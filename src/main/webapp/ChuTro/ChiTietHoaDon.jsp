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
	href="${pageContext.request.contextPath}/assets/css/ChiTietHoaDon.css">
<style>
body {
	font-family: "Open Sans", sans-serif;
	background-color: #f8fafc;
	color: #1e293b;
	padding: 40px 0;
}
.btn-edit-invoice {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background-color: #ffffff;
    color: #6366f1;
    border: 1.5px solid #6366f1;
    padding: 10px 20px;
    border-radius: 12px;
    font-weight: 600;
    text-decoration: none;
    transition: all 0.2s ease;
}

.btn-edit-invoice:hover {
    background-color: #6366f1;
    color: #ffffff;
    transform: translateY(-2px);
}

.btn-delete-invoice {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    background-color: #fee2e2;
    color: #ef4444;
    border: none;
    padding: 10px 20px;
    border-radius: 12px;
    font-weight: 600;
    transition: all 0.2s ease;
}

.btn-delete-invoice:hover {
    background-color: #ef4444;
    color: #ffffff;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(239, 68, 68, 0.2);
}

.action-footer {
    margin-top: -12px;
    padding: 20px;
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
					<span class="label">Kỳ thanh toán</span> <span class="value"><%=hd.getThangNam()%></span>
				</div>
				<div class="meta-item">
					<span class="label">Hạn thanh toán</span> <span class="value"><%=DateHelper.formatVN(hd.getHanThanhToan())%></span>
				</div>
				<div class="meta-item">
					<%
					DateTimeFormatter format = DateTimeFormatter.ofPattern("dd/MM/yyyy");
					%>
					<span class="label">Ngày tạo hóa đơn</span> <span class="value"><%=hd.getCreated_at().format(format)%></span>
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
							class="value fw-bold text-primary"><%=hd.getTenPhong()%></span>
					</div>
					<div class="info-group">
						<span class="label">Người thuê</span> <span class="value fw-bold"><%=hd.getTenNguoiThue()%></span>
					</div>
				</div>
				<div class="info-row">
					<div class="info-group">
						<span class="label">Địa chỉ phòng</span> <span class="value"><%=hd.getDiaChiPhong()%></span>
					</div>
					<div class="info-group">
						<%
						TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTin");
						%>
						<span class="label">Chủ trọ</span> <span class="value"><%=tk.getHoTen()%></span>
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
								phòng <%=hd.getThangNam()%></small>
						</div>
						<div class="cost-amount"><%=CurrencyHelper.format(hd.getTienPhong())%>
							₫
						</div>
					</div>

					<div class="cost-row">
						<div class="cost-desc">
							<span class="fw-bold">Tiền điện</span> <small>Số kWh: <%=hd.getTienDien() / hd.getGiaDien()%>
								• Đơn giá: <%=CurrencyHelper.format(hd.getGiaDien())%> ₫/kWh
							</small>
						</div>
						<div class="cost-amount"><%=CurrencyHelper.format(hd.getTienDien())%>
							₫
						</div>
					</div>

					<div class="cost-row">
						<div class="cost-desc">
							<span class="fw-bold">Tiền nước</span> <small>Số m³: <%=hd.getTienNuoc() / hd.getGiaNuoc()%>
								• Đơn giá: <%=CurrencyHelper.format(hd.getGiaNuoc())%> ₫/m³
							</small>
						</div>
						<div class="cost-amount"><%=CurrencyHelper.format(hd.getTienNuoc())%>
							₫
						</div>
					</div>

					<div class="total-section">
						<div class="total-label">TỔNG TIỀN THANH TOÁN</div>
						<div class="total-value"><%=CurrencyHelper.format(hd.getTongTien())%>
							₫
						</div>
					</div>
				</div>
			</div>

			<div class="card">
				<div class="section-title">
					<i class="fa-solid fa-comment-dots"></i> Ghi chú hóa đơn
				</div>
				<%
				if (hd.getGhiChu() == null) {
				%>
				<div class="note-box">Không có ghi chú</div>
				<%
				} else {
				%>
				<div class="note-box"><%=hd.getGhiChu()%></div>
				<%
				}
				%>

			</div>
		</div>
		<%
		if ("Chưa thanh toán".equals(trangThai) || "Trễ hạn".equals(trangThai)) {
		%>
		<div class="card action-footer"
			style="display: flex; justify-content: flex-end; gap: 12px; background: #f8fafc; border-top: 1px solid #e2e8f0;">
			<a
				href="${pageContext.request.contextPath}/SuaHoaDon?id=<%=hd.getId()%>"
				class="btn-edit-invoice"> <i class="fa-solid fa-pen-to-square"></i>
				Sửa hóa đơn
			</a>

			<button onclick="confirmDelete(<%=hd.getId()%>)"
				class="btn-delete-invoice">
				<i class="fa-solid fa-trash-can"></i> Xóa hóa đơn
			</button>
		</div>
		<%
		}
		%>
	</div>
	<div id="toast"
		style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<script>
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
function confirmDelete(idHoaDon) {
    swal({
        title: "Xác nhận xóa?",
        text: "Hóa đơn này sẽ bị xóa vĩnh viễn và không thể khôi phục!",
        icon: "warning",
        buttons: ["Hủy bỏ", "Xóa ngay"],
        dangerMode: true,
    }).then((willDelete) => {
        if (willDelete) {
            $.ajax({
                url: "/DoAnQLThueTro/XuLyXoaHoaDon",
                type: "POST",
                dataType: "json",
                data: {
                    id: idHoaDon
                },
                success: function (res) {
                    if (res.success) {
                        showToast(res.message || "Xóa hóa đơn thành công");

                        setTimeout(() => {
                            window.location.href ="/DoAnQLThueTro/QuanLyTro";
                        }, 1200);
                    } else {
                        showToast(res.message || "Không thể xóa hóa đơn", "error");
                    }
                },
                error: function () {
                    showToast("Lỗi server khi xóa hóa đơn", "error");
                }
            });
        }
    });
}
</script>
</body>
</html>