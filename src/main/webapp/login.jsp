<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Foodie Login</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:Arial, sans-serif;
}

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#ff6b35,#ff9f1c);
}

.login-container{
    width:400px;
    background:white;
    padding:30px;
    border-radius:15px;
    box-shadow:0px 4px 15px rgba(0,0,0,0.2);
}

h1{
    text-align:center;
    color:#ff6b35;
    margin-bottom:20px;
}

.input-group{
    margin-bottom:15px;
}

.input-group label{
    display:block;
    margin-bottom:5px;
    font-weight:bold;
}

.input-group input{
    width:100%;
    padding:12px;
    border:1px solid #ccc;
    border-radius:8px;
}

.btn{
    width:100%;
    padding:12px;
    background:#28a745;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
    font-size:16px;
}

.btn:hover{
    background:#218838;
}

.register-link{
    text-align:center;
    margin-top:15px;
}

.register-link a{
    text-decoration:none;
    color:#ff6b35;
    font-weight:bold;
}

.error{
    color:red;
    text-align:center;
    margin-bottom:15px;
}

</style>
</head>
<body>

<div class="login-container">

    <h1>🍴 Foodie Login</h1>

    <%
    String errorMessage =
            (String)request.getAttribute("errorMessage");

    if(errorMessage != null){
    %>

    <div class="error">
        <%= errorMessage %>
    </div>

    <%
    }
    %>

    <form action="callloginservlet" method="post">

        <div class="input-group">
            <label>Email</label>
            <input type="email"
                   name="email"
                   placeholder="Enter Email"
                   required>
        </div>

        <div class="input-group">
            <label>Password</label>
            <input type="password"
                   name="password"
                   placeholder="Enter Password"
                   required>
        </div>

        <button type="submit" class="btn">
            Login
        </button>

    </form>
    <p style="text-align:center; margin-top:15px;">
    🍔 Ready to order your favorite food?
    <a href="register.jsp"
       style="color:#ff6b35; font-weight:bold;">
       Join Foodie Today!
    </a>
</p>
  

</div>

</body>
</html>