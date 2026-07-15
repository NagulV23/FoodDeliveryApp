<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="com.tap.model.OrderTable"%>
<%@ page import="com.tap.model.OrderItem"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.cart"%>
<%@ page import="com.tap.model.User"%>
<%@ page import="com.tap.daoimplementation.OrderItemDAOImpl"%>
<%@ page import="com.tap.daoimplementation.MenuDAOImpl"%>
<%@ page import="com.tap.daoimplementation.RestaurantDAOImpl"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>My Orders | Foodie</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:#f7f7f7;}
.navbar{height:80px;padding:0 70px;display:flex;justify-content:space-between;align-items:center;background:white;box-shadow:0 10px 30px rgba(0,0,0,.08);position:sticky;top:0;z-index:999;}
.logo{font-size:34px;font-weight:700;color:#ff6b35;}
.nav-links{display:flex;gap:35px;}
.nav-links a{text-decoration:none;color:#444;font-size:18px;font-weight:500;transition:.3s;}
.nav-links a:hover{color:#ff6b35;}
.hero{width:92%;margin:35px auto;padding:45px;border-radius:30px;background:linear-gradient(135deg,#ff6b35,#ff914d);color:white;display:flex;justify-content:space-between;align-items:center;box-shadow:0 25px 45px rgba(255,107,53,.30);}
.hero-left h1{font-size:48px;margin-bottom:10px;}
.hero-left p{font-size:18px;opacity:.95;}
.hero-right{display:flex;gap:15px;flex-wrap:wrap;}
.hero-box{background:rgba(255,255,255,.15);padding:16px 24px;border-radius:20px;backdrop-filter:blur(10px);font-size:16px;font-weight:600;}
.container{width:92%;margin:auto;padding-bottom:60px;}
.page-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:30px;flex-wrap:wrap;gap:15px;}
.page-title{font-size:34px;font-weight:700;color:#222;}
.order-count{background:#f0f0f0;padding:8px 18px;border-radius:30px;font-size:15px;color:#888;font-weight:500;}
.order-card{background:white;padding:28px;border-radius:20px;margin-bottom:25px;box-shadow:0 10px 25px rgba(0,0,0,.08);transition:.35s;}
.order-card:hover{transform:translateY(-5px);box-shadow:0 18px 40px rgba(0,0,0,.12);}
.order-header{display:flex;justify-content:space-between;align-items:center;margin-bottom:20px;flex-wrap:wrap;gap:15px;}
.order-id{font-size:22px;font-weight:700;color:#333;}
.order-date{margin-top:6px;color:#999;font-size:14px;}
.status{padding:8px 20px;border-radius:30px;color:white;font-weight:600;font-size:14px;display:inline-block;}
.delivered{background:#27ae60;}.preparing{background:#f39c12;}.placed{background:#3498db;}.cancelled{background:#e74c3c;}
.details{display:grid;grid-template-columns:repeat(4,1fr);gap:15px;margin-top:20px;}
.detail-box{background:#fafafa;padding:16px;border-radius:12px;}
.detail-title{font-weight:500;margin-bottom:6px;color:#888;font-size:13px;text-transform:uppercase;letter-spacing:.5px;}
.detail-value{font-size:18px;font-weight:600;color:#333;}
.total-value{font-size:24px;font-weight:bold;color:#27ae60;}
.items-section{margin-top:25px;background:#fafafa;padding:20px;border-radius:14px;}
.items-title{margin-bottom:15px;font-size:18px;font-weight:600;color:#333;}
.item-row{display:flex;justify-content:space-between;align-items:center;padding:14px 0;border-bottom:1px solid #ececec;}
.item-row:last-child{border-bottom:none;}
.item-name{font-size:17px;font-weight:600;color:#333;}
.item-qty{margin-top:4px;color:#888;font-size:14px;}
.item-total{font-size:18px;font-weight:bold;color:#27ae60;}
.actions{margin-top:25px;display:flex;gap:12px;flex-wrap:wrap;}
.actions a{text-decoration:none;padding:12px 24px;border-radius:12px;font-size:15px;font-weight:600;transition:.3s;display:inline-flex;align-items:center;gap:6px;}
.order-again{background:#ff6b35;color:white;}
.order-again:hover{background:#e55b2b;transform:translateY(-2px);box-shadow:0 8px 20px rgba(255,107,53,.3);}
.view-invoice{background:#3498db;color:white;}
.view-invoice:hover{background:#2980b9;transform:translateY(-2px);}
.rate-order{background:#27ae60;color:white;}
.rate-order:hover{background:#219a52;transform:translateY(-2px);}
.empty{text-align:center;padding:100px 20px;}
.empty .empty-icon{font-size:80px;display:block;margin-bottom:20px;}
.empty h2{font-size:34px;color:#888;margin-bottom:15px;}
.empty p{font-size:18px;color:#999;margin-bottom:30px;}
.empty a{display:inline-block;padding:16px 35px;text-decoration:none;background:#ff6b35;color:white;border-radius:14px;font-weight:600;transition:.3s;}
.empty a:hover{background:#e55b2b;transform:translateY(-3px);box-shadow:0 12px 25px rgba(255,107,53,.3);}
footer{margin-top:50px;padding:35px;text-align:center;background:white;box-shadow:0 -5px 20px rgba(0,0,0,.05);font-size:15px;color:#888;}
@media(max-width:900px){.navbar{padding:20px;height:auto;flex-direction:column;gap:15px;}.hero{flex-direction:column;text-align:center;gap:20px;}.hero-left h1{font-size:34px;}.details{grid-template-columns:repeat(2,1fr);}.order-header{flex-direction:column;align-items:flex-start;}.item-row{flex-direction:column;align-items:flex-start;gap:8px;}}
@media(max-width:500px){.details{grid-template-columns:1fr;}}
</style>
</head>
<body>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    int orderCartCount = (session.getAttribute("cart") != null) ? ((cart)session.getAttribute("cart")).getItems().size() : 0;
    String orderCartBadgeStyle = (orderCartCount > 0) ? "" : "display:none;";
%>
<div class="navbar"><div class="logo">🍔 Foodie</div>
<div class="nav-links">
<a href="home.jsp">Home</a>
<a href="callRestaurantServlet">Restaurants</a>
<a href="cart.jsp" style="position:relative;">Cart <span class="nav-cart-badge" style="<%= orderCartBadgeStyle %>position:absolute;top:-8px;right:-14px;background:#ff6b35;color:white;font-size:10px;font-weight:700;min-width:18px;height:18px;border-radius:9px;text-align:center;line-height:18px;padding:0 4px;box-shadow:0 2px 6px rgba(255,107,53,.4);"><%= orderCartCount %></span></a>
<a href="orderhistory">My Orders</a>
<%
if(loggedInUser != null){
%>
<span style="display:flex;align-items:center;gap:8px;font-size:15px;font-weight:600;color:#444;">👋 <%=loggedInUser.getName()%></span>
<a href="logout" style="text-decoration:none;color:#e74c3c;font-weight:600;font-size:15px;transition:.3s;">Logout</a>
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
<div class="hero-left"><h1>My Orders</h1><p>Track and manage all your food orders in one place</p></div>
<div class="hero-right">
<div class="hero-box">Live Tracking</div>
<div class="hero-box">Fast Delivery</div>
<div class="hero-box">Order History</div>
</div></div>
<div class="container">
<%
List<OrderTable> orderList = (List<OrderTable>)request.getAttribute("orderList");
RestaurantDAOImpl restaurantDAO = (RestaurantDAOImpl) request.getAttribute("restaurantDAO");
OrderItemDAOImpl orderItemDAO = (OrderItemDAOImpl) request.getAttribute("orderItemDAO");
MenuDAOImpl menuDAO = (MenuDAOImpl) request.getAttribute("menuDAO");
if (restaurantDAO == null) restaurantDAO = new RestaurantDAOImpl();
if (orderItemDAO == null) orderItemDAO = new OrderItemDAOImpl();
if (menuDAO == null) menuDAO = new MenuDAOImpl();
if(orderList != null && !orderList.isEmpty()){
%>
<div class="page-header">
<h1 class="page-title">My Orders</h1>
<div class="order-count"><%=orderList.size()%> Order<%=orderList.size()!=1?"s":""%></div></div>
<%
for(OrderTable order : orderList){
String statusClass = "placed";
String statusIcon = "";
if(order.getStatus()!=null){
String s = order.getStatus().toLowerCase();
if(s.equals("delivered")){statusClass="delivered";statusIcon="✅";}
else if(s.equals("preparing")){statusClass="preparing";statusIcon="👨‍🍳";}
else if(s.equals("cancelled")){statusClass="cancelled";statusIcon="❌";}
else if(s.equals("placed")){statusClass="placed";statusIcon="📦";}
}
Restaurant restaurant = restaurantDAO.getRestaurant(order.getRestaurantId());
%>
<div class="order-card">
<div class="order-header">
<div>                    <div class="order-id">Order #<%=order.getOrderId()%></div><div class="order-date"><%=order.getOrderDate()%></div></div>
                    <div><span class="status <%=statusClass%>"><%=statusIcon%> <%=order.getStatus()%></span></div></div>
                    <div class="details">
                        <div class="detail-box"><div class="detail-title">Restaurant</div><div class="detail-value"><%=restaurant!=null?restaurant.getName():"Restaurant"%></div></div>
                        <div class="detail-box"><div class="detail-title">Payment</div><div class="detail-value"><%=order.getPaymentMethod()%></div></div>
                        <div class="detail-box"><div class="detail-title">Total</div><div class="total-value">₹ <%=String.format("%.2f",order.getTotalAmount())%></div></div>
                        <div class="detail-box"><div class="detail-title">Status</div><div class="detail-value"><%=order.getStatus()%></div></div>
</div>
<div class="items-section">
<h3 class="items-title">Ordered Items</h3>
<%
List<OrderItem> itemList = orderItemDAO.getOrderItemsByOrderId(order.getOrderId());
if(itemList != null && !itemList.isEmpty()){
for(OrderItem orderItem : itemList){
Menu menu = menuDAO.getMenu(orderItem.getMenuId());
%>
<div class="item-row">
<div><div class="item-name"><%=menu!=null?menu.getItemName():"Food Item"%></div><div class="item-qty">Quantity: <b><%=orderItem.getQuantity()%></b></div></div>
<div class="item-total">₹ <%=String.format("%.2f",orderItem.getItemTotal())%></div></div>
<%
}
}else{
%>
<div style="padding:10px 0;color:#888;">No items found for this order.</div>
<%
}
%>
</div>
<div class="actions">
<a href="menu?restaurantId=<%=order.getRestaurantId()%>" class="order-again">Order Again</a>
<a href="trackorder?orderId=<%=order.getOrderId()%>" class="view-invoice">🔍 Track Order</a>
<a href="menu?restaurantId=<%=order.getRestaurantId()%>" class="rate-order">Review Items</a>
</div></div>
<%
}
}else{
%>
<div class="empty">
<span class="empty-icon">🍽️</span>
<h2>No Orders Yet</h2>
<p>Looks like you haven't placed any orders yet. Start exploring restaurants and order your favourite food!</p>
<a href="callRestaurantServlet">Start Ordering</a>
</div>
<%
}
%>
</div>
<footer>Made with love using Java, JSP, Servlets and MySQL</footer>
</body>
</html>