<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.cart"%>
<%@ page import="com.tap.model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Foodie | Restaurants</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:#f8f8f8;}
.navbar{height:80px;padding:0 70px;display:flex;justify-content:space-between;align-items:center;background:white;box-shadow:0 10px 30px rgba(0,0,0,.08);position:sticky;top:0;z-index:999;}
.logo{font-size:34px;font-weight:700;color:#ff6b35;}
.nav-links{display:flex;gap:35px;}
.nav-links a{text-decoration:none;color:#444;font-size:18px;font-weight:500;transition:.3s;}
.nav-links a:hover{color:#ff6b35;}
.hero{height:360px;background:linear-gradient(rgba(0,0,0,.55),rgba(0,0,0,.55)),url('<%=request.getContextPath()%>/images/banner.jpg');background-size:cover;background-position:center;display:flex;flex-direction:column;justify-content:center;align-items:center;color:white;text-align:center;}
.hero h1{font-size:56px;font-weight:bold;margin-bottom:12px;text-shadow:0 4px 15px rgba(0,0,0,.3);}
.hero p{font-size:20px;opacity:.95;}
.search-bar{width:650px;max-width:92%;margin-top:30px;display:flex;}
.search-bar input{flex:1;padding:16px 24px;border:none;outline:none;font-size:17px;border-radius:50px 0 0 50px;}
.search-bar button{padding:16px 32px;border:none;background:#ff6b35;color:white;font-size:17px;font-weight:600;cursor:pointer;border-radius:0 50px 50px 0;transition:.3s;}
.search-bar button:hover{background:#e55b2b;}
.section{width:92%;margin:45px auto;padding-bottom:40px;}
.heading{display:flex;justify-content:space-between;align-items:center;margin-bottom:35px;}
.heading h2{font-size:34px;font-weight:700;color:#222;}
.heading .count{color:#888;font-size:16px;font-weight:500;background:#f0f0f0;padding:8px 18px;border-radius:30px;}
.filters{display:flex;flex-wrap:wrap;gap:15px;margin-bottom:35px;}
.filter{padding:10px 24px;background:white;border-radius:30px;box-shadow:0 4px 12px rgba(0,0,0,.06);cursor:pointer;font-size:15px;font-weight:500;transition:.3s;border:2px solid transparent;}
.filter:hover,.filter.active{background:#ff6b35;color:white;transform:translateY(-3px);box-shadow:0 8px 20px rgba(255,107,53,.25);}
.restaurant-container{display:grid;grid-template-columns:repeat(auto-fit,minmax(320px,1fr));gap:30px;}
.restaurant-link{text-decoration:none;color:black;}
.card{background:white;border-radius:22px;overflow:hidden;transition:.4s;box-shadow:0 12px 28px rgba(0,0,0,.10);}
.card:hover{transform:translateY(-10px);box-shadow:0 20px 40px rgba(0,0,0,.18);}
.card-image{position:relative;overflow:hidden;}
.card-image img{width:100%;height:220px;object-fit:cover;transition:.5s;}
.card:hover .card-image img{transform:scale(1.08);}
.rating-badge{position:absolute;top:15px;right:15px;background:#28a745;padding:8px 14px;color:white;font-weight:bold;border-radius:10px;font-size:15px;box-shadow:0 4px 10px rgba(0,0,0,.2);}
.time-badge{position:absolute;bottom:15px;left:15px;background:rgba(255,255,255,.9);backdrop-filter:blur(10px);padding:8px 14px;border-radius:10px;font-weight:600;font-size:14px;color:#333;box-shadow:0 4px 10px rgba(0,0,0,.1);}
.card-content{padding:22px;}
.card-content h3{font-size:26px;margin-bottom:6px;color:#222;}
.cuisine{color:#888;margin-bottom:8px;font-size:15px;}
.cuisine span{background:#fff0e8;color:#ff6b35;padding:3px 10px;border-radius:20px;font-size:13px;font-weight:600;margin-left:6px;}
.address{color:#999;font-size:14px;margin-bottom:18px;}
.divider{height:1px;background:#eee;margin:16px 0;}
.card-bottom{display:flex;justify-content:space-between;align-items:center;}
.card-bottom .price-range{color:#27ae60;font-weight:600;font-size:15px;}
.btn{padding:12px 28px;border:none;background:#ff6b35;color:white;font-size:16px;font-weight:600;border-radius:12px;cursor:pointer;transition:.3s;}
.btn:hover{background:#e55b2b;transform:translateY(-2px);box-shadow:0 8px 20px rgba(255,107,53,.3);}
.no-data{text-align:center;font-size:28px;color:#888;padding:100px 20px;}
.footer{margin-top:50px;background:#1a1a2e;color:white;padding:40px 30px;text-align:center;}
.footer h3{font-size:28px;color:#ff6b35;margin-bottom:10px;}
.footer p{color:#aaa;font-size:15px;line-height:1.8;}
.footer .footer-links{display:flex;justify-content:center;gap:25px;margin:20px 0;flex-wrap:wrap;}
.footer .footer-links a{color:#ccc;text-decoration:none;font-size:15px;transition:.3s;}
.footer .footer-links a:hover{color:#ff6b35;}
@media(max-width:900px){.navbar{padding:20px;height:auto;flex-direction:column;gap:15px;}.hero h1{font-size:36px;}.heading{flex-direction:column;gap:12px;text-align:center;}.restaurant-container{grid-template-columns:1fr;}}
</style>
</head>
<body>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    String cartStyle = (session.getAttribute("cart") != null && ((cart)session.getAttribute("cart")).getItems().size() > 0) ? "" : "display:none;";
    int cartCount = (session.getAttribute("cart") != null) ? ((cart)session.getAttribute("cart")).getItems().size() : 0;
%>
<div class="navbar"><div class="logo">🍔 Foodie</div>
<div class="nav-links" style="align-items:center;">
<a href="home.jsp">Home</a>
<a href="callRestaurantServlet">Restaurants</a>
<form action="search" method="get" style="display:flex;align-items:center;gap:6px;">
<input type="text" name="query" placeholder="Search food..." style="padding:8px 14px;border:2px solid #eee;border-radius:20px;outline:none;font-size:13px;width:160px;transition:.3s;" onfocus="this.style.borderColor='#ff6b35'" onblur="this.style.borderColor='#eee'">
<button type="submit" style="padding:8px 16px;border:none;background:#ff6b35;color:white;border-radius:20px;cursor:pointer;font-weight:600;font-size:13px;">🔍</button>
</form>
<a href="cart.jsp" style="position:relative;">Cart <span class="nav-cart-badge" style="<%= cartStyle %>position:absolute;top:-8px;right:-14px;background:#ff6b35;color:white;font-size:10px;font-weight:700;min-width:18px;height:18px;border-radius:9px;text-align:center;line-height:18px;padding:0 4px;box-shadow:0 2px 6px rgba(255,107,53,.4);"><%= cartCount %></span></a>
<%
if(loggedInUser != null){
%>
<span style="display:flex;align-items:center;gap:10px;font-size:15px;font-weight:600;color:#444;">👋 <%=loggedInUser.getName()%></span>
<a href="logout" style="text-decoration:none;color:#e74c3c;font-weight:600;transition:.3s;">Logout</a>
<%
} else {
%>
<a href="login.jsp" style="text-decoration:none;color:#444;font-size:18px;font-weight:500;transition:.3s;">Login</a>
<a href="register.jsp" style="text-decoration:none;color:#444;font-size:18px;font-weight:500;transition:.3s;">Register</a>
<%
}
%>
</div></div>
<div class="hero">
<h1>Discover Delicious Food</h1>
<p>Order from your favourite restaurants near you</p>
<div class="search-bar">
<input type="text" id="searchInput" placeholder="Search for restaurants...">
<button onclick="filterRestaurants()">Search</button>
</div></div>
<div class="section">
<%
List<Restaurant> allRestaurants = (List<Restaurant>)request.getAttribute("allRestaurants");
%>
<div class="heading">
<h2>Popular Restaurants</h2>
<div class="count"><%= allRestaurants!=null ? allRestaurants.size() : 0 %> Restaurants</div></div>
<div class="filters">
<div class="filter active" onclick="applyFilter('all',this)">All</div>
<div class="filter" onclick="applyFilter('Pizza',this)">Pizza</div>
<div class="filter" onclick="applyFilter('Burger',this)">Burger</div>
<div class="filter" onclick="applyFilter('Italian',this)">Italian</div>
<div class="filter" onclick="applyFilter('Chinese',this)">Chinese</div>
<div class="filter" onclick="applyFilter('Indian',this)">Indian</div>
<div class="filter" onclick="applyFilter('Dessert',this)">Desserts</div>
</div>
<div class="restaurant-container" id="restaurantContainer">
<%
if(allRestaurants != null && !allRestaurants.isEmpty()){
for(Restaurant restaurant : allRestaurants){
String cuisine = restaurant.getCuisineType() != null ? restaurant.getCuisineType().toLowerCase() : "";
%>
<a class="restaurant-link" href="menu?restaurantId=<%=restaurant.getRestaurantId()%>" data-cuisine="<%=cuisine%>">
<div class="card">
<div class="card-image">
<img src="<%=request.getContextPath()%>/<%=restaurant.getImagePath()%>" alt="<%=restaurant.getName()%>">
<div class="rating-badge"><%=restaurant.getRating()%></div>
<div class="time-badge"><%=restaurant.getDeliveryTime()%> mins</div>
</div>
<div class="card-content">
<h3><%=restaurant.getName()%></h3>
<div class="cuisine"><%=restaurant.getCuisineType()%><span>Popular</span></div>
<div class="address"><%=restaurant.getAddress()%></div>
<div class="divider"></div>
<div class="card-bottom">
<div class="price-range">Free Delivery</div>
<button class="btn">View Menu</button>
</div></div></div></a>
<%
}
}else{
%>
<div class="no-data"><h2>No Restaurants Available</h2><p>Please check back later.</p></div>
<%
}
%>
</div></div>
<div class="footer">
<h3>Foodie</h3>
<p>Fresh Food - Fast Delivery - Great Taste</p>
<div class="footer-links">
<a href="home.jsp">Home</a>
<a href="callRestaurantServlet">Restaurants</a>
<a href="cart.jsp" style="position:relative;">Cart <span class="nav-cart-badge" style="<%= cartStyle %>position:absolute;top:-8px;right:-14px;background:#ff6b35;color:white;font-size:10px;font-weight:700;min-width:18px;height:18px;border-radius:9px;text-align:center;line-height:18px;padding:0 4px;box-shadow:0 2px 6px rgba(255,107,53,.4);"><%= cartCount %></span></a>
<%
if(loggedInUser != null){
%>
<a href="logout" style="color:#ccc;text-decoration:none;font-size:15px;transition:.3s;">Logout</a>
<%
} else {
%>
<a href="login.jsp" style="color:#ccc;text-decoration:none;font-size:15px;transition:.3s;">Login</a>
<a href="register.jsp" style="color:#ccc;text-decoration:none;font-size:15px;transition:.3s;">Register</a>
<%
}
%>
</div>
<p>(c) 2026 Foodie. All Rights Reserved.</p>
</div>
<script>
function filterRestaurants(){var input=document.getElementById("searchInput");var filter=input.value.toLowerCase();var cards=document.querySelectorAll(".restaurant-link");cards.forEach(function(card){var name=card.querySelector("h3").innerText.toLowerCase();if(name.includes(filter)){card.style.display="block";}else{card.style.display="none";}});}
document.getElementById("searchInput").addEventListener("keyup",filterRestaurants);
function applyFilter(cuisine,btn){var filters=document.querySelectorAll(".filter");filters.forEach(function(f){f.classList.remove("active");});btn.classList.add("active");var cards=document.querySelectorAll(".restaurant-link");cards.forEach(function(card){if(cuisine==="all"){card.style.display="block";}else{var c=card.getAttribute("data-cuisine");if(c&&c.includes(cuisine.toLowerCase())){card.style.display="block";}else{card.style.display="none";}}});}
</script>
</body>
</html>