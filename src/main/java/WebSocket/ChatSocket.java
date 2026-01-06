package WebSocket;

import jakarta.websocket.OnClose;
import jakarta.websocket.OnMessage;
import jakarta.websocket.OnOpen;
import jakarta.websocket.Session;
import jakarta.websocket.server.ServerEndpoint;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@ServerEndpoint("/chat")
public class ChatSocket {
    private static Map<Integer, Session> users = new ConcurrentHashMap<>();

    @OnOpen
    public void onOpen(Session session) {
        try {
            int userId = Integer.parseInt(
                session.getRequestParameterMap().get("userId").get(0)
            );
            users.put(userId, session);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        try {
            String[] parts = message.split("\\|", 3);
            int senderId = Integer.parseInt(parts[0]);
            int receiverId = Integer.parseInt(parts[1]);
            String content = parts[2];

            Session receiverSession = users.get(receiverId);
            if (receiverSession != null && receiverSession.isOpen()) {
                receiverSession.getAsyncRemote().sendText(
                    senderId + "|" + content
                );
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @OnClose
    public void onClose(Session session) {
        users.values().remove(session);
    }
}

