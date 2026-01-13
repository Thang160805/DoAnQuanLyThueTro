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
<title>Sửa hóa đơn</title>
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
	href="${pageContext.request.contextPath}/assets/css/SuaHoaDon.css">
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
	<%
	HoaDon hd = (HoaDon) request.getAttribute("ChiTietHoaDon");
	%>
	<div class="container">
		<form id="updateHD" class="card" >
			<input type="hidden" id="idHoaDon" name="id" value="<%=hd.getId()%>">

			<div class="header-edit">
				<i class="fa-solid fa-pen-to-square"></i>
				<div>
					<h2 style="margin: 0; font-size: 20px;">
						Chỉnh sửa hóa đơn #<%=hd.getId()%></h2>
					<small style="color: #64748b;">Chỉnh sửa các chi phí điện,
						nước và ghi chú cho phòng <%=hd.getTenPhong()%></small>
				</div>
			</div>

			<div class="form-grid">
				<div class="form-group">
					<label class="label">Phòng</label> <input type="text"
						class="form-control readonly" value="<%=hd.getTenPhong()%>"
						readonly>
				</div>
				<div class="form-group">
					<label class="label">Người thuê</label> <input type="text"
						class="form-control readonly" value="<%=hd.getTenNguoiThue()%>"
						readonly>
				</div>

				<div class="form-group">
					<label class="label">Kỳ thanh toán (MM/YYYY)</label> <input
						type="month" name="thangNam" class="form-control"
						value="<%=hd.getThangNam()%>" required>
				</div>
				<div class="form-group">
					<label class="label">Hạn thanh toán</label> <input type="date"
						name="hanThanhToan" class="form-control"
						value="<%=hd.getHanThanhToan()%>" required>
				</div>

				<div class="full calc-box">
					<div class="form-grid">
						<input type="hidden" id="rentPrice" name="TienPhong"
							value="<%=hd.getTienPhong()%>">

						<div class="form-group">
							<label class="label">Tiền Phòng</label> <input type="text"
								class="form-control readonly"
								value="<%=utils.CurrencyHelper.format(hd.getTienPhong())%> ₫"
								readonly>
						</div>

						<div class="form-group">
							<label class="label">Trạng thái</label> <select name="trangThai"
								class="form-control">
								<option value="Chưa thanh toán"
									<%=hd.getTrangThai().equals("Chưa thanh toán") ? "selected" : ""%>>Chưa
									thanh toán</option>
								<option value="Trễ hạn"
									<%=hd.getTrangThai().equals("Trễ hạn") ? "selected" : ""%>>Trễ
									hạn</option>
							</select>
						</div>

						<div class="cost-box full"
							style="background: #ffffff; padding: 20px; border-radius: 12px; border: 1px solid #e2e8f0; margin-bottom: 15px;">
							<label class="form-label"><i
								class="fa-solid fa-bolt text-warning"></i> Tiền điện</label>
							<div class="form-grid-mini"
								style="display: flex; gap: 15px; margin-bottom: 10px;">
								<input type="number" class="form-control" id="elecUsage"
									value="<%=hd.getTienDien() / hd.getGiaDien()%>"
									placeholder="Số kWh sử dụng" min="0" oninput="calcElec()">

								<input type="number" class="form-control readonly" id="elecUnit"
									value="<%=hd.getGiaDien()%>" placeholder="Đơn giá" readonly>
							</div>
							<input type="number" name="TienDien" id="elecTotal"
								class="form-control mt-2 readonly"
								style="text-align: right; font-weight: 700; color: #6366f1;"
								readonly value="<%=hd.getTienDien()%>">
						</div>

						<div class="cost-box full"
							style="background: #ffffff; padding: 20px; border-radius: 12px; border: 1px solid #e2e8f0;">
							<label class="form-label"><i
								class="fa-solid fa-droplet text-primary"></i> Tiền nước</label>
							<div class="form-grid-mini"
								style="display: flex; gap: 15px; margin-bottom: 10px;">
								<input type="number" class="form-control" id="waterUsage"
									value="<%=hd.getTienNuoc() / hd.getGiaNuoc()%>"
									placeholder="Số m³ sử dụng" min="0" oninput="calcWater()">

								<input type="number" class="form-control readonly"
									id="waterUnit" value="<%=hd.getGiaNuoc()%>"
									placeholder="Đơn giá" readonly>
							</div>
							<input type="number" name="TienNuoc" id="waterTotal"
								class="form-control mt-2 readonly"
								style="text-align: right; font-weight: 700; color: #6366f1;"
								readonly value="<%=hd.getTienNuoc()%>">
						</div>
					</div>

					<div class="total-display"
						style="margin-top: 25px; padding-top: 20px; border-top: 2px dashed #e2e8f0; display: flex; justify-content: space-between; align-items: center;">
						<span style="font-weight: 800; color: #475569;">TỔNG TIỀN
							THANH TOÁN:</span> <input type="hidden" name="TongTien" id="hiddenTotal"
							value="<%=hd.getTongTien()%>"> <span
							class="total-amount" id="displayTotal"
							style="font-size: 24px; font-weight: 800; color: #6366f1;"><%=utils.CurrencyHelper.format(hd.getTongTien())%>
							₫</span>
					</div>

					<p id="warningText"
						style="color: #ef4444; font-size: 13px; margin-top: 10px; display: none;">
						<i class="fa-solid fa-circle-info"></i> Vui lòng nhập đủ chi phí
						sử dụng.
					</p>
				</div>

				<div class="form-group full">
					<label class="label">Ghi chú sửa đổi</label>
					<textarea name="ghiChu" class="form-control" rows="3"
						placeholder="Lý do thay đổi chi phí..."><%=hd.getGhiChu() != null ? hd.getGhiChu() : ""%></textarea>
				</div>
			</div>

			<div class="btn-group">
				<button type="button" class="btn btn-cancel"
					onclick="history.back()">Hủy bỏ</button>
				<button type="submit" class="btn btn-save">Cập nhật hóa đơn</button>
			</div>
		</form>
	</div>
	<div id="toast"
		style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
	function calcElec() {
	    const usage = parseFloat(document.getElementById('elecUsage').value);
	    const unit = parseFloat(document.getElementById('elecUnit').value) || 0;

	    let total = 0;
	    if (!isNaN(usage) && usage > 0) {
	        total = usage * unit;
	    }

	    document.getElementById('elecTotal').value = total;
	    updateFinalTotal();
	}

	function calcWater() {
	    const usage = parseFloat(document.getElementById('waterUsage').value);
	    const unit = parseFloat(document.getElementById('waterUnit').value) || 0;

	    let total = 0;
	    if (!isNaN(usage) && usage > 0) {
	        total = usage * unit;
	    }

	    document.getElementById('waterTotal').value = total;
	    updateFinalTotal();
	}

	function updateFinalTotal() {
	    const rent = parseFloat(document.getElementById('rentPrice').value) || 0;
	    const elec = parseFloat(document.getElementById('elecTotal').value) || 0;
	    const water = parseFloat(document.getElementById('waterTotal').value) || 0;

	    const total = rent + elec + water;

	    document.getElementById('displayTotal').innerText =
	        total.toLocaleString('vi-VN') + ' ₫';
	    document.getElementById('hiddenTotal').value = total;

	    // Nút submit và cảnh báo
	    const btnSubmit = document.getElementById('btnSubmit'); // Đảm bảo nút Gửi của bạn có ID này
	    const warning = document.getElementById('warningText');

	    const elecUsage = parseFloat(document.getElementById('elecUsage')?.value || 0);
	    const waterUsage = parseFloat(document.getElementById('waterUsage')?.value || 0);

	    // Logic kiểm tra để bật/tắt nút gửi
	    if (btnSubmit && warning) {
	        if (total > 0 && (elecUsage > 0 || waterUsage > 0)) {
	            btnSubmit.disabled = false;
	            warning.style.display = 'none';
	        } else {
	            btnSubmit.disabled = true;
	            warning.style.display = 'block';
	        }
	    }
	}

	// Chạy tính toán ngay khi load trang để hiển thị con số từ database
	window.onload = function() {
	    updateFinalTotal();
	};
		
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
		$("#updateHD").on("submit", function (e) {
		    e.preventDefault();

		    const formData = $(this).serialize();
		    const idHoaDon = $("#idHoaDon").val();
		    $.ajax({
		        url: "/DoAnQLThueTro/XuLySuaHoaDon",
		        type: "POST",
		        dataType: "json",
		        data: formData,
		        success: function (res) {
		            if (res.success) {
		                showToast(res.message || "Cập nhật hóa đơn thành công");

		                setTimeout(() => {
		                    window.location.href ="/DoAnQLThueTro/ChiTietHoaDon?id=" + idHoaDon;
		                }, 1200);

		            } else {
		                showToast(res.message || "Không thể cập nhật hóa đơn", "error");
		            }
		        },
		        error: function () {
		            showToast("Lỗi server khi cập nhật hóa đơn", "error");
		        }
		    });
		});
	</script>
</body>
</html>