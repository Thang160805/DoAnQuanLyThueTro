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
<title>Insert title here</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Inder&display=swap"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/assets/css/TaoHoaDonThanhToan.css">
</head>
<body>
	<div class="invoice-wrapper">
		<header class="page-header">
			<h1>Tạo hóa đơn thanh toán</h1>
			<p>Nhập thông tin chi phí điện, nước và tiền phòng cho kỳ thanh
				toán</p>
		</header>

		<form id="invoiceForm" action="LuuHoaDon" method="POST">
			<div class="grid-container">
				<div class="column-main">
					<div class="card">
						<div class="card-header">
							<i class="fa-solid fa-file-contract"></i> <span>Thông tin
								hợp đồng</span>
						</div>
						<%
						ArrayList<HopDong> listHD = (ArrayList<HopDong>) request.getAttribute("listHD");
						%>
						<div class="form-grid">
							<div class="form-group full-width">
								<label class="form-label">Hợp đồng thuê</label> <select
									class="form-select" name="ID_HopDong" id="contractSelect"
									required onchange="autoFillInfo()">
									<option value="" disabled selected>-- Chọn hợp đồng
										thuê --</option>
									<%
									for (HopDong hd : listHD) {
									%>
									<option value="<%=hd.getId()%>"
										data-room="<%=hd.getTenPhong()%>"
										data-tenant="<%=hd.getTenNguoiThue()%>"
										data-price="<%=hd.getGiaThue()%>"
										data-electric="<%=hd.getGiaDien()%>"
										data-water="<%=hd.getGiaNuoc()%>"
										data-rid="<%=hd.getID_Phong()%>"
										data-tid="<%=hd.getID_NguoiThue()%>">HD-<%=hd.getId()%>
										-
										<%=hd.getTenPhong()%> -
										<%=hd.getTenNguoiThue()%>
									</option>
									<%
									}
									%>
								</select>
							</div>
							<div class="form-group">
								<label class="form-label">Tên phòng (Readonly)</label> <input
									type="text" id="roomName" class="form-input readonly" readonly
									placeholder="Tự động điền"> <input type="hidden"
									name="ID_Phong" id="roomID">
							</div>
							<div class="form-group">
								<label class="form-label">Người thuê (Readonly)</label> <input
									type="text" id="tenantName" class="form-input readonly"
									readonly placeholder="Tự động điền"> <input
									type="hidden" name="ID_NguoiThue" id="tenantID">
							</div>
							<div class="form-group full-width">
								<label class="form-label">Chủ trọ (Readonly)</label> <input
									type="text" class="form-input readonly" readonly
									value="Phạm Võ Tuấn (Bạn)"> <input type="hidden"
									name="ID_ChuTro" value="999">
							</div>
						</div>
					</div>

					<div class="card">
						<div class="card-header">
							<i class="fa-solid fa-money-bill-transfer"></i> <span>Chi
								phí kỳ này</span>
						</div>
						<div class="form-grid">
							<div class="form-group full-width">
								<label class="form-label">Tiền phòng (TienPhong)</label>
								<div class="input-icon-wrapper">
									<input type="number" name="TienPhong" id="rentPrice"
										class="form-input readonly" readonly value="0">
								</div>
							</div>

							<div class="cost-box">
								<label class="form-label"> <i
									class="fa-solid fa-bolt text-warning"></i> Tiền điện
								</label>

								<div class="form-grid-mini">
									<input type="number" class="form-input" id="elecUsage"
										placeholder="Số kWh sử dụng" min="0" oninput="calcElec()">

									<input type="number" class="form-input" id="elecUnit"
										placeholder="Đơn giá" readonly>
								</div>

								<input type="number" name="TienDien" id="elecTotal"
									class="form-input mt-2 readonly" readonly value="0">
							</div>
							<div class="cost-box">
								<label class="form-label"> <i
									class="fa-solid fa-droplet text-primary"></i> Tiền nước
								</label>

								<div class="form-grid-mini">
									<input type="number" class="form-input" id="waterUsage"
										placeholder="Số m³ sử dụng" min="0" oninput="calcWater()">

									<input type="number" class="form-input" id="waterUnit"
										placeholder="Đơn giá" readonly>
								</div>

								<input type="number" name="TienNuoc" id="waterTotal"
									class="form-input mt-2 readonly" readonly value="0">
							</div>
						</div>
					</div>
				</div>

				<div class="column-side">
					<div class="card">
						<div class="form-group">
							<label class="form-label">Kỳ thanh toán (MM/YYYY)</label> <input
								type="month" name="ThangNam" class="form-input" required
								id="currentMonth">
						</div>
						<div class="form-group">
							<label class="form-label">Hạn thanh toán</label> <input
								type="date" name="HanThanhToan" class="form-input" id="dueDate">
						</div>
					</div>

					<div class="card total-card">
						<div class="total-label">TỔNG TIỀN PHẢI TRẢ</div>
						<div class="total-value" id="displayTotal">0 ₫</div>
						<input type="hidden" name="TongTien" id="hiddenTotal">
					</div>

					<div class="card">
						<label class="form-label">Ghi chú hóa đơn</label>
						<textarea name="GhiChu" class="form-textarea" rows="3"
							placeholder="Ví dụ: Tiền điện tăng do sử dụng điều hòa..."></textarea>
					</div>

					<div class="action-stack">
						<button type="submit" class="btn btn-primary" id="btnSubmit"
							disabled>
							<i class="fa-solid fa-paper-plane"></i> Tạo & Gửi hóa đơn
						</button>
						<button type="button" class="btn btn-outline"
							onclick="history.back()">Hủy</button>
					</div>
					<div id="warningText" class="alert-text mt-2">
						<i class="fa-solid fa-circle-info"></i> Vui lòng nhập đủ tiền
						điện/nước
					</div>
				</div>
			</div>
		</form>
	</div>
	<script>
		window.onload = function() {
			const now = new Date();
			const month = String(now.getMonth() + 1).padStart(2, '0');
			const year = now.getFullYear();
			document.getElementById('currentMonth').value = `${year}-${month}`;

			const dueDate = new Date(year, now.getMonth(), 5);
			document.getElementById('dueDate').value = dueDate.toISOString()
					.split('T')[0];
		};

		function autoFillInfo() {
			const select = document.getElementById("contractSelect");
			if (!select || select.selectedIndex === -1)
				return;

			const opt = select.options[select.selectedIndex];
			if (!opt.value)
				return;


			document.getElementById("roomName").value = opt.dataset.room || "";
			document.getElementById("tenantName").value = opt.dataset.tenant
					|| "";
			document.getElementById("roomID").value = opt.dataset.rid || "";
			document.getElementById("tenantID").value = opt.dataset.tid || "";

			const tienPhong = Number(opt.dataset.price || 0);
			const giaDien = Number(opt.dataset.electric || 0);
			const giaNuoc = Number(opt.dataset.water || 0);

			document.getElementById("rentPrice").value = tienPhong;
			document.getElementById("elecUnit").value = giaDien;
			document.getElementById("waterUnit").value = giaNuoc;

			updateFinalTotal();
		}
		
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

    const btnSubmit = document.getElementById('btnSubmit');
    const warning = document.getElementById('warningText');

    const elecUsage = parseFloat(document.getElementById('elecUsage')?.value || 0);
    const waterUsage = parseFloat(document.getElementById('waterUsage')?.value || 0);

    if (total > 0 && (elecUsage > 0 || waterUsage > 0)) {
        btnSubmit.disabled = false;
        warning.style.display = 'none';
    } else {
        btnSubmit.disabled = true;
        warning.style.display = 'block';
    }
}
</script>
</body>
</html>
