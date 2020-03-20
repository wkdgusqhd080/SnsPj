<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>


<!DOCTYPE html>
<head>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<%-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>--%>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<link href="https://fonts.googleapis.com/css?family=Rokkitt" rel="stylesheet"> 
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="/css/board.css" rel="stylesheet">

<%--font Awesome 참조 --%>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<%--bxSlider--%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<%--폰트 --%>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css?family=Yeon+Sung&display=swap');
span {
		font-family: 'Yeon Sung', cursive;
		font-size: 17px;
	}
.myButton {
	box-shadow:inset 0px 1px 0px 0px #bbdaf7;
	background:linear-gradient(to bottom, #79bbff 5%, #378de5 100%);
	background-color:#79bbff;
	border-radius:6px;
	border:1px solid #84bbf3;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #528ecc;
}
.myButton:hover {
	background:linear-gradient(to bottom, #378de5 5%, #79bbff 100%);
	background-color:#378de5;
}


</style>

 <%--좋아요버튼css--%>
<link href="/css/btn_like.css" rel="stylesheet">
<%--페이징css --%>
<link href="/css/paging.css" rel="stylesheet">



        <c:if test="${!empty loginUser}">
        	<div style="float:right;">
        	안녕하세요. ${loginUser.mem_email}님
        	<input type="button" id="btn_logout" value="logout"/>
        	</div>
        </c:if>
        
        <c:if test="${empty loginUser}">
        	<script>
        		location.href="/login/logout.do";
        	</script>
        </c:if>
</head>

		<!--[if IE 7]>
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome-ie7.min.css">
		<![endif]-->
	    <!-- ==============================================
	    Hero
	    =============================================== -->
        <section class="hero">

         <div class="container">
       		<div align='center' style='margin-bottom:20px;'>
       		<input type="button" id="btn_main" value="main_page"/>
       		</div>
       		
       		<div align="center">
       		<input type="text" id="search_text" placeholder="Search" style="height:30px;width:500px;margin-bottom:5%;"/>
       		<button type="button" id="search_btn"><i class="fa fa-search fa-lg" aria-hidden="true" id="search_icon"></i></button>
       		</div>
       <div class="row">
         
         
         <c:if test="${!empty userSearchListResult}">
			<c:forEach items="${userSearchListResult.member_list}" var="member" varStatus="status">

         <div class="col-lg-6 offset-lg-3">
				<div class="cardbox shadow-lg bg-white">
				 
				 <div class="cardbox-heading">

				   <div class="d-flex mr-3">
				   <a><img class="rounded-circle" style="width:100px; height:100px;" src="/resources/user_profile_images/${member.mem_profile}" alt="..."></a>
				   &emsp;<div style="width:40px;margin-top:40px;"><span>${member.mem_email}</span></div>
				   <c:choose>
				   		<c:when test="${fn:contains(userSearchListResult.follow_list, member.mem_email)}">
					   		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&nbsp;
					   		<div style="margin-top:35px;">
					   		<button type="button" class="myButton" cnt="${status.count}" flr_email="${member.mem_email}" onclick="following(this)"><span id="follow_${status.count}">Unfollow</span></button> 
					   		</div>
				   		</c:when>
				   		<c:otherwise>
					   		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					   		<div style="margin-top:35px;">
					   		<button type="button" class="myButton" cnt="${status.count}" flr_email="${member.mem_email}" onclick="following(this)"><span id="follow_${status.count}">Follow</span></button>
					   		</div>
				   		</c:otherwise>
				   </c:choose>
				   </div>
				   				
				 </div><!--/ cardbox-heading -->
				 </div>
		</div>
		
			</c:forEach>
		</c:if>
         
         
         <c:if test="${empty userSearchListResult.member_list}">
         	         <div class="col-lg-6 offset-lg-3">
				<div class="cardbox shadow-lg bg-white">
				 
				 <div class="cardbox-heading">

				   <div class="d-flex mr-3">
						<span>찾으시는 분이 없습니다.</span>
				   </div>
				   				
				 </div><!--/ cardbox-heading -->
				 </div>
		</div>
         </c:if>
         
	
      	</div>
         </div><!--/ container -->
          </section>
 <script>
 
 function following(obj) {
 	var flr_email = $(obj).attr("flr_email");	
 	var cnt = $(obj).attr("cnt");
 	//console.log(cnt, flr_email);
 	var flag = $("#follow_"+cnt).text();
 	if(flag == "Unfollow") {//"언팔누를경우"
 		$("#follow_"+cnt).text("Follow");
 		
 		$.ajax({
 			url:"/board/unfollow.do",
 			type:"POST",
 			data: flr_email,
 			contentType:"application/json",
 			success: function(data) {
 				//console.log(data);
 			}, error: function(err) {
 				console.log(err);
 			}
 		});
 	
 	}else {//"팔로잉누를경우"
 		$("#follow_"+cnt).text("Unfollow");
 		
 		$.ajax({
 			url: "/board/follow.do",
 			type: "POST",
 			data: flr_email,
 			contentType: "application/json",
 			success: function(data){
 				//console.log(data);
 			}, error: function(err) {
 				console.log(err);
 			}
 		});
 	}
 	
  }
 
 
 $(document).ready(function(){
     
     $("#btn_logout").on('click', function(){
   	 	location.href="/login/logout.do";
     });

     $("#btn_main").on('click', function(){
    	 location.href="/board/list.do";
     });
     
  });
 
 $("#search_btn").on('click', function(){
	 if($("#search_text").val() == '') {
		 alert("아이디를 입력 후 검색해주세요.");
		 $("#search_text").focus();
		 return;
	 }else {
		 location.href="/board/searchList.do?keyword="+$("#search_text").val();
	 }
 }); 
 

    
    

    

    
  </script>
       