<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Order Confirmed | Foodie</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:linear-gradient(135deg,#f0fff4,#e8fff0,#f0fff4);min-height:100vh;padding:30px 20px;position:relative;overflow-x:hidden;}

/* Floating particles */
.particle{position:fixed;width:12px;height:12px;border-radius:50%;animation:fall linear infinite;opacity:.5;pointer-events:none;z-index:0;}
.particle:nth-child(1){left:5%;width:14px;height:14px;background:#ff6b35;animation-duration:5s;animation-delay:0s;}
.particle:nth-child(2){left:15%;width:10px;height:10px;background:#f1c40f;animation-duration:6s;animation-delay:1s;}
.particle:nth-child(3){left:30%;width:16px;height:16px;background:#27ae60;animation-duration:4.5s;animation-delay:.5s;}
.particle:nth-child(4){left:50%;width:8px;height:8px;background:#3498db;animation-duration:5.5s;animation-delay:1.5s;}
.particle:nth-child(5){left:70%;width:13px;height:13px;background:#e74c3c;animation-duration:6.5s;animation-delay:.3s;}
.particle:nth-child(6){left:85%;width:11px;height:11px;background:#9b59b6;animation-duration:4.8s;animation-delay:.8s;}
.particle:nth-child(7){left:60%;width:9px;height:9px;background:#1abc9c;animation-duration:5.2s;animation-delay:1.2s;}
.particle:nth-child(8){left:90%;width:15px;height:15px;background:#e67e22;animation-duration:5.8s;animation-delay:.2s;}
@keyframes fall{0%{transform:translateY(-120px) rotate(0deg);opacity:.6;}100%{transform:translateY(110vh) rotate(720deg);opacity:0;}}

/* Page layout */
.page-wrapper{max-width:860px;margin:0 auto;position:relative;z-index:1;}

/* Success banner */
.success-banner{background:linear-gradient(135deg,#27ae60,#2ecc71);border-radius:24px;padding:40px;text-align:center;color:white;margin-bottom:30px;box-shadow:0 20px 50px rgba(39,174,96,.35);animation:fadeDown .6s ease;}
@keyframes fadeDown{from{opacity:0;transform:translateY(-30px);}to{opacity:1;transform:translateY(0);}}
.check-icon{width:80px;height:80px;border-radius:50%;background:rgba(255,255,255,.2);display:flex;justify-content:center;align-items:center;margin:0 auto 18px;font-size:40px;animation:popIn .5s ease .3s both;}
@keyframes popIn{0%{transform:scale(0);}60%{transform:scale(1.12);}100%{transform:scale(1);}}
.success-banner h1{font-size:32px;font-weight:800;margin-bottom:6px;}
.success-banner p{font-size:16px;opacity:.9;}
.order-id-badge{display:inline-block;margin-top:16px;padding:10px 28px;background:rgba(255,255,255,.2);border-radius:30px;font-size:20px;font-weight:700;letter-spacing:1px;border:2px dashed rgba(255,255,255,.4);}

/* Grid layout */
.details-grid{display:grid;grid-template-columns:1fr 1fr;gap:25px;margin-bottom:25px;}

/* Cards */
.card{background:white;border-radius:20px;padding:25px;box-shadow:0 10px 30px rgba(0,0,0,.08);animation:fadeUp .5s ease both;}
.card.full{grid-column:1/-1;}
@keyframes fadeUp{from{opacity:0;transform:translateY(20px);}to{opacity:1;transform:translateY(0);}}
.card:nth-child(1){animation-delay:.1s;}
.card:nth-child(2){animation-delay:.2s;}
.card:nth-child(3){animation-delay:.3s;}
.card:nth-child(4){animation-delay:.4s;}
.card-header{display:flex;align-items:center;gap:10px;margin-bottom:18px;padding-bottom:14px;border-bottom:2px solid #f0f0f0;}
.card-header .icon{font-size:24px;}
.card-header h2{font-size:20px;font-weight:700;color:#222;}

/* Detail rows */
.detail-row{display:flex;justify-content:space-between;align-items:center;padding:10px 0;border-bottom:1px solid #f5f5f5;font-size:15px;}
.detail-row:last-child{border-bottom:none;}
.detail-label{color:#888;display:flex;align-items:center;gap:6px;}
.detail-value{color:#333;font-weight:600;text-align:right;max-width:55%;}
.detail-value.green{color:#27ae60;}
.detail-value.orange{color:#ff6b35;}

/* Order items */
.order-item{display:flex;justify-content:space-between;align-items:center;padding:14px 0;border-bottom:1px solid #f0f0f0;gap:12px;}
.order-item:last-child{border-bottom:none;}
.item-left{display:flex;align-items:center;gap:14px;flex:1;min-width:0;}
.item-thumb{width:50px;height:50px;border-radius:12px;object-fit:cover;flex-shrink:0;background:#f0f0f0;}
.item-info{}
.item-info .item-name{font-size:16px;font-weight:600;color:#222;}
.item-info .item-meta{font-size:13px;color:#999;margin-top:2px;}
.item-right{text-align:right;flex-shrink:0;}
.item-right .item-qty{font-size:14px;color:#888;}
.item-right .item-total{font-size:18px;font-weight:700;color:#27ae60;}

/* Total section */
.total-row{display:flex;justify-content:space-between;align-items:center;padding:14px 0;font-size:17px;}
.total-row.sub{border-bottom:1px solid #f0f0f0;}
.total-row.grand{border-top:2px solid #ff6b35;padding-top:18px;margin-top:8px;}
.total-row.grand .label{font-size:22px;font-weight:800;color:#222;}
.total-row.grand .value{font-size:26px;font-weight:800;color:#ff6b35;}

/* Action buttons */
.actions{display:flex;gap:14px;flex-wrap:wrap;animation:fadeUp .5s ease .5s both;}
.btn{flex:1;min-width:180px;padding:16px 24px;border:none;border-radius:14px;font-size:16px;font-weight:600;cursor:pointer;transition:.3s;text-decoration:none;display:inline-flex;justify-content:center;align-items:center;gap:8px;text-align:center;}
.btn-primary{background:linear-gradient(135deg,#ff6b35,#ff914d);color:white;}
.btn-primary:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(255,107,53,.35);}
.btn-secondary{background:white;color:#ff6b35;border:2px solid #eee;}
.btn-secondary:hover{background:#fff8f5;border-color:#ff6b35;transform:translateY(-2px);}
.btn-tertiary{background:#27ae60;color:white;}
.btn-tertiary:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(39,174,96,.35);}

/* Rating */
.rating-section{text-align:center;padding:20px 0 10px;animation:fadeUp .5s ease .6s both;}
.rating-section p{color:#888;font-size:15px;margin-bottom:12px;}
.stars{display:flex;justify-content:center;gap:8px;font-size:32px;}
.stars span{transition:.3s;filter:grayscale(1);cursor:pointer;}
.stars span:hover{transform:scale(1.3);filter:grayscale(0);}

/* Responsive */
@media(max-width:768px){
.details-grid{grid-template-columns:1fr;}
.success-banner{padding:30px 20px;}
.success-banner h1{font-size:26px;}
.order-id-badge{font-size:16px;padding:8px 20px;}
.actions{flex-direction:column;}
.btn{min-width:auto;}
}
@media(max-width:480px){
body{padding:16px 12px;}
.card{padding:18px;}
.order-item{flex-wrap:wrap;}
.item-right{width:100%;text-align:left;display:flex;justify-content:space-between;align-items:center;}
}
</style>
</head>
<body>

<%
// ================= READ SESSION DATA =================
Integer lastOrderId = (Integer) session.getAttribute("lastOrderId");
if (lastOrderId == null) { response.sendRedirect("home.jsp"); return; }

String customerName = (String) session.getAttribute("orderCustomerName");
String phone = (String) session.getAttribute("orderPhone");
String address = (String) session.getAttribute("orderAddress");
String paymentMode = (String) session.getAttribute("orderPaymentMode");
Double totalAmount = (Double) session.getAttribute("orderTotalAmount");
Integer restaurantId = (Integer) session.getAttribute("orderRestaurantId");
Date orderDate = (Date) session.getAttribute("orderDate");
Map<String, Object>[] orderItems = (Map<String, Object>[]) session.getAttribute("orderItems");

if (customerName == null) customerName = "Customer";
if (phone == null) phone = "-";
if (address == null) address = "-";
if (paymentMode == null) paymentMode = "COD";
if (totalAmount == null) totalAmount = 0.0;
if (restaurantId == null) restaurantId = 0;
if (orderDate == null) orderDate = new Date();

// Read coupon info from session
String appliedCouponCode = (String) session.getAttribute("orderCouponCode");
Double appliedCouponDiscount = (Double) session.getAttribute("orderCouponDiscount");
Double orderSubtotal = (Double) session.getAttribute("orderSubtotal");

if (appliedCouponDiscount == null) appliedCouponDiscount = 0.0;
if (orderSubtotal == null || orderSubtotal <= 0) orderSubtotal = totalAmount;

double deliveryFee = 40;
double gst = orderSubtotal * 0.05;
double displayDelivery = (orderSubtotal >= 799) ? 0 : deliveryFee;
double grandTotal = orderSubtotal + displayDelivery + gst - appliedCouponDiscount;
if (grandTotal < 0) grandTotal = 0;

String formattedDate = new SimpleDateFormat("dd MMM yyyy, hh:mm a").format(orderDate);
%>

<div class="particle"></div><div class="particle"></div><div class="particle"></div>
<div class="particle"></div><div class="particle"></div><div class="particle"></div>
<div class="particle"></div><div class="particle"></div>

<div class="page-wrapper">

    <!-- ================= SUCCESS BANNER ================= -->
    <div class="success-banner">
        <div class="check-icon">✓</div>
        <h1>🎉 Order Placed Successfully!</h1>
        <p>Your delicious food is being prepared and will be on its way soon.</p>
        <div class="order-id-badge">📋 #ORD-<%= String.format("%05d", lastOrderId) %></div>
    </div>

    <div class="details-grid">

        <!-- ================= DELIVERY ADDRESS ================= -->
        <div class="card">
            <div class="card-header">
                <span class="icon">📍</span>
                <h2>Delivery Address</h2>
            </div>
            <div class="detail-row">
                <span class="detail-label">👤 Name</span>
                <span class="detail-value"><%= customerName %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">📞 Phone</span>
                <span class="detail-value"><%= phone %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">🏠 Address</span>
                <span class="detail-value"><%= address %></span>
            </div>
        </div>

        <!-- ================= PAYMENT INFO ================= -->
        <div class="card">
            <div class="card-header">
                <span class="icon">💳</span>
                <h2>Payment Details</h2>
            </div>
            <div class="detail-row">
                <span class="detail-label">💵 Method</span>
                <span class="detail-value"><%= paymentMode %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">📅 Order Date</span>
                <span class="detail-value"><%= formattedDate %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">🔒 Security</span>
                <span class="detail-value green">100% Secured</span>
            </div>
        </div>

        <!-- ================= DELIVERY INFO ================= -->
        <div class="card">
            <div class="card-header">
                <span class="icon">🚚</span>
                <h2>Delivery Info</h2>
            </div>
            <div class="detail-row">
                <span class="detail-label">🕐 Est. Delivery</span>
                <span class="detail-value green">25 - 35 minutes</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">🚴 Partner</span>
                <span class="detail-value">Foodie Express</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">📏 Distance</span>
                <span class="detail-value">4.8 km</span>
            </div>
        </div>

        <!-- ================= ORDER STATUS ================= -->
        <div class="card">
            <div class="card-header">
                <span class="icon">📦</span>
                <h2>Order Status</h2>
            </div>
            <div class="detail-row">
                <span class="detail-label">✅ Status</span>
                <span class="detail-value green">Confirmed</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">🔄 Tracking</span>
                <span class="detail-value orange">Preparing your food</span>
            </div>
            <div class="detail-row">
                <span class="detail-label">⏱️ Last Update</span>
                <span class="detail-value"><%= formattedDate %></span>
            </div>
        </div>

        <!-- ================= ORDERED ITEMS ================= -->
        <div class="card full">
            <div class="card-header">
                <span class="icon">🛒</span>
                <h2>Ordered Items (<%= orderItems != null ? orderItems.length : 0 %>)</h2>
            </div>

            <%
            if (orderItems != null && orderItems.length > 0) {
                for (Map<String, Object> item : orderItems) {
                    String itemName = (String) item.get("name");
                    int qty = (int) item.get("quantity");
                    double price = (double) item.get("price");
                    double itemTotal = (double) item.get("itemTotal");
                    String imgPath = (String) item.get("imagePath");
                    if (itemName == null) itemName = "Food Item";
                    if (imgPath == null) imgPath = "";
            %>
            <div class="order-item">
                <div class="item-left">
                    <img class="item-thumb" 
                         src="<%= request.getContextPath() %>/<%= imgPath %>" 
                         alt="<%= itemName %>"
                         onerror="this.style.display='none'">
                    <div class="item-info">
                        <div class="item-name"><%= itemName %></div>
                        <div class="item-meta">₹ <%= String.format("%.0f", price) %> each</div>
                    </div>
                </div>
                <div class="item-right">
                    <div class="item-qty">× <%= qty %></div>
                    <div class="item-total">₹ <%= String.format("%.0f", itemTotal) %></div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <div style="text-align:center;padding:20px;color:#888;">No items found for this order.</div>
            <%
            }
            %>

            <!-- Total Breakdown -->
            <div style="margin-top:20px;padding-top:18px;border-top:2px solid #f0f0f0;">
                <div class="total-row sub">
                    <span class="detail-label">Subtotal</span>
                    <span class="detail-value">₹ <%= String.format("%.2f", totalAmount) %></span>
                </div>
                <div class="total-row sub">
                    <span class="detail-label">Delivery Fee</span>
                    <span class="detail-value"><%= displayDelivery == 0 ? "🎉 FREE" : "₹ " + String.format("%.2f", displayDelivery) %></span>
                </div>
                <% if (orderSubtotal >= 799) { %>
                <div class="total-row sub" style="color:#27ae60;">
                    <span class="detail-label">🎉 Free Delivery Applied</span>
                    <span class="detail-value" style="color:#27ae60;">-₹40.00</span>
                </div>
                <% } %>
                <% if (appliedCouponDiscount > 0 && appliedCouponCode != null) { %>
                <div class="total-row sub" style="color:#27ae60;font-weight:600;">
                    <span class="detail-label">🎉 Coupon: <b><%= appliedCouponCode %></b></span>
                    <span class="detail-value" style="color:#27ae60;">-₹<%= String.format("%.0f", appliedCouponDiscount) %></span>
                </div>
                <% } %>
                <div class="total-row sub">
                    <span class="detail-label">GST (5%)</span>
                    <span class="detail-value">₹ <%= String.format("%.2f", gst) %></span>
                </div>
                <div class="total-row grand">
                    <span class="label">Total Amount</span>
                    <span class="value">₹ <%= String.format("%.0f", grandTotal) %></span>
                </div>
            </div>
        </div>

    </div>

    <!-- ================= ACTIONS ================= -->
    <div class="actions">
        <a href="trackorder?orderId=<%= lastOrderId %>" class="btn btn-primary">📦 Track My Order</a>
        <a href="callRestaurantServlet" class="btn btn-secondary">🍕 Continue Shopping</a>
        <a href="home.jsp" class="btn btn-tertiary">🏠 Back to Home</a>
    </div>

    <!-- ================= RATING ================= -->
    <div class="rating-section">
        <p>⭐ How was your ordering experience?</p>
        <div class="stars">
            <span>⭐</span><span>⭐</span><span>⭐</span><span>⭐</span><span>⭐</span>
        </div>
    </div>

    <!-- ================= FOOTER ================= -->
    <div style="text-align:center;padding:30px 0 10px;color:#aaa;font-size:14px;">
        Made with ❤️ using Java, JSP, Servlets &amp; MySQL
    </div>

</div>

<script>
// Star rating hover
document.querySelectorAll('.stars span').forEach(function(star, idx) {
    star.addEventListener('mouseenter', function() {
        var all = document.querySelectorAll('.stars span');
        all.forEach(function(s, i) {
            s.style.filter = i <= idx ? 'grayscale(0)' : 'grayscale(1)';
            s.style.transform = i <= idx ? 'scale(1.3)' : 'scale(1)';
        });
    });
    star.addEventListener('mouseleave', function() {
        document.querySelectorAll('.stars span').forEach(function(s) {
            s.style.filter = 'grayscale(1)';
            s.style.transform = 'scale(1)';
        });
    });
    star.addEventListener('click', function() {
        var all = document.querySelectorAll('.stars span');
        all.forEach(function(s, i) {
            if (i <= idx) {
                s.style.filter = 'grayscale(0)';
                s.style.transform = 'scale(1.1)';
            } else {
                s.style.filter = 'grayscale(1)';
                s.style.transform = 'scale(1)';
            }
        });
        // Show feedback
        var msgs = ['😕 Poor', '🙁 Fair', '😐 Good', '😊 Great', '🤩 Excellent!'];
        var p = document.querySelector('.rating-section p');
        p.textContent = msgs[idx] + ' — Thanks for your feedback!';
    });
});
</script>

</body>
</html>
