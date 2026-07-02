<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.tap.model.Menu" %>
<%@ page import="com.tap.model.Restaurant" %>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Restaurant Menu</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
}

body{
    background:#f4f4f4;
}

/* ================= HEADER ================= */

.header{

    background:#ff6b35;

    color:white;

    text-align:center;

    padding:25px;

    box-shadow:0 3px 10px rgba(0,0,0,.15);

}

.header h1{

    margin-bottom:10px;

    font-size:40px;

}

.header p{

    font-size:18px;

}

/* ================= MENU ================= */

.menu-container{

    display:flex;

    flex-wrap:wrap;

    justify-content:center;

    gap:25px;

    padding:35px;

}

/* ================= CARD ================= */

.card{

    width:280px;

    background:white;

    border-radius:15px;

    overflow:hidden;

    box-shadow:0 5px 15px rgba(0,0,0,.15);

    transition:.3s;

}

.card:hover{

    transform:translateY(-8px);

}

.card img{

    width:100%;

    height:180px;

    object-fit:cover;

}

.card-content{

    padding:18px;

}

.card-content h3{

    margin-bottom:10px;

    color:#333;

}

.description{

    color:#666;

    margin-bottom:12px;

    min-height:45px;

}

.price{

    color:#28a745;

    font-size:22px;

    font-weight:bold;

    margin-bottom:15px;

}

/* ================= BUTTON ================= */

.btn{

    width:100%;

    padding:12px;

    border:none;

    background:#28a745;

    color:white;

    border-radius:8px;

    cursor:pointer;

    font-size:17px;

    transition:.3s;

}

.btn:hover{

    background:#218838;

}

.no-data{

    text-align:center;

    margin-top:50px;

    color:red;

    font-size:24px;

}

</style>

</head>

<body>

<div class="header">

    <h1>🍴 Restaurant Menu</h1>

    <p>Select your favourite food and order now</p>

</div>

<div class="menu-container">

<%
Restaurant restaurant =
(Restaurant) request.getAttribute("restaurant");

List<Menu> allMenusByRestaurant =
(List<Menu>) request.getAttribute("allMenusByRestaurant");

if(allMenusByRestaurant != null &&
   !allMenusByRestaurant.isEmpty()){

    for(Menu menu : allMenusByRestaurant){

%>
    <div class="card">

        <img
            src="<%= request.getContextPath() %>/images/<%= menu.getImagePath() %>"
            alt="<%= menu.getItemName() %>">

        <div class="card-content">

            <h3>
                <%= menu.getItemName() %>
            </h3>

            <p class="description">
                <%= menu.getDescription() %>
            </p>

            <div class="price">
                ₹ <%= menu.getPrice() %>
            </div>

            <form action="cartservlet" method="post">

                <input
                    type="hidden"
                    name="menuId"
                    value="<%= menu.getMenuId() %>">

                <input
                    type="hidden"
                    name="restaurantId"
                    value="<%= menu.getRestaurantId() %>">

                <input
                    type="hidden"
                    name="quantity"
                    value="1">

                <input
                    type="hidden"
                    name="action"
                    value="add">

                <button
                    type="submit"
                    class="btn">

                    🛒 Add To Cart

                </button>

            </form>

        </div>

    </div>

<%
    }

}
else{

%>

<div class="no-data">

    <h2>
        No Menu Items Available
    </h2>

</div>

<%
}
%>

</div>

</body>
</html>