#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Generate NBA-team-inspired tmux/terminal themes with WCAG-validated contrast."""
import colorsys, os, sys

# ---------- colour math ----------
def hex2rgb(h):
    h = h.lstrip('#')
    return tuple(int(h[i:i+2], 16) for i in (0, 2, 4))

def rgb2hex(rgb):
    return '#%02X%02X%02X' % tuple(max(0, min(255, int(round(c)))) for c in rgb)

def _lin(c):
    c = c / 255.0
    return c / 12.92 if c <= 0.04045 else ((c + 0.055) / 1.055) ** 2.4

def lum(h):
    r, g, b = hex2rgb(h)
    return 0.2126 * _lin(r) + 0.7152 * _lin(g) + 0.0722 * _lin(b)

def contrast(a, b):
    la, lb = lum(a), lum(b)
    hi, lo = max(la, lb), min(la, lb)
    return (hi + 0.05) / (lo + 0.05)

def mix(a, b, t):
    ra, rb = hex2rgb(a), hex2rgb(b)
    return rgb2hex([ra[i] + (rb[i] - ra[i]) * t for i in range(3)])

def set_light(h, l):
    r, g, b = [c / 255.0 for c in hex2rgb(h)]
    hh, _, s = colorsys.rgb_to_hls(r, g, b)
    return rgb2hex([c * 255 for c in colorsys.hls_to_rgb(hh, max(0.0, min(1.0, l)), s)])

def get_light(h):
    r, g, b = [c / 255.0 for c in hex2rgb(h)]
    return colorsys.rgb_to_hls(r, g, b)[1]

def desat(h, factor):
    r, g, b = [c / 255.0 for c in hex2rgb(h)]
    hh, l, s = colorsys.rgb_to_hls(r, g, b)
    return rgb2hex([c * 255 for c in colorsys.hls_to_rgb(hh, l, s * factor)])

def tune(fg, bg, target, lighten=True, lo=0.0, hi=1.0):
    """Push fg's lightness until contrast(fg,bg) >= target. Binary-search style."""
    if contrast(fg, bg) >= target:
        return fg
    best, bestc = fg, contrast(fg, bg)
    steps = 200
    for i in range(steps + 1):
        l = (i / steps) if lighten else (1 - i / steps)
        if l < lo or l > hi:
            continue
        cand = set_light(fg, l)
        c = contrast(cand, bg)
        if c > bestc:
            best, bestc = cand, c
        if c >= target:
            return cand
    return best

# ---------- team definitions ----------
# (key, display, primary, secondary, tagline)
TEAMS = [
    ("lakers",   "Lakers",    "#552583", "#FDB927", "Purple & Gold"),
    ("celtics",  "Celtics",   "#007A33", "#BA9653", "Parquet Green"),
    ("warriors", "Warriors",  "#1D428A", "#FFC72C", "Bay Blue & Gold"),
    ("heat",     "Heat",      "#98002E", "#F9A01B", "Miami Vice Red"),
    ("knicks",   "Knicks",    "#006BB6", "#F58426", "Garden Blue & Orange"),
    ("bucks",    "Bucks",     "#00471B", "#EEE1C6", "Forest & Cream"),
    ("suns",     "Suns",      "#29127A", "#E56020", "Valley Purple"),
    ("nuggets",  "Nuggets",   "#0E2240", "#FEC524", "Mile High Navy"),
]

AA, AAA, UI = 4.5, 7.0, 3.0

def build(key, display, P, S, tagline):
    t = {}
    # ---- backgrounds: dark, slightly team-tinted (never pure black -> less halation)
    bg      = mix(desat(P, 0.55), "#0E0E13", 0.86)     # colour_1  main bg
    bg_soft = mix(desat(P, 0.50), "#26262E", 0.80)     # colour_2  raised bg
    # ---- accent used as the active-tab background; keep it dark enough for light text
    # Prefer DARKENING the team primary so the real secondary stays vivid --
    # washing the secondary out to hit contrast would erase the team identity.
    accent = P
    if contrast(S, accent) < AA:
        for i in range(100):
            cand = set_light(P, get_light(P) * (1 - i / 100.0))
            if get_light(cand) < 0.10:
                break
            accent = cand
            if contrast(S, cand) >= AA:
                break
    if get_light(accent) > 0.42:
        accent = set_light(accent, 0.32)
    # ---- bright team accent (active tab text, messages, mode)
    hot = S if contrast(S, accent) >= AA else tune(S, accent, AA, lighten=True, lo=0.45)
    if contrast(hot, bg) < AA:                          # also used on plain bg
        hot = tune(hot, bg, AA, lighten=True, lo=0.45)
    # ---- dim foreground for inactive tabs: AAA against bg so it is never mud
    dim = tune("#9BA3AE", bg, AAA, lighten=True)
    fg  = tune("#E6EAF2", bg, AAA, lighten=True)
    # ---- status-left third segment + right-side segments
    green = tune("#1FAF5E", bg, AA, lighten=True)
    red   = "#B4152F"
    if contrast("#F2F4F8", red) < AA:
        red = tune(red, "#F2F4F8", AA, lighten=False)
    white = "#EEF1F6"
    dark  = bg
    border_on = tune(mix(S, P, 0.35), bg, UI, lighten=True)

    t["1"]  = bg
    t["2"]  = bg_soft
    t["3"]  = dim
    t["4"]  = border_on
    t["5"]  = hot
    t["6"]  = bg
    t["7"]  = fg
    t["8"]  = bg
    t["9"]  = hot           # status-left seg1 bg (fg = colour_18)
    t["10"] = tune("#FF74C3", bg, AA, lighten=True)
    t["11"] = green         # status-left seg3 bg (fg = colour_8 = bg)
    t["12"] = dim
    t["13"] = white
    t["14"] = dark
    t["15"] = bg_soft       # status-right seg1 bg (fg = colour_12)
    t["16"] = red           # status-right seg2 bg (fg = colour_13)
    t["17"] = white         # status-right seg3 bg (fg = colour_14)
    t["18"] = accent        # team primary; active tab bg (fg = colour_5)

    # colour_18 on colour_9 (status-left seg1) must read
    if contrast(t["18"], t["9"]) < AA:
        t["9"] = tune(t["9"], t["18"], AA, lighten=True, lo=0.55)
    # colour_8(bg) on colour_11(green)
    if contrast(t["8"], t["11"]) < AA:
        t["11"] = tune(t["11"], t["8"], AA, lighten=True, lo=0.45)

    # ---- terminal ANSI: keep hues semantically correct, tune lightness for contrast
    base = {
        0:  mix(bg, dim, 0.18),        8:  dim,
        1:  "#F0616F", 9:  "#FF8A94",
        2:  "#5FD38A", 10: "#84E5A8",
        3:  "#E7B95C", 11: "#F5D07F",
        4:  "#6EA8FF", 12: "#93C0FF",
        5:  "#C89BF0", 13: "#DCBAFF",
        6:  "#5FCFD8", 14: "#8FE3EA",
        7:  fg,        15: white,
    }
    term = {}
    for i, c in base.items():
        need = AA if i not in (0,) else UI
        term[i] = tune(c, bg, need, lighten=True) if i != 0 else c

    theme = {
        "key": key, "display": display, "tagline": tagline,
        "tmux": t, "term": term,
        "bg": bg, "fg": fg, "cursor": hot, "cursor_text": bg,
        "sel_bg": accent if contrast(fg, accent) >= AA else bg_soft,
        "sel_fg": fg,
        "primary": P, "secondary": S, "accent": accent, "hot": hot,
    }
    return theme

# ---------- validation ----------
# (label, fg-role, bg-role, threshold)
PAIRS = [
    ("inactive tab      colour_3  on colour_1",  "3",  "1",  AAA),
    ("active tab        colour_5  on colour_18", "5",  "18", AA),
    ("last window       colour_12 on colour_2",  "12", "2",  AA),
    ("status-left  s1   colour_18 on colour_9",  "18", "9",  AA),
    ("status-left  s2   colour_5  on colour_18", "5",  "18", AA),
    ("status-left  s3   colour_8  on colour_11", "8",  "11", AA),
    ("status-right s1   colour_12 on colour_15", "12", "15", AA),
    ("status-right s2   colour_13 on colour_16", "13", "16", AA),
    ("status-right s3   colour_14 on colour_17", "14", "17", AA),
    ("message           colour_1  on colour_5",  "1",  "5",  AA),
    ("pane border       colour_4  on colour_1",  "4",  "1",  UI),
    ("main text         colour_7  on colour_1",  "7",  "1",  AAA),
]

def validate(th, verbose=True):
    fails = []
    rows = []
    for label, f, b, need in PAIRS:
        c = contrast(th["tmux"][f], th["tmux"][b])
        ok = c >= need
        if not ok:
            fails.append((label, c, need))
        rows.append((label, c, need, ok))
    for i in range(16):
        c = contrast(th["term"][i], th["bg"])
        if i == 0:
            # ANSI black is a *background* colour: it must stay dark, but never be
            # invisible if a program prints it as foreground. Bound it instead.
            ok = 1.15 <= c <= 2.5
            rows.append(("ansi 0  vs bg (want 1.15-2.5)", c, 1.15, ok))
            if not ok:
                fails.append(("ansi 0 vs bg out of band", c, 1.15))
            c2 = contrast(th["term"][0], th["term"][15])
            ok2 = c2 >= AAA
            rows.append(("ansi 0            on ansi 15", c2, AAA, ok2))
            if not ok2:
                fails.append(("ansi 0 on ansi 15", c2, AAA))
            continue
        ok = c >= AA
        if not ok:
            fails.append(("ansi %d" % i, c, AA))
        rows.append(("ansi %-2d           on bg" % i, c, AA, ok))
    c = contrast(th["fg"], th["bg"])
    rows.append(("terminal fg       on bg", c, AAA, c >= AAA))
    if c < AAA:
        fails.append(("terminal fg", c, AAA))
    if verbose:
        print("\n=== %s (%s) ===" % (th["display"], th["tagline"]))
        for label, c, need, ok in rows:
            print("  %-38s %5.2f:1  (need %.1f) %s" % (label, c, need, "OK" if ok else "** FAIL **"))
    return fails

# ---------- emit ----------
TPL = u"""# {display} — {tagline}
# NBA-team tmux + terminal theme.  Pure `name="value"` assignments ONLY:
# this file is sourced by BOTH tmux (source-file) and zsh (source).
#
# /!\\ The composite vars below MUST live here, not in .tmux.conf.local.
#     tmux expands $vars while *parsing*, and source-file runs only after the
#     whole file is parsed — so a composite written inline would bake in the
#     inline palette and ignore this theme entirely.
#
# Generated and WCAG-validated by themes/check-contrast.py

tru_theme_key="{key}"
tru_theme_name="{display}"
tru_theme_desc="{tagline}"

# ---- gpakosz / oh-my-tmux palette -------------------------------------------
{tmuxlines}

# ---- composites (reference the palette above; order matters) -----------------
tmux_conf_theme_focused_pane_bg="$tmux_conf_theme_colour_2"
tmux_conf_theme_pane_border="$tmux_conf_theme_colour_2"
tmux_conf_theme_pane_active_border="$tmux_conf_theme_colour_4"
tmux_conf_theme_pane_indicator="$tmux_conf_theme_colour_4"
tmux_conf_theme_pane_active_indicator="$tmux_conf_theme_colour_4"
tmux_conf_theme_message_fg="$tmux_conf_theme_colour_1"
tmux_conf_theme_message_bg="$tmux_conf_theme_colour_5"
tmux_conf_theme_message_command_fg="$tmux_conf_theme_colour_5"
tmux_conf_theme_message_command_bg="$tmux_conf_theme_colour_1"
tmux_conf_theme_mode_fg="$tmux_conf_theme_colour_1"
tmux_conf_theme_mode_bg="$tmux_conf_theme_colour_5"
tmux_conf_theme_status_fg="$tmux_conf_theme_colour_3"
tmux_conf_theme_status_bg="$tmux_conf_theme_colour_1"
tmux_conf_theme_window_status_fg="$tmux_conf_theme_colour_3"
tmux_conf_theme_window_status_bg="$tmux_conf_theme_colour_1"
tmux_conf_theme_window_status_current_fg="$tmux_conf_theme_colour_5"
tmux_conf_theme_window_status_current_bg="$tmux_conf_theme_colour_18"
tmux_conf_theme_window_status_bell_fg="$tmux_conf_theme_colour_5"
tmux_conf_theme_window_status_last_fg="$tmux_conf_theme_colour_12"
tmux_conf_theme_window_status_last_bg="$tmux_conf_theme_colour_2"
tmux_conf_theme_status_left_fg="$tmux_conf_theme_colour_18,$tmux_conf_theme_colour_5,$tmux_conf_theme_colour_8"
tmux_conf_theme_status_left_bg="$tmux_conf_theme_colour_9,$tmux_conf_theme_colour_18,$tmux_conf_theme_colour_11"
tmux_conf_theme_status_right_fg="$tmux_conf_theme_colour_12,$tmux_conf_theme_colour_13,$tmux_conf_theme_colour_14"
tmux_conf_theme_status_right_bg="$tmux_conf_theme_colour_15,$tmux_conf_theme_colour_16,$tmux_conf_theme_colour_17"
tmux_conf_theme_clock_colour="$tmux_conf_theme_colour_4"

# ---- terminal ---------------------------------------------------------------
tru_term_bg="{bg}"
tru_term_fg="{fg}"
tru_term_cursor="{cursor}"
tru_term_cursor_text="{cursor_text}"
tru_term_sel_bg="{sel_bg}"
tru_term_sel_fg="{sel_fg}"
{termlines}
"""

COMMENTS = {
    "1": "main background", "2": "raised background", "3": "inactive tab text",
    "4": "pane border / clock", "5": "team accent (active tab text)",
    "6": "background", "7": "main foreground", "8": "background",
    "9": "status-left seg1 bg", "10": "pink accent", "11": "status-left seg3 bg",
    "12": "dim foreground", "13": "white", "14": "dark",
    "15": "status-right seg1 bg", "16": "status-right seg2 bg",
    "17": "status-right seg3 bg", "18": "TEAM PRIMARY (active tab bg)",
}

def emit(th):
    tl = "\n".join(
        '%-28s # %s' % ('tmux_conf_theme_colour_%d="%s"' % (i, th["tmux"][str(i)]), COMMENTS[str(i)])
        for i in range(1, 19))
    tm = "\n".join('tru_term_color%d="%s"' % (i, th["term"][i]) for i in range(16))
    return TPL.format(display=th["display"], tagline=th["tagline"], key=th["key"],
                      tmuxlines=tl, termlines=tm, bg=th["bg"], fg=th["fg"],
                      cursor=th["cursor"], cursor_text=th["cursor_text"],
                      sel_bg=th["sel_bg"], sel_fg=th["sel_fg"])

if __name__ == "__main__":
    outdir = sys.argv[1] if len(sys.argv) > 1 else None
    allfails = []
    themes = []
    for args in TEAMS:
        th = build(*args)
        themes.append(th)
        f = validate(th)
        if f:
            allfails.append((th["display"], f))
    print("\n" + "=" * 70)
    if allfails:
        print("FAILURES:")
        for name, fs in allfails:
            for label, c, need in fs:
                print("  %-12s %-30s %.2f < %.1f" % (name, label, c, need))
    else:
        print("All %d themes pass every contrast target." % len(themes))
    if outdir:
        os.makedirs(outdir, exist_ok=True)
        for th in themes:
            p = os.path.join(outdir, th["key"] + ".theme")
            with open(p, "w") as fh:
                fh.write(emit(th))
        print("wrote %d theme files to %s" % (len(themes), outdir))
