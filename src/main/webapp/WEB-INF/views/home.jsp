<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<!DOCTYPE html>
<html>
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>우리들의 이야기</title>

  <!-- Bootstrap core CSS -->
  <link href="<c:url value='/css/bootstrap.min.css' />" rel="stylesheet">

  <!-- Custom styles for this template -->
  <link href="<c:url value='/css/simple-sidebar.css' />"  rel="stylesheet">
  
  <!-- Font -->
  <link href="https://fonts.googleapis.com/css?family=Poor+Story&amp;subset=korean" rel="stylesheet">
  
  <script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
	
</head>

<body>
<div class="d-flex" id="wrapper">
    <!-- Sidebar -->
    <div class="bg-light border-right" id="sidebar-wrapper">
      <div class="sidebar-heading">우리들의 이야기</div>
      <div class="list-group list-group-flush">
        <a href="javascript:void(0)" class="list-group-item list-group-item-action bg-light a-menu" data-menu="get_page/">게시판</a>
        <a href="javascript:void(0)" class="list-group-item list-group-item-action bg-light a-menu" data-menu="file/file_up">파일올리기</a>
        <a href="javascript:void(0)" class="list-group-item list-group-item-action bg-light a-menu" data-menu="file/files_up">다중파일올리기</a>
        <c:if test="${empty login_info}">
        	<a href="javascript:void(0)" class="list-group-item list-group-item-action bg-light a-menu" data-menu="login/login">로그인</a>
        	<a href="javascript:void(0)" class="list-group-item list-group-item-action bg-light a-menu" data-menu="member/join">회원가입</a>
        </c:if>
        <c:if test="${not empty login_info}">
      		<a href="javascript:void(0)" class="list-group-item list-group-item-action bg-light a-menu" data-menu="login/logout">로그아웃</a>
      		<a href="javascript:void(0)" class="list-group-item list-group-item-action bg-light a-menu" data-menu="member/update">${login_info.m_userid}님</a>
        </c:if>
        
      </div>
    </div>
    <!-- /#sidebar-wrapper -->

    <!-- Page Content -->
    <div id="page-content-wrapper">

      <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
        <button class="btn btn-primary" id="menu-toggle">메뉴 접기</button>

        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
          <ul class="navbar-nav ml-auto mt-2 mt-lg-0">
            <li class="nav-item active">
              <a class="nav-link" href="<c:url value='/' />">Home <span class="sr-only">(current)</span></a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Link</a>
            </li>
            <li class="nav-item dropdown">
              <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                Dropdown
              </a>
              <div class="dropdown-menu dropdown-menu-right" aria-labelledby="navbarDropdown">
                <a class="dropdown-item" href="#">Action</a>
                <a class="dropdown-item" href="#">Another action</a>
                <div class="dropdown-divider"></div>
                <a class="dropdown-item" href="#">Something else here</a>
              </div>
            </li>
          </ul>
        </div>
      </nav>

      <div class="container-fluid">
        <section class="main">
			<article id="body">
				<c:if test="${BODY == 'HOME'}">
					<%@ include file="/WEB-INF/views/body/main_home.jsp" %>
				</c:if>
				<c:if test="${BODY == 'JOIN_FORM'}">
					<%@ include file="/WEB-INF/views/body/join_form.jsp" %>
				</c:if>
				<c:if test="${BODY == 'JOIN_SUCCESS'}">
					<%@ include file="/WEB-INF/views/body/join_ok.jsp" %>
				</c:if>
				<c:if test="${BODY == 'UPDATE_FORM'}">
					<%@ include file="/WEB-INF/views/body/update_form.jsp" %>
				</c:if>
				<c:if test="${BODY == 'FILE_UP'}">
					<%@ include file="/WEB-INF/views/body/FileUpForm.jsp" %>
				</c:if>
				<c:if test="${BODY == 'FILES_UP'}">
					<%@ include file="/WEB-INF/views/body/FilesUpForm.jsp" %>
				</c:if>
				<c:if test="${BODY == 'LOGIN_FORM'}">
					<%@ include file="/WEB-INF/views/body/login_form.jsp" %>
				</c:if>
				<c:if test="${BODY == 'BBS_WRITE'}">
					<%@ include file="/WEB-INF/views/body/bbs_form.jsp" %>
				</c:if>
				<c:if test="${BODY == 'BBS_TAG_WRITE'}">
					<%@ include file="/WEB-INF/views/body/bbs_tag_form.jsp" %>
				</c:if>
				<c:if test="${BODY == 'BBS_LIST'}">
					<%@ include file="/WEB-INF/views/body/bbs_list.jsp" %>
				</c:if>
				<c:if test="${BODY == 'BBS_VIEW'}">
					<%@ include file="/WEB-INF/views/body/bbs_view.jsp" %>
				</c:if>
			</article>
		</section>
      </div>
    </div>
    <!-- /#page-content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Bootstrap core JavaScript -->
  <script src="<c:url value='/js/jquery.min.js' />" ></script>
  <script src="<c:url value='/js/bootstrap.bundle.min.js' />" ></script>

  <!-- Menu Toggle Script -->
  <script>
  $(function(){
		// 메모장 메뉴 클릭 이벤트
		$(".a-menu").click(function(){
			// let id = $(this).attr("id")
			let menu_id = $(this).attr("data-menu")
			location.href="<c:url value='/' />" + menu_id
		})
		
		$("#menu-toggle").click(function(e) {
		      e.preventDefault();
		      $("#wrapper").toggleClass("toggled");
		      
		      if($(this).html() == '메뉴 접기') {
			  	$(this).html('메뉴 펼치기');
			  }
		      else {
			  	$(this).html('메뉴 접기');
			  }
		});
	
		
	})

  </script>


</body>
</html>