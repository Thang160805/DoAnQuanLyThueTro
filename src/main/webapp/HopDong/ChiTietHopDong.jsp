<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TienIch"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="model.bean.HopDong"%>
<%@ page import="utils.DateHelper"%>
<%@ page import="utils.CurrencyHelper"%>
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
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/footer.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ChiTietHopDong.css">
<style>
.status-badge {
	display: inline-flex;
	align-items: center;
	gap: 8px;
	padding: 8px 14px;
	border-radius: 30px;
	font-size: 13px;
	font-weight: 700;
}

.status-dot {
	width: 8px;
	height: 8px;
	border-radius: 50%;
}

.badge-success {
	background: #dcfce7;
	color: #166534;
}

.badge-success .status-dot {
	background: #22c55e;
	box-shadow: 0 0 0 2px #dcfce7;
}

.badge-error {
	background: #fee2e2;
	color: #991b1b;
}

.badge-error .status-dot {
	background: #ef4444;
	box-shadow: 0 0 0 2px #fee2e2;
}
</style>
</head>
<body>
	<div class="container">
		<%
		HopDong hd = (HopDong) request.getAttribute("ChiTietHD");
		PhongTro pt = (PhongTro) request.getAttribute("ChiTietPhong");
		TaiKhoan tkNguoiThue = (TaiKhoan) request.getAttribute("TaiKhoanNguoiThue");
		TaiKhoan tkChuTro = (TaiKhoan) request.getAttribute("TaiKhoanChuTro");
		ArrayList<TienIch> listTI = (ArrayList<TienIch>) request.getAttribute("listTienIch");
		%>
		<input type="hidden" id="ID_HopDong" value="<%=hd.getId()%>">
		<input type="hidden" id="ID_Phong" value="<%=pt.getID_Phong()%>">
		<input type="hidden" id="ID_NguoiThue" value="<%=tkNguoiThue.getId() %>">
		<input type="hidden" id="TenPhong" value="<%=pt.getTenPhong() %>">
		<header class="page-header">
			<div class="header-left">
				<a href="${pageContext.request.contextPath}/QuanLyTro"
					class="btn-back"><i class="fa-solid fa-arrow-left"></i> Quản lý</a>
				<div class="page-title">
					<h1>
						Hợp đồng #HD-2025/<%=(hd != null && hd.getId() != -1) ? hd.getId() : ""%></h1>
				</div>
			</div>
			<div>
				<%
				if ("Đang hiệu lực".equals(hd.getTrangThai())) {
				%>
				<span class="status-badge badge-success"> <span
					class="status-dot"></span>Hiệu lực
				</span>
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
		</header>

		<div class="grid-layout">

			<div class="col-left">

				<div class="card">
					<div class="section-header">
						<i class="fa-solid fa-user-tie section-icon"></i>
						<h2 class="section-title">Bên A (Chủ trọ)</h2>
					</div>
					<div class="profile-flex">
						<div class="avatar-box">
							<i class="fa-solid fa-user-tie"></i>
						</div>
						<div class="profile-details">
							<div class="profile-name"><%=(tkChuTro != null && tkChuTro.getHoTen() != null) ? tkChuTro.getHoTen() : ""%></div>
							<div class="info-row">
								<div class="info-group">
									<label>CCCD/CMND</label>
									<div class="value"><%=(tkChuTro != null && tkChuTro.getCCCD() != null) ? tkChuTro.getCCCD() : ""%></div>
								</div>
								<div class="info-group">
									<label>Số điện thoại</label>
									<div class="value"><%=(tkChuTro != null && tkChuTro.getSDT() != null) ? tkChuTro.getSDT() : ""%></div>
								</div>
							</div>
							<div class="info-group">
								<label>Địa chỉ thường trú</label>
								<div class="value"><%=(tkChuTro != null && tkChuTro.getDiaChi() != null) ? tkChuTro.getDiaChi() : ""%></div>
							</div>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="section-header">
						<i class="fa-solid fa-user section-icon"></i>
						<h2 class="section-title">Bên B (Người thuê)</h2>
					</div>
					<div class="profile-flex">
						<img
							src="<%=(tkNguoiThue != null && tkNguoiThue.getAvatar() != null) ? tkNguoiThue.getAvatar() : ""%>"
							alt="Tenant" class="avatar-box"
							style="object-fit: cover; border: none;">
						<div class="profile-details">
							<div class="profile-name"><%=(tkNguoiThue != null && tkNguoiThue.getHoTen() != null) ? tkNguoiThue.getHoTen() : ""%></div>
							<div class="info-row">
								<div class="info-group">
									<label>CCCD/CMND</label>
									<div class="value"><%=(tkNguoiThue != null && tkNguoiThue.getCCCD() != null) ? tkNguoiThue.getCCCD() : ""%></div>
								</div>
								<div class="info-group">
									<label>Số điện thoại</label>
									<div class="value"><%=(tkNguoiThue != null && tkNguoiThue.getSDT() != null) ? tkNguoiThue.getSDT() : ""%></div>
								</div>
							</div>
							<div class="info-group">
								<label>Email</label>
								<div class="value"><%=(tkNguoiThue != null && tkNguoiThue.getEmail() != null) ? tkNguoiThue.getEmail() : ""%></div>
							</div>
							<div
								style="margin-top: 10px; font-size: 12px; color: var(--text-light); font-style: italic;">
								<i class="fa-solid fa-circle-info"></i> Thông tin được lấy từ hồ
								sơ người thuê
							</div>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="section-header">
						<i class="fa-solid fa-house section-icon"></i>
						<h2 class="section-title">Thông tin phòng thuê</h2>
					</div>
					<div class="info-row">
						<div class="info-group">
							<label>Tên phòng</label>
							<div class="value"><%=(pt != null && pt.getTenPhong() != null) ? pt.getTenPhong() : ""%></div>
						</div>
						<div class="info-group">
							<label>Diện tích</label>
							<div class="value"><%=(pt != null && pt.getDienTich() != -1) ? pt.getDienTich() : ""%>
								m²
							</div>
						</div>
					</div>
					<div class="info-group">
						<label>Địa chỉ phòng</label>
						<div class="value"><%=(pt != null && pt.getDiaChi() != null) ? pt.getDiaChi() : ""%></div>
					</div>
					<div class="info-group" style="margin-top: 16px;">
						<label>Tiện ích bàn giao</label>
						<div class="amenity-list">
							<%
							for (TienIch ti : listTI) {
							%>
							<span class="amenity-badge"><i class="fa-solid fa-check"></i>
								<%=ti.getTenTienIch()%></span>
							<%
							}
							%>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="section-header">
						<i class="fa-solid fa-file-contract section-icon"></i>
						<h2 class="section-title">Điều khoản hợp đồng</h2>
					</div>
					<div class="terms-content">
						<%=(hd != null && hd.getDieuKhoan() != null) ? hd.getDieuKhoan() : ""%>
					</div>
				</div>

			</div>

			<div class="col-right">

				<div class="card">
					<div class="section-header">
						<i class="fa-regular fa-calendar-check section-icon"></i>
						<h2 class="section-title">Thời gian thuê</h2>
					</div>
					<div class="info-group" style="margin-bottom: 12px;">
						<label>Ngày bắt đầu</label>
						<div class="value"><%=(hd != null && hd.getNgayBatDau() != null) ? DateHelper.formatVN(hd.getNgayBatDau()) : ""%></div>
					</div>
					<div class="info-group" style="margin-bottom: 12px;">
						<label>Thời hạn thuê</label>
						<div class="value"><%=(hd != null && hd.getThoiHanThue() != null) ? hd.getThoiHanThue() : ""%></div>
					</div>
					<div class="info-group" style="margin-bottom: 12px;">
						<label>Ngày kết thúc</label>
						<div class="value" style="color: var(--primary);"><%=(hd != null && hd.getNgayKetThuc() != null) ? DateHelper.formatVN(hd.getNgayKetThuc()) : ""%></div>
					</div>
					<div class="info-group">
						<label>Ngày thanh toán</label>
						<div class="value">
							Ngày 0<%=(hd != null && hd.getNgayThanhToanHangThang() != null) ? hd.getNgayThanhToanHangThang() : ""%>
							hàng tháng
						</div>
					</div>
				</div>

				<div class="card">
					<div class="section-header">
						<i class="fa-solid fa-coins section-icon"></i>
						<h2 class="section-title">Chi phí</h2>
					</div>
					<div class="info-row">
						<div class="info-group">
							<label>Giá thuê</label>
							<div class="value"><%=(pt != null && pt.getGiaThue() != -1) ? CurrencyHelper.format(pt.getGiaThue()) : ""%>
								đ
							</div>
						</div>
						<div class="info-group">
							<label>Tiền cọc</label>
							<div class="value"><%=(hd != null && hd.getTienCoc() != -1) ? CurrencyHelper.format(hd.getTienCoc()) : ""%>
								đ
							</div>
						</div>
					</div>
					<div class="info-row">
						<div class="info-group">
							<label>Giá điện</label>
							<div class="value"><%=(pt != null && pt.getGiaDien() != -1) ? CurrencyHelper.format(pt.getGiaDien()) : ""%>
								đ/kWh
							</div>
						</div>
						<div class="info-group">
							<label>Giá nước</label>
							<div class="value"><%=(pt != null && pt.getGiaNuoc() != -1) ? CurrencyHelper.format(pt.getGiaNuoc()) : ""%>
								đ/m³
							</div>
						</div>
					</div>

					<div class="financial-summary">
						<div class="fin-row">
							<span>Tiền thuê tháng đầu</span> <span><%=(pt != null && pt.getGiaThue() != -1) ? CurrencyHelper.format(pt.getGiaThue()) : ""%>
								đ</span>
						</div>
						<div class="fin-row">
							<span>Tiền cọc</span> <span><%=(hd != null && hd.getTienCoc() != -1) ? CurrencyHelper.format(hd.getTienCoc()) : ""%>
								đ</span>
						</div>
						<div class="fin-total">
							<span class="fin-total-label">TỔNG THANH TOÁN</span> <span
								class="fin-total-value"><%=(hd != null && hd.getTongThuBanDau() != -1) ? CurrencyHelper.format(hd.getTongThuBanDau()) : ""%>
								đ</span>
						</div>
					</div>
				</div>

				<%
				if (hd != null && "Đang hiệu lực".equals(hd.getTrangThai())) {
				%>
				<div class="action-container" id="actionContainer">
					<button class="btn btn-danger" onclick="openEndContractModal()">
						<i class="fa-solid fa-ban"></i> Kết thúc hợp đồng
					</button>
				</div>
				<%
				}
				%>

			</div>
		</div>
	</div>

	<div class="modal-overlay" id="endContractModal">
		<div class="modal-box">
			<div class="modal-icon">
				<i class="fa-solid fa-triangle-exclamation"></i>
			</div>
			<h3 class="modal-title">Kết thúc hợp đồng?</h3>
			<p class="modal-desc">
				Bạn có chắc chắn muốn kết thúc hợp đồng thuê phòng này?<br>
				Hành động này sẽ chuyển trạng thái hợp đồng sang <b>"Đã kết
					thúc"</b> và cập nhật phòng thành <b>"Còn trống"</b>.
			</p>
			<div class="modal-actions">
				<button class="btn btn-outline" style="flex: 1;"
					onclick="closeEndContractModal()">Hủy bỏ</button>
				<button class="btn btn-confirm" style="flex: 1;"
					onclick="confirmEndContract()">Xác nhận</button>
			</div>
		</div>
	</div>
	<div id="toast"
		style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

	<script>
	const modal = document.getElementById('endContractModal');

    function openEndContractModal() {
        modal.classList.add('active');
    }

    function closeEndContractModal() {
        modal.classList.remove('active');
    }

    function renderStatus() {
        const actionEl = document.getElementById('actionContainer');
        if (actionEl) {
            actionEl.style.display = 'none';
        }
    }
    let currentStatus = 'active'; 
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


   
    // 3. Logic Kết Thúc Hợp Đồng
function confirmEndContract() {
    const idHopDong = document.getElementById("ID_HopDong").value;
    const idPhong = document.getElementById("ID_Phong").value;
    const idNguoiThue = document.getElementById("ID_NguoiThue").value;
    const tenPhong = document.getElementById("TenPhong").value;
    const confirmBtn = document.querySelector('.btn-confirm');
    confirmBtn.innerText = 'Đang xử lý...';
    confirmBtn.disabled = true;

    $.ajax({
        url: "/DoAnQLThueTro/XuLyKetThucHopDong",
        type: "POST",
        dataType: "json",
        data: {
            ID_HopDong: idHopDong,
            ID_Phong: idPhong,
            ID_NguoiThue: idNguoiThue,
            TenPhong: tenPhong
        },

        success: function (res) {
            if (res.success) {
                currentStatus = 'ended';
                renderStatus();
                closeEndContractModal();

                showToast("Kết thúc hợp đồng thành công", "success");

                setTimeout(() => {
                    window.location.href = "/DoAnQLThueTro/QuanLyTro";
                }, 3000);
            } else {
                showToast(res.message || "Không thể kết thúc hợp đồng", "error");
                confirmBtn.disabled = false;
                confirmBtn.innerText = "Xác nhận";
            }
        },

        error: function () {
            showToast("Lỗi hệ thống, vui lòng thử lại", "error");
            confirmBtn.disabled = false;
            confirmBtn.innerText = "Xác nhận";
        }
    });
}
</script>


</body>
</html>