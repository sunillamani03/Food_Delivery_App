<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import= "com.tap.model.Menu, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Menu — Flavora</title>

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
  --spacing-28:  28px;
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

/* ════════════════════════════════════════
   HERO — display headline
════════════════════════════════════════ */
.hero {
  min-height: 60vh;
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
  font-size: clamp(80px, 20vw, 280px);
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
  font-size: clamp(64px, 9vw, 120px);
  line-height: var(--leading-display);
  letter-spacing: var(--tracking-display);
  color: var(--color-impossible-red);
  text-transform: uppercase;
  opacity: 0; transform: translateY(60px);
  animation: riseUp .9s cubic-bezier(.16,1,.3,1) forwards;
}
.hero-word:nth-child(2) { animation-delay: .15s; }
.hero-word:nth-child(3) {
  animation-delay: .30s;
  font-size: clamp(32px, 4.5vw, 60px);
  color: var(--color-blush-highlight);
}
@keyframes riseUp { to { opacity: 1; transform: translateY(0); } }

.hero-tagline {
  font-family: var(--font-body);
  font-size: var(--text-body-sm); line-height: 1.7;
  color: rgba(255,199,198,.55);
  max-width: 300px; margin-top: var(--spacing-24);
  opacity: 0;
  animation: riseUp .8s .55s cubic-bezier(.16,1,.3,1) forwards;
}
.hero-hashtag {
  font-family: var(--font-body);
  font-size: var(--text-caption); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: var(--color-blush-highlight);
  margin-top: var(--spacing-12);
  opacity: 0;
  animation: riseUp .8s .7s cubic-bezier(.16,1,.3,1) forwards;
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
.scroll-3d.vis { opacity: 1; transform: perspective(1200px) translateY(0) rotateX(0); }
.delay-1 { transition-delay: .06s; }
.delay-2 { transition-delay: .12s; }
.delay-3 { transition-delay: .18s; }

/* ════════════════════════════════════════
   MENU GRID SECTION
════════════════════════════════════════ */
.menu-section {
  padding: var(--spacing-40) 48px var(--spacing-80);
  background: var(--color-velvet-wine);
}

/* section opener */
.sec-bracket {
  max-width: 1200px;
  margin: 0 auto var(--spacing-32);
  font-family: var(--font-body);
  font-size: var(--text-caption); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: var(--color-impossible-red);
  display: flex; align-items: center; gap: 10px;
}
.sec-bracket::before { content: '◂'; }
.sec-bracket::after  { content: '▸'; }

.menu-grid {
  max-width: 1200px;
  margin: 0 auto;
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
  gap: var(--spacing-24);
}

/* ════════════════════════════════════════
   MENU CARD — burgundy surface, flat, hairline
════════════════════════════════════════ */
.menu-card {
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
  overflow: hidden;
  transition: transform 0.35s cubic-bezier(0.16,1,0.3,1),
              border-color 0.3s;
  display: flex;
  flex-direction: column;
  /* no shadow — flat elevation system */
}
.menu-card:hover {
  transform: translateY(-6px);
  border-color: var(--color-impossible-red);
}

.menu-card-img {
  width: 100%;
  height: 180px;
  object-fit: cover;
  display: block;
  position: relative;
}

.menu-card-body {
  padding: 18px 20px 22px;
  display: flex;
  flex-direction: column;
  flex: 1;
}
.menu-card-name {
  font-family: var(--font-display);
  font-size: 28px;
  letter-spacing: var(--tracking-ui);
  color: var(--color-blush-highlight);
  text-transform: uppercase;
  line-height: 1;
  margin-bottom: var(--spacing-8);
}
.menu-card-desc {
  font-family: var(--font-body);
  font-size: 12px;
  line-height: 1.6;
  color: rgba(255,199,198,.45);
  margin-bottom: var(--spacing-16);
  flex: 1;
}
.menu-card-meta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: var(--spacing-16);
}
.menu-card-price {
  font-family: var(--font-display);
  font-size: 26px;
  letter-spacing: var(--tracking-ui);
  color: var(--color-impossible-red);
}
.menu-card-price span {
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  color: var(--color-blush-highlight);
  margin-left: 4px;
}

/* availability badge — pill toggle pattern */
.avail-badge {
  font-family: var(--font-body);
  font-size: 9px;
  font-weight: 500;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  padding: 5px 12px;
  border-radius: var(--radius-toggles);
  background: rgba(225,6,0,.15);
  color: var(--color-impossible-red);
  border: 1px solid rgba(225,6,0,.25);
}

/* ════════════════════════════════════════
   ADD TO CART BUTTON — filled red, 15px radius
════════════════════════════════════════ */
.cart-form { margin-top: auto; }
.cart-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  width: 100%;
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  font-family: var(--font-body);
  font-size: var(--text-caption);
  font-weight: 500;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  padding: 12px 20px;
  border: 1px solid var(--color-impossible-red);
  border-radius: var(--radius-buttons);
  cursor: pointer;
  transition: background 0.22s, gap 0.2s, border-color 0.22s;
}
.cart-btn:hover {
  background: #c00400;
  border-color: #c00400;
  gap: 14px;
}
.cart-btn:active { transform: scale(0.97); }
.cart-btn .icon { font-size: 14px; line-height: 1; }

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
  .menu-section { padding: 30px 20px 60px; }
  .nav { padding: 0 20px; }
  .menu-grid { grid-template-columns: repeat(auto-fill, minmax(250px, 1fr)); gap: 20px; }
  .footer { padding: 48px 24px 32px; }
}
@media (max-width: 600px) {
  .footer-inner { flex-direction: column; align-items: center; text-align: center; gap: 20px; }
}
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
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
</nav>

<!-- ══════════════════════════════════════
     HERO — display headline
══════════════════════════════════════ -->
<section class="hero">
  <div class="hero-wm" aria-hidden="true">MENU</div>

  <div class="hero-left">
    <p class="hero-eyebrow">◂ Explore our kitchen ▸</p>
    <div class="hero-word">DISCOVER</div>
    <div class="hero-word">THE MENU</div>
    <div class="hero-word">(CRAVE MORE)</div>
    <p class="hero-tagline">
      Every dish tells a story. Browse our curated menu
      and find something new to crave.
    </p>
    <p class="hero-hashtag">#TasteTheCity</p>
  </div>

  <div class="hero-right">
    <div class="big-emoji">🍽️</div>
  </div>
</section>

<!-- ticker -->
<div class="tk"><div class="tk-t" id="tk1"></div></div>

<!-- ══════════════════════════════════════
     MENU GRID SECTION
══════════════════════════════════════ -->
<section class="menu-section">

  <p class="sec-bracket scroll-3d">Available dishes</p>

  <div class="menu-grid">

  <% List<Menu> menuList = (List<Menu>)request.getAttribute("menuList");
     for(Menu m : menuList){
  %>

    <div class="menu-card scroll-3d">
      <img src="assets/<%= m.getImages() %>" alt="<%= m.getItemName() %>" class="menu-card-img">
      <div class="menu-card-body">
        <h2 class="menu-card-name"><%= m.getItemName() %></h2>
        <p class="menu-card-desc"><%= m.getDescription() %></p>
        <div class="menu-card-meta">
          <span class="menu-card-price">₹ <%= m.getPrice() %></span>
          <span class="avail-badge"><%= m.getIsAvailable() %></span>
        </div>
        <form action="callCartServlet" class="cart-form">
          <input type="hidden" name="menuId" value="<%= m.getMenuId() %>">
          <input type="hidden" name="restaurantId" value="<%= m.getRestaurantId() %>">
          <input type="hidden" name="quantity" value="1">
          <input type="hidden" name="action" value="add">
          <button class="cart-btn"><span class="icon">+</span> Add to Cart</button>
        </form>
      </div>
    </div>

  <%
     }
  %>

  </div>
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
  'Fresh Ingredients', 'Chef Curated', 'Made to Order',
  'Fast Delivery', 'Taste the City', 'Flavora',
  'Fresh Ingredients', 'Chef Curated', 'Made to Order',
  'Fast Delivery', 'Taste the City', 'Flavora'
]);

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

  document.querySelectorAll('a, button, .cart-btn, .btnn, .menu-card').forEach(el => {
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
document.querySelectorAll('.scroll-3d').forEach(el => {
  const rect = el.getBoundingClientRect();
  if (rect.top < window.innerHeight - 40) {
    el.classList.add('vis');
  }
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
    if (target) { e.preventDefault(); target.scrollIntoView({ behavior: 'smooth' }); }
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