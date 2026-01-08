<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="utils.TimeHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.KhuVuc"%>
<%@ page import="model.bean.Comment"%>
<%@ page import="model.bean.TienIch"%>
<%@ page import="utils.PageURL"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Map"%>
<%@ page import="model.bean.ThongBao"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết phòng duyệt</title>
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
	href="${pageContext.request.contextPath}/assets/css/ChiTietPhongDuyet.css">
</head>
<body>
	<%
	PhongTro pt = (PhongTro) request.getAttribute("ChiTietPhong");
	%>
	<div class="admin-container">
		<div class="top-nav">
			<a href="${pageContext.request.contextPath}/AdminQT" class="btn-back"><i
				class="fa-solid fa-chevron-left"></i> Quay lại danh sách</a>
			<div class="request-id fw-bold text-muted">
				Mã yêu cầu: #<%=pt.getID_Phong()%></div>
		</div>

		<div class="detail-card">
			<div class="gallery-container">
				<div class="main-img-box">
					<img src="<%=pt.getAnhChinh()%>" id="mainImage" class="main-img"
						alt="Phòng chính">
				</div>
				<div class="sub-images-grid">
					<%
					ArrayList<String> img = pt.getHinhAnh();
					if (img != null && img.size() > 1) {
						for (int i = 0; i < img.size(); i++) {
					%>
					<img src="<%=img.get(i)%>" class="sub-img active"
						onclick="changeImage(this)" alt="Ảnh">
					<%
					}
					}
					%>
				</div>
			</div>

			<div class="content-body">
				<h1 class="room-title"><%=pt.getTenPhong()%></h1>
				<div class="room-tags mb-2">
					<span
						class="badge bg-primary-subtle text-primary px-3 py-2 rounded-pill">
						<i class="fa-solid fa-location-dot me-1"></i> <%=pt.getTenKhuVuc()%>
					</span>
				</div>
				<div class="location">
					<i class="fa-solid fa-location-dot"></i>
					<%=pt.getDiaChi()%>
				</div>

				<div class="info-matrix">
					<div class="info-item">
						<div class="info-label">Giá thuê</div>
						<div class="info-value"><%=CurrencyHelper.format(pt.getGiaThue())%>đ
						</div>
					</div>
					<div class="info-item">
						<div class="info-label">Diện tích</div>
						<div class="info-value"><%=pt.getDienTich()%>
							m²
						</div>
					</div>
					<div class="info-item">
						<div class="info-label">Điện</div>
						<div class="info-value"><%=CurrencyHelper.format(pt.getGiaDien())%>đ/kWh
						</div>
					</div>
					<div class="info-item">
						<div class="info-label">Nước</div>
						<div class="info-value"><%=CurrencyHelper.format(pt.getGiaNuoc())%>đ/m³
						</div>
					</div>
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

				<div class="section-label">
					<i class="fa-solid fa-star text-warning"></i> Tiện ích có sẵn
				</div>
				<div class="util-tags">
					<%
					ArrayList<TienIch> list = (ArrayList<TienIch>) request.getAttribute("listTienIch");
					for (TienIch ti : list) {
						String name = ti.getTenTienIch();
						String icon = iconMap.getOrDefault(name, "fas fa-check");
					%>
					<span class="tag"><i class="<%=icon%>"></i> <%=name%></span>
					<%
					}
					%>
				</div>

				<div class="section-label">
					<i class="fa-solid fa-align-left text-primary"></i> Mô tả chi tiết
				</div>
				<div class="desc-text">
					<%=pt.getMoTa()%>
				</div>
			</div>

			<div class="meta-footer">
				<div class="landlord-info">
					<img src="<%=pt.getAvatar()%>" class="landlord-avatar"
						alt="Chủ trọ">
					<div>
						<div class="fw-bold"><%=pt.getTenCT()%></div>
					</div>
				</div>
				<%
				DateTimeFormatter fmt = DateTimeFormatter.ofPattern("HH:mm • dd/MM/yyyy");
				%>
				<div class="request-time">
					<i class="fa-regular fa-clock"></i> Gửi yêu cầu:
					<%=pt.getNgayDang().format(fmt)%>
				</div>
			</div>
		</div>
	</div>
	<input type="hidden" id="roomId" value="<%=pt.getID_Phong()%>">


	<div class="action-bar">
		<button class="btn-reject" onclick="toggleModal(true)">
			<i class="fa-solid fa-xmark me-2"></i> TỪ CHỐI
		</button>
		<button class="btn-approve" onclick="approveRoom()">
			<i class="fa-solid fa-check me-2"></i> PHÊ DUYỆT NGAY
		</button>
	</div>

	<div class="reject-modal" id="rejectModal">
		<div class="modal-content">
			<h4 class="fw-bold mb-3">Lý do từ chối</h4>
			<p class="text-secondary small mb-4">Lý do này sẽ được gửi thông
				báo đến chủ trọ để họ chỉnh sửa lại bài đăng.</p>
			<textarea id="rejectReason" class="form-control mb-4" rows="4"
				placeholder="Ví dụ: Hình ảnh mờ, thông tin địa chỉ không chính xác..."></textarea>
			<div class="d-flex gap-2">
				<button class="btn btn-light flex-grow-1 fw-bold"
					onclick="toggleModal(false)">Hủy</button>
				<button class="btn btn-danger flex-grow-1 fw-bold"
					onclick="submitReject()">Gửi từ chối</button>
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
    // Hàm đổi ảnh chính khi click ảnh phụ
    function changeImage(element) {
        const mainImg = document.getElementById('mainImage');
        
        // Hiệu ứng mờ dần khi chuyển
        mainImg.style.opacity = '0';
        
        setTimeout(() => {
            mainImg.src = element.src;
            mainImg.style.opacity = '1';
        }, 200);

        // Cập nhật trạng thái Active
        const thumbnails = document.querySelectorAll('.sub-img');
        thumbnails.forEach(thumb => thumb.classList.remove('active'));
        element.classList.add('active');
    }

    function toggleModal(show) {
        document.getElementById('rejectModal').style.display = show ? 'flex' : 'none';
    }

    function approveRoom() {
        const roomId = $("#roomId").val();
        if (!roomId) {
            showToast("Thiếu ID phòng!", "error");
            return;
        }

        if (!confirm("Bạn có chắc chắn muốn phê duyệt phòng này?")) return;

        $.ajax({
            url: "/DoAnQLThueTro/DuyetPhongTro", // ✅ servlet phê duyệt
            method: "POST",
            data: { 
            	idPhong: roomId
            	},
            dataType: "json",
            success: function (res) {
                const result = (typeof res === "string") ? JSON.parse(res) : res;

                if (result.success) {
                    showToast("✅ Đã phê duyệt phòng!", "success");
                    setTimeout(() => {
                        window.location.href = "/DoAnQLThueTro/AdminQT";
                    }, 1200);
                } else {
                    showToast(result.message || "Không thể phê duyệt!", "error");
                }
            },
            error: function () {
                showToast("Lỗi server khi phê duyệt!", "error");
            }
        });
    }

    function submitReject() {
        const roomId = $("#roomId").val();
        const reason = $("#rejectReason").val().trim();
        const ID_ChuTro = $("#chuTroId").val();

        if (!roomId) {
            showToast("Thiếu ID phòng!", "error");
            return;
        }

        if (!reason) {
            showToast("Vui lòng nhập lý do từ chối!", "error");
            return;
        }

        $.ajax({
            url: "/DoAnQLThueTro/TuChoiPhongTro",
            method: "POST",
            data: {
                idPhong: roomId,
                lyDo: reason
            },
            dataType: "json",
            success: function (res) {
                const result = (typeof res === "string") ? JSON.parse(res) : res;

                if (result.success) {
                    showToast("✅ Đã từ chối và gửi thông báo!", "success");
                    toggleModal(false);
                    setTimeout(() => {
                        window.location.href = "/DoAnQLThueTro/AdminQT";
                    }, 1200);
                } else {
                    showToast(result.message || "Không thể từ chối!", "error");
                }
            },
            error: function () {
                showToast("Lỗi server khi từ chối!", "error");
            }
        });
    }

    window.onclick = function(event) {
        const modal = document.getElementById('rejectModal');
        if (event.target == modal) toggleModal(false);
    }
</script>

</body>
</html>