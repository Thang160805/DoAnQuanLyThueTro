package controller.phongtro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bo.HoaDonBO;

import java.io.IOException;
import java.io.PrintWriter;

/**
 * Servlet implementation class XuLyThanhToanHoaDon
 */
@WebServlet("/XuLyThanhToanHoaDon")
public class XuLyThanhToanHoaDon extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyThanhToanHoaDon() {
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
		response.setContentType("application/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		int idHoaDon = Integer.parseInt(request.getParameter("idHoaDon"));
		HoaDonBO hdBO = new HoaDonBO();
		boolean checked = hdBO.updateTrangThaiHoaDon(idHoaDon);
		if (checked) {
            out.print("{\"success\": true, \"message\": \"Đã ghi nhận thanh toán. Vui lòng chờ chủ trọ xác nhận.\"}");
        } else {
            out.print("{\"success\": false, \"message\": \"Không thể cập nhật trạng thái hóa đơn\"}");
        }
	}

}
