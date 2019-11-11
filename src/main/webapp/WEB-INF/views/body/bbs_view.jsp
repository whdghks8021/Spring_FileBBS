<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" 
	content="width=device-width,initial-scale=1">
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<style>
	#bbs_view {
		display: flex;
		flex-direction: column;
	}
	.bbs_box {
		width: 100%;
		margin: 10px auto;
	}
	
	#bbs_body {
		display: flex;
		width: 100%;
		margin: 10px auto;
	}
	.top-title {
		display: flex;
		background-color: #007bff;
		color: #fff;
		justify-content: space-between;
		align-items: baseline;
		border-radius: .25rem
	}
	.body-content {
		border: 1px solid #007bff;
		border-radius: .25rem;
		
	}
	.p-userid, .p-subject, .p-img {
		margin-left: 25px;
		font-size: 12pt;
	}
	
	.p-title {
		font-size: 20pt;
		margin-top: 10px;
		margin-bottom: 0;
	}
	
	.p-hit, .p-subject, .p-img {
		margin-right: 25px;
		font-size: 12pt;
	}
	
	.p-subject {
		font-size: 30pt;
		padding-bottom: 10px;
		border-bottom: 1px dotted #007bff;
	}
	
	.p-content {
		padding-bottom: 25px;
		margin-left: 70px;
		margin-right: 70px;
	}
	
	.p-img {
		padding-top: 10px;
		border-top: 1px dotted #007bff;
	}
	.img-file {
		margin-left: 30px;	
		border: 1px solid #007bff;
		border-radius: 0.25rem;
	}
</style>
<body>
	<article id="bbs_view" class="bbs_box">
		<div class="top-title">
			<p class="p-userid">${bbsVO.b_userid}</p>
			<p class="p-title">${bbsVO.b_date}  ${bbsVO.b_time}</p>
			<p class="p-hit">조회수 : ${bbsVO.b_hit}</p>
		</div>
	</article>
	<article class="bbs_body">	
		<div class="body-content">
			<p class="p-subject">${bbsVO.b_subject}</p>
			<p class="p-content">${bbsVO.b_content}</p>
			<p class="p-img">첨부파일
				<c:if test="${not empty bbsVO.b_image}">
					<img class="img-file" src="${pageContext.request.contextPath}/files/${bbsVO.b_image}" width="70px" height="70px">
				</c:if>
			</p>
		</div>
	</article>
		<div class="bbs_box">
			<c:if test="${bbsVO.b_userid == login_info.m_userid}">
				<button class="btn btn-primary" type="button" id="bbs_update">편집</button>
				<button class="btn btn-primary" type="button" id="bbs_delete">삭제</button>
			</c:if>
			<button class="btn btn-primary" type="button" id="bbs_list">목록으로</button>
		</div>

</body>
</html>
<script>
$(function(){
	$("#bbs_update").click(function(){
		let id = ${bbsVO.id}
		location.href = "<c:url value='/bbs/update'/>" + "?id=" + id
	})
	$("#bbs_delete").click(function(){
		let id = ${bbsVO.id}
		if(confirm("게시물을 삭제할까요?")) {
			location.href = "<c:url value='/bbs/delete'/>" + "?id=" + id
		}
		
	})
	$("#bbs_list").click(function(){
		location.href = document.referrer;
	})
})
</script>