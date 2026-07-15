<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.tap.model.OrderTable" %>
<%@ page import="com.tap.model.OrderItem" %>
<%@ page import="com.tap.model.Restaurant" %>
<%@ page import="com.tap.model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Track Order | Foodie</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:#f4f6fa;min-height:100vh;padding:30px 20px;}

/* Navbar */
.navbar{height:76px;padding:0 60px;display:flex;justify-content:space-between;align-items:center;background:rgba(255,255,255,.92);backdrop-filter:blur(20px);box-shadow:0 8px 25px rgba(0,0,0,.06);position:sticky;top:0;z-index:999;border-radius:16px;margin-bottom:30px;max-width:960px;margin-left:auto;margin-right:auto;}
.logo{font-size:28px;font-weight:800;color:#ff6b35;text-decoration:none;}
.nav-links{display:flex;gap:25px;}
.nav-links a{text-decoration:none;color:#555;font-size:15px;font-weight:500;transition:.3s;}
.nav-links a:hover{color:#ff6b35;}

/* Layout */
.page-wrapper{max-width:960px;margin:0 auto;position:relative;z-index:1;}

/* Hero */
.track-hero{background:linear-gradient(135deg,#ff6b35,#ff914d);border-radius:24px;padding:40px;color:white;margin-bottom:30px;box-shadow:0 20px 50px rgba(255,107,53,.3);display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:20px;}
.track-hero h1{font-size:32px;font-weight:800;}
.track-hero p{font-size:15px;opacity:.9;margin-top:6px;}
.track-hero .order-badge{background:rgba(255,255,255,.2);padding:12px 24px;border-radius:30px;font-size:18px;font-weight:700;border:2px dashed rgba(255,255,255,.4);text-align:center;}

/* Main Grid */
.main-grid{display:grid;grid-template-columns:1fr 1fr;gap:25px;margin-bottom:30px;}

/* Cards */
.card{background:white;border-radius:20px;padding:25px;box-shadow:0 10px 30px rgba(0,0,0,.08);}
.card.full{grid-column:1/-1;}
.card-header{display:flex;align-items:center;gap:10px;margin-bottom:18px;padding-bottom:14px;border-bottom:2px solid #f0f0f0;}
.card-header .icon{font-size:22px;}
.card-header h2{font-size:18px;font-weight:700;color:#222;}

/* Timeline */
.timeline{position:relative;padding:10px 0;}
.timeline::before{content:'';position:absolute;left:23px;top:10px;bottom:10px;width:3px;background:#e0e0e0;border-radius:4px;}
.timeline-step{display:flex;align-items:flex-start;gap:18px;margin-bottom:28px;position:relative;}
.timeline-step:last-child{margin-bottom:0;}
.timeline-dot{width:48px;height:48px;border-radius:50%;display:flex;justify-content:center;align-items:center;font-size:20px;flex-shrink:0;position:relative;z-index:1;transition:.4s;}
.timeline-dot.done{background:#27ae60;color:white;box-shadow:0 6px 20px rgba(39,174,96,.3);}
.timeline-dot.active{background:linear-gradient(135deg,#ff6b35,#ff914d);color:white;box-shadow:0 6px 20px rgba(255,107,53,.3);animation:pulse 2s infinite;}
.timeline-dot.pending{background:#e0e0e0;color:#aaa;}
@keyframes pulse{0%,100%{transform:scale(1);box-shadow:0 6px 20px rgba(255,107,53,.3);}50%{transform:scale(1.08);box-shadow:0 8px 30px rgba(255,107,53,.5);}}
.timeline-content{}
.timeline-content h3{font-size:16px;font-weight:600;color:#333;}
.timeline-content p{font-size:13px;color:#999;margin-top:2px;}

/* Detail rows */
.detail-row{display:flex;justify-content:space-between;padding:10px 0;border-bottom:1px solid #f5f5f5;font-size:15px;}
.detail-row:last-child{border-bottom:none;}
.detail-label{color:#888;}
.detail-value{font-weight:600;color:#333;text-align:right;}
.detail-value.green{color:#27ae60;}
.detail-value.orange{color:#ff6b35;}

/* Order items */
.order-item{display:flex;justify-content:space-between;align-items:center;padding:12px 0;border-bottom:1px solid #f0f0f0;}
.order-item:last-child{border-bottom:none;}
.oi-name{font-weight:600;color:#333;font-size:15px;}
.oi-meta{color:#999;font-size:13px;margin-top:2px;}
.oi-total{font-size:17px;font-weight:700;color:#27ae60;}

/* Buttons */
.actions{display:flex;gap:14px;flex-wrap:wrap;margin-top:20px;}
.btn{flex:1;min-width:160px;padding:14px 20px;border:none;border-radius:12px;font-size:15px;font-weight:600;cursor:pointer;transition:.3s;text-decoration:none;display:inline-flex;justify-content:center;align-items:center;gap:6px;text-align:center;}
.btn-primary{background:linear-gradient(135deg,#ff6b35,#ff914d);color:white;}
.btn-primary:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(255,107,53,.35);}
.btn-secondary{background:white;color:#ff6b35;border:2px solid #eee;}
.btn-secondary:hover{background:#fff8f5;border-color:#ff6b35;transform:translateY(-2px);}
.btn-tertiary{background:#27ae60;color:white;}
.btn-tertiary:hover{transform:translateY(-3px);box-shadow:0 12px 30px rgba(39,174,96,.35);}

/* Status bar */
.status-bar{background:#fafafa;border-radius:14px;padding:18px 22px;margin-bottom:25px;display:flex;justify-content:space-between;align-items:center;flex-wrap:wrap;gap:12px;}
.status-label{display:flex;align-items:center;gap:8px;font-size:16px;font-weight:600;}
.status-label .dot{width:12px;height:12px;border-radius:50%;display:inline-block;}
.dot.green{background:#27ae60;animation:pulse 1.5s infinite;}
.dot.orange{background:#ff6b35;animation:pulse 1.5s infinite;}
.dot.blue{background:#3498db;animation:pulse 1.5s infinite;}
.dot.red{background:#e74c3c;}
.est-time{color:#888;font-size:15px;}

footer{text-align:center;padding:30px;color:#aaa;font-size:14px;}

@media(max-width:768px){
.navbar{padding:16px 20px;height:auto;flex-direction:column;gap:12px;border-radius:12px;}
.nav-links{gap:14px;flex-wrap:wrap;justify-content:center;}
.main-grid{grid-template-columns:1fr;}
.track-hero{flex-direction:column;text-align:center;padding:30px 20px;}
.track-hero h1{font-size:26px;}
.actions{flex-direction:column;}
}
</style>
</head>
<body>

<%
OrderTable order = (OrderTable) request.getAttribute("order");
List<OrderItem> items = (List<OrderItem>) request.getAttribute("items");
Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
Map<Integer, String> menuNames = (Map<Integer, String>) request.getAttribute("menuNames");

if (order == null) { response.sendRedirect("orderhistory"); return; }

String status = order.getStatus() != null ? order.getStatus().toLowerCase() : "placed";
String formattedDate = new SimpleDateFormat("dd MMM yyyy, hh:mm a").format(order.getOrderDate());
%>

<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
%>
<div class="navbar">
<a href="home.jsp" class="logo">🍔 Foodie</a>
<div class="nav-links">
<a href="home.jsp">Home</a>
<a href="callRestaurantServlet">Restaurants</a>
<a href="orderhistory">Orders</a>
<%
if(loggedInUser != null){
%>
<span style="display:flex;align-items:center;gap:8px;font-size:14px;font-weight:600;color:#555;">👋 <%=loggedInUser.getName()%></span>
<a href="logout" style="text-decoration:none;color:#e74c3c;font-weight:600;font-size:14px;transition:.3s;">Logout</a>
<%
} else {
%>
<a href="login.jsp" style="text-decoration:none;color:#555;font-size:14px;font-weight:500;transition:.3s;">Login</a>
<a href="register.jsp" style="text-decoration:none;color:#555;font-size:14px;font-weight:500;transition:.3s;">Register</a>
<%
}
%>
</div>
</div>

<div class="page-wrapper">

    <!-- Hero -->
    <div class="track-hero">
        <div>
            <h1>📦 Track Your Order</h1>
            <p>Real-time updates for your food delivery</p>
        </div>
        <div class="order-badge">#ORD-<%= String.format("%05d", order.getOrderId()) %></div>
    </div>

    <!-- Status Bar -->
    <div class="status-bar">
        <div class="status-label">
            <span class="dot <%= status.equals("delivered") ? "green" : status.equals("cancelled") ? "red" : status.equals("preparing") ? "orange" : "blue" %>"></span>
            <%= status.equals("placed") ? "✅ Order Placed" : 
               status.equals("preparing") ? "👨‍🍳 Preparing Your Food" :
               status.equals("delivered") ? "✅ Delivered" :
               status.equals("cancelled") ? "❌ Cancelled" : "✅ " + order.getStatus() %>
        </div>
        <div class="est-time">
            <%= status.equals("delivered") ? "🎉 Delivered on " + formattedDate :
               status.equals("cancelled") ? "" : "🕐 Est. 25-35 min" %>
        </div>
    </div>

    <div class="main-grid">

        <!-- Timeline -->
        <div class="card">
            <div class="card-header">
                <span class="icon">📍</span>
                <h2>Order Progress</h2>
            </div>
            <div class="timeline">
                <div class="timeline-step">
                    <div class="timeline-dot done">✓</div>
                    <div class="timeline-content">
                        <h3>✅ Order Confirmed</h3>
                        <p><%= formattedDate %></p>
                    </div>
                </div>
                <div class="timeline-step">
                    <div class="timeline-dot <%= status.equals("preparing") || status.equals("delivered") ? "done" : status.equals("placed") ? "active" : "pending" %>">
                        <%= status.equals("preparing") || status.equals("delivered") ? "✓" : "2" %>
                    </div>
                    <div class="timeline-content">
                        <h3>👨‍🍳 Preparing</h3>
                        <p><%= status.equals("preparing") || status.equals("delivered") ? "Your food is being prepared" : "Waiting for restaurant" %></p>
                    </div>
                </div>
                <div class="timeline-step">
                    <div class="timeline-dot <%= status.equals("delivered") ? "done" : 
                        (status.equals("preparing") ? "active" : "pending") %>">
                        <%= status.equals("delivered") ? "✓" : "3" %>
                    </div>
                    <div class="timeline-content">
                        <h3>🛵 Out for Delivery</h3>
                        <p><%= status.equals("delivered") ? "Delivered to your doorstep" : 
                            (status.equals("preparing") ? "Rider will be assigned soon" : "Awaiting preparation") %></p>
                    </div>
                </div>
                <div class="timeline-step">
                    <div class="timeline-dot <%= status.equals("delivered") ? "done" : "pending" %>">
                        <%= status.equals("delivered") ? "✓" : "4" %>
                    </div>
                    <div class="timeline-content">
                        <h3>🍽️ Delivered</h3>
                        <p><%= status.equals("delivered") ? "Enjoy your meal! 🎉" : "Yet to be delivered" %></p>
                    </div>
                </div>
            </div>
        </div>

        <!-- Order Details -->
        <div class="card">
            <div class="card-header">
                <span class="icon">📋</span>
                <h2>Order Details</h2>
            </div>
            <div class="detail-row">
                <span class="detail-label">🏪 Restaurant</span>
                <span class="detail-value"><%= restaurant != null ? restaurant.getName() : "Restaurant" %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">💳 Payment</span>
                <span class="detail-value"><%= order.getPaymentMethod() %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">📅 Ordered</span>
                <span class="detail-value"><%= formattedDate %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">💵 Total</span>
                <span class="detail-value green">₹ <%= String.format("%.0f", order.getTotalAmount()) %></span>
            </div>
            <div class="detail-row">
                <span class="detail-label">📊 Status</span>
                <span class="detail-value orange"><%= order.getStatus() %></span>
            </div>
        </div>

        <!-- Ordered Items -->
        <div class="card full">
            <div class="card-header">
                <span class="icon">🛒</span>
                <h2>Ordered Items (<%= items != null ? items.size() : 0 %>)</h2>
            </div>
            <%
            if (items != null && !items.isEmpty()) {
                for (OrderItem item : items) {
                    String itemName = menuNames != null ? menuNames.get(item.getMenuId()) : "Food Item";
                    if (itemName == null) itemName = "Food Item";
            %>
            <div class="order-item">
                <div>
                    <div class="oi-name"><%= itemName %></div>
                    <div class="oi-meta">Qty: <%= item.getQuantity() %> × ₹<%= String.format("%.0f", item.getItemTotal() / item.getQuantity()) %></div>
                </div>
                <div class="oi-total">₹ <%= String.format("%.0f", item.getItemTotal()) %></div>
            </div>
            <%
                }
            } else {
            %>
            <div style="text-align:center;padding:20px;color:#888;">No items found.</div>
            <%
            }
            %>
            <div style="margin-top:16px;padding-top:16px;border-top:2px solid #f0f0f0;display:flex;justify-content:space-between;align-items:center;">
                <span style="font-size:18px;font-weight:700;color:#222;">Total</span>
                <span style="font-size:24px;font-weight:800;color:#ff6b35;">₹ <%= String.format("%.0f", order.getTotalAmount()) %></span>
            </div>
        </div>

    </div>

    <!-- Actions -->
    <div class="actions">
        <a href="menu?restaurantId=<%= order.getRestaurantId() %>" class="btn btn-primary">🍕 Order Again</a>
        <a href="orderhistory" class="btn btn-secondary">📋 All Orders</a>
        <a href="callRestaurantServlet" class="btn btn-tertiary">🍽️ Browse Restaurants</a>
    </div>

    <footer>Made with ❤️ using Java, JSP, Servlets &amp; MySQL</footer>

</div>
</body>
</html>
