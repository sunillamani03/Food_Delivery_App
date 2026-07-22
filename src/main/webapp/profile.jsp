<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Profile — Flavora</title>

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
  line-height: 1;
  text-transform: uppercase;
}
.nav-logo span {
  display: block;
  font-family: var(--font-body);
  font-size: 9px;
  font-weight: 400;
  color: rgba(255,199,198,.55);
  letter-spacing: 0.12em;
  text-transform: uppercase;
  margin-top: 2px;
}
.nav-links { display: flex; align-items: center; gap: 4px; }
.nav-links .btnn {
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
  padding: 8px; z-index: 10001;
  flex-direction: column; gap: 5px;
}
.hamburger span {
  display: block; width: 22px; height: 1.5px;
  background: var(--color-bone-white); border-radius: 2px;
  transition: all 0.3s ease;
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
  transition: opacity 0.35s ease;
}
.mobile-menu.open { opacity: 1; pointer-events: auto; }
.mobile-menu .btnn {
  font-family: var(--font-body);
  font-size: var(--text-body-sm); font-weight: 500;
  letter-spacing: var(--tracking-label); text-transform: uppercase;
  color: rgba(255,255,255,.7);
  padding: 14px 28px; border-radius: var(--radius-buttons);
  border: 1.5px solid rgba(255,255,255,.12);
  transition: all 0.22s; cursor: pointer; background: none;
  text-decoration: none; display: block; text-align: center; min-width: 200px;
}
.mobile-menu .btnn.primary {
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  border-color: var(--color-impossible-red);
}
.mobile-menu .btnn:hover { border-color: var(--color-impossible-red); color: var(--color-impossible-red); }
.mobile-menu .btnn.primary:hover { background: #c00400; border-color: #c00400; }

@media (max-width: 767px) {
  .hamburger { display: flex; }
  .nav-links { display: none; }
  .mobile-menu { display: flex; }
}

/* ════════════════════════════════════════
   HERO — full bleed display text
════════════════════════════════════════ */
.hero {
  min-height: 100vh;
  background: var(--color-velvet-wine);
  display: grid;
  grid-template-columns: 1fr 1fr;
  position: relative;
  overflow: hidden;
  padding-top: var(--nav-h);
}

/* watermark ghost text */
.hero-wm {
  position: absolute; inset: 0;
  display: flex; align-items: center; justify-content: center;
  font-family: var(--font-display);
  font-size: clamp(80px, 20vw, 280px);
  color: rgba(79,4,35,.35);
  letter-spacing: 0.03em; text-transform: uppercase;
  pointer-events: none; white-space: nowrap;
  user-select: none;
}

.hero-left {
  display: flex;
  flex-direction: column;
  justify-content: center;
  padding: 0 48px 0 60px;
  position: relative; z-index: 2;
}
.hero-eyebrow {
  font-family: var(--font-body);
  font-size: var(--text-caption);
  font-weight: 500;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  color: var(--color-impossible-red);
  margin-bottom: 10px;
  opacity: 0;
  animation: riseUp 0.7s 0.1s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-word {
  font-family: var(--font-display);
  font-size: clamp(72px, 10vw, 140px);
  line-height: var(--leading-display);
  letter-spacing: var(--tracking-display);
  color: var(--color-impossible-red);
  text-transform: uppercase;
  opacity: 0;
  transform: translateY(60px);
  animation: riseUp 0.9s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-word:nth-child(2) { animation-delay: 0.15s; }
.hero-word:nth-child(3) {
  animation-delay: 0.30s;
  font-size: clamp(40px, 6vw, 80px);
  color: var(--color-blush-highlight);
}
@keyframes riseUp { to { opacity: 1; transform: translateY(0); } }

.hero-tagline {
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  line-height: 1.7;
  color: rgba(255,199,198,.55);
  max-width: 300px;
  margin-top: var(--spacing-24);
  opacity: 0;
  animation: riseUp 0.8s 0.5s cubic-bezier(0.16,1,0.3,1) forwards;
}

/* hero right — avatar panel */
.hero-right {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  gap: var(--spacing-20);
  padding: 40px;
  position: relative; z-index: 2;
  background: rgba(79,4,35,.2);
  border-left: 1px solid var(--color-butcher-black);
}

/* avatar initials circle */
.avatar {
  width: 156px; height: 156px;
  border-radius: 50%;
  background: var(--color-impossible-red);
  border: 2px solid var(--color-butcher-black);
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-display);
  font-size: 72px;
  color: var(--color-bone-white);
  animation: floatY 4.5s ease-in-out infinite;
  will-change: transform;
}
@keyframes floatY {
  0%,100% { transform: translateY(0); }
  50%     { transform: translateY(-16px); }
}

/* role badge — pill toggle style */
.role-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-family: var(--font-body);
  font-size: var(--text-caption);
  font-weight: 500;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  color: var(--color-bone-white);
  background: var(--color-impossible-red);
  border: 1px solid var(--color-butcher-black);
  padding: 8px 18px;
  border-radius: var(--radius-toggles);
}

.avatar-name {
  font-family: var(--font-display);
  font-size: 32px;
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  color: var(--color-blush-highlight);
  line-height: 1;
}

/* ════════════════════════════════════════
   PROFILE SECTION — form cards
════════════════════════════════════════ */
.profile-section {
  padding: var(--spacing-64) 48px var(--spacing-80);
  background: var(--color-velvet-wine);
  max-width: 900px;
  margin: 0 auto;
}

/* bracket section opener */
.sec-bracket {
  font-family: var(--font-body);
  font-size: var(--text-caption);
  font-weight: 500;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  color: var(--color-impossible-red);
  margin-bottom: var(--spacing-24);
  display: flex;
  align-items: center;
  gap: 10px;
}
.sec-bracket::before { content: '◂'; }
.sec-bracket::after  { content: '▸'; }

/* section card — burgundy surface, hairline border */
.section-card {
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
  padding: 36px 40px;
  margin-bottom: var(--spacing-24);
}
.section-card:last-child { margin-bottom: 0; }

.section-title {
  font-family: var(--font-display);
  font-size: 40px;
  line-height: var(--leading-heading);
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  color: var(--color-impossible-red);
  margin-bottom: var(--spacing-24);
  display: flex;
  align-items: center;
  gap: 10px;
}
.section-title .icon { font-size: 28px; font-style: normal; }

/* ════════════════════════════════════════
   FORM GRID — underline inputs, flat
════════════════════════════════════════ */
.form-grid {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: var(--spacing-20) var(--spacing-32);
}
.form-group { display: flex; flex-direction: column; gap: 6px; position: relative; }
.form-group.full-width { grid-column: 1 / -1; }

.form-group label {
  font-family: var(--font-body);
  font-size: var(--text-caption);
  font-weight: 500;
  letter-spacing: var(--tracking-label);
  text-transform: uppercase;
  color: rgba(255,199,198,.45);
  transition: color 0.25s;
}
.form-group:focus-within label { color: var(--color-impossible-red); }

.form-group input,
.form-group textarea {
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
  transition: background 0.25s, padding-left 0.25s, border-color 0.25s;
}
.form-group textarea {
  resize: vertical;
  min-height: 80px;
  border: 1px solid rgba(255,255,255,.1);
  border-radius: 6px;
  padding: 12px 14px;
  margin-top: 4px;
}
.form-group input::placeholder,
.form-group textarea::placeholder { color: rgba(255,199,198,.25); font-style: italic; }
.form-group:focus-within input {
  background: rgba(0,0,0,.35);
  padding-left: 14px;
  border-bottom-color: var(--color-impossible-red);
}
.form-group:focus-within textarea {
  background: rgba(0,0,0,.35);
  border-color: var(--color-impossible-red);
}

/* underline expand animation */
.form-group::after {
  content: '';
  position: absolute;
  bottom: 0; left: 50%;
  width: 0; height: 1.5px;
  background: var(--color-impossible-red);
  transition: width 0.35s cubic-bezier(0.16,1,0.3,1), left 0.35s cubic-bezier(0.16,1,0.3,1);
}
.form-group.full-width.has-textarea::after { display: none; }
.form-group:focus-within::after { width: 100%; left: 0; }

/* ════════════════════════════════════════
   PASSWORD WRAPPER
════════════════════════════════════════ */
.pwd-wrap { position: relative; }
.pwd-wrap input { padding-right: 44px; }
.pwd-toggle {
  position: absolute;
  right: 0; top: 50%;
  transform: translateY(-50%);
  background: none; border: none; cursor: pointer;
  font-size: 15px;
  color: rgba(255,199,198,.3);
  padding: 6px;
  transition: color 0.2s;
  line-height: 1;
}
.pwd-toggle:hover { color: var(--color-blush-highlight); }

/* ════════════════════════════════════════
   FORM ACTIONS — CTA pair
════════════════════════════════════════ */
.form-actions {
  margin-top: var(--spacing-32);
  display: flex;
  justify-content: flex-end;
  gap: 10px;
}
.submit-btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-family: var(--font-body);
  font-size: var(--text-body-sm);
  font-weight: 500;
  letter-spacing: var(--tracking-ui);
  text-transform: uppercase;
  color: var(--color-bone-white);
  background: var(--color-impossible-red);
  border: 1px solid var(--color-impossible-red);
  border-radius: var(--radius-buttons);
  padding: 12px 28px;
  cursor: pointer;
  transition: background 0.22s, border-color 0.22s, gap 0.2s;
}
.submit-btn:hover { background: #c00400; border-color: #c00400; gap: 12px; }
.submit-btn:active { transform: scale(0.98); }
.submit-btn svg {
  stroke: currentColor; fill: none; stroke-width: 2.4;
  transition: transform 0.2s;
}
.submit-btn:hover svg { transform: translateX(4px); }

/* ════════════════════════════════════════
   3D SCROLL REVEAL
════════════════════════════════════════ */
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
.delay-2 { transition-delay: 0.14s; }
.delay-3 { transition-delay: 0.22s; }

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
  text-align: center;
  letter-spacing: 0.06em;
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
  color: var(--color-impossible-red); text-transform: uppercase; line-height: 1;
}
.footer-logo span {
  display: block;
  font-family: var(--font-body); font-size: 11px; font-weight: 400;
  color: rgba(255,199,198,.45); letter-spacing: 0.08em;
  text-transform: uppercase; margin-top: 4px;
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
@media (max-width: 1023px) {
  .hero-left { padding: 0 32px 0 40px; }
  .profile-section { padding: 40px 24px 72px; }
  .section-card { padding: 28px 24px; }
  .nav { padding: 0 20px; }
  .footer { padding: 48px 24px 32px; }
}
@media (max-width: 767px) {
  .hero { grid-template-columns: 1fr; min-height: auto; }
  .hero-left { padding: 60px 24px 20px; }
  .hero-right {
    padding: 32px 24px 48px;
    border-left: none;
    border-top: 1px solid var(--color-butcher-black);
  }
  .avatar { width: 120px; height: 120px; font-size: 56px; }
  .hero-word { font-size: clamp(56px, 14vw, 100px); }
  .hero-word:nth-child(3) { font-size: clamp(36px, 8vw, 60px); }
  .profile-section { padding: 28px 16px 60px; }
  .section-card { padding: 24px 18px; }
  .section-title { font-size: 32px; }
  .form-grid { grid-template-columns: 1fr; }
  .form-actions { flex-direction: column; }
  .submit-btn { width: 100%; justify-content: center; }
  .footer-inner { flex-direction: column; align-items: center; text-align: center; gap: 20px; }
}
@media (max-width: 479px) {
  .hero-left { padding: 40px 16px 20px; }
  .hero-right { padding: 20px 16px 36px; }
  .section-card { padding: 18px 14px; }
  .section-title { font-size: 26px; }
  .nav { padding: 0 12px; }
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

<% User user = (User)request.getAttribute("user"); %>

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
    <a href="restaurantServlet"       class="btnn primary">Restaurants</a>
  </div>
  <button class="hamburger" id="hamburger" aria-label="Menu">
    <span></span><span></span><span></span>
  </button>
</nav>

<!-- mobile menu -->
<div class="mobile-menu" id="mobileMenu">
  <a href="callOrderHistoryServlet" class="btnn">Order History</a>
  <a href="cart.jsp"                class="btnn">Cart</a>
  <a href="restaurantServlet"       class="btnn primary">Restaurants</a>
</div>

<% if (user != null) { %>

<!-- ══════════════════════════════════════
     HERO — display headline + avatar
══════════════════════════════════════ -->
<section class="hero">
  <div class="hero-wm" aria-hidden="true">PROFILE</div>

  <div class="hero-left">
    <p class="hero-eyebrow">◂ Your account ▸</p>
    <div class="hero-word">MY</div>
    <div class="hero-word">PROFILE</div>
    <div class="hero-word">(STAY UPDATED)</div>
    <p class="hero-tagline">
      Manage your personal information and keep your account secure.
    </p>
  </div>

  <div class="hero-right">
    <div class="avatar">
      <%= user.getUserName() != null ? String.valueOf(user.getUserName().charAt(0)).toUpperCase() : "U" %>
    </div>
    <p class="avatar-name">
      <%= user.getUserName() != null ? user.getUserName() : "Member" %>
    </p>
    <span class="role-badge">
      ★ <%= user.getRole() != null ? user.getRole() : "Member" %>
    </span>
  </div>
</section>

<!-- ══════════════════════════════════════
     PROFILE FORM SECTION
══════════════════════════════════════ -->
<div class="profile-section">

  <p class="sec-bracket scroll-3d">Edit your details</p>

  <form action="callProfileServlet" method="post">

    <input type="hidden" name="userId"     value="<%= user.getUserId() %>">
    <input type="hidden" name="DBPassword" value="<%= user.getPassword() %>">

    <!-- ── Personal Information card ── -->
    <div class="section-card scroll-3d delay-1">
      <div class="section-title">
        <i class="icon">👤</i> Personal Information
      </div>
      <div class="form-grid">

        <div class="form-group">
          <label>Name</label>
          <input type="text" name="userName"
                 value="<%= user.getUserName() != null ? user.getUserName() : "" %>">
        </div>

        <div class="form-group">
          <label>Email</label>
          <input type="text" name="email"
                 value="<%= user.getEmail() != null ? user.getEmail() : "" %>">
        </div>

        <div class="form-group full-width has-textarea">
          <label>Address</label>
          <textarea name="address" rows="3"><%= user.getAddress() != null ? user.getAddress() : "" %></textarea>
        </div>

      </div>
    </div>

    <!-- ── Security / Password card ── -->
    <div class="section-card scroll-3d delay-2">
      <div class="section-title">
        <i class="icon">🔒</i> Security
      </div>
      <div class="form-grid">

        <div class="form-group full-width">
          <label>Old Password</label>
          <div class="pwd-wrap">
            <input type="password" name="oldPassword" id="oldPwd"
                   placeholder="Enter current password" required>
            <button type="button" class="pwd-toggle"
                    onclick="togglePwd('oldPwd', this)"
                    aria-label="Toggle visibility">👁</button>
          </div>
        </div>

        <div class="form-group full-width">
          <label>New Password</label>
          <div class="pwd-wrap">
            <input type="password" name="newPassword" id="newPwd"
                   placeholder="Enter new password" required>
            <button type="button" class="pwd-toggle"
                    onclick="togglePwd('newPwd', this)"
                    aria-label="Toggle visibility">👁</button>
          </div>
        </div>

      </div>
    </div>

    <!-- ── Submit ── -->
    <div class="form-actions scroll-3d delay-3">
      <button type="submit" class="submit-btn">
        Save Changes
        <svg width="14" height="14" viewBox="0 0 24 24">
          <path d="M5 12h14M12 5l7 7-7 7"/>
        </svg>
      </button>
    </div>

  </form>
</div>

<% } %>

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
   PASSWORD TOGGLE
═══════════════════════════════ */
function togglePwd(id, btn) {
  const field = document.getElementById(id);
  if (field.type === 'password') {
    field.type = 'text';
    btn.innerHTML = '🙈';
  } else {
    field.type = 'password';
    btn.innerHTML = '👁';
  }
}

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

  document.querySelectorAll('a, button, .section-card, input, textarea').forEach(el => {
    el.addEventListener('mouseenter', () => ring.classList.add('big'));
    el.addEventListener('mouseleave', () => ring.classList.remove('big'));
  });
}

/* ═══════════════════════════════
   SCROLL PROGRESS
═══════════════════════════════ */
const progressBar = document.getElementById('scrollProgress');
window.addEventListener('scroll', () => {
  const scrollTop  = window.scrollY;
  const docHeight  = document.documentElement.scrollHeight - window.innerHeight;
  const pct        = docHeight > 0 ? (scrollTop / docHeight) * 100 : 0;
  progressBar.style.width = pct + '%';
}, { passive: true });

/* ═══════════════════════════════
   3D SCROLL REVEAL
═══════════════════════════════ */
// Immediately reveal in-view elements
document.querySelectorAll('.scroll-3d').forEach(el => {
  const rect = el.getBoundingClientRect();
  if (rect.top < window.innerHeight - 40) el.classList.add('vis');
});

// Observe the rest
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