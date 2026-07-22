<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login — Flavora</title>

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
  --text-caption:     10px;
  --text-body-sm:     14px;
  --text-body:        18px;
  --text-heading-lg:  103px;
  --text-display:     160px;

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
  --spacing-56:  56px;
  --spacing-64:  64px;

  /* Radius */
  --radius-buttons: 15px;
  --radius-cards:   12px;

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
   NAV — solid #000 bar
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
  margin-top: 2px; font-style: normal;
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
   HERO SPLIT
════════════════════════════════════════ */
.hero {
  min-height: 100vh;
  background: var(--color-velvet-wine);
  display: grid;
  grid-template-columns: 1fr 1fr;
  position: relative; overflow: hidden;
  padding-top: var(--nav-h);
}

.hero-left {
  display: flex; flex-direction: column;
  justify-content: center;
  padding: 0 48px 0 60px;
  position: relative; z-index: 2;
}
.hero-word {
  font-family: var(--font-display);
  font-size: clamp(80px, 10vw, 140px);
  line-height: var(--leading-display);
  letter-spacing: var(--tracking-display);
  color: var(--color-bone-white);
  text-transform: uppercase;
  opacity: 0; transform: translateY(60px);
  animation: wordReveal 0.9s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-word:nth-child(1) { animation-delay: 0.1s; }
.hero-word:nth-child(2) { animation-delay: 0.25s; color: var(--color-impossible-red); }
.hero-word:nth-child(3) { animation-delay: 0.4s; color: var(--color-blush-highlight); }

@keyframes wordReveal { to { opacity: 1; transform: translateY(0); } }

.hero-tagline {
  font-family: var(--font-body);
  font-size: var(--text-body-sm); line-height: 1.7;
  color: rgba(255,199,198,.55);
  max-width: 320px; margin-top: 28px;
  opacity: 0;
  animation: wordReveal 0.8s 0.55s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-hashtag {
  font-family: var(--font-body);
  font-size: var(--text-caption); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: var(--color-blush-highlight);
  margin-top: 14px;
  opacity: 0;
  animation: wordReveal 0.8s 0.7s cubic-bezier(0.16,1,0.3,1) forwards;
}

/* right */
.hero-right {
  display: flex; align-items: center; justify-content: center;
  padding: 40px; position: relative; z-index: 2;
}

/* 3D reveal */
.scroll-3d {
  opacity: 0;
  transform: perspective(1200px) translateY(40px) rotateX(6deg);
  transform-origin: center top;
  will-change: transform, opacity;
  transition: opacity 0.8s cubic-bezier(0.16,1,0.3,1),
              transform 1s cubic-bezier(0.16,1,0.3,1);
}
.scroll-3d.vis { opacity: 1; transform: perspective(1200px) translateY(0) rotateX(0); }
.delay-1 { transition-delay: 0.06s; }
.delay-2 { transition-delay: 0.12s; }
.delay-3 { transition-delay: 0.18s; }
.delay-4 { transition-delay: 0.24s; }

/* ════════════════════════════════════════
   LOGIN CARD — burgundy surface, flat
════════════════════════════════════════ */
.login-card {
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
  padding: 48px 40px 40px;
  width: 100%;
  max-width: 420px;
  position: relative;
  overflow: hidden;
  transform-style: preserve-3d;
}
.login-card h2 {
  font-family: var(--font-display);
  font-size: 56px;
  line-height: var(--leading-heading);
  letter-spacing: var(--tracking-heading-lg);
  color: var(--color-impossible-red);
  text-transform: uppercase;
  margin-bottom: 4px;
}
.login-card .card-sub {
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  font-weight: 500;
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  color: var(--color-blush-highlight);
  margin-bottom: 32px;
}

/* ════════════════════════════════════════
   INPUT GROUP — underline, flat
════════════════════════════════════════ */
.input-group {
  margin-bottom: 22px;
  position: relative;
}
.input-group label {
  display: block;
  font-family: var(--font-body);
  font-size: var(--text-caption);
  font-weight: 500;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  color: rgba(255,199,198,.45);
  margin-bottom: 6px;
  transition: color 0.3s;
}
.input-group:focus-within label { color: var(--color-impossible-red); }

.input-group input {
  width: 100%;
  background: rgba(0,0,0,.2);
  border: none;
  border-bottom: 1.5px solid rgba(255,255,255,.12);
  border-radius: 0;
  padding: 12px 16px 12px 0;
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  color: var(--color-bone-white);
  outline: none;
  transition: background 0.25s, padding 0.25s, border-color 0.25s;
}
.input-group input::placeholder { color: rgba(255,199,198,.25); font-style: italic; }
.input-group input:focus {
  background: rgba(0,0,0,.35);
  padding-left: 16px;
  border-bottom-color: var(--color-impossible-red);
}

/* underline animation */
.input-group::after {
  content: '';
  position: absolute;
  bottom: 0; left: 50%;
  width: 0; height: 1.5px;
  background: var(--color-impossible-red);
  transition: width 0.35s cubic-bezier(0.16,1,0.3,1), left 0.35s cubic-bezier(0.16,1,0.3,1);
}
.input-group:focus-within::after { width: 100%; left: 0; }

/* ════════════════════════════════════════
   PASSWORD TOGGLE
════════════════════════════════════════ */
.pw-wrap { position: relative; }
.pw-toggle {
  position: absolute; right: 0; top: 50%;
  transform: translateY(-50%);
  background: none; border: none; cursor: pointer;
  padding: 8px;
  color: rgba(255,199,198,.35);
  transition: color 0.25s;
  z-index: 2; line-height: 1;
}
.pw-toggle:hover { color: var(--color-blush-highlight); }
.pw-toggle svg { display: block; }

/* ════════════════════════════════════════
   SUBMIT BUTTON — impossible red fill
════════════════════════════════════════ */
.submit-btn {
  display: flex; align-items: center; justify-content: center; gap: 10px;
  width: 100%;
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  font-family: var(--font-body);
  font-size: var(--text-body-sm); font-weight: 500;
  letter-spacing: var(--tracking-ui); text-transform: uppercase;
  padding: 12px 20px;
  border: 1px solid var(--color-impossible-red);
  border-radius: var(--radius-buttons);
  cursor: pointer; overflow: hidden; position: relative;
  margin-top: 8px;
  transition: background 0.22s, gap 0.22s, border-color 0.22s;
}
.submit-btn:hover { background: #c00400; border-color: #c00400; gap: 14px; }
.submit-btn span { position: relative; z-index: 1; }
.submit-btn svg {
  position: relative; z-index: 1; transition: transform 0.22s;
  stroke: currentColor; fill: none; stroke-width: 2.4;
}
.submit-btn:hover svg { transform: translateX(4px); }
.submit-btn:active { transform: scale(0.98); }

/* loading state */
.submit-btn.loading {
  pointer-events: none;
  background: var(--color-butcher-black);
  border-color: var(--color-butcher-black);
}
.submit-btn.loading .btn-text { display: none; }
.submit-btn.loading .btn-load { display: flex; }
.btn-load { display: none; align-items: center; gap: 10px; position: relative; z-index: 1; }
.spinner {
  width: 14px; height: 14px;
  border: 2px solid rgba(255,255,255,.2);
  border-top-color: var(--color-bone-white);
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
}
@keyframes spin { to { transform: rotate(360deg); } }

/* ════════════════════════════════════════
   VALIDATION SHAKE
════════════════════════════════════════ */
.input-group.error input { border-bottom-color: #e53935; }
.input-group.error::after { background: #e53935; }
@keyframes shake {
  0%,100% { transform: translateX(0); }
  20%     { transform: translateX(-6px); }
  40%     { transform: translateX(6px); }
  60%     { transform: translateX(-4px); }
  80%     { transform: translateX(4px); }
}
.login-card.shake { animation: shake 0.4s ease; }

/* ════════════════════════════════════════
   LINKS
════════════════════════════════════════ */
.login-links {
  text-align: center;
  margin-top: 24px;
  font-family: var(--font-body);
  font-size: 12px;
  color: rgba(255,199,198,.4);
  display: flex; flex-direction: column; gap: 10px;
}
.login-links a {
  color: var(--color-blush-highlight);
  font-weight: 500;
  border-bottom: 1px solid transparent;
  transition: border-color 0.2s;
}
.login-links a:hover { border-bottom-color: var(--color-blush-highlight); }

/* ════════════════════════════════════════
   FOOTER
════════════════════════════════════════ */
.footer {
  background: var(--color-butcher-black);
  border-top: 1px solid rgba(255,255,255,.06);
  padding: 56px 48px 36px;
  position: relative; overflow: hidden;
}
.footer-bg-word {
  position: absolute;
  font-family: var(--font-display);
  font-size: clamp(80px, 14vw, 180px);
  color: rgba(255,255,255,.025);
  bottom: -12px; left: 0; right: 0;
  text-align: center; letter-spacing: 0.06em;
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
  font-size: 38px; letter-spacing: 0.08em;
  color: var(--color-impossible-red);
  text-transform: uppercase; line-height: 1;
}
.footer-logo span {
  display: block;
  font-family: var(--font-body); font-size: 11px; font-weight: 400;
  color: rgba(255,199,198,.45); letter-spacing: 0.08em;
  text-transform: uppercase; margin-top: 4px; font-style: normal;
}
.footer-copy {
  font-family: var(--font-body); font-size: var(--text-caption);
  letter-spacing: 0.1em; text-transform: uppercase;
  color: rgba(255,255,255,.25);
}
.footer-top-link {
  display: inline-flex; align-items: center; gap: 7px;
  font-family: var(--font-body); font-size: var(--text-caption); font-weight: 500;
  letter-spacing: 0.16em; text-transform: uppercase;
  color: var(--color-blush-highlight);
  border: 1px solid rgba(255,199,198,.25);
  padding: 9px 20px; border-radius: var(--radius-buttons);
  transition: all 0.24s;
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
  .hero { grid-template-columns: 1fr; }
  .hero-left { padding: 80px 24px 20px; align-items: flex-start; text-align: left; }
  .hero-right { padding: 20px 24px 60px; }
  .login-card { max-width: 100%; }
  .hero-tagline { max-width: 100%; }
  .nav { padding: 0 20px; }
  .footer { padding: 48px 24px 32px; }
}
@media (max-width: 600px) {
  .hero-word { font-size: 64px; }
  .login-card { padding: 36px 24px 32px; }
  .login-card h2 { font-size: 42px; }
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
    <a href="register.html"           class="btnn primary">Sign Up</a>
  </div>
</nav>

<%
	String error = (String)request.getAttribute("error");

	if(error != null){
%>
	<script>
		alert("<%= error %>");
	</script>

<%
}
%>

<!-- ══════════════════════════════════════
     HERO SPLIT
══════════════════════════════════════ -->
<section class="hero">
  <div class="hero-left">
    <div class="hero-word">WELCOME</div>
    <div class="hero-word">BACK</div>
    <div class="hero-word">(GOOD)</div>
    <p class="hero-tagline">
      Sign in to continue your flavour journey — your favourite kitchens are waiting.
    </p>
    <p class="hero-hashtag">#TasteTheCity</p>
  </div>

  <div class="hero-right">
    <form action="callLoginServlet" method="post" class="login-card" id="loginCard" novalidate>
      <h2>LOGIN</h2>
      <p class="card-sub">Welcome back</p>

      <div class="input-group scroll-3d delay-1">
        <label>Username</label>
        <input type="text" name="userName" placeholder="Enter your username" required>
      </div>

      <div class="input-group scroll-3d delay-2">
        <label>Password</label>
        <div class="pw-wrap">
          <input type="password" name="password" id="pwInput" placeholder="Enter your password" required>
          <button type="button" class="pw-toggle" id="pwToggle" tabindex="-1" aria-label="Toggle password visibility">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
              <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z" id="eyePath"/>
              <circle cx="12" cy="12" r="3"/>
            </svg>
          </button>
        </div>
      </div>

      <button type="submit" class="submit-btn scroll-3d delay-3" id="submitBtn">
        <span class="btn-text">Sign In</span>
        <span class="btn-load"><span class="spinner"></span> Signing in...</span>
        <svg width="14" height="14" viewBox="0 0 24 24" class="btn-text">
          <path d="M5 12h14M12 5l7 7-7 7"/>
        </svg>
      </button>

      <div class="login-links scroll-3d delay-4">
        <a href="register.html">Don't have an account? Register</a>
      </div>
    </form>
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

  document.querySelectorAll('a, button, .submit-btn, input').forEach(el => {
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
const observer3d = new IntersectionObserver((entries) => {
  entries.forEach(e => {
    if (e.isIntersecting) {
      e.target.classList.add('vis');
      observer3d.unobserve(e.target);
    }
  });
}, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

document.querySelectorAll('.scroll-3d').forEach(el => observer3d.observe(el));

/* ═══════════════════════════════
   3D TILT ON CARD
═══════════════════════════════ */
const loginCard = document.querySelector('.login-card');
if (loginCard && !isTouch) {
  loginCard.style.transition = 'transform 0.08s ease-out';
  const heroRight = document.querySelector('.hero-right');

  heroRight.addEventListener('mousemove', e => {
    const rect = loginCard.getBoundingClientRect();
    const cx = rect.left + rect.width / 2;
    const cy = rect.top + rect.height / 2;
    const dx = (e.clientX - cx) / rect.width;
    const dy = (e.clientY - cy) / rect.height;
    loginCard.style.transform =
      `perspective(1000px) rotateX(${dy * -3}deg) rotateY(${dx * 3}deg)`;
  });
  heroRight.addEventListener('mouseleave', () => {
    loginCard.style.transform = 'perspective(1000px) rotateX(0) rotateY(0)';
    loginCard.style.transition = 'transform 0.5s cubic-bezier(0.16,1,0.3,1)';
  });
  heroRight.addEventListener('mouseenter', () => {
    loginCard.style.transition = 'transform 0.08s ease-out';
  });
}

/* ═══════════════════════════════
   PASSWORD VISIBILITY TOGGLE
═══════════════════════════════ */
const pwInput  = document.getElementById('pwInput');
const pwToggle = document.getElementById('pwToggle');
if (pwToggle && pwInput) {
  pwToggle.addEventListener('click', () => {
    const isPassword = pwInput.type === 'password';
    pwInput.type = isPassword ? 'text' : 'password';
    pwToggle.innerHTML = isPassword
      ? `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
          <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94"/>
          <path d="M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19"/>
          <line x1="1" y1="1" x2="23" y2="23"/>
          <path d="M14.12 14.12a3 3 0 1 1-4.24-4.24"/>
        </svg>`
      : `<svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8">
          <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"/>
          <circle cx="12" cy="12" r="3"/>
        </svg>`;
  });
}

/* ═══════════════════════════════
   SUBMIT LOADING + VALIDATION
═══════════════════════════════ */
const form      = document.querySelector('.login-card');
const submitBtn = document.getElementById('submitBtn');

if (form) {
  form.addEventListener('submit', function(e) {
    const inputs = form.querySelectorAll('input');
    let valid = true;

    inputs.forEach(inp => {
      const group = inp.closest('.input-group');
      if (group) group.classList.remove('error');
      if (inp.hasAttribute('required') && !inp.value.trim()) {
        valid = false;
        if (group) group.classList.add('error');
      }
    });

    if (!valid) {
      e.preventDefault();
      form.classList.remove('shake');
      void form.offsetWidth;
      form.classList.add('shake');
      return;
    }

    if (submitBtn) {
      submitBtn.classList.add('loading');
      setTimeout(() => { submitBtn.classList.remove('loading'); }, 3000);
    }
  });

  form.querySelectorAll('input').forEach(inp => {
    inp.addEventListener('input', () => {
      const group = inp.closest('.input-group');
      if (group) group.classList.remove('error');
    });
  });
}

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