package controller.TinNhan;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.TinNhan;
import model.bo.TinNhanBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;

/**
 * Servlet implementation class LoadTinNhan
 */
@WebServlet("/LoadTinNhan")
public class LoadTinNhan extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoadTinNhan() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		TaiKhoan user = (TaiKhoan) session.getAttribute("user");
		if (user == null) {
		    response.sendRedirect(request.getContextPath() + "/index.jsp");
		    return;
		}
		response.setContentType("text/html;charset=UTF-8");
        int ctcId = Integer.parseInt(request.getParameter("ctcId"));
        TinNhanBO tnBO = new TinNhanBO();
        ArrayList<TinNhan> list = tnBO.getTinNhanByID(ctcId);
        PrintWriter out = response.getWriter();
        DateTimeFormatter fmt = DateTimeFormatter.ofPattern("HH:mm");

        for (TinNhan tn : list) {
            boolean isMe = tn.getID_NguoiGui() == user.getId();

            out.print("""
                <div class="msg-group %s">
                    <div class="msg-bubble">%s</div>
                    <span class="msg-time">%s</span>
                </div>
            """.formatted(
                isMe ? "outgoing" : "incoming",
                tn.getNoiDung(),
                tn.getThoiGian().format(fmt)
            ));
        }
	}

}
