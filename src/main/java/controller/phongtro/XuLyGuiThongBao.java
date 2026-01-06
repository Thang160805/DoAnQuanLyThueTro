package controller.phongtro;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bo.HopDongBO;
import model.bo.ThongBaoBO;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

/**
 * Servlet implementation class XuLyGuiThongBao
 */
@WebServlet("/XuLyGuiThongBao")
public class XuLyGuiThongBao extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public XuLyGuiThongBao() {
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
		String tieuDe = request.getParameter("tieuDe");
        String noiDung = request.getParameter("noiDung");
        String idNguoiThue = request.getParameter("ID_NguoiThue");
        
        if (tieuDe == null || tieuDe.trim().isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Vui lòng nhập tiêu đề\"}");
            return;
        }

        if (noiDung == null || noiDung.trim().isEmpty()) {
            out.print("{\"status\":\"error\",\"message\":\"Vui lòng nhập nội dung\"}");
            return;
        }

        ThongBaoBO tbBO = new ThongBaoBO();
        ThongBao tb = new ThongBao();
        

        if ("All".equals(idNguoiThue)) {

            HopDongBO hdBO = new HopDongBO();
            ArrayList<Integer> listID = hdBO.listID_NguoiThue();

            for (int id : listID) {
            	tb.setSender_id(user.getId());
                tb.setReceiver_id(id);
                tb.setTitle(tieuDe);
                tb.setFull_content(noiDung);
                tbBO.insertGuiThongBao(tb);
            }

        } else {
            int id = Integer.parseInt(idNguoiThue);
            tb.setSender_id(user.getId());
            tb.setReceiver_id(id);
            tb.setTitle(tieuDe);
            tb.setFull_content(noiDung);
            tbBO.insertGuiThongBao(tb);
            tbBO.insertGuiThongBao(tb);
        }

        out.print("{\"status\":\"success\"}");
	}

}
