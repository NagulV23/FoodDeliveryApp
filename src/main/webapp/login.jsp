<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Welcome Back | Foodie</title>

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:'Poppins',sans-serif;
}

body{
    min-height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#ff6b35,#ff9f1c);
    padding:20px;
    position:relative;
    overflow:hidden;
}

body::before{
    content:'';
    position:absolute;
    top:-50%;
    right:-30%;
    width:600px;
    height:600px;
    border-radius:50%;
    background:rgba(255,255,255,.08);
}

body::after{
    content:'';
    position:absolute;
    bottom:-40%;
    left:-20%;
    width:500px;
    height:500px;
    border-radius:50%;
    background:rgba(255,255,255,.06);
}

.login-wrapper{
    width:100%;
    max-width:460px;
    position:relative;
    z-index:1;
    animation:fadeUp .6s ease;
}

@keyframes fadeUp{
    from{
        opacity:0;
        transform:translateY(30px);
    }
    to{
        opacity:1;
        transform:translateY(0);
    }
}

.login-container{
    background:rgba(255,255,255,0.97);
    backdrop-filter:blur(20px);
    padding:45px 40px 35px;
    border-radius:24px;
    box-shadow:0 25px 60px rgba(0,0,0,0.2);
}

.logo{
    text-align:center;
    margin-bottom:8px;
}

.logo .icon{
    font-size:50px;
    display:block;
    margin-bottom:8px;
}

.logo h1{
    font-size:30px;
    font-weight:700;
    color:#222;
}

.logo h1 span{
    color:#ff6b35;
}

.logo p{
    color:#888;
    font-size:15px;
    margin-top:6px;
}

.error{
    background:#fff0f0;
    color:#e74c3c;
    padding:14px 18px;
    border-radius:12px;
    font-size:14px;
    font-weight:500;
    margin-bottom:20px;
    display:flex;
    align-items:center;
    gap:10px;
    border:1px solid #ffd5d5;
    animation:shake .4s ease;
}

@keyframes shake{
    0%,100%{transform:translateX(0)}
    25%{transform:translateX(-8px)}
    75%{transform:translateX(8px)}
}

.input-group{
    margin-bottom:20px;
}

.input-group label{
    display:block;
    margin-bottom:8px;
    font-weight:600;
    font-size:14px;
    color:#444;
}

.input-group .input-wrap{
    position:relative;
}

.input-group .input-wrap .input-icon{
    position:absolute;
    left:16px;
    top:50%;
    transform:translateY(-50%);
    font-size:18px;
    color:#bbb;
}

.input-group .input-wrap input{
    width:100%;
    padding:16px 16px 16px 50px;
    border:2px solid #eee;
    border-radius:14px;
    font-size:15px;
    outline:none;
    transition:.3s;
    background:#fafafa;
}

.input-group .input-wrap input:focus{
    border-color:#ff6b35;
    background:white;
    box-shadow:0 0 0 4px rgba(255,107,53,.1);
}

.input-group .input-wrap input::placeholder{
    color:#bbb;
}

.input-group .toggle-pw{
    position:absolute;
    right:16px;
    top:50%;
    transform:translateY(-50%);
    background:none;
    border:none;
    font-size:18px;
    cursor:pointer;
    color:#bbb;
    transition:.3s;
    padding:4px;
}

.input-group .toggle-pw:hover{
    color:#ff6b35;
}

.options{
    display:flex;
    justify-content:space-between;
    align-items:center;
    margin-bottom:25px;
    font-size:14px;
}

.options label{
    display:flex;
    align-items:center;
    gap:8px;
    color:#666;
    cursor:pointer;
}

.options label input[type="checkbox"]{
    width:18px;
    height:18px;
    accent-color:#ff6b35;
}

.options a{
    color:#ff6b35;
    text-decoration:none;
    font-weight:500;
    transition:.3s;
}

.options a:hover{
    color:#e55b2b;
}

.btn{
    width:100%;
    padding:16px;
    background:linear-gradient(135deg,#ff6b35,#ff914d);
    color:white;
    border:none;
    border-radius:14px;
    cursor:pointer;
    font-size:17px;
    font-weight:600;
    transition:.3s;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:8px;
}

.btn:hover{
    transform:translateY(-2px);
    box-shadow:0 12px 30px rgba(255,107,53,.35);
}

.btn:active{
    transform:translateY(0);
}

.divider{
    display:flex;
    align-items:center;
    gap:15px;
    margin:25px 0;
    color:#bbb;
    font-size:13px;
}

.divider::before,
.divider::after{
    content:'';
    flex:1;
    height:1px;
    background:#eee;
}

.social-login{
    display:flex;
    gap:12px;
}

.social-login a{
    flex:1;
    padding:14px;
    border:2px solid #eee;
    border-radius:14px;
    text-decoration:none;
    text-align:center;
    font-size:15px;
    font-weight:500;
    color:#444;
    transition:.3s;
    display:flex;
    align-items:center;
    justify-content:center;
    gap:8px;
}

.social-login a:hover{
    border-color:#ff6b35;
    background:#fff8f5;
    transform:translateY(-2px);
}

.register-link{
    text-align:center;
    margin-top:25px;
    font-size:15px;
    color:#888;
}

.register-link a{
    color:#ff6b35;
    text-decoration:none;
    font-weight:600;
    transition:.3s;
}

.register-link a:hover{
    color:#e55b2b;
}

@media(max-width:480px){
    .login-container{
        padding:30px 25px;
    }
    .social-login{
        flex-direction:column;
    }
}

</style>
</head>
<body>

<div class="login-wrapper">

<div class="login-container">

    <div class="logo">
        <span class="icon">🍔</span>
        <h1><span>Foodie</span> Login</h1>
        <p>Welcome back! Sign in to continue ordering</p>
    </div>

    <%
    String errorMessage =
            (String)request.getAttribute("errorMessage");

    if(errorMessage != null){
    %>

    <div class="error">
        ⚠️ <%= errorMessage %>
    </div>

    <%
    }
    %>

    <form action="callloginservlet" method="post">

        <div class="input-group">
            <label>Email Address</label>
            <div class="input-wrap">
                <span class="input-icon">✉️</span>
                <input type="email"
                       name="email"
                       placeholder="Enter your email"
                       required>
            </div>
        </div>

        <div class="input-group">
            <label>Password</label>
            <div class="input-wrap">
                <span class="input-icon">🔒</span>
                <input type="password"
                       name="password"
                       id="password"
                       placeholder="Enter your password"
                       required>
                <button type="button" class="toggle-pw" id="togglePwBtn" onclick="togglePassword()" tabindex="-1" aria-label="Toggle password visibility">
                    👁️
                </button>
            </div>
        </div>

        <div class="options">
            <label>
                <input type="checkbox" checked>
                Remember me
            </label>
            <a href="#">Forgot Password?</a>
        </div>

        <button type="submit" class="btn">
            Sign In →
        </button>

    </form>

    <div class="divider">or continue with</div>

    <div class="social-login">
        <a href="#">
            <span>🔵</span> Google
        </a>
        <a href="#">
            <span>🔷</span> Facebook
        </a>
    </div>

    <div class="register-link">
        Don't have an account?
        <a href="register.jsp">Create One</a>
    </div>

</div>

</div>

<script>
function togglePassword(){
    const pw = document.getElementById('password');
    const btn = document.getElementById('togglePwBtn');
    if(pw.type === 'password'){
        pw.type = 'text';
        btn.textContent = '🙈';
    } else {
        pw.type = 'password';
        btn.textContent = '👁️';
    }
}
</script>

</body>
</html>