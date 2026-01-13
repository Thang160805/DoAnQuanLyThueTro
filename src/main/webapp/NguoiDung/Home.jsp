<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.ThongBao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/Home.css">
<style>
body {
	font-family: "Open Sans", sans-serif;
	background-color: #f5f5f5;
	color: #222222;
	line-height: 1.6;
}
.card-footer {
	border-top: 1px solid #f0f0f0;
	padding-top: 15px;
	display: flex;
	justify-content: flex-end;
	align-items: center;
}

.btn-view {
	background: white;
	border: 1px solid #1E90FF;
	color: #1E90FF;
	padding: 6px 15px;
	border-radius: 6px;
	font-weight: 600;
	font-size: 0.85rem;
	cursor: pointer;
	transition: 0.2s;
	text-decoration: none;
	display: inline-block; 
}

.btn-view:hover {
	background: #1E90FF;
	color: white;
}
.dropdown-item {
	padding: 10px 20px;
	display: block;
	font-size: 0.9rem;
	color: #222222;
	 white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}
</style>
</head>
<body>
	<%
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
				<li class="nav-item active"><a
					href="${pageContext.request.contextPath}/ProcessHomeUser">Trang
						chủ</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/TimPhong">Tìm phòng</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/PhongDaThue">Phòng đã thuê</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/LichThanhToan">Lịch thanh toán</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/HopDong">Hợp đồng</a></li>
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
				<% ArrayList<ThongBao> list = (ArrayList<ThongBao>) request.getAttribute("listTB"); %>
				<div class="dropdown-content" id="notif-drop">
				<% for(ThongBao tb : list){
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

	<section class="hero-section">
		<div class="hero-overlay"></div>
		<div class="hero-content">
			<h1 class="hero-title">Chào mừng bạn đến với FindRoom!</h1>
			<p class="hero-subtitle">Tìm phòng trọ dễ dàng – Nhanh chóng – Uy
				tín. Hệ thống kết nối hàng triệu sinh viên và người đi làm với nơi ở
				lý tưởng.</p>
		</div>
	</section>



	<div style="background-color: #ecf0f1;">
		<section class="container">
			<div class="section-header">
				<h2 class="section-title">
					Phòng còn trống <span
						style="font-weight: 400; font-size: 1.2rem; color: #777; margin-left: 5px;">(Sẵn
						sàng vào ở)</span>
				</h2>
				<a href="${pageContext.request.contextPath}/DanhSachPhongTrong"
					class="view-more">Xem tất cả <i class="fa-solid fa-arrow-right"></i></a>
			</div>

			<div class="grid-layout">
				<%
				ArrayList<PhongTro> listTB = (ArrayList<PhongTro>) request.getAttribute("listPhongTrong");
				for (PhongTro pt : listTB) {
				%>
				<div class="room-card">
					<div class="card-img-wrap">
						<span class="tag-status tag-available"><%=pt.getTrangThai()%></span>
						<img src="<%=pt.getAnhChinh()%>" class="card-img">
					</div>
					<div class="card-content">
						<h3 class="card-title"><%=pt.getTenPhong()%></h3>
						<div class="card-price">
							<%=CurrencyHelper.format(pt.getGiaThue())%>
							đ <span>/tháng</span>
						</div>
						<div class="card-specs">
							<span class="spec-item"><i
								class="fa-solid fa-ruler-combined"></i> <%=pt.getDienTich()%>m²</span>
						</div>
						<div class="card-address">
							<i class="fa-solid fa-location-dot" style="color: #717171"></i>
							<%=pt.getDiaChi()%>
						</div>
						<div class="card-footer">
							<a
								href="${pageContext.request.contextPath}/ChiTietPhong_1?ID_Phong=<%= pt.getID_Phong() %>"
								class="btn-view">Xem chi tiết</a>
						</div>
					</div>
				</div>
				<%
				}
				%>

			</div>
		</section>
	</div>

	<section class="container">
		<div class="section-header">
			<h2 class="section-title">Mới đăng gần đây</h2>
		</div>

		<div class="slider-container">
			<button class="slider-btn btn-prev"
				onclick="document.getElementById('slider').scrollBy(-325,0)">
				<i class="fa-solid fa-chevron-left"></i>
			</button>
			<button class="slider-btn btn-next"
				onclick="document.getElementById('slider').scrollBy(325,0)">
				<i class="fa-solid fa-chevron-right"></i>
			</button>

			<div class="slider-track" id="slider">
				<%
				ArrayList<PhongTro> listNewPT = (ArrayList<PhongTro>) request.getAttribute("listNewPT");
				for (PhongTro pt1 : listNewPT) {
				%>
				<a
					href="${pageContext.request.contextPath}/ChiTietPhong_1?ID_Phong=<%= pt1.getID_Phong() %>"
					class="room-card slider-item">
					<div class="card-img-wrap">
						<span class="tag-status tag-new"><%=pt1.getTrangThai()%></span> <img
							src="<%=pt1.getAnhChinh()%>" class="card-img">
					</div>
					<div class="card-content">
						<h3 class="card-title"><%=pt1.getTenPhong()%></h3>
						<div class="card-price"><%=CurrencyHelper.format(pt1.getGiaThue())%>
							đ
						</div>
						<div class="card-address">
							<i class="fa-solid fa-location-dot"></i>
							<%=pt1.getDiaChi()%>
						</div>
					</div>
				</a>
				<%
				}
				%>

			</div>
		</div>
	</section>
	<%@ include file="../includes/footer.jsp"%>


	<script>
        function toggleDropdown(id) {
            const allDropdowns = document.querySelectorAll('.dropdown-content');
            allDropdowns.forEach(d => {
                if(d.id !== id) d.parentElement.classList.remove('active');
            });
            const element = document.getElementById(id);
            element.parentElement.classList.toggle('active');
        }
        window.onclick = function(event) {
            if (!event.target.closest('.dropdown')) {
                const dropdowns = document.querySelectorAll(".dropdown");
                dropdowns.forEach(openDropdown => {
                    openDropdown.classList.remove('active');
                });
            }
        }
    </script>

</body>
</html>