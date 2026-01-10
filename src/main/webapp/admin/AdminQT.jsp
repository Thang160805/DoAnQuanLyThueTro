<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="utils.TimeHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FindRoom Admin | Quản trị hệ thống</title>
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
	href="${pageContext.request.contextPath}/assets/css/AdminQT.css">

<style>
body {
	margin: 0;
	font-family: "Open Sans", sans-serif;
	background: linear-gradient(135deg, #f8fafc 0%, #eef2ff 100%);
	color: #1e293b;
	height: 100vh;
	overflow: hidden;
}
.section {
	display: none;
	opacity: 0;
	transform: translateY(10px);
	transition: all 0.4s ease;
}

.section.active {
	display: block;
	opacity: 1;
	transform: translateY(0);
}

.stat-card {
	border: none;
	background: #fff;
	padding: 24px;
	border-radius: 20px;
	box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
}

.form-container-admin {
	max-width: 600px;
	background: #fff;
	padding: 40px;
	border-radius: 24px;
	box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
}

.room-grid-container {
	border: none;
	background: #fff;
	border-radius: 20px;
	box-shadow: 0 10px 25px -5px rgba(0, 0, 0, 0.05);
}

.room-grid-header {
	background: #f8fafc;
	color: #64748b;
	text-transform: uppercase;
	font-size: 11px;
	letter-spacing: 0.5px;
	border-bottom: 1px solid #f1f5f9;
}

.btn-logout {
	background: #fee2e2;
	color: #ef4444;
	border: none;
	padding: 8px 16px;
	border-radius: 12px;
	font-weight: 600;
	transition: 0.3s;
}

.btn-logout:hover {
	background: #ef4444;
	color: #fff;
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
					<i class="fa-solid fa-chart-pie"></i> <span>Tổng quan</span>
				</div>
				<div class="nav-item" onclick="navTo('accounts', this)">
					<i class="fa-solid fa-users-gear"></i> <span>Quản lý tài
						khoản</span>
				</div>
				<div class="nav-item" onclick="navTo('add-admin', this)">
					<i class="fa-solid fa-user-shield"></i> <span>Thêm Admin</span>
				</div>
				<div class="nav-item" onclick="navTo('requests', this)">
					<i class="fa-solid fa-clipboard-check"></i> <span>Duyệt
						phòng trọ</span>
				</div>
			</nav>
			<%
			TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTinCaNhan");
			%>

			<a href="${pageContext.request.contextPath}/CaiDatAdmin"
				class="user-profile"> <img
				src="<%=(tk != null && tk.getAvatar() != null) ? tk.getAvatar() : ""%>"
				alt="Avatar" class="user-avatar">
				<div class="user-info">
					<h4 style="font-size: 14px;">Quản trị viên</h4>
					<p style="font-size: 12px;">Admin • Premium</p>
				</div> <i class="fa-solid fa-chevron-right ms-auto"></i>
			</a>
		</aside>

		<main>
			<header class="header">
				<div class="page-title">
					<h2 id="page-heading">Tổng quan</h2>
					<p id="page-sub">Chào mừng trở lại, hôm nay có gì mới?</p>
				</div>

				<div class="header-actions">
					<a href="${pageContext.request.contextPath}/ThongBaoAdmin"
						class="icon-btn"> <i class="fa-regular fa-bell"></i>
						<div class="notification-dot"></div>
					</a> <a href="${pageContext.request.contextPath}/Logout"
						class="btn btn-logout"> <i
						class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất
					</a>
				</div>
			</header>

			<div class="main-content">
				<%
				int countTK = (int) request.getAttribute("countTK");
				int countCD = (int) request.getAttribute("countCD");
				int countDD = (int) request.getAttribute("countDD");
				%>
				<div id="dashboard" class="section active">
					<div class="stats-grid">
						<div class="stat-card">
							<div class="stat-icon stat-primary">
								<i class="fa-solid fa-users"></i>
							</div>
							<div class="stat-value"><%=countTK%></div>
							<div class="stat-label">Tổng người dùng</div>
						</div>
						<div class="stat-card">
							<div class="stat-icon stat-busy">
								<i class="fa-solid fa-house-circle-check"></i>
							</div>
							<div class="stat-value"><%=countDD%></div>
							<div class="stat-label">Phòng đã duyệt</div>
						</div>
						<div class="stat-card">
							<div class="stat-icon stat-success">
								<i class="fa-solid fa-clock"></i>
							</div>
							<div class="stat-value"><%=countCD%></div>
							<div class="stat-label">Phòng chờ duyệt</div>
						</div>
					</div>

					
				</div>

				<div id="accounts" class="section">
					<div class="d-flex justify-content-between align-items-center mb-4">
						<h3 class="table-title">Quản lý tài khoản</h3>
						<div class="d-flex gap-3">
							<input type="text" class="form-control"
								style="width: 280px; border-radius: 12px;"
								placeholder="Tìm tên, email...">
							<button class="btn btn-primary" style="border-radius: 12px;">
								<i class="fa-solid fa-filter"></i> Lọc
							</button>
						</div>
					</div>
					<div class="room-grid-container">
						<div class="room-grid-header tenant-cols">
							<div>Thành viên</div>
							<div>Vai trò</div>
							<div>Liên hệ</div>
							<div>Ngày tham gia</div>
							<div>Trạng thái</div>
							<div class="col-right">Thao tác</div>
						</div>
						<%
						ArrayList<TaiKhoan> listTK = (ArrayList<TaiKhoan>) request.getAttribute("listTK");
						for (TaiKhoan tk1 : listTK) {
						%>
						<div class="room-grid-body">
							<div class="room-grid-row tenant-cols">
								<div class="user-cell">
									<img
										src="<%=(tk1 != null && tk1.getAvatar() != null) ? tk1.getAvatar() : ""%>"
										class="table-avatar">
									<div>
										<div class="fw-bold"><%=(tk1 != null && tk1.getHoTen() != null) ? tk1.getHoTen() : ""%></div>
										<div class="text-muted small">
											ID: #<%=(tk1 != null && tk1.getId() != -1) ? tk1.getId() : ""%></div>
									</div>
								</div>
								<div>
									<%
									if (tk.getRole() == 1) {
									%>
									<span class="badge bg-info-subtle text-info px-3"> Chủ
										trọ </span>
									<%
									} else if (tk.getRole() == 2) {
									%>
									<span class="badge bg-success-subtle text-success px-3">
										Người thuê </span>
									<%
									}
									%>
								</div>
								<div class="small">
									<%=(tk1 != null && tk1.getEmail() != null) ? tk1.getEmail() : ""%><br><%=(tk1 != null && tk1.getSDT() != null) ? tk1.getSDT() : ""%>
								</div>
								<div class="small text-muted">
									<%=(tk1 != null && tk1.getNgayTao() != null)
		? tk1.getNgayTao().format(DateTimeFormatter.ofPattern("dd/MM/yyyy"))
		: ""%>
								</div>
								<div>
									<span class="status-badge badge-success"><span
										class="status-dot"></span>Hoạt động</span>
								</div>
								<div class="col-right">
									<button class="btn btn-sm btn-outline-secondary rounded-pill">Chi
										tiết</button>
								</div>
							</div>
						</div>
						<%
						}
						%>
					</div>
				</div>

				<div id="add-admin" class="section">
					<div class="form-container-admin mx-auto">
						<div class="text-center mb-4">
							<i class="fa-solid fa-shield-halved fa-3x text-primary mb-3"></i>
							<h3>Tạo tài khoản Quản trị viên</h3>
							<p class="text-muted">Cấp quyền admin cho nhân sự mới của hệ
								thống</p>
						</div>
						<form id="addAdminForm">
							<div class="mb-3">
								<label class="form-label fw-bold">Tên đăng nhập</label> <input
									type="text" name="TenDangNhap" class="form-control py-2">
							</div>

							<div class="mb-3">
								<label class="form-label fw-bold">Mật khẩu</label> <input
									type="password" name="Password" class="form-control py-2">
							</div>

							<div class="mb-4">
								<label class="form-label fw-bold">Nhập lại mật khẩu</label> <input
									type="password" name="Confirm_pass" class="form-control py-2">
							</div>

							<button type="submit"
								class="btn btn-primary w-100 py-3 fw-bold rounded-4 shadow">
								Xác nhận tạo tài khoản</button>
						</form>
					</div>
				</div>
				<%
				ArrayList<PhongTro> listPT = (ArrayList<PhongTro>) request.getAttribute("listPT");
				%>
				<div id="requests" class="section">
					<h3 class="table-title mb-4">Danh sách tin đăng chờ duyệt</h3>
					<%
					if (listPT == null || listPT.isEmpty()) {
					%>

					<!-- ✅ KHÔNG CÓ PHÒNG -->
					<div class="text-center py-5 text-muted">
						<i class="fa-regular fa-folder-open fs-1 mb-3"></i>
						<div class="fw-semibold fs-6">Chưa có phòng nào chờ duyệt</div>
					</div>

					<%
					} else {
					%>
					<div class="room-grid-container">
						<div class="room-grid-header"
							style="grid-template-columns: 1.5fr 1fr 1fr 1fr 120px;">
							<div>Ảnh & Tên phòng</div>
							<div>Chủ trọ</div>
							<div>Giá thuê</div>
							<div>Ngày gửi</div>
							<div class="text-end">Thao tác</div>
						</div>
						<div class="room-grid-body">

							<div class="room-grid-row"
								style="grid-template-columns: 1.5fr 1fr 1fr 1fr 120px;">
								<%
								for (PhongTro pt : listPT) {
								%>
								<div class="user-cell">
									<img
										src="<%=(pt != null && pt.getAnhChinh() != null) ? pt.getAnhChinh() : ""%>"
										class="table-avatar rounded">
									<div class="fw-bold text-primary"><%=(pt != null && pt.getTenPhong() != null) ? pt.getTenPhong() : ""%></div>
								</div>
								<div class="small"><%=(pt != null && pt.getTenCT() != null) ? pt.getTenCT() : ""%></div>
								<div class="fw-bold text-success"><%=(pt != null && pt.getGiaThue() != -1) ? CurrencyHelper.format(pt.getGiaThue()) : ""%>
									₫
								</div>
								<div class="small text-muted"><%=(pt != null && pt.getNgayDang() != null) ? TimeHelper.timeAgo(pt.getNgayDang()) : ""%></div>
								<div class="text-end">
									<a
										href="${pageContext.request.contextPath}/ChiTietPhongDuyet?ID_Phong=<%= pt.getID_Phong() %>"
										class="btn btn-primary-premium btn-sm rounded-pill px-4">
										<i class="fa-solid fa-eye me-1"></i> Xem chi tiết
									</a>
								</div>
								<%
								}
								%>
							</div>
						</div>

					</div>
					<%
					}
					%>
				</div>
			</div>
		</main>
	</div>
	<div id="toast"
		style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

	<script>
    // Hàm điều hướng mượt mà giữa các tab
    function navTo(id, el) {
        const sections = document.querySelectorAll('.section');
        const navItems = document.querySelectorAll('.nav-item');
        const heading = document.getElementById('page-heading');
        const sub = document.getElementById('page-sub');

        // Ẩn tất cả
        sections.forEach(s => {
            s.classList.remove('active');
            s.style.display = 'none';
        });
        navItems.forEach(n => n.classList.remove('active'));

        // Hiện section được chọn
        const activeSection = document.getElementById(id);
        activeSection.style.display = 'block';
        // Delay 1 chút để effect transition chạy
        setTimeout(() => activeSection.classList.add('active'), 50);
        el.classList.add('active');
        
        // Cập nhật text tiêu đề
        const titles = {
            'dashboard': ['Tổng quan', 'Hôm nay hệ thống của bạn thế nào?'],
            'accounts': ['Quản lý tài khoản', 'Danh sách tất cả người dùng và chủ trọ'],
            'add-admin': ['Thêm Admin', 'Cấp quyền quản trị cho thành viên mới'],
            'requests': ['Duyệt phòng trọ', 'Kiểm tra và phê duyệt tin đăng mới']
        };
        
        heading.innerText = titles[id][0];
        sub.innerText = titles[id][1];
    }
    function showToast(message, type = "success") {
	    const toast = $("#toast");

	    let iconHTML = "";

	    if (type === "error") {
	        toast.css("background-color", "#dc2626"); // đỏ
	        iconHTML = `<i class="fa-solid fa-circle-xmark" style="color:#fecaca; margin-right:8px;"></i>`;
	    } else {
	        toast.css("background-color", "#2563eb"); // xanh
	        iconHTML = `<i class="fa-solid fa-circle-check" style="color:#4ade80; margin-right:8px;"></i>`;
	    }

	    toast.html(iconHTML + message);

	    toast.css({ opacity: "1", transform: "translateY(0)" });

	    setTimeout(() => {
	        toast.css({ opacity: "0", transform: "translateY(20px)" });
	    }, 5000);
	}
    $("#addAdminForm").on("submit", function (e) {
        e.preventDefault();

        $.ajax({
            url: "<%=request.getContextPath()%>/XuLyThemTaiKhoanAdmin",
            method: "POST",
            data: $(this).serialize(),
            dataType: "json",
            success: function (res) {
                if (res.success) {
                    showToast("Tạo admin thành công!");
                    $("#addAdminForm")[0].reset();
                } else {
                    showToast(res.message, "error");
                }
            },
            error: function () {
                showToast("Lỗi server", "error");
            }
        });
    });
</script>
</body>
</html>