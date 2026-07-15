<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.Map"%>
<%@ page import="com.tap.model.cart"%>
<%@ page import="com.tap.model.cartItem"%>
<%@ page import="com.tap.model.User"%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<title>My Cart | Foodie</title>

<link rel="preconnect"
href="https://fonts.googleapis.com">

<link rel="preconnect"
href="https://fonts.gstatic.com"
crossorigin>

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap"
rel="stylesheet">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
}

body{

background:
linear-gradient(135deg,#fff7f2,#fff,#fff7f2);

}

/* ================= NAVBAR ================= */

.navbar{

height:80px;

padding:0 70px;

display:flex;

justify-content:space-between;

align-items:center;

background:white;

box-shadow:0 10px 30px rgba(0,0,0,.08);

position:sticky;

top:0;

z-index:999;

}

.logo{

font-size:34px;

font-weight:700;

color:#ff6b35;

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

/* ================= HERO ================= */

.hero{

width:92%;

margin:35px auto;

padding:45px;

border-radius:30px;

background:
linear-gradient(135deg,#ff6b35,#ff914d);

color:white;

display:flex;

justify-content:space-between;

align-items:center;

box-shadow:0 25px 45px rgba(255,107,53,.30);

}

.hero-left h1{

font-size:52px;

margin-bottom:12px;

}

.hero-left p{

font-size:19px;

opacity:.95;

line-height:1.7;

}

.hero-right{

display:flex;

gap:18px;

flex-wrap:wrap;

justify-content:center;

}

.hero-box{

background:rgba(255,255,255,.15);

padding:18px 28px;

border-radius:20px;

backdrop-filter:blur(10px);

font-size:17px;

font-weight:600;

}

/* ================= CONTAINER ================= */

.container{

width:92%;

margin:auto;

display:grid;

grid-template-columns:2fr 1fr;

gap:30px;

padding-bottom:60px;

}

/* ================= LEFT ================= */

.left-section{

display:flex;

flex-direction:column;

gap:25px;

}

.section-title{

font-size:34px;

font-weight:700;

color:#222;

}

/* ================= CARD ================= */

.cart-card{

display:flex;

justify-content:space-between;

align-items:center;

background:rgba(255,255,255,.75);

backdrop-filter:blur(15px);

border-radius:24px;

padding:22px;

box-shadow:0 15px 40px rgba(0,0,0,.08);

transition:.35s;

}

.cart-card:hover{

transform:translateY(-8px);

}

.food-left{

display:flex;

gap:18px;

align-items:center;

}

/* FIXED IMAGE SIZE */

.food-left img{

width:110px;

height:110px;

border-radius:18px;

object-fit:cover;

box-shadow:0 10px 25px rgba(0,0,0,.15);

flex-shrink:0;

}

.food-info h2{

font-size:24px;

margin-bottom:6px;

color:#222;

}

.tag{

display:inline-block;

padding:6px 12px;

border-radius:20px;

background:#e8fff0;

color:#27ae60;

font-size:13px;

font-weight:600;

margin-bottom:12px;

}

.desc{

color:#777;

font-size:15px;

line-height:1.6;

max-width:350px;

}

.price{

font-size:30px;

font-weight:bold;

color:#ff6b35;

margin-top:10px;

}

/* ================= RIGHT OF CARD ================= */

.food-right{

display:flex;

flex-direction:column;

align-items:center;

gap:18px;

}

.qty-box{

display:flex;

align-items:center;

gap:12px;

background:#f6f6f6;

padding:8px 16px;

border-radius:40px;

}

.qty-btn{

width:36px;

height:36px;

border:none;

border-radius:50%;

background:#ff6b35;

color:white;

font-size:20px;

cursor:pointer;

transition:.3s;

}

.qty-btn:hover{

transform:scale(1.08);

}

.qty{

font-size:18px;

font-weight:700;

min-width:25px;

text-align:center;

}

.remove-btn{

background:#ff4d4f;

color:white;

border:none;

padding:12px 26px;

border-radius:30px;

font-size:15px;

cursor:pointer;

transition:.3s;

}

.remove-btn:hover{

background:#d9363e;

}

/* ================= SUMMARY ================= */

.summary{

background:white;

border-radius:28px;

padding:30px;

box-shadow:0 20px 40px rgba(0,0,0,.08);

position:sticky;

top:100px;

height:fit-content;

}

.summary h2{

margin-bottom:25px;

font-size:30px;

}

.bill{

display:flex;

justify-content:space-between;

margin:15px 0;

font-size:18px;

}

.total{

font-size:28px;

font-weight:bold;

color:#ff6b35;

margin-top:15px;

}

.coupon{

display:flex;

margin:25px 0;

gap:10px;

}

.coupon input{

flex:1;

padding:14px;

border-radius:12px;

border:1px solid #ddd;

}

.apply{

padding:14px 22px;

border:none;

border-radius:12px;

background:#ff6b35;

color:white;

cursor:pointer;

}

.checkout{

width:100%;

padding:16px;

margin-top:20px;

border:none;

border-radius:14px;

background:#27ae60;

color:white;

font-size:20px;

cursor:pointer;

}

.continue{

display:block;

margin-top:18px;

text-align:center;

text-decoration:none;

font-weight:600;

color:#ff6b35;

}

/* ================= EMPTY ================= */

.empty{

text-align:center;

padding:80px;

font-size:30px;

color:#888;

}

.empty a{

display:inline-block;

margin-top:25px;

padding:15px 35px;

background:#ff6b35;

color:white;

border-radius:12px;

text-decoration:none;

}

/* ================= RESPONSIVE ================= */

@media(max-width:950px){

.container{

grid-template-columns:1fr;

}

.hero{

flex-direction:column;

gap:25px;

text-align:center;

}

.cart-card{

flex-direction:column;

gap:20px;

}

.food-left{

flex-direction:column;

text-align:center;

}

}

</style>

</head>

<body>

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    int cartCount = (session.getAttribute("cart") != null) ? ((cart)session.getAttribute("cart")).getItems().size() : 0;
    String cartBadgeStyle = (cartCount > 0) ? "" : "display:none;";
%>
<div class="navbar">

<div class="logo">
🍔 Foodie
</div>

<div class="nav-links">

<a href="home.jsp">Home</a>

<a href="callRestaurantServlet">Restaurants</a>

<a href="cart.jsp" style="position:relative;">Cart <span class="nav-cart-badge" style="<%= cartBadgeStyle %>position:absolute;top:-8px;right:-14px;background:#ff6b35;color:white;font-size:10px;font-weight:700;min-width:18px;height:18px;border-radius:9px;text-align:center;line-height:18px;padding:0 4px;box-shadow:0 2px 6px rgba(255,107,53,.4);"><%= cartCount %></span></a>

<%
if(loggedInUser != null){
%>
<span style="display:flex;align-items:center;gap:10px;font-size:15px;font-weight:600;color:#444;">👋 <%=loggedInUser.getName()%></span>
<a href="logout" style="text-decoration:none;color:#e74c3c;font-weight:600;font-size:16px;transition:.3s;">Logout</a>
<%
} else {
%>
<a href="login.jsp" style="text-decoration:none;color:#444;font-size:18px;font-weight:500;transition:.3s;">Login</a>
<%
}
%>

</div>

</div>

<div class="hero">

<div class="hero-left">

<h1>🛒 Your Cart</h1>

<p>
Fresh food. Fast delivery. Secure checkout.
Review your delicious order before placing it.
</p>

</div>

<div class="hero-right">

<div class="hero-box">
⚡ Fast Delivery
</div>

<div class="hero-box">
🔥 Hot & Fresh
</div>

<div class="hero-box">
💳 Secure Payment
</div>

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

<!-- ================= LEFT SECTION ================= -->

<div class="left-section">

<h2 class="section-title">
Shopping Cart
</h2>

<%

if(itemCount > 0){

Map<Integer,cartItem> items = cartObj.getItems();

for(cartItem item : items.values()){

double itemTotal =
item.getPrice() * item.getQuantity();

subtotal += itemTotal;

%>

<!-- ================= CART CARD ================= -->

<div class="cart-card">

<div class="food-left">

<img
src="<%=request.getContextPath()%>/<%=item.getImagePath()%>"
alt="<%=item.getName()%>">

<div class="food-info">

<h2>
<%=item.getName()%>
</h2>

<div class="tag">
Fresh • Bestseller
</div>

<p class="desc">
Prepared with premium ingredients and delivered hot to your doorstep.
</p>

<div class="price">
₹ <%=item.getPrice()%>
</div>

</div>

</div>

<div class="food-right">

<!-- Quantity -->

<div class="qty-box">

<form
action="cartservlet"
method="post">

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
class="qty-btn"
type="submit">
−
</button>

</form>

<div class="qty">
<%=item.getQuantity()%>
</div>

<form
action="cartservlet"
method="post">

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
class="qty-btn"
type="submit">
+
</button>

</form>

</div>

<div style="font-size:18px;font-weight:600;color:#27ae60;">

Subtotal

<br>

₹ <%=String.format("%.2f",itemTotal)%>

</div>

<form
action="cartservlet"
method="post">

<input
type="hidden"
name="menuId"
value="<%=item.getMenuId()%>">

<input
type="hidden"
name="action"
value="remove">

<button
class="remove-btn"
type="submit">

🗑 Remove

</button>

</form>

</div>

</div>

<%
}

}else{
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

Browse Restaurants 🍔

</a>

</div>

<%
}
%>

</div>
<!-- ================= RIGHT SIDE ================= -->

<div class="summary">

<%
if(itemCount > 0){

    gst = subtotal * 0.05;
    grandTotal = subtotal + delivery + gst;

}else{

    delivery = 0;
    gst = 0;
    grandTotal = 0;

}
%>

<h2>🧾 Order Summary</h2>

<!-- Coupon -->

<div class="coupon">

<input
type="text"
id="cartCouponInput"
placeholder="🎉 Enter Coupon Code"
autocomplete="off">

<button
class="apply"
id="cartApplyBtn"
onclick="applyCartCoupon()">

Apply

</button>

</div>

<div id="cartCouponMsg" style="margin:10px 0;"></div>

<!-- Bill -->

<div class="bill">

<span>

Subtotal

</span>

<span>

₹ <%=String.format("%.2f",subtotal)%>

</span>

</div>

<div class="bill">

<span>

Delivery Fee

</span>

<span>

₹ <%=String.format("%.2f",delivery)%>

</span>

</div>

<div class="bill">

<span>

GST (5%)

</span>

<span>

₹ <%=String.format("%.2f",gst)%>

</span>

</div>

<hr
style="margin:20px 0;
border:none;
height:1px;
background:#ddd;"><div class="bill" id="cartDiscountRow" style="display:none;color:#27ae60;">
    <span>🎉 Coupon Discount</span>
    <span id="cartDiscountAmount">-₹0.00</span>
</div>

<div class="bill total">

<span>

Total

</span>

<span id="cartGrandTotal">

₹ <%=String.format("%.2f",grandTotal)%>

</span>

</div>

<!-- Continue Shopping -->

<a
href="callRestaurantServlet"
class="continue">

← Continue Shopping

</a>

<!-- Checkout -->

<%
if(itemCount>0){
%>

<form
action="checkout.jsp"
method="get">

<button
type="submit"
class="checkout">

Proceed to Checkout →

</button>

</form>

<%
}else{
%>

<button
class="checkout"
disabled
style="
background:#cccccc;
cursor:not-allowed;">

Cart is Empty

</button>

<%
}
%>

</div>

</div>

<!-- ================= FOOTER ================= -->

<footer
style="
margin-top:70px;
padding:35px;
text-align:center;
background:white;
box-shadow:0 -5px 20px rgba(0,0,0,.08);
font-size:16px;
color:#666;">

Made with ❤️ using Java, JSP, Servlets & MySQL

</footer>


<script>
var cartAppliedDiscount = 0;
var cartSubtotal = parseFloat('<%= String.format("%.2f", subtotal) %>');
var cartDelivery = parseFloat('<%= String.format("%.0f", delivery) %>');
var cartGst = parseFloat('<%= String.format("%.2f", gst) %>');

function applyCartCoupon() {
    var input = document.getElementById('cartCouponInput');
    var btn = document.getElementById('cartApplyBtn');
    var msgDiv = document.getElementById('cartCouponMsg');
    var code = input.value.trim();

    if (!code) {
        msgDiv.innerHTML = '<div style="padding:10px 14px;background:#fff0f0;border-left:4px solid #e74c3c;border-radius:8px;font-size:14px;color:#e74c3c;">⚠️ Please enter a coupon code.</div>';
        return;
    }

    btn.innerHTML = '⏳';
    btn.disabled = true;

    fetch('applycoupon', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=validate&code=' + encodeURIComponent(code)
    })
    .then(function(res) { return res.json(); })
    .then(function(data) {
        if (data.valid) {
            cartAppliedDiscount = data.discountAmount;

            // Show discount row
            var discountRow = document.getElementById('cartDiscountRow');
            var discountAmt = document.getElementById('cartDiscountAmount');
            discountRow.style.display = 'flex';
            discountAmt.textContent = '-₹' + data.discountAmount.toFixed(2);

            // Update grand total
            var total = cartSubtotal + cartDelivery + cartGst - data.discountAmount;
            document.getElementById('cartGrandTotal').innerHTML = '₹ ' + total.toFixed(2);

            msgDiv.innerHTML = '<div style="padding:10px 14px;background:#e8fff0;border-left:4px solid #27ae60;border-radius:8px;font-size:14px;color:#27ae60;">✅ Coupon applied! You saved ₹' + data.discountAmount.toFixed(0) + '</div>';
            input.style.borderColor = '#27ae60';
            btn.innerHTML = '✅';
            btn.style.background = '#27ae60';
        } else {
            cartAppliedDiscount = 0;
            document.getElementById('cartDiscountRow').style.display = 'none';
            var total = cartSubtotal + cartDelivery + cartGst;
            document.getElementById('cartGrandTotal').innerHTML = '₹ ' + total.toFixed(2);

            msgDiv.innerHTML = '<div style="padding:10px 14px;background:#fff0f0;border-left:4px solid #e74c3c;border-radius:8px;font-size:14px;color:#e74c3c;">⚠️ ' + data.message + '</div>';
            input.style.borderColor = '#e74c3c';
            btn.innerHTML = 'Apply';
            btn.style.background = '#ff6b35';
        }
        btn.disabled = false;
    })
    .catch(function() {
        msgDiv.innerHTML = '<div style="padding:10px 14px;background:#fff0f0;border-left:4px solid #e74c3c;border-radius:8px;font-size:14px;color:#e74c3c;">⚠️ Could not validate coupon.</div>';
        btn.innerHTML = 'Apply';
        btn.disabled = false;
    });
}

document.getElementById('cartCouponInput').addEventListener('keyup', function(e) {
    if (e.key === 'Enter') {
        applyCartCoupon();
    }
});
</script>

</body>

</html>