<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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


<%--좋아요버튼css
<link href="/css/btn_like.css" rel="stylesheet">
 --%>
 
 <%--좋아요버튼css2--%>
 <link href="/css/btn_like2.css" rel="stylesheet">

        <c:if test="${!empty loginUser}">
        	안녕하세요. ${loginUser.mem_email}님
        <input type="button" id="btn_logout" value="logout"/>
        </c:if>
        
        <c:if test="${empty loginUser}">
        	<script>
        		location.href="127.0.0.1:8080/index.jsp";
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
					<small><span><i class="icon ion-md-time"></i> 10 hours ago</span></small>
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
				  
				  <div>${board.b_content}</div>
				 </div><!--/ cardbox-item --> 
				
				 <div class="cardbox-base">
				 
				 
				 <c:choose>
				 <c:when test="${fn:contains(board.board_like_list, loginUser.mem_email)}">
				  <a style="margin:0%; margin-top:1%;float:right;width:50px; height:50px;background-position:99.9992% 0px" id="heart${board.b_seq}" class="heart" onclick="heartPlus(this);"></a>
				 </c:when>
				 <c:otherwise>
				  <a style="margin:0%; margin-top:1%;float:right;width:50px; height:50px;background-position:0px" id="heart${board.b_seq}" class="heart" onclick="heartPlus(this);"></a>
				 </c:otherwise>
				 </c:choose>
				  <ul class="float-right">

				   <li><a><i class="fa fa-comments"></i></a></li>
				   <li><a><em class="mr-5">12</em></a></li>
				   <li><a><i class="fa fa-share-alt"></i></a></li>
				   <li><a><em class="mr-3">03</em></a></li>
				  </ul>

				  <ul>
				   <li><a><i class="fa fa-thumbs-up"></i></a></li>
				   <c:forEach items="${board.board_like_list}" begin="0" end="2" var="board_like">
				   <li><a href="#"><img src="/resources/user_profile_images/${board_like.mem_profile}" id="${board_like.mem_email}" class="img-fluid rounded-circle" alt="User"></a></li>
				   </c:forEach>
					   <c:if test="${!empty board.board_like_list}">
					   		<li><a><span>${board.board_like_list.size()} Likes</span></a></li>
					   </c:if>
					   <c:if test="${empty board.board_like_list}">
					   <li><a><span>0 Likes</span></a></li>
					   </c:if>
				  </ul>	
				
				 </div><!--/ cardbox-base -->
				 
				 <div class="cardbox-comments">
				  <span class="comment-avatar float-left">
				   <a href=""><img class="rounded-circle" src="/resources/user_profile_images/${loginUser.mem_profile}" alt="..."></a>                            
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
 
 
 
 
 function heartPlus(obj) {
	 
 }
   
   
   
    $(document).ready(function(){
      $('.slider').bxSlider();
      
      
      $("#btn_logout").on('click', function(){
    	  //$('.heart').css('background-position', '99.9992% 0px');
      });

      <%--
      $('.heart').click(function(){},function(){
        if(heart && !animating){
          $('.heart').css('background-position','0 0');
          heart = false;
        }else if(!animating){
          animating = true;
          animate();
        }
      });

      function animate(){
        cycle = setInterval(increment,30);
      }

      function increment(){
        pos += dpos;
        if(pos > 100){
          clearInterval(cycle);
          heart = true;
          animating = false;
          pos = 0;
        }else{
          $('.heart').css('background-position',pos+'% 0');
        }
      }
      --%>

   });

  </script>
        </section>