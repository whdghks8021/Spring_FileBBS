<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<style>

#success {
	color: #3d65ff;
	font-weight: bold;
	text-align:center;
	margin-top: 30px;
}

#login_go {
	text-align:center;
	margin-top: 20px;
}
</style>

<h2 id="success">${MSG}</h2>
<button id="login_go" class="btn btn-primary">${BUTTON}</button>

<script>
$(function(){
	
	$('#login_go').click(function(){
		
		location.href = "<c:url value = '/login/login' />"
	})
	
})

</script>