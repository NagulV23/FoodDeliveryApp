<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.cart"%>
<%@ page import="com.tap.model.cartItem"%>
<%@ page import="java.util.Map"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>My Cart | Foodie</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Segoe UI',sans-serif;
}

body{
background:#f5f5f5;
}

/* ================= NAVBAR ================= */

.navbar{
display:flex;
justify-content:space-between;
align-items:center;
padding:18px 60px;
background:linear-gradient(90deg,#ff6b35,#ff914d);
color:white;
position:sticky;
top:0;
z-index:1000;
box-shadow:0 3px 10px rgba(0,0,0,.2);
}

.logo{
font-size:30px;
font-weight:bold;
}

.nav-links a{
text-decoration:none;
color:white;
margin-left:25px;
font-size:18px;
transition:.3s;
}

.nav-links a:hover{
color:#ffe082;
}

/* ================= PAGE ================= */

.container{
width:90%;
margin:35px auto;
display:flex;
gap:30px;
align-items:flex-start;
}

.left{
width:70%;
}

.right{
width:30%;
}

/* ================= TITLE ================= */

.cart-title{
font-size:35px;
margin-bottom:25px;
color:#333;
}

/* ================= CARD ================= */

.card{
background:white;
border-radius:15px;
padding:30px;
margin-bottom:20px;
display:flex;
justify-content:space-between;
align-items:center;
box-shadow:0 6px 20px rgba(0,0,0,.12);
transition:.3s;
}

.card:hover{
 transform:translateY(-8px);
    box-shadow:0 12px 30px rgba(0,0,0,.18);
}

.food{
display:flex;
align-items:center;
gap:20px;
}

.food img{
    width:150px;
    height:150px;
    border-radius:15px;
    object-fit:cover;
    box-shadow:0 6px 15px rgba(0,0,0,.15);
}

.food-details h3{
font-size:24px;
margin-bottom:8px;
}

.food-details p{
margin:6px 0;
color:#666;
}

/* ================= BUTTONS ================= */

.actions{
display:flex;
align-items:center;
gap:10px;
}

.btn{
border:none;
cursor:pointer;
border-radius:8px;
padding:10px 18px;
font-size:16px;
transition:.3s;
}

.plus{
width:50px;
    height:50px;
    border-radius:50%;
    font-size:22px;
    font-weight:bold;
}

.plus:hover{
background:#1e7e34;
}

.minus{
width:50px;
    height:50px;
    border-radius:50%;
    font-size:22px;
    font-weight:bold;
}

.minus:hover{
background:#e0a800;
}

.delete{
background:#dc3545;
color:white;
    padding:14px 20px;
    border-radius:25px;
    font-weight:bold;
}

.delete:hover{
background:#b02a37;
}
/* ================= ORDER SUMMARY ================= */

.summary{

background:white;
padding:25px;
   border-radius:20px;
    box-shadow:0 10px 30px rgba(0,0,0,.12);
position:sticky;
top:100px;

}

.summary h2{

margin-bottom:20px;
color:#333;

}

.bill-row{

display:flex;
justify-content:space-between;
margin:15px 0;
font-size:17px;

}

.summary hr{

margin:15px 0;

}

.grand{

font-size:24px;
font-weight:bold;
color:#28a745;

}

/* ================= COUPON ================= */

.coupon{

margin:25px 0;

}

.coupon input{

width:100%;
padding:12px;
border:1px solid #ddd;
border-radius:8px;
font-size:16px;

}

.apply{

margin-top:10px;
width:100%;
padding:12px;
border:none;
background:#ff6b35;
color:white;
border-radius:8px;
font-size:17px;
cursor:pointer;

}

.apply:hover{

background:#e55b2b;

}

/* ================= BUTTONS ================= */

.continue{

display:block;
width:100%;
text-align:center;
padding:15px;
margin-top:20px;
text-decoration:none;
background:#2196f3;
color:white;
border-radius:10px;
font-size:18px;
transition:.3s;

}

.continue:hover{

background:#0d8bf2;

}

.checkout{

width:100%;
padding:16px;
margin-top:20px;
border:none;
background:#28a745;
color:white;
font-size:20px;
border-radius:10px;
cursor:pointer;
transition:.3s;

}

.checkout:hover{

background:#218838;

}

/* ================= EMPTY CART ================= */

.empty{

text-align:center;
padding:100px;
font-size:28px;
color:#888;

}

.empty a{

display:inline-block;
margin-top:25px;
padding:15px 35px;
background:#ff6b35;
color:white;
text-decoration:none;
border-radius:10px;

}

/* ================= RESPONSIVE ================= */

@media(max-width:900px){

.container{

flex-direction:column;

}

.left,
.right{

width:100%;

}

.card{

flex-direction:column;
text-align:center;

}

.food{

flex-direction:column;

}

}

</style>

</head>

<body>

<!-- ================= NAVBAR ================= -->

<div class="navbar">

<div class="logo">

🍔 Foodie

</div>

<div class="nav-links">

<a href="home.jsp">Home</a>

<a href="callRestaurantServlet">Restaurants</a>

<a href="cart.jsp">Cart</a>

<a href="login.jsp">Login</a>

</div>

</div>

<%

cart cartObj = (cart) session.getAttribute("cart");

if(cartObj == null){

    cartObj = new cart();

    session.setAttribute("cart", cartObj);

}

double subtotal = 0;
double delivery = 40;
double gst = 0;
double grandTotal = 0;

int itemCount = cartObj.getItems().size();

%>

<div class="container">

<div class="left">

<h1 class="cart-title">

🛒 My Cart
</h1>

<%

if(cartObj!=null && !cartObj.getItems().isEmpty()){

Map<Integer,cartItem> items=cartObj.getItems();

for(cartItem item:items.values()){

double itemTotal=item.getPrice()*item.getQuantity();

subtotal+=itemTotal;

%>

<div class="card">

<div class="food">

<img
    src="<%=request.getContextPath()%>/images/<%=item.getImagePath()%>"
    alt="<%=item.getName()%>"
    style="width:120px;height:120px;object-fit:cover;border-radius:12px;">
<div class="food-details">

<h3><%=item.getName()%></h3>

<p>

💰 Price :
<b>₹ <%=item.getPrice()%></b>

</p>

<p>

📦 Quantity :
<b><%=item.getQuantity()%></b>

</p>

<p>

Subtotal :
<b style="color:green;">
₹ <%=itemTotal%>
</b>

</p>

</div>

</div>

<div class="actions">

<!-- Minus -->

<form action="cartservlet" method="post">

<input
type="hidden"
name="menuId"
value="<%=item.getMenuId()%>">

<input
type="hidden"
name="quantity"
value="<%=item.getQuantity()-1%>">

<input
type="hidden"
name="action"
value="update">

<button
class="btn minus"
type="submit">

➖

</button>

</form>

<!-- Plus -->

<form action="cartservlet" method="post">

<input
type="hidden"
name="menuId"
value="<%=item.getMenuId()%>">

<input
type="hidden"
name="quantity"
value="<%=item.getQuantity()+1%>">

<input
type="hidden"
name="action"
value="update">

<button
class="btn plus"
type="submit">

➕

</button>

</form>

<!-- Delete -->

<form action="cartservlet" method="post">

<input
type="hidden"
name="menuId"
value="<%=item.getMenuId()%>">

<input
type="hidden"
name="action"
value="remove">

<button
class="btn delete"
type="submit">

🗑 Remove

</button>

</form>

</div>

</div>

<%

}

}

else{

%>

<div class="empty">

<h2>

🛒 Your Cart is Empty

</h2>

<br>

<p>

Looks like you haven't added any delicious food yet.

</p>

<br>

<a href="callRestaurantServlet">

🍴 Browse Restaurants

</a>

</div>

<%

}

%>

</div>

<!-- RIGHT SIDE SUMMARY -->

<div class="right">

<div style="font-size:20px;font-weight:bold;margin-bottom:15px;">

🛒 <%=itemCount%> Item<%=itemCount!=1?"s":""%>

</div>

<%

if(itemCount>0){

    gst = subtotal * 0.05;
    grandTotal = subtotal + delivery + gst;

}else{

    delivery = 0;
    gst = 0;
    grandTotal = 0;

}

%>

<div class="summary">
<h2>🧾 Bill Details</h2>

<div class="coupon">

<input
type="text"
placeholder="Enter Coupon Code">

<button
class="apply">

Apply Coupon

</button>

</div>

<div class="bill-row">

<span>Subtotal</span>

<span>

₹ <%=String.format("%.2f", itemCount>0 ? subtotal : 0.0)%>

</span>

</div>

<div class="bill-row">

<span>Delivery Fee</span>

<span>

₹ <%=String.format("%.2f", itemCount>0 ? delivery : 0.0)%>

</span>

</div>

<div class="bill-row">

<span>GST (5%)</span>

<span>

₹ <%=String.format("%.2f", itemCount>0 ? gst : 0.0)%>

</span>

</div>

<hr>

<div class="bill-row grand">

<span>Total</span>

<span>

₹ <%=String.format("%.2f", itemCount>0 ? grandTotal : 0.0)%>

</span>

</div>

<a
href="callRestaurantServlet"
class="continue">

🛍 Continue Shopping

</a>

<%

if(itemCount>0){

%>

<form action="checkout.jsp" method="get">

<button
type="submit"
class="checkout">

💳 Proceed To Checkout

</button>

</form>

<%

}else{

%>

<button
class="checkout"
disabled
style="background:#cccccc;cursor:not-allowed;">

Cart is Empty

</button>

<%

}

%>



</div>   <!-- summary -->

</div>   <!-- right -->

</div>   <!-- container -->

</body>
</html>

