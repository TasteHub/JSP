package mvc.controller;

import java.io.IOException;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import mvc.model.VideoDAO;
import mvc.model.VideoDTO;

public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("userID");
		
		String RequestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = RequestURI.substring(contextPath.length());
		
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		
		if (command.equals("/home.do")) {//home.jsp 페이지 출력하기
			requestHomeVideo(request);
			RequestDispatcher rd = request.getRequestDispatcher("./home.jsp");
			rd.forward(request, response);
		}
		else if(command.equals("/search.do")) {//search.jsp 페이지 출력하기
			requestSearchVideo(request);
			RequestDispatcher rd = request.getRequestDispatcher("./search.jsp");
			rd.forward(request, response);
		}
		else if(command.equals("/subscribe1.do")) {//subscribe.jsp 페이지 출력하기
			requestSubVideo(request, id);
			RequestDispatcher rd = request.getRequestDispatcher("./subscribe_com.jsp");
			rd.forward(request, response);
		}
		else if(command.equals("/subscribe2.do")) {//subscribe.jsp 페이지 출력하기
			requestSubVideo(request, id);
			RequestDispatcher rd = request.getRequestDispatcher("./subscribe_list.jsp");
			rd.forward(request, response);
		}
		else if(command.equals("/history.do")) {//history.jsp 페이지 출력하기
			requestHistoryVideo(request, id);
			RequestDispatcher rd = request.getRequestDispatcher("./history.jsp");
			rd.forward(request, response);
		}
		else if(command.equals("/delHistory.do")) {//history 삭제
			requestDelHistoryVideo(request, id);
			RequestDispatcher rd = request.getRequestDispatcher("/history.do");
			rd.forward(request, response);
		}
		else if(command.equals("/likeList.do")) {//likelist.jsp 페이지 출력하기
			requestLikeVideo(request, id);
			RequestDispatcher rd = request.getRequestDispatcher("./likelist.jsp");
			rd.forward(request, response);
		}
		else if(command.equals("/delLikeList.do")) {//like 삭제
			requestDelLikeVideo(request, id);
			RequestDispatcher rd = request.getRequestDispatcher("/likeList.do");
			rd.forward(request, response);
		} else if(command.equals("/subscribe.do")) {//like 삭제
			subscribeChannel(request, id);
			RequestDispatcher rd = request.getRequestDispatcher("./subscribe_all.jsp");
			rd.forward(request, response);
		}
		else {
			RequestDispatcher rd = request.getRequestDispatcher("./errNoPage");;
			rd.forward(request, response);
		}
		
	}
	public void requestHomeVideo(HttpServletRequest request) {
		VideoDAO dao = VideoDAO.getInstance();
		ArrayList<VideoDTO> videolist = new ArrayList<VideoDTO>();
		
		videolist = dao.getHomeVideoList();
		
		request.setAttribute("videolist", videolist);
	}
	public void requestSearchVideo(HttpServletRequest request) {
		VideoDAO dao = VideoDAO.getInstance();
		ArrayList<VideoDTO> videolist = new ArrayList<VideoDTO>();
		
		String searchTxt = request.getParameter("searchTxt");
		videolist = dao.getSearchVideoList(searchTxt);
		
		request.setAttribute("videolist", videolist);
		request.setAttribute("query", searchTxt);
	}
	public void requestSubVideo(HttpServletRequest request, String id) {
		VideoDAO dao = VideoDAO.getInstance();
		ArrayList<VideoDTO> videolist = new ArrayList<VideoDTO>();
		
		videolist = dao.getSubVideoList(id);
		
		request.setAttribute("videolist", videolist);
	}
	public void requestHistoryVideo(HttpServletRequest request, String id) {
		VideoDAO dao = VideoDAO.getInstance();
		ArrayList<VideoDTO> videolist = new ArrayList<VideoDTO>();
		
		String searchTxt = request.getParameter("searchTxt");
		videolist = dao.getHistoryVideoList(searchTxt, id);
		
		request.setAttribute("videolist", videolist);
		request.setAttribute("query", searchTxt);
	}
	public void requestDelHistoryVideo(HttpServletRequest request, String userID) {
		VideoDAO dao = VideoDAO.getInstance();
		
		String videoID = request.getParameter("videoID");
		dao.delHistoryList(userID, videoID);

	}
	public void requestLikeVideo(HttpServletRequest request, String id) {
		VideoDAO dao = VideoDAO.getInstance();
		ArrayList<VideoDTO> videolist = new ArrayList<VideoDTO>();
		
		String searchTxt = request.getParameter("searchTxt");
		videolist = dao.getLikeVideoList(id);
		
		request.setAttribute("videolist", videolist);
		request.setAttribute("query", searchTxt);
	}
	
	public void requestDelLikeVideo(HttpServletRequest request, String userID) {
		VideoDAO dao = VideoDAO.getInstance();
		
		String videoID = request.getParameter("videoID");
		dao.delLikeList(userID, videoID);

	}
	public void subscribeChannel(HttpServletRequest request, String id) {
		VideoDAO dao = VideoDAO.getInstance();
		ArrayList<VideoDTO> videolist = new ArrayList<VideoDTO>();
		
		videolist = dao.subsChannelList(id);
		
		request.setAttribute("videolist", videolist);
	}

}
