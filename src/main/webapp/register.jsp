
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Foodie - Register</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Segoe UI',sans-serif;
}

body{
    background:linear-gradient(135deg,#ff6b35,#ff9f43);
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
}

.container{
    width:450px;
    background:white;
    border-radius:20px;
    padding:35px;
    box-shadow:0 10px 25px rgba(0,0,0,0.2);
}

.logo{
    text-align:center;
    font-size:40px;
    margin-bottom:10px;
}

h1{
    text-align:center;
    color:#ff6b35;
    margin-bottom:25px;
}

.input-group{
    margin-bottom:15px;
}

label{
    display:block;
    margin-bottom:6px;
    font-weight:bold;
    color:#444;
}

input,
textarea{
    width:100%;
    padding:12px;
    border:1px solid #ddd;
    border-radius:10px;
    outline:none;
    font-size:15px;
}

input:focus,
textarea:focus{
    border-color:#ff6b35;
}

textarea{
    resize:none;
    height:80px;
}

.btn{
    width:100%;
    padding:14px;
    border:none;
    border-radius:10px;
    background:#ff6b35;
    color:white;
    font-size:17px;
    cursor:pointer;
    margin-top:10px;
}

.btn:hover{
    background:#e85d2c;
}

.login-link{
    text-align:center;
    margin-top:20px;
}

.login-link a{
    color:#ff6b35;
    text-decoration:none;
    font-weight:bold;
}

</style>
</head>
<body>

<div class="container">

    <div class="logo">🍴</div>

    <h1>Create Account</h1>

    <form action="callregisterservlet" method="post">

        <div class="input-group">
            <label>Full Name</label>
            <input type="text" name="name" required>
        </div>

        <div class="input-group">
            <label>Username</label>
            <input type="text" name="username" required>
        </div>

        <div class="input-group">
            <label>Email Address</label>
            <input type="email" name="email" required>
        </div>

        <div class="input-group">
            <label>Phone Number</label>
            <input type="text" name="phone" required>
        </div>

        <div class="input-group">
            <label>Password</label>
            <input type="password" name="password" required>
        </div>

        <div class="input-group">
            <label>Delivery Address</label>
            <textarea name="address" required></textarea>
        </div>

        <button type="submit" class="btn">
            Register
        </button>

    </form>

    <div class="login-link">
        Already have an account?
        <a href="login.jsp">Login Here</a>
    </div>

</div>

</body>
</html>
