<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.Cart,com.tap.model.CartItems" %>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="icon" type="image/png"
      href="${pageContext.request.contextPath}/assets/favicon.png">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Checkout — Flavora</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Bebas+Neue&family=Inter:ital,wght@0,300;0,400;0,500;0,600;0,700;1,300;1,400&display=swap" rel="stylesheet">

<style>
:root {
  /* Impossible Foods token set */
  --color-velvet-wine: #260212;
  --color-burgundy-stage: #4f0423;
  --color-impossible-red: #e10600;
  --color-blush-highlight: #ffc7c6;
  --color-butcher-black: #000000;
  --color-bone-white: #ffffff;

  --font-display: 'Bebas Neue', sans-serif; /* sans-meat display substitute */
  --font-body: 'Inter', sans-serif;         /* sans-meat body/UI substitute */

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
  max-width: 360px;
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

/* checkout section */
.checkout-section {
  padding: 30px 48px 60px;
}
.checkout-wrapper {
  max-width: 1100px;
  margin: 0 auto;
  display: flex;
  gap: 24px;
  align-items: flex-start;
}

/* delivery form */
.checkout-box {
  flex: 2;
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  padding: 24px;
  border-radius: var(--radius-cards);
}
.section-title {
  font-family: var(--font-display);
  font-size: 32px;
  letter-spacing: 0.03em;
  color: var(--color-impossible-red);
  margin-bottom: 24px;
  padding-bottom: 10px;
  border-bottom: 1px solid var(--color-butcher-black);
}
.form-group { margin-bottom: 20px; }
.form-group label {
  display: block;
  font-family: var(--font-body);
  font-size: 10px;
  font-weight: 600;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  color: var(--color-blush-highlight);
  margin-bottom: 8px;
}
.input-wrap {
  position: relative;
}
.input-wrap input,
.input-wrap textarea,
.input-wrap select {
  width: 100%;
  padding: 12px 0;
  background: transparent;
  border: none;
  border-bottom: 1.5px solid rgba(255,255,255,0.18);
  outline: none;
  font-family: var(--font-body);
  font-size: 14px;
  color: var(--color-bone-white);
  transition: border-color 0.3s;
}
.input-wrap input::placeholder,
.input-wrap textarea::placeholder { color: rgba(255,199,198,0.45); }
.input-wrap textarea { resize: none; height: 100px; }
.input-wrap select {
  cursor: pointer;
  appearance: none;
  -webkit-appearance: none;
  padding-right: 20px;
  background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='10' height='6'%3E%3Cpath d='M0 0l5 6 5-6z' fill='%23ffc7c6'/%3E%3C/svg%3E") no-repeat right center;
}
.input-wrap select option { color: #000; }
.input-wrap input:focus,
.input-wrap textarea:focus,
.input-wrap select:focus {
  border-bottom-color: var(--color-impossible-red);
}
.input-wrap .underline {
  position: absolute;
  bottom: 0; left: 50%;
  height: 1.5px;
  width: 0;
  background: var(--color-impossible-red);
  transition: width 0.35s ease, left 0.35s ease;
}
.input-wrap input:focus ~ .underline,
.input-wrap textarea:focus ~ .underline,
.input-wrap select:focus ~ .underline {
  width: 100%;
  left: 0;
}

/* summary box */
.summary-box {
  flex: 1;
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-cards);
  padding: 24px;
  position: sticky;
  top: 90px;
}
.summary-box .section-title {
  font-size: 24px;
  margin-bottom: 20px;
}
.summary-item {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 12px 0;
  border-bottom: 1px solid rgba(255,255,255,0.08);
}
.summary-item:last-of-type { border-bottom: none; }
.summary-item .item-name {
  font-family: var(--font-display);
  font-size: 20px;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  color: var(--color-blush-highlight);
  flex: 2;
}
.summary-item .item-qty {
  font-family: var(--font-body);
  font-size: 12px;
  color: rgba(255,255,255,0.55);
  flex: 1;
  text-align: center;
}
.summary-item .item-total {
  font-family: var(--font-body);
  font-size: 13px;
  font-weight: 600;
  color: var(--color-bone-white);
  flex: 1;
  text-align: right;
}

/* bill details */
.bill-details { margin-top: 20px; }
.bill-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px 0;
  font-family: var(--font-body);
  font-size: 13px;
  color: rgba(255,255,255,0.7);
}
.bill-row:last-child {
  border-top: 1px dashed rgba(255,255,255,0.2);
  margin-top: 14px;
  padding-top: 16px;
  font-family: var(--font-display);
  font-size: 24px;
  letter-spacing: 0.03em;
  color: var(--color-impossible-red);
}
.bill-row:last-child span:last-child {
  color: var(--color-impossible-red);
}

/* buttons */
.place-order-btn {
  width: 100%;
  margin-top: 24px;
  padding: 14px;
  background: var(--color-impossible-red);
  color: var(--color-bone-white);
  font-family: var(--font-body);
  font-size: 14px;
  font-weight: 500;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  border: none;
  border-radius: var(--radius-buttons);
  cursor: pointer;
  transition: background 0.25s, transform 0.2s;
}
.place-order-btn:hover {
  background: #c00500;
  transform: scale(1.02);
}
.place-order-btn:active { transform: scale(0.97); }
.back-cart-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 8px;
  margin-top: 12px;
  padding: 12px;
  font-family: var(--font-body);
  font-size: 11px;
  font-weight: 500;
  letter-spacing: 0.02em;
  text-transform: uppercase;
  color: var(--color-bone-white);
  border: 1px solid var(--color-bone-white);
  border-radius: var(--radius-buttons);
  transition: all 0.25s;
}
.back-cart-btn:hover {
  border-color: var(--color-impossible-red);
  color: var(--color-impossible-red);
  gap: 12px;
}

/* empty state */
.empty-checkout {
  max-width: 500px;
  margin: 80px auto;
  text-align: center;
  padding: 80px 40px;
  background: var(--color-burgundy-stage);
  border: 1px solid var(--color-butcher-black);
  border-radius: var(--radius-feature-cards);
}
.empty-checkout .empty-emoji { font-size: 60px; margin-bottom: 20px; }
.empty-checkout h3 {
  font-family: var(--font-display);
  font-size: 48px;
  color: var(--color-impossible-red);
  letter-spacing: 0.03em;
  line-height: 0.9;
  margin-bottom: 10px;
}
.empty-checkout p {
  font-family: var(--font-body);
  font-size: 14px;
  color: var(--color-blush-highlight);
  margin-bottom: 30px;
}
.empty-checkout .back-btn {
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
.empty-checkout .back-btn:hover { background: #c00500; gap: 16px; }

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

/* responsive */
@media (max-width: 900px) {
  .checkout-wrapper { flex-direction: column; }
  .summary-box { position: static; width: 100%; }
  .checkout-section { padding: 20px 20px 50px; }
  .hero { min-height: 32vh; }
  .hero-blob { display: none; }
  .nav { padding: 0 20px; }
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
    <a href="cart.jsp"                class="btnn">Cart</a>
    <a href="register.html"           class="btnn">Sign Up</a>
    <a href="login.jsp"              class="btnn primary">Login</a>
  </div>
</nav>

<!-- hero -->
<section class="hero">
  <div class="hero-stack">
    <div class="hero-eyebrow">◂ Final Step ▸</div>
    <div class="hero-word">CHECK OUT</div>
    <p class="hero-tagline">
      One last step. Confirm your details and place your order.
    </p>
  </div>
  <div class="hero-blob">🧾</div>
</section>

<section class="checkout-section">

<%
Cart cart = (Cart)session.getAttribute("cart");
Integer restaurantId = (Integer)session.getAttribute("oldRestaurantId");

double grandTotal = 0;
double deliveryFee = 40;
double platformFee = 5;

if(cart != null && !cart.getItems().isEmpty()){

  for(CartItems item : cart.getItems().values()){
    grandTotal += item.getTotalPrice();
  }

  double finalAmount = grandTotal + deliveryFee + platformFee;
%>

<form id="checkoutForm" action="checkout" method="post">
<div class="checkout-wrapper">

  <!-- delivery form -->
  <div class="checkout-box scroll-3d">
    <h2 class="section-title">Delivery Details</h2>

    <div class="form-group">
      <label>Full Name</label>
      <div class="input-wrap">
        <input type="text" name="customerName" placeholder="Enter Your Name" required>
        <span class="underline"></span>
      </div>
    </div>

    <div class="form-group">
      <label>Mobile Number</label>
      <div class="input-wrap">
        <input type="tel" name="mobileNumber" placeholder="Enter Mobile Number" pattern="[0-9]{10}" maxlength="10" required>
        <span class="underline"></span>
      </div>
    </div>

    <div class="form-group">
      <label>Delivery Address</label>
      <div class="input-wrap">
        <textarea name="address" placeholder="Enter Complete Address" required></textarea>
        <span class="underline"></span>
      </div>
    </div>

    <div class="form-group">
      <label>Payment Method</label>
      <div class="input-wrap">
        <select id="paymentMethod" name="paymentMethod" required>
          <option value="">Select Payment Method</option>
          <option value="cash">Cash On Delivery</option>
          <option value="upi">UPI</option>
          <option value="card">Credit Card</option>
          <option value="card">Debit Card</option>
        </select>
        <span class="underline"></span>
      </div>
    </div>
  </div>

  <!-- order summary -->
  <div class="summary-box scroll-3d">
    <h2 class="section-title">Order Summary</h2>

<%
  for(CartItems item : cart.getItems().values()){
%>

    <div class="summary-item">
      <span class="item-name"><%= item.getName() %></span>
      <span class="item-qty">x <%= item.getQuantity() %></span>
      <span class="item-total">₹ <%= item.getTotalPrice() %></span>
    </div>

<%
  }
%>

    <div class="bill-details">
      <div class="bill-row">
        <span>Item Total</span>
        <span>₹ <%= grandTotal %></span>
      </div>
      <div class="bill-row">
        <span>Delivery Fee</span>
        <span>₹ <%= deliveryFee %></span>
      </div>
      <div class="bill-row">
        <span>Platform Fee</span>
        <span>₹ <%= platformFee %></span>
      </div>
      <div class="bill-row">
        <span>Total Amount</span>
        <span>₹ <%= finalAmount %></span>
      </div>
    </div>

<%
  session.setAttribute("finalAmount", finalAmount);
%>

    <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
    <input type="hidden" name="totalAmount" value="<%= finalAmount %>">

    <button type="submit" id="placeOrderBtn" class="place-order-btn">Place Order</button>
    <a href="cart.jsp" class="back-cart-btn"><span>← Back to Cart</span></a>
  </div>

</div>
</form>

<%
} else {
%>

<div class="empty-checkout scroll-3d">
  <div class="empty-emoji">📭</div>
  <h3>Your Cart is Empty</h3>
  <p>Please add food items before checkout.</p>
  <a href="restaurantServlet" class="back-btn"><span>Browse Restaurants →</span></a>
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

<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

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
document.querySelectorAll('a, button, .place-order-btn, .back-cart-btn, .back-btn').forEach(el => {
  el.addEventListener('mouseenter', () => {
    ring.style.width = '56px'; ring.style.height = '56px'; ring.style.opacity = '0.5';
  });
  el.addEventListener('mouseleave', () => {
    ring.style.width = '36px'; ring.style.height = '36px'; ring.style.opacity = '1';
  });
});

/* nav dark toggle (no-op class retained for parity, nav is always dark now) */
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

//Razorpay Payment
// Razorpay Payment
let paymentCompleted = false;

document.getElementById("checkoutForm").addEventListener("submit", function(e){

    if(paymentCompleted){
        return;
    }

    let paymentMethod = document.getElementById("paymentMethod").value;

    // Cash On Delivery -> submit normally
    if(paymentMethod === "cash"){
        return;
    }

    // Prevent normal form submit
    e.preventDefault();

    fetch("<%=request.getContextPath()%>/createOrder",{
        method:"POST"
    })
    .then(response => response.json())
    .then(order => {

    console.log("Order Created");
    console.log(order);

    	var options = {

    		    prefill:{

    		        name: document.getElementsByName("customerName")[0].value,

    		        contact: document.getElementsByName("mobileNumber")[0].value

    		    },

    		    key: "rzp_test_TAXpOrET0Dniuz",

    		    amount: order.amount,

    		    currency: order.currency,

    		    name: "Flavora",

    		    description: "Food Order",

    		    order_id: order.id,

    		    theme:{
    		        color:"#e10600"
    		    },

    		    modal:{
    		        ondismiss:function(){
    		            console.log("Checkout Closed");
    		        }
    		    },

    		    handler:function(response){

    		        console.log("Payment Success");
    		        console.log(response);

    		        let paymentId=document.createElement("input");
    		        paymentId.type="hidden";
    		        paymentId.name="razorpayPaymentId";
    		        paymentId.value=response.razorpay_payment_id;
    		        document.getElementById("checkoutForm").appendChild(paymentId);

    		        let orderId=document.createElement("input");
    		        orderId.type="hidden";
    		        orderId.name="razorpayOrderId";
    		        orderId.value=response.razorpay_order_id;
    		        document.getElementById("checkoutForm").appendChild(orderId);

    		        let signature=document.createElement("input");
    		        signature.type="hidden";
    		        signature.name="razorpaySignature";
    		        signature.value=response.razorpay_signature;
    		        document.getElementById("checkoutForm").appendChild(signature);

    		        paymentCompleted = true;
    		        document.getElementById("checkoutForm").submit();
    		    }

    		};

        var rzp = new Razorpay(options);
        rzp.on('payment.failed', function (response){

            alert("Payment Failed!");

            console.log(JSON.stringify(response.error, null, 2));

        });
        rzp.open();

    });

});
</script>

</body>
</html>