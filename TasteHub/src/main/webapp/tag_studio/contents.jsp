<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Calendar"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<link href="css/studio/contents.css?after" rel="stylesheet"
	type="text/css">

<div class="contents-main">
	<h2 class="title-contents">동영상 업로드</h2>
	<form action="process/studio_process.jsp" method="post" enctype="multipart/form-data" id="submit-btn">
		<div class="upload-contents">
			<div class="text-upload">
				<h3>제목</h3>
				<input name="title" type="text" class="title-input" placeholder="영상 제목" required> 
				<h3>내용</h3>
				<textarea name="detail" class="exp-input" placeholder="영상 설명" maxlength="60000" required></textarea>
			</div>
			<div class="video-upload">
				<h3>비디오 선택 (mp4, mkv, avi)</h3>
				<video id="viPreview" src="" width="400px" height="235px" controls></video>
				<input type="file" class="video-input" name="video" id="video-input"
				accept=".mp4,.mkv,.avi" required>
				<h3>썸네일 선택 (jpg, jpeg, png)</h3>
				<img class="thumbnail-preview" id="imgPreview" src="img/Studio/iconNoImg.png" width="400px" height="235px">
				<input type="file" class="thumbnail-input" name="thumbnail" id="thumbnail-input"
					accept=".jpeg,.jpg,.png" required>
			</div>		
		</div>
		<div class="submit-upload">
			<input type="submit" class="btn-submit" name="submit" value="업  로  드" >		
		</div>
	</form>
	<div class="loader-contents" style="display: none;" id="loader">
		<div class="dot-spinner">
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		    <div class="dot-spinner__dot"></div>
		</div>
		<p class="text-loader">Loading...</p>
	</div>
</div>

<script>
	const imgInput = document.getElementById('thumbnail-input');
	const imgPreview = document.getElementById('imgPreview');
	const videoInput = document.getElementById('video-input');
	const viPreview = document.getElementById('viPreview');
	
	imgInput.addEventListener('change', function() {
		const file = this.files[0]; // 선택한 파일
		if (file) {
			const reader = new FileReader();
			reader.onload = function() {
				imgPreview.src = reader.result; // 미리보기 이미지 설정
				imgPreview.style.display = 'block'; // 미리보기 이미지 보이기
			}
			reader.readAsDataURL(file); // 파일 읽기 
		} else {
			imgPreview.src = 'img/Studio/iconNoImg.png'; // 미리보기 초기화
		}
	});
	videoInput.addEventListener('change', function() {
		const file = this.files[0];
		  if (file) {
		    const fileURL = URL.createObjectURL(file);
		    console.log(fileURL);
		    viPreview.src = fileURL;
		  } else {
			viPreview.src = ''; // 미리보기 초기화
		}
	});
	
	const submitBtn = document.getElementById('submit-btn');
	const loader = document.getElementById('loader');
	submitBtn.addEventListener('submit', function() {
		loader.style.display = 'flex';
	});
</script>