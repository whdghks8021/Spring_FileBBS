<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" 
		prefix="form" %>

<c:set var="rootPath" value="${pageContext.request.contextPath}" />

<style>
	fieldset{
		width:70%;
		margin:20px auto; /* 가로방향 중앙정렬 */
	}
	
	legend {
		font-size:18pt;
		font-weight: bold;
		color : #3d65ff;
		text-align: center;
		padding: 20px;
	}
	
	label {
		margin-bottom: 0rem;
	}
	
	.in-label {
		display: inline-block;
		width:20%;
		font-size: 15pt;
		font-weight: bold;
		float:left;
		text-align: right;
		margin-right: 5px;
		padding:8px;
	}
	.in-box-border {
		padding:8px;
		margin:3px;
		display: inline-block;
		width:70%;
		border-top:1px solid #ccc;
	}
	
	
	.in-box {
		padding:8px;
		margin:3px;
		display: inline-block;
		width:70%;
		border:1px solid #ccc;
	}
	
	.in-box:hover {
		background-color: #ddd;
		border:1px solid blue;
	}
	
	input:invalid {
		background-color: #ffdddd;
		border:2px solid red;
	}
	
	.input-box {
		width: 100%;
		font-size: 12pt;
		padding-left: 3px;
	}
	
	/* span 설정 */
	#userid_error {
		width:70%;
		color:red;
		font-weight: bold;
	}
	
	.userid_label {
		display: none;
	}
	
	.in-box-error {
		font-size:12px;
		color:red;
	}
	
	.in-file-box {
		border : 2px solid blue;
	}
	
	.in-file-box h3 {
		text-align: center;
	}
	.in-file-box:hover {
		cursor: pointer;
		background-color: #ccc;
	}
	#img-container {
		display: flex;	
	}

	#images {
		flex : 0 0 auto;
		margin: 5px auto;
		
		display: flex;
		align-items: center;
		justify-content: center;
		
		border:1px solid blue;
	}
	.img-box {
		flex : 0 0 100px;
		height: 100px;
		margin: 10px;
		border-radius: 6px;
	}
</style>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

<form:form enctype="multipart/form-data" action="${rootPath}/bbs/write_tag" modelAttribute="bbsVO">

	<fieldset>
	<legend>게시판작성</legend>
	<label  class="in-label" for="b_userid">회원ID</label>
	<div class="in-box-border">
		<form:input
			placeholder="회원ID를 입력하세요"
			id="b_userid" 
			path="b_userid"
			class="input-box" /><br/>
		<form:errors path="b_userid" class="in-box-error"/>
	</div>
			
	<label class="in-label" for="b_date">작성일자</label>
	<div class="in-box-border">
	<form:input
			id="b_date" 
			path="b_date"
			class="input-box" /><br/>
			<form:errors path="b_date"  class="in-box-error"/><br/>
	</div>
	
	<label class="in-label" for="b_time">작성시각</label>
	<div class="in-box-border">
	<form:input
			id="b_time" 
			path="b_time"
			class="input-box" /><br/>
			<form:errors path="b_time"  class="in-box-error"/><br/>
	</div>		
	
	<label class="in-label" for="b_subject">제목</label>
	<div class="in-box-border">
	<form:input type="text" 
			id="b_subject" 
			path="b_subject"
			class="input-box" /><br/>
			<form:errors path="b_subject"  class="in-box-error"/>
	</div>
	
	<label class="in-label" for="b_content">내용</label>
	<div class="in-box-border">
	<form:textarea type="text"
			id="b_content" 
			path="b_content" rows="10"
			class="input-box"/><br/>
			<form:errors path="b_content"  class="in-box-error"/>
	</div><br/>
	
	<label class="in-label"></label>
	<input type="file" id="b_file" name="b_file">
	<hr />
	
	<label class="in-label" for="btn-join"></label>
	<button class="btn btn-primary" id="btn-join-1" type="submit">저장</button>
	</fieldset>
</form:form>