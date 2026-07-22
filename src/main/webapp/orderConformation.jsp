<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Confirmed — Flavora</title>

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
  min-height: 100vh;
  display: flex;
  flex-direction: column;
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

.mobile-menu {
  display: none;
  position: fixed; top: 0; left: 0; right: 0; bottom: 0;
  background: rgba(0,0,0,.97); z-index: 9999;
  flex-direction: column; align-items: center; justify-content: center; gap: 12px;
  opacity: 0; pointer-events: none; transition: opacity .35s;
}
.mobile-menu.open { opacity: 1; pointer-events: auto; }
.mobile-menu .btnn {
  font-family: var(--font-body);
  font-size: var(--text-body-sm); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: rgba(255,255,255,.7);
  padding: 14px 28px; border-radius: var(--radius-buttons);
  border: 1.5px solid rgba(255,255,255,.12);
  background: none; text-align: center; min-width: 200px; transition: all .22s;
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
   CONFIRM SECTION — centred flex
════════════════════════════════════════ */
.confirm-section {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: center;
  padding: 100px 24px 64px;
  position: relative;
  overflow: hidden;
}

/* full-page ghost watermark behind card */
.page-wm {
  position: absolute; inset: 0;
  display: flex; align-items: center; justify-content: center;
  font-family: var(--font-display);
  font-size: clamp(80px, 22vw, 320px);
  color: rgba(79,4,35,.3);
  letter-spacing: 0.03em; text-transform: uppercase;
  pointer-events: none; white-space: nowrap; user-select: none;
}

/* ════════════════════════════════════════
   CONFIRM CARD — burgundy stage, hairline border, flat
════════════════════════════════════════ */
.confirm-card {
  max-width: 500px;
  width: 100%;
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
  padding: 56px 44px 48px;
  text-align: center;
  position: relative;
  overflow: hidden;
  /* no shadow — flat system */
}

/* top accent stripe */
.confirm-card::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 3px;
  background: var(--color-impossible-red);
}

/* ════════════════════════════════════════
   ANIMATED CHECKMARK — red system
════════════════════════════════════════ */
.checkmark-wrap {
  width: 84px;
  height: 84px;
  margin: 0 auto var(--spacing-32);
  position: relative;
}
.checkmark-circle {
  width: 84px;
  height: 84px;
  border-radius: 50%;
  background: var(--color-impossible-red);
  border: 2px solid var(--color-butcher-black);
  display: flex;
  align-items: center;
  justify-content: center;
  animation: popIn 0.6s cubic-bezier(0.16,1,0.3,1) forwards;
  transform: scale(0);
}
@keyframes popIn {
  0%   { transform: scale(0); }
  70%  { transform: scale(1.12); }
  100% { transform: scale(1); }
}
.checkmark-circle svg {
  width: 40px; height: 40px;
  stroke: var(--color-bone-white);
  stroke-width: 3;
  fill: none;
  stroke-linecap: round;
  stroke-linejoin: round;
  stroke-dasharray: 50;
  stroke-dashoffset: 50;
  animation: drawCheck 0.45s 0.45s ease forwards;
}
@keyframes drawCheck { to { stroke-dashoffset: 0; } }

/* expanding ring — uses blush for contrast on dark bg */
.checkmark-wrap::after {
  content: '';
  position: absolute;
  top: 0; left: 0;
  width: 100%; height: 100%;
  border-radius: 50%;
  border: 2px solid var(--color-blush-highlight);
  animation: ringExpand 1.4s 0.6s ease-out infinite;
}
@keyframes ringExpand {
  0%   { transform: scale(1);   opacity: .5; }
  100% { transform: scale(1.7); opacity: 0; }
}

/* ════════════════════════════════════════
   CARD TYPOGRAPHY
════════════════════════════════════════ */
.confirm-card h2 {
  font-family: var(--font-display);
  font-size: clamp(36px, 6vw, 56px);
  line-height: var(--leading-heading);
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  color: var(--color-impossible-red);
  margin-bottom: var(--spacing-8);
  opacity: 0;
  transform: translateY(16px);
  animation: fadeUp 0.7s 0.55s cubic-bezier(0.16,1,0.3,1) forwards;
}
.confirm-card .sub-head {
  font-family: var(--font-display);
  font-size: clamp(22px, 3.5vw, 32px);
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  color: var(--color-blush-highlight);
  margin-bottom: var(--spacing-16);
  opacity: 0;
  transform: translateY(16px);
  animation: fadeUp 0.7s 0.65s cubic-bezier(0.16,1,0.3,1) forwards;
}
.confirm-card .sub {
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  line-height: 1.7;
  color: rgba(255,199,198,.55);
  max-width: 340px;
  margin: 0 auto var(--spacing-40);
  opacity: 0;
  transform: translateY(16px);
  animation: fadeUp 0.7s 0.75s cubic-bezier(0.16,1,0.3,1) forwards;
}
@keyframes fadeUp { to { opacity: 1; transform: translateY(0); } }

/* ════════════════════════════════════════
   CTA PAIR — filled + ghost
════════════════════════════════════════ */
.btn-row {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 10px;
  flex-wrap: wrap;
  opacity: 0;
  transform: translateY(16px);
  animation: fadeUp 0.7s 0.9s cubic-bezier(0.16,1,0.3,1) forwards;
}

.confirm-btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  font-family: var(--font-body);
  font-size: var(--text-body-sm); font-weight: 500;
  letter-spacing: var(--tracking-ui); text-transform: uppercase;
  padding: 12px 24px;
  border-radius: var(--radius-buttons);
  border: 1px solid var(--color-impossible-red);
  transition: background .22s, border-color .22s, gap .2s;
}
.confirm-btn:hover { background: #c00400; border-color: #c00400; gap: 14px; }
.confirm-btn svg {
  stroke: currentColor; fill: none; stroke-width: 2.4;
  transition: transform .2s;
}
.confirm-btn:hover svg { transform: translateX(4px); }

.ghost-btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  background: transparent;
  color: var(--color-bone-white);
  font-family: var(--font-body);
  font-size: var(--text-body-sm); font-weight: 500;
  letter-spacing: var(--tracking-ui); text-transform: uppercase;
  padding: 12px 24px;
  border-radius: var(--radius-buttons);
  border: 1px solid var(--color-bone-white);
  transition: border-color .22s, color .22s;
}
.ghost-btn:hover { border-color: var(--color-blush-highlight); color: var(--color-blush-highlight); }

/* ════════════════════════════════════════
   ORDER DETAIL STRIP — inside card
════════════════════════════════════════ */
.order-strip {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0;
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
  overflow: hidden;
  margin-bottom: var(--spacing-40);
  opacity: 0;
  transform: translateY(16px);
  animation: fadeUp 0.7s 0.82s cubic-bezier(0.16,1,0.3,1) forwards;
}
.order-strip-item {
  flex: 1; text-align: center; padding: 16px 12px;
  border-right: 1px solid var(--color-butcher-black);
  background: rgba(0,0,0,.2);
}
.order-strip-item:last-child { border-right: none; }
.order-strip-n {
  font-family: var(--font-display);
  font-size: 22px;
  letter-spacing: var(--tracking-ui);
  color: var(--color-impossible-red);
  line-height: 1;
}
.order-strip-l {
  font-family: var(--font-body);
  font-size: 8px; font-weight: 500;
  letter-spacing: .18em; text-transform: uppercase;
  color: rgba(255,199,198,.4);
  margin-top: 3px;
}

/* ════════════════════════════════════════
   FLOATING CELEBRATION DOTS — system colors
════════════════════════════════════════ */
.floating-dot {
  position: absolute;
  width: 6px; height: 6px;
  border-radius: 50%;
  pointer-events: none;
  opacity: 0;
  animation: dotFloat 2.5s ease-out infinite;
}
.floating-dot:nth-child(1) {
  top: 10%; left: 8%;
  background: var(--color-impossible-red);
  animation-delay: 0.2s; width: 8px; height: 8px;
}
.floating-dot:nth-child(2) {
  top: 8%; right: 12%;
  background: var(--color-blush-highlight);
  animation-delay: 0.6s;
}
.floating-dot:nth-child(3) {
  bottom: 15%; left: 10%;
  background: var(--color-impossible-red);
  animation-delay: 1s; width: 5px; height: 5px;
}
.floating-dot:nth-child(4) {
  bottom: 12%; right: 8%;
  background: var(--color-blush-highlight);
  animation-delay: 1.4s; width: 7px; height: 7px;
}
.floating-dot:nth-child(5) {
  top: 40%; left: 5%;
  background: var(--color-bone-white);
  animation-delay: 0.8s; width: 4px; height: 4px;
}
.floating-dot:nth-child(6) {
  top: 45%; right: 5%;
  background: var(--color-impossible-red);
  animation-delay: 1.6s;
}
@keyframes dotFloat {
  0%   { opacity: 0;   transform: translateY(0) scale(0); }
  20%  { opacity: 0.6; transform: translateY(-10px) scale(1); }
  80%  { opacity: 0.2; transform: translateY(-30px) scale(0.6); }
  100% { opacity: 0;   transform: translateY(-42px) scale(0); }
}

/* ════════════════════════════════════════
   TICKER
════════════════════════════════════════ */
.tk {
  overflow: hidden;
  background: var(--color-butcher-black);
  border-top: 1px solid rgba(255,255,255,.06);
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
   FOOTER
════════════════════════════════════════ */
.footer {
  background: var(--color-butcher-black);
  border-top: 1px solid rgba(255,255,255,.06);
  padding: var(--spacing-40) 48px;
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
  align-items: center; flex-wrap: wrap;
  gap: 20px; position: relative; z-index: 1;
}
.footer-logo {
  font-family: var(--font-display);
  font-size: 34px; letter-spacing: .08em;
  color: var(--color-impossible-red);
  text-transform: uppercase; line-height: 1;
}
.footer-logo span {
  display: block;
  font-family: var(--font-body); font-size: 9px; font-weight: 400;
  color: rgba(255,199,198,.45); letter-spacing: .1em;
  text-transform: uppercase; margin-top: 3px;
}
.footer-copy {
  font-family: var(--font-body); font-size: var(--text-caption);
  letter-spacing: .1em; text-transform: uppercase;
  color: rgba(255,255,255,.25);
}

/* ════════════════════════════════════════
   RESPONSIVE
════════════════════════════════════════ */
@media (max-width: 600px) {
  .confirm-card { padding: 44px 24px 40px; }
  .confirm-card h2 { font-size: 36px; }
  .order-strip-n { font-size: 18px; }
  .btn-row { flex-direction: column; }
  .confirm-btn, .ghost-btn { width: 100%; justify-content: center; }
  .nav { padding: 0 20px; }
  .confirm-section { padding: 80px 16px 48px; }
  .footer { padding: 32px 20px; }
  .footer-inner { flex-direction: column; text-align: center; gap: 14px; }
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
    <a href="callOrderHistoryServlet" class="btnn">Order History</a>
    <a href="cart.jsp"                class="btnn">Cart</a>
    <a href="register.html"           class="btnn">Sign Up</a>
    <a href="login.jsp"               class="btnn primary">Login</a>
  </div>
  <button class="hamburger" id="hamburger" aria-label="Menu">
    <span></span><span></span><span></span>
  </button>
</nav>

<!-- mobile drawer -->
<div class="mobile-menu" id="mobileMenu">
  <a href="callOrderHistoryServlet" class="btnn">Order History</a>
  <a href="cart.jsp"                class="btnn">Cart</a>
  <a href="register.html"           class="btnn">Sign Up</a>
  <a href="login.jsp"               class="btnn primary">Login</a>
</div>

<!-- ══════════════════════════════════════
     CONFIRM SECTION
══════════════════════════════════════ -->
<section class="confirm-section">
  <div class="page-wm" aria-hidden="true">DONE</div>

  <div class="confirm-card">

    <!-- floating celebration dots -->
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>
    <div class="floating-dot"></div>

    <!-- animated checkmark — red circle, white tick -->
    <div class="checkmark-wrap">
      <div class="checkmark-circle">
        <svg viewBox="0 0 24 24">
          <polyline points="4 13 9 18 20 6"/>
        </svg>
      </div>
    </div>

    <!-- display headline -->
    <h2>ORDER PLACED!</h2>
    <p class="sub-head">(SUCCESSFULLY)</p>
    <p class="sub">
      Thank you for ordering with Flavora.<br>
      Your meal is being prepared with care and is on its way.
    </p>

    <!-- order detail strip -->
    <div class="order-strip">
      <div class="order-strip-item">
        <div class="order-strip-n">✓</div>
        <div class="order-strip-l">Confirmed</div>
      </div>
      <div class="order-strip-item">
        <div class="order-strip-n">30</div>
        <div class="order-strip-l">Min ETA</div>
      </div>
      <div class="order-strip-item">
        <div class="order-strip-n">🛵</div>
        <div class="order-strip-l">On the Way</div>
      </div>
    </div>

    <!-- CTA pair — filled + ghost -->
    <div class="btn-row">
      <a href="restaurantServlet" class="confirm-btn">
        Order Again
        <svg width="14" height="14" viewBox="0 0 24 24">
          <path d="M5 12h14M12 5l7 7-7 7"/>
        </svg>
      </a>
      <a href="callOrderHistoryServlet" class="ghost-btn">
        View History
      </a>
    </div>

  </div>
</section>

<!-- ticker -->
<div class="tk"><div class="tk-t" id="tk1"></div></div>

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
    <p class="footer-copy">© 2026 Flavora. All rights reserved.</p>
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
  'Order Confirmed', 'Thank You', 'Enjoy Your Meal',
  'Fast Delivery', 'Fresh & Hot', 'Flavora',
  'Order Confirmed', 'Thank You', 'Enjoy Your Meal',
  'Fast Delivery', 'Fresh & Hot', 'Flavora'
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

  document.querySelectorAll('a, button, .confirm-btn, .ghost-btn, .confirm-card').forEach(el => {
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
   SMOOTH ANCHOR SCROLL
═══════════════════════════════ */
document.querySelectorAll('a[href^="#"]').forEach(a => {
  a.addEventListener('click', e => {
    const target = document.querySelector(a.getAttribute('href'));
    if (target) { e.preventDefault(); target.scrollIntoView({ behavior: 'smooth' }); }
  });
});
</script>

</body>
</html>