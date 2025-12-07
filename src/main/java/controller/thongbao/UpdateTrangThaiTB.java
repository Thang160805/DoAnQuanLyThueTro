package controller.thongbao;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class UpdateTrangThaiTB
 */
@WebServlet("/UpdateTrangThaiTB")
public class UpdateTrangThaiTB extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UpdateTrangThaiTB() {
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
		PrintWriter out = response.getWriter();
		TaiKhoan user = (TaiKhoan) session.getAttribute("user");
		if (user == null) {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
			return;
		}
		response.setContentType("application/json;charset=UTF-8");
		String action = request.getParameter("action");

		if ("DocTatCa".equals(action)) {
		    int receiverId = Integer.parseInt(request.getParameter("receiverId"));
		    ThongBaoBO tbBO = new ThongBaoBO();
		    tbBO.DocTatCa(receiverId);

		    response.setContentType("application/json;charset=UTF-8");
		    out.print("{\"status\":\"success\"}");
		    return;
		}
	}

}
