<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.cart"%>
<%@ page import="com.tap.model.cartItem"%>
<%@ page import="java.util.Map"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Checkout | Foodie</title>

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

/* ================= CONTAINER ================= */

.container{

width:90%;
margin:35px auto;
display:flex;
gap:30px;
align-items:flex-start;

}

.left{

width:65%;

}

.right{

width:35%;

}

/* ================= SECTION ================= */

.section{

background:white;
padding:25px;
border-radius:15px;
box-shadow:0 6px 20px rgba(0,0,0,.12);
margin-bottom:25px;

}

.section h2{

margin-bottom:20px;
color:#333;

}

/* ================= INPUTS ================= */

.input-group{

margin-bottom:18px;

}

.input-group label{

display:block;
margin-bottom:8px;
font-weight:600;

}

.input-group input,
.input-group textarea{

width:100%;
padding:14px;
border:1px solid #ddd;
border-radius:8px;
font-size:16px;
outline:none;

}

.input-group input:focus,
.input-group textarea:focus{

border-color:#ff6b35;

}

.row{

display:flex;
gap:20px;

}

.row .input-group{

flex:1;

}

/* ================= SUMMARY ================= */

.summary{

background:white;
padding:25px;
border-radius:15px;
box-shadow:0 6px 20px rgba(0,0,0,.12);
position:sticky;
top:30px;

}

.summary h2{

margin-bottom:20px;

}

.bill-row{

display:flex;
justify-content:space-between;
margin:12px 0;
font-size:17px;

}

hr{

margin:18px 0;

}

.total{

font-size:24px;
font-weight:bold;
color:#28a745;

}

@media(max-width:900px){

.container{

flex-direction:column;

}

.left,
.right{

width:100%;

}

.row{

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

</div>

</div>

<%

cart cartObj=(cart)session.getAttribute("cart");

double subtotal=0;

if(cartObj!=null){

for(cartItem item:cartObj.getItems().values()){

subtotal+=item.getPrice()*item.getQuantity();

}

}

double delivery=40;
double gst=subtotal*0.05;
double grandTotal=subtotal+delivery+gst;

%>

<div class="container">

<!-- LEFT SIDE -->

<div class="left">

<form action="<%=request.getContextPath()%>/orderservlet" method="post">

<div class="section">

<h2>📍 Delivery Address</h2>

<div class="row">

<div class="input-group">

<label>Full Name</label>

<input
type="text"
name="name"
placeholder="Enter your full name"
required>

</div>

<div class="input-group">

<label>Phone Number</label>

<input
type="tel"
name="phone"
placeholder="10-digit mobile number"
required>

</div>

</div>

<div class="input-group">

<label>House / Flat No.</label>

<input
type="text"
name="house"
placeholder="House Number"
required>

</div>

<div class="input-group">

<label>Street Address</label>

<textarea
name="street"
rows="3"
placeholder="Street, Area, Landmark"
required></textarea>

</div>

<div class="row">

<div class="input-group">

<label>City</label>

<input
type="text"
name="city"
required>

</div>

<div class="input-group">

<label>State</label>

<input
type="text"
name="state"
required>

</div>

<div class="input-group">

<label>Pincode</label>

<input
type="text"
name="pincode"
required>

</div>

</div>

</div>
<!-- ================= PAYMENT SECTION ================= -->

<div class="section">

<h2>💳 Payment Method</h2>

<div class="input-group">

<label>

<input
type="radio"
name="paymentMethod"
value="Cash on Delivery"
checked>

Cash On Delivery

</label>

</div>

<div class="input-group">

<label>

<input
type="radio"
name="paymentMethod"
value="UPI">

UPI

</label>

</div>

<div class="input-group">

<label>

<input
type="radio"
name="paymentMethod"
value="Credit Card">

Credit Card

</label>

</div>

<div class="input-group">

<label>

<input
type="radio"
name="paymentMethod"
value="Debit Card">

Debit Card

</label>

</div>

</div>

<!-- END OF LEFT COLUMN -->

</div>

<!-- ================= RIGHT SIDE ================= -->

<div class="right">

<div class="summary">

<h2>🧾 Order Summary</h2>

<%

if(cartObj!=null && !cartObj.getItems().isEmpty()){

for(cartItem item : cartObj.getItems().values()){

double itemTotal=item.getPrice()*item.getQuantity();

%>

<div class="bill-row">

<span>

<%=item.getName()%>

x <%=item.getQuantity()%>

</span>

<span>

₹ <%=String.format("%.2f",itemTotal)%>

</span>

</div>

<%

}

}

%>

<hr>

<div class="bill-row">

<span>Subtotal</span>

<span>

₹ <%=String.format("%.2f",subtotal)%>

</span>

</div>

<div class="bill-row">

<span>Delivery Fee</span>

<span>

₹ <%=String.format("%.2f",delivery)%>

</span>

</div>

<div class="bill-row">

<span>GST (5%)</span>

<span>

₹ <%=String.format("%.2f",gst)%>

</span>

</div>

<hr>

<div class="bill-row total">

<span>Total</span>

<span>

₹ <%=String.format("%.2f",grandTotal)%>

</span>

</div>
<hr>

<p style="text-align:center;
margin:15px 0;
color:#666;
font-size:15px;">

🚚 Estimated Delivery :
<b>25 - 35 Minutes</b>

</p>

<p style="text-align:center;
color:#666;
margin-bottom:20px;">

🔒 100% Secure Payments

</p>

<button
type="submit"
style="
width:100%;
padding:16px;
background:#28a745;
color:white;
font-size:20px;
border:none;
border-radius:10px;
cursor:pointer;
transition:.3s;">

🛍 Place Order

</button>

</div>

</div>

</form>

</div>

<!-- ================= FOOTER ================= -->

<footer style="
margin-top:50px;
background:#222;
color:white;
padding:25px;
text-align:center;">

<h2>🍔 Foodie</h2>

<p style="margin-top:10px;">
Fast • Fresh • Delicious
</p>

<p style="margin-top:15px;font-size:14px;">
© 2026 Foodie. All Rights Reserved.
</p>

</footer>

</body>
</html>
