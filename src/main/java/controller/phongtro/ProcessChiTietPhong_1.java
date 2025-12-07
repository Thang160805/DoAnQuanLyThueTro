package controller.phongtro;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.bean.Comment;
import model.bean.PhongTro;
import model.bean.TaiKhoan;
import model.bean.ThongBao;
import model.bean.TienIch;
import model.bo.PhongTroBO;
import model.bo.TaiKhoanBO;
import model.bo.ThongBaoBO;
import model.bo.TienIchBO;

import java.io.IOException;
import java.util.ArrayList;

/**
 * Servlet implementation class ProcessChiTietPhong_1
 */
@WebServlet(name = "ChiTietPhong_1", urlPatterns = { "/ChiTietPhong_1" })
public class ProcessChiTietPhong_1 extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ProcessChiTietPhong_1() {
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
		TaiKhoanBO tkBO = new TaiKhoanBO();
		TaiKhoan ThongTin = tkBO.getThongTinCaNhan(user.getId());
		request.setAttribute("ThongTinCaNhan", ThongTin);
		int ID_Phong = Integer.parseInt(request.getParameter("ID_Phong"));
		PhongTroBO ptBO =  new PhongTroBO();
		PhongTro pt = ptBO.getPhongTroById(ID_Phong);
		request.setAttribute("ChiTietPhong", pt);
		
		TienIchBO tiBO = new TienIchBO();
		ArrayList<TienIch> listTienIch = tiBO.getListTienIchByIDPhong(ID_Phong);
		request.setAttribute("listTienIch", listTienIch);
		
		ArrayList<Comment> listComment = ptBO.getListCommentByIDPhong(ID_Phong);
		request.setAttribute("listComment", listComment);
		
		int countComment = ptBO.getCountComment(ID_Phong);
		request.setAttribute("countComment", countComment);
		int avgStar = ptBO.getAvgStarComment(ID_Phong);
		request.setAttribute("avgStar", avgStar);
		
		
		ThongBaoBO tbBO = new ThongBaoBO();
		int countTB = tbBO.getCountThongBao(user.getId());
		request.setAttribute("countTB", countTB);
		ArrayList<ThongBao> listTB = tbBO.getTop3TB(user.getId());
		request.setAttribute("listTB", listTB);
		RequestDispatcher rs = request.getRequestDispatcher("/NguoiDung/ChiTietPhongTro_1.jsp");
		rs.forward(request, response);
	}

}
