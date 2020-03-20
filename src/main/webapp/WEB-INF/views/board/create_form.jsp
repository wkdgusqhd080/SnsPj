<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="today" value="${now}" pattern="yyyy-MM-dd HH:mm:ss"/>


<!DOCTYPE html>
<head>

<link href="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<%-- <script src="//maxcdn.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js"></script>--%>
<script src="//cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<!------ Include the above in your HEAD tag ---------->
<link href="https://fonts.googleapis.com/css?family=Rokkitt" rel="stylesheet"> 
<link href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css" rel="stylesheet">
<link href="/css/board.css" rel="stylesheet">

<%--font Awesome 참조 --%>
<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome.min.css">
<%--bxSlider--%>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>

<%--폰트 --%>
<link href="https://fonts.googleapis.com/css?family=Do+Hyeon&display=swap" rel="stylesheet">
<style>
@import url('https://fonts.googleapis.com/css?family=Yeon+Sung&display=swap');
span {
		font-family: 'Yeon Sung', cursive;
		font-size: 17px;
	}
.myButton {
	box-shadow:inset 0px 1px 0px 0px #bbdaf7;
	background:linear-gradient(to bottom, #79bbff 5%, #378de5 100%);
	background-color:#79bbff;
	border-radius:6px;
	border:1px solid #84bbf3;
	display:inline-block;
	cursor:pointer;
	color:#ffffff;
	font-family:Arial;
	font-size:15px;
	font-weight:bold;
	padding:6px 24px;
	text-decoration:none;
	text-shadow:0px 1px 0px #528ecc;
}
.myButton:hover {
	background:linear-gradient(to bottom, #378de5 5%, #79bbff 100%);
	background-color:#378de5;
}

textarea{ 
	width:100%; 
	height:300px;
	resize:none;
	/* 크기고정 */  /*   resize: horizontal; // 가로크기만 조절가능  resize: vertical;  세로크기만 조절가능  */ 
}



</style>

 <%--좋아요버튼css--%>
<link href="/css/btn_like.css" rel="stylesheet">
<%--페이징css --%>
<link href="/css/paging.css" rel="stylesheet">



        <c:if test="${!empty loginUser}">
        	<div style="float:right;">
        	안녕하세요. ${loginUser.mem_email}님
        	<input type="button" id="btn_logout" value="logout"/>
        	</div>
        </c:if>
        
        <c:if test="${empty loginUser}">
        	<script>
        		location.href="/login/logout.do";
        	</script>
        </c:if>
</head>

		<!--[if IE 7]>
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.6.3/css/font-awesome-ie7.min.css">
		<![endif]-->
	    <!-- ==============================================
	    Hero
	    =============================================== -->
        <section class="hero">

         <div class="container">
       		<div align='center' style='margin-bottom:20px;'>
       		<input type="button" id="btn_main" value="main_page"/>
       		</div>
       		
       		<div align="center">
       		<input type="text" id="search_text" placeholder="Search" style="height:30px;width:500px;margin-bottom:5%;"/>
       		<button type="button" id="search_btn"><i class="fa fa-search fa-lg" aria-hidden="true" id="search_icon"></i></button>
       		</div>
       <div class="row">         
         <form method="POST" name="f" action="/board/create" style="width:100%;">
         	 <div class="col-lg-6 offset-lg-3" >
				<div class="cardbox shadow-lg bg-white">
				 <div class="cardbox-heading">
				   <div class="d-flex mr-3">
						<textarea name="b_content"></textarea>
				   </div>
				 </div><!--/ cardbox-heading -->
				 </div>
		</div>
			

         </form>
	
      	</div>
         </div><!--/ container -->
          </section>
 <script>
 $(document).ready(function(){
     
     $("#btn_logout").on('click', function(){
   	 	location.href="/login/logout.do";
     });

     $("#btn_main").on('click', function(){
    	 location.href="/board/list.do";
     });
     
  });
  </script>
  
  <%--파일업로드관련 --%>
      <!-- The template to display files available for upload -->
    <script id="template-upload" type="text/x-tmpl">
      {% for (var i=0, file; file=o.files[i]; i++) { %}
          <tr class="template-upload fade">
              <td>
                  <span class="preview"></span>
              </td>
              <td>
                  {% if (window.innerWidth > 480 || !o.options.loadImageFileTypes.test(file.type)) { %}
                      <p class="name">{%=file.name%}</p>
                  {% } %}
                  <strong class="error text-danger"></strong>
              </td>
              <td>
                  <p class="size">Processing...</p>
                  <div class="progress progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="progress-bar progress-bar-success" style="width:0%;"></div></div>
              </td>
              <td>
                  {% if (!o.options.autoUpload && o.options.edit && o.options.loadImageFileTypes.test(file.type)) { %}
                    <button class="btn btn-success edit" data-index="{%=i%}" disabled>
                        <i class="glyphicon glyphicon-edit"></i>
                        <span>Edit</span>
                    </button>
                  {% } %}
                  {% if (!i && !o.options.autoUpload) { %}
                      <button class="btn btn-primary start" disabled>
                          <i class="glyphicon glyphicon-upload"></i>
                          <span>Start</span>
                      </button>
                  {% } %}
                  {% if (!i) { %}
                      <button class="btn btn-warning cancel">
                          <i class="glyphicon glyphicon-ban-circle"></i>
                          <span>Cancel</span>
                      </button>
                  {% } %}
              </td>
          </tr>
      {% } %}
    </script>
    <!-- The template to display files available for download -->
    <script id="template-download" type="text/x-tmpl">
      {% for (var i=0, file; file=o.files[i]; i++) { %}
          <tr class="template-download fade">
              <td>
                  <span class="preview">
                      {% if (file.thumbnailUrl) { %}
                          <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" data-gallery><img src="{%=file.thumbnailUrl%}"></a>
                      {% } %}
                  </span>
              </td>
              <td>
                  {% if (window.innerWidth > 480 || !file.thumbnailUrl) { %}
                      <p class="name">
                          {% if (file.url) { %}
                              <a href="{%=file.url%}" title="{%=file.name%}" download="{%=file.name%}" {%=file.thumbnailUrl?'data-gallery':''%}>{%=file.name%}</a>
                          {% } else { %}
                              <span>{%=file.name%}</span>
                          {% } %}
                      </p>
                  {% } %}
                  {% if (file.error) { %}
                      <div><span class="label label-danger">Error</span> {%=file.error%}</div>
                  {% } %}
              </td>
              <td>
                  <span class="size">{%=o.formatFileSize(file.size)%}</span>
              </td>
              <td>
                  {% if (file.deleteUrl) { %}
                      <button class="btn btn-danger delete" data-type="{%=file.deleteType%}" data-url="{%=file.deleteUrl%}"{% if (file.deleteWithCredentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                          <i class="glyphicon glyphicon-trash"></i>
                          <span>Delete</span>
                      </button>
                      <input type="checkbox" name="delete" value="1" class="toggle">
                  {% } else { %}
                      <button class="btn btn-warning cancel">
                          <i class="glyphicon glyphicon-ban-circle"></i>
                          <span>Cancel</span>
                      </button>
                  {% } %}
              </td>
          </tr>
      {% } %}
    </script>
    
    <script
      src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"
      integrity="sha384-vk5WoKIaW/vJyUAd9n/wmopsmNhiy+L2Z+SBxGYnUkunIxVxAv/UtMOhba/xskxh"
      crossorigin="anonymous"
    ></script>
    
    <!-- The jQuery UI widget factory, can be omitted if jQuery UI is already included -->
    <script src="/resources/file_js/vendor/jquery.ui.widget.js"></script>
    <!-- The Templates plugin is included to render the upload/download listings -->
    <script src="https://blueimp.github.io/JavaScript-Templates/js/tmpl.min.js"></script>
    <!-- The Load Image plugin is included for the preview images and image resizing functionality -->
    <script src="https://blueimp.github.io/JavaScript-Load-Image/js/load-image.all.min.js"></script>
    <!-- The Canvas to Blob plugin is included for image resizing functionality -->
    <script src="https://blueimp.github.io/JavaScript-Canvas-to-Blob/js/canvas-to-blob.min.js"></script>
    <!-- blueimp Gallery script -->
    <script src="https://blueimp.github.io/Gallery/js/jquery.blueimp-gallery.min.js"></script>
    <!-- The Iframe Transport is required for browsers without support for XHR file uploads -->
    <script src="/resources/file_js/jquery.iframe-transport.js"></script>
    <!-- The basic File Upload plugin -->
    <script src="/resources/file_js/jquery.fileupload.js"></script>
    <!-- The File Upload processing plugin -->
    <script src="/resources/file_js/jquery.fileupload-process.js"></script>
    <!-- The File Upload image preview & resize plugin -->
    <script src="/resources/file_js/jquery.fileupload-image.js"></script>
    <!-- The File Upload audio preview plugin -->
    <script src="/resources/file_js/jquery.fileupload-audio.js"></script>
    <!-- The File Upload video preview plugin -->
    <script src="/resources/file_js/jquery.fileupload-video.js"></script>
    <!-- The File Upload validation plugin -->
    <script src="/resources/file_js/jquery.fileupload-validate.js"></script>
    <!-- The File Upload user interface plugin -->
    <script src="/resources/file_js/jquery.fileupload-ui.js"></script>
    <!-- The main application script -->
    <script src="/resources/file_js/demo.js"></script>
    <!-- The XDomainRequest Transport is included for cross-domain file deletion for IE 8 and IE 9 -->
    <!--[if (gte IE 8)&(lt IE 10)]>
      <script src="js/cors/jquery.xdr-transport.js"></script>
    <![endif]-->
  
       