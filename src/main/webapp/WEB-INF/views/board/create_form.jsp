<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
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

<%--폰트 --%>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">

<%-- 파일 --%>
<link rel="stylesheet" type="text/css" href="/gu-upload/css/guupload.css"/>
<script type="text/javascript" src="/gu-upload/guuploadManager.js"></script>

<style>

textarea{ 
	width:100%; 
	height:300px;
	resize:none;
	/* 크기고정 */  /*   resize: horizontal; // 가로크기만 조절가능  resize: vertical;  세로크기만 조절가능  */ 
}

</style>

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
       		    <input type="button" id=main_feed_btn value="메인피드"/>
       			<button type="button" id="my_board_btn">나의게시글</button>
       		</div>
    <form id="form1" name="form1" action="/board/boardUpload.do" method="post">
       <div class="row">         
         	 <div class="col-lg-6 offset-lg-3" >
				<div class="cardbox shadow-lg bg-white">
				 <div class="cardbox-heading">
				   <div class="d-flex mr-3">
						<textarea name="b_content" id="b_content"></textarea>
				   </div>
				 </div><!--/ cardbox-heading -->
				 </div>
			 </div>
		</div> <!-- . row -->
			
			<div align="center">
				<div class="cardbox shadow-lg bg-white" style="width:550px;">
					<div class="cardbox-heading">
				<div id="attachFile" style="width:500px;"></div>
				    </div>
				</div>
			</div>
			
			<input type="hidden" id="realname" name="realname"/>
			<input type="hidden" id="filename" name="filename"/>
			<input type="hidden" id="filesize" name="filesize"/>	
		
			<div align='center'>
			<input type="button" value="Submit" onclick='formSubmit()'/>
			</div>
	 </form>
         </div><!--/ container -->
          </section>
 <script>

 $(document).ready(function(){
     $("#btn_logout").on('click', function(){
   	 	location.href="/login/logout.do";
     });
     
     $("#my_board_btn").on('click', function() {
   	  location.href="/board/my_board_list.do";
     });
     
     $("#main_feed_btn").on('click',function() {
   	  location.href="/board/list.do";
     });
  });
 
 var guManager=null;

 window.onload = function() {
 	var option = {
 		listtype: "thumbnail",
 		fileid: "attachFile",
 		uploadURL: "fileUpload.do",
 		afterFileTransfer: afterFileTransfer
 	}
 	guManager = new guUploadManager(option);
 }	
 function afterFileTransfer(realname, filename, filesize){

		var realname9 = document.getElementById( 'realname' );
		var filename9 = document.getElementById( 'filename' );
		var filesize9 = document.getElementById( 'filesize' );
		
		realname9.value = realname;
		filename9.value = filename;
		filesize9.value = filesize;
		
		document.form1.submit();
	}
 
 function formSubmit(){
		var b_content = document.getElementById( 'b_content' );
		if (b_content.value==="") {
			alert("input!");
			return;
		}
		
		guManager.uploadFiles();
		
	}
 
  </script>
  
       