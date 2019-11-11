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
		font-size:25pt;
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
		width: 70%;
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
<script>
$(function() {

	$("#drop-box").on("dragover", function(e) {
		$('h3').text('파일을 내려 놓으세요')
		return false
	})

	// drop event가 발생을 하면
	// 즉, 파일을 끌어서 drag_area box에 놓으면
	// drop event가 발생을 하고
	// 끌어 놓은 파일에 대한 정보가 dFile 매개 변수에 담기게 된다.
	$('#drop-box').on('drop', function(e) {
		$('h3').text('파일을 등록하는중')

		let files = e.originalEvent.dataTransfer.files
		// alert(fileInto[0])

		// ajax로 전송하기 위해 formData 객체를 생성
		let fData = new FormData();

		// fData에 파일 정보를 추가
		// fData.append('file', files[0]) // 1개의 파일만 추출
		for(let i = 0 ; i < files.length; i ++) {
			fData.append("files",files[i])
		}

		$.ajax({
			url : "<c:url value='/file/files' />",
			method:"POST",
			data:fData,
			dataType:"JSON",
			processData:false,
			contentType:false,
			success:function(result) {
				// JSON 형태로 수신한 문자열을 이용해서
				// HTML 코드를 생성한 후 본문에 그려보자
				if(result == null) {
					$("h3").text("파일 업로드 오류")
				} else {
					for(let i = 0 ; i < result.length ; i ++) {
						// 특정한 영역에 문자열이나 html코드를 추가하는
						$('#images').html(
								$('<img/>',{
									src : "<c:url value='/files/' />" + result[i],
									class : 'img-box'
								})		
						)
						$('#b_image').val(result[i])
					} // for end
					$('h3').text('파일 업로드 성공')
				}
			}
			,error:function() {
				alert('서버와 통신 오류')
				$('h3').text('파일 업로드 오류')
			}
		})
		return false;
	})

})
</script>
<%
/*
 form:form의 modelAttribute 속성
 Controller와 view(*.jsp)파일간에 VO 객체에 담긴
 데이터를 쉽게 교환하기 위한 통로로 설정하는 항목
 command라는 속성으로 사용되고
 form tag 에서는 필수 항목
 
 method 는 HTML tag에서는 기본값이 GET이나
 form:form에서는 기본값이 POST

*/
%>
<form:form action="${rootPath}/bbs/write" modelAttribute="bbsVO">

	<fieldset>
	<legend>게시판작성</legend>
	<%
	/*
		form:input taglib의 input box는 HTML과 사용법이 다소 다르다
		HTML			taglib		주의
		name			path		반드시 modelAttribute의 맴버변수설정
		기타속성		거의 비슷
		required		required="required"
	
	*/
	%>
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
			<form:errors path="b_date"  class="in-box-error"/>
	</div>
	
	<label class="in-label" for="b_time">작성시각</label>
	<div class="in-box-border">
	<form:input
			id="b_time" 
			path="b_time"
			class="input-box" /><br/>
			<form:errors path="b_time"  class="in-box-error"/>
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
	<form:hidden path="b_image" id="b_image" />
	<div class="in-box-border in-file-box" id="drop-box">
		<h3>파일을 끌어 놓으세요</h3>
	</div>
	<label class="in-label"></label>
	<article id="img-container">
		<div id="images">
			<c:if test="${not empty bbsVO.b_image}">
				<img class="img-box" src="${pageContext.request.contextPath}/files/${bbsVO.b_image}">
			</c:if>
		</div>
	</article>
	<hr />
	
	<label class="in-label" for="btn-join"></label>
	<button class="btn btn-primary" id="btn-join-1" type="submit">저장</button>
	</fieldset>
</form:form>