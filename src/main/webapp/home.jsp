<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.tap.model.cart"%>
<%@ page import="com.tap.model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Foodie - Online Food Delivery</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;scroll-behavior:smooth;}
body{background:#f8f9fa;overflow-x:hidden;}
.navbar{height:80px;padding:0 70px;display:flex;justify-content:space-between;align-items:center;background:rgba(255,255,255,.92);backdrop-filter:blur(20px);-webkit-backdrop-filter:blur(20px);box-shadow:0 10px 30px rgba(0,0,0,.06);position:sticky;top:0;z-index:999;transition:.3s;}
.logo{font-size:34px;font-weight:800;color:#ff6b35;display:flex;align-items:center;gap:6px;letter-spacing:-.5px;}
.logo span{background:linear-gradient(135deg,#ff6b35,#ff914d);-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
.nav-links{display:flex;gap:35px;}
.nav-links a{text-decoration:none;color:#555;font-size:16px;font-weight:500;transition:.3s;position:relative;}
.nav-links a::after{content:'';position:absolute;bottom:-4px;left:0;width:0;height:2.5px;background:#ff6b35;border-radius:4px;transition:.3s;}
.nav-links a:hover{color:#ff6b35;}
.nav-links a:hover::after{width:100%;}
.auth-btns{display:flex;gap:12px;}
.auth-btns a{text-decoration:none;padding:11px 24px;border-radius:50px;font-size:15px;font-weight:600;transition:.4s;}
.auth-btns .login-btn{color:#ff6b35;border:2px solid #ff6b35;background:transparent;}
.auth-btns .login-btn:hover{background:#ff6b35;color:white;transform:translateY(-2px);box-shadow:0 8px 20px rgba(255,107,53,.25);}
.auth-btns .register-btn{background:linear-gradient(135deg,#ff6b35,#ff914d);color:white;border:2px solid transparent;}
.auth-btns .register-btn:hover{transform:translateY(-2px);box-shadow:0 8px 25px rgba(255,107,53,.35);}
.auth-btns .logout-btn{text-decoration:none;padding:11px 24px;border-radius:50px;font-size:15px;font-weight:600;color:#e74c3c;border:2px solid #e74c3c;background:transparent;transition:.4s;}
.auth-btns .logout-btn:hover{background:#e74c3c;color:white;transform:translateY(-2px);box-shadow:0 8px 20px rgba(231,76,60,.25);}
.hero{min-height:92vh;background:linear-gradient(135deg,rgba(255,107,53,.94),rgba(255,159,28,.9)),url('<%=request.getContextPath()%>/images/banner.jpg');background-size:cover;background-position:center;display:flex;justify-content:center;align-items:center;text-align:center;color:white;position:relative;overflow:hidden;}
.hero::before{content:'';position:absolute;top:-20%;right:-10%;width:700px;height:700px;border-radius:50%;background:rgba(255,255,255,.06);animation:float 8s ease-in-out infinite;}
.hero::after{content:'';position:absolute;bottom:-25%;left:-5%;width:500px;height:500px;border-radius:50%;background:rgba(255,255,255,.04);animation:float 10s ease-in-out infinite reverse;}
@keyframes float{0%,100%{transform:translate(0,0);}50%{transform:translate(20px,-30px);}}
.hero-content{position:relative;z-index:1;max-width:820px;padding:20px;animation:fadeUp .9s ease;}
@keyframes fadeUp{from{opacity:0;transform:translateY(50px);}to{opacity:1;transform:translateY(0);}}
.hero-content h1{font-size:68px;font-weight:900;margin-bottom:16px;line-height:1.12;text-shadow:0 4px 25px rgba(0,0,0,.2);letter-spacing:-1px;}
.hero-content h1 span{background:linear-gradient(135deg,#ffe082,#ffcc00);-webkit-background-clip:text;-webkit-text-fill-color:transparent;}
.hero-content p{font-size:20px;margin-bottom:32px;opacity:.92;line-height:1.7;max-width:600px;margin-left:auto;margin-right:auto;}
.search-box{display:flex;justify-content:center;margin-bottom:28px;animation:fadeUp .9s ease .2s both;}
.search-box input{width:500px;padding:18px 28px;border:none;border-radius:50px 0 0 50px;font-size:16px;outline:none;box-shadow:0 8px 30px rgba(0,0,0,.12);}
.search-box input:focus{box-shadow:0 8px 40px rgba(0,0,0,.18);}
.search-box button{padding:18px 35px;background:#1a1a2e;border:none;color:white;border-radius:0 50px 50px 0;font-size:16px;font-weight:600;cursor:pointer;box-shadow:0 8px 30px rgba(0,0,0,.12);transition:.3s;}
.search-box button:hover{background:#2d2d4a;}
.hero-cta{margin-top:8px;animation:fadeUp .9s ease .4s both;}
.hero-cta a{display:inline-block;background:linear-gradient(135deg,#27ae60,#2ecc71);color:white;text-decoration:none;padding:17px 45px;border-radius:50px;font-size:19px;font-weight:700;transition:.4s;box-shadow:0 12px 35px rgba(39,174,96,.4);}
.hero-cta a:hover{transform:translateY(-5px);box-shadow:0 20px 50px rgba(39,174,96,.5);}
.hero-stats{display:flex;justify-content:center;gap:60px;margin-top:55px;flex-wrap:wrap;animation:fadeUp .9s ease .6s both;}
.hero-stats .stat{text-align:center;}
.hero-stats .stat h3{font-size:38px;font-weight:800;}
.hero-stats .stat p{font-size:15px;opacity:.8;margin-top:4px;text-transform:uppercase;letter-spacing:1px;}
.section-wrapper{padding:0 5%;margin-bottom:20px;}
.section-header{text-align:center;margin:65px 0 20px;}
.section-header h2{font-size:38px;font-weight:700;color:#1a1a2e;position:relative;display:inline-block;}
.section-header h2::after{content:'';display:block;width:70px;height:4px;background:linear-gradient(90deg,#ff6b35,#ff914d);margin:12px auto 0;border-radius:4px;}
.section-header p{color:#999;font-size:16px;margin-top:10px;}
.categories{display:grid;grid-template-columns:repeat(auto-fit,minmax(175px,1fr));gap:28px;}
.category-card{background:white;border-radius:24px;text-align:center;padding:20px 15px 25px;box-shadow:0 8px 25px rgba(0,0,0,.07);transition:.4s;cursor:pointer;position:relative;overflow:hidden;}
.category-card::before{content:'';position:absolute;top:0;left:0;width:100%;height:4px;background:linear-gradient(90deg,#ff6b35,#ff914d);opacity:0;transition:.4s;}
.category-card:hover{transform:translateY(-10px);box-shadow:0 20px 45px rgba(0,0,0,.13);}
.category-card:hover::before{opacity:1;}
.category-card .cat-img{width:90px;height:90px;border-radius:50%;object-fit:cover;margin:0 auto 14px;display:block;border:3px solid #fff;box-shadow:0 8px 20px rgba(0,0,0,.12);transition:.4s;}
.category-card:hover .cat-img{transform:scale(1.1);border-color:#ff6b35;box-shadow:0 12px 30px rgba(255,107,53,.25);}
.category-card h3{font-size:18px;font-weight:600;color:#333;}
.category-card p{color:#aaa;font-size:14px;margin-top:6px;}
.category-card .count-badge{display:inline-block;padding:3px 14px;border-radius:20px;background:#fff0eb;color:#ff6b35;font-size:12px;font-weight:600;margin-top:10px;}
.offers{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:25px;}
.offer-card{padding:32px 25px;border-radius:22px;color:white;transition:.4s;cursor:pointer;position:relative;overflow:hidden;}
.offer-card::after{content:'';position:absolute;top:-30px;right:-30px;width:120px;height:120px;border-radius:50%;background:rgba(255,255,255,.1);}
.offer-card:hover{transform:translateY(-8px) scale(1.02);box-shadow:0 25px 50px rgba(0,0,0,.2);}
.offer-card:nth-child(1){background:linear-gradient(135deg,#ff6b35,#ff9f1c);}
.offer-card:nth-child(2){background:linear-gradient(135deg,#e74c3c,#f39c12);}
.offer-card:nth-child(3){background:linear-gradient(135deg,#27ae60,#2ecc71);}
.offer-card:nth-child(4){background:linear-gradient(135deg,#8e44ad,#9b59b6);}
.offer-card .offer-emoji{font-size:50px;display:block;margin-bottom:14px;}
.offer-card h3{font-size:24px;font-weight:700;margin-bottom:8px;}
.offer-card p{opacity:.9;font-size:15px;line-height:1.6;}
.features{display:grid;grid-template-columns:repeat(auto-fit,minmax(250px,1fr));gap:28px;padding-bottom:40px;}
.feature{background:white;text-align:center;padding:42px 28px;border-radius:22px;box-shadow:0 8px 25px rgba(0,0,0,.07);transition:.4s;position:relative;overflow:hidden;}
.feature::before{content:'';position:absolute;bottom:0;left:50%;transform:translateX(-50%);width:0;height:4px;background:linear-gradient(90deg,#ff6b35,#ff914d);transition:.4s;border-radius:4px;}
.feature:hover{transform:translateY(-10px);box-shadow:0 20px 45px rgba(0,0,0,.12);}
.feature:hover::before{width:80%;}
.feature .feat-emoji{font-size:52px;display:block;margin-bottom:18px;transition:.4s;}
.feature:hover .feat-emoji{transform:scale(1.2) rotate(-5deg);}
.feature h3{font-size:21px;font-weight:600;color:#ff6b35;margin-bottom:12px;}
.feature p{color:#888;font-size:15px;line-height:1.7;}
.featured-restaurants{display:grid;grid-template-columns:repeat(auto-fit,minmax(280px,1fr));gap:28px;padding-bottom:20px;}
.restaurant-card{background:white;border-radius:22px;overflow:hidden;box-shadow:0 8px 25px rgba(0,0,0,.07);transition:.4s;cursor:pointer;}
.restaurant-card:hover{transform:translateY(-10px);box-shadow:0 20px 45px rgba(0,0,0,.13);}
.restaurant-card .rest-img{width:100%;height:180px;object-fit:cover;transition:.5s;}
.restaurant-card:hover .rest-img{transform:scale(1.08);}
.restaurant-card .rest-info{padding:20px 22px 22px;}
.restaurant-card .rest-info h3{font-size:20px;font-weight:600;color:#333;margin-bottom:6px;}
.restaurant-card .rest-info .rest-cuisine{color:#999;font-size:14px;margin-bottom:10px;}
.restaurant-card .rest-info .rest-meta{display:flex;justify-content:space-between;align-items:center;}
.restaurant-card .rest-info .rest-rating{background:#27ae60;color:white;padding:4px 14px;border-radius:20px;font-size:14px;font-weight:600;display:flex;align-items:center;gap:5px;}
.restaurant-card .rest-info .rest-time{color:#888;font-size:14px;}
.testimonials{display:grid;grid-template-columns:repeat(auto-fit,minmax(300px,1fr));gap:25px;padding-bottom:40px;}
.testimonial{background:white;padding:32px;border-radius:22px;box-shadow:0 8px 25px rgba(0,0,0,.07);transition:.4s;position:relative;}
.testimonial::before{content:'"';position:absolute;top:20px;right:25px;font-size:80px;color:rgba(255,107,53,.08);font-weight:900;line-height:1;font-family:Georgia,serif;}
.testimonial:hover{transform:translateY(-6px);box-shadow:0 16px 40px rgba(0,0,0,.1);}
.testimonial .stars{color:#f1c40f;font-size:18px;margin-bottom:14px;letter-spacing:3px;}
.testimonial p{color:#666;font-size:15px;line-height:1.8;margin-bottom:22px;font-style:italic;}
.testimonial .author{display:flex;align-items:center;gap:14px;}
.testimonial .author .avatar{width:48px;height:48px;border-radius:50%;background:linear-gradient(135deg,#ff6b35,#ff914d);display:flex;justify-content:center;align-items:center;color:white;font-weight:700;font-size:18px;flex-shrink:0;}
.testimonial .author .name{font-weight:600;color:#333;font-size:16px;}
.testimonial .author .role{color:#999;font-size:13px;}
.cta-banner{margin:10px 5% 50px;padding:65px 40px;border-radius:30px;background:linear-gradient(135deg,#ff6b35,#ff914d);text-align:center;color:white;box-shadow:0 25px 55px rgba(255,107,53,.35);position:relative;overflow:hidden;}
.cta-banner::before{content:'';position:absolute;top:-40%;left:-10%;width:300px;height:300px;border-radius:50%;background:rgba(255,255,255,.06);}
.cta-banner::after{content:'';position:absolute;bottom:-30%;right:-5%;width:250px;height:250px;border-radius:50%;background:rgba(255,255,255,.05);}
.cta-banner h2{font-size:44px;font-weight:800;margin-bottom:14px;position:relative;z-index:1;}
.cta-banner p{font-size:18px;opacity:.95;margin-bottom:32px;position:relative;z-index:1;}
.cta-banner a{display:inline-block;background:white;color:#ff6b35;text-decoration:none;padding:17px 48px;border-radius:50px;font-size:18px;font-weight:700;transition:.4s;position:relative;z-index:1;}
.cta-banner a:hover{transform:translateY(-4px);box-shadow:0 15px 35px rgba(0,0,0,.15);}
.footer{background:#1a1a2e;padding:60px 5% 30px;position:relative;}
.footer::before{content:'';position:absolute;top:0;left:0;width:100%;height:5px;background:linear-gradient(90deg,#ff6b35,#ff914d,#27ae60,#8e44ad);}
.footer-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:45px;margin-bottom:40px;}
.footer-col h3{font-size:24px;color:#ff6b35;margin-bottom:20px;font-weight:700;}
.footer-col p{color:#aaa;font-size:15px;line-height:1.9;}
.footer-col a{display:block;color:#ccc;text-decoration:none;margin-bottom:12px;font-size:15px;transition:.3s;display:flex;align-items:center;gap:8px;}
.footer-col a:hover{color:#ff6b35;padding-left:8px;}
.footer-bottom{border-top:1px solid rgba(255,255,255,.08);padding-top:25px;text-align:center;color:#777;font-size:14px;}
@media(max-width:1024px){.navbar{padding:0 30px;}}
@media(max-width:768px){
.navbar{padding:18px 20px;height:auto;flex-direction:column;gap:14px;}
.hero-content h1{font-size:36px;}
.hero-content p{font-size:17px;}
.hero-stats{gap:30px;margin-top:35px;}
.hero-stats .stat h3{font-size:28px;}
.search-box input{width:100%;}
.search-box{flex-direction:column;align-items:center;gap:10px;}
.search-box input{border-radius:50px;}
.search-box button{border-radius:50px;width:auto;}
.nav-links{gap:18px;flex-wrap:wrap;justify-content:center;}
.categories{grid-template-columns:repeat(2,1fr);}
.offers{grid-template-columns:1fr;}
.features{grid-template-columns:1fr;}
.featured-restaurants{grid-template-columns:1fr;}
.section-header h2{font-size:28px;}
.cta-banner h2{font-size:30px;}
.cta-banner{padding:40px 25px;}
}
@media(max-width:480px){
.categories{grid-template-columns:repeat(2,1fr);gap:15px;}
.category-card{padding:15px 10px;}
.category-card .cat-img{width:70px;height:70px;}
}
</style>
</head>
<body>
<div class="navbar">
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
%>
<div class="logo"><span>🍔 Foodie</span></div>
<div class="nav-links" style="align-items:center;">
<a href="#">Home</a>
<a href="callRestaurantServlet">Restaurants</a>
<a href="#offers">Offers</a>
<a href="#features">Why Us</a>
<form action="search" method="get" style="display:flex;align-items:center;gap:6px;">
<input type="text" name="query" placeholder="Search food..." style="padding:8px 14px;border:2px solid #eee;border-radius:20px;outline:none;font-size:13px;width:160px;transition:.3s;" onfocus="this.style.borderColor='#ff6b35'" onblur="this.style.borderColor='#eee'">
<button type="submit" style="padding:8px 16px;border:none;background:#ff6b35;color:white;border-radius:20px;cursor:pointer;font-weight:600;font-size:13px;">🔍</button>
</form>
<a href="cart.jsp" style="position:relative;">Cart <span class="nav-cart-badge" id="navCartBadge" style="position:absolute;top:-8px;right:-14px;background:#ff6b35;color:white;font-size:10px;font-weight:700;min-width:18px;height:18px;border-radius:9px;text-align:center;line-height:18px;padding:0 4px;box-shadow:0 2px 6px rgba(255,107,53,.4);"><%= session.getAttribute("cart") != null ? ((cart)session.getAttribute("cart")).getItems().size() : 0 %></span></a>
</div>
<div class="auth-btns">
<%
if(loggedInUser != null){
%>
<span style="display:flex;align-items:center;gap:12px;">
<a href="orderhistory" style="color:#ff6b35;text-decoration:none;font-weight:600;font-size:14px;transition:.3s;">📋 My Orders</a>
<span style="font-weight:600;color:#444;font-size:15px;">👋 <%=loggedInUser.getName()%></span>
<a href="logout" class="logout-btn">Logout</a>
</span>
<%
} else {
%>
<a href="login.jsp" class="login-btn">Sign In</a>
<a href="register.jsp" class="register-btn">Register</a>
<%
}
%>
</div></div>
<section class="hero">
<div class="hero-content">
<h1>Delicious Food<br><span>Delivered Fast</span></h1>
<p>Order from the best restaurants near you and enjoy freshly prepared meals delivered right to your doorstep.</p>
<div class="search-box">
<form action="search" method="get" style="display:flex;justify-content:center;width:100%;">
<input type="text" name="query" placeholder="Search for restaurants or dishes..." style="width:500px;padding:18px 28px;border:none;border-radius:50px 0 0 50px;font-size:16px;outline:none;box-shadow:0 8px 30px rgba(0,0,0,.12);" onfocus="this.style.boxShadow='0 8px 40px rgba(0,0,0,.18)'" onblur="this.style.boxShadow='0 8px 30px rgba(0,0,0,.12)'">
<button type="submit" style="padding:18px 35px;background:#1a1a2e;border:none;color:white;border-radius:0 50px 50px 0;font-size:16px;font-weight:600;cursor:pointer;box-shadow:0 8px 30px rgba(0,0,0,.12);transition:.3s;">🔍 Search</button>
</form>
</div>
<div class="hero-cta"><a href="callRestaurantServlet">🍕 Order Now</a></div>
<div class="hero-stats">
<div class="stat"><h3>500+</h3><p>Restaurants</p></div>
<div class="stat"><h3>50K+</h3><p>Happy Customers</p></div>
<div class="stat"><h3>30 Min</h3><p>Avg Delivery</p></div>
<div class="stat"><h3>4.8</h3><p>Rating</p></div>
</div></div></section>
<div class="section-wrapper">
<div class="section-header">
<h2>Popular Categories</h2>
<p>Choose from a wide variety of cuisines</p>
</div>
<div class="categories">
<div class="category-card">
<img src="<%=request.getContextPath()%>/images/pizza.png" alt="Pizza" class="cat-img">
<h3>Pizza</h3>
<p>Cheesy &amp; Delicious</p>
<span class="count-badge">30+ restaurants</span>
</div>
<div class="category-card">
<img src="<%=request.getContextPath()%>/images/burger.png" alt="Burger" class="cat-img">
<h3>Burger</h3>
<p>Juicy &amp; Crispy</p>
<span class="count-badge">25+ restaurants</span>
</div>
<div class="category-card">
<img src="<%=request.getContextPath()%>/images/biryani.png" alt="Biryani" class="cat-img">
<h3>Biryani</h3>
<p>Aromatic &amp; Flavorful</p>
<span class="count-badge">20+ restaurants</span>
</div>
<div class="category-card">
<img src="<%=request.getContextPath()%>/images/noodles.jpg" alt="Chinese" class="cat-img">
<h3>Chinese</h3>
<p>Spicy &amp; Tangy</p>
<span class="count-badge">18+ restaurants</span>
</div>
<div class="category-card">
<img src="<%=request.getContextPath()%>/images/pasta.jpg" alt="Italian" class="cat-img">
<h3>Italian</h3>
<p>Rich &amp; Creamy</p>
<span class="count-badge">15+ restaurants</span>
</div>
<div class="category-card">
<img src="<%=request.getContextPath()%>/images/dessert.png" alt="Desserts" class="cat-img">
<h3>Desserts</h3>
<p>Sweet &amp; Indulgent</p>
<span class="count-badge">22+ restaurants</span>
</div>
</div>
</div>
<div class="section-wrapper" id="offers">
<div class="section-header">
<h2>Today's Offers</h2>
<p>Grab these deals before they're gone</p>
</div>
<div class="offers">
<div class="offer-card"><span class="offer-emoji">🔥</span><h3>Flat 50% OFF</h3><p>On orders above &#x20B9;499. Use code: <strong>FOODIE50</strong></p></div>
<div class="offer-card"><span class="offer-emoji">🎉</span><h3>Buy 1 Get 1 Free</h3><p>On selected restaurants. Limited time offer!</p></div>
<div class="offer-card"><span class="offer-emoji">🚚</span><h3>Free Delivery</h3><p>On orders above &#x20B9;299. No minimum on weekends</p></div>
<div class="offer-card"><span class="offer-emoji">🎊</span><h3>Weekend Combo</h3><p>Get extra 20% off on weekend orders</p></div>
</div>
</div>
<div class="section-wrapper">
<div class="section-header">
<h2>Featured Restaurants</h2>
<p>Top-rated restaurants near you</p>
</div>
<div class="featured-restaurants">
<div class="restaurant-card">
<img src="<%=request.getContextPath()%>/images/mcd.jpg" alt="McDonald's" class="rest-img">
<div class="rest-info">
<h3>McDonald's</h3>
<p class="rest-cuisine">Burgers &#x2022; Fast Food</p>
<div class="rest-meta">
<span class="rest-rating">&#x2B50; 4.5</span>
<span class="rest-time">&#x23F1; 25 min</span>
</div>
</div>
</div>
<div class="restaurant-card">
<img src="<%=request.getContextPath()%>/images/pizzahut.jpg" alt="Pizza Hut" class="rest-img">
<div class="rest-info">
<h3>Pizza Hut</h3>
<p class="rest-cuisine">Pizza &#x2022; Italian</p>
<div class="rest-meta">
<span class="rest-rating">&#x2B50; 4.3</span>
<span class="rest-time">&#x23F1; 30 min</span>
</div>
</div>
</div>
<div class="restaurant-card">
<img src="<%=request.getContextPath()%>/images/subway.jpg" alt="Subway" class="rest-img">
<div class="rest-info">
<h3>Subway</h3>
<p class="rest-cuisine">Sandwiches &#x2022; Salads</p>
<div class="rest-meta">
<span class="rest-rating">&#x2B50; 4.4</span>
<span class="rest-time">&#x23F1; 20 min</span>
</div>
</div>
</div>
</div>
</div>
<div class="section-wrapper" id="features">
<div class="section-header">
<h2>Why Choose Foodie?</h2>
<p>We go the extra mile for every order</p>
</div>
<div class="features">
<div class="feature"><span class="feat-emoji">⚡</span><h3>Lightning Fast</h3><p>Hot food delivered in under 30 minutes. Our riders ensure your order reaches you fresh and on time.</p></div>
<div class="feature"><span class="feat-emoji">🏆</span><h3>Best Restaurants</h3><p>Choose from hundreds of top-rated restaurants. We partner only with the best in your city.</p></div>
<div class="feature"><span class="feat-emoji">🔒</span><h3>Secure Payments</h3><p>100% secure payments via UPI, Cards, Net Banking or Cash on Delivery. Your data is safe with us.</p></div>
<div class="feature"><span class="feat-emoji">💬</span><h3>24&#x00D7;7 Support</h3><p>Our support team is always here to help. Reach us anytime via chat, email, or phone.</p></div>
</div>
</div>
<div class="section-wrapper">
<div class="section-header">
<h2>What Our Customers Say</h2>
<p>Real reviews from real customers</p>
</div>
<div class="testimonials">
<div class="testimonial">
<div class="stars">&#x2605;&#x2605;&#x2605;&#x2605;&#x2605;</div>
<p>"Foodie is amazing! The food arrived hot and fresh within 20 minutes. The portion sizes are generous and the packaging was excellent."</p>
<div class="author"><div class="avatar">P</div><div><div class="name">Priya Sharma</div><div class="role">Regular Customer</div></div></div>
</div>
<div class="testimonial">
<div class="stars">&#x2605;&#x2605;&#x2605;&#x2605;&#x2605;</div>
<p>"The variety of restaurants is incredible. I've discovered so many new places through this app. The deals make ordering even better!"</p>
<div class="author"><div class="avatar">R</div><div><div class="name">Raj Patel</div><div class="role">Food Lover</div></div></div>
</div>
<div class="testimonial">
<div class="stars">&#x2605;&#x2605;&#x2605;&#x2605;&#x2606;</div>
<p>"Great app! The offers and discounts make ordering so affordable. Customer service is excellent and they always resolve issues quickly."</p>
<div class="author"><div class="avatar">A</div><div><div class="name">Ananya Gupta</div><div class="role">Verified Buyer</div></div></div>
</div>
</div>
</div>
<div class="cta-banner">
<h2>Ready to Order? 🎉</h2>
<p>Join thousands of happy customers and get delicious food delivered to your doorstep!</p>
<a href="callRestaurantServlet">🍔 Order Now</a>
</div>
<div class="footer">
<div class="footer-grid">
<div class="footer-col">
<h3>🍔 Foodie</h3>
<p>Your favourite food delivery app. We bring the best restaurants to your doorstep with lightning-fast delivery.</p>
</div>
<div class="footer-col">
<h3>Quick Links</h3>
<a href="#">🏠 Home</a>
<a href="callRestaurantServlet">🍽️ Restaurants</a>
<a href="cart.jsp">🛒 Cart</a>
<a href="#offers">🔥 Offers</a>
</div>
<div class="footer-col">
<h3>Support</h3>
<a href="#">❓ Help Center</a>
<a href="#">📞 Contact Us</a>
<a href="#">🔒 Privacy Policy</a>
<a href="#">📄 Terms of Service</a>
</div>
<div class="footer-col">
<h3>Connect</h3>
<a href="#">📘 Facebook</a>
<a href="#">📸 Instagram</a>
<a href="#">🐦 Twitter</a>
<a href="#">✉️ Email</a>
</div>
</div>
<div class="footer-bottom">
<p>&#x00A9; 2026 Foodie. All Rights Reserved. Made with &#x2764;&#xFE0F; using Java, JSP, Servlets &amp; MySQL</p>
</div>
</div>
</body>
</html>