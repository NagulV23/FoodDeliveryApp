<%@ page language="java"
contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="com.tap.model.cart"%>
<%@ page import="com.tap.model.cartItem"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.Collection"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="UTF-8">

<title>Checkout | Foodie</title>

<meta name="viewport"
content="width=device-width, initial-scale=1.0">

<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800;900&display=swap"
rel="stylesheet">

<style>

*{

margin:0;
padding:0;
box-sizing:border-box;
font-family:'Poppins',sans-serif;
scroll-behavior:smooth;

}

body{

background:#f4f6fa;

}

/*================ NAVBAR ================*/

.navbar{

height:76px;

background:rgba(255,255,255,.92);
backdrop-filter:blur(20px);
-webkit-backdrop-filter:blur(20px);

display:flex;

justify-content:space-between;

align-items:center;

padding:0 60px;

box-shadow:0 8px 25px rgba(0,0,0,.06);

position:sticky;

top:0;

z-index:999;

transition:.3s;

}

.logo{

font-size:30px;

font-weight:800;

color:#ff6b35;

text-decoration:none;

}

.logo span{

background:linear-gradient(135deg,#ff6b35,#ff914d);
-webkit-background-clip:text;
-webkit-text-fill-color:transparent;

}

.nav-links{

display:flex;

gap:30px;

}

.nav-links a{

text-decoration:none;

color:#555;

font-size:15px;

transition:.3s;

font-weight:500;

position:relative;

}

.nav-links a::after{
content:'';
position:absolute;
bottom:-4px;
left:0;
width:0;
height:2.5px;
background:linear-gradient(90deg,#ff6b35,#ff914d);
border-radius:4px;
transition:.3s;
}

.nav-links a:hover{

color:#ff6b35;

}

.nav-links a:hover::after{
width:100%;
}

/*================ PROGRESS BAR ================*/

.progress-wrapper{max-width:600px;margin:40px auto 30px;padding:0 20px;}

.progress-bar{
display:flex;
justify-content:space-between;
align-items:center;
position:relative;
}

.progress-bar::before{
content:'';
position:absolute;
top:50%;
left:15%;
right:15%;
height:3px;
background:#e0e0e0;
transform:translateY(-50%);
z-index:0;
border-radius:4px;
}

.progress-fill{
position:absolute;
top:50%;
left:15%;
height:3px;
background:linear-gradient(90deg,#ff6b35,#ff914d);
transform:translateY(-50%);
z-index:1;
border-radius:4px;
transition:width .6s ease;
width:66%;
}

.prog-step{
display:flex;
flex-direction:column;
align-items:center;
position:relative;
z-index:2;
}

.prog-circle{
width:42px;
height:42px;
border-radius:50%;
display:flex;
justify-content:center;
align-items:center;
font-weight:700;
font-size:16px;
background:#e0e0e0;
color:white;
transition:.4s;
box-shadow:0 4px 12px rgba(0,0,0,.08);
}

.prog-circle.active{
background:linear-gradient(135deg,#ff6b35,#ff914d);
box-shadow:0 6px 20px rgba(255,107,53,.3);
transform:scale(1.05);
}

.prog-circle.done{
background:#27ae60;
box-shadow:0 6px 20px rgba(39,174,96,.3);
}

.prog-label{
font-size:13px;
margin-top:8px;
color:#888;
font-weight:500;
}

.prog-label.active{
color:#ff6b35;
font-weight:600;
}

/*================ MAIN CONTAINER ================*/

.container{

width:92%;

margin:auto;

display:flex;

gap:30px;

align-items:flex-start;

}

.left{

width:60%;

}

.right{

width:40%;

position:sticky;

top:100px;

}

/*================ CARD ================*/

.card{

background:white;

padding:25px;

border-radius:18px;

box-shadow:0 8px 20px rgba(0,0,0,.08);

margin-bottom:25px;

transition:.3s;

}

.card:hover{

transform:translateY(-4px);

}

.card h2{

font-size:25px;

color:#333;

margin-bottom:20px;

}

/*================ CART ITEM ================*/

.cart-item{

display:flex;

justify-content:space-between;

align-items:center;

padding:20px 0;

border-bottom:1px solid #eee;

}

.item-left{

display:flex;

align-items:center;

gap:18px;

}

.food-img{

width:100px;

height:100px;

border-radius:15px;

object-fit:cover;

border:1px solid #ddd;

}

.item-name{

font-size:20px;

font-weight:600;

color:#222;

}

.item-price{

margin-top:8px;

color:#666;

font-size:15px;

}

.item-total{

font-size:22px;

font-weight:bold;

color:#28a745;

}
/*================ BILL SUMMARY ================*/

.bill-row{

display:flex;

justify-content:space-between;

margin:16px 0;

font-size:18px;

color:#444;

}

.bill-row span:last-child{

font-weight:600;

}

.grand{

font-size:28px;

font-weight:bold;

color:#28a745;

}

/*================ INPUT FIELDS ================*/

.input-group{

margin-bottom:18px;

}

.input-group label{

display:block;

margin-bottom:8px;

font-weight:600;

color:#333;

}

.input-group input{

width:100%;

padding:14px;

border:1px solid #ddd;

border-radius:10px;

font-size:16px;

transition:.3s;

}

.input-group input:hover{

border-color:#ff6b35;

}

.input-group input:focus{

outline:none;

border:2px solid #ff6b35;

box-shadow:0 0 8px rgba(255,107,53,.2);

}

/*================ PAYMENT OPTIONS ================*/

.payment-option{

display:flex;

align-items:center;

gap:15px;

padding:16px;

border:2px solid #eee;

border-radius:12px;

margin-bottom:15px;

cursor:pointer;

transition:.3s;

background:#fff;

}

.payment-option:hover{

border-color:#ff6b35;

background:#fff6f1;

}

.payment-option input{

width:20px;

height:20px;

cursor:pointer;

}

.payment-icon{

font-size:28px;

}

.payment-title{

font-size:17px;

font-weight:600;

}

.payment-sub{

font-size:13px;

color:#777;

}

/*================ COUPON BOX ================*/

.coupon-box{

display:flex;

gap:12px;

margin-top:15px;

}

.coupon-box input{

flex:1;

padding:14px;

border:1px solid #ddd;

border-radius:10px;

font-size:15px;

}

.apply-btn{

padding:14px 24px;

border:none;

background:#ff6b35;

color:white;

border-radius:10px;

cursor:pointer;

font-weight:600;

transition:.3s;

}

.apply-btn:hover{

background:#e85b28;

}

/*================ INFO BOX ================*/

.info-box{

padding:18px;

border-left:5px solid #ff6b35;

background:#fff8f3;

border-radius:12px;

margin-top:20px;

}

.info-box h3{

color:#ff6b35;

margin-bottom:10px;

}

.info-box p{

color:#666;

line-height:26px;

}

/*================ PLACE ORDER BUTTON ================*/

.place-btn{

width:100%;

padding:18px;

border:none;

background:#28a745;

color:white;

font-size:22px;

font-weight:bold;

border-radius:12px;

cursor:pointer;

transition:.3s;

margin-top:20px;

}

.place-btn:hover{

background:#218838;

transform:scale(1.03);

box-shadow:0 10px 20px rgba(0,0,0,.18);

}

.secure{

margin-top:18px;

text-align:center;

color:#777;

font-size:15px;

}

/*================ RESPONSIVE ================*/

@media(max-width:968px){
.checkout-container{grid-template-columns:1fr;max-width:700px;}
.right-sidebar{position:static;display:grid;grid-template-columns:1fr 1fr;gap:20px;}
.side-card{position:static;}
.place-order-card{grid-column:1/-1;}
}

@media(max-width:768px){

.navbar{

flex-direction:column;

height:auto;

padding:16px 20px;
gap:12px;

}
.nav-links{gap:18px;flex-wrap:wrap;justify-content:center;}
.right-sidebar{grid-template-columns:1fr;}
.form-row{grid-template-columns:1fr;}
.payment-grid{grid-template-columns:1fr;}
.progress-wrapper{margin:25px auto 20px;}
.section-card{padding:20px;}
.checkout-container{padding:0 16px;}

}

@media(max-width:480px){
.checkout-item-img{width:55px;height:55px;}
.checkout-item-total{font-size:16px;}
}

</style>

</head>

<body>
<!-- ================= NAVBAR ================= -->

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    int editCartCount = (session.getAttribute("cart") != null) ? ((cart)session.getAttribute("cart")).getItems().size() : 0;
    String editCartBadgeStyle = (editCartCount > 0) ? "" : "display:none;";
%>
<div class="navbar">

    <div class="logo">
        🍔 <span>Foodie</span>
    </div>

    <div class="nav-links">

        <a href="home.jsp">Home</a>

        <a href="callRestaurantServlet">Restaurants</a>

        <a href="cart.jsp" style="position:relative;">Cart <span class="nav-cart-badge" style="<%= editCartBadgeStyle %>position:absolute;top:-8px;right:-14px;background:#ff6b35;color:white;font-size:10px;font-weight:700;min-width:18px;height:18px;border-radius:9px;text-align:center;line-height:18px;padding:0 4px;box-shadow:0 2px 6px rgba(255,107,53,.4);"><%= editCartCount %></span></a>

        <a href="orderhistory">Orders</a>

<%
if(loggedInUser != null){
%>
<span style="display:flex;align-items:center;gap:10px;font-size:15px;font-weight:600;color:#555;">👋 <%=loggedInUser.getName()%></span>
<a href="logout" style="text-decoration:none;color:#e74c3c;font-weight:600;font-size:15px;transition:.3s;">Logout</a>
<%
} else {
%>
<a href="login.jsp" style="text-decoration:none;color:#555;font-size:15px;font-weight:500;transition:.3s;">Login</a>
<%
}
%>

    </div>

</div>

<%

cart cartObj = (cart)session.getAttribute("cart");

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

    <div class="left">

        <div class="card">

            <h2>🛒 Order Summary</h2>

<%

if(itemCount > 0){

    for(cartItem item : cartObj.getItems().values()){

        double itemTotal = item.getPrice() * item.getQuantity();

        subtotal += itemTotal;

%>

            <div class="cart-item">

                <div class="item-left">

                    <img
                    class="food-img"
                    src="<%=request.getContextPath()%>/<%=item.getImagePath()%>"
                    alt="<%=item.getName()%>">

                    <div>

                        <div class="item-name">

                            <%=item.getName()%>

                        </div>

                        <div class="item-price">

                            ₹ <%=item.getPrice()%> each

                        </div>

                        <div style="margin-top:10px;">

                            Quantity :

                            <b>

                                <%=item.getQuantity()%>

                            </b>

                        </div>

                    </div>

                </div>

                <div class="item-total">

                    ₹ <%=String.format("%.2f", itemTotal)%>

                </div>

            </div>

<%

    }
    gst = subtotal * 0.05;
    grandTotal = subtotal + delivery + gst;
    // Apply free delivery for orders >= 799
    double displayDelivery = (subtotal >= 799) ? 0 : delivery;
    double displayGrandTotal = subtotal + displayDelivery + gst;
%>

            <hr style="margin:25px 0;">

            <div class="bill-row">

                <span>Subtotal</span>

                <span>

                    ₹ <%=String.format("%.2f", subtotal)%>

                </span>

            </div>

            <div class="bill-row">

                <span>Delivery Fee</span>

                <span>

                    ₹ <%=String.format("%.2f", displayDelivery)%>

                </span>

            </div>

            <% if(subtotal >= 799){ %>
            <div class="bill-row">
                <span style="color:#27ae60;">🎉 Free Delivery Applied</span>
                <span style="color:#27ae60;">-₹40.00</span>
            </div>
            <% } %>

            <div class="bill-row">

                <span>GST (5%)</span>

                <span>

                    ₹ <%=String.format("%.2f", gst)%>

                </span>

            </div>

            <hr style="margin:25px 0;">

            <div class="bill-row" style="border-top:2px solid #ff6b35;padding-top:15px;margin-top:10px;">

                <span style="font-size:22px;font-weight:800;color:#1a1a2e;">Total</span>

                <span style="font-size:24px;font-weight:800;color:#ff6b35;">

                    ₹ <%=String.format("%.0f", displayGrandTotal)%>

                </span>

            </div>

<%

}else{

%>

            <div style="text-align:center;padding:60px;">

                <h2>🛒 Your Cart is Empty</h2>

                <br>

                <a
                href="callRestaurantServlet"
                style="
                text-decoration:none;
                background:#ff6b35;
                color:white;
                padding:15px 35px;
                border-radius:10px;">

                    Browse Restaurants

                </a>

            </div>

<%

}

%>

        </div>

    </div>

    <!-- ================= RIGHT SECTION START ================= -->

    <div class="right">

        <div class="card">

            <h2>📍 Delivery Address</h2>

            <form action="orderservlet" method="post">

                <%
                String guestName = loggedInUser != null && loggedInUser.getName() != null ? loggedInUser.getName() : "";
                String guestEmail = loggedInUser != null && loggedInUser.getEmail() != null ? loggedInUser.getEmail() : "";
                String guestPhone = loggedInUser != null && loggedInUser.getPhone() != null ? loggedInUser.getPhone() : "";
                %>

                <% if (loggedInUser == null) { %>
                <div class="info-box" style="margin-bottom:20px;background:#fff8f3;border-left:5px solid #ff6b35;">
                    <h3 style="color:#ff6b35;font-size:15px;">👤 Checking Out as Guest</h3>
                    <p style="font-size:13px;color:#888;">Already have an account? <a href="login.jsp" style="color:#ff6b35;font-weight:600;">Sign in</a></p>
                </div>
                <% } %>

                <div class="input-group">

                    <label>Full Name</label>

                    <input
                    type="text"
                    name="customerName"
                    placeholder="Enter your full name"
                    value="<%= guestName %>"
                    required>

                </div>

                <div class="input-group">

                    <label>Email Address</label>

                    <input
                    type="email"
                    name="email"
                    placeholder="email@example.com"
                    value="<%= guestEmail %>"
                    required>

                </div>

                <div class="input-group">

                    <label>Phone Number</label>

                    <input
                    type="tel"
                    name="phone"
                    placeholder="9876543210"
                    value="<%= guestPhone %>"
                    pattern="[0-9]{10}"
                    required>

                </div>

                <div class="input-group">

                    <label>House / Flat No</label>

                    <input
                    type="text"
                    name="house"
                    placeholder="Flat / House No"
                    required>

                </div>

                <div class="input-group">

                    <label>Street</label>

                    <input
                    type="text"
                    name="street"
                    placeholder="Street Name"
                    required>

                </div>

                <div class="input-group">

                    <label>City</label>

                    <input
                    type="text"
                    name="city"
                    placeholder="City"
                    required>

                </div>

                <div class="input-group">

                    <label>State</label>

                    <input
                    type="text"
                    name="state"
                    placeholder="State"
                    required>

                </div>

                <div class="input-group">

                    <label>Pincode</label>

                    <input
                    type="text"
                    name="pincode"
                    placeholder="600001"
                    pattern="[0-9]{6}"
                    required>

                </div>

                <h2 style="margin-top:30px;">💳 Payment Method</h2>

                <label class="payment-option">

                    <input
                    type="radio"
                    name="paymentMode"
                    value="COD"
                    checked>

                    <div>

                        <div class="payment-title">
                            💵 Cash On Delivery
                        </div>

                        <div class="payment-sub">
                            Pay when your order arrives.
                        </div>

                    </div>

                </label>

                <label class="payment-option">

                    <input
                    type="radio"
                    name="paymentMode"
                    value="UPI">

                    <div>

                        <div class="payment-title">
                            📱 UPI Payment
                        </div>

                        <div class="payment-sub">
                            PhonePe, Google Pay, Paytm
                        </div>

                    </div>

                </label>

                <label class="payment-option">

                    <input
                    type="radio"
                    name="paymentMode"
                    value="Credit Card">

                    <div>

                        <div class="payment-title">
                            💳 Credit Card
                        </div>

                        <div class="payment-sub">
                            Visa, Mastercard, RuPay
                        </div>

                    </div>

                </label>

                <label class="payment-option">

                    <input
                    type="radio"
                    name="paymentMode"
                    value="Debit Card">

                    <div>

                        <div class="payment-title">
                            🏦 Debit Card
                        </div>

                        <div class="payment-sub">
                            All major banks accepted.
                        </div>

                    </div>

                </label>

                <button
                type="submit"
                class="place-btn">

                    🛍 Place Order

                </button>

                <div class="secure">

                    🔒 Secure Checkout • 100% Safe Payment
                    <% if (loggedInUser == null) { %>
                    <br><span style="font-size:13px;color:#999;">🛡️ Guest checkout — no account needed</span>
                    <% } %>

                </div>

            </form>

        </div>

        <!-- ================= COUPON CARD ================= -->

        <div class="card">

            <h2>🎁 Coupons & Offers</h2>

            <div class="coupon-box">

                <input
                type="text"
                id="couponInput"
                placeholder="Enter Coupon Code"
                autocomplete="off">

                <button
                type="button"
                class="apply-btn"
                id="applyCouponBtn"
                onclick="applyCoupon()">

                    Apply

                </button>

            </div>

            <div id="couponMessage"></div>

            <div class="info-box" id="couponInfoBox" style="display:none;">
                <h3 style="color:#27ae60;">🎉 Coupon Applied!</h3>
                <p id="couponInfoText"></p>
            </div>

            <div class="info-box">

                <h3>🔥 Today's Offer</h3>

                <p>

                    Use <b>FOODIE50</b> and get
                    <b>₹50 OFF</b> on orders above
                    <b>₹499</b>.

                </p>

            </div>

            <div class="info-box"
                 style="border-left:5px solid #28a745;background:#eef9f1;">

                <h3 style="color:#28a745;">

                    🚚 Free Delivery

                </h3>

                <p>

                    Enjoy FREE Delivery on orders above
                    <b>₹799</b>.

                </p>

            </div>

        </div>
                <!-- ================= DELIVERY INFORMATION ================= -->

        <div class="card">

            <h2>🚚 Delivery Information</h2>

            <div class="bill-row">

                <span>Estimated Delivery</span>

                <span style="color:#28a745;font-weight:bold;">
                    25 - 35 mins
                </span>

            </div>

            <div class="bill-row">

                <span>Delivery Partner</span>

                <span>🚴 Foodie Express</span>

            </div>

            <div class="bill-row">

                <span>Distance</span>

                <span>4.8 km</span>

            </div>

            <div class="bill-row">

                <span>Payment Security</span>

                <span>🔒 Secured</span>

            </div>

        </div>

        <!-- ================= WHY ORDER FROM FOODIE ================= -->

        <div class="card">

            <h2>⭐ Why Order From Foodie?</h2>

            <div style="margin-top:20px;line-height:35px;font-size:16px;">

                <p>✅ Freshly Prepared Food</p>

                <p>✅ Live Order Tracking</p>

                <p>✅ Secure Payments</p>

                <p>✅ Fast Delivery</p>

                <p>✅ 24×7 Customer Support</p>

                <p>✅ Trusted Restaurant Partners</p>

            </div>

        </div>

    </div>

</div>

<!-- Hidden fields for coupon -->
<input type="hidden" name="couponCode" id="orderCouponCode" value="">
<input type="hidden" name="couponDiscount" id="orderCouponDiscount" value="0">

<script>
// ================= COUPON SYSTEM =================
var appliedCouponCode = '';
var appliedDiscount = 0;

function applyCoupon() {
    var input = document.getElementById('couponInput');
    var btn = document.getElementById('applyCouponBtn');
    var msgDiv = document.getElementById('couponMessage');
    var infoBox = document.getElementById('couponInfoBox');
    var infoText = document.getElementById('couponInfoText');
    var code = input.value.trim();

    if (!code) {
        msgDiv.innerHTML = '<div class="info-box" style="background:#fff0f0;border-left-color:#e74c3c;"><p style="color:#e74c3c;">⚠️ Please enter a coupon code.</p></div>';
        return;
    }

    btn.innerHTML = '⏳ Validating...';
    btn.disabled = true;

    fetch('applycoupon', {
        method: 'POST',
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: 'action=validate&code=' + encodeURIComponent(code)
    })
    .then(function(res) { return res.json(); })
    .then(function(data) {
        msgDiv.innerHTML = '';
        if (data.valid) {
            appliedCouponCode = code.toUpperCase();
            appliedDiscount = data.discountAmount;

            // Show success info box
            infoBox.style.display = 'block';
            infoText.innerHTML = '<b>' + code.toUpperCase() + '</b> — You saved <b>₹' + data.discountAmount.toFixed(0) + '</b>!';
            input.style.borderColor = '#27ae60';
            btn.innerHTML = '✅ Applied!';
            btn.style.background = '#27ae60';

            // Update hidden fields for order submission
            document.getElementById('orderCouponCode').value = code.toUpperCase();
            document.getElementById('orderCouponDiscount').value = data.discountAmount;
        } else {
            appliedCouponCode = '';
            appliedDiscount = 0;
            infoBox.style.display = 'none';
            msgDiv.innerHTML = '<div class="info-box" style="background:#fff0f0;border-left-color:#e74c3c;"><p style="color:#e74c3c;">⚠️ ' + data.message + '</p></div>';
            input.style.borderColor = '#e74c3c';
            btn.innerHTML = 'Try Again';
            btn.style.background = '#ff6b35';

            document.getElementById('orderCouponCode').value = '';
            document.getElementById('orderCouponDiscount').value = '0';
        }
        btn.disabled = false;
    })
    .catch(function() {
        msgDiv.innerHTML = '<div class="info-box" style="background:#fff0f0;border-left-color:#e74c3c;"><p style="color:#e74c3c;">⚠️ Could not validate coupon. Please try again.</p></div>';
        btn.innerHTML = 'Apply';
        btn.disabled = false;
    });
}

// Allow Enter key to trigger coupon apply
document.getElementById('couponInput').addEventListener('keyup', function(e) {
    if (e.key === 'Enter') {
        applyCoupon();
    }
});
</script>

</body>

</html>