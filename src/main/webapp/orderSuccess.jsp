<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order Success</title>

<style>

body{
    font-family:Arial,sans-serif;
    background:#f4f4f4;
    display:flex;
    justify-content:center;
    align-items:center;
    height:100vh;
}

.box{
    background:white;
    padding:40px;
    border-radius:15px;
    text-align:center;
    box-shadow:0 2px 10px rgba(0,0,0,0.2);
}

h1{
    color:green;
}

a{
    text-decoration:none;
    color:white;
    background:#ff6b35;
    padding:10px 20px;
    border-radius:5px;
}

</style>

</head>
<body>

<div class="box">

    <h1>✅ Order Placed Successfully</h1>

    <p>
        Thank you for ordering with Foodie.
    </p>

    <br>

    <a href="callRestaurantServlet">
        Continue Shopping
    </a>

</div>

</body>
</html>