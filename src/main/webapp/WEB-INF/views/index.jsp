<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>

<!------ Include the above in your HEAD tag ---------->

<!DOCTYPE html>
<html>
<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<head>
	<title>Login Page</title>
   <!--Made with love by Mutiullah Samim -->
   
	<!--Bootsrap 4 CDN-->
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
  
    <!--Fontawesome CDN-->
	<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
	<link rel="stylesheet" href="/css/login.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
</head>
<body onload="document.getElementById('mem_email').focus();">
<div class="container">
	<div class="d-flex justify-content-center h-100">
		<div class="card">
			<div class="card-header">
				<h3>Sign In</h3>
				<%-- 
				<div class="d-flex justify-content-end social_icon">
					<span><i class="fab fa-facebook-square"></i></span>8
					<span><i class="fab fa-google-plus-square"></i></span>
					<span><i class="fab fa-twitter-square"></i></span>
				</div>
				--%>
				<div>
				<a href="/kakaoLogin/loginRequest.do">
				<img style="float:right;" src="/images/kakaolink_btn_small.png"/>
				</a>
				</div>
				
			</div>
			<div class="card-body">
				<form name="f" method="post" action="/login/login.do">
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-user"></i></span>
						</div>
						<input type="text" class="form-control" id="mem_email" name="mem_email" placeholder="Enter your Email">
						
					</div>
					<div class="input-group form-group">
						<div class="input-group-prepend">
							<span class="input-group-text"><i class="fas fa-key"></i></span>
						</div>
						<input type="password" class="form-control" id="mem_pwd" name="mem_pwd" placeholder="Enter your Password">
					</div>
					<%-- 
					<div class="row align-items-center remember">
						<input type="checkbox">Remember Me
					</div>
					--%>
					<div class="form-group">
						<input type="button" id="loginBtn" value="Login" class="btn float-right login_btn" onclick="loginSubmit()">
					</div>
				</form>

				
				
			</div>
			
			<div style="margin-bottom:20px;" class="card-footer">
				<div class="d-flex justify-content-center links">
					Don't have an account?<a href="/join/joinForm.do">Sign Up</a>
				</div>
				<%-- 
				<div class="d-flex justify-content-center">
					<a href="#">Forgot your password?</a>
				</div>
				--%>
			</div>
		</div>
	</div>
</div>
<script>


function loginSubmit() {
	var mem_email = $("#mem_email").val();
	var mem_pwd = $("#mem_pwd").val();
	
	if(mem_email.length == 0) {
		alert("이메일을 입력해주세요.");
		$("#mem_email").focus();
		return;
	}
	if(mem_pwd.length == 0) {
		alert("비밀번호를 입력해주세요.");
		$("#mem_pwd").focus();
		return;
	}
	f.submit();	
}

$(document).ready(function(){	
	
	$("#mem_email").on('keyup', function(){
		if(window.event.keyCode == 13) {
			loginSubmit();
		}
	});
	$("#mem_pwd").on('keyup', function(){
		if(window.event.keyCode == 13) {
			loginSubmit();
		}
	});
	
});
</script>
</body>
</html>