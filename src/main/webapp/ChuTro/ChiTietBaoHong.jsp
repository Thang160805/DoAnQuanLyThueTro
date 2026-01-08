<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.BaoHong"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.time.*, java.util.Random"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chi tiết báo hỏng</title>
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
	href="${pageContext.request.contextPath}/assets/css/ChiTietBaoHong.css">
	<style>
	body {
	font-family: "Open Sans", sans-serif;
	background-color: #f8fafc;
	color: #1e293b;
	line-height: 1.6;
}
	</style>
</head>
<body>
	<%
	BaoHong bh = (BaoHong) request.getAttribute("ChiTietBH");
	%>
	<div class="container">
		<div class="breadcrumb">
			<a href="${pageContext.request.contextPath}/QuanLyTro">Sự cố</a> <span>Chi
				tiết</span> <span>Xử lý</span>
		</div>

		<div class="grid-layout">
			<div class="left-col">
				<div class="card">
					<div class="incident-header">
						<h1 class="incident-title"><%=bh.getTieuDe()%></h1>
						<div class="meta-grid">
							<div class="meta-item">
								<span class="label">Mã số sự cố</span> <span class="value">#<%=bh.getId()%></span>
							</div>
							<div class="meta-item">
								<span class="label">Phòng</span> <span class="value"
									style="color: #6366f1; font-weight: 700;"><%=bh.getTenPhong()%></span>
							</div>
						</div>
					</div>

					<div class="meta-grid"
						style="grid-template-columns: repeat(3, 1fr);">
						<div class="meta-item">
							<span class="label">Loại hư hỏng</span> <span class="value"><%=bh.getLoaiHuHong()%></span>
						</div>
						<%
						String priority = bh.getMucDoUuTien();
						String priorityClass = "";

						switch (priority) {
							case "Thấp" :
								priorityClass = "priority-low";
								break;
							case "Trung bình" :
								priorityClass = "priority-medium";
								break;
							case "Cao" :
								priorityClass = "priority-high";
								break;
							case "Khẩn cấp" :
								priorityClass = "priority-urgent";
								break;
							default :
								priorityClass = "priority-unknown";
						}
						%>
						<div class="meta-item">
							<span class="label">Ưu tiên</span> <span> <span
								class="badge <%=priorityClass%>"> <%=priority%></span>
						</div>
						<%
						String status = bh.getTrangThai();
						String statusClass = "";

						switch (status) {
							case "Chờ xử lý" :
								statusClass = "status-pending";
								break;
							case "Đang xử lý" :
								statusClass = "status-processing";
								break;
							default :
								statusClass = "status-unknown";
						}
						%>
						<div class="meta-item">
							<span class="label">Trạng thái hiện tại</span> <span> <span
								class="badge <%=statusClass%>" id="currentStatusBadge"><%=status%>
							</span>
							</span>
						</div>
					</div>
					<%
					DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm - dd/MM/yyyy");
					%>
					<div class="form-group">
						<span class="label">Người báo cáo</span>
						<div class="reporter-info" style="margin-top: 8px;">
							<img src="<%=bh.getAvatar()%>" class="avatar" alt="">
							<div>
								<div class="value"><%=bh.getTenNguoiGui()%></div>
								<div class="label" style="font-size: 10px;">
									Gửi lúc
									<%=bh.getThoiGianGui().format(formatter)%></div>
							</div>
						</div>
					</div>

					<div class="form-group">
						<span class="label">Mô tả chi tiết</span>
						<div class="desc-box"
							style="margin-top: 8px; padding: 16px; background: #fcfcfd; border-radius: 12px; border-left: 4px solid #e0e7ff;">
							<%=bh.getMoTa()%>
						</div>
					</div>
				</div>

				<div class="card">
					<div class="card-title">
						<i class="fa-solid fa-images"></i> Hình ảnh minh chứng
					</div>
					<%
					ArrayList<String> listAnh = bh.getAnhBaoHong();
					%>
					<div class="gallery">
						<%
						if (listAnh != null && listAnh.size() > 1) {
							for (int i = 0; i < listAnh.size(); i++) {
						%>
						<img src="<%=listAnh.get(i)%>" class="gallery-img"
							onclick="alert('Mở lightbox...')">
						<%
						}
						}
						%>
					</div>

				</div>
			</div>
			<%
			String status1 = bh.getTrangThai();

			String duKienText = "";

			if ("Đang xử lý".equals(status)) {

				LocalDateTime updateTime = bh.getUpdated_At();

				Random random = new Random();
				int randomDays = random.nextInt(3) + 1;

				LocalDateTime duKienHoanThanh = updateTime.plusDays(randomDays);

				DateTimeFormatter fullFormatter = DateTimeFormatter.ofPattern("HH:mm - dd/MM/yyyy");
				DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("HH:mm");

				if (duKienHoanThanh.toLocalDate().equals(LocalDate.now())) {
					duKienText = "Dự kiến: " + duKienHoanThanh.format(timeFormatter) + " hôm nay";
				} else {
					duKienText = "Dự kiến: " + duKienHoanThanh.format(fullFormatter);
				}
			}
			%>
			<div class="right-col">
				<div class="card timeline-card">
					<div class="card-title">
						<i class="fa-solid fa-stairs"></i> Tiến độ xử lý
					</div>

					<div class="timeline">

						<div
							class="timeline-item <%=status.equals("Chờ xử lý") || status.equals("Đang xử lý") ? "active" : ""%>">
							<div class="timeline-dot"></div>
							<div class="timeline-content">
								<div class="timeline-status">Đã tiếp nhận</div>

								<div class="timeline-time">
									<%=status.equals("Chờ xử lý") ? "Chờ xử lý" : bh.getUpdated_At().format(formatter)%>
								</div>
							</div>
						</div>

						<div
							class="timeline-item <%=status.equals("Đang xử lý") ? "current" : ""%>">
							<div class="timeline-dot"></div>
							<div class="timeline-content">
								<div class="timeline-status">Đang xử lý</div>
								<div class="timeline-time">
									<%=status.equals("Đang xử lý") ? "Nhân viên kỹ thuật đang kiểm tra" : "Chưa bắt đầu"%>
								</div>
							</div>
						</div>
						<%
						if ("Đang xử lý".equals(status)) {
						%>
						<div class="timeline-item">
							<div class="timeline-dot"></div>
							<div class="timeline-content">
								<div class="timeline-status">Hoàn thành</div>
								<div class="timeline-time">
									<%=duKienText%>
								</div>
							</div>
						</div>
						<%
						}
						%>

					</div>
				</div>

				<div class="card contact-card">
					<div class="card-title">
						<i class="fa-solid fa-address-book"></i> Liên hệ cư dân
					</div>
					<div class="contact-profile">
						<img src="<%=bh.getAvatar()%>" alt="Avatar">
						<div class="contact-info">
							<strong><%=bh.getTenNguoiGui()%></strong>
							<p><%=bh.getTenPhong()%></p>
						</div>
					</div>
					<div class="quick-actions">
						<button class="action-btn btn-call">
							<i class="fa-solid fa-phone"></i> Gọi điện
						</button>
						<button class="action-btn btn-chat">
							<i class="fa-solid fa-comment"></i> Nhắn tin
						</button>
					</div>
				</div>
				<%
				String status3 = bh.getTrangThai();
				%>
				<div class="card action-group-card">
					<div class="btn-stack">
						<%
						if ("Chờ xử lý".equals(status)) {
						%>

						<button class="btn btn-primary"
							onclick="batDauXuLy()">
							<i class="fa-solid fa-play"></i> Bắt đầu xử lý
						</button>

						<button class="btn btn-danger-outline" onclick="openRejectModal()">
							<i class="fa-solid fa-ban"></i> Từ chối
						</button>

						<%
						}
						%>

						<%-- TRẠNG THÁI: ĐANG XỬ LÝ --%>
						<%
						if ("Đang xử lý".equals(status)) {
						%>

						<button class="btn btn-success"
							onclick="hoanThanhBaoHong()">
							<i class="fa-solid fa-check-double"></i> Hoàn thành
						</button>

						<%
						}
						%>

					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="modal-overlay" id="rejectModal">
		<div class="modal">
			<h3 style="margin-bottom: 16px;">Xác nhận từ chối</h3>
			<p class="label" style="margin-bottom: 12px;">Vui lòng nhập lý do
				từ chối xử lý sự cố này:</p>
			<textarea class="form-textarea" id="rejectReason" rows="4"
				placeholder="Ví dụ: Sự cố do người dùng tự ý làm hỏng, không thuộc phạm vi bảo trì..."></textarea>
			<div style="display: flex; gap: 12px; margin-top: 24px;">
				<button class="btn btn-back" style="flex: 1;"
					onclick="closeRejectModal()">Hủy</button>
				<button class="btn btn-danger" style="flex: 1;"
					onclick="tuChoiBaoHong()">Xác nhận từ chối</button>
			</div>
		</div>
	</div>
	<div id="toast"
			style="position: fixed; top: 20px; right: 20px; background: #1e293b; color: white; padding: 12px 24px; border-radius: 50px; font-weight: 600; font-size: 14px; box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2); opacity: 0; transition: 0.3s; transform: translateY(-20px); pointer-events: none;">
		</div>
		<script
			src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
		function handleAction(status) {
			const note = document.getElementById('workNote').value;
			const badge = document.getElementById('currentStatusBadge');

			if (status === 'rejected') {
				const reason = document.getElementById('rejectReason').value;
				if (!reason) {
					alert("Vui lòng nhập lý do từ chối!");
					return;
				}
				badge.innerText = "Đã từ chối";
				badge.className = "badge";
				badge.style.background = "#fee2e2";
				badge.style.color = "var(--danger)";
				closeRejectModal();
			} else if (status === 'processing') {
				badge.innerText = "Đang xử lý";
				badge.className = "badge status-processing";
			} else if (status === 'done') {
				badge.innerText = "Đã hoàn thành";
				badge.className = "badge";
				badge.style.background = "#dcfce7";
				badge.style.color = "var(--success)";
			}

			showToast();
		}

		function openRejectModal() {
			document.getElementById('rejectModal').style.display = 'flex';
		}
		function closeRejectModal() {
			document.getElementById('rejectModal').style.display = 'none';
		}
		
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
		const idBaoHong = "<%= bh.getId() %>";
	    const idPhong = "<%= bh.getID_Phong() %>";
	    const idNguoiGui = "<%= bh.getID_NguoiGui() %>";
	    function batDauXuLy() {
	        $.ajax({
	            url: "/DoAnQLThueTro/XuLyBaoHong",
	            type: "POST",
	            dataType: "json",
	            data: {
	                idBaoHong: idBaoHong,
	                idNguoiGui: idNguoiGui
	            },
	            success: function (res) {
	                if (res.success) {
	                    showToast(res.message);
	                    setTimeout(() => {
	                        location.reload();
	                    }, 800);
	                } else {
	                    showToast(res.message, "error");
	                }
	            },
	            error: function () {
	                showToast("Có lỗi xảy ra khi gửi yêu cầu", "error");
	            }
	        });
	    }
	    
	    function hoanThanhBaoHong() {
	        $.ajax({
	            url: "/DoAnQLThueTro/HoanThanhBaoHong",
	            type: "POST",
	            dataType: "json",
	            data: {
	                idBaoHong: idBaoHong,
	                idNguoiGui: idNguoiGui
	            },
	            success: function (res) {
	                if (res.success) {
	                    showToast(res.message);
	                    setTimeout(() => {
	                        window.location.href = "/DoAnQLThueTro/QuanLyTro";
	                    }, 800);
	                } else {
	                    showToast(res.message, "error");
	                }
	            },
	            error: function () {
	                showToast("Có lỗi xảy ra khi hoàn thành báo hỏng", "error");
	            }
	        });
	    }
	    
	    function tuChoiBaoHong() {
	        const reason = $("#rejectReason").val();

	        if (!reason) {
	            alert("Vui lòng nhập lý do từ chối!");
	            return;
	        }

	        $.ajax({
	            url: "/DoAnQLThueTro/TuChoiBaoHong",
	            type: "POST",
	            dataType: "json",
	            data: {
	                idBaoHong: idBaoHong,
	                idNguoiGui: idNguoiGui,
	                lyDo: reason
	            },
	            success: function (res) {
	                if (res.success) {
	                    showToast(res.message);
	                    closeRejectModal();
	                    setTimeout(() => {
	                        window.location.href = "/DoAnQLThueTro/QuanLyTro";
	                    }, 800);
	                } else {
	                    showToast(res.message, "error");
	                }
	            },
	            error: function () {
	                showToast("Có lỗi xảy ra khi từ chối báo hỏng", "error");
	            }
	        });
	    }
	</script>

</body>
</html>