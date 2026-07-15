<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.tap.model.Menu"%>
<%@ page import="com.tap.model.Restaurant"%>
<%@ page import="com.tap.model.cart"%>
<%@ page import="com.tap.model.User"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Search Results | Foodie</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
*{margin:0;padding:0;box-sizing:border-box;font-family:'Poppins',sans-serif;}
body{background:#f8f8f8;}
.navbar{height:78px;padding:0 70px;display:flex;justify-content:space-between;align-items:center;background:white;box-shadow:0 5px 18px rgba(0,0,0,.08);position:sticky;top:0;z-index:1000;}
.logo{font-size:34px;font-weight:bold;color:#ff6b35;text-decoration:none;}
.nav-links{display:flex;gap:35px;align-items:center;}
.nav-links a{text-decoration:none;color:#444;font-size:18px;font-weight:500;transition:.3s;}
.nav-links a:hover{color:#ff6b35;}
.nav-search{display:flex;align-items:center;gap:8px;}
.nav-search input{padding:10px 18px;border:2px solid #eee;border-radius:25px;outline:none;font-size:14px;width:220px;transition:.3s;}
.nav-search input:focus{border-color:#ff6b35;box-shadow:0 0 0 3px rgba(255,107,53,.1);}
.nav-search button{padding:10px 20px;border:none;background:#ff6b35;color:white;border-radius:25px;cursor:pointer;font-weight:600;transition:.3s;font-size:14px;}
.nav-search button:hover{background:#e55b2b;}
.hero{background:linear-gradient(135deg,#ff6b35,#ff914d);padding:50px 30px;text-align:center;color:white;}
.hero h1{font-size:42px;margin-bottom:10px;}
.hero p{font-size:18px;opacity:.9;}
.hero .query-highlight{background:rgba(255,255,255,.2);padding:4px 16px;border-radius:20px;display:inline-block;margin-top:12px;font-weight:600;font-size:16px;}
.container{width:90%;margin:35px auto;padding-bottom:60px;}
.result-count{margin-bottom:25px;font-size:18px;color:#888;font-weight:500;}
.results-grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(340px,1fr));gap:30px;}
.result-card{background:white;border-radius:20px;overflow:hidden;box-shadow:0 10px 25px rgba(0,0,0,.08);transition:.35s;display:flex;flex-direction:column;}
.result-card:hover{transform:translateY(-8px);box-shadow:0 18px 40px rgba(0,0,0,.15);}
.result-card img{width:100%;height:200px;object-fit:cover;transition:.4s;}
.result-card:hover img{transform:scale(1.06);}
.card-body{padding:20px 22px;flex:1;display:flex;flex-direction:column;}
.card-body h3{font-size:22px;color:#222;margin-bottom:4px;}
.resto-name{color:#ff6b35;font-size:15px;font-weight:600;margin-bottom:8px;text-decoration:none;display:inline-block;transition:.3s;}
.resto-name:hover{color:#e55b2b;text-decoration:underline;}
.card-body .desc{color:#888;font-size:14px;margin-bottom:12px;line-height:1.6;flex:1;}
.price-row{display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;}
.price{font-size:26px;font-weight:bold;color:#27ae60;}
.delivery-badge{color:#888;font-size:13px;}
.btn{width:100%;padding:14px;border:none;border-radius:12px;background:#ff6b35;color:white;font-size:16px;font-weight:bold;cursor:pointer;transition:.3s;}
.btn:hover{background:#e55b2b;transform:scale(1.02);}
.empty{text-align:center;padding:80px 20px;}
.empty h2{font-size:34px;color:#888;margin-bottom:15px;}
.empty p{font-size:18px;color:#999;margin-bottom:25px;}
.empty a{display:inline-block;padding:15px 35px;background:#ff6b35;color:white;text-decoration:none;border-radius:12px;font-weight:600;transition:.3s;}
.empty a:hover{background:#e55b2b;transform:translateY(-3px);}
.cart-link{position:relative;text-decoration:none;color:#444;font-size:18px;font-weight:500;transition:.3s;}
.cart-link:hover{color:#ff6b35;}
.cart-badge{display:none;position:absolute;top:-10px;right:-14px;background:#ff6b35;color:white;font-size:11px;font-weight:700;min-width:20px;height:20px;border-radius:10px;text-align:center;line-height:20px;padding:0 5px;box-shadow:0 3px 8px rgba(255,82,0,.3);}
.cart-badge.show{display:block;}
.toast{position:fixed;top:100px;right:-400px;z-index:9999;background:white;padding:18px 28px;border-radius:18px;box-shadow:0 20px 50px rgba(0,0,0,.18);display:flex;align-items:center;gap:16px;transition:right .5s cubic-bezier(.22,.61,.36,1);border-left:5px solid #27ae60;min-width:320px;}
.toast.show{right:30px;}
.toast-icon{font-size:36px;flex-shrink:0;}
.toast-title{font-size:16px;font-weight:700;color:#27ae60;margin-bottom:4px;}
.toast-item-name{font-size:18px;font-weight:600;color:#222;}
.toast-sub{font-size:13px;color:#999;margin-top:3px;}
footer{margin-top:50px;padding:35px;text-align:center;background:white;font-size:15px;color:#888;box-shadow:0 -5px 20px rgba(0,0,0,.05);}
@media(max-width:900px){.navbar{padding:20px;height:auto;flex-direction:column;gap:15px;}.nav-links{gap:15px;flex-wrap:wrap;justify-content:center;}.nav-search input{width:160px;}.results-grid{grid-template-columns:1fr;}.hero h1{font-size:30px;}}
</style>
</head>
<body>
<%
List<Menu> results = (List<Menu>) request.getAttribute("results");
Map<Integer, Restaurant> restaurantMap = (Map<Integer, Restaurant>) request.getAttribute("restaurantMap");
String searchQuery = (String) request.getAttribute("searchQuery");
if (results == null) results = new java.util.ArrayList<>();
int resultCount = results.size();
%>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
%>
<div class="navbar">
<a href="home.jsp" class="logo">🍴 Foodie</a>
<div class="nav-links">
<a href="home.jsp">Home</a>
<a href="callRestaurantServlet">Restaurants</a>
<a href="cart.jsp" class="cart-link">Cart<span class="cart-badge" id="cartBadge"><%= session.getAttribute("cart") != null ? ((cart)session.getAttribute("cart")).getItems().size() : 0 %></span></a>
<%
if(loggedInUser != null){
%>
<span style="display:flex;align-items:center;gap:8px;font-size:14px;font-weight:600;color:#444;">👋 <%=loggedInUser.getName()%></span>
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
<div class="hero">
<h1>🔍 Search Results</h1>
<p>Showing delicious food matching your search</p>
<div class="query-highlight">"<%= searchQuery != null ? searchQuery : "" %>"</div>
</div>
<div class="container">
<div class="result-count"><%= resultCount %> result<%= resultCount != 1 ? "s" : "" %> found</div>
<%
if (resultCount > 0) {
%>
<div class="results-grid">
<%
for (Menu menu : results) {
Restaurant resto = restaurantMap != null ? restaurantMap.get(menu.getRestaurantId()) : null;
%>
<div class="result-card">
<img src="<%= request.getContextPath() %>/<%= menu.getImagePath() %>" alt="<%= menu.getItemName() %>">
<div class="card-body">
<h3><%= menu.getItemName() %></h3>
<% if (resto != null) { %>
<a href="menu?restaurantId=<%= resto.getRestaurantId() %>" class="resto-name">🍽 <%= resto.getName() %></a>
<% } %>
<p class="desc"><%= menu.getDescription() %></p>
<div class="price-row">
<span class="price">₹ <%= menu.getPrice() %></span>
<span class="delivery-badge">🚀 Fast Delivery</span>
</div>
<form action="cartservlet" method="post" class="add-to-cart-form">
<input type="hidden" name="menuId" value="<%= menu.getMenuId() %>">
<input type="hidden" name="restaurantId" value="<%= menu.getRestaurantId() %>">
<input type="hidden" name="quantity" value="1">
<input type="hidden" name="action" value="add">
<button type="submit" class="btn">🛒 Add To Cart</button>
</form>
</div>
</div>
<%
}
%>
</div>
<%
} else {
%>
<div class="empty">
<h2>😔 No Results Found</h2>
<p>We couldn't find any menu items matching "<b><%= searchQuery %></b>". Try searching for something else!</p>
<a href="callRestaurantServlet">Browse All Restaurants</a>
</div>
<%
}
%>
</div>

<!-- Toast -->
<div class="toast" id="toast">
<div class="toast-icon">✅</div>
<div>
<div class="toast-title">Added to Cart!</div>
<div class="toast-item-name" id="toastItemName">Item</div>
<div class="toast-sub">Check your cart to review</div>
</div>
</div>

<footer>Made with ❤️ using Java, JSP, Servlets & MySQL</footer>

<script>
// Cart badge init
function updateCartBadge(){
var badge = document.getElementById('cartBadge');
if(!badge) return;
var count = parseInt(badge.textContent) || 0;
if(count > 0) badge.classList.add('show');
else badge.classList.remove('show');
}
updateCartBadge();

// Add to cart AJAX
document.querySelectorAll('.add-to-cart-form').forEach(function(form){
form.addEventListener('submit', function(e){
e.preventDefault();
var formData = new FormData(this);
formData.append('ajax', 'true');
var btn = this.querySelector('.btn');
var originalText = btn.innerHTML;
btn.innerHTML = '⏳ Adding...';
btn.disabled = true;
fetch('cartservlet', {method:'POST',body:formData})
.then(function(res){return res.json();})
.then(function(data){
if(data.success){
var badge = document.getElementById('cartBadge');
if(badge){
badge.textContent = data.cartCount;
if(data.cartCount > 0) badge.classList.add('show');
else badge.classList.remove('show');
}
var toast = document.getElementById('toast');
var toastName = document.getElementById('toastItemName');
if(toast && toastName){
toastName.textContent = data.itemName;
toast.classList.add('show');
setTimeout(function(){toast.classList.remove('show');},3000);
}
}
btn.innerHTML = originalText;
btn.disabled = false;
})
.catch(function(){
btn.innerHTML = originalText;
btn.disabled = false;
form.submit();
});
});
});
</script>
</body>
</html>
