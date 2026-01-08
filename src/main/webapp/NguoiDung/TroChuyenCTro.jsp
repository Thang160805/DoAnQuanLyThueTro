<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.TinNhan"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Chat</title>
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
	href="${pageContext.request.contextPath}/assets/css/TroChuyenCTro.css">
<script src="https://unpkg.com/lucide@latest"></script>
</head>
<body>
	<%
	TaiKhoan tk = (TaiKhoan) request.getAttribute("ThongTin");

	TaiKhoan user = (TaiKhoan) session.getAttribute("user");
	ArrayList<TinNhan> listTinNhan = (ArrayList<TinNhan>) request.getAttribute("listTinNhan");

	DateTimeFormatter timeFmt = DateTimeFormatter.ofPattern("HH:mm");
	%>
	<div class="chat-wrapper">
		<header class="chat-header">
			<div class="header-left">
				<button class="btn-icon" onclick="history.back()">
					<i data-lucide="chevron-left"></i>
				</button>
				<div class="user-info">
					<div class="avatar-container">
						<img src="<%=tk.getAvatar()%>" alt="Avatar"> <span
							class="status-dot online"></span>
					</div>
					<div class="user-text">
						<h3><%=tk.getHoTen()%></h3>
					</div>
				</div>
			</div>
			<div class="header-right" style="display: flex;">
				<button class="btn-icon">
					<i data-lucide="phone"></i>
				</button>
				<button class="btn-icon mobile-hide">
					<i data-lucide="more-horizontal"></i>
				</button>
			</div>
		</header>

		<main class="message-area" id="messageArea">

			<%
			if (listTinNhan != null && !listTinNhan.isEmpty()) {

				java.time.LocalDate currentDate = null;

				for (TinNhan tn : listTinNhan) {

					java.time.LocalDate msgDate = tn.getThoiGian().toLocalDate();

					if (currentDate == null || !msgDate.equals(currentDate)) {
				currentDate = msgDate;
			%>
			<div class="date-divider">
				<%
				java.time.LocalDate today = java.time.LocalDate.now();
				if (msgDate.equals(today)) {
					out.print("Hôm nay");
				} else if (msgDate.equals(today.minusDays(1))) {
					out.print("Hôm qua");
				} else {
					out.print(msgDate.format(java.time.format.DateTimeFormatter.ofPattern("dd/MM/yyyy")));
				}
				%>
			</div>
			<%
			}

			boolean isMe = tn.getID_NguoiGui() == user.getId();
			%>

			<div class="msg-row <%=isMe ? "outgoing" : "incoming"%>">
				<div class="msg-bubble">
					<%=tn.getNoiDung()%>
					<span class="msg-time"> <%=tn.getThoiGian().format(timeFmt)%>
					</span>
				</div>
			</div>

			<%
			}
			} else {
			%>

			<p style="text-align: center; color: #999;">Chưa có tin nhắn nào</p>

			<%
			}
			%>

		</main>

		<footer class="message-input-bar">
			<div class="input-actions" style="display: flex;">
				<button class="btn-icon">
					<i data-lucide="image"></i>
				</button>
				<button class="btn-icon">
					<i data-lucide="plus-circle"></i>
				</button>
			</div>
			<div class="input-container">
				<input type="text" id="chatInput" placeholder="Nhập tin nhắn..."
					autocomplete="off">
				<button style="border: none;" class="emoji-btn">
					<i data-lucide="smile"></i>
				</button>
			</div>
			<button type="button" class="btn-send" id="btnSend">
				<i data-lucide="send"></i>
			</button>
		</footer>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
const chatInput   = document.getElementById("chatInput");
const btnSend     = document.getElementById("btnSend");
const messageArea = document.getElementById("messageArea");

// ID người đang đăng nhập
const myId = <%=user.getId()%>;

// ID người đang chat cùng (chủ trọ)
const otherId = <%=tk.getId()%>;

/* ================== WEBSOCKET ================== */

// Kết nối WebSocket
const socket = new WebSocket(
    "ws://" + location.host + "<%=request.getContextPath()%>/chat?userId=" + myId
);

socket.onopen = function () {
    console.log("✅ WebSocket connected");
};

socket.onmessage = function (event) {
    const parts = event.data.split("|", 2);
    const senderId = parseInt(parts[0]);
    const content  = parts[1];

    if (senderId === myId) return;

    renderMessage(content, false);
};

socket.onerror = function () {
    console.error("❌ WebSocket error");
};



function sendMessage() {
    const text = chatInput.value.trim();
    if (text.length === 0) return;

    chatInput.value = "";


    renderMessage(text, true);


    socket.send(myId + "|" + otherId + "|" + text);

    $.ajax({
        url: "<%=request.getContextPath()%>/XuLyGuiTinNhan",
				type : "POST",
				data : {
					message : text,
					idChuTro : otherId
				}
			});

		}

		function renderMessage(text, isMe) {
			const time = new Date().toLocaleTimeString([], {
				hour : "2-digit",
				minute : "2-digit"
			});

			const html = '<div class="msg-row '
					+ (isMe ? 'outgoing' : 'incoming') + '">'
					+ '<div class="msg-bubble">' + escapeHtml(text)
					+ '<span class="msg-time">' + time + '</span>' + '</div>'
					+ '</div>';

			messageArea.insertAdjacentHTML("beforeend", html);
			messageArea.scrollTop = messageArea.scrollHeight;
		}

		btnSend.addEventListener("click", function(e) {
			e.preventDefault();
			sendMessage();
		});

		chatInput.addEventListener("keydown", function(e) {
			if (e.key === "Enter" && !e.shiftKey) {
				e.preventDefault();
				sendMessage();
			}
		});

		function escapeHtml(text) {
			const div = document.createElement("div");
			div.innerText = text;
			return div.innerHTML;
		}
	</script>



	<script>
		lucide.createIcons();
	</script>
</body>
</html>