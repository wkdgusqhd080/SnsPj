<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>
<jsp:include page="board_header.jsp"></jsp:include>
       		
       		
       <div class="row">
         
         
         <c:if test="${!empty member}">
	         <div class="col-lg-6 offset-lg-3">
					<div class="cardbox shadow-lg bg-white">
					 
					 <div class="cardbox-heading">
	
					   <div class="d-flex mr-3">
					   
					   <a href="javascript:profileUpload()">
					   <img id="profile_img" class="rounded-circle" style="width:100px; height:100px;" src="/resources/user_profile_images/${member.mem_profile}" alt="...">
					   </a>
					   &emsp;<div style="width:40px;margin-top:40px;"><span>${member.mem_email}</span></div>
					   </div>
					   				
					 </div><!--/ cardbox-heading -->
					 </div>
			</div>
		</c:if>

      	</div>
	      	<div align='center'>
	      	<form name="f" method="POST" action="/board/my_info_change.do" enctype="multipart/form-data">
	      		<input type="hidden" name="before_profile_file" value="${member.mem_profile}"/>
	      		<input type="file" name="profile_file" id="profile_file" accept=".gif, .jpg, .png" style="display:none;">
	      	</form>
	      	</div>
	      	<br/>
	      	<div align='center'>
	      	<button type="button" id="edit_btn">변경하기</button>
	      	</div>
         </div><!--/ container -->
          </section>
 <script>
 
 
 $(document).ready(function(){
     
     $("#btn_logout").on('click', function(){
   	 	location.href="/login/logout.do";
     });

     $("#board_create_btn").on('click', function(){
   	  location.href="/board/board_create_form.do";
     });
     
     $("#my_board_btn").on('click', function() {
   	  location.href="/board/my_board_list.do";
     });
     
     $("#main_feed_btn").on('click',function() {
   	  location.href="/board/list.do";
     });
	
     $("#my_info_btn").on('click', function(){
   	  location.href="/board/my_info.do";
     });
     
     $("#profile_file").on('change', function() {
    	 imageURL(this);
     });
     
     $("#edit_btn").on('click', function(){
    	 f.submit();
     });
     
  });
 function profileUpload() {
	 $("#profile_file").click();
 }
 
 function imageURL(input) {
     if (input.files && input.files[0]) {
         var reader = new FileReader();
         reader.onload = function(e) {
             $('#profile_img').attr('src', e.target.result);
         }
         reader.readAsDataURL(input.files[0]);
     }
 }
 
  </script>
       