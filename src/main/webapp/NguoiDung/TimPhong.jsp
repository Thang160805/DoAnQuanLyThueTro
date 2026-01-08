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
<title>Tìm phòng</title>
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
<!-- Toastify CSS (Thông báo đẹp) -->
<link rel="stylesheet" type="text/css"
	href="https://cdn.jsdelivr.net/npm/toastify-js/src/toastify.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/TimPhong.css">
<style>
body {
	font-family: "Open Sans", sans-serif;
	background-color: #f5f5f5;
	color: #222222;
	line-height: 1.6;
}
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
/* Container tổng */
.filter-container {
	padding: 15px;
	background: #fff;
	border-radius: 8px;
}

.filter-group {
	margin-bottom: 20px;
}

.filter-group .label {
	display: block;
	font-weight: bold;
	margin-bottom: 8px;
	color: #333;
}

/* Hàng nhập liệu */
.input-range {
	display: flex;
	align-items: center;
	gap: 10px;
}

.filter-input {
	width: 100%;
	padding: 8px 12px;
	border: 1px solid #ccc;
	border-radius: 4px;
	font-size: 14px;
	outline: none;
	transition: border 0.3s;
}

.filter-input:focus {
	border-color: #007bff;
}

.dash {
	color: #888;
}

/* Nút bấm */
.btn-apply-all {
	width: 100%;
	background-color: #007bff;
	color: white;
	border: none;
	padding: 10px;
	border-radius: 5px;
	font-weight: bold;
	cursor: pointer;
	text-transform: uppercase;
}

.btn-apply-all:hover {
	background-color: #0056b3;
}
.pagination-wrapper {
    margin-top: 30px;
    margin-bottom: 50px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
}

.pagination-list {
    display: flex;
    align-items: center;
    gap: 6px;
    list-style: none;
    padding: 0;
}

/* Từng ô số */
.pagi-item {
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 40px;
    height: 40px;
    padding: 0 10px;
    border-radius: 10px;
    background-color: #ffffff;
    border: 1px solid #e2e8f0;
    color: #475569;
    font-weight: 500;
    font-family: 'Inter', sans-serif;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

/* Hiệu ứng Hover */
.pagi-item:hover {
    border-color: #6366f1;
    color: #6366f1;
    background-color: #f5f3ff;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15);
}

/* Trang hiện tại */
.pagi-item.active {
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    color: #ffffff;
    border: none;
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.35);
}

/* Dấu ba chấm */
.pagi-dots {
    color: #94a3b8;
    padding: 0 5px;
}

/* Chữ hiển thị thông tin */
.pagi-info {
    font-size: 0.85rem;
    color: #64748b;
    font-weight: 400;
}

/* Nút Icon */
.pagi-item i {
    font-size: 0.8rem;
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
				<%
				ArrayList<ThongBao> listTB = (ArrayList<ThongBao>) request.getAttribute("listTB");
				%>
				<div class="dropdown-content" id="notif-drop">
					<%
					for (ThongBao tb : listTB) {
					%>
					<a
						href="${pageContext.request.contextPath}/ChiTietThongBao?id=<%= tb.getId() %>"
						class="dropdown-item"><%=tb.getTitle()%></a>
					<%
					}
					%>
					<div class="dropdown-divider"></div>
					<a href="${pageContext.request.contextPath}/TatCaThongBao"
						class="dropdown-item" style="text-align: center; color: #1E90FF;">Xem
						tất cả</a>
				</div>
			</div>

			<div class="dropdown" onclick="toggleDropdown('user-drop')">
				<div class="user-profile">
					<img
						src="<%=(tk != null && tk.getAvatar() != null) ? tk.getAvatar() : ""%>"
						alt="User" class="avatar"> <i class="fa-solid fa-angle-down"
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

			<form action="${pageContext.request.contextPath}/TimPhong"
				method="GET" class="filter-container">

				<div class="filter-group">
					<label class="label">Khoảng giá (VNĐ)</label>
					<div class="input-range">
						<input type="number" name="giaMin" placeholder="Từ"
							class="filter-input" min="0"> <span class="dash">-</span>
						<input type="number" name="giaMax" placeholder="Đến"
							class="filter-input" min="0">
					</div>
				</div>

				<div class="filter-group">
					<label class="label">Diện tích (m²)</label>
					<div class="input-range">
						<input type="number" name="dtMin" placeholder="Từ"
							class="filter-input" min="0"> <span class="dash">-</span>
						<input type="number" name="dtMax" placeholder="Đến"
							class="filter-input" min="0">
					</div>
				</div>

				<button type="submit" class="btn-apply-all">Áp dụng bộ lọc</button>
			</form>

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
			Integer totalPage = (Integer) request.getAttribute("totalPage");
			Integer currentPage = (Integer) request.getAttribute("currentPage");

			if (totalPage != null && totalPage > 1) {
			%>
			<nav class="pagination-wrapper">
				<ul class="pagination-list">
					<%
					if (currentPage > 1) {
					%>
					<li><a href="?page=<%=currentPage - 1%>"
						class="pagi-item prev" title="Trang trước"> <i
							class="fa-solid fa-chevron-left"></i>
					</a></li>
					<%
					}
					%>

					<%
					
					int start = Math.max(1, currentPage - 2);
					int end = Math.min(totalPage, currentPage + 2);

					if (start > 1) {
					%>
					<li><a href="?page=1" class="pagi-item">1</a></li>
					<%
					if (start > 2) {
					%><li class="pagi-dots">...</li>
					<%
					}
					%>
					<%
					}
					%>

					<%
					for (int i = start; i <= end; i++) {
					%>
					<li><a href="?page=<%=i%>"
						class="pagi-item <%=(i == currentPage) ? "active" : ""%>"> <%=i%>
					</a></li>
					<%
					}
					%>

					<%
					if (end < totalPage) {
					%>
					<%
					if (end < totalPage - 1) {
					%><li class="pagi-dots">...</li>
					<%
					}
					%>
					<li><a href="?page=<%=totalPage%>" class="pagi-item"><%=totalPage%></a></li>
					<%
					}
					%>

					<%
					if (currentPage < totalPage) {
					%>
					<li><a href="?page=<%=currentPage + 1%>"
						class="pagi-item next" title="Trang tiếp"> <i
							class="fa-solid fa-chevron-right"></i>
					</a></li>
					<%
					}
					%>
				</ul>
				
			</nav>
			<%
			}
			%>





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