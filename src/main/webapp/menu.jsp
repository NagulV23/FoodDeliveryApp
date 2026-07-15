<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.cart"%>
<%@ page import="com.tap.model.User"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>Foodie | Restaurant Menu</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

html{
scroll-behavior:smooth;
}

body{

background:#f8f8f8;
color:#222;

}

/*================ NAVBAR =================*/

.navbar{

height:78px;
padding:0 70px;

display:flex;
justify-content:space-between;
align-items:center;

background:white;

box-shadow:0 5px 18px rgba(0,0,0,.08);

position:sticky;
top:0;
z-index:1000;

}

.logo{

font-size:34px;
font-weight:bold;

color:#ff6b35;

}

.logo span{

color:#222;

}

.nav-links{

display:flex;
gap:35px;

}

.nav-links a{

text-decoration:none;
color:#444;
font-size:18px;
font-weight:500;
transition:.3s;

}

.nav-links a:hover{

color:#ff6b35;

}

/*================ HERO =================*/

.hero{

height:360px;

background:
linear-gradient(rgba(0,0,0,.55),
rgba(0,0,0,.55)),
url("<%=request.getContextPath()%>/images/banner.jpg");

background-size:cover;
background-position:center;

display:flex;
justify-content:center;
align-items:center;
flex-direction:column;

color:white;
text-align:center;

}

.hero h1{

font-size:60px;
font-weight:bold;
margin-bottom:18px;

}

.hero p{

font-size:20px;
opacity:.95;

}

.restaurant-info{

margin-top:25px;

display:flex;
gap:20px;

flex-wrap:wrap;

justify-content:center;

}

.info{

padding:12px 24px;

background:rgba(255,255,255,.15);

border-radius:40px;

backdrop-filter:blur(8px);

font-size:16px;

}

/*================ SEARCH =================*/

.search-area{

padding:40px;

display:flex;
justify-content:center;

}

.search-box{

width:700px;
height:58px;

padding:0 25px;

border:none;
outline:none;

border-radius:40px;

font-size:18px;

box-shadow:0 10px 25px rgba(0,0,0,.12);

}

/*================ CATEGORY =================*/

.category-bar{

display:flex;

justify-content:center;

flex-wrap:wrap;

gap:18px;

padding-bottom:35px;

}

.category{

padding:12px 26px;

background:white;

border-radius:30px;

box-shadow:0 5px 15px rgba(0,0,0,.08);

cursor:pointer;

transition:.3s;

font-weight:500;

}

.category:hover{

background:#ff6b35;

color:white;

transform:translateY(-4px);

}

/*================ TITLE =================*/

.title{

width:90%;
margin:auto;

display:flex;

justify-content:space-between;

align-items:center;

padding-bottom:20px;

}

.title h2{

font-size:36px;

}

.title p{

color:#777;

}

/*================ MENU GRID =================*/

.menu-container{

width:90%;
margin:auto;

display:grid;

grid-template-columns:

repeat(auto-fit,minmax(320px,1fr));

gap:35px;

padding-bottom:70px;

}

/*================ CARD =================*/

.card{

background:white;

border-radius:22px;

overflow:hidden;

box-shadow:0 12px 28px rgba(0,0,0,.10);

transition:.35s;

position:relative;

}

.card:hover{

transform:translateY(-10px);

box-shadow:0 18px 35px rgba(0,0,0,.18);

}

.card img{

width:100%;
height:220px;
object-fit:cover;

transition:.4s;

}

.card:hover img{

transform:scale(1.08);

}

.badge{

position:absolute;

top:18px;
left:18px;

background:#ff6b35;

color:white;

padding:6px 15px;

font-size:14px;

border-radius:20px;

font-weight:bold;

}

.card-content{

padding:22px;

}

.item-top{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:15px;

}

.item-top h3{

font-size:26px;

color:#222;

}

.rating{

background:#1ba672;

color:white;

padding:6px 12px;

border-radius:20px;

font-size:14px;

font-weight:bold;

}

.description{

margin:18px 0;

color:#666;

line-height:1.6;

min-height:60px;

}

.price-row{

display:flex;

justify-content:space-between;

align-items:center;

margin-bottom:20px;

}

.price{

font-size:28px;

font-weight:bold;

color:#1ba672;

}

.delivery{

color:#777;

font-size:15px;

}

.btn{

width:100%;

padding:16px;

border:none;

border-radius:12px;

background:#ff6b35;

color:white;

font-size:18px;

font-weight:bold;

cursor:pointer;

transition:.3s;

}

.btn:hover{

background:#e64900;

transform:scale(1.02);

}

/* ================= TOAST ================= */

.toast{
position:fixed;
top:100px;
right:-400px;
z-index:9999;
background:white;
padding:18px 28px;
border-radius:18px;
box-shadow:0 20px 50px rgba(0,0,0,.18);
display:flex;
align-items:center;
gap:16px;
transition:right .5s cubic-bezier(.22,.61,.36,1);
border-left:5px solid #27ae60;
min-width:320px;
}

.toast.show{
right:30px;
}

.toast-icon{
font-size:36px;
flex-shrink:0;
}

.toast-title{
font-size:16px;
font-weight:700;
color:#27ae60;
margin-bottom:4px;
}

.toast-item-name{
font-size:18px;
font-weight:600;
color:#222;
}

.toast-sub{
font-size:13px;
color:#999;
margin-top:3px;
}

/* ================= CART BADGE ================= */

.cart-link{
position:relative;
text-decoration:none;
color:#444;
font-size:18px;
font-weight:500;
transition:.3s;
}

.cart-link:hover{
color:#ff6b35;
}

.cart-badge{
display:none;
position:absolute;
top:-10px;
right:-14px;
background:#ff6b35;
color:white;
font-size:11px;
font-weight:700;
min-width:20px;
height:20px;
border-radius:10px;
text-align:center;
line-height:20px;
padding:0 5px;
box-shadow:0 3px 8px rgba(255,82,0,.3);
}

.cart-badge.show{
display:block;
}

.no-data{

text-align:center;

font-size:30px;

padding:100px;

color:#ff6b35;

}

.cart-float{

position:fixed;

bottom:30px;
right:30px;

background:#ff6b35;

color:white;

padding:18px 24px;

border-radius:50px;

font-size:20px;

font-weight:bold;

text-decoration:none;

box-shadow:0 12px 25px rgba(0,0,0,.25);

z-index:999;

transition:.3s;

}

.cart-float:hover{

background:#e64900;

transform:scale(1.05);

}

@media(max-width:900px){

.navbar{

padding:20px;
height:auto;

flex-direction:column;

gap:15px;

}

.hero h1{

font-size:40px;

}

.search-box{

width:90%;

}

}

</style>

</head>

<body>

<%
Restaurant restaurant =
(Restaurant)request.getAttribute("restaurant");

List<Menu> allMenusByRestaurant =
(List<Menu>)request.getAttribute("allMenusByRestaurant");
%>

<!-- NAVBAR -->

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
%>
<div class="navbar">

<div class="logo">

🍴 Foodie

</div>

<div class="nav-links" style="align-items:center;">

<a href="home.jsp">Home</a>

<a href="callRestaurantServlet">Restaurants</a>

<form action="search" method="get" style="display:flex;align-items:center;gap:6px;">
<input type="text" name="query" placeholder="Search food..." style="padding:8px 14px;border:2px solid #eee;border-radius:20px;outline:none;font-size:13px;width:160px;transition:.3s;" onfocus="this.style.borderColor='#ff6b35'" onblur="this.style.borderColor='#eee'">
<button type="submit" style="padding:8px 16px;border:none;background:#ff6b35;color:white;border-radius:20px;cursor:pointer;font-weight:600;font-size:13px;">🔍</button>
</form>

<a href="cart.jsp" class="cart-link">
Cart
<span class="cart-badge" id="cartBadge"><%= session.getAttribute("cart") != null ? ((cart)session.getAttribute("cart")).getItems().size() : 0 %></span>
</a>

<%
if(loggedInUser != null){
%>
<span style="display:flex;align-items:center;gap:8px;font-size:15px;font-weight:600;color:#444;">👋 <%=loggedInUser.getName()%></span>
<a href="logout" style="text-decoration:none;color:#e74c3c;font-weight:600;font-size:15px;transition:.3s;">Logout</a>
<%
} else {
%>
<a href="login.jsp" style="text-decoration:none;color:#444;font-size:18px;font-weight:500;transition:.3s;">Login</a>
<%
}
%>

</div>

</div>

<!-- HERO -->

<div class="hero">

<h1>

<%= restaurant!=null ? restaurant.getName() : "Restaurant" %>

</h1>

<p>

Fresh • Delicious • Fast Delivery

</p>

<div class="restaurant-info">

<div class="info">
⭐ <%= restaurant!=null ? restaurant.getRating() : "4.5" %>
</div>

<div class="info">
🍽 <%= restaurant!=null ? restaurant.getCuisineType() : "" %>
</div>

<div class="info">
🕒 <%= restaurant!=null ? restaurant.getDeliveryTime() : 30 %> mins
</div>

<div class="info">
📍 <%= restaurant!=null ? restaurant.getAddress() : "" %>
</div>

</div>

</div>

<!-- SEARCH -->

<div class="search-area">

<input
type="text"
class="search-box"
placeholder="🔍 Search your favourite food...">

</div>

<!-- CATEGORY -->

<div class="category-bar">

<div class="category">🍛 All</div>
<div class="category">🍕 Pizza</div>
<div class="category">🍔 Burger</div>
<div class="category">🍗 Chicken</div>
<div class="category">🍚 Biryani</div>
<div class="category">🍨 Desserts</div>

</div>

<!-- TITLE -->

<div class="title">

<h2>Popular Dishes</h2>

<p>
<%= allMenusByRestaurant!=null ? allMenusByRestaurant.size() : 0 %> Items
</p>

</div>
<!-- ================= MENU ITEMS ================= -->

<div class="menu-container">

<%

if(allMenusByRestaurant != null && !allMenusByRestaurant.isEmpty()){

    for(Menu menu : allMenusByRestaurant){

%>

<div class="card">

    <!-- Bestseller Badge -->
    <div class="badge">
        ⭐ Bestseller
    </div>

    <!-- Food Image -->

    <img
        src="<%=request.getContextPath()%>/<%=menu.getImagePath()%>"
        alt="<%=menu.getItemName()%>">

    <div class="card-content">

        <!-- Title -->

        <div class="item-top">

            <h3>
                <%=menu.getItemName()%>
            </h3>

            <div class="rating">
                ⭐ 4.5
            </div>

        </div>

        <!-- Description -->

        <p class="description">
            <%=menu.getDescription()%>
        </p>

        <!-- Price -->

        <div class="price-row">

            <div class="price">
                ₹ <%=menu.getPrice()%>
            </div>

            <div class="delivery">
                🚀 Fast Delivery
            </div>

        </div>

        <!-- Add To Cart -->

        <form
            action="cartservlet"
            method="post"
            class="add-to-cart-form">

            <input
                type="hidden"
                name="menuId"
                value="<%=menu.getMenuId()%>">

            <input
                type="hidden"
                name="restaurantId"
                value="<%=menu.getRestaurantId()%>">

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

}else{

%>

<div class="no-data">

    <h2>

        😔 No Menu Items Available

    </h2>

</div>

<%

}

%>

</div>

<!-- ================= TOAST NOTIFICATION ================= -->

<div class="toast" id="toast">
    <div class="toast-icon">✅</div>
    <div>
        <div class="toast-title">Added to Cart!</div>
        <div class="toast-item-name" id="toastItemName">Item</div>
        <div class="toast-sub">Check your cart to review</div>
    </div>
</div>

<!-- ================= FLOATING CART ================= -->

<a
href="cart.jsp"
class="cart-float">

🛒 View Cart

</a>
<!-- ================= JAVASCRIPT ================= -->

<script>

// ================= SEARCH =================

const searchBox =
document.querySelector(".search-box");

const cards =
document.querySelectorAll(".card");

searchBox.addEventListener("keyup",function(){

let value =
this.value.toLowerCase();

cards.forEach(card=>{

let name =
card.querySelector("h3")
.innerText
.toLowerCase();

if(name.includes(value)){

card.style.display="block";

}
else{

card.style.display="none";

}

});

});

// ================= CATEGORY FILTER =================

const categoryButtons =
document.querySelectorAll(".category");

categoryButtons.forEach(btn=>{

btn.addEventListener("click",function(){

let category =
this.innerText
.toLowerCase();

cards.forEach(card=>{

let food =
card.querySelector("h3")
.innerText
.toLowerCase();

if(category.includes("all")){

card.style.display="block";

}
else if(food.includes("pizza") && category.includes("pizza")){

card.style.display="block";

}
else if(food.includes("burger") && category.includes("burger")){

card.style.display="block";

}
else if(food.includes("biryani") && category.includes("biryani")){

card.style.display="block";

}
else if(food.includes("chicken") && category.includes("chicken")){

card.style.display="block";

}
else if(
food.includes("ice") ||
food.includes("dessert") ||
food.includes("cake") ||
food.includes("brownie") ||
food.includes("sundae")
){

if(category.includes("desserts")){

card.style.display="block";

}
else{

card.style.display="none";

}

}
else{

card.style.display="none";

}

});

});

});

// ================= ACTIVE CATEGORY =================

categoryButtons.forEach(btn=>{

btn.addEventListener("click",()=>{

categoryButtons.forEach(b=>{

b.style.background="white";
b.style.color="#222";

});

btn.style.background="#ff6b35";
btn.style.color="white";

});

});

// ================= CART BADGE INIT =================

function updateCartBadge(){
    var badge = document.getElementById('cartBadge');
    if(!badge) return;
    var count = parseInt(badge.textContent) || 0;
    if(count > 0){
        badge.classList.add('show');
    }else{
        badge.classList.remove('show');
    }
}
updateCartBadge();

// ================= ADD TO CART AJAX =================

document.querySelectorAll('.add-to-cart-form').forEach(function(form){
    form.addEventListener('submit', function(e){
        e.preventDefault();
        
        var formData = new FormData(this);
        formData.append('ajax', 'true');
        
        var btn = this.querySelector('.btn');
        var originalText = btn.innerHTML;
        btn.innerHTML = '⏳ Adding...';
        btn.disabled = true;
        
        fetch('cartservlet', {
            method: 'POST',
            body: formData
        })
        .then(function(res){ return res.json(); })
        .then(function(data){
            if(data.success){
                // Update badge count
                var badge = document.getElementById('cartBadge');
                if(badge){
                    badge.textContent = data.cartCount;
                    if(data.cartCount > 0){
                        badge.classList.add('show');
                    }else{
                        badge.classList.remove('show');
                    }
                }
                // Show toast
                var toast = document.getElementById('toast');
                var toastName = document.getElementById('toastItemName');
                if(toast && toastName){
                    toastName.textContent = data.itemName;
                    toast.classList.add('show');
                    setTimeout(function(){
                        toast.classList.remove('show');
                    }, 3000);
                }
            }
            btn.innerHTML = originalText;
            btn.disabled = false;
        })
        .catch(function(){
            btn.innerHTML = originalText;
            btn.disabled = false;
            // Fallback: submit normally
            var fallbackInput = document.createElement('input');
            fallbackInput.type = 'hidden';
            fallbackInput.name = 'ajax';
            fallbackInput.value = 'false';
            form.appendChild(fallbackInput);
            form.submit();
        });
    });
});

</script>

</body>

</html>