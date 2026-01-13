<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.ThongBao"%>
<%@ page import="model.bean.HopDong"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="model.bean.TienIch"%>
<%@ page import="model.bo.TienIchBO"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Phòng đã thuê</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
<script src="https://unpkg.com/lucide@latest"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/PhongDaThue.css">
	<style>
	body {
	font-family: "Open Sans", sans-serif;
	background-color: #f5f5f5;
	color: #222222;
	line-height: 1.6;
}
	.dropdown-item{
	padding: 10px 20px;
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
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/ProcessHomeUser">Trang
						chủ</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/TimPhong">Tìm phòng</a></li>
				<li class="nav-item active"><a href="${pageContext.request.contextPath}/PhongDaThue">Phòng đã thuê</a></li>
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
	<main class="container">
        <section class="page-header">
            <h1>Phòng đã thuê</h1>
            <p>Danh sách các phòng bạn đã từng ở trước đây</p>
        </section>
        <% ArrayList<HopDong> listPT = (ArrayList<HopDong>) request.getAttribute("listPhongThue"); 
        if(listPT != null){
        %>
        <div class="room-grid">
            <%
            TienIchBO tiBO = new TienIchBO();
            for(HopDong hd : listPT){
            %>
            <div class="room-card">
                <div class="room-image">
                    <img src="<%= hd.getAnhPhong() %>" alt="Phòng trọ">
                </div>
                <div class="room-content">
                    <h3 class="room-name"><%= hd.getTenPhong() %></h3>
                    <p class="room-address"><i data-lucide="map-pin"></i> <%= hd.getDiaChi() %></p>
                    
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
                    <div class="amenities-tags">
                    <% ArrayList<TienIch> listTI = tiBO.getListTienIchByIDPhong(hd.getID_Phong());
                    for(TienIch ti : listTI){
                    	String name = ti.getTenTienIch();
						String icon = iconMap.getOrDefault(name, "fas fa-check");
                    %>
                        <span class="tag"><i class="<%=icon%>"></i> <%= name %></span>
                        <% } %>
                    </div>

                    <div class="cta-group">
                        <a href="${pageContext.request.contextPath}/ChiTietPhong_1?ID_Phong=<%= hd.getID_Phong() %>" class="btn btn-outline">Xem phòng</a>
                    </div>
                </div>
            </div>
            <%} %>
        </div>
        <%} else{ %>
        <div class="empty-state" style="display: none;">
            <img src="https://cdn-icons-png.flaticon.com/512/4076/4076432.png" alt="Empty">
            <h3>Bạn chưa từng thuê phòng nào</h3>
            <p>Khám phá hàng ngàn phòng trọ chất lượng trên FindRoom ngay!</p>
            <a href="${pageContext.request.contextPath}/TimPhong" class="btn btn-primary">Tìm phòng ngay</a>
            <%} %>
        </div>
    </main>
	<%@ include file="../includes/footer.jsp"%>
	<script>lucide.createIcons();</script>
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