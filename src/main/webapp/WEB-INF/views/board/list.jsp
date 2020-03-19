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
       		
       		<div align="center">
       		<input type="text" id="search_text" placeholder="Search" style="height:30px;width:500px;margin-bottom:5%;"/>
       		<button type="button" id="search_btn"><i class="fa fa-search fa-lg" aria-hidden="true" id="search_icon"></i></button>
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

				   <li><a><i class="fa fa-comments" b_seq="${board.b_seq}" c_seq="comment_${board.b_seq}" style="cursor:pointer;" onclick="boardReplyRead(this);"></i></a></li>
				   <li><a><em class="mr-5" id="comment_cnt_tot_${board.b_seq}">${board.board_reply_count}</em></a></li>

				   <li><a><i class="fa fa-share-alt"></i></a></li>
				   <li><a><em class="mr-3"></em></a></li>
				   
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
				   <input placeholder="Write a comment" style="outline:none;" type="text" id="reply_text_${board.b_seq}">
				   
				   <%-- 
				   <button type="button" style="outline:none;" b_seq="${board.b_seq}" onclick="boardReplyCreate(this)">
				   <img src="/images/paper_plane.png" style="width:25px;height:20px;">
				   </button>
				   <button type="button">수정</button>
				   --%>
				   
				   <img src="/images/paper_plane.png" b_seq="${board.b_seq}" style="width:25px;height:20px; cursor:pointer;" onclick="boardReplyCreate(this)">

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
 
 current_page = 1;//페이징
 $(window).scroll(function(){//게시판 무한스크롤링
	 
	 let $window = $(this);
	 let scrollTop = $window.scrollTop();
	 let windowHeight = $window.height();
	 let documentHeight = $(document).height();
	 if(scrollTop + windowHeight + 30 > documentHeight) {
		//console.log(++current_page);
		++current_page;
		$.ajax({
			url: "/board/infinityList.do?cp="+current_page,
			contentType: "application/json",
			dataType: "json",
			success: function(data) {
				//console.log(data);

				if(data.boardList.length != 0) {
					var str = '';
					$.each(data.boardList, function(board_idx, board) {
						str += "<div class='col-lg-6 offset-lg-3'><div class='cardbox shadow-lg bg-white'><div class='cardbox-heading'><div class='dropdown float-right'><button class='btn btn-flat btn-flat-icon' type='button' data-toggle='dropdown' aria-expanded='false'><em class='fa fa-ellipsis-h'></em></button> <div class='dropdown-menu dropdown-scale dropdown-menu-right' role='menu' style='position: absolute; transform: translate3d(-136px, 28px, 0px); top: 0px; left: 0px; will-change: transform;'><a class='dropdown-item' href='#'>Hide post</a><a class='dropdown-item' href='#'>Stop following</a><a class='dropdown-item' href='#'>Report</a></div></div>";
						str += "<div class='media m-0'><div class='d-flex mr-3'> <img class='img-fluid rounded-circle' src='/resources/user_profile_images/"+board.mem_profile+"' alt='User'"+board_idx+"> </div> <div class='media-body'> <p class='m-0'>"+board.mem_email+"</p> <small><span><i class='icon ion-md-time'></i>"+board.b_rdate+"</span></small> </div></div></div>";
						str += "<div class='cardbox-item'>";
						if(board.board_file_list != null) {
							str += "<ul class='slider'>";
							$.each(board.board_file_list, function(board_file_idx, board_file) {
								str += "<li><img style='width:550px;' src='/resources/board_file_images/"+board_file.bf_fname+"'></li>";
							});
							str += "</ul>";
						}
						
						str += "<div style='margin-left:5%; font-family: "+'Yeon Sung'+", cursive; font-size:20px;'>"+board.b_content+"</div></div>";
						str += "<div class='cardbox-base'>";
						
						if(board.board_like_list != null) {//좋아요리스트 != null
							var board_like_mem_email_list = [];//includes를 사용하기 위하여 배열 생성
							for(var i=0; i<board.board_like_list.length; i++) {
								board_like_mem_email_list.push(board.board_like_list[i].mem_email);
							}
								if(board_like_mem_email_list.includes('${loginUser.mem_email}')) {//유저가  좋아요를 눌렀을 경우
									str += "<a style='margin:0%; margin-top:1.5%;float:right;width:50px; height:50px;background-position:99.9992% 0px' b_seq='"+board.b_seq+"' class='heart' onclick='heartPlus(this);'></a>";
								}else {//유저가  좋아요를 눌르지 않았을 경우
									str += "<a style='margin:0%; margin-top:1.5%;float:right;width:50px; height:50px;background-position:0px' b_seq='"+board.b_seq+"' class='heart' onclick='heartPlus(this);'></a>";
								}
						}else {//좋아요리스트 == null
							str += "<a style='margin:0%; margin-top:1.5%;float:right;width:50px; height:50px;background-position:0px' b_seq='"+board.b_seq+"' class='heart' onclick='heartPlus(this);'></a>";
						}
							str += "<ul class='float-right'>";
							str += "<li><a><i class='fa fa-comments' b_seq='"+board.b_seq+"' c_seq='comment_"+board.b_seq+"' style='cursor:pointer;' onclick='boardReplyRead(this);'></i></a></li>";
							str += "<li><a><em class='mr-5' id='comment_cnt_tot_"+board.b_seq+"'>"+board.board_reply_count+"</em></a></li>";
							str += "<li><a><i class='fa fa-share-alt'></i></a></li><li><a><em class='mr-3'></em></a></li> </ul>";
							
							str += "<ul id='ul"+board.b_seq+"'>";
							
							if(board.board_like_list != null) {
								if(board.board_like_list.length >= 3) {
									for(var i = 0; i<board.board_like_list.length; i++) {
										str += "<li id='like_"+board.b_seq+"_"+board.board_like_list[i].mem_email+"'><a href='#'><img src='/resources/user_profile_images/"+board.board_like_list[i].mem_profile+"' class='img-fluid rounded-circle' alt='User'></a></li>";
										if(i == 3) {
											break;
										}
									}
								}else {
									for(var m of board.board_like_list) {
										str += "<li id='like_"+board.b_seq+"_"+m.mem_email+"'><a href='#'><img src='/resources/user_profile_images/"+m.mem_profile+"' class='img-fluid rounded-circle' alt='User'></a></li>";
										}
									}
							}
					
							if(board.board_like_list != null) {
								str += "<li><a><span id='like_cnt"+board.b_seq+"'>"+board.board_like_list.length+" Likes</span></a></li>";
							}else {
								str += "<li><a><span id='like_cnt"+board.b_seq+"'>0 Likes</span></a></li>";
							}
								str += "</ul></div>";
							
								str += "<div id='comment_"+board.b_seq+"' style='display:none; margin-left:8px;margin-right:8px;'> </div>";
								str += "<div class='cardbox-comments'> <span class='comment-avatar float-left'>";
								str += "<a><img class='rounded-circle' src='/resources/user_profile_images/${loginUser.mem_profile}' alt='...'></a> </span>";
								str += "<div class='search'> <input placeholder='Write a comment' style='outline:none;' type='text' id='reply_text_"+board.b_seq+"'>";
								str += "<button type='button' style='outline:none;' b_seq='"+board.b_seq+"' onclick='boardReplyCreate(this)'><img src='/images/paper_plane.png' style='width:25px;height:20px;'></button>";
								str += "</div> </div> </div> </div>";
								
						
						});
								$('.row').append(str);
						        $('.slider').bxSlider({
						        	  controls: false
						        });
					}
				
			}, error: function(err) {
				console.log(err);
			}
			
		});

	 }
	 
 });

 $("#search_btn").on('click', function(){//검색
	 if($("#search_text").val() == '') {
		 alert("아이디를 입력 후 검색해주세요.");
		 $("#search_text").focus();
		 return;
	 }else {
		 location.href="/board/searchList.do?keyword="+$("#search_text").val();
	 }
 });
 
 function boardReplyRead(obj) {//댓글 보여주기
	 var c_seq = $(obj).attr('c_seq');
	 var b_seq = $(obj).attr('b_seq');
	 var display = $("#comment_"+b_seq).css('display');

	 if(display == 'none') {
		 
		 $.ajax({
			 url:"/board_rest/list/"+b_seq+"?cp=1",
			 dataType: "json",
			 success: function(data) {
				 
				 if(data.boardReplyList.length != 0) {
					 $.each(data.boardReplyList, function(index, item) {
						 var str = '';
						 str += "<span style='float:right; font-size:13px; margin-top:8px;'>"+item.brp_rdate+"</span>";
						 str += "<a><img class='rounded-circle' src='/resources/user_profile_images/"+item.mem_profile+"' alt='...' style='width:30px;height:30px;'></a>";
						 str += "<span style='font-size:12px;'>"+item.mem_email+":</span>"
						 str += "<span style='margin-left:8px; font-size:14px;' id='brp_content_"+item.brp_seq+"'>"+item.brp_content+"</span>";
						 if(item.mem_email == '${loginUser.mem_email}') {
							 str += "&nbsp;<span id='brp_"+item.brp_seq+"'><a href='javascript:void(0)' cp='"+data.currentPage+"' b_seq='"+item.b_seq+"' brp_seq='"+item.brp_seq+"' id='brp_update_request_"+item.brp_seq+"' onclick='boardReplyUpdateRequest(this);' style='text-decoration:none; font-size:10px;'>수정</a>";
							 str += "&nbsp;<a href='javascript:void(0)' b_seq='"+item.b_seq+"' brp_seq='"+item.brp_seq+"' onclick='boardReplyDelete(this);' id='brp_delete_request_"+item.brp_seq+"' style='text-decoration:none; font-size:10px;'>삭제</a></span>";
						 }
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
					 
					 $('#comment_cnt_tot_'+b_seq).text(data.totalCount);
				 }
				
				 
			 },error: function(err) {
				 console.log(err);
			 }
		 });

	 }else {//댓글 가리기
		 $('#'+c_seq).css('display', 'none'); //console.log(flag);
		 $('#'+c_seq).empty();
	 }
	 	 
 }
 
 
 function boardReplyUpdateRequest(obj) {
	 
	 let brp_seq =  $(obj).attr("brp_seq");
	 let b_seq = $(obj).attr("b_seq");
	 let brp_content = $("#brp_content_"+brp_seq).text();
	 let cp = $(obj).attr("cp");
	 
	 console.log("#brp_content: " + brp_content);
	 
	 $("#reply_text_"+b_seq).val("");
	 $("#reply_text_"+b_seq).val(brp_content);
	 
	 let str = "<span id='brp_update_write_"+brp_seq+"'><a href='javascript:void(0)' cp='"+cp+"' brp_seq='"+brp_seq+"' b_seq='"+b_seq+"' style='text-decoration:none; font-size:10px;' onclick='boardReplyUpdate(this);'>수정하기</a></span>";

	 $("#brp_"+brp_seq).append(str);
	 $("#brp_update_request_"+brp_seq).css('display', 'none');
	 $("#brp_delete_request_"+brp_seq).css('display', 'none');
	 
	 
 }
 function boardReplyUpdate(obj) {
	 
	 let brp_seq = $(obj).attr("brp_seq");
	 let b_seq = $(obj).attr("b_seq");
	 let brp_content = $("#reply_text_"+b_seq).val();
	 let cpStr = $(obj).attr("cp");
	 
	 $.ajax({
		 url:"/board_rest/update/"+brp_seq,
		 data: JSON.stringify({"brp_content": brp_content,
			 	"cpStr":cpStr
			 	}),
		 type: "PATCH",
		 contentType:"application/json",
		 dataType: "json",
		 success: function(data) {
			 console.log(data);
		 }, error: function(err) {
			 console.log(err);
		 }
	 });
	
	 
	 console.log($("#reply_text_"+b_seq).val());
	 
	 //alert("글 수정이 완료되었습니다.");
	 $("#reply_text_"+b_seq).val("");
	 
	 $("#brp_update_write_"+brp_seq).remove();
	 $("#brp_update_request_"+brp_seq).css('display', 'inline');
	 $("#brp_delete_request_"+brp_seq).css('display', 'inline');
	 
	 
	 
	 
 }
 
 
 function boardReplyCreate(obj) {//댓글쓰는부분
	 var b_seq = $(obj).attr('b_seq');
	 var replyText = $("#reply_text_"+b_seq);
	 
	 if(replyText.val().length != 0 || replyText.val() != "") {
		 var brp_content = replyText.val();
		 replyText.val("");
		 $.ajax({
			 url: "/board_rest/create/"+b_seq,
			 data: brp_content,
			 type: "POST",
			 contentType:"application/json",
			 dataType:"json", 
			 success: function(data) {
				 //console.log(data);
				 var display = $("#comment_"+b_seq).css('display');
				 var c_seq = "comment_"+b_seq;
				 
				 if(display == 'block') {//댓글이 나와있는 경우
					 
					 if(data.boardReplyList.length != 0) {
						 $('#'+c_seq).empty();
						 $.each(data.boardReplyList, function(index, item){
							 var str = '';
							 str += "<span style='float:right; font-size:13px; margin-top:8px;'>"+item.brp_rdate+"</span>";
							 str += "<a><img class='rounded-circle' src='/resources/user_profile_images/"+item.mem_profile+"' alt='...' style='width:30px;height:30px;'></a>";
							 str += "<span style='font-size:12px;'>"+item.mem_email+":</span>"
							 str += "<span style='margin-left:8px; font-size:14px;' id='brp_content_"+item.brp_seq+"'>"+item.brp_content+"</span>";
							 if(item.mem_email == '${loginUser.mem_email}') {
								 str += "&nbsp;<span id='brp_"+item.brp_seq+"'><a href='javascript:void(0)' cp='"+data.currentPage+"' b_seq='"+item.b_seq+"' brp_seq='"+item.brp_seq+"' id='brp_update_request_"+item.brp_seq+"' onclick='boardReplyUpdateRequest(this);' style='text-decoration:none; font-size:10px;'>수정</a>";
								 str += "&nbsp;<a href='javascript:void(0)' b_seq='"+item.b_seq+"' brp_seq='"+item.brp_seq+"' onclick='boardReplyDelete(this);' id='brp_delete_request_"+item.brp_seq+"' style='text-decoration:none; font-size:10px;'>삭제</a></span>";
							 }
							 str += "<br/>";
							 $('#'+c_seq).append(str); 
						 }); 
					 
						 if(data.totalPageCount != 0) {
							 if(data.totalPageCount != 1) {
								 var pagingHtml = Paging(data.currentPage, data.pageSize, data.totalCount, data.totalPageCount, b_seq, c_seq);
								 $('#'+c_seq).append(pagingHtml);
							 }
						 }
						 
						 $('#comment_cnt_tot_'+b_seq).text(data.totalCount); //tot 갱신
					 }
				 }else if(display == 'none') {//댓글이 안나와 있는경우
					
					 if(data.boardReplyList.length != 0) {
						 $.each(data.boardReplyList, function(index, item) {
							 var str = '';
							 str += "<span style='float:right; font-size:13px; margin-top:8px;'>"+item.brp_rdate+"</span>";
							 str += "<a><img class='rounded-circle' src='/resources/user_profile_images/"+item.mem_profile+"' alt='...' style='width:30px;height:30px;'></a>";
							 str += "<span style='font-size:12px;'>"+item.mem_email+":</span>"
							 str += "<span style='margin-left:8px; font-size:14px;' id='brp_content_"+item.brp_seq+"'>"+item.brp_content+"</span>";
							 if(item.mem_email == '${loginUser.mem_email}') {
								 str += "&nbsp;<span id='brp_"+item.brp_seq+"'><a href='javascript:void(0)' cp='"+data.currentPage+"' b_seq='"+item.b_seq+"' brp_seq='"+item.brp_seq+"' id='brp_update_request_"+item.brp_seq+"' onclick='boardReplyUpdateRequest(this);' style='text-decoration:none; font-size:10px;'>수정</a>";
								 str += "&nbsp;<a href='javascript:void(0)' b_seq='"+item.b_seq+"' brp_seq='"+item.brp_seq+"' onclick='boardReplyDelete(this);' id='brp_delete_request_"+item.brp_seq+"' style='text-decoration:none; font-size:10px;'>삭제</a></span>";
							 }
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
						 $('#comment_cnt_tot_'+b_seq).text(data.totalCount);
					 }
				 }
			 },error: function(err) {
				 console.log(err);
			 }
			 
		 });
		 return;
	 }else {
		alert("글을 입력해주세요.");
		replyText.focus();
		return;
	 }
 }
 
 function pagingAjax(obj) {//댓글에 페이징이 존재 할 경우
	 var uri = $(obj).attr('uri');
	 var c_seq = $(obj).attr('c_seq');
	 var b_seq = $(obj).attr('b_seq');
		 
	 $.ajax({
		 url: uri,
		 dataType:"json",
		 success: function(data) {
			 
			 if(data.boardReplyList.length != 0) {
				 $('#'+c_seq).empty();
				 $.each(data.boardReplyList, function(index, item){
					 var str = '';
					 str += "<span style='float:right; font-size:13px; margin-top:8px;'>"+item.brp_rdate+"</span>";
					 str += "<a><img class='rounded-circle' src='/resources/user_profile_images/"+item.mem_profile+"' alt='...' style='width:30px;height:30px;'></a>";
					 str += "<span style='font-size:12px;'>"+item.mem_email+":</span>"
					 str += "<span style='margin-left:8px; font-size:14px;' id='brp_content_"+item.brp_seq+"'>"+item.brp_content+"</span>";
					 if(item.mem_email == '${loginUser.mem_email}') {
						 str += "&nbsp;<span id='brp_"+item.brp_seq+"'><a href='javascript:void(0)' cp='"+data.currentPage+"' b_seq='"+item.b_seq+"' brp_seq='"+item.brp_seq+"' id='brp_update_request_"+item.brp_seq+"' onclick='boardReplyUpdateRequest(this);' style='text-decoration:none; font-size:10px;'>수정</a>";
						 str += "&nbsp;<a href='javascript:void(0)' b_seq='"+item.b_seq+"' brp_seq='"+item.brp_seq+"' onclick='boardReplyDelete(this);' id='brp_delete_request_"+item.brp_seq+"' style='text-decoration:none; font-size:10px;'>삭제</a></span>";
					 }
					 str += "<br/>";
					 $('#'+c_seq).append(str); 
				 });
			 }
				 if(data.totalPageCount != 0) {
					 if(data.totalPageCount != 1) {
						 var pagingHtml = Paging(data.currentPage, data.pageSize, data.totalCount, data.totalPageCount, b_seq, c_seq);
						 $('#'+c_seq).append(pagingHtml);
					 }
				 }
				 
		 },error: function(err) {
			 //console.clear();
			 console.log(err);
		 }
	 });
 }
 
 
 Paging = function(cp, ps, totalCount, totalPageCount, b_seq, c_seq) {//댓글 페이징관련
	 cp = parseInt(cp);
	 ps = parseInt(ps);
	 totalCount = parseInt(totalCount);
	 totalPageCount = parseInt(totalPageCount);
	 
	 var pageBlock = 3;
	 	 
	 var pRCnt = parseInt(cp / pageBlock);
	 if(cp % pageBlock == 0) {
		 pRCnt = parseInt(cp / pageBlock) - 1;
	 }
 
	 var pagingHtml = '';
	 pagingHtml += "<div class='page_wrap'>";
	 pagingHtml += "<div class='page_nation'>";
	
	 //console.log("cp: " + cp+", ps: "+ps);
	 
	 if(cp > pageBlock) {
		 
		 var s2;
		 if(cp % pageBlock == 0) {
			 s2 = cp - pageBlock;
		 }else {
			 s2 = cp - cp % pageBlock;
		 }
		// console.log("이전페이지s2: " + s2);
		 pagingHtml += "<a href='javascript:void(0)' class='arrow prev' b_seq='"+b_seq+"' c_seq='"+c_seq+"' uri='/board_rest/list/"+b_seq+"?cp="+s2+"' onclick=pagingAjax(this)></a>";
	 }else {
		// console.log('처음페이지');
		 pagingHtml += "<a href='javascript:void(0)' class='arrow pprev' b_seq='"+b_seq+"' c_seq='"+c_seq+"' uri='/board_rest/list/"+b_seq+"?cp=1' onclick=pagingAjax(this)></a>"; 
	 }

	 	 for(var i=pRCnt * pageBlock + 1; i<(pRCnt+1)*pageBlock + 1; i++) {
			 if(i == cp) {
				 pagingHtml += "<a href='javascript:void(0)' class='active' b_seq='"+b_seq+"' c_seq='"+c_seq+"' uri='/board_rest/list/"+b_seq+"?cp="+i+"' onclick=pagingAjax(this)>"+i+"</a>";
			 }else {
				 pagingHtml += "<a href='javascript:void(0)' b_seq='"+b_seq+"' c_seq='"+c_seq+"' uri='/board_rest/list/"+b_seq+"?cp="+i+"' onclick=pagingAjax(this)>"+i+"</a>";
			 }
			 
			 if(i == totalPageCount) {
				 break;
			 }
		 }
	 	 
	 if(totalPageCount > (pRCnt + 1)* pageBlock) {
		 pagingHtml += "<a href='javascript:void(0)' class='arrow next' b_seq='"+b_seq+"' c_seq='"+c_seq+"' uri='/board_rest/list/"+b_seq+"?cp="+(cp+1)+"' onclick=pagingAjax(this)></a>";
		 pagingHtml += "<a href='javascript:void(0)' class='arrow nnext' b_seq='"+b_seq+"' c_seq='"+c_seq+"' uri='/board_rest/list/"+b_seq+"?cp="+totalPageCount+"' onclick=pagingAjax(this)></a>";
	 }
	 	 pagingHtml += "</div></div>";
	 
	 return pagingHtml;
	 
 }
 

 
 
 function likeAjax(cmd, obj) {//좋아요
	 var b_seq = $(obj).attr('b_seq');
	 var str = { 'str' : cmd+","+b_seq+",${loginUser.mem_email}" };
	 $.ajax({
			url: "/board/likeAjax.do",
			data: str,
			type: "POST",
			dataType: "json",
			success: function(data) {
				//console.log(data); //console.log("cnt: " + data.board_like_count);
				$("#like_cnt"+b_seq).text(data.board_like_count+" Likes");
				var ul = document.getElementById('ul'+b_seq); //console.log(ul);
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
 

 function heartPlus(obj) {//좋아요
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