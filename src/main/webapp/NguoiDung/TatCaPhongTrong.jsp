<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.KhuVuc"%>
<%@ page import="utils.PageURL"%>
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
	href="${pageContext.request.contextPath}/assets/css/PhongTrong.css">

<style>
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
<% TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTinCaNhan");
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
				<li class="nav-item"><a href="${pageContext.request.contextPath}/TimPhong">Tìm phòng</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/PhongDaThue">Phòng đã thuê</a></li>
				<li class="nav-item"><a href="#">Lịch thanh toán</a></li>
				<li class="nav-item"><a href="${pageContext.request.contextPath}/HopDong">Hợp đồng</a></li>
			</ul>
		</nav>

		<div class="header-right">
			<div class="dropdown" onclick="toggleDropdown('notif-drop')">
				<div class="notification-icon">
					<i class="fa-regular fa-bell"></i> <% if (countTB > 0) { %>
    <span class="badge"><%= countTB %></span>
<% } %>
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
					<img
						src="<%= (tk != null && tk.getAvatar() != null) ? tk.getAvatar() : "" %>"
						alt="User" class="avatar"> <i class="fa-solid fa-angle-down"
						style="font-size: 0.8rem; color: #666;"></i>
				</div>
				<div class="dropdown-content" id="user-drop">
					<a href="${pageContext.request.contextPath}/ThongTinCaNhan" class="dropdown-item"><i class="fa-regular fa-user"
						style="width: 20px"></i> Thông tin cá nhân</a> <a href="${pageContext.request.contextPath}/CaiDat"
						class="dropdown-item"><i class="fa-solid fa-gear"
						style="width: 20px"></i> Cài đặt</a>
					<div class="dropdown-divider"></div>
					<a href="${pageContext.request.contextPath}/Logout" class="dropdown-item" style="color: #e74c3c;"><i
						class="fa-solid fa-right-from-bracket" style="width: 20px"></i>
						Đăng xuất</a>
				</div>
			</div>
		</div>
	</header>
	<!-- 2. MAIN CONTENT -->
	<div class="container">

		<div class="section-header">
			<h1 class="section-title">
				Phòng còn trống <span class="section-subtitle">(Sẵn sàng vào
					ở)</span>
			</h1>
		</div>

		<!-- BỘ LỌC DẠNG LINK (THẺ A) TRONG DROPDOWN -->
		<div class="filter-bar">
			<span style="font-weight: 600; color: #333; margin-right: 10px;"><i
				class="fa-solid fa-filter text-primary"></i> Lọc nhanh:</span>

			<!-- Filter: Mức giá -->
			<div class="dropdown">
				<button class="btn btn-filter dropdown-toggle" type="button"
					data-bs-toggle="dropdown" aria-expanded="false">Mức giá</button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?GiaThue=10000000">Dưới
							10 triệu</a></li>
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?GiaThue=7000000">Dưới
							7 triệu</a></li>
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?GiaThue=5000000">Dưới
							5 triệu</a></li>
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?GiaThue=3000000">Dưới
							3 triệu</a></li>
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?GiaThue=1000000">Dưới
							1 triệu</a></li>
				</ul>
			</div>

			<!-- Filter: Khu vực -->
			<div class="dropdown">
				<button class="btn btn-filter dropdown-toggle" type="button"
					data-bs-toggle="dropdown" aria-expanded="false">Khu vực</button>
				<%
				ArrayList<KhuVuc> list = (ArrayList<KhuVuc>) request.getAttribute("listKhucVuc");
				%>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?KhuVuc=all">Tất
							cả</a></li>
					<%
					for (KhuVuc kv : list) {
					%>
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?KhuVuc=<%= kv.getId()%>"><%=kv.getTenKhuVuc()%></a></li>
					<%
					}
					%>
				</ul>
			</div>

			<!-- Filter: Diện tích -->
			<div class="dropdown">
				<button class="btn btn-filter dropdown-toggle" type="button"
					data-bs-toggle="dropdown" aria-expanded="false">Diện tích
				</button>
				<ul class="dropdown-menu">
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?DienTich=50">Dưới
							50m²</a></li>
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?DienTich=35">Dưới
							35m²</a></li>
					<li><a class="dropdown-item"
						href="${pageContext.request.contextPath}/DanhSachPhongTrong?DienTich=20">Dưới
							20m²</a></li>
				</ul>
			</div>
			<%
			int totalCount = (int) request.getAttribute("totalCount");
			%>
			<div class="result-count ms-auto">
				Tìm thấy <strong><%=totalCount%></strong> phòng
			</div>
		</div>

		<!-- LƯỚI PHÒNG (GRID) -->
		<div class="room-grid">
			<%
			ArrayList<PhongTro> listPT = (ArrayList<PhongTro>) request.getAttribute("listPhongTrong");
			for (PhongTro pt : listPT) {
			%>
			<!-- Card 1 -->
			<div class="room-card">
				<div class="card-img-wrap">
					<span class="status-badge"><%=pt.getTrangThai()%></span> <img
						src="<%=pt.getAnhChinh()%>" class="card-img" alt="Room">
				</div>
				<div class="card-body">
					<h3 class="card-title"><%=pt.getTenPhong()%></h3>
					<div class="card-price"><%=CurrencyHelper.format(pt.getGiaThue())%>
						đ <span>/tháng</span>
					</div>
					<div class="card-info">
						<span><i class="fa-solid fa-ruler-combined"></i> <%=pt.getDienTich()%>m²</span>
					</div>
					<div class="card-address">
						<i class="fa-solid fa-location-dot"></i>
						<%=pt.getDiaChi()%>
					</div>
					<!-- Link này cũng là thẻ a -->
					<a href="${pageContext.request.contextPath}/ChiTietPhong_1?ID_Phong=<%= pt.getID_Phong() %>"
						class="btn-detail text-decoration-none">Xem chi tiết</a>
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

	</div>
	<%@ include file="../includes/footer.jsp" %>

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