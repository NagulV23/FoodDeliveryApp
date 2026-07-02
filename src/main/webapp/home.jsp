<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Foodie - Online Food Delivery</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, Helvetica, sans-serif;
    scroll-behavior:smooth;
}

body{
    background:#f8f9fa;
}

/* Navbar */

.navbar{
    position:sticky;
    top:0;
    z-index:1000;
    background:#ffffff;
    display:flex;
    justify-content:space-between;
    align-items:center;
    padding:18px 60px;
    box-shadow:0 2px 10px rgba(0,0,0,.15);
}

.logo{
    font-size:30px;
    color:#ff5722;
    font-weight:bold;
}

.nav-links a{
    text-decoration:none;
    color:#333;
    margin:0 18px;
    font-size:18px;
    transition:.3s;
}

.nav-links a:hover{
    color:#ff5722;
}

.auth a{
    text-decoration:none;
    color:white;
    background:#ff5722;
    padding:10px 18px;
    border-radius:8px;
    margin-left:10px;
    transition:.3s;
}

.auth a:hover{
    background:#e64a19;
}

/* Hero */

.hero{
    height:90vh;
    background:
        linear-gradient(rgba(0,0,0,.55),rgba(0,0,0,.55)),
        url("<%=request.getContextPath()%>/images/hero.png");

    background-size:cover;
    background-position:center;
    background-repeat:no-repeat;

    display:flex;
    justify-content:center;
    align-items:center;
    text-align:center;
    color:white;
}

.hero-content h1{
    font-size:60px;
    margin-bottom:20px;
}

.hero-content p{
    font-size:22px;
    margin-bottom:35px;
}

.search-box input{
    width:420px;
    padding:15px;
    border:none;
    border-radius:30px;
    font-size:18px;
    outline:none;
}

.search-box button{
    padding:15px 30px;
    background:#ff5722;
    border:none;
    color:white;
    border-radius:30px;
    font-size:18px;
    cursor:pointer;
    margin-left:10px;
}

.order-btn{
    margin-top:35px;
}

.order-btn a{
    background:#28a745;
    color:white;
    text-decoration:none;
    padding:15px 35px;
    border-radius:8px;
    font-size:20px;
}

.order-btn a:hover{
    background:#218838;
}

/* Section */

.section-title{
    text-align:center;
    margin:60px 0 30px;
    font-size:38px;
    color:#333;
}

/* Categories */

.categories{
    display:flex;
    justify-content:center;
    flex-wrap:wrap;
    gap:25px;
    padding:20px;
}

.category-card{
    width:220px;
    background:white;
    border-radius:15px;
    overflow:hidden;
    text-align:center;
    box-shadow:0 5px 15px rgba(0,0,0,.15);
    transition:.3s;
}

.category-card:hover{
    transform:translateY(-8px);
}

.category-card img{
    width:100%;
    height:170px;
    object-fit:cover;
}

.category-card h3{
    padding:15px;
}

/* Offers */

.offers{
    display:flex;
    justify-content:center;
    flex-wrap:wrap;
    gap:20px;
    padding:20px;
}

.offer-card{
    width:260px;
    background:#ff5722;
    color:white;
    padding:30px;
    text-align:center;
    border-radius:12px;
    font-size:22px;
    box-shadow:0 5px 15px rgba(0,0,0,.2);
}

/* Features */

.features{
    display:flex;
    justify-content:center;
    flex-wrap:wrap;
    gap:30px;
    padding:30px;
}

.feature{
    width:250px;
    background:white;
    text-align:center;
    padding:25px;
    border-radius:12px;
    box-shadow:0 5px 15px rgba(0,0,0,.15);
}

.feature h2{
    color:#ff5722;
    margin-bottom:15px;
}

/* Footer */

.footer{
    background:#222;
    color:white;
    text-align:center;
    padding:25px;
    margin-top:50px;
}

@media(max-width:768px){

.navbar{
    flex-direction:column;
    padding:20px;
}

.hero-content h1{
    font-size:40px;
}

.search-box input{
    width:90%;
    margin-bottom:10px;
}

.search-box button{
    margin:10px 0;
}

}

</style>

</head>
<body>

<!-- Navbar -->

<div class="navbar">

<div class="logo">
🍔 Foodie
</div>

<div class="nav-links">
<a href="#">Home</a>
<a href="callRestaurantServlet">Restaurants</a>
<a href="#offers">Offers</a>
<a href="#about">About</a>
<a href="cart.jsp">Cart</a>
</div>

<div class="auth">
<a href="login.jsp">Login</a>
<a href="register.jsp">Register</a>
</div>

</div>

<!-- Hero -->

<section class="hero">

<div class="hero-content">

<h1>Delicious Food Delivered Fast</h1>

<p>Order from your favourite restaurants near you.</p>

<div class="search-box">
<input type="text" placeholder="Search Restaurants or Food">
<button>Search</button>
</div>

<div class="order-btn">
<a href="callRestaurantServlet">Order Now</a>
</div>

</div>

</section>

<!-- Categories -->

<h2 class="section-title">Popular Categories</h2>

<div class="categories">

<div class="category-card">
<img src="images/pizza.png">
<h3>Pizza</h3>
</div>

<div class="category-card">
<img src="images/burger.png">
<h3>Burger</h3>
</div>

<div class="category-card">
<img src="images/biryani.png">
<h3>Biryani</h3>
</div>

<div class="category-card">
<img src="images/dessert.png">
<h3>Desserts</h3>
</div>

</div>

<!-- Offers -->

<h2 class="section-title" id="offers">Today's Offers</h2>

<div class="offers">

<div class="offer-card">
🔥 Flat 50% OFF
</div>

<div class="offer-card">
🍕 Buy 1 Get 1 Free
</div>

<div class="offer-card">
🚚 Free Delivery
</div>

<div class="offer-card">
🎁 Weekend Combo
</div>

</div>

<!-- Features -->

<h2 class="section-title" id="about">Why Choose Foodie?</h2>

<div class="features">

<div class="feature">
<h2>⚡ Fast Delivery</h2>
<p>Hot food delivered in under 30 minutes.</p>
</div>

<div class="feature">
<h2>🍽 Best Restaurants</h2>
<p>Choose from hundreds of top-rated restaurants.</p>
</div>

<div class="feature">
<h2>💳 Secure Payments</h2>
<p>Pay safely using UPI, Cards or Cash.</p>
</div>

<div class="feature">
<h2>😊 24×7 Support</h2>
<p>We are always here to help you.</p>
</div>

</div>

<!-- Footer -->

<div class="footer">

<h2>🍔 Foodie</h2>

<p>Delivering Happiness Every Day ❤️</p>

<br>

<p>
Home |
Restaurants |
Offers |
Contact |
Privacy Policy
</p>

<br>

<p>
© 2026 Foodie. All Rights Reserved.
</p>

</div>

</body>
</html>