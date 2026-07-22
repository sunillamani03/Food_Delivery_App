<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List,com.tap.model.Order" %>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order History — Flavora</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:ital,wght@0,300;0,400;0,500;0,600;1,300;1,400&display=swap" rel="stylesheet">

<style>
/* ════════════════════════════════════════
   IMPOSSIBLE FOODS — DESIGN TOKENS
════════════════════════════════════════ */
:root {
  --color-velvet-wine:    #260212;
  --color-burgundy-stage: #4f0423;
  --color-impossible-red: #e10600;
  --color-blush-highlight:#ffc7c6;
  --color-butcher-black:  #000000;
  --color-bone-white:     #ffffff;

  --font-display: 'Bebas Neue', ui-sans-serif, system-ui, sans-serif;
  --font-body:    'Inter', ui-sans-serif, system-ui, sans-serif;

  /* Type scale */
  --text-caption:    10px;
  --text-body-sm:    14px;
  --text-body:       18px;
  --text-heading-lg: 103px;
  --text-display:    160px;

  /* Leading */
  --leading-display:    0.73;
  --leading-heading-lg: 0.75;
  --leading-heading:    0.90;

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
  --spacing-48:  48px;
  --spacing-56:  56px;
  --spacing-64:  64px;
  --spacing-80:  80px;

  /* Radius */
  --radius-buttons: 15px;
  --radius-cards:   12px;
  --radius-toggles: 15px;

  --nav-h: 64px;
}

/* ════════════════════════════════════════
   BASE RESET
════════════════════════════════════════ */
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; overflow-x: hidden; }
body {
  font-family: var(--font-body);
  background: var(--color-velvet-wine);
  color: var(--color-bone-white);
  overflow-x: hidden;
}
a { text-decoration: none; color: inherit; }

/* ════════════════════════════════════════
   SCROLL PROGRESS BAR
════════════════════════════════════════ */
.scroll-progress {
  position: fixed; top: 0; left: 0;
  height: 2px;
  background: var(--color-impossible-red);
  z-index: 10001;
  width: 0%;
  transition: width 0.1s linear;
}

/* ════════════════════════════════════════
   CUSTOM CURSOR
════════════════════════════════════════ */
.cursor-dot {
  width: 7px; height: 7px;
  background: var(--color-impossible-red);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none; z-index: 9999;
  transform: translate(-50%,-50%);
  display: none;
}
.cursor-ring {
  width: 34px; height: 34px;
  border: 1.5px solid rgba(225,6,0,.5);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none; z-index: 9998;
  transform: translate(-50%,-50%);
  transition: width .22s, height .22s, border-color .22s;
  display: none;
}
.cursor-ring.big { width: 54px; height: 54px; border-color: rgba(225,6,0,.25); }

/* ════════════════════════════════════════
   NAV — solid black bar
════════════════════════════════════════ */
.nav {
  position: fixed; top: 0; left: 0; right: 0;
  z-index: 1000;
  display: flex; align-items: center;
  justify-content: space-between;
  padding: 0 40px; height: var(--nav-h);
  background: var(--color-butcher-black);
  border-bottom: 1px solid rgba(255,255,255,.06);
}
.nav-logo {
  font-family: var(--font-display);
  font-size: 22px;
  letter-spacing: var(--tracking-label);
  color: var(--color-impossible-red);
  line-height: 1; text-transform: uppercase;
}
.nav-logo span {
  display: block;
  font-family: var(--font-body);
  font-size: 9px; font-weight: 400;
  color: rgba(255,199,198,.55);
  letter-spacing: 0.12em; text-transform: uppercase;
  margin-top: 2px;
}
.nav-links { display: flex; align-items: center; gap: 4px; }
.nav-links .btnn {
  font-family: var(--font-body);
  font-size: var(--text-caption); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: rgba(255,255,255,.7);
  padding: 8px 16px; border-radius: var(--radius-buttons);
  border: 1.5px solid transparent; background: transparent;
  transition: all .22s;
}
.nav-links .btnn:hover { border-color: var(--color-impossible-red); color: var(--color-impossible-red); }
.nav-links .btnn.primary {
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  border-color: var(--color-impossible-red);
}
.nav-links .btnn.primary:hover { background: #c00400; border-color: #c00400; }

/* hamburger */
.hamburger {
  display: none; background: none; border: none; cursor: pointer;
  padding: 8px; flex-direction: column; gap: 5px;
}
.hamburger span {
  display: block; width: 22px; height: 1.5px;
  background: var(--color-bone-white); border-radius: 2px;
  transition: all .3s;
}
.hamburger.active span:nth-child(1) { transform: rotate(45deg) translate(5px,5px); }
.hamburger.active span:nth-child(2) { opacity: 0; }
.hamburger.active span:nth-child(3) { transform: rotate(-45deg) translate(5px,-5px); }

/* mobile drawer */
.mobile-menu {
  display: none;
  position: fixed; top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,.97);
  z-index: 9999;
  flex-direction: column; align-items: center;
  justify-content: center; gap: 12px;
  opacity: 0; pointer-events: none;
  transition: opacity .35s;
}
.mobile-menu.open { opacity: 1; pointer-events: auto; }
.mobile-menu .btnn {
  font-family: var(--font-body);
  font-size: var(--text-body-sm); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: rgba(255,255,255,.7);
  padding: 14px 28px; border-radius: var(--radius-buttons);
  border: 1.5px solid rgba(255,255,255,.12);
  background: none; text-decoration: none; display: block;
  text-align: center; min-width: 200px; transition: all .22s;
}
.mobile-menu .btnn:hover { border-color: var(--color-impossible-red); color: var(--color-impossible-red); }
.mobile-menu .btnn.primary {
  background: var(--color-impossible-red); color: var(--color-bone-white);
  border-color: var(--color-impossible-red);
}
.mobile-menu .btnn.primary:hover { background: #c00400; border-color: #c00400; }

@media (max-width: 767px) {
  .hamburger { display: flex; }
  .nav-links  { display: none; }
  .mobile-menu { display: flex; }
}

/* ════════════════════════════════════════
   HERO — full-bleed display declaration
════════════════════════════════════════ */
.hero {
  min-height: 100vh;
  background: var(--color-velvet-wine);
  display: grid;
  grid-template-columns: 1fr 1fr;
  position: relative; overflow: hidden;
  padding-top: var(--nav-h);
}

/* ghost watermark */
.hero-wm {
  position: absolute; inset: 0;
  display: flex; align-items: center; justify-content: center;
  font-family: var(--font-display);
  font-size: clamp(80px, 20vw, 300px);
  color: rgba(79,4,35,.35);
  letter-spacing: 0.03em; text-transform: uppercase;
  pointer-events: none; white-space: nowrap; user-select: none;
}

.hero-left {
  display: flex; flex-direction: column;
  justify-content: center;
  padding: 0 48px 0 60px;
  position: relative; z-index: 2;
}
.hero-eyebrow {
  font-family: var(--font-body);
  font-size: var(--text-caption); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: var(--color-impossible-red);
  margin-bottom: var(--spacing-8);
  opacity: 0;
  animation: riseUp .7s .1s cubic-bezier(.16,1,.3,1) forwards;
}
.hero-word {
  font-family: var(--font-display);
  font-size: clamp(72px, 10vw, 140px);
  line-height: var(--leading-display);
  letter-spacing: var(--tracking-display);
  color: var(--color-impossible-red);
  text-transform: uppercase;
  opacity: 0; transform: translateY(60px);
  animation: riseUp .9s cubic-bezier(.16,1,.3,1) forwards;
}
.hero-word:nth-child(2) { animation-delay: .15s; }
.hero-word:nth-child(3) { animation-delay: .30s; }
.hero-word:nth-child(4) {
  animation-delay: .45s;
  font-size: clamp(36px, 5vw, 70px);
  color: var(--color-blush-highlight);
}
@keyframes riseUp { to { opacity: 1; transform: translateY(0); } }

.hero-tagline {
  font-family: var(--font-body);
  font-size: var(--text-body-sm); line-height: 1.7;
  color: rgba(255,199,198,.55);
  max-width: 300px; margin-top: var(--spacing-24);
  opacity: 0;
  animation: riseUp .8s .6s cubic-bezier(.16,1,.3,1) forwards;
}

/* hero right — big emoji panel */
.hero-right {
  display: flex; align-items: center; justify-content: center;
  padding: 40px; position: relative; z-index: 2;
  background: rgba(79,4,35,.2);
  border-left: 1px solid var(--color-butcher-black);
}
.hero-right .big-emoji {
  font-size: clamp(100px, 14vw, 180px);
  animation: floatY 4s ease-in-out infinite;
  will-change: transform;
}
@keyframes floatY {
  0%,100% { transform: translateY(0) rotate(-3deg); }
  50%      { transform: translateY(-18px) rotate(3deg); }
}

/* hero stats strip */
.hero-stats {
  display: flex; align-items: center; justify-content: center;
  border-top: 1px solid rgba(255,255,255,.06);
  grid-column: 1 / -1;
}
.hstat {
  flex: 1; text-align: center;
  padding: var(--spacing-20) var(--spacing-24);
  border-right: 1px solid rgba(255,255,255,.06);
}
.hstat:last-child { border-right: none; }
.hstat-n {
  font-family: var(--font-display);
  font-size: clamp(24px, 3.5vw, 44px);
  color: var(--color-impossible-red);
  letter-spacing: .04em; line-height: 1;
}
.hstat-l {
  font-family: var(--font-body);
  font-size: var(--text-caption); font-weight: 400;
  letter-spacing: .2em; text-transform: uppercase;
  color: rgba(255,199,198,.45); margin-top: 4px;
}

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
.tk-t { display: flex; white-space: nowrap; animation: tkroll 28s linear infinite; }
.tk:hover .tk-t { animation-play-state: paused; }
.tk-t s {
  font-family: var(--font-display);
  font-size: 13px; letter-spacing: .18em; text-transform: uppercase;
  color: rgba(255,255,255,.55); text-decoration: none;
  padding: 0 28px; flex-shrink: 0;
}
.tk-t .td { padding: 0 2px; color: var(--color-impossible-red); font-size: 14px; }
@keyframes tkroll { from { transform: translateX(0); } to { transform: translateX(-50%); } }

/* ════════════════════════════════════════
   TABLE SECTION
════════════════════════════════════════ */
.table-section {
  padding: var(--spacing-64) 48px var(--spacing-80);
  background: var(--color-velvet-wine);
}

/* section opener */
.sec-bracket {
  font-family: var(--font-body);
  font-size: var(--text-caption); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: var(--color-impossible-red);
  margin-bottom: var(--spacing-8);
  text-align: center;
}
.sec-head {
  font-family: var(--font-display);
  font-size: clamp(48px, 7vw, 96px);
  line-height: var(--leading-heading-lg);
  letter-spacing: var(--tracking-heading-lg);
  text-transform: uppercase;
  color: var(--color-impossible-red);
  text-align: center;
  margin-bottom: var(--spacing-40);
}
.sec-head .aside {
  display: block;
  font-size: clamp(28px, 4vw, 52px);
  color: var(--color-blush-highlight);
}

/* table wrapper — burgundy card, hairline border, no shadow */
.table-wrap {
  max-width: 1100px;
  margin: 0 auto;
  overflow-x: auto;
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
}

table {
  width: 100%;
  border-collapse: collapse;
  min-width: 600px;
}

/* thead — butcher black surface, bone white text */
thead th {
  font-family: var(--font-body);
  font-size: var(--text-caption); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: rgba(255,199,198,.6);
  background: var(--color-butcher-black);
  padding: 16px 20px; text-align: left;
}
thead th:first-child { border-radius: var(--radius-cards) 0 0 0; }
thead th:last-child  { border-radius: 0 var(--radius-cards) 0 0; }

/* tbody */
tbody td {
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  color: var(--color-bone-white);
  padding: 16px 20px;
  border-bottom: 1px solid rgba(0,0,0,.3);
}
tbody tr { transition: background .18s; }
tbody tr:hover { background: rgba(225,6,0,.07); }
tbody tr:last-child td { border-bottom: none; }

/* order id — display face */
.order-id {
  font-family: var(--font-display);
  font-size: 22px;
  letter-spacing: var(--tracking-ui);
  color: var(--color-blush-highlight);
}

/* amount */
.amount {
  font-family: var(--font-display);
  font-size: 20px;
  letter-spacing: var(--tracking-ui);
  color: var(--color-bone-white);
}

/* ════════════════════════════════════════
   STATUS BADGES — pill toggle pattern
════════════════════════════════════════ */
.status-badge {
  display: inline-flex; align-items: center; gap: 6px;
  font-family: var(--font-body);
  font-size: 9px; font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  padding: 5px 12px; border-radius: var(--radius-toggles);
  border: 1px solid transparent;
}
.status-badge.delivered {
  background: rgba(225,6,0,.15);
  color: var(--color-impossible-red);
  border-color: rgba(225,6,0,.25);
}
.status-badge.pending {
  background: rgba(255,199,198,.1);
  color: var(--color-blush-highlight);
  border-color: rgba(255,199,198,.2);
}
.status-badge.cancelled {
  background: rgba(255,255,255,.06);
  color: rgba(255,199,198,.4);
  border-color: rgba(255,255,255,.1);
}
.status-dot {
  width: 5px; height: 5px; border-radius: 50%;
}
.status-dot.green  { background: var(--color-impossible-red); }
.status-dot.orange { background: var(--color-blush-highlight); }
.status-dot.gray   { background: rgba(255,199,198,.3); }

/* ════════════════════════════════════════
   CTA BUTTONS
════════════════════════════════════════ */
.back-btn {
  display: inline-flex; align-items: center; gap: 8px;
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  font-family: var(--font-body);
  font-size: var(--text-body-sm); font-weight: 500;
  letter-spacing: var(--tracking-ui); text-transform: uppercase;
  padding: 12px 24px; border-radius: var(--radius-buttons);
  border: 1px solid var(--color-impossible-red);
  transition: background .22s, border-color .22s, gap .2s;
}
.back-btn:hover { background: #c00400; border-color: #c00400; gap: 14px; }
.back-btn svg {
  stroke: currentColor; fill: none; stroke-width: 2.4;
  transition: transform .2s;
}
.back-btn:hover svg { transform: translateX(4px); }

.ghost-btn {
  display: inline-flex; align-items: center; gap: 8px;
  background: transparent;
  color: var(--color-bone-white);
  font-family: var(--font-body);
  font-size: var(--text-body-sm); font-weight: 500;
  letter-spacing: var(--tracking-ui); text-transform: uppercase;
  padding: 12px 24px; border-radius: var(--radius-buttons);
  border: 1px solid var(--color-bone-white);
  transition: border-color .22s, color .22s;
}
.ghost-btn:hover { border-color: var(--color-blush-highlight); color: var(--color-blush-highlight); }

/* ════════════════════════════════════════
   EMPTY STATE
════════════════════════════════════════ */
.empty-state {
  max-width: 500px; margin: 0 auto;
  text-align: center; padding: var(--spacing-80) var(--spacing-40);
}
.empty-emoji { font-size: 60px; margin-bottom: var(--spacing-20); }
.empty-state h3 {
  font-family: var(--font-display);
  font-size: 56px;
  color: var(--color-impossible-red);
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  margin-bottom: var(--spacing-12);
}
.empty-state p {
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  color: rgba(255,199,198,.5);
  line-height: 1.7;
  margin-bottom: var(--spacing-32);
}

/* ════════════════════════════════════════
   3D SCROLL REVEAL
════════════════════════════════════════ */
.scroll-3d {
  opacity: 0;
  transform: perspective(1200px) translateY(40px) rotateX(6deg);
  transform-origin: center top;
  will-change: transform, opacity;
  transition: opacity .8s cubic-bezier(.16,1,.3,1),
              transform 1s cubic-bezier(.16,1,.3,1);
}
.scroll-3d.vis {
  opacity: 1;
  transform: perspective(1200px) translateY(0) rotateX(0);
}
.delay-1 { transition-delay: .06s; }
.delay-2 { transition-delay: .12s; }
.delay-3 { transition-delay: .18s; }

/* ════════════════════════════════════════
   FOOTER
════════════════════════════════════════ */
.footer {
  background: var(--color-butcher-black);
  border-top: 1px solid rgba(255,255,255,.06);
  padding: var(--spacing-56) 48px 36px;
  position: relative; overflow: hidden;
}
.footer-bg-word {
  position: absolute;
  font-family: var(--font-display);
  font-size: clamp(80px, 14vw, 180px);
  color: rgba(255,255,255,.025);
  bottom: -12px; left: 0; right: 0;
  text-align: center; letter-spacing: .06em;
  pointer-events: none; text-transform: uppercase;
}
.footer-inner {
  max-width: 1200px; margin: 0 auto;
  display: flex; justify-content: space-between;
  align-items: flex-end; flex-wrap: wrap;
  gap: 28px; position: relative; z-index: 1;
}
.footer-logo {
  font-family: var(--font-display);
  font-size: 38px; letter-spacing: .08em;
  color: var(--color-impossible-red);
  text-transform: uppercase; line-height: 1;
}
.footer-logo span {
  display: block;
  font-family: var(--font-body); font-size: 11px; font-weight: 400;
  color: rgba(255,199,198,.45); letter-spacing: .08em;
  text-transform: uppercase; margin-top: 4px;
}
.footer-copy {
  font-family: var(--font-body); font-size: var(--text-caption);
  letter-spacing: .1em; text-transform: uppercase;
  color: rgba(255,255,255,.25);
}
.footer-top-link {
  display: inline-flex; align-items: center; gap: 7px;
  font-family: var(--font-body); font-size: var(--text-caption); font-weight: 500;
  letter-spacing: .16em; text-transform: uppercase;
  color: var(--color-blush-highlight);
  border: 1px solid rgba(255,199,198,.25);
  padding: 9px 20px; border-radius: var(--radius-buttons);
  transition: all .24s;
}
.footer-top-link:hover {
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  border-color: var(--color-impossible-red);
}

/* ════════════════════════════════════════
   RESPONSIVE
════════════════════════════════════════ */
@media (max-width: 900px) {
  .hero { grid-template-columns: 1fr; min-height: auto; }
  .hero-left { padding: 60px 24px 20px; }
  .hero-right {
    padding: 24px 24px 40px;
    border-left: none;
    border-top: 1px solid var(--color-butcher-black);
  }
  .hero-tagline { max-width: 100%; }
  .hero-stats { flex-wrap: wrap; }
  .table-section { padding: 40px 20px 60px; }
  .nav { padding: 0 20px; }
  .footer { padding: 48px 24px 32px; }
}
@media (max-width: 600px) {
  table { min-width: 100%; }
  thead th, tbody td { padding: 12px 14px; font-size: 12px; }
  .order-id { font-size: 18px; }
  .sec-head { font-size: 48px; }
  .footer-inner { flex-direction: column; align-items: center; text-align: center; gap: 20px; }
}
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: .01ms !important;
    transition-duration: .01ms !important;
  }
}
</style>
</head>
<body>

<!-- scroll progress -->
<div class="scroll-progress" id="scrollProgress"></div>

<!-- custom cursor -->
<div class="cursor-dot" id="cDot"></div>
<div class="cursor-ring" id="cRing"></div>

<!-- ══════════════════════════════════════
     NAV — solid black bar, red wordmark
══════════════════════════════════════ -->
<nav class="nav" id="mainNav">
  <a href="restaurantServlet" class="nav-logo">
    FLAVORA
    <span>fine food delivery</span>
  </a>
  <div class="nav-links">
    <a href="callOrderHistoryServlet" class="btnn primary">Order History</a>
    <a href="cart.jsp"                class="btnn">Cart</a>
    <a href="register.html"           class="btnn">Sign Up</a>
    <a href="login.jsp"               class="btnn">Login</a>
  </div>
  <button class="hamburger" id="hamburger" aria-label="Menu">
    <span></span><span></span><span></span>
  </button>
</nav>

<!-- mobile drawer -->
<div class="mobile-menu" id="mobileMenu">
  <a href="callOrderHistoryServlet" class="btnn primary">Order History</a>
  <a href="cart.jsp"                class="btnn">Cart</a>
  <a href="register.html"           class="btnn">Sign Up</a>
  <a href="login.jsp"               class="btnn">Login</a>
</div>

<!-- ══════════════════════════════════════
     HERO — display headline
══════════════════════════════════════ -->
<section class="hero">
  <div class="hero-wm" aria-hidden="true">ORDERS</div>

  <div class="hero-left">
    <p class="hero-eyebrow">◂ Your account ▸</p>
    <div class="hero-word">YOUR</div>
    <div class="hero-word">ORDER</div>
    <div class="hero-word">HISTORY</div>
    <div class="hero-word">(EVERY MEAL)</div>
    <p class="hero-tagline">
      Every meal you've ordered, all in one place.
      Track, reorder, and relive the flavours.
    </p>
  </div>

  <div class="hero-right">
    <div class="big-emoji">📋</div>
  </div>

  <div class="hero-stats">
    <div class="hstat">
      <div class="hstat-n">Fast</div>
      <div class="hstat-l">Delivery</div>
    </div>
    <div class="hstat">
      <div class="hstat-n">Fresh</div>
      <div class="hstat-l">Every Order</div>
    </div>
    <div class="hstat">
      <div class="hstat-n">4.8 ★</div>
      <div class="hstat-l">Avg Rating</div>
    </div>
    <div class="hstat">
      <div class="hstat-n">50k+</div>
      <div class="hstat-l">Happy Customers</div>
    </div>
  </div>
</section>

<!-- ticker -->
<div class="tk"><div class="tk-t" id="tk1"></div></div>

<!-- ══════════════════════════════════════
     ORDERS TABLE SECTION
══════════════════════════════════════ -->
<section class="table-section">

  <%
  List<Order> historyList = (List<Order>)request.getAttribute("orderHistory");

  if (historyList != null && !historyList.isEmpty()) {
  %>

  <p class="sec-bracket scroll-3d">◂ All your orders ▸</p>
  <h2 class="sec-head scroll-3d delay-1">
    ORDER LOG
    <span class="aside">(<%= historyList.size() %> ORDERS)</span>
  </h2>

  <div class="table-wrap scroll-3d delay-2">
    <table>
      <thead>
        <tr>
          <th>Order ID</th>
          <th>Date</th>
          <th>Total Amount</th>
          <th>Status</th>
          <th>Payment</th>
        </tr>
      </thead>
      <tbody>

      <%
      for (Order o : historyList) {
        String status = o.getStatus() != null ? o.getStatus().toLowerCase() : "";
        String badgeClass = "pending";
        String dotClass   = "orange";
        if (status.contains("deliver") || status.contains("completed")) {
          badgeClass = "delivered"; dotClass = "green";
        } else if (status.contains("cancel")) {
          badgeClass = "cancelled"; dotClass = "gray";
        }
      %>

        <tr>
          <td><span class="order-id">#<%= o.getOrderId() %></span></td>
          <td style="color:rgba(255,199,198,.65)"><%= o.getOrderDate() %></td>
          <td><span class="amount">₹ <%= o.getTotalAmount() %></span></td>
          <td>
            <span class="status-badge <%= badgeClass %>">
              <span class="status-dot <%= dotClass %>"></span>
              <%= o.getStatus() %>
            </span>
          </td>
          <td style="color:rgba(255,199,198,.65)"><%= o.getPaymentMethod() %></td>
        </tr>

      <%
      }
      %>

      </tbody>
    </table>
  </div>

  <!-- CTA row — filled + ghost pair -->
  <div style="display:flex;justify-content:center;gap:10px;margin-top:var(--spacing-40);" class="scroll-3d delay-3">
    <a href="restaurantServlet" class="back-btn">
      Order Again
      <svg width="14" height="14" viewBox="0 0 24 24">
        <path d="M5 12h14M12 5l7 7-7 7"/>
      </svg>
    </a>
    <a href="restaurantServlet" class="ghost-btn">
      Browse Restaurants
    </a>
  </div>

  <%
  } else {
  %>

  <!-- empty state -->
  <div class="empty-state scroll-3d">
    <div class="empty-emoji">📭</div>
    <h3>No Orders Yet</h3>
    <p>
      Looks like you haven't placed any orders yet.
      Craving something? Browse our restaurants and place your first order.
    </p>
    <a href="restaurantServlet" class="back-btn">
      Browse Restaurants
      <svg width="14" height="14" viewBox="0 0 24 24">
        <path d="M5 12h14M12 5l7 7-7 7"/>
      </svg>
    </a>
  </div>

  <%
  }
  %>

</section>

<!-- ══════════════════════════════════════
     FOOTER
══════════════════════════════════════ -->
<footer class="footer">
  <div class="footer-bg-word" aria-hidden="true">FLAVORA</div>
  <div class="footer-inner">
    <div class="footer-logo">
      FLAVORA
      <span>fine food delivery</span>
    </div>
    <div style="text-align:right;">
      <p class="footer-copy" style="margin-bottom:16px;">© 2026 Flavora. All rights reserved.</p>
      <a href="#" class="footer-top-link">Back to top ↑</a>
    </div>
  </div>
</footer>

<!-- ══════════════════════════════════════
     SCRIPTS — all functionality preserved
══════════════════════════════════════ -->
<script>
/* ═══════════════════════════════
   TICKER
═══════════════════════════════ */
function buildTicker(id, words) {
  const t = document.getElementById(id);
  if (!t) return;
  const all = [...words, ...words];
  all.forEach((w, i) => {
    const s = document.createElement('s'); s.textContent = w; t.appendChild(s);
    if (i < all.length - 1) {
      const d = document.createElement('span'); d.className = 'td'; d.textContent = ' ✦ '; t.appendChild(d);
    }
  });
}
buildTicker('tk1', [
  'Order History', 'Track Your Meals', 'Reorder Favourites',
  'Fast Delivery', '4.8 Stars', '50k+ Orders',
  'Order History', 'Track Your Meals', 'Reorder Favourites',
  'Fast Delivery', '4.8 Stars', '50k+ Orders'
]);

/* ═══════════════════════════════
   HAMBURGER TOGGLE
═══════════════════════════════ */
const hamburger  = document.getElementById('hamburger');
const mobileMenu = document.getElementById('mobileMenu');
if (hamburger && mobileMenu) {
  hamburger.addEventListener('click', () => {
    hamburger.classList.toggle('active');
    mobileMenu.classList.toggle('open');
    document.body.style.overflow = mobileMenu.classList.contains('open') ? 'hidden' : '';
  });
  mobileMenu.querySelectorAll('.btnn').forEach(link => {
    link.addEventListener('click', () => {
      hamburger.classList.remove('active');
      mobileMenu.classList.remove('open');
      document.body.style.overflow = '';
    });
  });
}

/* ═══════════════════════════════
   CUSTOM CURSOR — desktop only
═══════════════════════════════ */
const isTouch = window.matchMedia('(pointer:coarse)').matches;
const dot  = document.getElementById('cDot');
const ring = document.getElementById('cRing');

if (!isTouch) {
  dot.style.display  = 'block';
  ring.style.display = 'block';

  let mx = 0, my = 0, rx = 0, ry = 0;
  document.addEventListener('mousemove', e => { mx = e.clientX; my = e.clientY; });

  (function animCursor() {
    rx += (mx - rx) * 0.13;
    ry += (my - ry) * 0.13;
    dot.style.left  = mx + 'px'; dot.style.top  = my + 'px';
    ring.style.left = rx + 'px'; ring.style.top = ry + 'px';
    requestAnimationFrame(animCursor);
  })();

  document.querySelectorAll('a, button, .back-btn, .ghost-btn, tbody tr').forEach(el => {
    el.addEventListener('mouseenter', () => ring.classList.add('big'));
    el.addEventListener('mouseleave', () => ring.classList.remove('big'));
  });
}

/* ═══════════════════════════════
   SCROLL PROGRESS
═══════════════════════════════ */
const progressBar = document.getElementById('scrollProgress');
window.addEventListener('scroll', () => {
  const scrollTop = window.scrollY;
  const docHeight = document.documentElement.scrollHeight - window.innerHeight;
  const pct = docHeight > 0 ? (scrollTop / docHeight) * 100 : 0;
  progressBar.style.width = pct + '%';
}, { passive: true });

/* ═══════════════════════════════
   3D SCROLL REVEAL
═══════════════════════════════ */
// Immediately reveal anything already in view
document.querySelectorAll('.scroll-3d').forEach(el => {
  if (el.getBoundingClientRect().top < window.innerHeight - 40) el.classList.add('vis');
});

const observer3d = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      e.target.classList.add('vis');
      observer3d.unobserve(e.target);
    }
  });
}, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

document.querySelectorAll('.scroll-3d:not(.vis)').forEach(el => observer3d.observe(el));

/* ═══════════════════════════════
   SMOOTH ANCHOR SCROLL
═══════════════════════════════ */
document.querySelectorAll('a[href^="#"]').forEach(a => {
  a.addEventListener('click', e => {
    const target = document.querySelector(a.getAttribute('href'));
    if (target) {
      e.preventDefault();
      target.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  });
});

/* ═══════════════════════════════
   FOOTER BACK TO TOP
═══════════════════════════════ */
document.querySelector('.footer-top-link')?.addEventListener('click', e => {
  e.preventDefault();
  window.scrollTo({ top: 0, behavior: 'smooth' });
});
</script>

</body>
</html>