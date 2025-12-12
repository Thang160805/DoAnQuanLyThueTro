<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.YeuCauThueTro"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="utils.DateHelper"%>
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
	href="${pageContext.request.contextPath}/assets/css/ChiTietYeuCauThue.css">
<style>
.badge-warn {
	background-color: #facc15;
}

.badge-success {
	background-color: #34d399;
}

.badge-error {
	background-color: #f87171;
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
	<div class="container">

		<div style="margin-bottom: 20px;">
			<a href="${pageContext.request.contextPath}/QuanLyTro"
				style="color: #64748b; text-decoration: none; font-size: 14px;">
				<i class="fa-solid fa-arrow-left"></i> Quay lại danh sách
			</a>
		</div>
		<%
		YeuCauThueTro yc = (YeuCauThueTro) request.getAttribute("ChiTietYeuCau");
		%>
		<div class="grid-layout">

			<div class="col-left">
				<%
				PhongTro pt = yc.getPhongTro();
				%>
				<div class="card">
					<div class="room-img-wrapper">
						<img src="<%=pt.getAnhChinh()%>" alt="Ảnh phòng trọ"
							class="room-img">
						<div
							style="position: absolute; top: 15px; left: 15px; background: white; padding: 5px 12px; border-radius: 20px; font-size: 12px; font-weight: 600; color: var(--text-main);">
							Cho thuê</div>
					</div>

					<h2 class="room-name"><%=pt.getTenPhong()%></h2>
					<div class="room-address">
						<i class="fa-solid fa-location-dot" style="color: #6366f1"></i>
						<%=pt.getDiaChi()%>
					</div>

					<div
						style="display: flex; justify-content: space-between; align-items: center;">
						<span class="price-tag"><%=CurrencyHelper.format(pt.getGiaThue())%>đ<span
							style="font-size: 14px; font-weight: 400; color: #64748b;">/tháng</span></span>
					</div>

					<div class="utilities">
						<div class="util-item">
							<i class="fa-solid fa-bolt" style="color: #f59e0b;"></i>
							<%=CurrencyHelper.format(pt.getGiaDien())%>đ/kWh
						</div>
						<div class="util-item">
							<i class="fa-solid fa-droplet" style="color: #0ea5e9;"></i>
							<%=pt.getGiaNuoc()%>đ/m³
						</div>
					</div>
				</div>
				<%
				TaiKhoan tk = yc.getTaiKhoan();
				%>
				<div class="card">
					<div class="card-title">Người yêu cầu thuê</div>
					<div class="user-profile">
						<img src="<%=tk.getAvatar()%>" alt="Avatar" class="user-avatar">
						<div class="user-info">
							<h3 class="user-name"><%=tk.getHoTen()%></h3>
							<div class="user-detail-row">
								<i class="fa-solid fa-phone"></i>
								<%=tk.getSDT()%>
							</div>
							<div class="user-detail-row">
								<i class="fa-regular fa-envelope"></i>
								<%=(tk != null && tk.getEmail() != null) ? tk.getEmail() : "Chưa có"%>
							</div>
							<div class="user-detail-row">
								<i class="fa-solid fa-id-card"></i>
								<%=tk.getCCCD()%>
							</div>
							<div class="user-detail-row">
								<i class="fa-solid fa-venus"></i>
								<%=(tk != null && tk.getGioiTinh() != -1) ? (tk.getGioiTinh() == 1 ? "Nam" : "Nữ") : ""%>
							</div>
							<div class="user-detail-row">
								<i class="fa-solid fa-map-pin"></i>
								<%=tk.getDiaChi()%>
							</div>
						</div>
					</div>
				</div>

			</div>

			<div class="col-right">

				<div class="card">
					<div class="card-title">
						Thông tin yêu cầu
						<%
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
						<span class="status-badge <%=badgeClass%>"><%=status%></span>
					</div>

					<ul class="info-list">
						<li class="info-item"><span class="label"><i
								class="fa-regular fa-calendar-check" style="margin-right: 8px;"></i>Ngày
								dọn vào</span> <span class="value"><%=DateHelper.formatVN(yc.getNgayDonVao())%></span>
						</li>
						<li class="info-item"><span class="label"><i
								class="fa-solid fa-clock-rotate-left" style="margin-right: 8px;"></i>Thời
								hạn thuê</span> <span class="value"><%=yc.getThoiHanThue()%></span></li>
						<li class="info-item"><span class="label"><i
								class="fa-solid fa-address-book" style="margin-right: 8px;"></i>Liên
								hệ qua</span> <span class="value"
							style="color: var(--primary); font-weight: 600;"><%=yc.getLienHe()%></span>
						</li>
					</ul>

					<div style="margin-top: 20px;">
						<span class="label" style="font-size: 14px;">Lời nhắn:</span>
						<div class="message-box">
							"<%=yc.getLoiNhan()%>"
						</div>
					</div>
				</div>

				<div class="card"
					style="border: none; background: transparent; box-shadow: none; padding: 0;">
					<div class="action-group">

						<button class="btn btn-approve" data-yeucau-id="<%=yc.getId()%>"
							data-nguoi-id="<%=yc.getID_TaiKhoan()%>">
							<i class="fa-solid fa-phone-volume"></i> Duyệt yêu cầu (Đã liên
							hệ)
						</button>

						<button class="btn btn-reject" data-yeucau-id="<%=yc.getId()%>"
							data-nguoi-id="<%=yc.getID_TaiKhoan()%>">
							<i class="fa-solid fa-xmark"></i> Hủy yêu cầu
						</button>

					</div>
					<p
						style="text-align: center; color: var(--text-light); font-size: 12px; margin-top: 12px;">
						Việc duyệt đồng nghĩa bạn đã liên hệ và xác nhận với người thuê.</p>
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
$(document).ready(function () {

    // NÚT DUYỆT
   $(".btn-approve").click(function () {
    let idYeuCau = $(this).data("yeucau-id");
    let idNguoi = $(this).data("nguoi-id");


        $.ajax({
            url: "/DoAnQLThueTro/CapNhatTrangThaiYeuCau",
            method: "POST",
            data: {
                idYeuCau: idYeuCau,
                idTaiKhoan: idNguoi,
                trangThai: "Đã liên hệ",
                title: "Chủ trọ đã duyệt yêu cầu thuê trọ của bạn",
                content: "Yêu cầu thuê phòng của bạn đã được chủ trọ chấp nhận.",
                fullcontent: "Chủ trọ đã duyệt và xác nhận yêu cầu thuê trọ của bạn. Vui lòng chờ chủ trọ liên hệ hoặc chủ động nhắn tin để trao đổi thêm thông tin và tiến hành tạo hợp đồng thuê."
            },
            success: function (res) {
                if (res.success) {
                    showToast("Đã duyệt yêu cầu!", "success");

                    setTimeout(() => {
                        window.location.href = "/DoAnQLThueTro/QuanLyTro";
                    }, 3000);

                } else {
                    showToast("Cập nhật thất bại!", "error");
                }
            },
            error: function () {
                showToast("Lỗi hệ thống!", "error");
            }
        });
    });

    // NÚT HỦY
    $(".btn-reject").click(function () {
    	let idYeuCau = $(this).data("yeucau-id");
        let idNguoi = $(this).data("nguoi-id");

        $.ajax({
            url: "/DoAnQLThueTro/CapNhatTrangThaiYeuCau",
            method: "POST",
            data: {
            	idYeuCau: idYeuCau,
                idTaiKhoan: idNguoi,
                trangThai: "Đã hủy",
                title: "Yêu cầu thuê trọ của bạn đã bị từ chối",
                content: "Rất tiếc, yêu cầu thuê phòng của bạn không được chấp nhận.",
                fullcontent: "Chủ trọ đã từ chối yêu cầu thuê phòng của bạn. Có thể phòng không còn trống hoặc không phù hợp điều kiện cho thuê. Bạn có thể tiếp tục tìm phòng khác hoặc gửi yêu cầu mới trong hệ thống."
            },
            success: function (res) {
                if (res.success) {
                    showToast("Đã hủy yêu cầu!", "error");

                    setTimeout(() => {
                        window.location.href = "/DoAnQLThueTro/QuanLyTro";
                    }, 3000);

                } else {
                    showToast("Không thể hủy yêu cầu!", "error");
                }
            },
            error: function () {
                showToast("Lỗi hệ thống!", "error");
            }
        });
    });

});
</script>
</body>
</html>