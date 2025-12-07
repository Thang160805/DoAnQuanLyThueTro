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
import model.bo.TaiKhoanBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class TatCaThongBao
 */
@WebServlet("/TatCaThongBao")
public class TatCaThongBao extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public TatCaThongBao() {
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
		
		
		
		ThongBaoBO tbBO = new ThongBaoBO();
		ArrayList<ThongBao> listThongBao = tbBO.getListThongBaoById(user.getId());
		request.setAttribute("listThongBao", listThongBao);
		
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/TatCaThongBao.jsp");
		rs.forward(request, response);
	}

}
