<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TienIch"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tạo hợp đồng</title>
<!-- Google Fonts: Poppins (Hiện đại, tròn trịa giống Airbnb) -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Open+Sans:ital,wght@0,300..800;1,300..800&display=swap" rel="stylesheet">
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
	href="${pageContext.request.contextPath}/assets/css/TaoHopDong.css">
	<style>
	body {
	font-family: "Open Sans", sans-serif;
	background-color: #f8fafc;
	color: #1e293b;
	line-height: 1.5;
	padding-bottom: 40px;
}
	</style>
</head>
<body>
<div class="container">
    <header class="page-header">
        <div class="page-title">
            <h1>Tạo hợp đồng thuê trọ</h1>
        </div>
        <div class="status-badge">
            <i class="fa-solid fa-pen-to-square"></i> Đang tạo
        </div>
    </header>
    <% PhongTro pt = (PhongTro) request.getAttribute("ChiTietPhong");
    TaiKhoan tkNguoiThue = (TaiKhoan) request.getAttribute("TaiKhoanNguoiThue");
    TaiKhoan tkChuTro = (TaiKhoan) request.getAttribute("TaiKhoanChuTro");
    ArrayList<TienIch> listTI = (ArrayList<TienIch>) request.getAttribute("listTienIch");
    int idHopDong = (int) request.getAttribute("idHopDong");
    int idYeuCau = (int) request.getAttribute("idYeuCau");
    %>
    <form id="contractForm">
    <input type="hidden" name="idYeuCau" value="<%= idYeuCau%>">
    <input type="hidden" name="idHopDong" value="<%= idHopDong%>">
        <div class="grid-layout">
            
            <div class="col-left">
                
                <div class="card">
                    <div class="section-header">
                        <i class="fa-solid fa-user-tie section-icon"></i>
                        <h2 class="section-title">Thông tin Bên A (Chủ trọ)</h2>
                    </div>
                    <div class="form-grid">
                    <input type="hidden" name="ID_ChuTro" value="<%= tkChuTro.getId()%>">
                        <div class="form-group">
                            <label>Họ và tên</label>
                            <input type="text" value="<%=(tkChuTro != null && tkChuTro.getHoTen() != null) ? tkChuTro.getHoTen() : ""%>" readonly>
                        </div>
                        <div class="form-group">
                            <label>CCCD/CMND</label>
                            <input type="text" value="<%=(tkChuTro != null && tkChuTro.getCCCD() != null) ? tkChuTro.getCCCD() : ""%>" readonly>
                        </div>
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <input type="text" value="<%=(tkChuTro != null && tkChuTro.getSDT() != null) ? tkChuTro.getSDT() : ""%>" readonly>
                        </div>
                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" value="<%=(tkChuTro != null && tkChuTro.getEmail() != null) ? tkChuTro.getEmail() : ""%>" readonly>
                        </div>
                        <div class="form-group full-width">
                            <label>Địa chỉ thường trú</label>
                            <input type="text" value="<%=(tkChuTro != null && tkChuTro.getDiaChi() != null) ? tkChuTro.getDiaChi() : ""%>" readonly>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="section-header">
                        <i class="fa-solid fa-user section-icon"></i>
                        <h2 class="section-title">Thông tin Bên B (Người thuê)</h2>
                    </div>
                    
                    <div class="tenant-card">
                        <div class="tenant-avatar"><i class="fa-solid fa-user"></i></div>
                        <div>
                            <div style="font-weight: 600; font-size: 16px;"><%=(tkNguoiThue != null && tkNguoiThue.getHoTen() != null) ? tkNguoiThue.getHoTen() : ""%></div>
                            <div style="font-size: 13px; color: var(--text-secondary);">Người yêu cầu thuê</div>
                        </div>
                    </div>

                    <div class="form-grid">
                    <input type="hidden" name="ID_NguoiThue" value="<%= tkNguoiThue.getId()%>">
                        <div class="form-group">
                            <label>Họ và tên</label>
                            <input type="text" value="<%=(tkNguoiThue != null && tkNguoiThue.getHoTen() != null) ? tkNguoiThue.getHoTen() : ""%>" readonly>
                        </div>
                        <div class="form-group">
                            <label>CCCD/CMND</label>
                            <input type="text" value="<%=(tkNguoiThue != null && tkNguoiThue.getCCCD() != null) ? tkNguoiThue.getCCCD() : ""%>" readonly>
                        </div>
                        <div class="form-group">
                            <label>Số điện thoại</label>
                            <input type="text" value="<%=(tkNguoiThue != null && tkNguoiThue.getSDT() != null) ? tkNguoiThue.getSDT() : ""%>" readonly>
                        </div>
                        <div class="form-group">
                            <label>Email (Để nhận hợp đồng)</label>
                            <input type="email" value="<%=(tkNguoiThue != null && tkNguoiThue.getEmail() != null) ? tkNguoiThue.getEmail() : ""%>" readonly>
                        </div>
                    </div>
                    <div class="tenant-note">
                        <i class="fa-solid fa-circle-info"></i> Thông tin được lấy tự động từ hồ sơ người thuê.
                    </div>
                </div>

                <div class="card">
                    <div class="section-header">
                        <i class="fa-solid fa-house section-icon"></i>
                        <h2 class="section-title">Thông tin Phòng thuê</h2>
                    </div>
                    <div class="form-grid">
                    <input type="hidden" name="ID_Phong" value="<%= pt.getID_Phong()%>">
                    <input type="hidden" name="TenPhong" value="<%= pt.getTenPhong()%>">
                        <div class="form-group">
                            <label>Tên phòng</label>
                            <input type="text" value="<%=(pt != null && pt.getTenPhong() != null) ? pt.getTenPhong() : ""%>" readonly>
                        </div> 
                        <div class="form-group">
                            <label>Diện tích(m²)</label>
                            <input type="text" value="<%=(pt != null && pt.getDienTich() != -1) ? pt.getDienTich() : ""%>" readonly>
                        </div>
                        <div class="form-group">
                            <label>Giá thuê(VNĐ)</label>
                            <input type="text" value="<%=(pt != null && pt.getGiaThue() != -1) ? pt.getGiaThue() : ""%>" readonly>
                        </div>
                        <div class="form-group full-width">
                            <label>Địa chỉ</label>
                            <input type="text" value="<%=(pt != null && pt.getDiaChi() != null) ? pt.getDiaChi() : ""%>" readonly>
                        </div>
                    </div>
                    
                    <div style="margin-top: 15px;">
                        <label>Tiện ích có sẵn:</label>
                        <div class="amenities-grid">
                        <% for(TienIch ti : listTI){ %>
                            <div class="amenity-item"><i class="fa-solid fa-check"></i> <%= ti.getTenTienIch() %></div>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="card">
                    <div class="section-header">
                        <i class="fa-solid fa-file-contract section-icon"></i>
                        <h2 class="section-title">Điều khoản hợp đồng</h2>
                    </div>
                    

                    <div class="form-group full-width" style="margin-top: 20px;">
                        <label>Điều khoản hợp đồng</label>
                        <textarea style="height: 250px;" placeholder="Ví dụ: Không được nuôi thú cưng, giới hạn số người ở..."></textarea>
                    </div>
                </div>

            </div>

            <div class="col-right">
                
                <div class="card">
                    <div class="section-header">
                        <i class="fa-regular fa-calendar-check section-icon"></i>
                        <h2 class="section-title">Thời gian</h2>
                    </div>
                    <div class="form-group">
                        <label>Ngày bắt đầu <span class="required">*</span></label>
                        <input type="date" id="startDate" required>
                        <div class="error-message">Vui lòng chọn ngày bắt đầu</div>
                    </div>
                    <div class="form-group">
                        <label>Thời hạn thuê <span class="required">*</span></label>
                        <select id="duration" onchange="calculateEndDate()">
                            <option value="3">3 Tháng</option>
                            <option value="6" selected>6 Tháng</option>
                            <option value="12">12 Tháng</option>
                            <option value="0">Tùy chỉnh</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Ngày kết thúc (Dự kiến)</label>
                        <input type="date" id="endDate" readonly>
                    </div>
                    <div class="form-group">
                        <label>Ngày thanh toán hàng tháng</label>
                        <select id="ngayThanhToan">
                            <option value="1">Ngày 01</option>
                            <option value="5" selected>Ngày 05</option>
                            <option value="10">Ngày 10</option>
                            <option value="15">Ngày 15</option>
                        </select>
                    </div>
                </div>

                <div class="card" style="position: sticky; top: 20px;">
                    <div class="section-header">
                        <i class="fa-solid fa-coins section-icon"></i>
                        <h2 class="section-title">Chi phí & Xác nhận</h2>
                    </div>

                    <div class="form-group">
                        <label>Giá thuê chốt (VNĐ) <span class="required">*</span></label>
                        <input type="number" id="rentPrice" oninput="calculateTotal()" value="<%=(pt != null && pt.getGiaThue() != -1) ? pt.getGiaThue() : ""%>" readonly>
                    </div>
                    <div class="form-group">
                        <label>Tiền cọc (VNĐ) <span class="required">*</span></label>
                        <input type="number" id="depositPrice" oninput="calculateTotal()" value="4000000" >
                        <div class="error-message">Vui lòng nhập tiền cọc</div>
                    </div>
                    
                    <div class="form-grid">
                        <div class="form-group">
                            <label>Điện (đ/kWh)</label>
                            <input type="number" value="<%=(pt != null && pt.getGiaDien() != -1) ? pt.getGiaDien() : ""%>" readonly>
                        </div>
                        <div class="form-group">
                            <label>Nước (đ/m³)</label>
                            <input type="number" value="<%=(pt != null && pt.getGiaNuoc() != -1) ? pt.getGiaNuoc() : ""%>" readonly>
                        </div>
                    </div>

                    <div class="financial-summary">
                        <div class="summary-row">
                            <span>Tiền thuê tháng đầu</span>
                            <span id="displayRent"><%=(pt != null && pt.getGiaThue() != -1) ?CurrencyHelper.format(pt.getGiaThue()) : ""%> đ</span>
                        </div>
                        <div class="summary-row">
                            <span>Tiền cọc</span>
                            <span id="displayDeposit">3.500.000 đ</span>
                        </div>
                        <div class="summary-total">
                            <span class="total-label">Tổng thanh toán đầu:</span>
                            <span class="total-value" id="totalAmount">7.100.000 đ</span>
                        </div>
                    </div>

                    <div class="action-container">
                        <button type="button" class="btn btn-primary" onclick="submitContract()">
                            <i class="fa-solid fa-paper-plane"></i> Gửi yêu cầu tạo HĐ
                        </button>
                        
                        <button type="button" class="btn btn-danger">Hủy bỏ</button>
                    </div>
                </div>

            </div>
        </div>
    </form>
</div>
<div id="toast"
		style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script>

let contractSubmitted = false;
/* =======================
   1. TÍNH NGÀY KẾT THÚC
======================= */
const startDateInput = document.getElementById('startDate');
const durationSelect = document.getElementById('duration');
const endDateInput = document.getElementById('endDate');

function calculateEndDate() {
    const startVal = startDateInput.value;
    if (!startVal) {
        endDateInput.value = "";
        return;
    }

    let days = 0;
    switch (durationSelect.value) {
        case "3": days = 90; break;
        case "6": days = 180; break;
        case "12": days = 360; break;
        default:
            endDateInput.value = "";
            return;
    }

    const startDate = new Date(startVal);
    const endDate = new Date(startDate);
    endDate.setDate(endDate.getDate() + days);

    endDateInput.value = endDate.toISOString().split('T')[0];
}

startDateInput.addEventListener('change', calculateEndDate);
durationSelect.addEventListener('change', calculateEndDate);

/* =======================
   2. TÍNH TIỀN REALTIME
======================= */
function formatCurrency(num) {
    return num.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " đ";
}

function calculateTotal() {
    const rent = parseInt(document.getElementById('rentPrice').value) || 0;
    const deposit = parseInt(document.getElementById('depositPrice').value) || 0;

    document.getElementById('displayRent').innerText = formatCurrency(rent);
    document.getElementById('displayDeposit').innerText = formatCurrency(deposit);
    document.getElementById('totalAmount').innerText = formatCurrency(rent + deposit);
}

// chạy ngay khi load
calculateTotal();

/* =======================
   3. GỬI AJAX TẠO HỢP ĐỒNG
======================= */
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
function submitContract() {
    if (contractSubmitted) return;


    if (!startDateInput.value || !endDateInput.value) {
        showToast("Vui lòng chọn ngày bắt đầu và thời hạn thuê", "error");
        return;
    }

    const dieuKhoan = document.querySelector('textarea').value.trim();
    if (dieuKhoan.length < 10) {
        showToast("Điều khoản hợp đồng quá ngắn", "error");
        return;
    }

    const btn = document.querySelector('.btn-primary');
    btn.disabled = true;
    btn.innerHTML = '<i class="fa-solid fa-spinner fa-spin"></i> Đang gửi...';

    const data = {
    	idYeuCau: document.querySelector('input[name="idYeuCau"]').value,
    	idHopDong: document.querySelector('input[name="idHopDong"]').value,
        ID_NguoiThue: document.querySelector('input[name="ID_NguoiThue"]').value,
        ID_ChuTro: document.querySelector('input[name="ID_ChuTro"]').value,
        ID_Phong: document.querySelector('input[name="ID_Phong"]').value,
        TenPhong: document.querySelector('input[name="TenPhong"]').value,

        NgayBatDau: startDateInput.value,
        NgayKetThuc: endDateInput.value,
        ThoiHanThue: durationSelect.value + " tháng",

        TienCoc: document.getElementById('depositPrice').value,
        NgayThanhToanHangThang: document.getElementById('ngayThanhToan').value,

        TongThuBanDau:
            (parseInt(document.getElementById('rentPrice').value) || 0) +
            (parseInt(document.getElementById('depositPrice').value) || 0),

        DieuKhoan: dieuKhoan
    };

    $.ajax({
        url: "/DoAnQLThueTro/XuLyTaoHopDong",
        type: "POST",
        dataType: "json",
        data: data,

        success: function (res) {
            if (res.success) {
                contractSubmitted = true;
                showToast(res.message || "Tạo hợp đồng thành công!", "success");

                setTimeout(() => {
                	window.location.replace("/DoAnQLThueTro/QuanLyTro");
                }, 1500);

            } else {
                showToast(res.message || "Tạo hợp đồng thất bại", "error");
                btn.disabled = false;
                btn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Gửi yêu cầu tạo HĐ';
            }
        },

        error: function () {
            showToast("Lỗi hệ thống, vui lòng thử lại", "error");
            btn.disabled = false;
            btn.innerHTML = '<i class="fa-solid fa-paper-plane"></i> Gửi yêu cầu tạo HĐ';
        }
    });
}


/* =======================
   4. CHẶN BACK KHI CHƯA GỬI
======================= */


//Đẩy state giả
history.pushState(null, null, location.href);

//Chặn back
window.addEventListener('popstate', function () {
 if (!contractSubmitted) {
     history.pushState(null, null, location.href);
     showToast("Bạn cần gửi hợp đồng trước khi rời trang", "error");
 }
});
</script>


</body>
</html>