<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>
<jsp:include page="board_header.jsp"></jsp:include>
       		
       		
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
					   		<c:choose>
					   		<c:when test="${loginUser.mem_email eq member.mem_email}">
					   		<button type="button" disabled class="myButton" cnt="${status.count}" flr_email="${member.mem_email}" onclick="following(this)"><span id="follow_${status.count}">Unfollow</span></button>
					   		</c:when>
					   		<c:otherwise>
					   		<button type="button" class="myButton" cnt="${status.count}" flr_email="${member.mem_email}" onclick="following(this)"><span id="follow_${status.count}">Unfollow</span></button>
					   		</c:otherwise>
					   		 </c:choose>
					   		</div>
				   		</c:when>
				   		<c:otherwise>
					   		&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;
					   		<div style="margin-top:35px;">
					   		<c:choose>
					   		<c:when test="${loginUser.mem_email eq member.mem_email}">
					   		<button type="button" disabled class="myButton" cnt="${status.count}" flr_email="${member.mem_email}" onclick="following(this)"><span id="follow_${status.count}">Follow</span></button>
					   		</c:when>
					   		<c:otherwise>
					   		<button type="button" class="myButton" cnt="${status.count}" flr_email="${member.mem_email}" onclick="following(this)"><span id="follow_${status.count}">Follow</span></button>
					   		</c:otherwise>
					   		</c:choose>
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
       