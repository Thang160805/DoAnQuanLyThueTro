<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.ThongBao"%>
<%@ page import="model.bean.YeuCauThueTro"%>
<%@ page import="utils.TimeHelper"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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


<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ChuTro.css">
<style>
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
	grid-template-columns: 2.5fr 1fr 1.5fr 1fr 160px;
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
	grid-template-columns: 2.5fr 1fr 1.5fr 1fr 160px; padding : 16px 24px;
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
	/* Cột "Vấn đề" rộng nhất (2.5fr) để hiển thị chi tiết */
	grid-template-columns: 0.8fr 2.5fr 1.2fr 1fr 1.2fr 120px;
	align-items: center;
}
.truncate-150 {
    display:block;
    width: 150px;            /* cố định 150px như bạn yêu cầu */
    white-space: nowrap;     /* không xuống dòng */
    overflow: hidden;        /* ẩn phần dư */
    text-overflow: ellipsis; /* hiện dấu “…” */
}
</style>
</head>
<body>
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
					<% int countYC = (int) request.getAttribute("countYC");
					if(countYC != -1){%>
						<span
						style="margin-left: auto; background: linear-gradient(135deg, #ef4444, #f43f5e); color: white; font-size: 11px; font-weight: 700; padding: 4px 8px; border-radius: 8px; box-shadow: var(--shadow-primary);"><%= countYC %></span>
					<%}
					%>
				</div>
				<div class="nav-item" onclick="navTo('incidents', this)">
					<i class="fa-solid fa-screwdriver-wrench"></i> Sự cố & Sửa chữa
				</div>
				<div class="nav-item" onclick="navTo('notify', this)">
					<i class="fa-solid fa-paper-plane"></i> Gửi thông báo
				</div>
			</nav>
			<%
			TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTinCaNhan");
			%>
			<a href="${pageContext.request.contextPath}/CaiDatCT" class="user-profile">
				<img
					src="<%=(tk != null && tk.getAvatar() != null) ? tk.getAvatar() : ""%>"
					alt="Avatar" class="user-avatar">
				<div class="user-info">
					<h4 style="font-size: 14px;"><%=(tk != null && tk.getHoTen() != null) ? tk.getHoTen() : ""%></h4>
					<span style="font-size: 12px;">Chủ trọ • Premium</span>
				</div>
				<i class="fa-solid fa-chevron-right"
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
					<button class="icon-btn">
						<i class="fa-solid fa-magnifying-glass"></i>
					</button>
					<button class="icon-btn">
						<i class="fa-regular fa-bell"></i>
						<div class="notification-dot"></div>
					</button>
					<a href="${pageContext.request.contextPath}/Logout"
						class="btn btn-logout"> Đăng xuất</a>
				</div>
			</header>

			<div class="main-content">
			<% int countSoPhong = (int) request.getAttribute("countSoPhong");
			int countPhongTrong = (int) request.getAttribute("countPhongTrong");
			int countPhongDaThue = (int) request.getAttribute("countPhongDaThue");
			%>
				<div id="dashboard" class="section active">
					<div class="stats-grid">
						<div class="stat-card">
							<div class="stat-icon stat-primary">
								<i class="fa-solid fa-building-user"></i>
							</div>
							<div class="stat-value"><%= (countSoPhong!=-1) ? countSoPhong : "" %></div>
							<div class="stat-label">Tổng số phòng</div>
						</div>
						<div class="stat-card">
							<div class="stat-icon stat-busy">
								<i class="fa-solid fa-check-double"></i>
							</div>
							<div class="stat-value"><%= (countPhongDaThue!=-1) ? countPhongDaThue : "" %></div>
							<div class="stat-label" style="color: #6366f1">Đang
								thuê</div>
						</div>
						<div class="stat-card">
							<div class="stat-icon stat-success">
								<i class="fa-solid fa-key"></i>
							</div>
							<div class="stat-value"><%= (countPhongTrong!=-1) ? countPhongTrong : "" %></div>
							<div class="stat-label" style="color: #15803d">Phòng trống</div>
						</div>
						<div class="stat-card">
							<div class="stat-icon stat-warning">
								<i class="fa-solid fa-sack-dollar"></i>
							</div>
							<div class="stat-value">45.2tr</div>
							<div class="stat-label" style="color: #b45309">Doanh thu
								tháng</div>
						</div>
					</div>

					<div class="revenue-section">
						<div class="chart-header">
							<div class="chart-title">Thống kê doanh thu (6 tháng gần
								nhất)</div>
							<select class="form-input"
								style="width: auto; padding: 6px 12px;">
								<option>Năm 2025</option>
								<option>Năm 2024</option>
							</select>
						</div>
						<div class="chart-container">
							<div class="chart-bar-group">
								<div class="chart-bar" style="height: 40%;" data-value="32tr"></div>
								<span class="chart-label">Tháng 7</span>
							</div>
							<div class="chart-bar-group">
								<div class="chart-bar" style="height: 55%;" data-value="38tr"></div>
								<span class="chart-label">Tháng 8</span>
							</div>
							<div class="chart-bar-group">
								<div class="chart-bar" style="height: 45%;" data-value="35tr"></div>
								<span class="chart-label">Tháng 9</span>
							</div>
							<div class="chart-bar-group">
								<div class="chart-bar" style="height: 70%;" data-value="41tr"></div>
								<span class="chart-label">Tháng 10</span>
							</div>
							<div class="chart-bar-group">
								<div class="chart-bar" style="height: 65%;" data-value="40tr"></div>
								<span class="chart-label">Tháng 11</span>
							</div>
							<div class="chart-bar-group">
								<div class="chart-bar"
									style="height: 85%; background: var(--primary);"
									data-value="45.2tr"></div>
								<span class="chart-label">Tháng 12</span>
							</div>
						</div>
					</div>
				</div>

				<div id="rooms" class="section">

					<div
						style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
						<div class="table-title">Danh sách phòng</div>
						<a href="#" class="btn btn-primary"> <i
							class="fa-solid fa-plus"></i> Thêm phòng
						</a>
					</div>

					<div class="room-grid-container">

						<!-- HEADER -->
						<div class="room-grid-header">
							<div>Phòng</div>
							<div>Giá thuê cơ bản</div>
							<div>Người thuê</div>
							<div>Trạng thái</div>
							<div class="col-right">Hành động</div>
						</div>

						<div class="room-grid-body">

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
								<div style="font-size: 14px; margin-bottom: 16px;">Hãy
									thêm phòng mới để bắt đầu quản lý trọ.</div>

								<a href="#" class="btn btn-primary"> <i
									class="fa-solid fa-plus"></i> Thêm phòng mới
								</a>
							</div>

							<%
							} else {

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
									<div style="font-weight: 600; font-size: 13px;"><%=pt.getTenCT()%></div>
									<div style="font-size: 11px; color: #64748b;"><%=pt.getPhone()%></div>
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

										<button class="btn-action btn-edit" title="Sửa">
											<i class="fa-solid fa-pen"></i>
										</button>

										<button class="btn-action btn-delete" title="Xóa">
											<i class="fa-solid fa-trash"></i>
										</button>
									</div>
								</div>

							</div>

							<%
							}
							}
							%>

						</div>
					</div>
				</div>


				<div id="tenants" class="section">

					<div
						style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
						<div class="table-title">Danh sách người thuê trọ</div>

						<div style="display: flex; gap: 12px;">
							<button class="btn btn-outline" style="padding: 10px 16px;">
								<i class="fa-solid fa-filter"></i> Lọc
							</button>
							<div class="form-input"
								style="padding: 8px 12px; display: flex; align-items: center; gap: 8px; width: 250px;">
								<i class="fa-solid fa-magnifying-glass"
									style="color: var(--text-light)"></i> <input type="text"
									placeholder="Tìm tên, phòng..."
									style="border: none; outline: none; background: transparent; width: 100%;">
							</div>
						</div>
					</div>

					<div class="room-grid-container">

						<div class="room-grid-header tenant-cols">
							<div>Cư dân</div>
							<div>Phòng</div>
							<div>Liên hệ</div>
							<div>Ngày bắt đầu HĐ</div>
							<div>Trạng thái đóng tiền</div>
							<div class="col-right">Thao tác</div>
						</div>

						<div class="room-grid-body">

							<div class="room-grid-row tenant-cols">
								<div>
									<div class="user-cell">
										<img src="https://i.pravatar.cc/150?img=12"
											class="table-avatar">
										<div>
											<div style="font-weight: 700;">Nguyễn Văn A</div>
											<div style="font-size: 12px; color: var(--text-secondary);">Sinh
												viên ĐH Vinh</div>
										</div>
									</div>
								</div>
								<div>
									<span style="font-weight: 700; color: var(--primary);">P.101</span>
								</div>
								<div>
									<div style="font-size: 13px;">
										<i class="fa-solid fa-phone"
											style="font-size: 11px; color: var(--text-light)"></i> 0987
										654 321
									</div>
									<div style="font-size: 12px; color: var(--text-secondary);">Zalo:
										0987...</div>
								</div>
								<div style="font-size: 13px; color: var(--text-main);">15/08/2024</div>
								<div>
									<span class="status-badge badge-success"><span
										class="status-dot"></span>Đã đóng đủ</span>
								</div>
								<div class="col-right">
									<div class="action-group">
										<button class="btn-icon-plain" title="Chat Zalo">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
										<button class="btn-icon-plain" title="Xem hợp đồng">
											<i class="fa-solid fa-file-contract"></i>
										</button>
									</div>
								</div>
							</div>

							<div class="room-grid-row tenant-cols">
								<div>
									<div class="user-cell">
										<img src="https://i.pravatar.cc/150?img=44"
											class="table-avatar">
										<div>
											<div style="font-weight: 700;">Lê Thị Mai</div>
											<div style="font-size: 12px; color: var(--text-secondary);">Nhân
												viên VP</div>
										</div>
									</div>
								</div>
								<div>
									<span style="font-weight: 700; color: var(--text-main);">P.205</span>
								</div>
								<div>
									<div style="font-size: 13px;">
										<i class="fa-solid fa-phone"
											style="font-size: 11px; color: var(--text-light)"></i> 0912
										345 678
									</div>
								</div>
								<div style="font-size: 13px; color: var(--text-main);">01/12/2024</div>
								<div>
									<span class="status-badge badge-error"><span
										class="status-dot"></span>Nợ phí T12</span>
								</div>
								<div class="col-right">
									<div class="action-group">
										<button class="btn-icon-plain" title="Gửi nhắc nhở"
											style="color: #ef4444; background: #fee2e2;">
											<i class="fa-solid fa-bell"></i>
										</button>
										<button class="btn-icon-plain" title="Xem hợp đồng">
											<i class="fa-solid fa-file-contract"></i>
										</button>
									</div>
								</div>
							</div>

							<div class="room-grid-row tenant-cols">
								<div>
									<div class="user-cell">
										<img src="https://i.pravatar.cc/150?img=60"
											class="table-avatar">
										<div>
											<div style="font-weight: 700;">Trần Văn C</div>
											<div style="font-size: 12px; color: var(--text-secondary);">Công
												nhân</div>
										</div>
									</div>
								</div>
								<div>
									<span style="font-weight: 700; color: var(--text-main);">P.301</span>
								</div>
								<div>
									<div style="font-size: 13px;">0345 678 999</div>
								</div>
								<div style="font-size: 13px;">10/06/2024</div>
								<div>
									<span class="status-badge badge-success"><span
										class="status-dot"></span>Đã đóng đủ</span>
								</div>
								<div class="col-right">
									<div class="action-group">
										<button class="btn-icon-plain">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
										<button class="btn-icon-plain">
											<i class="fa-solid fa-file-contract"></i>
										</button>
									</div>
								</div>
							</div>
							<div class="room-grid-row tenant-cols">
								<div>
									<div class="user-cell">
										<img src="https://i.pravatar.cc/150?img=15"
											class="table-avatar">
										<div>
											<div style="font-weight: 700;">Phạm Văn D</div>
											<div style="font-size: 12px; color: var(--text-secondary);">Sinh
												viên</div>
										</div>
									</div>
								</div>
								<div>
									<span style="font-weight: 700; color: var(--text-main);">P.302</span>
								</div>
								<div>
									<div style="font-size: 13px;">0988 777 666</div>
								</div>
								<div style="font-size: 13px;">01/01/2025</div>
								<div>
									<span class="status-badge badge-success"><span
										class="status-dot"></span>Đã đóng đủ</span>
								</div>
								<div class="col-right">
									<div class="action-group">
										<button class="btn-icon-plain">
											<i class="fa-solid fa-comment-dots"></i>
										</button>
										<button class="btn-icon-plain">
											<i class="fa-solid fa-file-contract"></i>
										</button>
									</div>
								</div>
							</div>

						</div>
					</div>
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

					<div class="room-grid-container">
					<% ArrayList<YeuCauThueTro> listYC = (ArrayList<YeuCauThueTro>) request.getAttribute("listYeuCau");
					if (listYC == null || listYC.size() == 0) {
						%>

						<div style="padding: 20px; text-align:center; color: #6b7280; font-size: 15px;">
						    <i class="fa-regular fa-circle-xmark"></i> Chưa có yêu cầu thuê nào
						</div>
					<%} else { %>
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
						for(YeuCauThueTro yc : listYC){
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
										<img src="<%=(yc != null && yc.getAvatar() != null) ? yc.getAvatar() : ""%>"
											class="table-avatar">
										<div>
											<div style="font-weight: 700;"><%=(yc != null && yc.getHoTen() != null) ? yc.getHoTen() : ""%></div>
										</div>
									</div>
								</div>
								<div>
									<span class="truncate-150" style="font-weight: 700; color: #6366f1;"><%=(yc != null && yc.getTenPhong() != null) ? yc.getTenPhong() : ""%></span>
								</div>
								<div><%=(yc != null && yc.getSDT() != null) ? yc.getSDT() : ""%></div>
								<div style="color: #64748b;"><%=(yc != null && yc.getCreate_at() != null) ? TimeHelper.timeAgo(yc.getCreate_at()) : ""%></div>
								<div>
									<span class="status-badge <%= badgeClass%>"><span
										class="status-dot"></span><%= status %></span>
								</div>
								<div class="col-right">
									<button class="btn btn-outline btn-sm">Xem chi tiết</button>
								</div>
							</div>
							<% }
							}%>
							
							

							

						</div>
					</div>
				</div>

				<div id="incidents" class="section">

					<div
						style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 16px;">
						<div class="table-title">Sự cố cần xử lý</div>
						<div style="display: flex; gap: 10px;">
							<select class="form-input"
								style="padding: 8px 12px; width: auto;">
								<option>Tất cả trạng thái</option>
								<option>Chưa xử lý</option>
								<option>Đang xử lý</option>
							</select>
						</div>
					</div>

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

							<div class="room-grid-row incident-cols">
								<div>
									<div
										style="font-weight: 700; font-size: 16px; color: var(--text-main)">P.101</div>
								</div>

								<div>
									<div class="user-cell">
										<div
											style="width: 40px; height: 40px; background: #fee2e2; color: #ef4444; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px;">
											<i class="fa-solid fa-faucet-drip"></i>
										</div>
										<div>
											<div style="font-weight: 600">Rò rỉ ống nước nhà tắm</div>
											<div style="font-size: 12px; color: var(--text-secondary)">10:30
												AM hôm nay</div>
										</div>
									</div>
								</div>

								<div>
									<div class="user-cell">
										<img src="https://i.pravatar.cc/150?img=12"
											class="table-avatar" style="width: 30px; height: 30px;">
										<span style="font-size: 13px; font-weight: 600">Nguyễn
											Văn A</span>
									</div>
								</div>

								<div>
									<span class="status-badge badge-error"><span
										class="status-dot"></span>Khẩn cấp</span>
								</div>

								<div>
									<span id="badge-101" class="status-badge badge-warn"><span
										class="status-dot"></span>Chờ xử lý</span>
								</div>

								<div class="col-right">
									<button class="btn btn-primary"
										style="padding: 8px 16px; font-size: 13px;"
										onclick="openIncidentModal('101', 'P.101', 'Rò rỉ ống nước')">
										<i class="fa-solid fa-screwdriver-wrench"></i> Xử lý
									</button>
								</div>
							</div>

							<div class="room-grid-row incident-cols">
								<div>
									<div
										style="font-weight: 700; font-size: 16px; color: var(--text-main)">P.205</div>
								</div>

								<div>
									<div class="user-cell">
										<div
											style="width: 40px; height: 40px; background: #fef9c3; color: #b45309; border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px;">
											<i class="fa-regular fa-lightbulb"></i>
										</div>
										<div>
											<div style="font-weight: 600">Bóng đèn hành lang nhấp
												nháy</div>
											<div style="font-size: 12px; color: var(--text-secondary)">Báo
												cáo: Hôm qua</div>
										</div>
									</div>
								</div>

								<div>
									<div class="user-cell">
										<img src="https://i.pravatar.cc/150?img=32"
											class="table-avatar" style="width: 30px; height: 30px;">
										<span style="font-size: 13px; font-weight: 600">Lê Thị
											B</span>
									</div>
								</div>

								<div>
									<span class="status-badge badge-warn"><span
										class="status-dot"></span>Trung bình</span>
								</div>

								<div>
									<span id="badge-205" class="status-badge badge-warn"
										style="background: #f1f5f9; color: var(--text-secondary)"><span
										class="status-dot" style="background: var(--text-secondary)"></span>Chờ
										tiếp nhận</span>
								</div>

								<div class="col-right">
									<button class="btn btn-outline"
										style="padding: 5px 10px; font-size: 13px;"
										onclick="openIncidentModal('205', 'P.205', 'Bóng đèn hành lang')">
										<i class="fa-regular fa-pen-to-square"></i> Tiếp nhận
									</button>
								</div>
							</div>

						</div>
					</div>
				</div>

				<div id="notify" class="section">
					<div class="table-container"
						style="max-width: 600px; margin: 0 auto;">
						<div class="table-title" style="margin-bottom: 20px;">Soạn
							thông báo mới</div>
						<div class="form-group">
							<label class="form-label">Tiêu đề</label> <input
								class="form-input"
								placeholder="Ví dụ: Thông báo thu tiền điện tháng 12">
						</div>
						<div class="form-group">
							<label class="form-label">Gửi tới</label> <select
								class="form-input">
								<option>Tất cả người thuê</option>
								<option>Tầng 1</option>
								<option>Tầng 2</option>
							</select>
						</div>
						<div class="form-group">
							<label class="form-label">Nội dung</label>
							<textarea class="form-input" rows="5"
								placeholder="Nhập nội dung..."></textarea>
						</div>
						<button class="btn btn-primary">
							<i class="fa-solid fa-paper-plane"></i> Gửi ngay
						</button>
					</div>
				</div>

			</div>
		</main>
	</div>

	<div class="modal-overlay" id="roomModal">
		<div class="modal-box">
			<div class="modal-header"
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
				<h3>Thêm phòng mới</h3>
				<button onclick="closeModal('roomModal')"
					style="background: none; border: none; cursor: pointer;">
					<i class="fa-solid fa-xmark" style="font-size: 20px;"></i>
				</button>
			</div>
			<div class="form-group">
				<label class="form-label">Tên phòng</label><input type="text"
					class="form-input">
			</div>
			<div style="display: flex; justify-content: flex-end;">
				<button class="btn btn-primary">Lưu</button>
			</div>
		</div>
	</div>

	<div class="modal-overlay" id="requestDetailModal">
		<div class="modal-box" style="max-width: 600px;">
			<div class="table-header">
				<h3>Chi tiết yêu cầu thuê</h3>
				<button onclick="closeModal('requestDetailModal')"
					style="background: none; border: none; cursor: pointer;">
					<i class="fa-solid fa-xmark" style="font-size: 20px;"></i>
				</button>
			</div>
			<div style="display: flex; gap: 20px; margin-bottom: 20px;">
				<img src="https://i.pravatar.cc/150?img=3"
					style="width: 80px; height: 80px; border-radius: 12px; object-fit: cover;">
				<div>
					<h4 style="font-size: 18px; margin-bottom: 4px;">Phạm Hương</h4>
					<p
						style="color: var(--text-secondary); font-size: 14px; margin-bottom: 4px;">
						<i class="fa-solid fa-phone"></i> 0987 654 321
					</p>
					<p style="color: var(--text-secondary); font-size: 14px;">
						<i class="fa-solid fa-envelope"></i> huong.pham@email.com
					</p>
				</div>
			</div>
			<div style="display: flex; justify-content: flex-end; gap: 12px;">
				<button class="btn btn-outline">Từ chối</button>
				<button class="btn btn-primary">
					<i class="fa-solid fa-check"></i> Duyệt yêu cầu
				</button>
			</div>
		</div>
	</div>

	<div class="modal-overlay" id="billModal">
		<div class="modal-box" style="max-width: 500px;">
			<div class="table-header" style="margin-bottom: 20px;">
				<h3>
					<i class="fa-solid fa-calculator"
						style="color: var(--primary); margin-right: 8px;"></i> Tính tiền
					phòng
				</h3>
				<button onclick="closeModal('billModal')"
					style="background: none; border: none; cursor: pointer;">
					<i class="fa-solid fa-xmark" style="font-size: 20px;"></i>
				</button>
			</div>
			<div
				style="background: var(--primary-soft); padding: 12px; border-radius: 12px; margin-bottom: 20px; display: flex; justify-content: space-between; align-items: center;">
				<div>
					<div
						style="font-size: 12px; color: var(--text-secondary); font-weight: 600;">PHÒNG</div>
					<div
						style="font-weight: 800; color: var(--text-main); font-size: 16px;"
						id="billRoomName">P.101</div>
				</div>
				<div style="text-align: right;">
					<div
						style="font-size: 12px; color: var(--text-secondary); font-weight: 600;">KHÁCH
						THUÊ</div>
					<div style="font-weight: 700; color: var(--primary);"
						id="billTenantName">Nguyễn Văn A</div>
				</div>
			</div>
			<form id="billForm">
				<div class="form-group">
					<label class="form-label">Tiền phòng cố định</label><input
						type="number" id="baseRent" class="form-input"
						style="background: #f1f5f9; font-weight: 700;" readonly>
				</div>
				<div
					style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px;">
					<div class="form-group">
						<label class="form-label">Số điện (kWh) <span
							style="font-weight: 400; font-size: 11px;">(3.5k/số)</span></label><input
							type="number" id="elecNum" class="form-input" placeholder="0"
							oninput="calculateTotal()">
					</div>
					<div class="form-group">
						<label class="form-label">Số nước (m³) <span
							style="font-weight: 400; font-size: 11px;">(15k/khối)</span></label><input
							type="number" id="waterNum" class="form-input" placeholder="0"
							oninput="calculateTotal()">
					</div>
				</div>
				<div class="form-group">
					<label class="form-label">Chi phí khác</label><input type="number"
						id="otherFee" class="form-input" value="100000"
						oninput="calculateTotal()">
				</div>
				<div
					style="margin-top: 24px; padding-top: 16px; border-top: 2px dashed var(--border-color); display: flex; justify-content: space-between; align-items: center;">
					<div
						style="font-size: 14px; font-weight: 600; color: var(--text-secondary);">TỔNG
						CỘNG</div>
					<div style="font-size: 24px; font-weight: 800; color: #ef4444;"
						id="totalBill">0 ₫</div>
				</div>
				<div
					style="display: flex; justify-content: flex-end; gap: 12px; margin-top: 24px;">
					<button type="button" class="btn btn-outline"
						onclick="closeModal('billModal')">Hủy</button>
					<button type="submit" class="btn btn-primary">
						<i class="fa-regular fa-paper-plane"></i> Gửi hóa đơn
					</button>
				</div>
			</form>
		</div>
	</div>

	<div class="modal-overlay" id="incidentModal">
		<div class="modal-box" style="max-width: 550px;">
			<div class="modal-header"
				style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px; padding-bottom: 16px; border-bottom: 1px solid var(--border-color);">
				<h3 style="display: flex; align-items: center; gap: 10px;">
					<i class="fa-solid fa-toolbox" style="color: var(--primary)"></i>
					Cập nhật tiến độ
				</h3>
				<button onclick="closeIncidentModal()"
					style="background: none; border: none; cursor: pointer;">
					<i class="fa-solid fa-xmark" style="font-size: 20px;"></i>
				</button>
			</div>
			<div
				style="background: var(--primary-soft); padding: 12px 16px; border-radius: 12px; margin-bottom: 20px; display: flex; justify-content: space-between;">
				<div>
					<div
						style="font-size: 12px; color: var(--text-secondary); font-weight: 600;">PHÒNG</div>
					<div
						style="font-weight: 800; color: var(--primary); font-size: 16px;"
						id="modalRoomName">P.101</div>
				</div>
				<div style="text-align: right;">
					<div
						style="font-size: 12px; color: var(--text-secondary); font-weight: 600;">SỰ
						CỐ</div>
					<div style="font-weight: 700; color: var(--text-main);"
						id="modalIssueName">Rò rỉ ống nước</div>
				</div>
			</div>
			<form id="incidentForm">
				<input type="hidden" id="currentIncidentId">
				<div class="form-group">
					<label class="form-label">1. Trạng thái hiện tại</label>
					<div
						style="display: grid; grid-template-columns: 1fr 1fr 1fr; gap: 10px;">
						<label style="cursor: pointer;"><input type="radio"
							name="status" value="pending" class="hidden-radio">
							<div class="radio-box">Chờ xử lý</div></label> <label
							style="cursor: pointer;"><input type="radio"
							name="status" value="processing" class="hidden-radio" checked>
							<div class="radio-box active">Đang sửa</div></label> <label
							style="cursor: pointer;"><input type="radio"
							name="status" value="done" class="hidden-radio">
							<div class="radio-box">Hoàn thành</div></label>
					</div>
				</div>
				<div class="form-group">
					<label class="form-label">2. Nhắn cho người thuê</label>
					<div style="display: flex; gap: 8px; margin-bottom: 8px;">
						<button type="button" class="btn-tag"
							onclick="fillReply('Đã tiếp nhận, thợ sẽ lên kiểm tra trong 30p tới.')">30p
							nữa</button>
						<button type="button" class="btn-tag"
							onclick="fillReply('Hẹn sáng mai 9h thợ sẽ qua xử lý.')">Hẹn
							sáng mai</button>
						<button type="button" class="btn-tag"
							onclick="fillReply('Đã sửa xong, bạn kiểm tra lại nhé.')">Đã
							xong</button>
					</div>
					<textarea id="incidentReply" class="form-input" rows="4"
						placeholder="Nhập nội dung phản hồi..."></textarea>
				</div>
				<div
					style="display: flex; justify-content: flex-end; gap: 12px; margin-top: 32px;">
					<button type="button" class="btn btn-outline"
						onclick="closeIncidentModal()">Đóng</button>
					<button type="submit" class="btn btn-primary">
						<i class="fa-solid fa-paper-plane"></i> Cập nhật & Gửi
					</button>
				</div>
			</form>
		</div>
	</div>
	<script>
    // --- Navigation ---
    function navTo(id, el) {
        document.querySelectorAll('.section').forEach(s => s.classList.remove('active'));
        document.getElementById(id).classList.add('active');
        document.querySelectorAll('.nav-item').forEach(n => n.classList.remove('active'));
        el.classList.add('active');
        
        const titles = {
            'dashboard': 'Tổng quan', 'rooms': 'Quản lý phòng', 'tenants': 'Danh sách người thuê',
            'requests': 'Yêu cầu thuê', 'incidents': 'Sự cố & Sửa chữa', 'notify': 'Gửi thông báo'
        };
        document.getElementById('page-heading').innerText = titles[id];
    }

    // --- Modal General ---
    function openModal(id) { document.getElementById(id).classList.add('active'); }
    function closeModal(id) { document.getElementById(id).classList.remove('active'); }

    // --- Bill Logic ---
    const PRICE_ELEC = 3500;
    const PRICE_WATER = 15000;
    function openBillModal(room, tenant, price) {
        document.getElementById('billRoomName').innerText = room;
        document.getElementById('billTenantName').innerText = tenant;
        document.getElementById('baseRent').value = price;
        document.getElementById('elecNum').value = '';
        document.getElementById('waterNum').value = '';
        calculateTotal();
        openModal('billModal');
    }
    function calculateTotal() {
        let rent = Number(document.getElementById('baseRent').value) || 0;
        let elec = Number(document.getElementById('elecNum').value) || 0;
        let water = Number(document.getElementById('waterNum').value) || 0;
        let other = Number(document.getElementById('otherFee').value) || 0;
        let total = rent + (elec * PRICE_ELEC) + (water * PRICE_WATER) + other;
        document.getElementById('totalBill').innerText = total.toLocaleString('vi-VN') + ' ₫';
    }
    document.getElementById('billForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const btn = this.querySelector('button[type="submit"]');
        btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang gửi...';
        setTimeout(() => { closeModal('billModal'); btn.innerHTML = '<i class="fa-regular fa-paper-plane"></i> Gửi hóa đơn'; alert('Đã gửi hóa đơn!'); }, 1000);
    });

    // --- Incident Logic ---
    function openIncidentModal(id, room, issue) {
        document.getElementById('currentIncidentId').value = id;
        document.getElementById('modalRoomName').innerText = room;
        document.getElementById('modalIssueName').innerText = issue;
        document.getElementById('incidentReply').value = '';
        document.getElementById('incidentModal').classList.add('active');
    }
    function closeIncidentModal() { document.getElementById('incidentModal').classList.remove('active'); }
    function fillReply(text) { document.getElementById('incidentReply').value = text; }
    
    document.querySelectorAll('input[name="status"]').forEach(radio => {
        radio.addEventListener('change', function() {
            document.querySelectorAll('.radio-box').forEach(box => {
                box.style.borderColor = 'var(--border-color)'; box.style.background = 'white'; box.style.color = 'var(--text-secondary)';
            });
            const box = this.nextElementSibling;
            box.style.borderColor = 'var(--primary)'; box.style.background = 'var(--primary-soft)'; box.style.color = 'var(--primary)';
        });
    });

    document.getElementById('incidentForm').addEventListener('submit', function(e) {
        e.preventDefault();
        const btn = this.querySelector('button[type="submit"]');
        const originalText = btn.innerHTML;
        const id = document.getElementById('currentIncidentId').value;
        const status = document.querySelector('input[name="status"]:checked').value;

        btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang gửi...';
        setTimeout(() => {
            closeIncidentModal();
            btn.innerHTML = originalText;
            const badge = document.getElementById('badge-' + id);
            if(badge) {
                if (status === 'processing') { badge.className = 'status-badge badge-busy'; badge.innerHTML = '<span class="status-dot"></span>Đang xử lý'; }
                else if (status === 'done') { badge.className = 'status-badge badge-success'; badge.innerHTML = '<span class="status-dot"></span>Hoàn thành'; }
                else { badge.className = 'status-badge badge-warn'; badge.innerHTML = '<span class="status-dot"></span>Chờ xử lý'; }
            }
            alert("Đã cập nhật!");
        }, 800);
    });
</script>
</body>
</html>