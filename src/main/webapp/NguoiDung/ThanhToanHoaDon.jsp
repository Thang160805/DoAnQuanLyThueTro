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
<title>Thanh toán</title>
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
	href="${pageContext.request.contextPath}/assets/css/ThanhToanHoaDon.css">
	<style>
	body {
	font-family: "Open Sans", sans-serif;
	background-color: #f8fafc;
	color: #1e293b;
	margin: 0;
	-webkit-font-smoothing: antialiased;
}
	</style>
</head>
<body>
	<%
	HoaDon hd = (HoaDon) request.getAttribute("ChiTietHoaDon");
	TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTin");
	%>
	<div class="pay-container">
		<header class="pay-header">
			<a
				href="${pageContext.request.contextPath}/ChiTietHoaDonThanhToan?id=<%=hd.getId() %>"
				class="back-link"><i class="fa-solid fa-chevron-left"></i> Quay
				lại</a>
			<div class="invoice-status-group">
				<span class="invoice-id">Hóa đơn #<%=hd.getId()%></span>
				<%
				String statusClass = "";
				String statusText = "";

				if ("Chưa thanh toán".equals(hd.getTrangThai())) {
					statusClass = "status-pending";
					statusText = "Chưa thanh toán";
				} else if ("Trễ hạn".equals(hd.getTrangThai())) {
					statusClass = "status-overdue";
					statusText = "Trễ hạn";
				}
				%>
				<span class="badge <%=statusClass%>"> <span class="dot"></span>
					<%=statusText%>
				</span>
			</div>
		</header>

		<div class="pay-grid">
			<aside class="qr-column" id="qrColumn">
				<div class="card qr-card">
					<h3 class="qr-title">Quét mã để thanh toán</h3>
					<div class="qr-wrapper">
						<img
							src='<%=hd.getQRThanhToan()%>?amount=<%=hd.getTongTien()%>&addInfo=HD_<%=hd.getId()%>_<%=hd.getThangNam()%>' />
						<div class="qr-brand">VietQR | Napas247</div>
					</div>

					<div class="bank-details"></div>

					<p class="qr-note">
						<i class="fa-solid fa-circle-info"></i> Vui lòng chuyển khoản đúng
						nội dung để hệ thống xác nhận tự động.
					</p>

					<div class="qr-action-area">
						<button class="btn-complete-payment"
							onclick="notifyServer(<%=hd.getId()%>)">
							<i class="fa-solid fa-check-to-slot"></i> Tôi đã hoàn thành
							chuyển khoản
						</button>
						<p class="sub-text-btn">Nhấn sau khi bạn đã thực hiện giao
							dịch trên App ngân hàng</p>
					</div>
				</div>
			</aside>

			<main class="info-column">
				<section class="card detail-card">
					<div class="card-title">
						<i class="fa-solid fa-house-user"></i> Thông tin đối tượng
					</div>
					<div class="info-grid">
						<div class="info-group">
							<span class="label">Tên phòng</span> <span
								class="value room-name"><%=hd.getTenPhong()%></span>
						</div>
						<div class="info-group">
							<span class="label">Người thuê</span> <span class="value"><%=tk.getHoTen()%></span>
						</div>
						<div class="info-group">
							<span class="label">Chủ trọ</span> <span class="value"><%=hd.getTenChuTro()%></span>
						</div>
						<div class="info-group">
							<span class="label">Địa chỉ phòng</span> <span class="value"><%=hd.getDiaChiPhong()%></span>
						</div>
					</div>
				</section>

				<section class="card detail-card">
					<div class="card-title">
						<i class="fa-solid fa-receipt"></i> Chi phí kỳ này
					</div>
					<div class="cost-list">
						<div class="cost-item">
							<div class="cost-desc">
								Tiền phòng (<%=hd.getThangNam()%>)
							</div>
							<div class="cost-value"><%=CurrencyHelper.format(hd.getTienPhong())%>
								₫
							</div>
						</div>
						<div class="cost-item">
							<div class="cost-desc">
								<span>Tiền điện</span> <small>Sử dụng: <%=hd.getTienNuoc() / hd.getGiaNuoc()%>
									kWh • Đơn giá: <%=CurrencyHelper.format(hd.getGiaDien())%>
									₫/kWh
								</small>
							</div>
							<div class="cost-value"><%=CurrencyHelper.format(hd.getTienDien())%>
								₫
							</div>
						</div>
						<div class="cost-item">
							<div class="cost-desc">
								<span>Tiền nước</span> <small>Sử dụng: <%=hd.getTienNuoc() / hd.getGiaNuoc()%>
									m³ • Đơn giá: <%=CurrencyHelper.format(hd.getGiaNuoc())%> ₫/m³
								</small>
							</div>
							<div class="cost-value"><%=CurrencyHelper.format(hd.getTienNuoc())%>
								₫
							</div>
						</div>
					</div>

					<div class="total-pay">
						<span class="total-label">Tổng tiền thanh toán</span> <span
							class="total-amount"><%=CurrencyHelper.format(hd.getTongTien())%>
							VNĐ</span>
					</div>
				</section>
			</main>
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


			    toast.html(iconHTML + message);


			    toast.css({ opacity: "1", transform: "translateY(0)" });


			    setTimeout(() => {
			        toast.css({ opacity: "0", transform: "translateY(20px)" });
			    }, 5000);
			}
			function notifyServer(idHoaDon) {
			    if (!idHoaDon) {
			        showToast("Không tìm thấy hóa đơn", "error");
			        return;
			    }

			    $.ajax({
			        url: "<%=request.getContextPath()%>/XuLyThanhToanHoaDon",
			        type: "POST",
			        dataType: "json",
			        data: {
			            idHoaDon: idHoaDon
			        },
			        success: function (res) {
			            if (res.success) {
			                showToast(res.message || "Đã ghi nhận thanh toán");

			                setTimeout(() => {
			                    window.location.href =
			                        "<%=request.getContextPath()%>/LichThanhToan";
			                }, 1200);
			            } else {
			                showToast(res.message || "Không thể xác nhận thanh toán", "error");
			            }
			        },
			        error: function () {
			            showToast("Lỗi server khi xác nhận thanh toán", "error");
			        }
			    });
			}
			
</script>
</body>
</html>