package controller.chutro;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.YeuCauThueTro;
import model.bo.YeuCauThueTroBO;

import java.io.IOException;

/**
 * Servlet implementation class ChiTietYeuCauThue
 */
@WebServlet("/ChiTietYeuCauThue")
public class ChiTietYeuCauThue extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChiTietYeuCauThue() {
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
		
		int id = Integer.parseInt(request.getParameter("id"));
		YeuCauThueTroBO ycBO = new YeuCauThueTroBO();
		YeuCauThueTro yc = ycBO.getChiTietYeuCauThueByID(id);
		request.setAttribute("ChiTietYeuCau", yc);
		RequestDispatcher rs = request.getRequestDispatcher("/ChuTro/ChiTietYeuCauThue.jsp");
		rs.forward(request, response);
	}

}
