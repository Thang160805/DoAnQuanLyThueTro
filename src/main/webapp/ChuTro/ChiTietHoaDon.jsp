<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.HopDong"%>
<%@ page import="model.bean.HoaDon"%>
<%@ page import="utils.TimeHelper"%>
<%@ page import="utils.DateHelper"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết hóa đơn</title>
<!-- Google Fonts: Poppins (Hiện đại, tròn trịa giống Airbnb) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ChiTietHoaDon.css">
	<style>
	body {
	font-family: "Open Sans", sans-serif;
	background-color: #f8fafc;
	color: #1e293b;
	padding: 40px 0;
}
	
	</style>
</head>
<body>
	<div class="view-container">
		<div class="top-nav">
			<a href="${pageContext.request.contextPath}/QuanLyTro"
				class="btn-back"> <i class="fa-solid fa-arrow-left"></i> Quay
				lại danh sách
			</a>
		</div>
		<%
		HoaDon hd = (HoaDon) request.getAttribute("ChiTietHoaDon");
		%>
		<div class="card card-header-info">
			<div class="header-main">
				<div>
					<div class="label">Mã hóa đơn</div>
					<div class="invoice-id">
						#<%=hd.getId()%></div>
					</div>
					<div class="status-wrapper">
						<%
						String trangThai = hd.getTrangThai();
						String badgeClass = "";
						String label = "";

						if ("Chưa thanh toán".equals(trangThai)) {
							badgeClass = "badge-warning";
							label = "Chưa thanh toán";
						} else if ("Đã thanh toán".equals(trangThai)) {
							badgeClass = "badge-success";
							label = "Đã thanh toán";
						} else if ("Trễ hạn".equals(trangThai)) {
							badgeClass = "badge-danger";
							label = "Trễ hạn";
						}
						%>

						<span class="badge <%=badgeClass%>"> <span
							class="status-dot"></span> <%=label%>
						</span>
					</div>
				</div>
				<div class="header-grid">
					<div class="meta-item">
						<span class="label">Kỳ thanh toán</span> <span class="value"><%= hd.getThangNam() %></span>
					</div>
					<div class="meta-item">
						<span class="label">Hạn thanh toán</span> <span class="value"><%= DateHelper.formatVN(hd.getHanThanhToan()) %></span>
					</div>
					<div class="meta-item">
					<% DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/yyyy"); %>
						<span class="label">Ngày tạo hóa đơn</span> <span class="value"><%= hd.getCreated_at().format(format) %></span>
					</div>
				</div>
			</div>

			<div class="content-grid">
				<div class="card">
					<div class="section-title">
						<i class="fa-solid fa-house-user"></i> Thông tin đối tượng
					</div>
					<div class="info-row">
						<div class="info-group">
							<span class="label">Tên phòng</span> <span
								class="value fw-bold text-primary"><%= hd.getTenPhong() %></span>
						</div>
						<div class="info-group">
							<span class="label">Người thuê</span> <span class="value fw-bold"><%= hd.getTenNguoiThue() %></span>
						</div>
					</div>
					<div class="info-row">
						<div class="info-group">
							<span class="label">Địa chỉ phòng</span> <span class="value"><%= hd.getDiaChiPhong() %></span>
						</div>
						<div class="info-group">
						<%TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTin"); %>
							<span class="label">Chủ trọ</span> <span class="value"><%= tk.getHoTen() %></span>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="section-title">
						<i class="fa-solid fa-receipt"></i> Chi phí kỳ này
					</div>
					<div class="cost-table">
						<div class="cost-row">
							<div class="cost-desc">
								<span class="fw-bold">Tiền phòng</span> <small>Giá thuê
									phòng <%= hd.getThangNam() %></small>
							</div>
							<div class="cost-amount"><%= CurrencyHelper.format(hd.getTienPhong()) %> ₫</div>
						</div>

						<div class="cost-row">
							<div class="cost-desc">
								<span class="fw-bold">Tiền điện</span> <small>Số kWh:
									<%= hd.getTienDien()/hd.getGiaDien() %> • Đơn giá: <%= CurrencyHelper.format(hd.getGiaDien()) %> ₫/kWh</small>
							</div>
							<div class="cost-amount"><%= CurrencyHelper.format(hd.getTienDien()) %> ₫</div>
						</div>

						<div class="cost-row">
							<div class="cost-desc">
								<span class="fw-bold">Tiền nước</span> <small>Số m³: <%= hd.getTienNuoc()/hd.getGiaNuoc() %> •
									Đơn giá: <%= CurrencyHelper.format(hd.getGiaNuoc()) %> ₫/m³</small>
							</div>
							<div class="cost-amount"><%= CurrencyHelper.format(hd.getTienNuoc()) %> ₫</div>
						</div>

						<div class="total-section">
							<div class="total-label">TỔNG TIỀN THANH TOÁN</div>
							<div class="total-value"><%= CurrencyHelper.format(hd.getTongTien()) %> ₫</div>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="section-title">
						<i class="fa-solid fa-comment-dots"></i> Ghi chú hóa đơn
					</div>
					<% if(hd.getGhiChu()==null){
					%>
					<div class="note-box">Không có ghi chú</div>
					<%} else{ %>
					<div class="note-box"><%= hd.getGhiChu() %></div>
					<% } %>
					
				</div>
			</div>
		</div>
</body>
</html>