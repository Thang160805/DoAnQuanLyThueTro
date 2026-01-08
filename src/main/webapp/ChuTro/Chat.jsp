<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.bean.PhongTro"%>
<%@ page import="model.bean.TaiKhoan"%>
<%@ page import="model.bean.TinNhan"%>
<%@ page import="model.bo.TinNhanBO"%>
<%@ page import="model.bean.CuocTroChuyen"%>
<%@ page import="utils.TimeHelper"%>
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
	href="${pageContext.request.contextPath}/assets/css/Chat.css">
<style>
.conv-item.unread {
	background: #eef2ff;
	font-weight: 600;
}

.conv-item.read {
	background: #ffffff;
	opacity: 0.7;
}
</style>
</head>
<body>
	<%
	TaiKhoan user = (TaiKhoan) session.getAttribute("user");
	ArrayList<CuocTroChuyen> listCTC = (ArrayList<CuocTroChuyen>) request.getAttribute("listCTC");
	TinNhanBO tnBO = new TinNhanBO();
	%>
	<div class="dashboard-content">
		<div class="chat-dashboard-container">
			<aside class="chat-sidebar">
				<div class="sidebar-header-search">
					<h2 class="sidebar-title">Tin nhắn</h2>
					<div class="search-input-wrapper">
						<i class="fa-solid fa-magnifying-glass"></i> <input type="text"
							placeholder="Tìm người thuê...">
					</div>
				</div>

				<div class="conversation-list" id="conversationList">
					<%
					for (CuocTroChuyen ctc : listCTC) {
					%>
					<div class="conv-item unread"
						id="conv-<%=ctc.getID_NguoiNhan()%>"
						data-ctc-id="<%=ctc.getID_CuocTroChuyen()%>"
						data-receiver-id="<%=ctc.getID_NguoiNhan()%>"
						data-name="<%=ctc.getTenNguoiNhan()%>"
						data-avatar="<%=ctc.getAvatar()%>"
						onclick="loadConversation(this)">


						<div class="avatar-wrapper">
							<img src="<%=ctc.getAvatar()%>" alt=""> <span
								class="status-indicator online"></span>
						</div>
						<%
						TinNhan tn = tnBO.getNewTinNhan(ctc.getID_CuocTroChuyen());
						%>
						<div class="conv-info">
							<div class="conv-header">
								<span class="name"><%=ctc.getTenNguoiNhan()%></span> <span
									class="time"> <%=(tn != null && tn.getThoiGian() != null) ? TimeHelper.timeAgo(tn.getThoiGian()) : ""%>
								</span>


							</div>
							<div class="conv-preview <%=(tn != null) ? "unread" : ""%>">
								<%
								if (tn != null) {
									if (tn.getID_NguoiGui() == user.getId()) {
								%>
								Bạn:
								<%=tn.getNoiDung()%>
								<%
								} else {
								%>
								<%=tn.getNoiDung()%>
								<%
								}
								} else {
								%>
								Chưa có tin nhắn
								<%
								}
								%>
							</div>

						</div>
						<%
						}
						%>


					</div>
			</aside>

			<section class="chat-main">
				<header class="chat-main-header">
					<div class="current-user">
						<img src="" id="headerAvatar" alt="">
						<div class="user-meta">
							<h3 id="headerName">Chọn cuộc trò chuyện</h3>
						</div>
					</div>
					<div class="header-actions">
						<button class="icon-btn-circle">
							<i class="fa-solid fa-phone"></i>
						</button>
						<button class="icon-btn-circle">
							<i class="fa-solid fa-circle-info"></i>
						</button>
					</div>
				</header>

				<div class="message-display" id="messageDisplay"></div>

				<footer class="chat-input-footer">
					<div class="input-actions">
						<button class="btn-attach">
							<i class="fa-solid fa-circle-plus"></i>
						</button>
						<button class="btn-attach">
							<i class="fa-solid fa-image"></i>
						</button>
					</div>
					<div class="chat-input-wrapper">
						<input type="text" id="mainChatInput"
							placeholder="Nhập tin nhắn...">
						<button class="btn-emoji">
							<i class="fa-regular fa-face-smile"></i>
						</button>
					</div>
					<button class="btn-send-msg" id="btnSend">
						<i class="fa-solid fa-paper-plane"></i>
					</button>
				</footer>
			</section>
		</div>
	</div>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script>
	let currentCTCId = null;
	let currentReceiverId = null;
const myId = <%=user.getId()%>;
const contextPath = "<%=request.getContextPath()%>";


const display   = document.getElementById("messageDisplay");
const sendBtn   = document.getElementById("btnSend");
const chatInput = document.getElementById("mainChatInput");

function updateSidebarOnNewMessage(senderId, content) {

    const conv = document.getElementById("conv-" + senderId);
    if (!conv) return;

    // preview
    const preview = conv.querySelector(".conv-preview");
    preview.innerText = content;

    // time
    const timeEl = conv.querySelector(".time");
    timeEl.innerText = "Vừa xong";

    // unread
    conv.classList.remove("read");
    conv.classList.add("unread");

    // move lên đầu
    const list = document.getElementById("conversationList");
    list.prepend(conv);
}



function loadConversation(el) {

    document.querySelectorAll(".conv-item")
        .forEach(i => i.classList.remove("active"));
    el.classList.add("active");

    // 🔥 ĐÁNH DẤU ĐÃ XEM
    el.classList.remove("unread");
    el.classList.add("read");

    currentCTCId      = el.dataset.ctcId;
    currentReceiverId = el.dataset.receiverId;

    document.getElementById("headerName").innerText = el.dataset.name;
    document.getElementById("headerAvatar").src     = el.dataset.avatar;

    fetch(contextPath + "/LoadTinNhan?ctcId=" + currentCTCId)
        .then(res => res.text())
        .then(html => {
            display.innerHTML = html;
            display.scrollTop = display.scrollHeight;
        });
}


const socket = new WebSocket(
    "ws://" + location.host + contextPath + "/chat?userId=" + myId
);

socket.onopen = () => {
    console.log("✅ WebSocket connected");
};

socket.onerror = () => {
    console.error("❌ WebSocket error");
};

socket.onmessage = function (event) {

    const parts = event.data.split("|", 2);
    const senderId = parseInt(parts[0]);
    const content  = parts[1];

    if (senderId === currentReceiverId) {
        // đang mở cuộc chat
        renderIncomingMessage(content);
    } else {
        // KHÔNG mở → update sidebar
        updateSidebarOnNewMessage(senderId, content);
    }
};

function sendMessage() {
    const text = chatInput.value.trim();
    if (!text || !currentReceiverId) return;

    chatInput.value = "";

   
    renderOutgoingMessage(text);

    socket.send(myId + "|" + currentReceiverId + "|" + text);

    // lưu DB
    fetch(contextPath + "/XuLyGuiTinNhanCuaCT", {
        method: "POST",
        headers: { "Content-Type": "application/x-www-form-urlencoded" },
        body: "message=" + encodeURIComponent(text) +
              "&idNguoiNhan=" + currentReceiverId
    });
}


sendBtn.onclick = sendMessage;

chatInput.addEventListener("keydown", e => {
    if (e.key === "Enter") {
        e.preventDefault();
        sendMessage();
    }
});

function renderOutgoingMessage(text) {
    const time = getTimeNow();
    const html =
        '<div class="msg-group outgoing">' +
            '<div class="msg-bubble">' + escapeHtml(text) + '</div>' +
            '<span class="msg-time">' + time + '</span>' +
        '</div>';
    display.insertAdjacentHTML("beforeend", html);
    display.scrollTop = display.scrollHeight;
}

function renderIncomingMessage(text) {
    const time = getTimeNow();
    const html =
        '<div class="msg-group incoming">' +
            '<div class="msg-bubble">' + escapeHtml(text) + '</div>' +
            '<span class="msg-time">' + time + '</span>' +
        '</div>';

    display.insertAdjacentHTML("beforeend", html);
    display.scrollTop = display.scrollHeight;
}


function getTimeNow() {
    return new Date().toLocaleTimeString([], {
        hour: "2-digit",
        minute: "2-digit"
    });
}

function escapeHtml(text) {
    const div = document.createElement("div");
    div.innerText = text;
    return div.innerHTML;
}
</script>

</body>
</html>