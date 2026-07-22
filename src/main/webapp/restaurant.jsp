<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.DAOImple.RestaurantDAOImple" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Restaurants — Flavora</title>

<script src="https://cdn.jsdelivr.net/npm/@studio-freight/lenis@1.0.42/dist/lenis.min.js"></script>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400&display=swap" rel="stylesheet">

<style>
/* ════════════════════════════════════════
   IMPOSSIBLE FOODS — DESIGN TOKENS
════════════════════════════════════════ */
:root {
  /* Colors */
  --color-velvet-wine:    #260212;
  --color-burgundy-stage: #4f0423;
  --color-impossible-red: #e10600;
  --color-blush-highlight:#ffc7c6;
  --color-butcher-black:  #000000;
  --color-bone-white:     #ffffff;

  /* Typography */
  --font-display: 'Bebas Neue', ui-sans-serif, system-ui, sans-serif;
  --font-body:    'Inter', ui-sans-serif, system-ui, sans-serif;

  /* Type scale */
  --text-caption:     10px;
  --text-body-sm:     14px;
  --text-body:        18px;
  --text-subheading:  24px;
  --text-heading-sm:  32px;
  --text-heading:     48px;
  --text-heading-lg:  103px;
  --text-display:     160px;

  /* Leading */
  --leading-display:    0.73;
  --leading-heading-lg: 0.75;
  --leading-heading:    0.90;
  --leading-body:       1.40;

  /* Tracking */
  --tracking-display:    0.06em;
  --tracking-heading-lg: 0.03em;
  --tracking-ui:         0.02em;
  --tracking-label:      0.15em;

  /* Spacing */
  --spacing-4:   4px;
  --spacing-8:   8px;
  --spacing-12:  12px;
  --spacing-16:  16px;
  --spacing-20:  20px;
  --spacing-24:  24px;
  --spacing-32:  32px;
  --spacing-40:  40px;
  --spacing-56:  56px;
  --spacing-64:  64px;
  --spacing-80:  80px;
  --spacing-100: 100px;
  --spacing-148: 148px;

  /* Radius */
  --radius-nav:           15px;
  --radius-cards:         12px;
  --radius-buttons:       15px;
  --radius-toggles:       15px;
  --radius-feature-cards: 38px;

  /* Layout */
  --page-max-width: 1280px;
  --nav-h: 64px;
}

/* ════════════════════════════════════════
   BASE RESET
════════════════════════════════════════ */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { overflow-x: hidden; scroll-behavior: auto; }
body {
  font-family: var(--font-body);
  background: var(--color-velvet-wine);
  color: var(--color-bone-white);
  overflow-x: hidden;
  overscroll-behavior: none;
}
img { display: block; max-width: 100%; }
a { text-decoration: none; color: inherit; }

/* ════════════════════════════════════════
   SCROLL PROGRESS BAR
════════════════════════════════════════ */
#spbar {
  position: fixed; top: 0; left: 0;
  height: 2px; width: 0%;
  background: var(--color-impossible-red);
  z-index: 9999; pointer-events: none;
}

/* ════════════════════════════════════════
   CUSTOM CURSOR
════════════════════════════════════════ */
.cur-dot {
  width: 7px; height: 7px;
  background: var(--color-impossible-red);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none; z-index: 9998;
  transform: translate(-50%,-50%);
  display: none;
}
.cur-ring {
  width: 34px; height: 34px;
  border: 1.5px solid rgba(225,6,0,.5);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none; z-index: 9997;
  transform: translate(-50%,-50%);
  transition: width .22s, height .22s, border-color .22s;
  display: none;
}
.cur-ring.big { width: 54px; height: 54px; border-color: rgba(225,6,0,.25); }

/* ════════════════════════════════════════
   NAV — solid #000 bar, impossible-red wordmark
════════════════════════════════════════ */
.nav {
  position: fixed; top: 0; left: 0; right: 0;
  z-index: 5000; height: var(--nav-h);
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 40px;
  background: var(--color-butcher-black);
  border-bottom: 1px solid rgba(255,255,255,.06);
}

/* wordmark */
.nav-logo {
  font-family: var(--font-display);
  font-size: 22px;
  letter-spacing: var(--tracking-label);
  color: var(--color-impossible-red);
  line-height: 1;
  text-transform: uppercase;
}
.nav-logo small {
  display: block;
  font-family: var(--font-body);
  font-size: 9px;
  font-weight: 400;
  color: rgba(255,199,198,.55);
  letter-spacing: 0.12em;
  text-transform: uppercase;
  margin-top: 2px;
}

/* nav links */
.nav-links { display: flex; align-items: center; gap: 4px; }

/* shared nav button */
.btnn {
  font-family: var(--font-body);
  font-size: var(--text-caption);
  font-weight: 500;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  color: rgba(255,255,255,.7);
  padding: 8px 16px;
  border-radius: var(--radius-buttons);
  border: 1.5px solid transparent;
  background: transparent;
  white-space: nowrap;
  cursor: pointer;
  transition: all .2s;
}
.btnn:hover { border-color: var(--color-impossible-red); color: var(--color-impossible-red); }
.btnn.primary {
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  border-color: var(--color-impossible-red);
}
.btnn.primary:hover { background: #c00400; border-color: #c00400; }

/* user dropdown */
.u-wrap { position: relative; display: inline-block; }
.u-wrap:hover .u-menu { display: block; }
.u-menu {
  display: none; position: absolute; top: calc(100% + 8px); right: 0;
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
  padding: 6px; list-style: none; min-width: 140px; z-index: 200;
}
.u-menu li a {
  display: block;
  font-family: var(--font-body); font-size: var(--text-caption); font-weight: 500;
  letter-spacing: 0.12em; text-transform: uppercase;
  padding: 10px 14px; border-radius: 8px;
  color: var(--color-bone-white);
  transition: background .16s, color .16s;
}
.u-menu li a:hover { background: var(--color-impossible-red); color: var(--color-bone-white); }

/* hamburger */
.ham { display: none; flex-direction: column; gap: 5px; cursor: pointer; padding: 8px; }
.ham span { display: block; width: 22px; height: 1.5px; background: var(--color-bone-white); transition: all .3s; }

/* mobile drawer */
.drawer {
  display: none; position: fixed;
  top: var(--nav-h); left: 0; right: 0;
  background: var(--color-butcher-black);
  padding: 16px 20px 24px;
  flex-direction: column; gap: 8px;
  border-bottom: 1px solid rgba(255,255,255,.07);
  z-index: 4999;
}
.drawer.open { display: flex; }
.drawer .btnn { width: 100%; text-align: center; border-color: rgba(255,255,255,.12); color: rgba(255,255,255,.7); }
.drawer .btnn.primary { background: var(--color-impossible-red); border-color: var(--color-impossible-red); color: #fff; }

/* ════════════════════════════════════════
   HERO — full-bleed display text at 160px
════════════════════════════════════════ */
.hero {
  min-height: 100vh;
  background: var(--color-velvet-wine);
  display: flex; flex-direction: column; justify-content: flex-end;
  position: relative; overflow: hidden;
  padding-top: var(--nav-h);
}

/* background ghost text watermark */
.hero-wm {
  position: absolute; inset: 0;
  display: flex; align-items: center; justify-content: center;
  font-family: var(--font-display);
  font-size: clamp(80px, 20vw, 280px);
  color: rgba(79,4,35,.45);
  letter-spacing: 0.03em;
  text-transform: uppercase;
  pointer-events: none;
  white-space: nowrap;
  user-select: none;
}

/* eyebrow */
.hero-eye {
  position: relative; z-index: 2;
  text-align: center;
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  font-weight: 500;
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  color: var(--color-blush-highlight);
  padding: 0 48px;
  opacity: 0; animation: riseUp .8s .2s cubic-bezier(.16,1,.3,1) forwards;
}

/* main display headline */
.hero-head {
  position: relative; z-index: 2;
  text-align: center;
  font-family: var(--font-display);
  font-size: clamp(72px, 12.5vw, var(--text-display));
  line-height: var(--leading-display);
  letter-spacing: var(--tracking-display);
  text-transform: uppercase;
  color: var(--color-impossible-red);
  padding: 12px 48px 0;
  opacity: 0; animation: riseUp .9s .38s cubic-bezier(.16,1,.3,1) forwards;
}
.hero-head .aside {
  display: block;
  font-size: clamp(48px, 7.5vw, 120px);
  color: var(--color-blush-highlight);
}

/* hero sub-row */
.hero-sub {
  position: relative; z-index: 2;
  display: flex; align-items: center; justify-content: space-between;
  padding: 32px 48px 48px;
  opacity: 0; animation: riseUp .8s .62s cubic-bezier(.16,1,.3,1) forwards;
}
.hero-desc {
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  line-height: 1.75;
  color: rgba(255,199,198,.65);
  max-width: 260px;
}
.hero-cta {
  display: inline-flex; align-items: center; gap: 8px;
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  font-weight: 500;
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  padding: 10px 18px;
  border-radius: var(--radius-buttons);
  transition: background .22s, gap .2s;
}
.hero-cta:hover { background: #c00400; gap: 14px; }
.hero-cta svg { stroke: currentColor; fill: none; stroke-width: 2.4; transition: transform .2s; }
.hero-cta:hover svg { transform: translateX(4px); }

.hero-stats {
  position: relative; z-index: 2;
  display: flex; align-items: center; justify-content: center; gap: 0;
  border-top: 1px solid rgba(255,255,255,.06);
}
.hstat {
  flex: 1; text-align: center; padding: 20px 24px;
  border-right: 1px solid rgba(255,255,255,.06);
}
.hstat:last-child { border-right: none; }
.hstat-n {
  font-family: var(--font-display);
  font-size: clamp(28px, 4vw, 52px);
  color: var(--color-impossible-red);
  letter-spacing: 0.04em;
  line-height: 1;
}
.hstat-l {
  font-family: var(--font-body);
  font-size: var(--text-caption);
  font-weight: 400;
  letter-spacing: 0.2em;
  text-transform: uppercase;
  color: rgba(255,199,198,.5);
  margin-top: 4px;
}

@keyframes riseUp { to { opacity: 1; transform: translateY(0); } }
.hero-eye, .hero-head { transform: translateY(48px); }
.hero-sub { transform: translateY(32px); }

/* ════════════════════════════════════════
   TICKER
════════════════════════════════════════ */
.tk {
  overflow: hidden;
  background: var(--color-butcher-black);
  border-top: 1px solid rgba(255,255,255,.06);
  border-bottom: 1px solid rgba(255,255,255,.06);
  padding: 12px 0; user-select: none;
}
.tk.red { background: var(--color-impossible-red); }
.tk-t { display: flex; white-space: nowrap; animation: tkroll 28s linear infinite; }
.tk:hover .tk-t { animation-play-state: paused; }
.tk.rev .tk-t { animation-direction: reverse; }
.tk-t s {
  font-family: var(--font-display);
  font-size: 13px; letter-spacing: 0.18em;
  text-transform: uppercase;
  color: rgba(255,255,255,.7);
  text-decoration: none; padding: 0 28px; flex-shrink: 0;
}
.tk.red .tk-t s { color: var(--color-bone-white); }
.tk-t .td { padding: 0 2px; color: var(--color-impossible-red); font-size: 14px; }
.tk.red .tk-t .td { color: rgba(26,0,8,.5); }
@keyframes tkroll { from { transform: translateX(0); } to { transform: translateX(-50%); } }

/* ════════════════════════════════════════
   SECTION OPENER — bracket accent pattern
════════════════════════════════════════ */
.sec-opener {
  background: var(--color-velvet-wine);
  text-align: center;
  padding: var(--spacing-64) 48px var(--spacing-40);
}
.sec-bracket {
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  font-weight: 500;
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  color: var(--color-impossible-red);
  margin-bottom: 8px;
}
.sec-display {
  font-family: var(--font-display);
  font-size: clamp(56px, 9vw, var(--text-heading-lg));
  line-height: var(--leading-heading-lg);
  letter-spacing: var(--tracking-heading-lg);
  text-transform: uppercase;
  color: var(--color-impossible-red);
}
.sec-display .aside {
  display: block;
  color: var(--color-blush-highlight);
  font-size: clamp(36px, 5.5vw, 64px);
}

/* search — dark-surface pill */
.srch-wrap { padding: 0 48px var(--spacing-32); background: var(--color-velvet-wine); }
.srch {
  max-width: 540px; margin: 0 auto;
  display: flex; align-items: center;
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: 40px; padding: 5px 5px 5px 20px;
  transition: border-color .25s;
}
.srch:focus-within { border-color: var(--color-impossible-red); }
.srch input {
  flex: 1; border: none; background: transparent;
  font-family: var(--font-body); font-size: 13px;
  color: var(--color-bone-white); outline: none;
}
.srch input::placeholder { color: rgba(255,199,198,.4); font-style: italic; }
.sb {
  background: var(--color-impossible-red); color: var(--color-bone-white);
  border: none; border-radius: 30px;
  padding: 10px 22px;
  font-family: var(--font-body); font-size: var(--text-caption); font-weight: 500;
  letter-spacing: 0.14em; text-transform: uppercase;
  cursor: pointer; transition: background .22s;
}
.sb:hover { background: #c00400; }

/* ════════════════════════════════════════
   FILTER PILL TOGGLES
════════════════════════════════════════ */
.pills {
  display: flex; justify-content: center; gap: 8px; flex-wrap: wrap;
  padding: 0 48px var(--spacing-40);
  background: var(--color-velvet-wine);
}
.pill {
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  font-weight: 500;
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  padding: 10px 18px;
  border-radius: var(--radius-toggles);
  border: 1px solid rgba(255,199,198,.3);
  background: transparent;
  color: var(--color-blush-highlight);
  cursor: pointer; transition: all .2s;
}
.pill:hover { border-color: var(--color-impossible-red); color: var(--color-impossible-red); }
.pill.on {
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  border-color: var(--color-impossible-red);
}

/* ════════════════════════════════════════
   2×3 PAGE CAROUSEL
════════════════════════════════════════ */
.car-sec {
  background: var(--color-velvet-wine);
  padding: 0 0 var(--spacing-64);
}

.car-hdr {
  display: flex; align-items: center; justify-content: space-between;
  padding: 0 48px var(--spacing-24);
}
.car-hdr-left { display: flex; align-items: baseline; gap: 14px; }
.car-label {
  font-family: var(--font-body);
  font-size: var(--text-caption); font-weight: 500;
  letter-spacing: 0.2em; text-transform: uppercase;
  color: var(--color-blush-highlight);
}
.car-count {
  font-family: var(--font-display);
  font-size: 14px; letter-spacing: 0.1em;
  color: rgba(255,199,198,.4); text-transform: uppercase;
}

/* arrow buttons */
.car-arrows { display: flex; gap: 10px; }
.arrow-btn {
  width: 44px; height: 44px; border-radius: 50%;
  border: 1px solid rgba(255,255,255,.12);
  background: var(--color-burgundy-stage);
  display: flex; align-items: center; justify-content: center;
  cursor: pointer; transition: all .22s; color: var(--color-bone-white);
}
.arrow-btn:hover {
  background: var(--color-impossible-red);
  border-color: var(--color-impossible-red);
}
.arrow-btn svg { width: 16px; height: 16px; stroke: currentColor; stroke-width: 2.3; fill: none; }

.car-outer { overflow: hidden; position: relative; }
.car-track { display: flex; will-change: transform; transition: transform 0s; }
.car-page {
  flex: 0 0 100%; width: 100%;
  padding: 0 48px;
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  grid-template-rows: auto auto;
  gap: 16px;
}

@media (max-width: 700px) {
  .car-page { grid-template-columns: 1fr; padding: 0 20px; }
  .car-hdr { padding-left: 20px; padding-right: 20px; }
}
@media (min-width: 701px) and (max-width: 1000px) {
  .car-page { grid-template-columns: repeat(2, 1fr); padding: 0 28px; }
}

/* ═══ RESTAURANT CARD ═══ */
.ccard {
  background: var(--color-burgundy-stage);
  border-radius: var(--radius-cards);
  border: 1px solid var(--color-butcher-black);
  overflow: hidden;
  position: relative; cursor: pointer;
  /* AOS */
  opacity: 0; transform: translateY(40px);
  transition:
    opacity .75s cubic-bezier(.16,1,.3,1),
    transform .85s cubic-bezier(.16,1,.3,1),
    border-color .22s;
}
.ccard.show { opacity: 1; transform: translateY(0); }
/* no shadows — flat, color contrast only */
.ccard:hover { border-color: var(--color-impossible-red); transform: translateY(-4px) !important; }

/* image area */
.ci { position: relative; height: 188px; overflow: hidden; }
.ci img { width: 100%; height: 100%; object-fit: cover; transition: transform .55s cubic-bezier(.25,.8,.25,1); }
.ccard:hover .ci img { transform: scale(1.05); }
.ci::after {
  content: ''; position: absolute; inset: 0;
  background: linear-gradient(to top, rgba(38,2,18,.7) 0%, transparent 55%);
  pointer-events: none;
}

/* tag + rating */
.ctag {
  position: absolute; top: 12px; left: 12px;
  background: var(--color-butcher-black);
  color: var(--color-bone-white);
  font-family: var(--font-body); font-size: 9px; font-weight: 600;
  letter-spacing: 0.18em; text-transform: uppercase;
  padding: 4px 10px; border-radius: var(--radius-buttons);
}
.crat {
  position: absolute; top: 12px; right: 12px;
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  font-family: var(--font-body); font-size: 11px; font-weight: 700;
  padding: 4px 10px; border-radius: var(--radius-buttons);
}
.ctim {
  position: absolute; bottom: 10px; left: 12px; z-index: 1;
  font-family: var(--font-body); font-size: 10px; font-weight: 400;
  letter-spacing: 0.06em;
  color: rgba(255,199,198,.85);
  display: flex; align-items: center; gap: 4px;
}

/* card body */
.cb { padding: 16px 18px 18px; }
.cn {
  font-family: var(--font-display);
  font-size: 28px; letter-spacing: var(--tracking-ui);
  color: var(--color-blush-highlight);
  text-transform: uppercase;
  line-height: .92; margin-bottom: 8px;
}
.ca {
  font-family: var(--font-body); font-size: 12px;
  color: rgba(255,199,198,.45); line-height: 1.5;
  margin-bottom: 12px;
  display: flex; align-items: flex-start; gap: 5px;
}
.ca svg { flex-shrink: 0; margin-top: 1px; opacity: .4; }
.cst {
  display: inline-flex; align-items: center; gap: 5px;
  font-family: var(--font-body); font-size: 9px; font-weight: 500;
  letter-spacing: 0.14em; text-transform: uppercase;
  color: rgba(255,199,198,.45);
  margin-bottom: 14px;
}
.sdot {
  width: 5px; height: 5px; border-radius: 50%; background: #4caf50;
  animation: sdp 2s ease-in-out infinite;
}
@keyframes sdp { 0%,100%{ opacity:1; transform:scale(1); } 50%{ opacity:.4; transform:scale(.8); } }

/* CTA pair — filled + ghost */
.cbtn-row { display: flex; gap: 8px; }
.cbtn {
  flex: 1;
  display: flex; align-items: center; justify-content: center; gap: 6px;
  font-family: var(--font-body); font-size: 10px; font-weight: 500;
  letter-spacing: 0.14em; text-transform: uppercase;
  padding: 10px 14px; border-radius: var(--radius-buttons);
  transition: all .22s; text-decoration: none;
}
.cbtn.filled {
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  border: 1px solid var(--color-impossible-red);
}
.cbtn.filled:hover { background: #c00400; border-color: #c00400; }
.cbtn.ghost {
  background: transparent;
  color: var(--color-bone-white);
  border: 1px solid var(--color-bone-white);
}
.cbtn.ghost:hover { border-color: var(--color-blush-highlight); color: var(--color-blush-highlight); }
.cbtn svg { stroke: currentColor; fill: none; stroke-width: 2.4; transition: transform .2s; }
.cbtn:hover svg { transform: translateX(3px); }

/* dots */
.car-dots { display: flex; justify-content: center; gap: 8px; margin-top: 28px; }
.dp {
  width: 6px; height: 6px; border-radius: 50%;
  background: rgba(255,199,198,.25);
  cursor: pointer; transition: all .3s;
}
.dp.on { background: var(--color-impossible-red); width: 22px; border-radius: 3px; }

/* empty state */
.empty { text-align: center; padding: 80px 40px; width: 100%; }
.empty-i { font-size: 52px; margin-bottom: 14px; }
.empty h3 {
  font-family: var(--font-display); font-size: 48px;
  letter-spacing: 0.04em; color: var(--color-impossible-red);
  text-transform: uppercase; margin-bottom: 8px;
}
.empty p { font-family: var(--font-body); font-size: 13px; color: rgba(255,199,198,.45); }

/* ════════════════════════════════════════
   DARK FEATURE BAND
════════════════════════════════════════ */
.df {
  background: var(--color-burgundy-stage);
  border-top: 1px solid var(--color-butcher-black);
  border-bottom: 1px solid var(--color-butcher-black);
  display: grid; grid-template-columns: 1fr 1fr;
  gap: 60px; align-items: center;
  padding: 80px 48px;
}
.dfe {
  font-family: var(--font-body); font-size: var(--text-caption); font-weight: 500;
  letter-spacing: 0.24em; text-transform: uppercase;
  color: var(--color-blush-highlight); margin-bottom: 16px;
}
.dfb {
  font-family: var(--font-display);
  font-size: clamp(48px, 6.5vw, 88px);
  line-height: var(--leading-heading);
  letter-spacing: 0.03em; text-transform: uppercase;
  color: var(--color-impossible-red); margin-bottom: 16px;
}
.dfs {
  font-family: var(--font-body); font-size: 14px;
  font-style: italic; color: var(--color-blush-highlight);
  margin-bottom: 20px;
}
.dfd {
  font-family: var(--font-body); font-size: 14px; line-height: 1.85;
  color: rgba(255,199,198,.55); max-width: 340px;
}
.df-ico {
  text-align: center; font-size: clamp(80px, 12vw, 156px);
  animation: floatY 5s ease-in-out infinite;
  will-change: transform;
}
@keyframes floatY { 0%,100%{ transform: translateY(0); } 50%{ transform: translateY(-18px); } }

/* ════════════════════════════════════════
   MINI CARDS BAND
════════════════════════════════════════ */
.ms {
  background: var(--color-velvet-wine);
  padding: 80px 48px; text-align: center; position: relative; overflow: hidden;
}
.ms-wm {
  position: absolute; inset: 0;
  display: flex; align-items: center; justify-content: center;
  font-family: var(--font-display);
  font-size: clamp(80px, 16vw, 220px);
  color: rgba(79,4,35,.3); letter-spacing: 0.06em;
  pointer-events: none; white-space: nowrap; overflow: hidden;
  text-transform: uppercase;
}
.ms-eye {
  position: relative; z-index: 1;
  font-family: var(--font-body); font-size: var(--text-caption); font-weight: 500;
  letter-spacing: 0.24em; text-transform: uppercase;
  color: var(--color-impossible-red); margin-bottom: 10px;
}
.ms-head {
  position: relative; z-index: 1;
  font-family: var(--font-display);
  font-size: clamp(48px, 7vw, 96px);
  line-height: var(--leading-heading);
  letter-spacing: 0.03em; text-transform: uppercase;
  color: var(--color-bone-white); margin-bottom: 8px;
}
.ms-sub {
  position: relative; z-index: 1;
  font-family: var(--font-body); font-size: 14px; font-style: italic;
  color: var(--color-blush-highlight);
}
.mg {
  display: flex; gap: 12px; justify-content: center; flex-wrap: wrap;
  position: relative; z-index: 1; margin-top: 36px;
}
.mc {
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
  padding: 24px 20px; width: 180px; text-align: center;
  transition: border-color .22s, transform .3s cubic-bezier(.16,1,.3,1);
}
.mc:hover { border-color: var(--color-impossible-red); transform: translateY(-6px); }
.mc-i { font-size: 30px; margin-bottom: 10px; }
.mc-t {
  font-family: var(--font-display); font-size: 22px;
  letter-spacing: 0.04em; text-transform: uppercase;
  color: var(--color-bone-white); margin-bottom: 4px;
}
.mc-s {
  font-family: var(--font-body); font-size: var(--text-caption); font-weight: 400;
  letter-spacing: 0.12em; text-transform: uppercase;
  color: rgba(255,199,198,.45);
}

/* ════════════════════════════════════════
   FOOTER
════════════════════════════════════════ */
.ft {
  background: var(--color-butcher-black);
  border-top: 1px solid rgba(255,255,255,.06);
  padding: 48px 48px 32px; position: relative; overflow: hidden;
}
.ft-bg {
  position: absolute; bottom: -12px; left: 0; right: 0;
  text-align: center;
  font-family: var(--font-display);
  font-size: clamp(60px, 14vw, 180px);
  color: rgba(255,255,255,.025); letter-spacing: 0.06em;
  pointer-events: none; text-transform: uppercase;
}
.ft-in {
  max-width: var(--page-max-width); margin: 0 auto;
  display: flex; justify-content: space-between; align-items: flex-end;
  flex-wrap: wrap; gap: 24px; position: relative; z-index: 1;
}
.ft-brand {
  font-family: var(--font-display);
  font-size: 38px; letter-spacing: 0.08em;
  color: var(--color-impossible-red); text-transform: uppercase; line-height: 1;
}
.ft-brand small {
  display: block;
  font-family: var(--font-body); font-size: 11px; font-weight: 400;
  color: rgba(255,199,198,.45); letter-spacing: 0.08em;
  text-transform: uppercase; margin-top: 4px;
}
.ft-r { text-align: right; }
.ft-copy {
  font-family: var(--font-body); font-size: var(--text-caption);
  letter-spacing: 0.1em; text-transform: uppercase;
  color: rgba(255,255,255,.25); margin-bottom: 14px;
}
.ft-top {
  display: inline-flex; align-items: center; gap: 7px;
  font-family: var(--font-body); font-size: var(--text-caption); font-weight: 500;
  letter-spacing: 0.16em; text-transform: uppercase;
  color: var(--color-blush-highlight);
  border: 1px solid rgba(255,199,198,.25);
  padding: 9px 20px; border-radius: var(--radius-buttons);
  transition: all .24s;
}
.ft-top:hover {
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  border-color: var(--color-impossible-red);
}

/* ════════════════════════════════════════
   AOS
════════════════════════════════════════ */
.af { opacity: 0; transform: translateY(32px); transition: opacity .85s cubic-bezier(.16,1,.3,1), transform .95s cubic-bezier(.16,1,.3,1); }
.al { opacity: 0; transform: translateX(-44px); transition: opacity .9s cubic-bezier(.16,1,.3,1), transform 1.05s cubic-bezier(.16,1,.3,1); }
.ar { opacity: 0; transform: translateX(44px); transition: opacity .9s cubic-bezier(.16,1,.3,1), transform 1.05s cubic-bezier(.16,1,.3,1); }
.af.show, .al.show, .ar.show { opacity: 1; transform: translate(0); }
.d1{transition-delay:.06s} .d2{transition-delay:.13s} .d3{transition-delay:.20s} .d4{transition-delay:.28s}

/* ════════════════════════════════════════
   RESPONSIVE
════════════════════════════════════════ */
@media (max-width: 960px) {
  .df { grid-template-columns: 1fr; gap: 28px; }
  .hero-sub { flex-direction: column; gap: 16px; text-align: center; }
  .hero-desc { max-width: 100%; }
  .hstat-n { font-size: 28px; }
  .nav { padding: 0 20px; }
  .nav-links { display: none; }
  .ham { display: flex; }
  .ms,.ft { padding-left: 24px; padding-right: 24px; }
  .srch-wrap { padding-left: 20px; padding-right: 20px; }
  .sec-opener { padding-left: 24px; padding-right: 24px; }
  .pills { padding-left: 20px; padding-right: 20px; }
  .df { padding: 56px 24px; }
}
@media (max-width: 600px) {
  .hero-head { font-size: 64px; padding: 8px 20px 0; }
  .hero-eye { padding: 0 20px; }
  .hero-sub { padding: 20px 20px 36px; }
  .hstat { padding: 14px 12px; }
  .hero-stats { flex-wrap: wrap; }
  .mg { gap: 10px; }
  .mc { width: 148px; padding: 18px 14px; }
}
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after { animation: none !important; transition-duration: .01ms !important; }
}
</style>
</head>
<body>

<div id="spbar"></div>
<div class="cur-dot" id="cdot"></div>
<div class="cur-ring" id="cring"></div>

<!-- ══════════════════════════════════════
     NAV — solid black bar, red wordmark
══════════════════════════════════════ -->
<nav class="nav" id="mainNav">
  <a href="restaurantServlet" class="nav-logo">
    FLAVORA<small>fine food delivery</small>
  </a>

  <div class="nav-links" id="navDsk">
    <a href="callOrderHistoryServlet" class="btnn">Order History</a>
    <a href="cart.jsp"                class="btnn">Cart</a>
    <%User user=(User)session.getAttribute("user");%>
    <%if(user==null){%>
      <a href="register.html" class="btnn">Sign Up</a>
      <a href="login.jsp"     class="btnn primary">Login</a>
    <%}%>
    <a href="admin/dashBoard.jsp" class="btnn primary">Admin Dashboard</a>
    <div class="u-wrap">
      <div class="btnn primary" style="cursor:pointer;">
        👤 <%=user!=null?user.getUserName():"User"%>
      </div>
      <ul class="u-menu">
        <%if(user != null){ %>
        <li><a href="<%=request.getContextPath()%>/callLogoutServlet">Logout</a></li>
        <li><a href="<%=request.getContextPath()%>/callProfileServlet">Profile</a></li>
        <%} %>
      </ul>
    </div>
  </div>

  <div class="ham" id="hamBtn" onclick="toggleDrawer()">
    <span></span><span></span><span></span>
  </div>
</nav>

<div class="drawer" id="navDrawer">
  <a href="callOrderHistoryServlet" class="btnn">Order History</a>
  <a href="cart.jsp"                class="btnn">Cart</a>
  <%if(user==null){%>
    <a href="register.html" class="btnn">Sign Up</a>
    <a href="login.jsp"     class="btnn primary">Login</a>
  <%}%>
  <a href="admin/dashBoard.jsp" class="btnn primary">Admin Dashboard</a>
  <a href="<%=request.getContextPath()%>/callLogoutServlet" class="btnn">Logout</a>
</div>

<!-- ══════════════════════════════════════
     HERO — 160px display declaration
══════════════════════════════════════ -->
<section class="hero" id="hero">
  <div class="hero-wm" aria-hidden="true">FLAVORA</div>

  <p class="hero-eye">◂ Order tonight ▸</p>

  <h1 class="hero-head">
    EAT WELL
    <span class="aside">(DELIVERED FAST)</span>
  </h1>

  <div class="hero-sub">
    <p class="hero-desc">
      More than delivery — a curated experience bringing the city's
      finest kitchens straight to your door.
    </p>
    <a href="#restaurants" class="hero-cta">
      Browse restaurants
      <svg width="14" height="14" viewBox="0 0 24 24">
        <path d="M5 12h14M12 5l7 7-7 7"/>
      </svg>
    </a>
    <p style="font-family:var(--font-body);font-size:11px;font-style:italic;color:rgba(255,199,198,.4);letter-spacing:.04em;">
      #TasteTheCity
    </p>
  </div>

  <div class="hero-stats">
    <div class="hstat"><div class="hstat-n">120+</div><div class="hstat-l">Restaurants</div></div>
    <div class="hstat"><div class="hstat-n">30 min</div><div class="hstat-l">Avg Delivery</div></div>
    <div class="hstat"><div class="hstat-n">4.8 ★</div><div class="hstat-l">Avg Rating</div></div>
    <div class="hstat"><div class="hstat-n">50k+</div><div class="hstat-l">Happy Customers</div></div>
  </div>
</section>

<!-- ticker 1 -->
<div class="tk"><div class="tk-t" id="tk1"></div></div>

<!-- ══════════════════════════════════════
     SECTION OPENER — bracket + display
══════════════════════════════════════ -->
<section class="sec-opener" id="restaurants">
  <p class="sec-bracket af">◂ Browse &amp; discover ▸</p>
  <h2 class="sec-display af d1">
    OUR RESTAURANTS
    <span class="aside">(HANDPICKED KITCHENS)</span>
  </h2>
</section>

<!-- search -->
<div class="srch-wrap af d2">
  <div class="srch">
    <input type="text" id="searchInput" placeholder="Search cuisine or restaurant…" oninput="applyFilters()">
    <button class="sb">Search</button>
  </div>
</div>

<!-- filter pill toggles -->
<div class="pills af d3">
  <button class="pill on"  onclick="setFilter(this,'')">All</button>
  <button class="pill"     onclick="setFilter(this,'indian')">Indian</button>
  <button class="pill"     onclick="setFilter(this,'chinese')">Chinese</button>
  <button class="pill"     onclick="setFilter(this,'italian')">Italian</button>
  <button class="pill"     onclick="setFilter(this,'fast food')">Fast Food</button>
  <button class="pill"     onclick="setFilter(this,'biryani')">Biryani</button>
  <button class="pill"     onclick="setFilter(this,'pizza')">Pizza</button>
</div>

<!-- ══════════════════════════════════════
     2×3 PAGE CAROUSEL
══════════════════════════════════════ -->
<section class="car-sec" id="carSec">
  <div class="car-hdr af">
    <div class="car-hdr-left">
      <p class="car-label">Your restaurants</p>
      <span class="car-count" id="carCount"></span>
    </div>
    <div class="car-arrows">
      <button class="arrow-btn" id="carPrev" aria-label="Previous">
        <svg viewBox="0 0 24 24"><polyline points="15 18 9 12 15 6"/></svg>
      </button>
      <button class="arrow-btn" id="carNext" aria-label="Next">
        <svg viewBox="0 0 24 24"><polyline points="9 6 15 12 9 18"/></svg>
      </button>
    </div>
  </div>

  <div class="car-outer" id="carOuter">
    <div class="car-track" id="carTrack"></div>
  </div>

  <div class="car-dots" id="carDots"></div>
</section>

<!-- Hidden card pool — JS paginates into 2×3 pages -->
<div id="cardPool" style="display:none">
<%
List<Restaurant> restaurantList=(List<Restaurant>)request.getAttribute("restaurantList");
if(restaurantList!=null && !restaurantList.isEmpty()){
  for(Restaurant r:restaurantList){
%>
<div class="ccard"
     data-cuisine="<%=r.getCuisineType()!=null?r.getCuisineType().toLowerCase():""%>"
     data-name="<%=r.getName()!=null?r.getName().toLowerCase():""%>">
  <div class="ci">
    <img alt="<%=r.getName()%>" src="assets/<%=r.getImages()%>" loading="lazy">
    <div class="ctag"><%=r.getCuisineType()%></div>
    <div class="crat">⭐ <%=r.getRating()%></div>
    <div class="ctim">
      <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.3">
        <circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/>
      </svg>
      <%=r.getDeliveryTime()%> mins
    </div>
  </div>
  <div class="cb">
    <h2 class="cn"><%=r.getName()%></h2>
    <p class="ca">
      <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
        <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z"/>
        <circle cx="12" cy="10" r="3"/>
      </svg>
      <%=r.getAddress()%>
    </p>
    <div class="cst">
      <span class="sdot"></span>
      <span><%=r.getIsActive()==1?"Available":"Not Available"%></span>
    </div>
    <div class="cbtn-row">
      <a href="callMenuServlet?restaurantId=<%=r.getRestaurantId()%>" class="cbtn filled">
        <span>View Menu</span>
        <svg width="13" height="13" viewBox="0 0 24 24"><path d="M5 12h14M12 5l7 7-7 7"/></svg>
      </a>
      <a href="callMenuServlet?restaurantId=<%=r.getRestaurantId()%>" class="cbtn ghost">
        <svg width="13" height="13" viewBox="0 0 24 24">
          <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0118 0z"/>
          <circle cx="12" cy="10" r="3"/>
        </svg>
        <span>Find It</span>
      </a>
    </div>
  </div>
</div>
<%}}else{%>
<div class="empty" style="display:block">
  <div class="empty-i">🍽️</div>
  <h3>No Restaurants Yet</h3>
  <p>Great things are cooking. Check back soon.</p>
</div>
<%}%>
</div>

<!-- ticker 2 -->
<div class="tk red rev"><div class="tk-t" id="tk2"></div></div>

<!-- ══════════════════════════════════════
     DARK FEATURE — why Flavora
══════════════════════════════════════ -->
<section class="df" id="why">
  <div class="al">
    <p class="dfe">◂ Why Flavora ▸</p>
    <h2 class="dfb">CRAFTED<br>WITH CARE</h2>
    <p class="dfs"><em>every meal, a moment of joy</em></p>
    <p class="dfd">We partner only with kitchens that treat ingredients with respect — fresh produce sourced daily, recipes refined over generations, delivered to the people who matter most. No shortcuts. Just flavour.</p>
  </div>
  <div class="ar">
    <div class="df-ico">🥘</div>
  </div>
</section>

<!-- ══════════════════════════════════════
     MINI CARDS
══════════════════════════════════════ -->
<section class="ms">
  <div class="ms-wm" aria-hidden="true">FLAVORA</div>
  <p class="ms-eye af">◂ Always nearby ▸</p>
  <h2 class="ms-head af d1">ORDER FROM<br>ANYWHERE</h2>
  <p class="ms-sub af d2"><em>the city's best food, one tap away</em></p>
  <div class="mg af d3">
    <div class="mc"><div class="mc-i">🛵</div><div class="mc-t">Fast</div><div class="mc-s">Delivery</div></div>
    <div class="mc"><div class="mc-i">🌿</div><div class="mc-t">Fresh</div><div class="mc-s">Ingredients</div></div>
    <div class="mc"><div class="mc-i">⭐</div><div class="mc-t">Rated</div><div class="mc-s">Kitchens</div></div>
    <div class="mc"><div class="mc-i">🔒</div><div class="mc-t">Secure</div><div class="mc-s">Payments</div></div>
  </div>
</section>

<!-- ══════════════════════════════════════
     FOOTER
══════════════════════════════════════ -->
<footer class="ft">
  <div class="ft-bg" aria-hidden="true">FLAVORA</div>
  <div class="ft-in">
    <div class="ft-brand">FLAVORA<small>fine food delivery</small></div>
    <div class="ft-r">
      <p class="ft-copy">© 2026 Flavora. All rights reserved.</p>
      <a href="#hero" class="ft-top">Back to top ↑</a>
    </div>
  </div>
</footer>

<!-- ══════════════════════════════════════
     SCRIPTS — all logic preserved
══════════════════════════════════════ -->
<script>
/* ═══════════════════════════════
   1. LENIS SMOOTH SCROLL
═══════════════════════════════ */
const lenis = new Lenis({
  duration: 1.3,
  easing: t => Math.min(1, 1.001 - Math.pow(2, -10 * t)),
  direction: 'vertical',
  gestureDirection: 'vertical',
  smooth: true,
  smoothTouch: false,
  touchMultiplier: 2,
});
function lenisRAF(time){ lenis.raf(time); requestAnimationFrame(lenisRAF); }
requestAnimationFrame(lenisRAF);

/* ═══════════════════════════════
   2. SCROLL PROGRESS BAR
═══════════════════════════════ */
const spbar = document.getElementById('spbar');
lenis.on('scroll', ({ progress }) => {
  spbar.style.width = (progress * 100) + '%';
});

/* ═══════════════════════════════
   3. MOBILE DRAWER
═══════════════════════════════ */
const drawer = document.getElementById('navDrawer');
function toggleDrawer(){ drawer.classList.toggle('open'); }

/* ═══════════════════════════════
   4. CUSTOM CURSOR — DESKTOP ONLY
═══════════════════════════════ */
const isTouch = window.matchMedia('(pointer:coarse)').matches;
const cdot    = document.getElementById('cdot');
const cring   = document.getElementById('cring');

if(!isTouch){
  cdot.style.display  = 'block';
  cring.style.display = 'block';
  let mx=0, my=0, rx=0, ry=0;
  document.addEventListener('mousemove', e=>{ mx=e.clientX; my=e.clientY; });
  (function raf(){
    rx += (mx-rx)*.13; ry += (my-ry)*.13;
    cdot.style.left  = mx+'px'; cdot.style.top  = my+'px';
    cring.style.left = rx+'px'; cring.style.top = ry+'px';
    requestAnimationFrame(raf);
  })();
  document.querySelectorAll('a,button,.ccard,.pill,.arrow-btn,.mc').forEach(el=>{
    el.addEventListener('mouseenter', ()=> cring.classList.add('big'));
    el.addEventListener('mouseleave', ()=> cring.classList.remove('big'));
  });
}

/* ═══════════════════════════════
   5. TICKERS
═══════════════════════════════ */
function buildTicker(id, words){
  const t = document.getElementById(id);
  if(!t) return;
  const all = [...words, ...words];
  all.forEach((w,i)=>{
    const s = document.createElement('s'); s.textContent = w; t.appendChild(s);
    if(i < all.length-1){
      const d = document.createElement('span'); d.className='td'; d.textContent=' ✦ '; t.appendChild(d);
    }
  });
}
buildTicker('tk1',['Fresh Delivery','Top Restaurants','Fast & Reliable','Order Now','Premium Kitchens','Great Taste','Fresh Delivery','Top Restaurants','Fast & Reliable','Order Now']);
buildTicker('tk2',["City's Finest","Rated 4.8 Stars","30 Min Delivery","50k+ Orders","Eat Well","Flavora","City's Finest","Rated 4.8 Stars","30 Min Delivery","50k+ Orders"]);

/* ═══════════════════════════════
   6. AOS — scroll reveal
═══════════════════════════════ */
const aosEls = document.querySelectorAll('.af,.al,.ar,.ccard');
const aio = new IntersectionObserver(entries=>{
  entries.forEach(e=>{
    if(e.isIntersecting){ e.target.classList.add('show'); aio.unobserve(e.target); }
  });
},{ threshold:0.1, rootMargin:'0px 0px -44px 0px' });

aosEls.forEach((el,i)=>{
  const r = el.getBoundingClientRect();
  if(r.top < window.innerHeight-60){ setTimeout(()=>el.classList.add('show'), i*36); }
  else{ aio.observe(el); }
});

/* ═══════════════════════════════
   7. 2×3 PAGE CAROUSEL
═══════════════════════════════ */
const pool      = document.getElementById('cardPool');
const carTrack  = document.getElementById('carTrack');
const carOuter  = document.getElementById('carOuter');
const carDots   = document.getElementById('carDots');
const carPrev   = document.getElementById('carPrev');
const carNext   = document.getElementById('carNext');
const carCount  = document.getElementById('carCount');

let allCards    = [];
let visCards    = [];
let pages       = [];
let currentPage = 0;
let targetX     = 0;
let currentX    = 0;
let isAnimating = false;
let cols        = 3;
const rows      = 2;

function getCols(){
  const w = window.innerWidth;
  if(w <= 700)  return 1;
  if(w <= 1000) return 2;
  return 3;
}

function buildPages(){
  cols = getCols();
  const perPage = cols * rows;
  pages = [];
  for(let i=0; i<visCards.length; i+=perPage){
    pages.push(visCards.slice(i, i+perPage));
  }
  if(pages.length === 0) pages = [[]];

  carTrack.innerHTML = '';

  pages.forEach(pg=>{
    const div = document.createElement('div');
    div.className = 'car-page';
    div.style.gridTemplateColumns = `repeat(${cols}, 1fr)`;
    pg.forEach(card=>{ div.appendChild(card); });
    carTrack.appendChild(div);
  });

  carTrack.style.width = (pages.length * 100) + '%';
  document.querySelectorAll('.car-page').forEach(p=>{
    p.style.flex  = `0 0 ${100/pages.length}%`;
    p.style.width = `${100/pages.length}%`;
  });

  currentPage = 0; currentX = 0; targetX = 0;
  carTrack.style.transform = 'translateX(0)';

  buildDots();
  updateCount();
  pgCardsReObserve();
}

function pgCardsReObserve(){
  document.querySelectorAll('.ccard').forEach((c,i)=>{
    c.classList.remove('show');
    setTimeout(()=>{
      const r = c.getBoundingClientRect();
      if(r.top < window.innerHeight-60) c.classList.add('show');
      else aio.observe(c);
    }, i*40);
  });
}

function buildDots(){
  carDots.innerHTML = '';
  pages.forEach((_,i)=>{
    const d = document.createElement('div');
    d.className = 'dp' + (i===0?' on':'');
    d.addEventListener('click', ()=>goToPage(i));
    carDots.appendChild(d);
  });
}
function updateDots(){
  document.querySelectorAll('.dp').forEach((d,i)=>d.classList.toggle('on', i===currentPage));
}
function updateCount(){
  const total = allCards.length;
  const vis   = visCards.length;
  carCount.textContent = vis===total ? total+' restaurants' : vis+' of '+total+' shown';
}

function goToPage(p){
  currentPage = Math.max(0, Math.min(pages.length-1, p));
  const outerW = carOuter.offsetWidth;
  targetX = -(currentPage * outerW);
  animateTo();
  updateDots();
}

function animateTo(){
  if(isAnimating) return;
  isAnimating = true;
  function step(){
    currentX += (targetX - currentX) * 0.072;
    if(Math.abs(targetX - currentX) < 0.4){
      currentX = targetX;
      carTrack.style.transform = `translateX(${currentX}px)`;
      isAnimating = false; return;
    }
    carTrack.style.transform = `translateX(${currentX}px)`;
    requestAnimationFrame(step);
  }
  requestAnimationFrame(step);
}

carPrev.addEventListener('click', ()=>goToPage(currentPage-1));
carNext.addEventListener('click', ()=>goToPage(currentPage+1));

/* touch swipe */
let tStartX=0;
carOuter.addEventListener('touchstart', e=>{ tStartX=e.touches[0].clientX; lenis.stop(); },{passive:true});
carOuter.addEventListener('touchend',   e=>{
  const dx = tStartX - e.changedTouches[0].clientX;
  if(Math.abs(dx)>40) goToPage(dx>0 ? currentPage+1 : currentPage-1);
  lenis.start();
},{passive:true});

/* mouse drag */
let mDown=false, mStartX=0, mStartPage=0;
carOuter.addEventListener('mousedown', e=>{ mDown=true; mStartX=e.clientX; mStartPage=currentPage; lenis.stop(); carOuter.style.cursor='grabbing'; });
window.addEventListener('mouseup', ()=>{ if(mDown){ mDown=false; lenis.start(); carOuter.style.cursor=''; } });
window.addEventListener('mousemove', e=>{
  if(!mDown) return;
  const dx = mStartX - e.clientX;
  if(Math.abs(dx)>60){
    mDown=false; lenis.start(); carOuter.style.cursor='';
    goToPage(dx>0 ? mStartPage+1 : mStartPage-1);
  }
});

/* resize */
let resizeTimer;
window.addEventListener('resize',()=>{
  clearTimeout(resizeTimer);
  resizeTimer=setTimeout(()=>{ buildPages(); goToPage(currentPage); },220);
});

/* ═══════════════════════════════
   8. SEARCH & FILTER
═══════════════════════════════ */
let activeFilter = '';

function setFilter(btn, cuisine){
  document.querySelectorAll('.pill').forEach(p=>p.classList.remove('on'));
  btn.classList.add('on');
  activeFilter = cuisine;
  applyFilters();
}

function applyFilters(){
  const q = (document.getElementById('searchInput').value||'').toLowerCase().trim();
  visCards = allCards.filter(card=>{
    const n = card.dataset.name    || '';
    const c = card.dataset.cuisine || '';
    return (!q || n.includes(q) || c.includes(q)) && (!activeFilter || c.includes(activeFilter));
  });
  buildPages();
}

/* ═══════════════════════════════
   9. INIT CAROUSEL
═══════════════════════════════ */
(function init(){
  allCards = Array.from(pool.querySelectorAll('.ccard'));
  visCards = [...allCards];
  buildPages();
})();

/* ═══════════════════════════════
   10. SMOOTH ANCHOR SCROLL
═══════════════════════════════ */
document.querySelectorAll('a[href^="#"]').forEach(a=>{
  a.addEventListener('click', e=>{
    const t = document.querySelector(a.getAttribute('href'));
    if(t){ e.preventDefault(); lenis.scrollTo(t, {offset:-64, duration:1.4}); }
  });
});

/* ═══════════════════════════════
   11. FOOTER BACK TO TOP
═══════════════════════════════ */
document.querySelector('.ft-top')?.addEventListener('click', e=>{
  e.preventDefault();
  lenis.scrollTo(0, {duration:1.6});
});
</script>

</body>
</html>