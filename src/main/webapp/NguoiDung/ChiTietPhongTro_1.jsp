<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="utils.TimeHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.KhuVuc"%>
<%@ page import="model.bean.Comment"%>
<%@ page import="model.bean.TienIch"%>
<%@ page import="utils.PageURL"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="model.bean.ThongBao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Font Google: Poppins & Inter -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@400;500;600&display=swap"
	rel="stylesheet">
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Toastify CSS (Thông báo đẹp) -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ChiTietPhong.css">
<style>
.back-btn {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 10px 18px;
	background: linear-gradient(135deg, #fafafa, #eaeaea);
	border: 1px solid #d4d4d4;
	border-radius: 10px;
	font-size: 15px;
	font-weight: 500;
	color: #333;
	text-decoration: none;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.08);
	transition: all 0.25s ease;
	margin-bottom: 30px;
	margin-top: 75px;
}

.gallery-container {
	position: relative;
	margin-bottom: 30px;
	margin-top: 100px;
}

.main-image-wrapper {
	height: 475px;
	background-color: #f0f0f0;
	border-radius: 12px;
	overflow: hidden;
	position: relative;
	cursor: pointer;
}

/* --- 3. MODAL OVERLAY & CONTAINER --- */
.modal-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	backdrop-filter: blur(4px);
	display: flex;
	justify-content: center;
	align-items: center;
	z-index: 10000;
	opacity: 0;
	visibility: hidden;
	transition: opacity 0.3s ease, visibility 0.3s ease;
}

.modal-overlay.active {
	opacity: 1;
	visibility: visible;
}

.modal-container {
	background: #FFFFFF;
	width: 780px;
	max-width: 95%;
	max-height: 90vh;
	border-radius: 12px;
	box-shadow: 0 6px 16px rgba(0, 0, 0, 0.08);
	display: flex;
	flex-direction: column;
	transform: translateY(20px);
	transition: transform 0.3s cubic-bezier(0.16, 1, 0.3, 1);
	overflow: hidden;
	/* Để bo góc hoạt động tốt */
}

.modal-overlay.active .modal-container {
	transform: translateY(0);
}

/* --- 4. MODAL HEADER --- */
.modal-header {
	padding: 40px 40px;
	border-bottom: 1px solid #eee;
	display: flex;
	justify-content: space-between;
	background: #fff;
}

.header-title h2 {
	font-size: 24px;
	font-weight: 700;
	margin-bottom: 4px;
	color: #222222;
}

.header-meta {
	font-size: 13px;
	color: #717171;
	display: flex;
	gap: 12px;
	align-items: center;
}

.meta-item {
	display: flex;
	align-items: center;
	gap: 4px;
}

.tag-free {
	color: #2ECC71;
	font-weight: 600;
	background: rgba(46, 204, 113, 0.1);
	padding: 2px 6px;
	border-radius: 4px;
}

.header-actions {
	display: flex;
	gap: 12px;
}

.btn-icon {
	background: #f5f7fa;
	border: none;
	width: 36px;
	height: 36px;
	border-radius: 50%;
	color: #717171;
	cursor: pointer;
	display: flex;
	align-items: center;
	justify-content: center;
	transition: all 0.2s ease;
	font-size: 16px;
}

.btn-icon:hover {
	background: #e0e7ff;
	color: #1E90FF;
}

.btn-close-icon:hover {
	background: #ffe0e0;
	color: #e74c3c;
}

/* --- 5. MODAL BODY (Content Scroll) --- */
.modal-body {
	flex: 1;
	padding: 24px 32px;
	overflow-y: auto;
	background-color: #fff;
	font-size: 15px;
	color: #333;
}

/* Custom Scrollbar */
.modal-body::-webkit-scrollbar {
	width: 6px;
}

.modal-body::-webkit-scrollbar-track {
	background: #f1f1f1;
}

.modal-body::-webkit-scrollbar-thumb {
	background: #ccc;
	border-radius: 3px;
}

.modal-body::-webkit-scrollbar-thumb:hover {
	background: #bbb;
}

/* Typography trong hợp đồng */
.contract-content h3 {
	font-size: 18px;
	font-weight: 700;
	margin-top: 20px;
	margin-bottom: 10px;
	color: #000;
}

.contract-content p {
	margin-bottom: 12px;
	text-align: justify;
}

.contract-content ul {
	padding-left: 20px;
	margin-bottom: 12px;
}

.highlight {
	font-weight: 600;
	color: #1E90FF;
}

/* --- 6. MODAL FOOTER --- */
.modal-footer {
	padding: 20px 24px;
	border-top: 1px solid #eee;
	background: #fff;
	display: flex;
	flex-direction: column;
	gap: 16px;
}

.checkbox-wrapper {
	display: flex;
	align-items: center;
	gap: 8px;
	font-size: 14px;
	color: #222222;
	cursor: pointer;
}

.checkbox-wrapper input {
	accent-color: #1E90FF;
	width: 16px;
	height: 16px;
	cursor: pointer;
}

.footer-buttons {
	display: flex;
	justify-content: space-between;
	align-items: center;
	gap: 16px;
}

.btn-group-main {
	display: flex;
	gap: 12px;
	flex: 1;
}

.btn {
	padding: 12px 24px;
	border-radius: 8px;
	font-weight: 600;
	font-size: 15px;
	cursor: pointer;
	transition: all 0.2s ease;
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 8px;
}

.btn-primary {
	background-color: #1E90FF;
	color: white;
	border: none;
	flex: 2;
	box-shadow: 0 4px 12px rgba(30, 144, 255, 0.2);
}

.btn-primary:hover {
	background-color: #1873CC;
	transform: translateY(-1px);
}

.btn-primary:disabled {
	background-color: #ccc;
	cursor: not-allowed;
	transform: none;
	box-shadow: none;
}

.btn-secondary {
	background-color: white;
	color: #1E90FF;
	border: 1px solid #1E90FF;
	display: flex;
}

.btn-text-close:hover {
	color: #222222;
}

/* --- 7. RESPONSIVE --- */
@media ( max-width : 768px) {
	.modal-container {
		width: 100%;
		height: 100%;
		max-width: 100%;
		max-height: 100%;
		border-radius: 0;
	}
	.modal-header {
		padding: 16px;
	}
	.header-title h2 {
		font-size: 20px;
	}
	.meta-item i {
		display: none;
	}

	/* Ẩn icon nhỏ trên mobile cho gọn */
	.modal-footer {
		padding: 16px;
		border-top: 1px solid #eee;
		position: sticky;
		bottom: 0;
	}
	.footer-buttons {
		flex-direction: column-reverse;
		gap: 12px;
	}
	.btn-group-main {
		width: 100%;
	}
	.btn-text-close {
		margin-bottom: 5px;
	}
}

/* --- 8. PRINT STYLE --- */
@media print {
	body * {
		visibility: hidden;
	}
	#printableArea, #printableArea * {
		visibility: visible;
	}
	#printableArea {
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
	}
	.modal-container {
		box-shadow: none;
		border: none;
	}
}
</style>
</head>
<body>
	<%
	// Ngăn cache để không thể back sau khi logout
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setDateHeader("Expires", 0);

	if (session.getAttribute("user") == null) {
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
	}
	%>
	<%
	TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTinCaNhan");
	int countTB = (int) request.getAttribute("countTB");
	%>
	<header>
		<a class="navbar-brand" href="#"> <i
			class="fa-solid fa-house-chimney"></i> FindRoom
		</a>

		<nav>
			<ul class="nav-menu">
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/ProcessHomeUser">Trang
						chủ</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/TimPhong">Tìm phòng</a></li>
				<li class="nav-item"><a href="#">Phòng đã thuê</a></li>
				<li class="nav-item"><a href="#">Lịch thanh toán</a></li>
				<li class="nav-item"><a href="#">Hợp đồng</a></li>
			</ul>
		</nav>

		<div class="header-right">
			<div class="dropdown" onclick="toggleDropdown('notif-drop')">
				<div class="notification-icon">
					<i class="fa-regular fa-bell"></i>
					<%
					if (countTB > 0) {
					%>
					<span class="badge"><%=countTB%></span>
					<%
					}
					%>
				</div>
				<% ArrayList<ThongBao> listTB = (ArrayList<ThongBao>) request.getAttribute("listTB"); %>
				<div class="dropdown-content" id="notif-drop">
				<% for(ThongBao tb : listTB){
					%>
					<a href="${pageContext.request.contextPath}/ChiTietThongBao?id=<%= tb.getId() %>" class="dropdown-item"><%= tb.getTitle() %></a>
						<%} %> 
					<div class="dropdown-divider"></div>
					<a href="${pageContext.request.contextPath}/TatCaThongBao"
						class="dropdown-item" style="text-align: center; color: #1E90FF;">Xem
						tất cả</a>
				</div>
			</div>

			<div class="dropdown" onclick="toggleDropdown('user-drop')">
				<div class="user-profile">
					<img src="<%= (tk != null && tk.getAvatar() != null) ? tk.getAvatar() : "" %>" alt="User" class="avatar"> <i
						class="fa-solid fa-angle-down"
						style="font-size: 0.8rem; color: #666;"></i>
				</div>
				<div class="dropdown-content" id="user-drop">
					<a href="${pageContext.request.contextPath}/ThongTinCaNhan"
						class="dropdown-item"><i class="fa-regular fa-user"
						style="width: 20px"></i> Thông tin cá nhân</a> <a
						href="${pageContext.request.contextPath}/CaiDat"
						class="dropdown-item"><i class="fa-solid fa-gear"
						style="width: 20px"></i> Cài đặt</a>
					<div class="dropdown-divider"></div>
					<a href="${pageContext.request.contextPath}/Logout"
						class="dropdown-item" style="color: #e74c3c;"><i
						class="fa-solid fa-right-from-bracket" style="width: 20px"></i>
						Đăng xuất</a>
				</div>
			</div>
		</div>
	</header>
	<%
	PhongTro pt = (PhongTro) request.getAttribute("ChiTietPhong");
	%>
	<div class="container mt-4">

		<!-- 1. ẢNH PHÒNG (Gallery) -->
		<div class="gallery-container">
			<%
			ArrayList<String> img = pt.getHinhAnh();
			%>
			<div class="main-image-wrapper">
				<%
				if (img != null && !img.isEmpty()) {
					String firstImage = img.get(0);
				%>
				<img src="<%=firstImage%>" id="currentImg" class="main-image"
					alt="Phòng trọ">
				<%
				}
				%>
			</div>
			<div class="thumb-row">
				<%
				if (img != null && img.size() > 1) {
					for (int i = 0; i < img.size(); i++) {
				%>
				<img src="<%=img.get(i)%>" class="thumb-img active"
					onclick="changeImage(this)">

				<%
				}
				}
				%>
			</div>
		</div>

		<div class="detail-layout">
			<!-- CỘT TRÁI: THÔNG TIN CHI TIẾT -->
			<div class="left-column">
				<!-- 2. THÔNG TIN CHÍNH -->
				<div class="room-header">
					<h1><%=pt.getTenPhong()%></h1>
					<div class="room-address">
						<i class="fa-solid fa-location-dot text-danger"></i>
						<%=pt.getDiaChi()%>
					</div>
					<div class="room-tags">
						<span class="tag tag-status"><%=pt.getTrangThai()%></span> <span
							class="tag tag-area"><i class="fa-solid fa-ruler-combined"></i>
							<%=pt.getDienTich()%>m²</span>
					</div>
				</div>

				<div class="section-box">
					<div class="landlord-box">
						<img src="<%=pt.getAvatar()%>" class="landlord-avatar">
						<div>
							<div class="landlord-name"><%=pt.getTenCT()%></div>
							<div class="landlord-sub">Chủ nhà • Phản hồi nhanh</div>
						</div>
						<button
							class="btn btn-outline-primary btn-sm ms-auto rounded-pill px-3">
							<i class="fa-brands fa-whatsapp"></i> Chat ngay
						</button>
					</div>
					<p class="text-secondary"><%=pt.getMoTa()%></p>
				</div>

				<%
				Map<String, String> iconMap = new HashMap<>();
				iconMap.put("Điều hòa", "fas fa-snowflake");
				iconMap.put("Wi-Fi miễn phí", "fas fa-wifi");
				iconMap.put("Máy giặt", "fas fa-soap");
				iconMap.put("Chỗ để xe", "fas fa-motorcycle");
				iconMap.put("Bình nóng lạnh", "fas fa-shower");
				iconMap.put("Giường, tủ, bàn ghế", "fas fa-bed");
				iconMap.put("Nhà vệ sinh khép kín", "fas fa-bath");
				iconMap.put("Camera an ninh", "fas fa-video");
				iconMap.put("Ban công riêng", "fas fa-door-open");
				iconMap.put("Chỗ nấu ăn", "fas fa-fire");
				%>

				<!-- Tiện ích -->
				<div class="section-box">
					<h3 class="section-title">Tiện ích có sẵn</h3>

					<div class="amenities-grid">
						<%
						ArrayList<TienIch> list = (ArrayList<TienIch>) request.getAttribute("listTienIch");
						for (TienIch ti : list) {
							String name = ti.getTenTienIch();
							String icon = iconMap.getOrDefault(name, "fas fa-check");
						%>
						<div class="amenity-item">
							<i class="<%=icon%>"></i>
							<%=name%>
						</div>
						<%
						}
						%>

					</div>
				</div>

				<!-- 3. BẢN ĐỒ -->
				<div class="section-box">
					<h3 class="section-title">Vị trí</h3>
					<iframe
						src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3723.6573463462786!2d105.7812523148837!3d21.046392985988864!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x3135ab3b4220c2bd%3A0x1c9e359e2a4f618c!2zQ2Hduw!5e0!3m2!1svi!2s!4v1646814758000!5m2!1svi!2s"
						class="map-frame" allowfullscreen="" loading="lazy"></iframe>
				</div>
				<% int countComment = (int) request.getAttribute("countComment");
				int avgStar = (int) request.getAttribute("avgStar");
				%>
				<!-- 5. BÌNH LUẬN -->
				<div class="section-box">
					<div class="review-summary">
						<i class="fa-solid fa-star text-warning"></i> <%= (avgStar !=-1) ? avgStar : "" %>.0 <span
							style="font-size: 1.1rem; font-weight: 400; color: #777;">(<%= (countComment !=-1) ? countComment : "" %>
							đánh giá)</span>
					</div>

					<!-- Form đăng bình luận -->
					<form action="${pageContext.request.contextPath}/Comment"
						method="post" id="reviewForm">

						<div class="mb-4 p-3 bg-light rounded-3">
							<h6 class="fw-bold mb-2">Viết đánh giá của bạn</h6>
							<!-- Chọn sao -->
							<div class="d-flex gap-2 mb-2 text-warning rating"
								id="ratingStars">
								<i class="fa-regular fa-star" data-value="1"></i> <i
									class="fa-regular fa-star" data-value="2"></i> <i
									class="fa-regular fa-star" data-value="3"></i> <i
									class="fa-regular fa-star" data-value="4"></i> <i
									class="fa-regular fa-star" data-value="5"></i>
							</div>
							<input type="hidden" name="id_Phong"
								value="<%=pt.getID_Phong()%>">
							<!-- Input bình thường để nhận số sao -->
							<input type="hidden" name="rating" id="ratingInput"
								class="form-control mb-2" readonly>

							<textarea name="comment" id="commentText"
								class="form-control mb-2" rows="2"
								placeholder="Chia sẻ trải nghiệm của bạn..."></textarea>

							<button type="submit" class="btn btn-primary btn-sm">Đăng
								bình luận</button>
						</div>

					</form>

					<!-- List bình luận -->
					<div class="review-list">
						<%
						ArrayList<Comment> listCM = (ArrayList<Comment>) request.getAttribute("listComment");
						for (Comment cm : listCM) {
						%>
						<div class="review-card">
							<div class="review-header">
								<div class="reviewer-info">
									<img src="<%=cm.getAvatar()%>" class="avatar">
									<div>
										<div class="review-name"><%=cm.getTenNguoiDung()%></div>
										<div class="review-date"><%=TimeHelper.timeAgo(cm.getCreate_at())%></div>
									</div>
								</div>
								<div class="text-warning small">
									<i class="fa-solid fa-star"></i>
									<%=cm.getRating()%>.0
								</div>
							</div>
							<div class="review-text"><%=cm.getComment()%></div>
						</div>
						<%
						}
						%>

					</div>
				</div>

			</div>

			<!-- CỘT PHẢI: ĐẶT PHÒNG (Sticky Sidebar) -->
			<div class="right-column">
				<div class="booking-sidebar">
					<div class="price-tag">
						<%=CurrencyHelper.format(pt.getGiaThue())%>
						đ <span class="price-sub">/ tháng</span>
					</div>
					<div class="text-success fw-bold mt-1 small">
						<i class="fa-solid fa-bolt"></i> Điện
						<%=CurrencyHelper.format(pt.getGiaDien())%>đ/số • <i
							class="fa-solid fa-droplet"></i> Nước
						<%=CurrencyHelper.format(pt.getGiaNuoc())%>đ/m³
					</div>

					<div class="booking-action">
						<!-- 4. NÚT THUÊ PHÒNG (Trigger Modal) -->
						<a href="${pageContext.request.contextPath}/YeuCauThueTro?ID_Phong=<%= pt.getID_Phong() %>" class="btn-rent">Yêu cầu thuê</a>
					</div>

					<div class="mt-4 pt-3 border-top">
						<div class="d-flex justify-content-between mb-2">
							<span>Liên hệ chủ nhà:</span> <a href="tel:0988123456"
								class="text-decoration-none fw-bold"><%=pt.getPhone()%></a>
						</div>
					</div>
				</div>
			</div>
		</div>


		<!-- 6. PHÒNG TƯƠNG TỰ -->
		<div class="section-box border-top-0 mt-4">
			<h3 class="section-title">Phòng tương tự gần đây</h3>
			<div class="row g-4">
				<div class="col-md-4 col-sm-6">
					<div class="card-room">
						<img src="https://source.unsplash.com/random/400x300/?bedroom"
							class="card-img">
						<div class="card-body">
							<h5 class="fw-bold fs-6 mb-1">Phòng Studio Ban Công</h5>
							<div class="text-muted small mb-2">Tây Hồ, Hà Nội • 30m²</div>
							<div class="card-price">5.000.000 đ</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 col-sm-6">
					<div class="card-room">
						<img src="https://source.unsplash.com/random/400x300/?loft"
							class="card-img">
						<div class="card-body">
							<h5 class="fw-bold fs-6 mb-1">Căn hộ dịch vụ Full đồ</h5>
							<div class="text-muted small mb-2">Ba Đình, Hà Nội • 40m²</div>
							<div class="card-price">6.500.000 đ</div>
						</div>
					</div>
				</div>
				<div class="col-md-4 col-sm-6 d-none d-md-block">
					<div class="card-room">
						<img src="https://source.unsplash.com/random/400x300/?interior"
							class="card-img">
						<div class="card-body">
							<h5 class="fw-bold fs-6 mb-1">Phòng trọ khép kín</h5>
							<div class="text-muted small mb-2">Cầu Giấy, Hà Nội • 25m²</div>
							<div class="card-price">3.800.000 đ</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="../includes/footer.jsp"%>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
	function toggleDropdown(id) {
        // Đóng các dropdown khác
        const allDropdowns = document.querySelectorAll('.dropdown-content');
        allDropdowns.forEach(d => {
            if(d.id !== id) d.parentElement.classList.remove('active');
        });

        // Mở/Đóng cái hiện tại
        const element = document.getElementById(id);
        element.parentElement.classList.toggle('active');
    }

    // Click ra ngoài thì đóng
    window.onclick = function(event) {
        if (!event.target.closest('.dropdown')) {
            const dropdowns = document.querySelectorAll(".dropdown");
            dropdowns.forEach(openDropdown => {
                openDropdown.classList.remove('active');
            });
        }
    }
        // Gallery Image Switcher
        function changeImage(element) {
            // Change main image
            document.getElementById('currentImg').src = element.src.replace('w=200', 'w=1200'); // Load high res
            
            // Update active class
            document.querySelectorAll('.thumb-img').forEach(img => img.classList.remove('active'));
            element.classList.add('active');
            function toggleDropdown(id) {
                // Đóng các dropdown khác
                const allDropdowns = document.querySelectorAll('.dropdown-content');
                allDropdowns.forEach(d => {
                    if(d.id !== id) d.parentElement.classList.remove('active');
                });

                // Mở/Đóng cái hiện tại
                const element = document.getElementById(id);
                element.parentElement.classList.toggle('active');
            }

            // Click ra ngoài thì đóng
            window.onclick = function(event) {
                if (!event.target.closest('.dropdown')) {
                    const dropdowns = document.querySelectorAll(".dropdown");
                    dropdowns.forEach(openDropdown => {
                        openDropdown.classList.remove('active');
                    });
                }
            }
        }
        
        const modal = document.getElementById('contractModal');
        const openBtn = document.getElementById('openModalBtn');
        const closeIconBtn = document.getElementById('closeIconBtn');
        const agreeCheckbox = document.getElementById('agreeTerms');
        const submitBtn = document.getElementById('submitBtn');

        function openModal() {
            modal.classList.add('active');
            document.body.style.overflow = 'hidden';
            closeIconBtn.focus();
        }

        function closeModal() {
            modal.classList.remove('active');
            document.body.style.overflow = '';
            agreeCheckbox.checked = false;
            submitBtn.disabled = true;
        }

        openBtn.addEventListener('click', openModal);
        closeIconBtn.addEventListener('click', closeModal);

        modal.addEventListener('click', (e) => {
            if (e.target === modal) closeModal();
        });

        // CHECKBOX EVENT
        agreeCheckbox.addEventListener('change', function () {
            submitBtn.disabled = !this.checked;
        });

        // --- 4. CHỨC NĂNG GIẢ LẬP ---

        // In hợp đồng
        function printContract() {
            window.print();
        }

        // Tải xuống PDF
        function downloadContract() {
            // Logic thực tế: Gọi API backend để tải file PDF thật
            // Ở đây dùng giả lập tạo file text đơn giản
            const element = document.createElement('a');
            const text = document.querySelector('.contract-content').innerText;
            element.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(text));
            element.setAttribute('download', 'Mau_Hop_Dong.txt'); // Demo tải file text
            element.style.display = 'none';
            document.body.appendChild(element);
            element.click();
            document.body.removeChild(element);

            alert('Đang tải xuống bản mẫu hợp đồng...');
        }

        // Ký hợp đồng (Submit)
        function signContract() {
            if (!submitBtn.disabled) {
                alert('Bạn đã đồng ý ký hợp đồng! Hệ thống sẽ chuyển sang bước thanh toán.');
                closeModal();
                // window.location.href = '/payment-step'; // Chuyển trang
            }
        }
        
        const stars = document.querySelectorAll("#ratingStars i");
        const ratingInput = document.getElementById("ratingInput");

        stars.forEach(star => {
            star.addEventListener("click", function () {
                let value = this.getAttribute("data-value");

                // tô sao
                stars.forEach(s => s.classList.replace("fa-solid","fa-regular"));
                for (let i = 0; i < value; i++) {
                    stars[i].classList.replace("fa-regular","fa-solid");
                }

                // gán vào input để form tự gửi
                ratingInput.value = value;
            });
        });
    </script>

</body>
</html>