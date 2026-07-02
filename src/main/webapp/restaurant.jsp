<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Restaurant" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Foodie Restaurants</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial,sans-serif;
}

body{
    background:#f4f4f4;
}

/* Navbar */

/* Modern Navbar */

.navbar{
    background:linear-gradient(90deg,#ff6b35,#ff914d);
    padding:18px 60px;
    display:flex;
    justify-content:space-between;
    align-items:center;
    box-shadow:0 4px 12px rgba(0,0,0,.2);
    position:sticky;
    top:0;
    z-index:1000;
}

.logo{
    color:white;
    font-size:32px;
    font-weight:bold;
}

.nav-links{
    display:flex;
    align-items:center;
    gap:25px;
}

.nav-links a{
    color:white;
    text-decoration:none;
    font-size:18px;
    font-weight:500;
    transition:.3s;
}

.nav-links a:hover{
    color:#ffe082;
}

/* Header */

.header{
    background:#ff6b35;
    color:white;
    text-align:center;
    padding:25px;
}

.header h1{
    margin-bottom:10px;
}

/* Restaurant Cards */

.restaurant-container{
    display:flex;
    flex-wrap:wrap;
    justify-content:center;
    gap:25px;
    padding:30px;
}

.card{
    width:280px;
    background:white;
    border-radius:15px;
    overflow:hidden;
    box-shadow:0px 4px 10px rgba(0,0,0,0.2);
    transition:0.3s;
}

.card:hover{
    transform:translateY(-5px);
}

.card img{
    width:100%;
    height:180px;
    object-fit:cover;
}

.card-content{
    padding:15px;
}

.card-content h3{
    margin-bottom:10px;
}

.card-content p{
    margin:6px 0;
}

.btn{
    width:100%;
    padding:10px;
    margin-top:10px;
    background:#28a745;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
}

.btn:hover{
    background:#218838;
}

.no-data{
    text-align:center;
    color:red;
    font-size:24px;
    margin-top:50px;
}

.restaurant-link{
    text-decoration:none;
    color:black;
}

</style>

</head>
<body>

<!-- Navbar -->

<div class="navbar">

    <div class="logo">
        🍴 Foodie
    </div>

    <div class="nav-links">
        <a href="home.jsp">Home</a>
        <a href="callRestaurantServlet">Restaurants</a>
        <a href="cart.jsp">Cart</a>
        <a href="login.jsp">Login</a>
        <a href="register.jsp">Register</a>
    </div>

</div>

<!-- Header -->

<div class="header">
    <h1>Discover Restaurants</h1>
    <p>Order Food From Your Favourite Restaurant</p>
</div>

<!-- Restaurant List -->

<div class="restaurant-container">

<%
List<Restaurant> allRestaurants =
(List<Restaurant>)request.getAttribute("allRestaurants");

if(allRestaurants != null && !allRestaurants.isEmpty()){

    for(Restaurant restaurant : allRestaurants){
%>

<a class="restaurant-link"
   href="menu?restaurantId=<%= restaurant.getRestaurantId() %>">

    <div class="card">

        <img
        src="<%= request.getContextPath() %>/images/<%= restaurant.getImagePath() %>"
        alt="<%= restaurant.getName() %>">

        <div class="card-content">

            <h3><%= restaurant.getName() %></h3>

            <p>
                🍽️ <%= restaurant.getCuisineType() %>
            </p>

            <p>
                ⭐ <%= restaurant.getRating() %>
            </p>

            <p>
                🕒 <%= restaurant.getDeliveryTime() %> mins
            </p>

            <p>
                📍 <%= restaurant.getAddress() %>
            </p>

            <button class="btn">
                View Menu
            </button>

        </div>

    </div>

</a>

<%
    }
}
else{
%>

<div class="no-data">
    No Restaurants Available
</div>

<%
}
%>

</div>

</body>
</html>