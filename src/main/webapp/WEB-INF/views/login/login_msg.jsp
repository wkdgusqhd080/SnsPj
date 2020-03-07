<%@page contentType="text/html;charset=utf-8" import="sns.login.service.LoginSet"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>



<form name="f" action="/board/list.do" method="post">
	<input type="hidden" name="mem_email" value="${loginUser.mem_email}"/>
</form>

<script>
if(${requestScope.result} == <%=LoginSet.NO_ID%>){
	   alert("없는 아이디 입니다 ");
	   location.href="/";
}else if(${requestScope.result} == <%=LoginSet.NO_PWD%>){
	   alert("잘못된 비밀번호 입니다 ");
	   location.href="/";
}else if(${result} == <%=LoginSet.NO_PASS%>) {
	   alert("이메일 인증 후 사용 가능합니다.");
	   location.href="/";
}else{
	   alert("환영합니다 ${sessionScope.loginUser.mem_email} 님");
	   f.submit();
}
	
</script>
