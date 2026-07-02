<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.util.List"%>

<%@ page import="com.tap.model.OrderTable"%>
<%@ page import="com.tap.model.OrderItem"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.Restaurant"%>

<%@ page import="com.tap.daoimplementation.OrderItemDAOImpl"%>
<%@ page import="com.tap.daoimplementation.MenuDAOImpl"%>
<%@ page import="com.tap.daoimplementation.RestaurantDAOImpl"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Orders | Foodie</title>

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
margin:40px auto;
}

.page-title{
font-size:38px;
margin-bottom:30px;
color:#333;
}

/* ================= ORDER CARD ================= */

.order-card{
background:white;
padding:25px;
border-radius:15px;
margin-bottom:30px;
box-shadow:0 5px 20px rgba(0,0,0,.12);
transition:.3s;
}

.order-card:hover{
transform:translateY(-5px);
}

.order-header{
display:flex;
justify-content:space-between;
align-items:center;
margin-bottom:20px;
}

.order-id{
font-size:24px;
font-weight:bold;
color:#333;
}

.order-date{
margin-top:8px;
color:#666;
}

/* ================= STATUS ================= */

.status{
padding:8px 18px;
border-radius:30px;
color:white;
font-weight:bold;
}

.delivered{
background:#28a745;
}

.preparing{
background:#ff9800;
}

.cancelled{
background:#dc3545;
}

/* ================= DETAILS ================= */

.details{
display:grid;
grid-template-columns:repeat(2,1fr);
gap:15px;
margin-top:20px;
}

.detail-box{
background:#fafafa;
padding:15px;
border-radius:10px;
}

.detail-title{
font-weight:bold;
margin-bottom:8px;
color:#555;
}

.total{
font-size:24px;
font-weight:bold;
color:#28a745;
}

/* ================= ORDER ITEMS ================= */

.items-title{
margin-top:30px;
margin-bottom:15px;
font-size:22px;
font-weight:bold;
color:#333;
}

.item-row{
display:flex;
justify-content:space-between;
align-items:center;
padding:15px 0;
border-bottom:1px solid #ececec;
}

.item-name{
font-size:18px;
font-weight:600;
}

.item-qty{
margin-top:5px;
color:#666;
}

.item-total{
font-size:18px;
font-weight:bold;
color:#28a745;
}

/* ================= BUTTON ================= */

.order-btn{
margin-top:25px;
}

.order-btn a{
text-decoration:none;
background:#ff6b35;
color:white;
padding:12px 25px;
border-radius:10px;
transition:.3s;
display:inline-block;
}

.order-btn a:hover{
background:#e55b2b;
}

/* ================= EMPTY ================= */

.empty{
text-align:center;
padding:100px;
}

.empty h2{
font-size:34px;
color:#777;
}

.empty p{
margin:20px 0;
font-size:18px;
color:#666;
}

.empty a{
display:inline-block;
margin-top:20px;
padding:15px 30px;
text-decoration:none;
background:#ff6b35;
color:white;
border-radius:10px;
}

/* ================= RESPONSIVE ================= */

@media(max-width:900px){

.details{
grid-template-columns:1fr;
}

.order-header{
flex-direction:column;
align-items:flex-start;
gap:15px;
}

.item-row{
flex-direction:column;
align-items:flex-start;
gap:10px;
}

.navbar{
padding:18px 20px;
}

.nav-links a{
margin-left:12px;
font-size:15px;
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

<a href="orderhistory">My Orders</a>

<a href="login.jsp">Logout</a>

</div>

</div>

<div class="container">

<h1 class="page-title">
📦 My Orders
</h1>

<%

List<OrderTable> orderList =
(List<OrderTable>)request.getAttribute("orderList");

RestaurantDAOImpl restaurantDAO = new RestaurantDAOImpl();
OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
MenuDAOImpl menuDAO = new MenuDAOImpl();

if(orderList != null && !orderList.isEmpty()){

for(OrderTable order : orderList){

String statusClass="preparing";

if(order.getStatus()!=null){

if(order.getStatus().equalsIgnoreCase("Delivered")){

statusClass="delivered";

}
else if(order.getStatus().equalsIgnoreCase("Cancelled")){

statusClass="cancelled";

}

}

Restaurant restaurant =
restaurantDAO.getRestaurantById(order.getRestaurantId());

%>
<div class="order-card">

<div class="order-header">

<div>

<div class="order-id">

Order #<%=order.getOrderId()%>

</div>

<div class="order-date">

🗓 <%=order.getOrderDate()%>

</div>

</div>

<div>

<span class="status <%=statusClass%>">

<%=order.getStatus()%>

</span>

</div>

</div>

<div class="details">

<div class="detail-box">

<div class="detail-title">

🍴 Restaurant

</div>

<div>

<%=restaurant!=null ? restaurant.getName() : "Restaurant"%>

</div>

</div>

<div class="detail-box">

<div class="detail-title">

💳 Payment Method

</div>

<div>

<%=order.getPaymentMethod()%>

</div>

</div>

<div class="detail-box">

<div class="detail-title">

💰 Total Amount

</div>

<div class="total">

₹ <%=String.format("%.2f",order.getTotalAmount())%>

</div>

</div>

<div class="detail-box">

<div class="detail-title">

📦 Order Status

</div>

<div>

<%=order.getStatus()%>

</div>

</div>

</div>

<h3 class="items-title">

🍽 Ordered Items

</h3>

<%

List<OrderItem> itemList =
orderItemDAO.getOrderItemsByOrderId(order.getOrderId());

if(itemList!=null && !itemList.isEmpty()){

for(OrderItem orderItem : itemList){

Menu menu =
menuDAO.getMenu(orderItem.getMenuId());

%>

<div class="item-row">

<div>

<div class="item-name">

<%=menu!=null ? menu.getItemName() : "Food Item"%>

</div>

<div class="item-qty">

Quantity :
<b><%=orderItem.getQuantity()%></b>

</div>

</div>

<div class="item-total">

₹ <%=String.format("%.2f",orderItem.getItemTotal())%>

</div>

</div>

<%

}

}

else{

%>

<div style="padding:15px;color:#777;">

No items found for this order.

</div>

<%

}

%>
<div class="order-btn">

<a href="menu?restaurantId=<%=order.getRestaurantId()%>">

🔁 Order Again

</a>

<a href="invoice.jsp?orderId=<%=order.getOrderId()%>"
style="
margin-left:15px;
background:#2196f3;
color:white;
padding:12px 25px;
text-decoration:none;
border-radius:10px;">

📄 View Invoice

</a>

<a href="rateOrder.jsp?orderId=<%=order.getOrderId()%>"
style="
margin-left:15px;
background:#28a745;
color:white;
padding:12px 25px;
text-decoration:none;
border-radius:10px;">

⭐ Rate Order

</a>

</div>

</div>

<%

}

}

else{

%>

<div class="empty">

<h2>

📦 No Orders Yet

</h2>

<p>

Looks like you haven't placed any orders yet.

</p>

<br>

<a href="callRestaurantServlet">

🍴 Start Ordering

</a>

</div>

<%

}

%>

</div>

</body>

</html>