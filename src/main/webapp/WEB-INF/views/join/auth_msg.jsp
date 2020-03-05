<%@page contentType="text/html;charset=utf-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script>
    if(${flag} == true) {
    	alert("인증 되었습니다.");
    	location.href="/";
    }else {
    	alert("인증 실패하였습니다.");
    	location.href="/";
    }
</script>
