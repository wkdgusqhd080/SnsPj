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
       		
       		<div align='center' style="margin-bottom:30px;">
       			<input type="button" id=main_feed_btn value="메인피드"/>
       			<button type="button" id="board_create_btn">글쓰기</button>
       			<button type="button" id="my_board_btn">나의게시글</button>
       			<button type="button" id="my_info_btn">나의정보</button>
       		</div>
       		
       		
       		<div align="center">
       		<input type="text" id="search_text" placeholder="Search" style="height:30px;width:500px;margin-bottom:5%;"/>
       		<button type="button" id="search_btn"><i class="fa fa-search fa-lg" aria-hidden="true" id="search_icon"></i></button>
       		</div>