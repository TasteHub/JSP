package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import mvc.database.DBConnection;

public class VideoDAO {

	private static VideoDAO instance;

	private VideoDAO() {
	}

	public static VideoDAO getInstance() {
		if (instance == null)
			instance = new VideoDAO();
		return instance;
	}

	// home.do
	public ArrayList<VideoDTO> getHomeVideoList() {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql;
		sql = "SELECT userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate FROM "
				+ "( SELECT V.userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate, cntLike, detail FROM "
				+ "Video as V, User as U WHERE U.userID = V.userID ORDER BY UNIX_TIMESTAMP(createDate) desc LIMIT 0,30)"
				+ " as VU ORDER BY cntLike DESC";
		ArrayList<VideoDTO> list = new ArrayList<VideoDTO>();
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				VideoDTO video = new VideoDTO();
				video.setVideoID(rs.getInt("videoID"));
				video.setTitle(rs.getString("title"));
				video.setCreateDate(rs.getDate("createDate"));
				video.setUrlThumbnail(rs.getString("urlThumbnail"));
				video.setCntView(rs.getInt("cntView"));

				video.setUserID(rs.getInt("userID"));
				video.setUserName(rs.getString("userName"));
				video.setUrlUserImg(rs.getString("urlUserImg"));

				list.add(video);
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getHomeVideoList() 예외발생: " + ex);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return null;
	}

	// search.do
	public ArrayList<VideoDTO> getSearchVideoList(String searchTxt) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql;
		sql = "SELECT videoID, V.userID, urlThumbnail, title, cntLike, cntView, createDate, detail, urlUserImg, userName"
				+ " FROM(SELECT videoID, userID, urlThumbnail, title, cntLike, cntView, createDate, detail FROM Video"
				+ " WHERE MATCH(title) AGAINST('" + searchTxt
				+ "' IN BOOLEAN MODE) ORDER BY UNIX_TIMESTAMP(createDate) DESC LIMIT 0,30)"
				+ " as V, User as U WHERE V.userID = U.userID ORDER BY cntLike DESC";
		ArrayList<VideoDTO> list = new ArrayList<VideoDTO>();
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				VideoDTO video = new VideoDTO();
				video.setVideoID(rs.getInt("videoID"));
				video.setTitle(rs.getString("title"));
				video.setDetail(rs.getString("detail"));
				video.setCreateDate(rs.getDate("createDate"));
				video.setUrlThumbnail(rs.getString("urlThumbnail"));
				video.setCntView(rs.getInt("cntView"));

				video.setUserID(rs.getInt("userID"));
				video.setUserName(rs.getString("userName"));
				video.setUrlUserImg(rs.getString("urlUserImg"));

				list.add(video);
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getSearchVideoList() 예외발생: " + ex);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return null;
	}

	// subscribe.do
	public ArrayList<VideoDTO> getSubVideoList(String input) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "SELECT userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate, detail "
				+ "FROM ( SELECT U.userID, userName, urluserImg, videoID, urlthumbnail, title, cntView, createDate, detail "
				+ "FROM ( SELECT videoID, V.userID, title, createDate, urlThumbnail, cntView, cntLike, detail "
				+ "FROM Subscribe as S, Video as V WHERE S.userID = " + input
				+ " AND userSubID = V.userID ) as VS, User as U "
				+ "WHERE U.userID = VS.userID ORDER BY cntLike desc) as VU ORDER BY UNIX_TIMESTAMP(createDate) desc LIMIT 0,30";
		ArrayList<VideoDTO> list = new ArrayList<VideoDTO>();
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				VideoDTO video = new VideoDTO();
				video.setVideoID(rs.getInt("videoID"));
				video.setTitle(rs.getString("title"));
				video.setDetail(rs.getString("detail"));
				video.setCreateDate(rs.getDate("createDate"));
				video.setUrlThumbnail(rs.getString("urlThumbnail"));
				video.setCntView(rs.getInt("cntView"));

				video.setUserID(rs.getInt("userID"));
				video.setUserName(rs.getString("userName"));
				video.setUrlUserImg(rs.getString("urlUserImg"));

				list.add(video);
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getSubVideoList() 예외발생: " + ex);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return null;
	}

	// history.do
	public ArrayList<VideoDTO> getHistoryVideoList(String searchTxt, String input) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		if (searchTxt == null)
			searchTxt = "";
		else
			searchTxt = searchTxt.replace('\\', ' ').trim();

		String sql_search = "";
		if (!searchTxt.trim().isEmpty()) {
			sql_search = " AND MATCH(title) AGAINST('" + searchTxt + "' IN BOOLEAN MODE) ";
		}

		String sql;
		sql = "SELECT WV.userID, WV.videoID, urlThumbnail, title, userName, cntView, createDate, detail, viewDate "
				+ "FROM ( SELECT viewDate, V.videoID, V.userID, title, urlThumbnail, cntView, createDate, detail "
				+ "FROM View as W, Video as V WHERE W.userID = " + input + " AND V.videoID = W.videoID " + sql_search
				+ ") as WV, User as U WHERE U.userID = WV.userID GROUP BY videoID ORDER BY UNIX_TIMESTAMP(viewDate) DESC";
		ArrayList<VideoDTO> list = new ArrayList<VideoDTO>();
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				VideoDTO video = new VideoDTO();
				video.setVideoID(rs.getInt("videoID"));
				video.setTitle(rs.getString("title"));
				video.setDetail(rs.getString("detail"));
				video.setCreateDate(rs.getDate("createDate"));
				video.setUrlThumbnail(rs.getString("urlThumbnail"));
				video.setCntView(rs.getInt("cntView"));
				video.setViewDate(rs.getDate("viewDate"));

				video.setUserID(rs.getInt("userID"));
				video.setUserName(rs.getString("userName"));

				list.add(video);
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getHistoryVideoList() 예외발생: " + ex);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return null;
	}

	// deleteHistory.do
	public void delHistoryList(String userID, String videoID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();
			String sql = "DELETE FROM View where videoID = ? AND userID = ?;"
					+ "UPDATE Video SET cntView = (SELECT count(viewID) FROM View WHERE View.videoID = ?) WHERE videoID = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(2, userID);
			pstmt.setString(1, videoID);
			pstmt.setString(3, videoID);
			pstmt.setString(4, videoID);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("delHistoryList() 예외발생: " + ex);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

	// likelist.do
	public ArrayList<VideoDTO> getLikeVideoList(String input) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql;
		sql = "SELECT WV.userID, WV.videoID, urlThumbnail, title, userName, cntView, createDate, detail "
				+ "FROM ( SELECT likeDate, V.videoID, V.userID, title, urlThumbnail, cntView, createDate, detail "
				+ "FROM LikeBtn as L, Video as V WHERE L.userID = " + input + " AND V.videoID = L.videoID "
				+ "ORDER BY UNIX_TIMESTAMP(likeDate) desc LIMIT 0,30) as WV, User as U WHERE U.userID = WV.userID;";
		ArrayList<VideoDTO> list = new ArrayList<VideoDTO>();
		try {
			conn = DBConnection.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				VideoDTO video = new VideoDTO();
				video.setVideoID(rs.getInt("videoID"));
				video.setTitle(rs.getString("title"));
				video.setDetail(rs.getString("detail"));
				video.setCreateDate(rs.getDate("createDate"));
				video.setUrlThumbnail(rs.getString("urlThumbnail"));
				video.setCntView(rs.getInt("cntView"));

				video.setUserID(rs.getInt("userID"));
				video.setUserName(rs.getString("userName"));

				list.add(video);
			}
			return list;
		} catch (Exception ex) {
			System.out.println("getLikeVideoList() 예외발생: " + ex);
		} finally {
			try {
				if (rs != null)
					rs.close();
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
		return null;
	}

	// deleteLike.do
	public void delLikeList(String userID, String videoID) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			conn = DBConnection.getConnection();
			String sql = "DELETE FROM LikeBtn where videoID = ? AND userID = ?;"
					+ "UPDATE Video SET cntLike = (SELECT count(likeID) FROM LikeBtn where LikeBtn.videoID = ?) WHERE videoID = ?;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(2, userID);
			pstmt.setString(1, videoID);
			pstmt.setString(3, videoID);
			pstmt.setString(4, videoID);
			pstmt.executeUpdate();
		} catch (Exception ex) {
			System.out.println("delHistoryList() 예외발생: " + ex);
		} finally {
			try {
				if (pstmt != null)
					pstmt.close();
				if (conn != null)
					conn.close();
			} catch (Exception ex) {
				throw new RuntimeException(ex.getMessage());
			}
		}
	}

}
