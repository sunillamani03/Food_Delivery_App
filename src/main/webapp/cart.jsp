<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import= "com.tap.model.Cart" %>
<%@ page import= "com.tap.model.CartItems" %>
<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Cart — Flavora</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400&display=swap" rel="stylesheet">

<style>
:root {
  --color-velvet-wine: #260212;
  --color-burgundy-stage: #4f0423;
  --color-impossible-red: #e10600;
  --color-blush-highlight: #ffc7c6;
  --color-butcher-black: #000000;
  --color-bone-white: #ffffff;

  --font-display: 'Bebas Neue', sans-serif;
  --font-body: 'Inter', sans-serif;

  --radius-nav: 15px;
  --radius-cards: 12px;
  --radius-buttons: 15px;
  --radius-toggles: 15px;
  --radius-feature-cards: 38px;
}
*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }
html { scroll-behavior: smooth; }
body {
  font-family: var(--font-body);
  background: var(--color-velvet-wine);
  color: var(--color-bone-white);
  overflow-x: hidden;
  cursor: default;
}
a { text-decoration: none; color: inherit; }

/* scroll progress */
.scroll-progress {
  position: fixed; top: 0; left: 0;
  height: 3px;
  background: linear-gradient(90deg, var(--color-impossible-red), var(--color-blush-highlight));
  z-index: 10001;
  width: 0%;
  transition: width 0.1s linear;
}

/* custom cursor */
.cursor-dot {
  width: 8px; height: 8px;
  background: var(--color-impossible-red);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none;
  z-index: 9999;
  transform: translate(-50%,-50%);
  transition: transform 0.1s ease;
}
.cursor-ring {
  width: 36px; height: 36px;
  border: 1.5px solid var(--color-impossible-red);
  border-radius: 50%;
  position: fixed; top: 0; left: 0;
  pointer-events: none;
  z-index: 9998;
  transform: translate(-50%,-50%);
  transition: transform 0.12s ease, width 0.2s ease, height 0.2s ease, opacity 0.2s ease;
}

/* nav */
.nav {
  position: fixed; top: 0; left: 0; right: 0;
  z-index: 1000;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 40px;
  height: 68px;
  background: var(--color-butcher-black);
  border-bottom: 1px solid rgba(255,255,255,0.08);
  transition: background 0.4s;
}
.nav-logo {
  font-family: var(--font-display);
  font-size: 26px;
  letter-spacing: 0.06em;
  color: var(--color-impossible-red);
  line-height: 1;
}
.nav-logo span {
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  display: block;
  color: var(--color-blush-highlight);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  margin-top: 2px;
}
.nav-links { display: flex; align-items: center; gap: 8px; }
.nav-links .btnn {
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  color: var(--color-bone-white);
  padding: 10px 16px;
  border-radius: var(--radius-nav);
  border: 1px solid transparent;
  transition: all 0.22s ease;
}
.nav-links .btnn:hover { border-color: var(--color-impossible-red); color: var(--color-impossible-red); }
.nav-links .btnn.primary { background: var(--color-impossible-red); color: var(--color-bone-white); border-color: var(--color-impossible-red); }
.nav-links .btnn.primary:hover { background: #c00500; border-color: #c00500; color: var(--color-bone-white); }

/* hero */
.hero {
  min-height: 40vh;
  background: var(--color-velvet-wine);
  display: flex;
  align-items: center;
  justify-content: center;
  position: relative;
  overflow: hidden;
  padding-top: 68px;
}
.hero-stack {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  position: relative;
  z-index: 2;
  padding: 40px 24px;
}
.hero-eyebrow {
  font-family: var(--font-body);
  font-size: 14px;
  font-weight: 500;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  color: var(--color-impossible-red);
  opacity: 0;
  animation: wordReveal 0.8s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-word {
  font-family: var(--font-display);
  font-size: clamp(80px, 12vw, 160px);
  line-height: 0.73;
  letter-spacing: 0.06em;
  color: var(--color-impossible-red);
  opacity: 0;
  transform: translateY(60px);
  animation: wordReveal 0.9s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-word:nth-child(2) { animation-delay: 0.15s; }
@keyframes wordReveal {
  to { opacity: 1; transform: translateY(0); }
}
.hero-tagline {
  font-family: var(--font-body);
  font-size: 14px;
  line-height: 1.7;
  color: var(--color-blush-highlight);
  max-width: 380px;
  margin-top: 16px;
  opacity: 0;
  animation: wordReveal 0.8s 0.4s cubic-bezier(0.16,1,0.3,1) forwards;
}
.hero-blob {
  position: absolute;
  right: 6%;
  top: 20%;
  font-size: clamp(70px, 10vw, 130px);
  animation: float 4s ease-in-out infinite;
  border-radius: 68% 32% 58% 42% / 45% 55% 45% 55%;
  background: var(--color-burgundy-stage);
  width: 220px; height: 220px;
  display: flex; align-items: center; justify-content: center;
  z-index: 1;
}
@keyframes float {
  0%,100% { transform: translateY(0) rotate(-3deg); }
  50%      { transform: translateY(-18px) rotate(3deg); }
}

/* 3D reveal */
.scroll-3d {
  opacity: 1;
  transform: perspective(1200px) translateY(50px) rotateX(8deg);
  transform-origin: center top;
  will-change: transform, opacity;
  transition: opacity 0.8s cubic-bezier(0.16,1,0.3,1),
              transform 1s cubic-bezier(0.16,1,0.3,1);
}
.scroll-3d.vis {
  opacity: 1;
  transform: perspective(1200px) translateY(0) rotateX(0);
}

/* cart section */
.cart-section {
  padding: 30px 48px 60px;
  max-width: 900px;
  margin: 0 auto;
}

/* cart card */
.cart-card {
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
  overflow: hidden;
}

/* cart header row */
.cart-header {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1.2fr 0.8fr;
  align-items: center;
  padding: 14px 24px;
  background: var(--color-butcher-black);
  color: var(--color-blush-highlight);
  font-size: 9px;
  font-weight: 600;
  letter-spacing: 0.2em;
  text-transform: uppercase;
}

/* cart item row */
.cart-row {
  display: grid;
  grid-template-columns: 2fr 1fr 1fr 1.2fr 0.8fr;
  align-items: center;
  padding: 16px 24px;
  border-bottom: 1px solid rgba(255,255,255,0.08);
  transition: background 0.2s;
}
.cart-row:last-child { border-bottom: none; }
.cart-row:hover { background: rgba(225,6,0,0.06); }
.cart-row.grand-total {
  background: var(--color-butcher-black);
  color: var(--color-bone-white);
  border-bottom: none;
}
.cart-row.grand-total:hover { background: var(--color-butcher-black); }

/* item name */
.cart-item-name {
  font-family: var(--font-display);
  font-size: 22px;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  color: var(--color-blush-highlight);
  line-height: 1.1;
}
.cart-cell {
  font-family: var(--font-body);
  font-size: 13px;
  color: var(--color-bone-white);
}
.cart-cell.price {
  font-weight: 500;
}
.cart-cell.total {
  font-weight: 600;
  font-size: 14px;
}
.cart-cell.grand {
  font-family: var(--font-display);
  font-size: 24px;
  letter-spacing: 0.03em;
  color: var(--color-impossible-red);
}

/* quantity controls */
.qty-wrap {
  display: flex;
  align-items: center;
  gap: 10px;
}
.qty-btn {
  width: 30px; height: 30px;
  border-radius: 50%;
  border: 1.5px solid var(--color-impossible-red);
  background: transparent;
  color: var(--color-impossible-red);
  font-size: 15px;
  font-weight: 500;
  display: flex;
  align-items: center;
  justify-content: center;
  cursor: pointer;
  transition: all 0.2s;
}
.qty-btn:hover {
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
}
.qty-btn:active { transform: scale(0.9); }
.qty-number {
  font-family: var(--font-body);
  font-size: 15px;
  font-weight: 600;
  color: var(--color-bone-white);
  min-width: 20px;
  text-align: center;
}

/* remove */
.remove-btn {
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 500;
  letter-spacing: 0.1em;
  text-transform: uppercase;
  color: rgba(255,255,255,0.4);
  background: none;
  border: none;
  cursor: pointer;
  padding: 6px 0;
  transition: color 0.2s;
}
.remove-btn:hover { color: var(--color-impossible-red); }

/* cart actions */
.cart-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 30px;
  gap: 16px;
  flex-wrap: wrap;
}
.cart-action-btn {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-family: var(--font-body);
  font-size: 14px;
  font-weight: 500;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  padding: 10px 14px;
  border-radius: var(--radius-buttons);
  transition: all 0.25s;
  cursor: pointer;
}
.cart-action-btn.ghost {
  color: var(--color-bone-white);
  border: 1px solid var(--color-bone-white);
  background: transparent;
}
.cart-action-btn.ghost:hover {
  border-color: var(--color-impossible-red);
  color: var(--color-impossible-red);
  gap: 12px;
}
.cart-action-btn.primary {
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  border: 1px solid var(--color-impossible-red);
}
.cart-action-btn.primary:hover {
  background: #c00500;
  border-color: #c00500;
  gap: 12px;
}

/* empty state */
.empty-state {
  max-width: 500px;
  margin: 0 auto;
  text-align: center;
  padding: 80px 40px;
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-feature-cards);
}
.empty-emoji { font-size: 60px; margin-bottom: 20px; }
.empty-state h3 {
  font-family: var(--font-display);
  font-size: 48px;
  color: var(--color-impossible-red);
  letter-spacing: 0.03em;
  line-height: 0.9;
  margin-bottom: 10px;
}
.empty-state p {
  font-family: var(--font-body);
  font-size: 14px;
  color: var(--color-blush-highlight);
  margin-bottom: 30px;
}
.empty-state .back-btn {
  display: inline-flex;
  align-items: center;
  gap: 10px;
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  font-family: var(--font-body);
  font-size: 14px;
  font-weight: 500;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  padding: 10px 14px;
  border-radius: var(--radius-buttons);
  transition: background 0.25s, gap 0.2s;
}
.empty-state .back-btn:hover { background: #c00500; gap: 16px; }

/* footer */
.footer {
  background: var(--color-butcher-black);
  padding: 60px 48px 40px;
  position: relative;
  overflow: hidden;
}
.footer-bg-word {
  position: absolute;
  font-family: var(--font-display);
  font-size: clamp(80px, 14vw, 180px);
  color: rgba(225,6,0,0.06);
  bottom: -10px; left: 0; right: 0;
  text-align: center;
  letter-spacing: 0.06em;
  pointer-events: none;
}
.footer-inner {
  max-width: 1200px;
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: flex-end;
  flex-wrap: wrap;
  gap: 30px;
  position: relative;
  z-index: 1;
}
.footer-logo {
  font-family: var(--font-display);
  font-size: 48px;
  letter-spacing: 0.06em;
  color: var(--color-impossible-red);
  line-height: 0.9;
}
.footer-logo span {
  display: block;
  font-family: var(--font-body);
  font-size: 13px;
  font-weight: 500;
  color: var(--color-blush-highlight);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  margin-top: 6px;
}
.footer-copy {
  font-family: var(--font-body);
  font-size: 11px;
  letter-spacing: 0.1em;
  color: rgba(255,255,255,0.4);
  text-transform: uppercase;
}
.footer-top-link {
  display: inline-flex;
  align-items: center;
  gap: 8px;
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  color: var(--color-bone-white);
  border: 1px solid rgba(255,255,255,0.3);
  padding: 10px 22px;
  border-radius: var(--radius-buttons);
  transition: all 0.25s;
}
.footer-top-link:hover { background: var(--color-impossible-red); color: var(--color-bone-white); border-color: var(--color-impossible-red); }

/* hr hidden */
.hr { display: none; }

/* responsive */
@media (max-width: 768px) {
  .cart-header, .cart-row {
    grid-template-columns: 1.5fr 1fr 1fr 1fr 0.7fr;
    padding: 12px 16px;
    gap: 4px;
  }
  .cart-item-name { font-size: 18px; }
  .cart-section { padding: 20px 16px 50px; }
  .hero { min-height: 32vh; }
  .hero-blob { display: none; }
  .nav { padding: 0 20px; }
  .cart-actions { flex-direction: column; align-items: stretch; }
  .cart-action-btn { justify-content: center; }
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

<!-- nav -->
<nav class="nav" id="mainNav">
  <a href="restaurantServlet" class="nav-logo">
    FLAVORA
    <span>Fine Food Delivery</span>
  </a>
  <div class="nav-links buttons">
    <a href="callOrderHistoryServlet" class="btnn">Order History</a>
    <a href="cart.jsp"                class="btnn primary">Cart</a>
    <a href="register.html"           class="btnn">Sign Up</a>
    <a href="login.jsp"              class="btnn">Login</a>
  </div>
</nav>

<!-- hero -->
<section class="hero">
  <div class="hero-stack">
    <div class="hero-eyebrow">◂ Review Order ▸</div>
    <div class="hero-word">YOUR CART</div>
    <p class="hero-tagline">
      Review your selections, adjust quantities, and proceed when you're ready.
    </p>
  </div>
  <div class="hero-blob">🛒</div>
</section>

<section class="cart-section">

<%
  Cart cart = (Cart)session.getAttribute("cart");
  Integer restaurantId = (Integer)session.getAttribute("oldRestaurantId");

  double grandTotal = 0;
  if(cart != null && !cart.getItems().isEmpty()){
%>

<div class="cart-card scroll-3d">
  <div class="cart-header">
    <span>Item</span>
    <span>Price</span>
    <span>Total</span>
    <span>Quantity</span>
    <span>Action</span>
  </div>

<%
  for(CartItems item : cart.getItems().values()){
    grandTotal = grandTotal + item.getTotalPrice();
%>

  <div class="cart-row">
    <div class="cart-item-name"><%= item.getName() %></div>
    <div class="cart-cell price">₹ <%= item.getPrice() %></div>
    <div class="cart-cell total">₹ <%= item.getTotalPrice() %></div>
    <div class="qty-wrap">
      <form action="callCartServlet" style="display:inline;">
        <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
        <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
        <% if(item.getQuantity() - 1 <= 0) { %>
          <input type="hidden" name="action" value="remove">
        <% } else { %>
          <input type="hidden" name="action" value="update">
          <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
        <% } %>
        <button class="qty-btn" type="submit">−</button>
      </form>
      <span class="qty-number"><%= item.getQuantity() %></span>
      <form action="callCartServlet" style="display:inline;">
        <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
        <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
        <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
        <input type="hidden" name="action" value="update">
        <button class="qty-btn" type="submit">+</button>
      </form>
    </div>
    <form action="callCartServlet" style="display:inline;">
      <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
      <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
      <input type="hidden" name="action" value="remove">
      <button class="remove-btn" type="submit">✕ Remove</button>
    </form>
  </div>

<%
  }
%>

  <div class="cart-row grand-total">
    <div style="font-family:var(--font-body);font-size:12px;font-weight:600;letter-spacing:0.12em;text-transform:uppercase;color:rgba(255,255,255,0.5);">Grand Total</div>
    <div></div>
    <div></div>
    <div></div>
    <%
	session.setAttribute("finalAmount", grandTotal);
	%>
    <div class="cart-cell grand">₹ <%= grandTotal %>/-</div>
  </div>
</div>

<div class="cart-actions">
  <a class="cart-action-btn ghost" href="callMenuServlet?restaurantId=<%= restaurantId %>">
    <span>← Add more items</span>
  </a>
  <a class="cart-action-btn primary" href="checkout.jsp">
    <span>Proceed to Checkout →</span>
  </a>
</div>

<%
  } else {
%>

<div class="empty-state scroll-3d">
  <div class="empty-emoji">📭</div>
  <h3>Your Cart is Empty</h3>
  <p>Please add some food items from the menu to get started.</p>
  <a href="restaurantServlet" class="back-btn">
    <span>Go To Restaurant →</span>
  </a>
</div>

<%
  }
%>

</section>

<!-- footer -->
<footer class="footer">
  <div class="footer-bg-word">FLAVORA</div>
  <div class="footer-inner">
    <div class="footer-logo">
      FLAVORA
      <span>Fine Food Delivery</span>
    </div>
    <div style="text-align:right;">
      <p class="footer-copy" style="margin-bottom:16px;">© 2026 Flavora. All rights reserved.</p>
      <a href="#" class="footer-top-link">Back to top ↑</a>
    </div>
  </div>
</footer>

<script>
/* custom cursor */
const dot  = document.getElementById('cDot');
const ring = document.getElementById('cRing');
let mx = 0, my = 0, rx = 0, ry = 0;
document.addEventListener('mousemove', e => { mx = e.clientX; my = e.clientY; });
(function animCursor() {
  rx += (mx - rx) * 0.12;
  ry += (my - ry) * 0.12;
  dot.style.left  = mx + 'px';
  dot.style.top   = my + 'px';
  ring.style.left = rx + 'px';
  ring.style.top  = ry + 'px';
  requestAnimationFrame(animCursor);
})();
document.querySelectorAll('a, button, .qty-btn, .remove-btn, .cart-action-btn, .back-btn').forEach(el => {
  el.addEventListener('mouseenter', () => {
    ring.style.width = '56px'; ring.style.height = '56px'; ring.style.opacity = '0.5';
  });
  el.addEventListener('mouseleave', () => {
    ring.style.width = '36px'; ring.style.height = '36px'; ring.style.opacity = '1';
  });
});

/* nav dark toggle (retained for parity; nav is always dark now) */
const nav = document.getElementById('mainNav');
window.addEventListener('scroll', () => {
  nav.classList.toggle('dark-bg', window.scrollY > window.innerHeight - 80);
}, { passive: true });

/* scroll progress */
const progressBar = document.getElementById('scrollProgress');
window.addEventListener('scroll', () => {
  const scrollTop = window.scrollY;
  const docHeight = document.documentElement.scrollHeight - window.innerHeight;
  const pct = docHeight > 0 ? (scrollTop / docHeight) * 100 : 0;
  progressBar.style.width = pct + '%';
}, { passive: true });

/* 3D scroll reveal */
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
</script>

</body>
</html>