<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.ThongBao"%>
<%@ page import="model.bean.BaoHong"%>
<%@ page import="model.bean.YeuCauThueTro"%>
<%@ page import="model.bean.HopDong"%>
<%@ page import="model.bean.HoaDon"%>
<%@ page import="utils.TimeHelper"%>
<%@ page import="utils.DateHelper"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Quản lý</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ChuTro.css">
<style>
body {
	margin: 0;
	font-family: "Open Sans", sans-serif;
	background: linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%);
	color: #1e293b;
	height: 100vh;
	overflow: hidden;
}

.room-grid-container {
	background: #ffffff;
	border-radius: 24px;
	box-shadow: 0 12px 35px -5px rgba(99, 102, 241, 0.1), 0 4px 12px -2px
		rgba(0, 0, 0, 0.05);
	overflow: hidden;
	display: flex;
	flex-direction: column;
	height: 540px;
}

.room-grid-header {
	display: grid;
	grid-template-columns: 2.5fr 1fr 1.5fr 160px;
	padding: 16px 24px;
	background: #f1f5f9;
	border-bottom: 1px solid #e2e8f0;
	font-size: 12px;
	font-weight: 700;
	text-transform: uppercase;
	color: #94a3b8;
	align-items: center;
	position: sticky;
	top: 0;
	z-index: 10;
}

.room-grid-body {
	overflow-y: auto;
	flex: 1;
	scrollbar-width: thin;
	scrollbar-color: #e2e8f0 transparent;
}

.room-grid-row {
	display: grid;
	grid-template-columns: 2.5fr 1fr 1.5fr 160px;
	padding: 16px 24px;
	border-bottom: 1px solid
		linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%);
	align-items: center;
	transition: background 0.2s;
	background: white;
	padding: 16px 24px;
}

.room-grid-row:hover {
	background: #f8fafc;
	transform: scale(1);
}

.col-right {
	text-align: right;
	justify-content: flex-end;
	display: flex;
}

.col-center {
	text-align: center;
	justify-content: center;
	display: flex;
}

.tenant-cols {
	display: grid;
	grid-template-columns: 2fr 0.8fr 1.5fr 1fr 1.2fr 120px;
	align-items: center;
}

.request-cols {
	display: grid;
	grid-template-columns: 2fr 1.2fr 1.2fr 1fr 1fr 120px;
	align-items: center;
}

.incident-cols {
	display: grid;
	grid-template-columns: 0.8fr 2.5fr 1.2fr 1fr 1.2fr 120px;
	align-items: center;
}

.truncate-150 {
	display: block;
	width: 150px;
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis; 
}

.modal-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.4);
	display: none;
	justify-content: center;
	align-items: center;
}

.modal-overlay.active {
	display: flex;
}

.modal-box {
	background: white;
	padding: 20px 28px;
	border-radius: 12px;
	box-shadow: 0 8px 25px rgba(0, 0, 0, 0.2);
}

.btn-error {
	background: #ef4444;
	color: white;
}

.contract-cols {
	display: grid;
	grid-template-columns: 1fr 0.8fr 1.5fr 1.5fr 1fr 120px;
	align-items: center;
}

.status-badgee {
	display: inline-block;
	padding: 8px 24px; 
	border-radius: 50px; 
	font-family: sans-serif; 
	font-size: 14px; 
	font-weight: 800; 
	text-align: center;
	border: 1px solid #FFEBB7; 
}

.badge-waiting {
	background-color: #FFF8E1;
	color: #E67E22; 
}

.header-actions a[title="Tin nhắn"] .notification-dot {
	background: #6366f1;
}

.header-actions {
	display: flex;
	align-items: center;
	gap: 12px; 
}

.badge-warn {
	background: #fef3c7;
	color: #92400e;
}

.badge-process {
	background: #e0f2fe;
	color: #2563eb;
}

.badge-low {
	background: #dcfce7;
	color: #166534;
}

.badge-medium {
	background: #fef3c7;
	color: #92400e;
}

.badge-high {
	background: #ffedd5;
	color: #c2410c;
}

.badge-urgent {
	background: #fee2e2;
	color: #dc2626;
}

.badge-low .status-dot {
	background: #166534;
}

.badge-medium .status-dot {
	background: #92400e;
}

.badge-high .status-dot {
	background: #c2410c;
}

.badge-urgent .status-dot {
	background: #dc2626;
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
	<div class="app-container">

		<aside class="sidebar">
			<a class="navbar-brand" href="#"> <i
				class="fa-solid fa-house-chimney"></i> FindRoom
			</a>

			<nav class="nav-menu">
				<div class="nav-item active" onclick="navTo('dashboard', this)">
					<i class="fa-solid fa-layer-group"></i> Tổng quan
				</div>
				<div class="nav-item" onclick="navTo('rooms', this)">
					<i class="fa-solid fa-door-open"></i> Quản lý phòng
				</div>
				<div class="nav-item" onclick="navTo('tenants', this)">
					<i class="fa-solid fa-users"></i> Quản lý người thuê
				</div>
				<div class="nav-item" onclick="navTo('requests', this)">
					<i class="fa-solid fa-user-clock"></i> Yêu cầu thuê
					<%
					int countYC = (int) request.getAttribute("countYC");
					if (countYC != 0) {
					%>
					<span
						style="margin-left: auto; background: linear-gradient(135deg, #ef4444, #f43f5e); color: white; font-size: 11px; font-weight: 700; padding: 4px 8px; border-radius: 8px; box-shadow: var(--shadow-primary);"><%=countYC%></span>
					<%
					}
					%>
				</div>
				<div class="nav-item" onclick="navTo('incidents', this)">
					<i class="fa-solid fa-screwdriver-wrench"></i> Sự cố & Sửa chữa
				</div>
				<div class="nav-item" onclick="navTo('contracts', this)">
					<i class="fa-solid fa-file-contract"></i> Quản lý hợp đồng
				</div>
				<div class="nav-item" onclick="navTo('invoices', this)">
					<i class="fa-solid fa-file-invoice-dollar"></i> Quản lý hóa đơn
				</div>
				<div class="nav-item" onclick="navTo('notify', this)">
					<i class="fa-solid fa-paper-plane"></i> Gửi thông báo
				</div>
			</nav>
			<%
			TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTinCaNhan");
			%>
			<a href="${pageContext.request.contextPath}/CaiDatCT"
				class="user-profile"> <img
				src="<%=(tk != null && tk.getAvatar() != null) ? tk.getAvatar() : ""%>"
				alt="Avatar" class="user-avatar">
				<div class="user-info">
					<h4 style="font-size: 14px;"><%=(tk != null && tk.getHoTen() != null) ? tk.getHoTen() : ""%></h4>
					<span style="font-size: 12px;">Chủ trọ • Premium</span>
				</div> <i class="fa-solid fa-chevron-right"
				style="margin-left: auto; font-size: 12px; color: #94a3b8;"></i>
			</a>
		</aside>

		<main>
			<header class="header">
				<div class="page-title">
					<h2 id="page-heading">Tổng quan</h2>
					<p id="page-sub">Chào mừng trở lại, hôm nay có gì mới?</p>
				</div>

				<div class="header-actions">

					<a href="${pageContext.request.contextPath}/Chat" class="icon-btn"
						title="Tin nhắn"> <i class="fa-regular fa-comment-dots"></i>
						<div class="notification-dot" style="background: #6366f1;"></div>
					</a> <a href="${pageContext.request.contextPath}/DanhSachThongBao"
						class="icon-btn"> <i class="fa-regular fa-bell"></i>
						<div class="notification-dot"></div>
					</a> <a href="${pageContext.request.contextPath}/Logout"
						class="btn btn-logout"> Đăng xuất</a>
				</div>
			</header>

			<div class="main-content">
				<%
				int countSoPhong = (int) request.getAttribute("countSoPhong");
				int countPhongTrong = (int) request.getAttribute("countPhongTrong");
				int countPhongDaThue = (int) request.getAttribute("countPhongDaThue");
				int DoanhThu = (int) request.getAttribute("DoanhThu");
				%>
				<div id="dashboard" class="section active">
					<div class="stats-grid">
						<div class="stat-card">
							<div class="stat-icon stat-primary">
								<i class="fa-solid fa-building-user"></i>
							</div>
							<div class="stat-value"><%=(countSoPhong != -1) ? countSoPhong : ""%></div>
							<div class="stat-label">Tổng số phòng</div>
						</div>
						<div class="stat-card">
							<div class="stat-icon stat-busy">
								<i class="fa-solid fa-check-double"></i>
							</div>
							<div class="stat-value"><%=(countPhongDaThue != -1) ? countPhongDaThue : ""%></div>
							<div class="stat-label" style="color: #6366f1">Đang thuê</div>
						</div>
						<div class="stat-card">
							<div class="stat-icon stat-success">
								<i class="fa-solid fa-key"></i>
							</div>
							<div class="stat-value"><%=(countPhongTrong != -1) ? countPhongTrong : ""%></div>
							<div class="stat-label" style="color: #15803d">Phòng trống</div>
						</div>
						<div class="stat-card">
							<div class="stat-icon stat-warning">
								<i class="fa-solid fa-sack-dollar"></i>
							</div>
							<div class="stat-value"><%= CurrencyHelper.format(DoanhThu) %> VNĐ</div>
							<div class="stat-label" style="color: #b45309">Doanh thu
								</div>
						</div>
					</div>
				</div>

				<div id="rooms" class="section">

					<div
						style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
						<div class="table-title">Danh sách phòng</div>
						<a href="${pageContext.request.contextPath}/ThemPhongTro"
							class="btn btn-primary"> <i class="fa-solid fa-plus"></i>
							Thêm phòng
						</a>
					</div>
					<%
					ArrayList<PhongTro> listPT = (ArrayList<PhongTro>) request.getAttribute("listPT");

					if (listPT == null || listPT.isEmpty()) {
					%>

					<div
						style="padding: 40px; text-align: center; width: 100%; grid-column: span 5; color: #64748b;">

						<i class="fa-solid fa-circle-info"
							style="font-size: 36px; margin-bottom: 12px; color: #94a3b8;"></i>

						<div
							style="font-size: 18px; font-weight: 600; margin-bottom: 6px;">
							Chưa có phòng nào trong hệ thống</div>
						<div style="font-size: 14px; margin-bottom: 16px;">Hãy thêm
							phòng mới để bắt đầu quản lý trọ.</div>


					</div>
					<%
					} else {
					%>
					<div class="room-grid-container">

						<!-- HEADER -->
						<div class="room-grid-header">
							<div>Phòng</div>
							<div>Giá thuê cơ bản</div>
							<div>Trạng thái</div>
							<div class="col-right">Hành động</div>
						</div>

						<div class="room-grid-body">



							<%
							for (PhongTro pt : listPT) {
								String status = pt.getTrangThai();
								String badgeClass = "";

								switch (status) {
									case "Còn trống" :
								badgeClass = "badge-success";
								break;
									case "Đang thuê" :
								badgeClass = "badge-busy";
								break;
									case "Đang sửa chữa" :
								badgeClass = "badge-error";
								break;
									default :
								badgeClass = "badge-warn";
								}
							%>

							<div class="room-grid-row">

								<div>
									<div class="user-cell">
										<img src="<%=pt.getAnhChinh()%>" class="table-avatar"
											style="border-radius: 8px;">
										<div>
											<div
												style="font-weight: 700; color: #1e293b; font-size: 15px;">
												<%=pt.getTenPhong()%>
											</div>
										</div>
									</div>
								</div>

								<div style="font-weight: 700;">
									<%=CurrencyHelper.format(pt.getGiaThue())%>
									₫
								</div>



								<div>
									<span class="status-badge <%=badgeClass%>"> <span
										class="status-dot"></span><%=status%>
									</span>
								</div>

								<div class="col-right">
									<div class="action-group">

										<%
										if (!status.equals("Còn trống")) {
										%>
										<button class="btn btn-primary btn-sm"
											onclick="openBillModal('<%=pt.getTenPhong()%>', '<%=pt.getTenCT()%>', <%=pt.getGiaThue()%>)"
											style="background: #6366f1; box-shadow: none; padding: 8px 12px;">
											<i class="fa-solid fa-file-invoice-dollar"></i>
										</button>
										<div class="vertical-divider"></div>
										<%
										}
										%>

										<a
											href="${pageContext.request.contextPath}/SuaPhongTro?ID_Phong=<%= pt.getID_Phong() %>"
											class="btn-action btn-edit" title="Sửa"> <i
											class="fa-solid fa-pen"></i>
										</a>

										<button class="btn-action btn-delete"
											data-id="<%=pt.getID_Phong()%>" data-status="<%=status%>">
											<i class="fa-solid fa-trash"></i>
										</button>

									</div>
								</div>

							</div>

							<%
							}
							%>

						</div>
					</div>
					<%
					}
					%>
				</div>


				<div id="tenants" class="section">

					<div
						style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
						<div class="table-title">Danh sách người thuê trọ</div>

						<form action="QuanLyTro" method="GET"
							style="display: flex; gap: 12px;">
							<button class="btn btn-outline" style="padding: 10px 16px;">
								<i class="fa-solid fa-filter"></i> Lọc
							</button>
							<div class="form-input"
								style="padding: 8px 12px; display: flex; align-items: center; gap: 8px; width: 250px;">
								<i class="fa-solid fa-magnifying-glass"
									style="color: var(--text-light)"></i> <input type="text"
									name="TenNguoiThue" placeholder="Tìm theo tên người thuê..."
									style="border: none; outline: none; background: transparent; width: 100%;">
							</div>
						</form>
					</div>
					<%
					ArrayList<HopDong> listHDNT = (ArrayList<HopDong>) request.getAttribute("listHDNT");
					%>

					<%
					if (listHDNT == null || listHDNT.isEmpty()) {
					%>

					<!-- ===== EMPTY STATE ===== -->
					<div style="padding: 40px; text-align: center; color: #64748b;">
						<i class="fa-solid fa-users-slash"
							style="font-size: 36px; margin-bottom: 12px; color: #94a3b8;"></i>
						<div style="font-size: 18px; font-weight: 600;">Chưa có
							người thuê nào</div>
						<div style="font-size: 14px; margin-top: 6px;">Hiện tại chưa
							có hợp đồng thuê đang hiệu lực.</div>
					</div>

					<%
					} else {
					%>

					<div class="room-grid-container">

						<!-- HEADER -->
						<div class="room-grid-header tenant-cols">
							<div>Cư dân</div>
							<div>Phòng</div>
							<div>Liên hệ</div>
							<div>Ngày bắt đầu HĐ</div>
							<div>Trạng thái</div>
							<div class="col-right">Thao tác</div>
						</div>

						<div class="room-grid-body">

							<%
							for (HopDong hd : listHDNT) {
							%>

							<div class="room-grid-row tenant-cols">

								<div>
									<div class="user-cell">
										<img
											src="<%=hd.getAvatar()%>"
											class="table-avatar">
										<div>
											<div style="font-weight: 700;"><%=hd.getTenNguoiThue()%></div>
										</div>
									</div>
								</div>

								<div>
									<span style="font-weight: 700; color: #6366f1;">
										<%=hd.getTenPhong()%>
									</span>
								</div>

								<!-- Liên hệ -->
								<div style="font-size: 13px;">
									<%=hd.getSDT() != null ? hd.getSDT() : "—"%>
								</div>

								<!-- Ngày bắt đầu -->
								<div style="font-size: 13px;">
									<%=utils.DateHelper.formatVN(hd.getNgayBatDau())%>
								</div>
								<div>
									<span class="status-badge badge-success"> <span
										class="status-dot"></span>Đang thuê
									</span>
								</div>

								<div class="col-right">
									<div class="action-group">
										<a
											href="<%=request.getContextPath()%>/ChiTietHopDong?id=<%=hd.getId()%>&ID_NguoiThue=<%= hd.getID_NguoiThue() %>
											&ID_ChuTro=<%=hd.getID_ChuTro() %>&ID_Phong=<%= hd.getID_Phong() %>"
											class="btn-icon-plain" title="Xem hợp đồng"> <i
											class="fa-solid fa-file-contract"></i>
										</a>
									</div>
								</div>

							</div>

							<%
							}
							%>

						</div>
					</div>

					<%
					}
					%>
				</div>

				<div id="requests" class="section">
					<div
						style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
						<div class="table-title">Danh sách yêu cầu thuê</div>

						<div style="display: flex; gap: 12px;">
							<select class="form-input"
								style="padding: 8px 12px; width: auto;">
								<option>Tất cả trạng thái</option>
								<option>Chờ duyệt</option>
								<option>Đã liên hệ</option>
							</select>
						</div>
					</div>
					<%
					ArrayList<YeuCauThueTro> listYC = (ArrayList<YeuCauThueTro>) request.getAttribute("listYeuCau");
					if (listYC == null || listYC.size() == 0) {
					%>

					<div
						style="padding: 20px; text-align: center; color: #6b7280; font-size: 15px;">
						<i class="fa-regular fa-circle-xmark"></i> Chưa có yêu cầu thuê
						nào
					</div>
					<%
					} else {
					%>
					<div class="room-grid-container">

						<div class="room-grid-header request-cols">
							<div>Người gửi yêu cầu</div>
							<div>Phòng quan tâm</div>
							<div>Thông tin liên hệ</div>
							<div>Ngày gửi</div>
							<div>Trạng thái</div>
							<div class="col-right">Thao tác</div>
						</div>

						<div class="room-grid-body">
							<%
							for (YeuCauThueTro yc : listYC) {
								String status = yc.getTrangThai();
								String badgeClass = "";

								switch (status) {
									case "Chờ duyệt" :
								badgeClass = "badge-warn";
								break;
									case "Đã liên hệ" :
								badgeClass = "badge-success";
								break;
									case "Đã hủy" :
								badgeClass = "badge-error";
								break;
									default :
								badgeClass = "badge-warn";
								}
							%>
							<div class="room-grid-row request-cols">
								<div>
									<div class="user-cell">
										<img
											src="<%=(yc != null && yc.getAvatar() != null) ? yc.getAvatar() : ""%>"
											class="table-avatar">
										<div>
											<div style="font-weight: 700;"><%=(yc != null && yc.getHoTen() != null) ? yc.getHoTen() : ""%></div>
										</div>
									</div>
								</div>
								<div>
									<span class="truncate-150"
										style="font-weight: 700; color: #6366f1;"><%=(yc != null && yc.getTenPhong() != null) ? yc.getTenPhong() : ""%></span>
								</div>
								<div><%=(yc != null && yc.getSDT() != null) ? yc.getSDT() : ""%></div>
								<div style="color: #64748b;"><%=(yc != null && yc.getCreate_at() != null) ? TimeHelper.timeAgo(yc.getCreate_at()) : ""%></div>
								<div>
									<span class="status-badge <%=badgeClass%>"><span
										class="status-dot"></span><%=status%></span>
								</div>
								<div class="col-right">
									<a
										href="${pageContext.request.contextPath}/ChiTietYeuCauThue?id=<%= yc.getId() %>"
										class="btn btn-outline btn-sm">Xem chi tiết</a>
								</div>
							</div>
							<%
							}
							%>

						</div>
					</div>
					<%
					}
					%>
				</div>

				<div id="incidents" class="section">

					<div
						style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
						<div class="table-title">Sự cố cần xử lý</div>
					</div>
					<%
					ArrayList<BaoHong> listBH = (ArrayList<BaoHong>) request.getAttribute("listBH");
					%>
					<%
					if (listBH == null || listBH.isEmpty()) {
					%>

					<!-- KHÔNG CÓ BÁO HỎNG -->
					<div
						style="text-align: center; padding: 40px; color: #6b7280; font-size: 15px; background: #f9fafb; border-radius: 12px; border: 1px dashed #e5e7eb;">
						Chưa có sự cố nào cần xử lý</div>

					<%
					} else {
					%>
					<div class="room-grid-container">

						<div class="room-grid-header incident-cols">
							<div>Phòng</div>
							<div>Vấn đề & Hình ảnh</div>
							<div>Người báo cáo</div>
							<div>Mức độ</div>
							<div>Trạng thái</div>
							<div class="col-right">Hành động</div>
						</div>

						<div class="room-grid-body">
							<%
							for (BaoHong bh : listBH) {
							%>
							<div class="room-grid-row incident-cols">
								<div>
									<div
										style="font-weight: 700; font-size: 16px; color: var(--text-main)"><%=bh.getTenPhong()%></div>
								</div>

								<div>
									<%
									Map<String, String> iconMap = new HashMap<>();
									iconMap.put("Điện", "fa-solid fa-bolt");
									iconMap.put("Nước", "fa-solid fa-faucet-drip");
									iconMap.put("Nội thất", "fa-solid fa-chair");
									iconMap.put("Kết cấu", "fa-solid fa-border-all");
									iconMap.put("Khác", "fa-solid fa-ellipsis");
									%>
									<%
									Map<String, String> bgMap = new HashMap<>();
									bgMap.put("Điện", "#fef9c3|#a16207");
									bgMap.put("Nước", "#eff6ff|#2563eb");
									bgMap.put("Nội thất", "#dcfce7|#16a34a");
									bgMap.put("Kết cấu", "#ede9fe|#7c3aed");
									bgMap.put("Khác", "#f3f4f6|#374151");
									DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
									%>
									<%
									String loai = bh.getLoaiHuHong();

									// icon
									String iconClass = iconMap.getOrDefault(loai, "fa-solid fa-ellipsis");

									// màu nền | màu icon
									String mau = bgMap.getOrDefault(loai, "#f3f4f6|#374151");
									String[] colors = mau.split("\\|");
									String bgColor = colors[0];
									String iconColor = colors[1];
									%>

									<div class="user-cell">
										<div
											style="width: 40px;height: 40px;background: <%=bgColor%>;color: <%=iconColor%>;border-radius: 10px;
                                          display: flex;align-items: center;justify-content: center;font-size: 18px;">
											<i class="<%=iconClass%>"></i>
										</div>

										<div>
											<div style="font-weight: 600">
												<%=bh.getTieuDe()%>
											</div>
											<div style="font-size: 12px; color: var(--text-secondary)">
												<%=bh.getThoiGianGui().format(formatter)%>
											</div>
										</div>
									</div>
								</div>

								<div>
									<div class="user-cell">
										<img src="<%=bh.getAvatar()%>" class="table-avatar"
											style="width: 30px; height: 30px;"> <span
											style="font-size: 13px; font-weight: 600"><%=bh.getTenNguoiGui()%></span>
									</div>
								</div>
								<%
								String mucDo = bh.getMucDoUuTien();
								String mucDoClass = "";

								if ("Thấp".equals(mucDo)) {
									mucDoClass = "badge-low";
								} else if ("Trung bình".equals(mucDo)) {
									mucDoClass = "badge-medium";
								} else if ("Cao".equals(mucDo)) {
									mucDoClass = "badge-high";
								} else if ("Khẩn cấp".equals(mucDo)) {
									mucDoClass = "badge-urgent";
								}
								%>

								<div>
									<span class="status-badge <%=mucDoClass%>"><span
										class="status-dot"></span> <%=mucDo%> </span>
								</div>
								<%
								String trangThai = bh.getTrangThai();
								String trangThaiText = "";
								String trangThaiClass = "";

								if ("Chưa xử lý".equals(trangThai)) {
									trangThaiText = "Chưa xử lý";
									trangThaiClass = "badge-warn";
								} else if ("Đang xử lý".equals(trangThai)) {
									trangThaiText = "Đang xử lý";
									trangThaiClass = "badge-process";
								}
								%>
								<div>
									<span class="status-badge <%=trangThaiClass%>"> <span
										class="status-dot"></span> <%=trangThaiText%>
									</span>
								</div>

								<div class="col-right">
									<a href="ChiTietBaoHong?id=<%=bh.getId()%>"
										class="btn btn-primary"
										style="padding: 8px 16px; font-size: 13px; text-decoration: none;">
										<i class="fa-solid fa-screwdriver-wrench"></i> Xử lý
									</a>
								</div>
							</div>

							<%
							}
							%>

						</div>
					</div>
					<%
					}
					%>
				</div>

				<div id="contracts" class="section">
					<div
						style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
						<div class="table-title">Danh sách hợp đồng</div>
						<div style="display: flex; gap: 12px;">
							<select class="form-input"
								style="padding: 8px 12px; width: auto;">
								<option>Tất cả trạng thái</option>
								<option>Đang hiệu lực</option>
								<option>Sắp hết hạn</option>
								<option>Đã kết thúc</option>
							</select>
						</div>
					</div>
					<%
					ArrayList<HopDong> listHD = (ArrayList<HopDong>) request.getAttribute("listHD");
					if (listHD == null || listHD.isEmpty()) {
					%>

					<div
						style="padding: 20px; text-align: center; color: #6b7280; font-size: 15px;">
						<i class="fa-regular fa-circle-xmark"></i> Chưa có hợp đồng nào
					</div>

					<%
					} else {
					%>

					<div class="room-grid-container">
						<div class="room-grid-header contract-cols">
							<div>Mã HĐ</div>
							<div>Phòng</div>
							<div>Người thuê</div>
							<div>Thời hạn thuê</div>
							<div>Trạng thái</div>
							<div class="col-right">Hành động</div>
						</div>

						<div class="room-grid-body">
							<%
							for (HopDong hd : listHD) {
							%>

							<div class="room-grid-row contract-cols">
								<div>
									<span style="font-weight: 700; color: #64748b;">
										HD-2025/<%=hd.getId()%>
									</span>
								</div>

								<div>
									<span style="font-weight: 700; color: #6366f1;"> <%=hd.getTenPhong()%>
									</span>
								</div>

								<div>
									<div style="font-weight: 600;">
										<%=hd.getTenNguoiThue()%>
									</div>
								</div>

								<div style="font-size: 13px; color: #64748b;">
									<%=DateHelper.formatVN(hd.getNgayBatDau())%>
									-
									<%=DateHelper.formatVN(hd.getNgayKetThuc())%>
								</div>

								<div>
									<%
									if ("Đang hiệu lực".equals(hd.getTrangThai())) {
									%>
									<span class="status-badge badge-success"> <span
										class="status-dot"></span>Hiệu lực
									</span>
									<%
									} else if ("Chờ tạo hợp đồng".equals(hd.getTrangThai())) {
									%>
									<span class="status-badgee badge-waiting"> Chờ tạo </span>
									<%
									} else {
									%>
									<span class="status-badge badge-error"> <span
										class="status-dot"></span>Hết hạn
									</span>
									<%
									}
									%>
								</div>

								<%
								if ((hd != null && "Đang hiệu lực".equals(hd.getTrangThai())) || "Đã kết thúc".equals(hd.getTrangThai())) {
								%>
								<div class="col-right">
									<a
										href="${pageContext.request.contextPath}/ChiTietHopDong?id=<%=hd.getId()%>&ID_NguoiThue=<%= hd.getID_NguoiThue() %>&ID_ChuTro=<%=hd.getID_ChuTro() %>&ID_Phong=<%=hd.getID_Phong() %>"
										class="btn btn-outline btn-sm" title="Xem chi tiết hợp đồng">
										<i class="fa-regular fa-eye"></i> Xem
									</a>
								</div>
								<%
								} else if (hd != null && "Chờ tạo hợp đồng".equals(hd.getTrangThai())) {
								%>
								<div class="col-right">
									<a
										href="${pageContext.request.contextPath}/TaoHopDong?id=<%= hd.getId() %>&idYeuCau=<%=hd.getID_YeuCau()%>&ID_NguoiThue=<%= hd.getID_NguoiThue() %>&ID_ChuTro=<%=hd.getID_ChuTro() %>&ID_Phong=<%=hd.getID_Phong() %>"
										class="btn btn-outline btn-sm" title="Tạo hợp đồng"> <i
										class="fa-regular fa-eye"></i> Tạo hợp đồng
									</a>
								</div>
								<%
								}
								%>
							</div>
							<%
							}
							%>
						</div>
					</div>

					<%
					}
					%>



				</div>
			</div>
			<div id="invoices" class="section">
				<div
					style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px; padding: 0 30px;">
					<div class="table-title">Lịch sử hóa đơn</div>
					<div style="display: flex; gap: 12px;">
						<form method="get" action="QuanLyTro">
							<div class="form-input"
								style="display: flex; align-items: center; padding: 5px 15px; background: white;">
								<i class="fa-regular fa-calendar-days"
									style="color: #64748b; margin-right: 8px;"></i> <select
									id="filterMonth" class="form-select" name="ThangNam"
									onchange="this.form.submit()"
									style="border: none; font-size: 14px; font-weight: 600;">
									<option value="">Vui lòng chọn tháng</option>
									<option value="2026-01">Tháng 01/2026</option>
									<option value="2025-12">Tháng 12/2025</option>
									<option value="2025-11">Tháng 11/2025</option>
									<option value="2025-10">Tháng 10/2025</option>
								</select>
							</div>
						</form>

						<a href="${pageContext.request.contextPath}/TaoHoaDon"
							class="btn btn-primary"
							style="box-shadow: 0 4px 12px rgba(99, 102, 241, 0.3);"> <i
							class="fa-solid fa-plus"></i> Tạo hóa đơn mới
						</a>
					</div>
				</div>
				<%
				ArrayList<HoaDon> listHoaDon = (ArrayList<HoaDon>) request.getAttribute("listHoaDon");
				%>
				<%
				if (listHoaDon == null || listHoaDon.isEmpty()) {
				%>
				<div
					style="height: 300px; margin: 0 20px; display: flex; align-items: center; justify-content: center; background: #f9fafb; border-radius: 16px; border: 1px dashed #e5e7eb; color: #6b7280; font-size: 15px; font-weight: 500;">
					<i class="fa-regular fa-file-lines"
						style="font-size: 28px; margin-right: 12px;"></i> Chưa có hóa đơn
					nào
				</div>

				<%
				} else {
				%>
				<div class="room-grid-container"
					style="height: 475px; margin: 0 20px;">

					<div class="room-grid-header"
						style="grid-template-columns: 1fr 1.5fr 1fr 1fr 1.2fr 100px;">
						<div>Phòng</div>
						<div>Người thuê</div>
						<div>Kỳ thanh toán</div>
						<div>Tổng tiền</div>
						<div>Trạng thái</div>
						<div class="col-right">Xem</div>
					</div>

					<div class="room-grid-body">
						<%
						for (HoaDon hd : listHoaDon) {
							String trangThai = hd.getTrangThai();
							String badgeClass = "";

							if ("Đã thanh toán".equals(trangThai)) {
								badgeClass = "badge-success";
							} else if ("Chưa thanh toán".equals(trangThai)) {
								badgeClass = "badge-warn";
							} else if ("Trễ hạn".equals(trangThai)) {
								badgeClass = "badge-error";
							}
						%>

						<div class="room-grid-row"
							style="grid-template-columns: 1fr 1.5fr 1fr 1fr 1.2fr 100px;">

							<div style="font-weight: 700; color: #6366f1;">
								<%=hd.getTenPhong()%>
							</div>

							<div style="font-weight: 600;">
								<%=hd.getTenNguoiThue()%>
							</div>

							<div style="color: #64748b;">
								<%=hd.getThangNam()%>
							</div>

							<div style="font-weight: 700; color: #1e293b;">
								<%=utils.CurrencyHelper.format(hd.getTongTien())%>
								₫
							</div>

							<div>
								<span class="status-badge <%=badgeClass%>"> <span
									class="status-dot"></span> <%=trangThai%>
								</span>
							</div>

							<div class="col-right">
								<a href="ChiTietHoaDon?id=<%=hd.getId()%>"
									class="btn-icon-plain" title="Chi tiết"> <i
									class="fa-regular fa-eye"></i>
								</a>
							</div>

						</div>

						<%
						}
						%>
					</div>
				</div>

				<%
				}
				%>
			</div>
			<div id="notify" class="section">
				<%
				ArrayList<HopDong> listNT = (ArrayList<HopDong>) request.getAttribute("listNT");
				%>
				<form id="sendNotifyForm">
					<div id="notify" class="table-container"
						style="max-width: 600px; margin: 0 auto;">
						<div class="table-title" style="margin-bottom: 20px;">Soạn
							thông báo mới</div>
						<div class="form-group">
							<label class="form-label">Tiêu đề</label> <input
								class="form-input" name="tieuDe"
								placeholder="Ví dụ: Thông báo thu tiền điện tháng 12">
						</div>

						<div class="form-group">
							<label class="form-label">Gửi tới</label> <select
								class="form-input" name="ID_NguoiThue">
								<option value="All">Tất cả người thuê</option>
								<%
								for (HopDong hdNT : listNT) {
								%>
								<option value="<%=hdNT.getID_NguoiThue()%>">
									<%=hdNT.getTenNguoiThue()%>
								</option>
								<%
								}
								%>
							</select>
						</div>

						<div class="form-group">
							<label class="form-label">Nội dung</label>
							<textarea class="form-input" name="noiDung" rows="5"
								placeholder="Nhập nội dung..."></textarea>
						</div>

						<button type="submit" class="btn btn-primary">
							<i class="fa-solid fa-paper-plane"></i> Gửi ngay
						</button>
					</div>
				</form>
			</div>
		</main>
	</div>



	<div id="deleteModal" class="modal-overlay">
		<div class="modal-box" style="max-width: 350px; text-align: center;">
			<h3>Xoá phòng?</h3>
			<p>Bạn có chắc chắn muốn xoá phòng này không?</p>
			<input type="hidden" id="deleteRoomId" name="id"> <input
				type="hidden" id="roomStatus" name="status">

			<div style="display: flex; justify-content: center; gap: 12px;">
				<button onclick="closeDeleteModal()" class="btn btn-outline">Hủy</button>
				<button onclick="confirmDeleteRoom()" class="btn btn-error">Có</button>
			</div>
		</div>
	</div>
	<div id="toast"
		style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

	<script>
    function navTo(id, el) {
        document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
        document.getElementById(id).classList.add('active');
        document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
        el.classList.add('active');
        
        const titles = {
            'dashboard': 'Tổng quan', 'rooms': 'Quản lý phòng', 'tenants': 'Danh sách người thuê',
            'requests': 'Yêu cầu thuê', 'incidents': 'Sự cố & Sửa chữa','contracts': 'Quản lý hợp đồng', 'notify': 'Gửi thông báo','invoices': 'Quản lý hóa đơn'
        };
        document.getElementById('page-heading').innerText = titles[id];
    }
    function openModal(id) { document.getElementById(id).classList.add('active'); }
    function closeModal(id) { document.getElementById(id).classList.remove('active'); }
    

    function showToast(message, type = "success") {
	    const toast = $("#toast");
	    let iconHTML = "";

	    if (type === "error") {
	        toast.css("background-color", "#dc2626");
	        iconHTML = `<i class="fa-solid fa-circle-xmark" style="color:#fecaca; margin-right:8px;"></i>`;
	    } else {
	        toast.css("background-color", "#2563eb");
	        iconHTML = `<i class="fa-solid fa-circle-check" style="color:#4ade80; margin-right:8px;"></i>`;
	    }
	    toast.html(iconHTML + message);
	    toast.css({ opacity: "1", transform: "translateY(0)" });
	    setTimeout(() => {
	        toast.css({ opacity: "0", transform: "translateY(20px)" });
	    }, 5000);
	}
    $(document).on("click", ".btn-delete", function () {
        let roomId = $(this).data("id");
        let status = $(this).data("status");

        console.log("Clicked delete:", roomId, status);

        openDeleteModal(roomId, status);
    });

    
    function openDeleteModal(roomId, status) {
        console.log("Delete ID:", roomId, "Status:", status);

        $("#deleteRoomId").val(roomId);

        $("#roomStatus").val(status);

        $("#deleteModal").addClass("active");
    }

function closeDeleteModal() {
    $("#deleteModal").removeClass("active");
}


function confirmDeleteRoom() {
    let roomId = $("#deleteRoomId").val();
    let status = $("#roomStatus").val();

    $.ajax({
        url: "/DoAnQLThueTro/XoaPhongTro",
        method: "POST",
        data: { 
            id: roomId,
            status: status 
        },
        dataType: "json",
        success: function (response) {
            let result = typeof response === "string" ? JSON.parse(response) : response;

            if (result.success) {
                showToast("Xoá phòng thành công!", "success");
                setTimeout(() => location.reload(), 1200);
            } else {
                showToast(result.message || "Không thể xoá phòng!", "error");
            }
        },
        error: function () {
            showToast("Lỗi server!", "error");
        }
    });

    closeDeleteModal();
}

$(document).ready(function () {
    $("#sendNotifyForm").on("submit", function (e) {
        e.preventDefault();

        $.ajax({
            url: "/DoAnQLThueTro/XuLyGuiThongBao",
            type: "post",
            data: {
                tieuDe: $("input[name='tieuDe']").val(),
                ID_NguoiThue: $("select[name='ID_NguoiThue']").val(),
                noiDung: $("textarea[name='noiDung']").val()
            },
            success: function (response) {
                if (response.status === "success") {
                    showToast("Gửi thông báo thành công!");
                    $("#sendNotifyForm")[0].reset();
                } else {
                    showToast(response.message, "error");
                }
            },
            error: function () {
                showToast("Có lỗi xảy ra, vui lòng thử lại!", "error");
            }
        });
    });
});
</script>
</body>
</html>