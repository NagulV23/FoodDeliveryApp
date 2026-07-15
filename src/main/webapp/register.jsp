<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Join Foodie | Register</title>

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
    background:linear-gradient(135deg,#ff6b35,#ff9f43);
    padding:20px;
    position:relative;
    overflow:hidden;
}

body::before{
    content:'';
    position:absolute;
    top:-40%;
    right:-20%;
    width:500px;
    height:500px;
    border-radius:50%;
    background:rgba(255,255,255,.08);
}

body::after{
    content:'';
    position:absolute;
    bottom:-30%;
    left:-20%;
    width:400px;
    height:400px;
    border-radius:50%;
    background:rgba(255,255,255,.06);
}

.register-wrapper{
    width:100%;
    max-width:540px;
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

.container{
    background:rgba(255,255,255,0.97);
    backdrop-filter:blur(20px);
    border-radius:24px;
    padding:40px 38px;
    box-shadow:0 25px 60px rgba(0,0,0,0.2);
}

.logo{
    text-align:center;
    margin-bottom:8px;
}

.logo .icon{
    font-size:50px;
    display:block;
    margin-bottom:6px;
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

.form-grid{
    display:grid;
    grid-template-columns:1fr 1fr;
    gap:18px;
    margin-top:25px;
}

.form-grid .full-width{
    grid-column:span 2;
}

.input-group{
    margin-bottom:4px;
}

label{
    display:block;
    margin-bottom:7px;
    font-weight:600;
    font-size:13px;
    color:#444;
}

.input-wrap{
    position:relative;
}

.input-wrap .input-icon{
    position:absolute;
    left:14px;
    top:50%;
    transform:translateY(-50%);
    font-size:16px;
    color:#bbb;
}

input,
textarea{
    width:100%;
    padding:14px 14px 14px 44px;
    border:2px solid #eee;
    border-radius:12px;
    outline:none;
    font-size:14px;
    transition:.3s;
    background:#fafafa;
}

input:focus,
textarea:focus{
    border-color:#ff6b35;
    background:white;
    box-shadow:0 0 0 4px rgba(255,107,53,.1);
}

input::placeholder,
textarea::placeholder{
    color:#bbb;
}

textarea{
    resize:none;
    height:80px;
    padding-top:14px;
}

.btn{
    width:100%;
    padding:16px;
    border:none;
    border-radius:14px;
    background:linear-gradient(135deg,#ff6b35,#ff914d);
    color:white;
    font-size:17px;
    font-weight:600;
    cursor:pointer;
    margin-top:8px;
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

.terms{
    margin-top:18px;
    font-size:13px;
    color:#888;
    text-align:center;
    line-height:1.6;
}

.terms a{
    color:#ff6b35;
    text-decoration:none;
    font-weight:500;
}

.login-link{
    text-align:center;
    margin-top:20px;
    font-size:15px;
    color:#888;
}

.login-link a{
    color:#ff6b35;
    text-decoration:none;
    font-weight:600;
    transition:.3s;
}

.login-link a:hover{
    color:#e55b2b;
}

@media(max-width:540px){
    .container{
        padding:30px 22px;
    }
    .form-grid{
        grid-template-columns:1fr;
    }
    .form-grid .full-width{
        grid-column:span 1;
    }
}

</style>
</head>
<body>

<div class="register-wrapper">

<div class="container">

    <div class="logo">
        <span class="icon">🍔</span>
        <h1>Join <span>Foodie</span></h1>
        <p>Create your account and start ordering delicious food!</p>
    </div>

    <form action="callregisterservlet" method="post">

        <div class="form-grid">

            <div class="input-group">
                <label>Full Name</label>
                <div class="input-wrap">
                    <span class="input-icon">👤</span>
                    <input type="text" name="name" placeholder="John Doe" required>
                </div>
            </div>

            <div class="input-group">
                <label>Username</label>
                <div class="input-wrap">
                    <span class="input-icon">@</span>
                    <input type="text" name="username" placeholder="johndoe" required>
                </div>
            </div>

            <div class="input-group full-width">
                <label>Email Address</label>
                <div class="input-wrap">
                    <span class="input-icon">✉️</span>
                    <input type="email" name="email" placeholder="john@example.com" required>
                </div>
            </div>

            <div class="input-group">
                <label>Phone Number</label>
                <div class="input-wrap">
                    <span class="input-icon">📞</span>
                    <input type="text" name="phone" placeholder="9876543210" required>
                </div>
            </div>

            <div class="input-group">
                <label>Password</label>
                <div class="input-wrap">
                    <span class="input-icon">🔒</span>
                    <input type="password" name="password" id="password" placeholder="Create password" required>
                </div>
            </div>

            <div class="input-group full-width">
                <label>Delivery Address</label>
                <div class="input-wrap">
                    <span class="input-icon" style="top:20px;transform:none;">📍</span>
                    <textarea name="address" placeholder="House No, Street, City, State - Pincode" required></textarea>
                </div>
            </div>

        </div>

        <div class="terms">
            By creating an account, you agree to our 
            <a href="#">Terms of Service</a> and <a href="#">Privacy Policy</a>
        </div>

        <button type="submit" class="btn">
            Create Account →
        </button>

    </form>

    <div class="divider">or sign up with</div>

    <div style="text-align:center;">
        <a href="#" style="
            display:inline-block;
            padding:12px 30px;
            border:2px solid #eee;
            border-radius:12px;
            text-decoration:none;
            color:#444;
            font-weight:500;
            transition:.3s;
        " onmouseover="this.style.borderColor='#ff6b35';this.style.background='#fff8f5'"
           onmouseout="this.style.borderColor='#eee';this.style.background='transparent'">
            🔵 Sign up with Google
        </a>
    </div>

    <div class="login-link">
        Already have an account?
        <a href="login.jsp">Sign In</a>
    </div>

</div>

</div>

</body>
</html>