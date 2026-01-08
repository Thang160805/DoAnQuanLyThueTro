package controller.thongbao;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.ThongBaoBO;

import java.io.IOException;

/**
 * Servlet implementation class ChiTietThongBaoAdmin
 */
@WebServlet("/ChiTietThongBaoAdmin")
public class ChiTietThongBaoAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChiTietThongBaoAdmin() {
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
		
		ThongBaoBO tbBO = new ThongBaoBO();
		int is_read = tbBO.getIsReadById(id);
		ThongBao tb = tbBO.getThongBaoById(id);
		request.setAttribute("ChiTietTB", tb);
		
		if(is_read==0) {
			tbBO.DaDocById(id);
		}
		
		RequestDispatcher rs = request.getRequestDispatcher("/admin/ChiTietThongBaoAd.jsp");
		rs.forward(request, response);
	}

}
