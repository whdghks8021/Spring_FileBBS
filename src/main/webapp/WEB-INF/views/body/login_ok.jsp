<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<p>id : ${login_info.m_userid}
<p>name : ${login_info.m_name}
<p>tel : ${login_info.m_tel}
<br />
<button id="info_fix" class="btn btn-primary">내정보 수정</button>

<script>

$(function(){
	
	$("#info_fix").click(function(){
		
		location.href = "<c:url value='/member/update' />"
	})
})
</script>