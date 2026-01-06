<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Google Fonts: Poppins (Hiện đại, tròn trịa giống Airbnb) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">

<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/index.css">
	<style>
	body {
	font-family: "Open Sans", sans-serif;
	color: #222222;
	overflow-x: hidden;
}
	</style>
</head>
<body>
	<!-- 1. HEADER -->
	<nav class="navbar navbar-expand-lg">
		<div class="container-fluid" style="max-width: 1300px;">
			<a class="navbar-brand" href="#"> <i
				class="fa-solid fa-house-chimney"></i> FindRoom
			</a>
			<button class="navbar-toggler border-0" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav mx-auto">
					<li class="nav-item"><a class="nav-link" href="#intro">Giới
							thiệu</a></li>
					<li class="nav-item"><a class="nav-link" href="#features">Tính
							năng</a></li>
					<li class="nav-item"><a class="nav-link" href="#reviews">Đánh
							giá</a></li>
				</ul>
				<div class="d-flex gap-2 mt-3 mt-lg-0">
					<a href="${pageContext.request.contextPath}/auth/DangNhap.jsp"
						class="btn-auth btn-login">Đăng nhập</a> <a
						href="${pageContext.request.contextPath}/auth/DangKy.jsp"
						class="btn-auth btn-register">Đăng ký ngay</a>
				</div>
			</div>
		</div>
	</nav>

	<!-- 2. HERO BANNER -->
	<section class="hero-section">
		<div class="container">
			<div class="hero-content">
				<h1>
					Tìm phòng trọ dễ dàng <br> An toàn – Minh bạch
				</h1>
				<p>Kết nối hàng triệu người thuê và chủ nhà. Hệ thống quản lý
					thông minh giúp bạn an tâm tuyệt đối khi thuê phòng.</p>


			</div>
		</div>
	</section>

	<!-- 3. GIỚI THIỆU (Sứ mệnh) -->
	<section class="intro-section" id="intro">
		<div class="container" style="max-width: 1200px;">
			<div class="row align-items-center">
				<div class="col-lg-6">
					<h2 class="section-title">Tại sao chọn FindRoom?</h2>
					<p class="section-subtitle">Chúng tôi không chỉ giúp bạn tìm
						chỗ ở, chúng tôi mang đến giải pháp quản lý và trải nghiệm sống
						tốt hơn.</p>

					<ul class="list-unstyled check-list">
						<li><i class="fa-solid fa-check"></i> <span><strong>Thông
									tin xác thực:</strong> 100% phòng trọ được kiểm duyệt hình ảnh và thông
								tin.</span></li>
						<li><i class="fa-solid fa-check"></i> <span><strong>Tiết
									kiệm chi phí:</strong> Không qua môi giới, giá gốc từ chủ nhà.</span></li>
						<li><i class="fa-solid fa-check"></i> <span><strong>Hợp
									đồng minh bạch:</strong> Ký kết hợp đồng điện tử, bảo vệ quyền lợi đôi
								bên.</span></li>
						<li><i class="fa-solid fa-check"></i> <span><strong>Hỗ
									trợ 24/7:</strong> Đội ngũ CSKH luôn sẵn sàng giải quyết mọi vấn đề.</span></li>
					</ul>
					<a href="#"
						class="btn btn-link text-decoration-none p-0 mt-3 fw-bold text-primary">Tìm
						hiểu thêm về chúng tôi <i class="fa-solid fa-arrow-right"></i>
					</a>
				</div>
				<div class="col-lg-6">
					<div class="row g-3">
						<div class="col-6 mt-5">
							<img
								src="https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?auto=format&fit=crop&w=600&q=80"
								class="intro-img">
						</div>
						<div class="col-6">
							<img
								src="https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=600&q=80"
								class="intro-img">
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 4. TÍNH NĂNG NỔI BẬT -->
	<section class="features-section" id="features">
		<div class="container" style="max-width: 1200px;">
			<div class="text-center mb-5">
				<h2 class="section-title">Tính năng vượt trội</h2>
				<p class="text-secondary">Công nghệ giúp việc thuê trọ trở nên
					đơn giản hơn bao giờ hết</p>
			</div>

			<div class="row g-4">
				<div class="col-md-3 col-sm-6">
					<div class="feature-card">
						<div class="feature-icon">
							<i class="fa-solid fa-map-location-dot"></i>
						</div>
						<h4 class="feature-title">Tìm theo bản đồ</h4>
						<p class="feature-desc">Tìm phòng trực quan ngay trên bản đồ,
							lọc theo bán kính trường học, nơi làm việc.</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="feature-card">
						<div class="feature-icon">
							<i class="fa-solid fa-sliders"></i>
						</div>
						<h4 class="feature-title">Bộ lọc thông minh</h4>
						<p class="feature-desc">Lọc chi tiết theo mức giá, diện tích,
							tiện ích (Wifi, điều hòa, nóng lạnh...).</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="feature-card">
						<div class="feature-icon">
							<i class="fa-solid fa-file-contract"></i>
						</div>
						<h4 class="feature-title">Quản lý hợp đồng</h4>
						<p class="feature-desc">Lưu trữ hợp đồng online, xem lại điều
							khoản bất cứ lúc nào, nhắc hạn hợp đồng.</p>
					</div>
				</div>
				<div class="col-md-3 col-sm-6">
					<div class="feature-card">
						<div class="feature-icon">
							<i class="fa-regular fa-credit-card"></i>
						</div>
						<h4 class="feature-title">Thanh toán Online</h4>
						<p class="feature-desc">Nhận hóa đơn và thanh toán tiền nhà,
							điện nước qua MoMo, Ngân hàng tiện lợi.</p>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- 5. TRẢI NGHIỆM (VIDEO) -->
	<section class="experience-section">
		<div class="container" style="max-width: 1000px;">
			<div class="text-center mb-5">
				<h2 class="section-title">Trải nghiệm thực tế</h2>
				<p class="text-secondary">Khám phá không gian sống tiện nghi qua
					video thực tế</p>
			</div>

			<div class="video-wrapper">
				<video class="video-thumb" controls
					poster="https://images.unsplash.com/photo-1493809842364-78817add7ffb?auto=format&fit=crop&w=1920&q=80">
					<source src="${pageContext.request.contextPath}/assets/video/Video2.mp4" type="video/mp4">
					Trình duyệt không hỗ trợ video.
				</video>
			</div>

		</div>
	</section>

	<!-- 6. ĐÁNH GIÁ (REVIEWS) -->
	<section class="reviews-section" id="reviews">
		<div class="container" style="max-width: 1200px;">
			<div class="text-center mb-5">
				<h2 class="section-title">Khách hàng nói gì về chúng tôi?</h2>
			</div>

			<div class="row">
				<div class="col-md-4">
					<div class="review-card">
						<div class="stars">
							<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star"></i>
						</div>
						<p class="review-text">"Tôi đã tìm được căn phòng ưng ý chỉ
							sau 1 ngày sử dụng FindRoom. Giao diện rất dễ dùng và thông tin
							minh bạch."</p>
						<div class="review-user">
							<img
								src="${pageContext.request.contextPath}/assets/img/NgaLe.jpg"
								class="review-avatar">
							<div>
								<h6 class="mb-0 fw-bold">Lê Thanh Nga</h6>
								<small class="text-muted">Sinh viên Đại học Vinh</small>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="review-card">
						<div class="stars">
							<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star"></i>
						</div>
						<p class="review-text">"Tính năng nhắc đóng tiền trọ rất hữu
							ích. Tôi không còn bị quên hay trễ hạn thanh toán nữa. Rất tuyệt
							vời!"</p>
						<div class="review-user">
							<img
								src="${pageContext.request.contextPath}/assets/img/PhamVoTuanMinh.jpg"
								class="review-avatar">
							<div>
								<h6 class="mb-0 fw-bold">Phạm Võ Tuấn Minh</h6>
								<small class="text-muted">SoftWare Engineer</small>
							</div>
						</div>
					</div>
				</div>
				<div class="col-md-4">
					<div class="review-card">
						<div class="stars">
							<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i
								class="fa-solid fa-star-half-stroke"></i>
						</div>
						<p class="review-text">"Là chủ nhà, tôi thấy việc quản lý hợp
							đồng trên web rất tiện. Giảm bớt giấy tờ và tránh rắc rối không
							đáng có."</p>
						<div class="review-user">
							<img
								src="${pageContext.request.contextPath}/assets/img/DuongBui.jpg"
								class="review-avatar">
							<div>
								<h6 class="mb-0 fw-bold">Bùi Đình Dương</h6>
								<small class="text-muted">Chủ trọ</small>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 7. FOOTER -->
	<footer>
		<div class="container" style="max-width: 1200px;">
			<div class="row">
				<div class="col-lg-4 mb-4">
					<a href="#" class="footer-logo"><i
						class="fa-solid fa-house-chimney"></i> FindRoom</a>
					<p class="footer-desc">Nền tảng kết nối thuê trọ số 1 Việt Nam.
						Mang đến cuộc sống tiện nghi và an toàn cho mọi người.</p>
					<div class="social-links">
						<a href="#"><i class="fa-brands fa-facebook-f"></i></a> <a
							href="#"><i class="fa-brands fa-youtube"></i></a> <a href="#"><i
							class="fa-brands fa-instagram"></i></a> <a href="#"><i
							class="fa-brands fa-tiktok"></i></a>
					</div>
				</div>
				<div class="col-lg-2 col-6 mb-4">
					<h5 class="footer-title">Về FindRoom</h5>
					<ul class="list-unstyled footer-links">
						<li><a href="#">Giới thiệu</a></li>
						<li><a href="#">Tuyển dụng</a></li>
						<li><a href="#">Tin tức</a></li>
						<li><a href="#">Liên hệ</a></li>
					</ul>
				</div>
				<div class="col-lg-3 col-6 mb-4">
					<h5 class="footer-title">Hỗ trợ khách hàng</h5>
					<ul class="list-unstyled footer-links">
						<li><a href="#">Trung tâm trợ giúp</a></li>
						<li><a href="#">Quy định sử dụng</a></li>
						<li><a href="#">Chính sách bảo mật</a></li>
						<li><a href="#">Giải quyết khiếu nại</a></li>
					</ul>
				</div>
				<div class="col-lg-3 mb-4">
					<h5 class="footer-title">Thông tin liên hệ</h5>
					<ul class="list-unstyled footer-links">
						<li><i class="fa-solid fa-location-dot me-2 text-primary"></i>
							182 Lê Duẩn, Bến Thủy, Vinh, Nghệ An</li>
						<li><i class="fa-solid fa-phone me-2 text-primary"></i> 1900
							1234</li>
						<li><i class="fa-solid fa-envelope me-2 text-primary"></i>
							support@findroom.com</li>
					</ul>
				</div>
			</div>

			<div class="copyright">
				<p class="mb-0">© 2025 FindRoom. Bản quyền thuộc về FindRoom
					Vinh, Nghệ An.</p>
			</div>
		</div>
	</footer>

	<!-- Bootstrap JS -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
		</body>
		</html>
	