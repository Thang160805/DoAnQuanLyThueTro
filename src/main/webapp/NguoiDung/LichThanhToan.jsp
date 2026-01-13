<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="utils.CurrencyHelper"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.ThongBao"%>
<%@ page import="model.bean.HoaDon"%>
<%@ page import="utils.TimeHelper"%>
<%@ page import="utils.DateHelper"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Lịch thanh toán</title>
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
	href="${pageContext.request.contextPath}/assets/css/LichThanhToan.css">
	<style>
	pagination-wrapper {
    margin-top: 30px;
    margin-bottom: 50px;
    display: flex;
    flex-direction: column;
    align-items: center;
    gap: 12px;
}

.pagination-list {
    display: flex;
    align-items: center;
    gap: 6px;
    list-style: none;
    padding: 0;
}

.pagi-item {
    display: flex;
    align-items: center;
    justify-content: center;
    min-width: 40px;
    height: 40px;
    padding: 0 10px;
    border-radius: 10px;
    background-color: #ffffff;
    border: 1px solid #e2e8f0;
    color: #475569;
    font-weight: 500;
    font-family: 'Inter', sans-serif;
    transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.pagi-item:hover {
    border-color: #6366f1;
    color: #6366f1;
    background-color: #f5f3ff;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.15);
}

.pagi-item.active {
    background: linear-gradient(135deg, #6366f1 0%, #8b5cf6 100%);
    color: #ffffff;
    border: none;
    box-shadow: 0 4px 12px rgba(99, 102, 241, 0.35);
}

.pagi-dots {
    color: #94a3b8;
    padding: 0 5px;
}

.pagi-info {
    font-size: 0.85rem;
    color: #64748b;
    font-weight: 400;
}

.pagi-item i {
    font-size: 0.8rem;
}
footer {
	background: white;
	padding: 70px 20px 30px;
	margin-top: 50px;
	border-top: 1px solid #eee;
}

.footer-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
	gap: 40px;
	max-width: 1280px;
	margin: 0 auto;
}

.ft-col h4 {
	font-size: 1.1rem;
	margin-bottom: 20px;
	color: #222222;
}

.ft-link {
	display: block;
	margin-bottom: 12px;
	color: #717171;
	font-size: 0.95rem;
	transition: 0.2s;
}

.ft-link:hover {
	color: #1E90FF;
	padding-left: 5px;
}

.copyright {
	text-align: center;
	margin-top: 50px;
	padding-top: 20px;
	border-top: 1px solid #eee;
	color: #888;
	font-size: 0.9rem;
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
	<%
	TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTinCaNhan");
	int countTB = (int) request.getAttribute("countTB");
	%>
	<header>
		<a class="navbar-brand" href="#"> <i
			class="fa-solid fa-house-chimney"></i> FindRoom
		</a>

		<nav>
			<ul class="nav-menu">
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/ProcessHomeUser">Trang
						chủ</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/TimPhong">Tìm phòng</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/PhongDaThue">Phòng đã
						thuê</a></li>
				<li class="nav-item active"><a
					href="${pageContext.request.contextPath}/LichThanhToan">Lịch
						thanh toán</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/HopDong">Hợp đồng</a></li>
			</ul>
		</nav>

		<div class="header-right">
			<div class="dropdown" onclick="toggleDropdown('notif-drop')">
				<div class="notification-icon">
					<i class="fa-regular fa-bell"></i>
					<%
					if (countTB > 0) {
					%>
					<span class="badge"><%=countTB%></span>
					<%
					}
					%>

				</div>
				<%
				ArrayList<ThongBao> list = (ArrayList<ThongBao>) request.getAttribute("listTB");
				%>
				<div class="dropdown-content" id="notif-drop">
					<%
					for (ThongBao tb : list) {
					%>
					<a
						href="${pageContext.request.contextPath}/ChiTietThongBao?id=<%= tb.getId() %>"
						class="dropdown-item"><%=tb.getTitle()%></a>
					<%
					}
					%>
					<div class="dropdown-divider"></div>
					<a href="${pageContext.request.contextPath}/TatCaThongBao"
						class="dropdown-item" style="text-align: center; color: #1E90FF;">Xem
						tất cả</a>
				</div>
			</div>

			<div class="dropdown" onclick="toggleDropdown('user-drop')">
				<div class="user-profile">
					<img
						src="<%=(tk != null && tk.getAvatar() != null) ? tk.getAvatar() : ""%>"
						alt="User" class="avatar"> <i class="fa-solid fa-angle-down"
						style="font-size: 0.8rem; color: #666;"></i>
				</div>
				<div class="dropdown-content" id="user-drop">
					<a href="${pageContext.request.contextPath}/ThongTinCaNhan"
						class="dropdown-item"><i class="fa-regular fa-user"
						style="width: 20px"></i> Thông tin cá nhân</a> <a
						href="${pageContext.request.contextPath}/CaiDat"
						class="dropdown-item"><i class="fa-solid fa-gear"
						style="width: 20px"></i> Cài đặt</a>
					<div class="dropdown-divider"></div>
					<a href="${pageContext.request.contextPath}/Logout"
						class="dropdown-item" style="color: #e74c3c;"><i
						class="fa-solid fa-right-from-bracket" style="width: 20px"></i>
						Đăng xuất</a>
				</div>
			</div>
		</div>
	</header>
	<div class="container" style="margin-top: 120px;">
		<div class="page-header">
			<h1>Lịch thanh toán</h1>
			<p>Theo dõi và thanh toán tiền thuê phòng hàng tháng của bạn.</p>
		</div>
		<%
		ArrayList<HoaDon> listHD = (ArrayList<HoaDon>) request.getAttribute("listHD");
		if (listHD == null || listHD.isEmpty()) {
		%>

		<!-- EMPTY STATE -->
		<div class="empty-state" id="emptyState">
			<i class="fa-solid fa-calendar-xmark"></i>
			<h3>Bạn chưa có phòng nào cần thanh toán</h3>
			<p class="text-secondary mt-2">Hãy tìm phòng và thuê để nhận lịch
				thanh toán tại đây.</p>
		</div>

		<%
		} else {
		%>
		<div class="bill-grid" id="billGrid">
			<%
			for (HoaDon hd : listHD) {
				String trangThai = hd.getTrangThai();

				String badgeClass = "";
				String badgeText = "";
				String btnClass = "";
				String btnText = "";
				String btnIcon = "";
				boolean btnDisabled = false;

				if ("Chưa thanh toán".equals(trangThai)) {
					badgeClass = "baddge-pending";
					badgeText = "Chưa thanh toán";
					btnClass = "btn btn-primary";
					btnText = "Thanh toán tháng này";
					btnIcon = "fa-wallet";
				} else if ("Trễ hạn".equals(trangThai)) {
					badgeClass = "baddge-overdue";
					badgeText = "Quá hạn";
					btnClass = "btn btn-warning";
					btnText = "Thanh toán ngay";
					btnIcon = "fa-circle-exclamation";
				} else if ("Đã thanh toán".equals(trangThai)) {
					badgeClass = "baddge-success";
					badgeText = "Đã thanh toán";
					btnClass = "btn btn-disabled";
					btnText = "Đã thanh toán";
					btnIcon = "fa-circle-check";
					btnDisabled = true;
				}
			%>

			<div class="bill-card">
				<img src="<%=hd.getAnhPhong()%>" class="room-thumb">

				<div class="room-info">
					<div class="room-name">
						Phòng
						<%=hd.getTenPhong()%>
						<span class="baddge <%=badgeClass%>"> <span class="dot"></span><%=badgeText%>
						</span>
					</div>

					<div class="room-address">
						<i class="fa-solid fa-location-dot"></i>
						<%=hd.getDiaChiPhong()%>
					</div>

					<div class="details-grid">
						<div class="detail-item">
							Kỳ thanh toán <strong>Tháng <%=hd.getThangNam()%></strong>
						</div>

						<div class="detail-item">
							Hạn thanh toán <strong><%=DateHelper.formatVN(hd.getHanThanhToan())%></strong>
						</div>

						<div class="detail-item">
							Chủ trọ <strong><%=hd.getTenChuTro()%></strong>
						</div>
					</div>
				</div>

				<div class="action">

					<%
					if (btnDisabled) {
					%>
					<!-- ĐÃ THANH TOÁN -->
					<a class="<%=btnClass%> disabled"
						style="pointer-events: none; opacity: 0.7;"> <i
						class="fa-solid <%=btnIcon%>"></i> <%=btnText%>
					</a>
					<%
					} else {
					%>
					<!-- CHƯA THANH TOÁN / TRỄ HẠN -->
					<a class="<%=btnClass%>"
						href="ChiTietHoaDonThanhToan?id=<%=hd.getId()%>">
						<i class="fa-solid <%=btnIcon%>"></i> <%=btnText%>
					</a>
					<%
					}
					%>

				</div>
			</div>

			<%
			}
			%>
		</div>

		<%
		}
		%>
		
		<%
			Integer totalPage = (Integer) request.getAttribute("totalPage");
			Integer currentPage = (Integer) request.getAttribute("currentPage");

			if (totalPage != null && totalPage > 1) {
			%>
			<nav class="pagination-wrapper">
				<ul class="pagination-list">
					<%
					if (currentPage > 1) {
					%>
					<li><a href="?page=<%=currentPage - 1%>"
						class="pagi-item prev" title="Trang trước"> <i
							class="fa-solid fa-chevron-left"></i>
					</a></li>
					<%
					}
					%>

					<%
					
					int start = Math.max(1, currentPage - 2);
					int end = Math.min(totalPage, currentPage + 2);

					if (start > 1) {
					%>
					<li><a href="?page=1" class="pagi-item">1</a></li>
					<%
					if (start > 2) {
					%><li class="pagi-dots">...</li>
					<%
					}
					%>
					<%
					}
					%>

					<%
					for (int i = start; i <= end; i++) {
					%>
					<li><a href="?page=<%=i%>"
						class="pagi-item <%=(i == currentPage) ? "active" : ""%>"> <%=i%>
					</a></li>
					<%
					}
					%>

					<%
					if (end < totalPage) {
					%>
					<%
					if (end < totalPage - 1) {
					%><li class="pagi-dots">...</li>
					<%
					}
					%>
					<li><a href="?page=<%=totalPage%>" class="pagi-item"><%=totalPage%></a></li>
					<%
					}
					%>

					<%
					if (currentPage < totalPage) {
					%>
					<li><a href="?page=<%=currentPage + 1%>"
						class="pagi-item next" title="Trang tiếp"> <i
							class="fa-solid fa-chevron-right"></i>
					</a></li>
					<%
					}
					%>
				</ul>
				
			</nav>
			<%
			}
			%>


	</div>
	<%@ include file="../includes/footer.jsp"%>
	<script>
        function toggleDropdown(id) {
            const allDropdowns = document.querySelectorAll('.dropdown-content');
            allDropdowns.forEach(d => {
                if(d.id !== id) d.parentElement.classList.remove('active');
            });
            const element = document.getElementById(id);
            element.parentElement.classList.toggle('active');
        }
        window.onclick = function(event) {
            if (!event.target.closest('.dropdown')) {
                const dropdowns = document.querySelectorAll(".dropdown");
                dropdowns.forEach(openDropdown => {
                    openDropdown.classList.remove('active');
                });
            }
        }
    </script>
</body>
</html>