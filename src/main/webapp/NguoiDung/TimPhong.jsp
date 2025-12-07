<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.KhuVuc"%>
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
	href="${pageContext.request.contextPath}/assets/css/TimPhong.css">
<style>
.container {
	max-width: 1320px;
	margin: 0 auto;
	padding: 30px 20px;
	display: grid;
	grid-template-columns: 280px 1fr;
	gap: 30px;
	align-items: start;
	margin-top: 80px;
}
/* Custom Button Style for Dropdown Trigger */
.btn-filter {
	background: white;
	border: 1px solid #ddd;
	color: #333333;
	padding: 8px 20px;
	border-radius: 20px;
	font-size: 0.9rem;
	font-weight: 500;
	display: flex;
	align-items: center;
	gap: 8px;
	transition: 0.2s;
}

.btn-filter:hover, .btn-filter.show {
	background: #f8f9fa;
	border-color: #1E90FF;
	color: #1E90FF;
}

.btn-filter::after {
	margin-left: auto;
} /* Đẩy mũi tên sang phải */

/* Dropdown Menu Item */
.dropdown-item {
	font-size: 0.9rem;
	padding: 8px 20px;
	cursor: pointer;
}

.dropdown-item:active {
	background-color: #1E90FF;
}

.result-count {
	font-size: 0.9rem;
	color: #666666;
}

.pagination {
	display: flex;
	justify-content: center;
	align-items: center;
	margin-top: 30px;
	list-style: none;
	gap: 8px;
}

.pagination a {
	text-decoration: none;
	color: #343a40;
	background: #fff;
	border: 1px solid #dee2e6;
	padding: 10px 15px;
	border-radius: 8px;
	font-weight: 600;
}

.pagination a:hover, .pagination a.active {
	background: #007bff;
	color: #fff;
	border-color: #007bff;
}

.utilities-form {
	display: flex;
	flex-direction: column;
	gap: 10px;
	/* Khoảng cách giữa các checkbox */
}
.card-location {
	font-size: 0.85rem;
	color: #666;
	display: flex;
	align-items: center;
	gap: 5px;
	margin-bottom: 15px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
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
				<li class="nav-item active"><a
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
					<a href="#" class="dropdown-item" style="color: #e74c3c;"><i
						class="fa-solid fa-right-from-bracket" style="width: 20px"></i>
						Đăng xuất</a>
				</div>
			</div>
		</div>
	</header>

	<!-- MAIN LAYOUT -->
	<div class="container">

		<!-- 2. FILTER SIDEBAR -->
		<aside class="filter-sidebar">
			<div class="filter-header">
				<div class="filter-title">
					<i class="fa-solid fa-filter"></i> Bộ lọc
				</div>
				<a href="${pageContext.request.contextPath}/TimPhong"
					class="btn-reset">Xóa tất cả</a>
			</div>

			<!-- 1. TÌM KIẾM TỪ KHÓA (FORM RIÊNG) -->
			<div class="filter-group">
				<label class="label">Tìm kiếm</label>
				<form action="${pageContext.request.contextPath}/TimPhong"
					method="GET" class="search-group">
					<input type="text" name="keyword" class="input-box"
						placeholder="Tên phòng, tên đường...">
					<button type="submit" class="search-btn-icon">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
				</form>
			</div>
			<%
			ArrayList<KhuVuc> listKV = (ArrayList<KhuVuc>) request.getAttribute("listKhuVuc");
			int ToTalCountKV = (int) request.getAttribute("totalCountKV");
			%>
			<!-- Khu vực (Links) -->
			<div class="filter-group">
				<label class="label">Khu vực</label>
				<ul class="filter-list">
					<li><a
						href="${pageContext.request.contextPath}/TimPhong?KhuVuc=all"
						class="filter-link active">Tất cả <span class="filter-count"><%=ToTalCountKV%></span>
					</a></li>
					<%
					for (KhuVuc kv : listKV) {
					%>
					<li><a
						href="${pageContext.request.contextPath}/TimPhong?KhuVuc=<%= kv.getId() %>"
						class="filter-link"><%=kv.getTenKhuVuc()%> <span
							class="filter-count"><%=kv.getSoPhong()%></span></a></li>
					<%
					}
					%>
				</ul>
			</div>

			<!-- Khoảng giá (Links) -->
			<div class="filter-group">
				<label class="label">Khoảng giá</label>
				<ul class="filter-list">
					<li><a
						href="${pageContext.request.contextPath}/TimPhong?GiaThue=1000000"
						class="filter-link">Dưới 1 triệu</a></li>
					<li><a
						href="${pageContext.request.contextPath}/TimPhong?GiaThue=3000000"
						class="filter-link">Dưới 3 triệu</a></li>
					<li><a
						href="${pageContext.request.contextPath}/TimPhong?GiaThue=5000000"
						class="filter-link">Dưới 5 triệu</a></li>
					<li><a
						href="${pageContext.request.contextPath}/TimPhong?GiaThue=7000000"
						class="filter-link">Dưới 7 triệu</a></li>
				</ul>
			</div>

			<!-- Diện tích (Links) -->
			<div class="filter-group">
				<label class="label">Diện tích</label>
				<ul class="filter-list">
					<li><a
						href="${pageContext.request.contextPath}/TimPhong?DienTich=20"
						class="filter-link">Dưới 50m²</a></li>
					<li><a
						href="${pageContext.request.contextPath}/TimPhong?DienTich=30"
						class="filter-link">Dưới 35m²</a></li>
					<li><a
						href="${pageContext.request.contextPath}/TimPhong?DienTich=50"
						class="filter-link">Dưới 20m²</a></li>
				</ul>
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

			<!-- 2. TIỆN ÍCH (MULTI-SELECT CÓ ICON) -->
			<div class="filter-group">
				<form action="${pageContext.request.contextPath}/TimPhong"
					method="get" class="utilities-form">
					<label class="label">Tiện ích (Chọn nhiều)</label>
					<div class="checkbox-group">
						<%
						ArrayList<TienIch> list = (ArrayList<TienIch>) request.getAttribute("listTienIch");
						for (TienIch ti : list) {
							String name = ti.getTenTienIch();
							String icon = iconMap.getOrDefault(name, "fas fa-check");
						%>
						<label class="checkbox-item"> <input type="checkbox"
							value="<%=ti.getId()%>" name="TienIch" class="util-check">
							<i class="<%=icon%>"></i> <%=name%>
						</label>
						<%
						}
						%>
					</div>
					<!-- Nút Tìm Kiếm Tổng Quát (Dành cho Tiện ích Multi-select) -->
					<button class="btn-search-main">Áp dụng tiện ích</button>
				</form>
			</div>


		</aside>

		<!-- 3. RESULT LIST (BÊN PHẢI) -->
		<main class="results-area">
			<%
			int TotalCount = (int) request.getAttribute("totalCount");
			%>
			<!-- Toolbar -->
			<div class="results-header">
				<span class="result-count">Tìm thấy <strong><%=TotalCount%></strong>
					phòng phù hợp
				</span>
				<!-- Filter: Mức giá -->
				<div class="dropdown">
					<button class="btn btn-filter dropdown-toggle" type="button"
						data-bs-toggle="dropdown" aria-expanded="false">Sắp xếp
						theo</button>
					<ul class="dropdown-menu">
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/TimPhong?orderBy=NgayDang&order=desc">Mới
								nhất</a></li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/TimPhong?orderBy=GiaThue&order=asc">Giá
								từ thấp đến cao</a></li>
						<li><a class="dropdown-item"
							href="${pageContext.request.contextPath}/TimPhong?orderBy=GiaThue&order=desc">Giá
								từ cao đến thấp</a></li>
					</ul>
				</div>
			</div>

			<!-- Grid Layout -->
			<div class="room-grid">
				<%
				ArrayList<PhongTro> listPT = (ArrayList<PhongTro>) request.getAttribute("listPhongTro");
				for (PhongTro pt : listPT) {
				%>
				<!-- Card 1 -->
				<div class="room-card">
					<div class="card-img-wrapper">
						<img src="<%=pt.getAnhChinh()%>" class="card-img" alt="Room">
						<i class="fa-regular fa-heart wishlist-icon"></i>
					</div>
					<div class="card-body">
						<h3 class="card-title"><%=pt.getTenPhong()%></h3>
						<div class="card-location">
							<i class="fa-solid fa-location-dot"></i>
							<%=pt.getDiaChi()%>
						</div>

						<div class="card-price">
							<%=CurrencyHelper.format(pt.getGiaThue())%>
							đ <span>/tháng</span>
						</div>

						<div class="card-features">
							<span><i class="fa-solid fa-ruler-combined"></i> <%=pt.getDienTich()%>m²</span>
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
			<%
			int currentPage = (int) request.getAttribute("currentPage");
			int totalPage = (int) request.getAttribute("totalPage");
			%>
			<nav class="pagination">
				<%
				for (int i = 1; i <= totalPage; i++) {
					String url = PageURL.buildPageUrl(request, i, "TimPhong");
					String active = (i == currentPage) ? "active" : "";
				%>
				<a href="<%=url%>" class="<%=active%>"><%=i%></a>
				<%
				}
				%>
			</nav>





		</main>
	</div>
	<%@ include file="../includes/footer.jsp"%>

	<!-- Script Bootstrap Bundle để Dropdown hoạt động -->
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
    </script>

</body>
</html>