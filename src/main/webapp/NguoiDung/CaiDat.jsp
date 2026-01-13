<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.HopDong"%>
<%@ page import="model.bean.BaoHong"%>
<%@ page import="utils.DateHelper"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cài đặt</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/CaiDat.css">
<style>
body {
	font-family: "Open Sans", sans-serif;
	background-color: #f3f4f6;
	color: #1f2937;
	height: 100vh;
	display: flex;
	overflow: hidden;
}
.status-badge {
	font-size: 0.75rem;
	font-weight: 600;
	padding: 0.25rem 0.6rem;
	border-radius: 6px;
	display: inline-block;
}

.status-pending {
	background: #fef3c7;
	color: #92400e;
}

.status-process {
	background: #e0f2fe;
	color: #2563eb;
}

.status-done {
	background: #dcfce7;
	color: #16a34a;
}

.status-reject {
	background: #fee2e2;
	color: #dc2626;
}

.upload-area {
	border: 2px dashed #e5e7eb;
	border-radius: 12px;
	padding: 1.5rem;
	text-align: center;
	cursor: pointer;
	transition: all 0.2s ease-in-out;
}

.upload-area:hover {
	border-color: #2563eb;
	background-color: #f8fafc;
}

.preview-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(90px, 1fr));
    gap: 10px;
    margin-top: 10px;
}

.preview-item {
    position: relative;
}

.preview-item img {
    width: 100%;
    height: 90px;
    object-fit: cover;
    border-radius: 8px;
    border: 1px solid #e5e7eb;
}

.preview-remove {
    position: absolute;
    top: -6px;
    right: -6px;
    background: #ef4444;
    color: #fff;
    border-radius: 50%;
    width: 20px;
    height: 20px;
    font-size: 12px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
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
	<aside class="sidebar">
		<div class="sidebar-header">
			<a class="navbar-brand"
				href="${pageContext.request.contextPath}/ProcessHomeUser"> <i
				class="fa-solid fa-house-chimney"></i> FindRoom
			</a>



		</div>
		<nav id="sidebar-nav" class="sidebar-nav">
			<div class="nav-label">Cài đặt chung</div>

			<button onclick="switchTab('profile', this)" class="nav-item active">
				<i class="fa-regular fa-user"></i> Thông tin tài khoản
			</button>

			<button onclick="switchTab('reports', this)" class="nav-item">
				<i class="fa-solid fa-screwdriver-wrench"></i> Báo cáo sự cố
			</button>

			<button onclick="switchTab('security', this)" class="nav-item">
				<i class="fa-solid fa-shield-halved"></i> Bảo mật & Đăng nhập
			</button>


			<div class="nav-label" style="margin-top: 2rem;">Vùng nguy hiểm</div>

			<button onclick="switchTab('delete', this)" class="nav-item danger">
				<i class="fa-solid fa-trash-can"></i> Xoá tài khoản
			</button>
		</nav>

		<div class="sidebar-footer">
			<a href="${pageContext.request.contextPath}/Logout" class="nav-item"
				style="color: #dc2626;"> <i
				class="fa-solid fa-arrow-right-from-bracket"></i> Đăng xuất
			</a>
		</div>
	</aside>

	<main class="main-content">
		<div class="container">
			<%
			TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTinCaNhan");
			%>

			<div id="profile" class="tab-content">
				<div class="page-header">
					<h2 class="page-title">Thông tin tài khoản</h2>
					<p class="page-subtitle">Quản lý thông tin hồ sơ cá nhân của
						bạn trên FindRoom.</p>
				</div>


				<div class="card">
					<form id="avatarForm" enctype="multipart/form-data">
						<div class="avatar-section">
							<div class="avatar-wrapper">
								<img id="avatar-preview"
									src="<%=(tk != null && tk.getAvatar() != null) ? tk.getAvatar() : ""%>"
									alt="Avatar" class="avatar-img"> <label
									for="avatar-upload" class="avatar-upload-icon"> <i
									class="fa-solid fa-camera"></i>
								</label> <input type="file" id="avatar-upload" name="avatar"
									class="hidden" accept="image/*" onchange="uploadAvatar()">
							</div>

							<div style="flex: 1;">
								<h3>Ảnh đại diện</h3>
								<p
									style="color: #6b7280; font-size: 0.875rem; margin-bottom: 1rem;">Chấp
									nhận file PNG, JPG, JPEG. Tối đa 5MB.</p>

								<div class="flex gap-3">
									<!-- chỉ mở file, KHÔNG submit -->
									<button type="button" class="btn btn-light"
										onclick="document.getElementById('avatar-upload').click()">
										Tải ảnh lên</button>
								</div>
							</div>
						</div>
					</form>
				</div>

				<div class="card">
					<form id="updateInfoForm">
						<div class="form-grid">
							<div class="form-group col-span-2">
								<label class="form-label">Họ và tên</label>
								<div class="input-wrapper">
									<i class="fa-regular fa-user input-icon"></i> <input
										type="text" class="form-input" name="HoTen"
										value="<%=(tk != null && tk.getHoTen() != null) ? tk.getHoTen() : ""%>">
								</div>
							</div>
							<div class="form-group">
								<label class="form-label">CCCD</label>
								<div class="input-wrapper">
									<i class="fa-solid fa-briefcase input-icon"></i> <input
										type="text" name="CCCD" class="form-input"
										value="<%=(tk != null && tk.getCCCD() != null) ? tk.getCCCD() : ""%>">
								</div>
							</div>

							
							<div class="form-group">
								<label class="form-label">Email</label>
								<div class="input-wrapper">
									<i class="fa-regular fa-envelope input-icon"></i> <input
										type="email" name="Email" class="form-input"
										value="<%=(tk != null && tk.getEmail() != null) ? tk.getEmail() : ""%>">
								</div>
							</div>

							
							<div class="form-group">
								<label class="form-label">Số điện thoại</label>
								<div class="input-wrapper">
									<i class="fa-solid fa-phone input-icon"></i> <input type="tel"
										name="SDT" class="form-input"
										value="<%=(tk != null && tk.getSDT() != null) ? tk.getSDT() : ""%>">
								</div>
							</div>

							
							<div class="form-group">
								<label class="form-label">Giới tính</label>
								<div class="input-wrapper">
									<i class="fa-solid fa-venus-mars input-icon"></i> <select
										name="GioiTinh" class="form-select">
										<option value="1" selected>Nam</option>
										<option value="2">Nữ</option>
									</select>
								</div>
							</div>

							
							<div class="form-group">
								<label class="form-label">Ngày sinh</label>
								<div class="input-wrapper">
									<i class="fa-regular fa-calendar input-icon"></i> <input
										type="date"
										value="<%=(tk != null && tk.getNgaySinh() != null) ? tk.getNgaySinh() : ""%>"
										name="NgaySinh" class="form-input">
								</div>
							</div>

							
							<div class="form-group col-span-2">
								<label class="form-label">Địa chỉ</label>
								<div class="input-wrapper">
									<i class="fa-solid fa-map-pin input-icon"></i> <input
										type="text" name="DiaChi" class="form-input"
										value="<%=(tk != null && tk.getDiaChi() != null) ? tk.getDiaChi() : ""%>">
								</div>
							</div>

							
							<div class="flex justify-between items-center"
								style="margin-top: 2rem; padding-top: 1.5rem; border-top: 1px solid #f3f4f6;">


								<button type="submit" class="btn btn-primary">Lưu thay
									đổi</button>

							</div>

						</div>
					</form>
				</div>
			</div>
			<div id="reports" class="tab-content hidden">
				<form id="baoCaoSuCoForm" enctype="multipart/form-data">

					<div class="page-header">
						<h2 class="page-title">Báo cáo sự cố</h2>
						<p class="page-subtitle">Gửi yêu cầu sửa chữa các thiết bị hư
							hỏng trong phòng trọ.</p>
					</div>

					<div class="card">
						<h3
							style="font-size: 1.1rem; font-weight: 700; margin-bottom: 1.5rem;">Tạo
							báo cáo mới</h3>
						<div class="form-grid">
							<div class="form-group col-span-2">
								<label class="form-label">Tiêu đề sự cố</label>
								<div class="input-wrapper">
									<i class="fa-solid fa-heading input-icon"></i> <input
										type="text" class="form-input" name="tieuDe"
										placeholder="Ví dụ: Vòi nước bồn rửa bị rò rỉ...">
								</div>
							</div>
							<div class="form-group col-span-2">
								<label class="form-label">Phòng xảy ra sự cố</label>
								<div class="input-wrapper">
									<i class="fa-solid fa-door-open input-icon"></i> <select
										class="form-select" name="phongId" required>
										<%
										ArrayList<HopDong> listPT = (ArrayList<HopDong>) request.getAttribute("listPhongThue");
										for (HopDong hd : listPT) {
										%>
										<option value="<%=hd.getID_Phong()%>"><%=hd.getTenPhong()%></option>
										<%
										}
										%>
									</select>
								</div>
								<p
									style="font-size: 0.75rem; color: #6b7280; margin-top: 0.25rem;">
									Lưu ý: Chỉ những phòng bạn đang có hợp đồng hiệu lực mới hiển
									thị ở đây.</p>
							</div>

							<div class="form-group">
								<label class="form-label">Loại hư hỏng</label>
								<div class="input-wrapper">
									<i class="fa-solid fa-screwdriver input-icon"></i> <select
										class="form-select" name="loaiHuHong">
										<option value="" disabled selected>Chọn danh mục</option>
										<option value="Điện">Điện (Bóng đèn, ổ cắm...)</option>
										<option value="Nước">Nước (Vòi, ống dẫn, rò rỉ...)</option>
										<option value="Nội thật">Nội thất (Giường, tủ,
											bàn...)</option>
										<option value="Kết cấu">Kết cấu (Tường, cửa sổ,
											sàn...)</option>
										<option value="Khác">Khác</option>
									</select>
								</div>
							</div>

							<div class="form-group">
								<label class="form-label">Mức độ ưu tiên</label>
								<div class="input-wrapper">
									<i class="fa-solid fa-triangle-exclamation input-icon"></i> <select
										class="form-select" name="mucDoUuTien">
										<option value="Thấp">Thấp</option>
										<option value="Trung Bình" selected>Trung bình</option>
										<option value="Cao">Cao</option>
										<option value="Khẩn cấp">Khẩn cấp (Cần ngay)</option>
									</select>
								</div>
							</div>

							<div class="form-group col-span-2">
								<label class="form-label">Mô tả chi tiết tình trạng</label>
								<textarea rows="4" class="form-textarea" name="moTa"
									placeholder="Mô tả kỹ hơn về vấn đề (khi nào bị hỏng, mức độ ảnh hưởng...)"></textarea>
							</div>

							<div class="form-group col-span-2">
								<label class="form-label">Hình ảnh minh chứng sự cố (Tối
									đa 5 ảnh)</label> <input type="file" id="fileInput" name="images"
									accept="image/*" multiple hidden>

								<div class="upload-area" id="dropZone"
									onclick="document.getElementById('fileInput').click()">
									<i class="fa-solid fa-images"
										style="font-size: 2rem; color: #6366f1; margin-bottom: 0.5rem;"></i>
									<p
										style="font-weight: 600; color: #1e293b; margin-bottom: 0.25rem;">Nhấn
										để chọn ảnh hoặc kéo thả vào đây</p>
									<p style="font-size: 0.75rem; color: #64748b;">Dung lượng
										tối đa 10MB/ảnh (PNG, JPG)</p>
								</div>

								<div id="previewContainer" class="preview-grid"></div>
							</div>
						</div>

						<div class="flex justify-between items-center"
							style="margin-top: 1.5rem;">
							<button class="btn btn-secondary">Hủy bỏ</button>
							<button class="btn btn-primary">
								<i class="fa-regular fa-paper-plane"></i> Gửi yêu cầu
							</button>
						</div>
					</div>
				</form>
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
				%>
				<% ArrayList<BaoHong> listBH = (ArrayList<BaoHong>) request.getAttribute("listBH");
				%>

				<div class="card">
					<div class="flex justify-between items-center"
						style="margin-bottom: 1.5rem;">
						<h3 style="font-size: 1.1rem; font-weight: 700;">Lịch sử báo
							cáo</h3>
						<button class="btn btn-secondary"
							style="font-size: 0.8rem; padding: 0.4rem 0.8rem;">Xem
							tất cả</button>
					</div>

					<div class="flex" style="flex-direction: column; gap: 0.5rem;">

						<%
						if (listBH == null || listBH.isEmpty()) {
						%>

						<!-- KHÔNG CÓ BÁO CÁO -->
						<div
							style="text-align: center; padding: 1rem; color: #6b7280; font-size: 0.9rem;">
							Chưa có báo cáo sự cố nào</div>

						<%
						} else {
						for (BaoHong bh : listBH) {

							String trangThai = bh.getTrangThai();
							String statusText = "";
							String statusClass = "";

							if ("Chờ xử lý".equals(trangThai)) {
								statusText = "Chờ xử lý";
								statusClass = "status-pending";
							} else if ("Đang xử lý".equals(trangThai)) {
								statusText = "Đang xử lý";
								statusClass = "status-process";
							} else if ("Hoàn thành".equals(trangThai)) {
								statusText = "Đã hoàn thành";
								statusClass = "status-done";
							} else if ("Từ chối".equals(trangThai)) {
								statusText = "Từ chối";
								statusClass = "status-reject";
							}
							String mau = bgMap.getOrDefault(bh.getLoaiHuHong(), "#f3f4f6|#374151");
							String[] colors = mau.split("\\|");
							String bgColor = colors[0];
							String iconColor = colors[1];
							String iconClass = iconMap.getOrDefault(bh.getLoaiHuHong(), "fa-solid fa-ellipsis");
						%>

						<div class="list-item"
							<%="Hoàn thành".equals(trangThai) ? "style='opacity:0.7'" : ""%>>
							<div class="flex items-center gap-3">
								<div class="device-icon" style="background-color:<%= bgColor %>; color:<%= iconColor %>;">
									<i class="<%=iconClass%>"></i>
								</div>
								<div>
									<h4 style="font-weight: 600; font-size: 0.95rem;">
										<%=bh.getTieuDe()%>
									</h4>
									<%
									DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
									%>
									<p style="font-size: 0.75rem; color: var(--text-secondary);">
										Gửi ngày:
										 <%= bh.getThoiGianGui().format(formatter) %>
										•
										<%=bh.getLoaiHuHong()%>
									</p>
								</div>
							</div>
							<span class="status-badge <%=statusClass%>"> <%=statusText%>
							</span>
						</div>

						<%
						}
						}
						%>

					</div>
				</div>
			</div>

			<!-- TAB 2: BẢO MẬT -->
			<div id="security" class="tab-content hidden">
				<div class="page-header">
					<h2 class="page-title">Bảo mật & Đăng nhập</h2>
					<p class="page-subtitle">Bảo vệ tài khoản và quản lý các phiên
						đăng nhập.</p>
				</div>

				<!-- Change Password -->
				<div class="card">
					<h3
						style="font-size: 1.1rem; font-weight: 700; margin-bottom: 1rem; padding-bottom: 0.5rem; border-bottom: 1px solid #f3f4f6;">
						Đổi mật khẩu</h3>

					<form id="changePassForm"
						style="max-width: 500px; display: flex; flex-direction: column; gap: 1rem;">

						<div class="form-group">
							<label class="form-label">Mật khẩu hiện tại</label> <input
								type="password" name="currentPass" placeholder="••••••••"
								class="form-input" style="padding-left: 1rem;">
						</div>

						<div class="form-group">
							<label class="form-label">Mật khẩu mới</label> <input
								type="password" name="newPass" placeholder="••••••••"
								class="form-input" style="padding-left: 1rem;">
						</div>

						<div class="form-group">
							<label class="form-label">Nhập lại mật khẩu mới</label> <input
								type="password" name="confirmPass" placeholder="••••••••"
								class="form-input" style="padding-left: 1rem;">
						</div>

						<div style="margin-top: 0.5rem;">
							<button type="submit" class="btn"
								style="background-color: #1f2937; color: white;">Cập
								nhật mật khẩu</button>
						</div>

					</form>
				</div>


				<!-- Active Sessions -->
				<div class="card">
					<div class="flex justify-between items-center"
						style="margin-bottom: 1rem; border-bottom: 1px solid #f3f4f6; padding-bottom: 0.5rem;">
						<h3 style="font-size: 1.1rem; font-weight: 700;">Thiết bị
							đang đăng nhập</h3>
						<button class="btn btn-secondary"
							style="font-size: 0.8rem; padding: 0.5rem 1rem;">Đăng
							xuất tất cả</button>
					</div>

					<div style="display: flex; flex-direction: column; gap: 0.5rem;">
						<!-- Device 1 -->
						<div class="list-item">
							<div class="flex items-center gap-3">
								<div class="device-icon bg-green-light">
									<i class="fa-solid fa-desktop"></i>
								</div>
								<div>
									<h4 style="font-weight: 600; font-size: 0.95rem;">Windows
										PC - Chrome</h4>
									<p style="font-size: 0.75rem; color: #6b7280;">Hà Nội •
										Đang hoạt động</p>
								</div>
							</div>
							<span class="badge-current">Hiện tại</span>
						</div>

						<!-- Device 2 -->
						<div class="list-item">
							<div class="flex items-center gap-3">
								<div class="device-icon bg-gray-light">
									<i class="fa-solid fa-mobile-screen-button"></i>
								</div>
								<div>
									<h4 style="font-weight: 600; font-size: 0.95rem;">iPhone
										14 Pro - App</h4>
									<p style="font-size: 0.75rem; color: #6b7280;">Hà Nội • 2
										giờ trước</p>
								</div>
							</div>
							<button class="btn btn-secondary" style="padding: 0.5rem;">
								<i class="fa-solid fa-arrow-right-from-bracket"></i>
							</button>
						</div>
					</div>
				</div>
			</div>







			<div id="delete" class="tab-content hidden">
				<div class="page-header">
					<h2 class="page-title" style="color: #dc2626;">Vùng nguy hiểm</h2>
					<p class="page-subtitle">Các hành động tại đây có thể ảnh hưởng
						vĩnh viễn đến tài khoản của bạn.</p>
				</div>

				<div class="card card-danger">
					<div
						style="position: absolute; right: -20px; top: -20px; color: #fee2e2; font-size: 8rem; z-index: 0; opacity: 0.5; pointer-events: none;">
						<i class="fa-solid fa-triangle-exclamation"></i>
					</div>

					<div style="position: relative; z-index: 1;">
						<h3
							style="font-size: 1.25rem; font-weight: 700; color: #b91c1c; margin-bottom: 0.5rem;">Xóa
							tài khoản vĩnh viễn</h3>
						<p
							style="color: #b91c1c; font-size: 0.9rem; line-height: 1.6; margin-bottom: 1.5rem; max-width: 600px;">
							Hành động này <strong>không thể hoàn tác</strong>. Một khi bạn
							xóa tài khoản: <br>- Toàn bộ thông tin hồ sơ sẽ bị xóa. <br>-
							Các bài đăng tìm phòng/cho thuê sẽ bị gỡ bỏ. <br>- Lịch sử
							tin nhắn và giao dịch sẽ mất vĩnh viễn.
						</p>

						<div
							style="display: flex; gap: 1rem; flex-wrap: wrap; align-items: flex-end; padding-top: 1.5rem; border-top: 1px solid #fecaca;">
							<div style="flex: 1; min-width: 250px;">
								<label
									style="display: block; font-size: 0.75rem; font-weight: 700; color: #b91c1c; text-transform: uppercase; margin-bottom: 0.25rem;">Xác
									nhận mật khẩu</label> <input type="password"
									placeholder="Nhập mật khẩu để xác nhận" class="form-input"
									style="border-color: #fca5a5; padding-left: 1rem;">
							</div>
							<button class="btn btn-danger">Xóa vĩnh viễn</button>
						</div>
					</div>
				</div>
			</div>

		</div>
		</main>
		<div id="toast"
			style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
		</div>
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script>
        function switchTab(tabId, element) {
            document.querySelectorAll('.tab-content').forEach(content => {
                content.classList.add('hidden');
            });
            
            document.getElementById(tabId).classList.remove('hidden');
            document.querySelectorAll('.nav-item').forEach(item => {
                item.classList.remove('active');
            });
            element.classList.add('active');
            const nav = document.getElementById('sidebar-nav');
            if (window.innerWidth < 768) {
                nav.classList.remove('show');
            }
        }
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function(){
                const output = document.getElementById('avatar-preview');
                output.src = reader.result;
            };
            if(event.target.files[0]) {
                reader.readAsDataURL(event.target.files[0]);
            }
        }

        window.addEventListener('resize', () => {
             const nav = document.getElementById('sidebar-nav');
             if (window.innerWidth >= 768) {
                 nav.classList.remove('show');
                 nav.style.display = '';
             }
        });
        
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
        
        $(document).ready(function () {
            $("#changePassForm").on("submit", function (e) {
                e.preventDefault();

                $.ajax({
                    url: "/DoAnQLThueTro/ChangePass",
                    type: "post",
                    data: {
                        CurrentPass: $("input[name='currentPass']").val(),
                        NewPass: $("input[name='newPass']").val(),
                        ConfirmPass: $("input[name='confirmPass']").val()
                    },
                    success: function (response) {
                        if (response.status === "success") {
                            showToast("Đổi mật khẩu thành công!");
                            setTimeout(() => {
                                window.location.href = "/DoAnQLThueTro/CaiDat";
                            }, 3000);
                        } else {
                            showToast(response.message, "error");
                        }
                    }
                });
            });
        });
        
        $(document).ready(function () {
            $("#updateInfoForm").on("submit", function (e) {
                e.preventDefault();

                $.ajax({
                    url: "/DoAnQLThueTro/UpdateProfile",
                    type: "post",
                    dataType: "json",
                    data: $(this).serialize(),
                    success: function (response) {
                        if (response.status === "success") {
                            showToast(response.message);
                            setTimeout(() => {
                                window.location.href = "/DoAnQLThueTro/CaiDat";
                            }, 3000);
                        } else {
                            showToast(response.message, "error");
                        }
                    },
                    error: function () {
                        showToast("Có lỗi xảy ra!", "error");
                    }
                });
            });
        });
        
        function uploadAvatar() {
            let file = document.getElementById("avatar-upload").files[0];

            if (!file) {
                showToast("Bạn chưa chọn ảnh!", "error");
                return;
            }

            if (file.size > 5 * 1024 * 1024) {
                showToast("File vượt quá 5MB!", "error");
                return;
            }
            let formData = new FormData();

            formData.append("avatar", file);
            formData.append("username", localStorage.getItem("username"));
            formData.append("password", localStorage.getItem("password"));

            $.ajax({
                url: "/DoAnQLThueTro/UpLoadAvatar",
                type: "POST",
                data: formData,
                contentType: false,
                processData: false,
                dataType: "json",
                success: function (res) {
                    if (res.status === "success") {
                        showToast("Cập nhật ảnh thành công!");
                        $("#avatar-preview").attr("src", res.newAvatar);
                        setTimeout(() => {
                            window.location.href = "/DoAnQLThueTro/CaiDat";
                        }, 3000);
                    } else {
                        showToast(res.message, "error");
                    }
                },
                error: function () {
                    showToast("Lỗi server!", "error");
                }
            });
        }
        
        const fileInput = document.getElementById("fileInput");
        const previewContainer = document.getElementById("previewContainer");

        let selectedFiles = [];

        fileInput.addEventListener("change", function () {
            const files = Array.from(this.files);

            files.forEach(file => {

                if (selectedFiles.length >= 5) {
                    alert("Chỉ được chọn tối đa 5 ảnh");
                    return;
                }

                if (!file.type.startsWith("image/")) return;

                selectedFiles.push(file);

                const reader = new FileReader();

                reader.onload = function () {
                    const div = document.createElement("div");
                    div.className = "preview-item";

                    const img = document.createElement("img");
                    img.src = reader.result;

                    const removeBtn = document.createElement("div");
                    removeBtn.className = "preview-remove";
                    removeBtn.innerHTML = "&times;";

                    removeBtn.onclick = function () {
                        const index = Array.from(previewContainer.children).indexOf(div);
                        selectedFiles.splice(index, 1);
                        div.remove();
                        updateFileInput();
                    };

                    div.appendChild(img);
                    div.appendChild(removeBtn);
                    previewContainer.appendChild(div);
                };

                reader.readAsDataURL(file);
            });

            updateFileInput();
        });

        function updateFileInput() {
            const dataTransfer = new DataTransfer();
            selectedFiles.forEach(file => dataTransfer.items.add(file));
            fileInput.files = dataTransfer.files;
        }
        
        $(document).ready(function () {
            $("#baoCaoSuCoForm").on("submit", function (e) {
                e.preventDefault(); 

                let formData = new FormData(this);

                $.ajax({
                    url: "/DoAnQLThueTro/XuLyBaoCaoSuCo",
                    type: "post",
                    data: formData,
                    processData: false,
                    contentType: false, 
                    success: function (response) {
                        if (response.status === "success") {
                            showToast("Gửi báo cáo sự cố thành công!");
                            $("#baoCaoSuCoForm")[0].reset();
                            $("#previewContainer").empty();
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