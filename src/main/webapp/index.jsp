<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Vehicle Service System</title>
<link rel="stylesheet" type="text/css" href="Styles/index.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Lora:ital,wght@0,400;0,500;0,700;1,400&display=swap" rel="stylesheet">
</head>

<body>

<div class="logo">
	<img alt="" src="Images/logo-white.png">
</div>
<div class="login-container">
<h1>Welcome to a Safe Ride!</h1>
<div class="content">
<div class="inner-div">

	<button class="btn" onclick="window.location.href='https://api.asgardeo.io/t/projectwheelxgo/oauth2/authorize?response_type=code&client_id=Sgw02f5sSRq273fxmMfySrPILAQa&scope=openid%20email%20phone%20profile&redirect_uri=http%3A%2F%2Flocalhost%3A8080%2FVehicleServiceSystem%2Fauth.jsp'" class="form-control btn btn-primary submit px-3">
	<span class="btn-text">Login</span>
	<div class="fill-container"></div>
	</button>
	
	
</div>
</div>
</div>
</body>
</html>