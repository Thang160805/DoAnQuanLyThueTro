<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="utils.DateHelper"%>
<%@ page import="model.bean.PhongTro"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Font Google: Poppins & Inter -->
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&family=Inter:wght@400;500;600&display=swap"
	rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<!-- Toastify CSS (Thông báo đẹp) -->

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/CaiDatCT.css">

</head>
<body>
	<div class="sidebar">
		<a class="navbar-brand"
			href="${pageContext.request.contextPath}/QuanLyTro"> <i
			class="fa-solid fa-house-chimney"></i> FindRoom
		</a>

		<nav class="nav-group">
			<button class="nav-item active" onclick="openTab('profile', this)">
				<i class="fa-regular fa-id-card"></i> Thông tin cá nhân
			</button>
			<button class="nav-item" onclick="openTab('password', this)">
				<i class="fa-solid fa-lock"></i> Đổi mật khẩu
			</button>
			<button class="nav-item" onclick="openTab('delete', this)"
				style="margin-top: auto; color: #ef4444;">
				<i class="fa-solid fa-trash-can"></i> Xóa tài khoản
			</button>
		</nav>

	</div>
	<%
	TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTinCaNhan");
	%>
	<div class="content-area">
		<div class="container">
			<div id="profile" class="tab-content active">
				<div class="section-header">
					<h2 class="section-title">Hồ sơ cá nhân</h2>
					<p class="section-desc">Cập nhật thông tin hiển thị của bạn để
						người thuê dễ dàng liên hệ.</p>
				</div>

				<div class="card left-card">

					<form id="avatarForm" enctype="multipart/form-data">

						<div class="avatar-container">

							<img
								src="<%=(tk != null && tk.getAvatar() != null) ? tk.getAvatar() : ""%>"
								id="avatar-preview" class="avatar-img" alt="Avatar">

							<!-- input file phải đúng ID avatar-upload để uploadAvatar() hoạt động -->
							<input type="file" id="avatar-upload" name="avatar"
								accept="image/*" hidden onchange="uploadAvatar()">

							<!-- nút mở file -->
							<button type="button" class="btn-camera-small"
								onclick="document.getElementById('avatar-upload').click()"
								title="Đổi ảnh đại diện">
								<i class="fa-solid fa-camera"></i>
							</button>

						</div>

					</form>


					<div class="profile-main-info">
						<h3 class="user-title"><%=(tk != null && tk.getHoTen() != null) ? tk.getHoTen() : ""%></h3>
						<div class="premium-badge">
							<i class="fa-solid fa-crown"></i> Premium
						</div>
					</div>
					<% int countSoPhong = (int) request.getAttribute("countSoPhong");
					TaiKhoan tk1 = (TaiKhoan) request.getAttribute("NgayTao");
					%>
					<div class="info-list">
						<div class="info-item">
							<span class="label">Ngày tham gia</span> <span class="value"><%= DateHelper.formatDateTime(tk1.getNgayTao()) %></span>
						</div>
						<div class="info-item">
							<span class="label">Phòng quản lý</span> <span class="value"><%= (countSoPhong!=-1) ? countSoPhong : "" %>
								Phòng</span>
						</div>
						<div class="info-item">
							<span class="label">Trạng thái</span> <span
								class="value status-active"> <i
								class="fa-solid fa-circle-check"></i> Đang hoạt động
							</span>
						</div>
					</div>

				</div>

				<form id="updateInfoForm">

					<div class="form-grid">

						<div class="form-group">
							<label class="form-label">Họ và tên</label>
							<div class="input-wrapper">
								<input type="text" name="HoTen" class="form-input" value=""
									placeholder="<%=(tk != null && tk.getHoTen() != null) ? tk.getHoTen() : ""%>">
								<i class="fa-regular fa-user input-icon"></i>
							</div>
						</div>

						<div class="form-group">
							<label class="form-label">Số điện thoại (Zalo)</label>
							<div class="input-wrapper">
								<input type="tel" name="SDT" class="form-input" value=""
									placeholder="<%=(tk != null && tk.getSDT() != null) ? tk.getSDT() : ""%>">
								<i class="fa-solid fa-phone input-icon"></i>
							</div>
						</div>

						<div class="form-group">
							<label class="form-label">Số CCCD / CMND</label>
							<div class="input-wrapper">
								<input type="text" name="CCCD" class="form-input" value=""
									placeholder="<%=(tk != null && tk.getCCCD() != null) ? tk.getCCCD() : ""%>">
								<i class="fa-regular fa-id-card input-icon"></i>
							</div>
						</div>

						<div class="form-group">
							<label class="form-label">Ngày sinh</label>
							<div class="input-wrapper">
								<input type="date" name="NgaySinh" class="form-input"
									value="<%=(tk != null && tk.getNgaySinh() != null) ? tk.getNgaySinh() : ""%>">
								<i class="fa-regular fa-calendar input-icon"></i>
							</div>
						</div>

						<div class="form-group">
							<label class="form-label">Giới tính</label>
							<div class="input-wrapper">
								<select class="form-select" name="GioiTinh">
									<option value="1" selected>Nam</option>
									<option value="2">Nữ</option>
								</select> <i class="fa-solid fa-venus-mars input-icon"></i>
							</div>
						</div>

						<div class="form-group">
							<label class="form-label">Email đăng nhập</label>
							<div class="input-wrapper">
								<input type="email" name="Email" class="form-input"
									placeholder="<%=(tk != null && tk.getEmail() != null) ? tk.getEmail() : ""%>"
									value="" disabled> <i
									class="fa-regular fa-envelope input-icon"></i>
							</div>
						</div>

						<div class="form-group full">
							<label class="form-label">Địa chỉ liên hệ</label>
							<div class="input-wrapper">
								<input type="text" name="DiaChi" class="form-input" value=""
									placeholder="<%=(tk != null && tk.getDiaChi() != null) ? tk.getDiaChi() : ""%>">
								<i class="fa-solid fa-map-pin input-icon"></i>
							</div>
						</div>

					</div>

					<div
						style="text-align: right; margin-top: 32px; padding-top: 24px; border-top: 1px solid #e2e8f0;">
						<button class="btn-primary" type="submit">
							<i class="fa-solid fa-floppy-disk"></i> Lưu thay đổi
						</button>
					</div>

				</form>

			</div>

			<div id="password" class="tab-content">
				<div class="section-header">
					<h2 class="section-title">Đổi mật khẩu</h2>
					<p class="section-desc">Cập nhật mật khẩu định kỳ để bảo vệ tài
						khoản của bạn.</p>
				</div>

				<form id="changePassForm">
					<div class="card" style="max-width: 600px;">

						<div class="form-group" style="margin-bottom: 24px;">
							<label class="form-label">Mật khẩu hiện tại</label>
							<div class="input-wrapper">
								<input type="password" name="currentPass" class="form-input"
									placeholder="••••••••"> <i
									class="fa-solid fa-lock input-icon"></i>
							</div>
						</div>

						<div class="form-group" style="margin-bottom: 24px;">
							<label class="form-label">Mật khẩu mới</label>
							<div class="input-wrapper">
								<input type="password" name="newPass" class="form-input"
									placeholder="Ít nhất 8 ký tự"> <i
									class="fa-solid fa-key input-icon"></i>
							</div>
						</div>

						<div class="form-group" style="margin-bottom: 32px;">
							<label class="form-label">Xác nhận mật khẩu mới</label>
							<div class="input-wrapper">
								<input type="password" name="confirmPass" class="form-input"
									placeholder="Nhập lại mật khẩu mới"> <i
									class="fa-solid fa-check-double input-icon"></i>
							</div>
						</div>

						<div
							style="background: #f0fdf4; border: 1px solid #bbf7d0; padding: 12px 16px; border-radius: 8px; margin-bottom: 24px; font-size: 13px; color: #166534; display: flex; align-items: center; gap: 8px;">
							<i class="fa-solid fa-shield-halved"></i> Mật khẩu mạnh giúp bảo
							vệ tài khoản tốt hơn.
						</div>

						<button type="submit" class="btn-primary">Cập nhật mật
							khẩu</button>

					</div>
				</form>
			</div>


			<div id="delete" class="tab-content">
				<div class="section-header">
					<h2 class="section-title" style="color: #ef4444;">Vùng nguy
						hiểm</h2>
					<p class="section-desc">Các hành động tại đây không thể hoàn
						tác.</p>
				</div>

				<div class="danger-zone">
					<h4 class="danger-title">
						<i class="fa-solid fa-triangle-exclamation"></i> Xóa tài khoản
						vĩnh viễn
					</h4>
					<p class="danger-text">
						Khi bạn xóa tài khoản, toàn bộ dữ liệu về phòng trọ, danh sách
						người thuê, hóa đơn và lịch sử giao dịch sẽ bị xóa khỏi hệ thống
						FindRoom. <br> Người thuê sẽ không còn thấy thông tin liên hệ
						của bạn nữa.
					</p>

					<div style="max-width: 400px; margin-bottom: 24px;">
						<label class="form-label" style="color: #9f1239;">Nhập mật
							khẩu để xác nhận</label>
						<div class="input-wrapper">
							<input type="password" class="form-input"
								placeholder="Mật khẩu của bạn" style="border-color: #fda4af;">
							<i class="fa-solid fa-lock input-icon" style="color: #fda4af;"></i>
						</div>
					</div>

					<button class="btn-danger">Tôi hiểu, xóa tài khoản này</button>
				</div>
			</div>

		</div>
	</div>


	<div id="toast"
		style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

	<script>
        // Chuyển Tab
        function openTab(tabId, element) {
            document.querySelectorAll('.tab-content').forEach(tab => tab.classList.remove('active'));
            document.querySelectorAll('.nav-item').forEach(nav => nav.classList.remove('active'));
            document.getElementById(tabId).classList.add('active');
            element.classList.add('active');
        }

        // Preview Ảnh
        function previewImage(event) {
            const reader = new FileReader();
            reader.onload = function() {
                document.getElementById('avatarPreview').src = reader.result;
            }
            if(event.target.files[0]) {
                reader.readAsDataURL(event.target.files[0]);
            }
        }

        // Hiện Toast Notification
        function showToast(message, type = "success") {
		    const toast = $("#toast");

		    // Icon hiển thị theo loại
		    let iconHTML = "";

		    if (type === "error") {
		        toast.css("background-color", "#dc2626"); // đỏ
		        iconHTML = `<i class="fa-solid fa-circle-xmark" style="color:#fecaca; margin-right:8px;"></i>`;
		    } else {
		        toast.css("background-color", "#2563eb"); // xanh
		        iconHTML = `<i class="fa-solid fa-circle-check" style="color:#4ade80; margin-right:8px;"></i>`;
		    }

		    // Set nội dung kèm icon
		    toast.html(iconHTML + message);

		    // hiện
		    toast.css({ opacity: "1", transform: "translateY(0)" });

		    // tự tắt sau 5 giây
		    setTimeout(() => {
		        toast.css({ opacity: "0", transform: "translateY(20px)" });
		    }, 5000);
		}
        
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

            // KHÔNG ĐƯỢC KHAI BÁO formData 2 LẦN
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
                    } else {
                        showToast(res.message, "error");
                    }
                },
                error: function () {
                    showToast("Lỗi server!", "error");
                }
            });
        }
        
        $(document).ready(function () {
            $("#changePassForm").on("submit", function (e) {
                e.preventDefault(); // Ngăn reload trang

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
                        } else {
                            showToast(response.message, "error");
                        }
                    }
                });
            });
        });
        
        $(document).ready(function () {
            $("#updateInfoForm").on("submit", function (e) {
                e.preventDefault(); // Ngăn reload trang

                $.ajax({
                    url: "/DoAnQLThueTro/UpdateProfile",
                    type: "post",
                    dataType: "json",
                    data: $(this).serialize(),  // Tự động gom tất cả name=""
                    success: function (response) {
                        if (response.status === "success") {
                            showToast(response.message); // dùng toast bạn đã có
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
    </script>

</body>
</html>