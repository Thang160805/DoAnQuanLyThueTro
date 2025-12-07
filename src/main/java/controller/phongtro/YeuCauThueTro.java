package controller.phongtro;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;

import java.io.IOException;

/**
 * Servlet implementation class YeuCauThueTro
 */
@WebServlet("/YeuCauThueTro")
public class YeuCauThueTro extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public YeuCauThueTro() {
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
		
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/YeuCauThueTro.jsp");
		rs.forward(request, response);
	}

}
