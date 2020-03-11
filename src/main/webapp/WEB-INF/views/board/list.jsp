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
 
 <%--좋아요버튼css--%>
 <link href="/css/btn_like.css" rel="stylesheet">

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
<style>
@import url('https://fonts.googleapis.com/css?family=Yeon+Sung&display=swap');
span {
		font-family: 'Yeon Sung', cursive;
		font-size: 17px;
	}

</style>
</head>

		<!--[if IE 7]>
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome-ie7.min.css">
		<![endif]-->
	    <!-- ==============================================
	    Hero
	    =============================================== -->
        <section class="hero">

         <div class="container">
       		
       		<div align="center">
       		<input type="text" id="searchBar" placeholder="Search" style="height:30px;width:500px;margin-bottom:5%;"/>
       		<button><i class="fa fa-search fa-lg" aria-hidden="true" id="searchIcon"></i></button>
       		</div>  
       
          <div class="row">	
		  
		  <c:if test="${!empty boardListResult}">
		  	<c:forEach items="${boardListResult.boardList}" var="board" varStatus="status">
			   <div class="col-lg-6 offset-lg-3">
				
				<div class="cardbox shadow-lg bg-white">
				 
				 <div class="cardbox-heading">
				  <!-- START dropdown-->
				  <div class="dropdown float-right">
				   <button class="btn btn-flat btn-flat-icon" type="button" data-toggle="dropdown" aria-expanded="false">
					<em class="fa fa-ellipsis-h"></em>
				   </button>
				   <div class="dropdown-menu dropdown-scale dropdown-menu-right" role="menu" style="position: absolute; transform: translate3d(-136px, 28px, 0px); top: 0px; left: 0px; will-change: transform;">
					<a class="dropdown-item" href="#">Hide post</a>
					<a class="dropdown-item" href="#">Stop following</a>
					<a class="dropdown-item" href="#">Report</a>
				   </div>
				  </div><!--/ dropdown -->
				  <div class="media m-0">
				   <div class="d-flex mr-3">
					<%-- <a href="">--%>
					<img class="img-fluid rounded-circle" src="/resources/user_profile_images/${board.mem_profile}" alt="User${status.count}">
					<%-- </a>--%>
				   </div>
				   <div class="media-body">
				    <p class="m-0">${board.mem_email}</p>
					<!--  <small><span><i class="icon ion-md-pin"></i> Nairobi, Kenya</span></small>-->
					

					<small><span><i class="icon ion-md-time"></i>${board.b_rdate}</span></small>
					
					
					
				   </div>
				  </div><!--/ media -->
				 </div><!--/ cardbox-heading -->
				  
				 <div class="cardbox-item">
				 
				 <c:if test="${!empty board.board_file_list}">
					<ul class="slider">
					 	<c:forEach items="${board.board_file_list}" var="board_file">
					 		<li>
					 		<img style="width:550px;" src="/resources/board_file_images/${board_file.bf_fname}">
					 		</li>
					 	</c:forEach>
					</ul>
				 </c:if>
				  
				  <div style="margin-left:5%; font-family: 'Yeon Sung', cursive; font-size:20px;">${board.b_content}</div>
				 </div><!--/ cardbox-item --> 
				
				 <div class="cardbox-base">
				 
				 
				 <c:choose>
				 <c:when test="${fn:contains(board.board_like_list, loginUser.mem_email)}">
				  <a style="margin:0%; margin-top:1.5%;float:right;width:50px; height:50px;background-position:99.9992% 0px" b_seq="${board.b_seq}" class="heart" onclick="heartPlus(this);"></a>
				 </c:when>
				 <c:otherwise>
				  <a style="margin:0%; margin-top:1.5%;float:right;width:50px; height:50px;background-position:0px" b_seq="${board.b_seq}" class="heart" onclick="heartPlus(this);"></a>
				 </c:otherwise>
				 </c:choose>
				  <ul class="float-right">

				   <li><a><i class="fa fa-comments" value="false" b_seq="${board.b_seq}" c_seq="comment_${board.b_seq}" style="cursor:pointer;" onclick="showComment(this);"></i></a></li>
				   <li><a><em class="mr-5">12</em></a></li>
				   
				    
				   <li><a><i class="fa fa-share-alt"></i></a></li>
				   <li><a><em class="mr-3">03</em></a></li>
				   
				  </ul>
				  
				  <ul id="ul${board.b_seq}">
				   <%-- <li><a><i class="fa fa-thumbs-up"></i></a></li>--%>
				   
				   <c:forEach items="${board.board_like_list}" begin="0" end="2" var="board_like">
				   <li id="like_${board.b_seq}_${board_like.mem_email}"><a href="#"><img src="/resources/user_profile_images/${board_like.mem_profile}" class="img-fluid rounded-circle" alt="User"></a></li>
				   </c:forEach>
				   
					   <c:if test="${!empty board.board_like_list}">
					   		<li><a><span id="like_cnt${board.b_seq}">${board.board_like_list.size()} Likes</span></a></li>
					   </c:if>
					   
					   <c:if test="${empty board.board_like_list}">
					  		<li><a><span id="like_cnt${board.b_seq}">0 Likes</span></a></li>
					   </c:if>
					   
				  </ul>	

				 </div><!--/ cardbox-base -->
				 
				 <div id="comment_${board.b_seq}" style="display:none; margin-left:8px;margin-right:8px;">
				 
				 </div>
				 
				 
				 <div class="cardbox-comments">
				  <span class="comment-avatar float-left">
				   <a><img class="rounded-circle" src="/resources/user_profile_images/${loginUser.mem_profile}" alt="..."></a>                            
				  </span>
				  <div class="search">
				   <input placeholder="Write a comment" type="text">
				   <button><img src="/images/paper_plane.png" style="width:25px;height:20px;"></button>
				  </div><!--/. Search -->
				 </div><!--/ cardbox-like -->			  
						
				</div><!--/ cardbox -->
	
	           </div><!--/ col-lg-6 -->	

		<%-- 
		   <div class="col-lg-3">
			<div class="shadow-lg p-4 mb-2 bg-white author">
			 <a href="#">Get more from themashabrand.com</a>
			 <p>Bootstrap 4.1.0</p>
			</div>
		   </div><!--/ col-lg-3 -->
		--%>
			</c:forEach>
		</c:if>
			
          </div><!--/ row -->
         </div><!--/ container -->
 <script>
 
 Paging = function(cp, ps, totalCount, totalPageCount, b_seq, c_seq) {
	 cp = parseInt(cp);
	 ps = parseInt(ps);
	 totalCount = parseInt(totalCount);
	 totalPageCount = parseInt(totalPageCount);
	 
	 var pagingHtml = '';
	 
	 pagingHtml += "<div class='board_paging' align='center'>";
	 pagingHtml += "<button onclick='javascript:location.href='/board_rest/list/"+b_seq+"?cp=1'>&#x000AB;</button>";
	 if(cp != 1) pagingHtml += "<button onclick='javascript:location.href='/board_rest/list"+b_seq+"?cp="+(cp-1)+"'>&#x02039;</button>";
	 
	 for(var i=1; i<=totalPageCount; i++) {
		 if(i == cp) {
			 pagingHtml += "<button onclick='javascript:location.href='/board_rest/list/"+b_seq+"?cp="+i+"' class='on'><strong>"+i+"</strong></button>";
		 }else {
			 pagingHtml += "<button onclick='javascript:location.href='/board_rest/list/"+b_seq+"?cp="+i+"'>"+i+"</button>";
		 }
	 }
	 
	 if(cp != totalPageCount) pagingHtml += "<button onclick='javascript:location.href='/board_rest/list/"+b_seq+"?cp="+(cp+1)+"'>&#x0203A;</button>";
	 
	 pagingHtml += "<button onclick='javascript:location.href=/board_rest/list/"+b_seq+"?cp="+totalPageCount+"'>&#x000BB;</button>";

	 pagingHtml += "</div>";
	 
	 return pagingHtml;
	 
 }
 
 function showComment(obj) {
	 var c_seq = $(obj).attr('c_seq');
	 var b_seq = $(obj).attr('b_seq');
	 var flag = $(obj).attr('value');
	 
	 if(flag == 'false') {//댓글 보이기
		 
		 $.ajax({
			 url:"/board_rest/list/"+b_seq+"?cp=1",
			 dataType: "json",
			 success: function(data) {
				 console.log(data);
				 
				 if(data.boardReplyList.length != 0) {
					 $.each(data.boardReplyList, function(index, item) {
						 var str = '';
						 str += "<span style='float:right; font-size:13px; margin-top:8px;'>"+item.brp_rdate+"</span>";
						 str += "<a><img class='rounded-circle' src='/resources/user_profile_images/"+item.mem_profile+"' alt='...' style='width:40px;height:40px;'></a>";
						 str += "<span style='margin-left:8px;'>"+item.brp_content+"</span>";
						 str += "<br/>";
						 $('#'+c_seq).append(str);
					 });
					 
					 if(data.totalPageCount != 0) {
						 if(data.totalPageCount != 1) {
							 var pagingHtml = Paging(data.currentPage, data.pageSize, data.totalCount, data.totalPageCount, b_seq, c_seq);
							 $('#'+c_seq).append(pagingHtml);
						 }
					 }
					 
					 $('#'+c_seq).css('display', 'block'); //console.log(flag);
					 $(obj).attr('value', 'true'); 
				 }
				 //$('#'+c_seq).text(data.totalCount);
				 
			 },error: function(err) {
				 console.log(err);
			 }
		 });

	 }else {//댓글 가리기
		 $('#'+c_seq).css('display', 'none'); //console.log(flag);
		 $('#'+c_seq).empty();
		 $(obj).attr('value', 'false');
	 }
	 	 
 }
 
 
 function likeAjax(cmd, obj) {
	 var b_seq = $(obj).attr('b_seq');
	 var str = { 'str' : cmd+","+b_seq+",${loginUser.mem_email}" };
	 $.ajax({
			url: "/board/likeAjax.do",
			data: str,
			type: "POST",
			dataType: "json",
			success: function(data) {
				console.log(data); //console.log("cnt: " + data.board_like_count);
				$("#like_cnt"+b_seq).text(data.board_like_count+" Likes");
				var ul = document.getElementById('ul'+b_seq);
				//console.log(ul);
				if(cmd == 'minus') {
					var li = document.getElementById('like_'+b_seq+'_${loginUser.mem_email}');
					if (li != null) li.parentNode.removeChild(li);
				}else if(cmd == 'plus') {
					$(ul).each(function(){
						if($('li', this ).length <= 3) {//console.log('되나요');
							var str = "";
							str += "<li id='like_"+b_seq+"_${loginUser.mem_email}'>";
							str += "<a href='#'>";
							str += "<img src='/resources/user_profile_images/${loginUser.mem_profile}' class='img-fluid rounded-circle' alt='User'>";
							str += "</a>"
							str += "</li>";
							$(ul).prepend(str);
						}
					});
				}
			},error: function(err) {
				console.log(err);
			}
		 });
 }
 

 function heartPlus(obj) {
	 var filled = $(obj).css('background-position');
	 var b_seq = $(obj).attr('b_seq');
	 if(filled == '99.9992% 0px') {//minus
		 $(obj).css('background-position', '0px 50%');
	 	 likeAjax('minus', obj);
	 }else {//plus
		 $(obj).css('background-position', '99.9992% 0px');
	 	 likeAjax('plus', obj);
	 }
 }
   
   
   
    $(document).ready(function(){
    	
      $('.slider').bxSlider({
    	  controls: false
      });
      
      $("#btn_logout").on('click', function(){
    	 location.href="/login/logout.do";
      });

   });

  </script>
        </section>