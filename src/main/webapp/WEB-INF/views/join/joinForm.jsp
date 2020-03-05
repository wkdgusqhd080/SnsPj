<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>

<!------ Include the above in your HEAD tag ---------->
<!DOCTYPE html>
<html lang="kor">
    <head> 
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<!-- Website Font style -->
	    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css">
		
		<!-- Google Fonts -->
		<link href='https://fonts.googleapis.com/css?family=Passion+One' rel='stylesheet' type='text/css'>
		<link href='https://fonts.googleapis.com/css?family=Oxygen' rel='stylesheet' type='text/css'>
		<link href="/css/join.css" rel="stylesheet">
		<title>Join</title>
	</head>
	<link href="//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<body onload="$('#mem_email').focus()">
		<div class="container">
			<div class="row main">
				<div class="panel-heading">
	               <div class="panel-title text-center">
	               		<h1 class="title">Join us</h1>
	               		<hr />
	               	</div>
	            </div> 
				<div class="main-login main-center">
					<form class="form-horizontal" name="f" method="post" action="/join/joinAccess.do">
					
						<div class="form-group">
							<label for="email" class="cols-sm-2 control-label">Your Email</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-envelope fa" aria-hidden="true"></i></span>
									<input type="text" class="form-control" name="mem_email" id="mem_email"  placeholder="Enter your Email"/>
								</div>
							</div>
							<input type="hidden" id="email_duplicate" value="unChecked">
							<div id="msgEmail"></div>
						</div>

						<div class="form-group">
							<label for="password" class="cols-sm-2 control-label">Password</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
									<input type="password" class="form-control" name="mem_pwd" id="mem_pwd"  placeholder="Enter your Password"/>
								</div>
							</div>
							<div id="msgPwd"></div>
						</div>

						<div class="form-group">
							<label for="confirm" class="cols-sm-2 control-label">Confirm Password</label>
							<div class="cols-sm-10">
								<div class="input-group">
									<span class="input-group-addon"><i class="fa fa-lock fa-lg" aria-hidden="true"></i></span>
									<input type="password" class="form-control" name="mem_pwd_confirm" id="mem_pwd_confirm"  placeholder="Confirm your Password"/>
								</div>
							</div>
							<div id="msgPwdConfirm"></div>
						</div>

						<div class="form-group ">
							<button type="button" id="regiBtn" class="btn btn-primary btn-lg btn-block login-button">Register</button>
						</div>
						
						<div class="login-register">
				             <a href="/">Main</a>
				         </div>
					</form>
				</div>
			</div>
		</div>
<script>
$(document).ready(function(){
	 var getMail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
	 var getPwdCheck= RegExp(/^[a-zA-Z0-9]{4,12}$/);
	
	 
	$("#regiBtn").on('click', function(){
		var mem_email = $("#mem_email").val();
		var mem_pwd = $("#mem_pwd").val();
		var mem_pwd_confirm = $("#mem_pwd_confirm").val();
		var email_duplicate = $("#email_duplicate").val();
		
		if(mem_email.length == 0 || mem_pwd.length == 0 || mem_pwd_confirm.length == 0) {
			alert("필수 정보를 입력해주세요.");
			return;
		}
		if(email_duplicate == "checked") {
			if(mem_pwd == mem_pwd_confirm) {
				f.submit();
			}else {
				alert("비밀번호가 일치 하지 않습니다.");
				return;
			}
		}else if(email_duplicate != "chekced"){
			alert("Email 중복체크를 해주세요.");
			return;
		}
		
	});
	 
	$('#mem_email').on('keyup', function(){
  		if(!getMail.test($("#mem_email").val())){
  	        $("#msgEmail").css("color","red");
  	        $("#msgEmail").text("이메일 형식에 맞게 입력해주세요");
  	        $("#mem_email").focus();
  			var n = $("#mem_email").val().length;
  			if(n == 0) {
  				$("#msgEmail").text("");
  			}
  	        return false;
  	      }else {
  	    	  $.ajax({
  	    		  url: "/join/emailCheck.do",
  	    		  data: $("#mem_email").val(),
  	    		  type: "POST",
  	    		  success: function(data) {
  	    			  if(data == "possible") {
  	    				$("#msgEmail").css("color", "purple");
  	    				$("#msgEmail").text("사용가능한 이메일 입니다.");
  	    				$("#email_duplicate").val("checked");
  	    			  }else {
  	    				$("#msgEmail").css("color", "red");
  	    				$("#msgEmail").text("이미 사용중인 이메일 입니다.");
  	    				$("#email_duplicate").val("unChecked");
  	    			  }
  	    		  },
  	    		  error: function(err) {
 	    			 console.log("실패");
  	    		  }
  	    	  });
  	      }
	});
	
	$("#mem_pwd").on('keyup', function(){
		var mem_pwd = $("#mem_pwd").val();
		var mem_pwd_confirm = $("#mem_pwd_confirm").val();
		
		if(mem_pwd.length == 0) {
			$("#msgPwd").text("");
			$("#mem_pwd_confirm").val("");
			$("#msgPwdConfirm").text("");
			return;
		}
		
		if(mem_pwd.length != 0) {
			if(mem_pwd_confirm.length == 0) {
					$("#msgPwd").css("color","purple");
					$("#msgPwd").text("비밀번호 확인을 입력해주세요.");
					return;
			}
			if(mem_pwd_confirm.length != 0) {
				if(mem_pwd == mem_pwd_confirm) {
					$("#msgPwd").css("color", "purple");
					$("#msgPwd").text("비밀번호가 일치합니다.");
					$("#msgPwdConfirm").css("color", "purple");
					$("#msgPwdConfirm").text("비밀번호가 일치합니다.");
				}else if(mem_pwd != mem_pwd_confirm) {
					$("#msgPwd").css("color", "red");
					$("#msgPwd").text("비밀번호가 일치하지 않습니다.");
					$("#msgPwdConfirm").css("color", "red");
					$("#msgPwdConfirm").text("비밀번호가 일치하지 않습니다.");
				}
			}
		}
	});
	
	$("#mem_pwd_confirm").on('keyup', function(){
		var mem_pwd = $("#mem_pwd").val();
		var mem_pwd_confirm = $("#mem_pwd_confirm").val();
		
		if(mem_pwd_confirm.length == 0) {
			$("#msgPwdConfirm").text("");
			$("#msgPwd").text("");
			return;
		}
		
		if(mem_pwd_confirm.length != 0) {
			if(mem_pwd.length != 0) {
				if(mem_pwd == mem_pwd_confirm) {
					$("#msgPwd").css("color", "purple");
					$("#msgPwd").text("비밀번호가 일치합니다.");
					$("#msgPwdConfirm").css("color", "purple");
					$("#msgPwdConfirm").text("비밀번호가 일치합니다.");
				}else if(mem_pwd != mem_pwd_confirm) {
					$("#msgPwd").css("color", "red");
					$("#msgPwd").text("비밀번호가 일치하지 않습니다.");
					$("#msgPwdConfirm").css("color", "red");
					$("#msgPwdConfirm").text("비밀번호가 일치하지 않습니다.");
				}
			}
		}
	});
});


</script>
		
	</body>
</html>