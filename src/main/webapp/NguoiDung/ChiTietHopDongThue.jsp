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
<%@ page import="model.bo.TaiKhoanBO"%>
<%@ page import="model.bo.PhongTroBO"%>
<%@ page import="model.bo.TienIchBO"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết hợp đồng</title>
<!-- Google Fonts: Poppins (Hiện đại, tròn trịa giống Airbnb) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap"
	rel="stylesheet">

<!-- Bootstrap 5 CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome Icons -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/ChiTietHopDongThue.css">
<style>
a {
	text-decoration: none;
	color: inherit;
	transition: 0.2s;
}
</style>
</head>
<body>
	<%
	HopDong hd = (HopDong) request.getAttribute("ChiTietHD");
	int ID_NguoiThue = hd.getID_NguoiThue();
	int ID_ChuTro = hd.getID_ChuTro();
	int ID_Phong = hd.getID_Phong();
	PhongTroBO ptBO = new PhongTroBO();
	PhongTro pt = ptBO.getPhongTroById(ID_Phong);
	TaiKhoanBO tkBO = new TaiKhoanBO();
	TaiKhoan tkNguoiThue = tkBO.getThongTinCaNhan(ID_NguoiThue);
	TaiKhoan tkChuTro = tkBO.getThongTinCaNhan(ID_ChuTro);
	TienIchBO tiBO = new TienIchBO();
	ArrayList<TienIch> list = tiBO.getListTienIchByIDPhong(ID_Phong);
	%>
	<div class="dashboard-container">
		<header class="page-header">
			<a href="${pageContext.request.contextPath}/HopDong" class="btn-back">
				<i class="fa-solid fa-arrow-left"></i> Quản lý
			</a>
			<div class="header-main">
				<div class="header-title-group">
					<i data-lucide="file-text" class="icon-contract"></i>
					<h1>
						Hợp đồng #<%=hd.getId()%></h1>
					<span class="badge badge-expired"><%=hd.getTrangThai()%></span>
				</div>
			</div>
		</header>

		<main class="content-layout">
			<section class="main-info">
				<div class="party-grid">
					<div class="card party-card">
						<h3>BÊN A – CHỦ TRỌ</h3>
						<div class="party-content">
							<div class="avatar-placeholder">
								<i style="font-size: 30px;" class="fa-solid fa-user-astronaut"></i>
							</div>
							<div class="details">
								<p class="name"><%=(tkChuTro != null && tkChuTro.getHoTen() != null) ? tkChuTro.getHoTen() : ""%></p>
								<p>
									<span>CCCD:</span>
									<%=(tkChuTro != null && tkChuTro.getCCCD() != null) ? tkChuTro.getCCCD() : ""%></p>
								<p>
									<span>SĐT:</span>
									<%=(tkChuTro != null && tkChuTro.getSDT() != null) ? tkChuTro.getSDT() : ""%></p>
								<p>
									<span>Địa chỉ:</span>
									<%=(tkChuTro != null && tkChuTro.getDiaChi() != null) ? tkChuTro.getDiaChi() : ""%></p>
							</div>
						</div>
					</div>

					<div class="card party-card">
						<h3>BÊN B – NGƯỜI THUÊ</h3>
						<div class="party-content">
							<img
								src="<%=(tkNguoiThue != null && tkNguoiThue.getAvatar() != null) ? tkNguoiThue.getAvatar() : ""%>"
								alt="Avatar" class="avatar-img">
							<div class="details">
								<p class="name"><%=(tkNguoiThue != null && tkNguoiThue.getHoTen() != null) ? tkNguoiThue.getHoTen() : "Khách"%></p>
								<p>
									<span>CCCD:</span>
									<%=(tkNguoiThue != null && tkNguoiThue.getCCCD() != null) ? tkNguoiThue.getCCCD() : ""%></p>
								<p>
									<span>SĐT:</span>
									<%=(tkNguoiThue != null && tkNguoiThue.getSDT() != null) ? tkNguoiThue.getSDT() : ""%></p>
								<p>
									<span>Email:</span>
									<%=(tkNguoiThue != null && tkNguoiThue.getEmail() != null) ? tkNguoiThue.getEmail() : ""%></p>
								<small class="note">Thông tin từ hồ sơ người thuê</small>
							</div>
						</div>
					</div>
				</div>

				<div class="card room-info">
					<h3>THÔNG TIN PHÒNG THUÊ</h3>
					<div class="room-header">
						<div class="room-title">
							<h4><%=(pt != null && pt.getTenPhong() != null) ? pt.getTenPhong() : ""%></h4>
							<span>Diện tích: <%=(pt != null && pt.getDienTich() != -1) ? pt.getDienTich() : ""%>
								m²
							</span>
						</div>
						<p class="address">
							<i data-lucide="map-pin"></i>
							<%=(pt != null && pt.getDiaChi() != null) ? pt.getDiaChi() : ""%></p>
					</div>
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
					<div class="amenities">
						<%
						for (TienIch ti : list) {
							String name = ti.getTenTienIch();
							String icon = iconMap.getOrDefault(name, "fas fa-check");
						%>
						<span class="tag"><i class="<%=icon%>"></i> <%=name%></span>
						<%
						}
						%>
					</div>
				</div>

				<div class="card contract-terms">
					<h3>ĐIỀU KHOẢN HỢP ĐỒNG</h3>
					<div class="terms-box">
						<p><%=(hd != null && hd.getDieuKhoan() != null) ? hd.getDieuKhoan() : ""%></p>
					</div>
				</div>
			</section>

			<aside class="sidebar-info">
				<div class="card side-card">
					<div class="card-header">
						<i data-lucide="calendar"></i> THỜI GIAN THUÊ
					</div>
					<div class="side-item">
						<span>Bắt đầu:</span>
						<%=DateHelper.formatVN(hd.getNgayBatDau())%></div>
					<div class="side-item">
						<span>Thời hạn:</span>
						<%=hd.getThoiHanThue()%></div>
					<div class="side-item">
						<span>Kết thúc:</span>
						<%=DateHelper.formatVN(hd.getNgayKetThuc())%></div>
					<div class="side-item highlight">
						<span>Ngày thanh toán:</span> Ngày
						<%=hd.getNgayThanhToanHangThang().length() == 1
		? "0" + hd.getNgayThanhToanHangThang()
		: hd.getNgayThanhToanHangThang()%>

						hàng tháng
					</div>
				</div>

				<div class="card side-card">
					<div class="card-header">
						<i data-lucide="credit-card"></i> CHI PHÍ
					</div>
					<div class="side-item">
						<span>Giá thuê:</span>
						<%=CurrencyHelper.format(pt.getGiaThue())%>
						đ
					</div>
					<div class="side-item">
						<span>Tiền cọc:</span>
						<%=CurrencyHelper.format(hd.getTienCoc())%>
						đ
					</div>
					<div class="side-item">
						<span>Giá điện:</span>
						<%=CurrencyHelper.format(pt.getGiaDien())%>
						đ/kWh
					</div>
					<div class="side-item">
						<span>Giá nước:</span>
						<%=CurrencyHelper.format(pt.getGiaNuoc())%>
						đ/m³
					</div>

					<div class="total-box">
						<div class="total-main">
							<span>TỔNG THANH TOÁN</span> <strong><%=CurrencyHelper.format(hd.getTongThuBanDau())%>
								đ</strong>
						</div>
					</div>
				</div>
				<%
				if (hd.getTrangThai().equals("Đang hiệu lực")) {
				%>
				<div class="card action-card">
					<p class="action-help">Bạn muốn chấm dứt thuê phòng trước thời
						hạn?</p>
					<button type="button" class="btn-cancel-contract" data-hd="<%=hd.getId()%>"
						data-chutro="<%=hd.getID_ChuTro()%>" data-tenphong="<%= pt.getTenPhong()%>">
						<i data-lucide="file-x"></i> Gửi yêu cầu hủy hợp đồng
					</button>
				</div>
				<%
				}
				%>
			</aside>
		</main>
	</div>
	<div id="toast"
		style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
		<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
		
		<script>
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
		
		$(document).on("click", ".btn-cancel-contract", function (e) {
		    e.preventDefault();

		    const btn = $(this);
		    const idHopDong = btn.data("hd");
		    const idChuTro = btn.data("chutro");
		    const tenPhong = btn.data("tenphong");

		    Swal.fire({
		        title: "Xác nhận hủy hợp đồng",
		        text: `Bạn có chắc chắn muốn gửi yêu cầu hủy hợp đồng phòng "${tenPhong}" không?`,
		        icon: "warning",
		        showCancelButton: true,
		        confirmButtonText: "Gửi yêu cầu",
		        cancelButtonText: "Hủy",
		        confirmButtonColor: "#dc2626"
		    }).then((result) => {
		        if (!result.isConfirmed) return;

		        $.ajax({
		            url: "/DoAnQLThueTro/XuLyYeuCauHuyHopDong",
		            type: "POST",
		            dataType: "json",
		            data: {
		                idHopDong,
		                idChuTro,
		                tenPhong
		            },
		            success: function (res) {
		                if (res && res.success) {
		                    Swal.fire(
		                        "Thành công",
		                        "Đã gửi yêu cầu hủy hợp đồng. Vui lòng chờ chủ trọ xử lý.",
		                        "success"
		                    );

		                    setTimeout(() => {
		                        window.location.href = "/DoAnQLThueTro/HopDong";
		                    }, 2500);
		                } else {
		                    Swal.fire("Lỗi", res.message || "Không thể gửi yêu cầu", "error");
		                }
		            },
		            error: function () {
		                Swal.fire("Lỗi", "Có lỗi hệ thống xảy ra", "error");
		            }
		        });
		    });
		});

		</script>

</body>
</html>