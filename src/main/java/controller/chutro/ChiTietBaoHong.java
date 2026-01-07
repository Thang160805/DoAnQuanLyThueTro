package controller.chutro;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.BaoHong;
import model.bean.TaiKhoan;
import model.bo.BaoHongBO;

import java.io.IOException;

/**
 * Servlet implementation class ChiTietBaoHong
 */
@WebServlet("/ChiTietBaoHong")
public class ChiTietBaoHong extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChiTietBaoHong() {
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
		int idBaoHong = Integer.parseInt(request.getParameter("id"));
		BaoHongBO bhBO = new BaoHongBO();
		BaoHong bh = bhBO.getBaoHongById(idBaoHong);
		request.setAttribute("ChiTietBH", bh);
		RequestDispatcher rs = request.getRequestDispatcher("/ChuTro/ChiTietBaoHong.jsp");
		rs.forward(request, response);
	}

}
