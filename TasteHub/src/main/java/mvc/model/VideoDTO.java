package mvc.model;

import java.sql.Date;

public class VideoDTO {
	//video table
	private int videoID;
	private String title;
	private String detail;
	private Date createDate;
	private Date viewDate;
	private String urlThumbnail;
	private String urlVideo;
	private long cntView;
	private long cntLike;
	
	
	//user table
	private int userID;
	private String userName;
	private String urlUserImg;
	private String email;
	private String introTxt;
	
	public VideoDTO() {
		super();
	}
	
	//video
	public int getVideoID() {
		return videoID;
	}
	public void setVideoID(int videoID) {
		this.videoID = videoID;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public Date getViewDate() {
		return viewDate;
	}
	public void setViewDate(Date viewDate) {
		this.viewDate = viewDate;
	}
	public String getUrlThumbnail() {
		return urlThumbnail;
	}
	public void setUrlThumbnail(String urlThumbnail) {
		this.urlThumbnail = urlThumbnail;
	}
	public String getUrlVideo() {
		return urlVideo;
	}
	public void setUrlVideo(String urlVideo) {
		this.urlVideo = urlVideo;
	}
	public long getCntView() {
		return cntView;
	}
	public void setCntView(long cntView) {
		this.cntView = cntView;
	}
	public long getCntLike() {
		return cntLike;
	}
	public void setCntLike(long cntLike) {
		this.cntLike = cntLike;
	}
	
	//user
	public int getUserID() {
		return userID;
	}
	public void setUserID(int userID) {
		this.userID = userID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUrlUserImg() {
		return urlUserImg;
	}
	public void setUrlUserImg(String urlUserImg) {
		this.urlUserImg = urlUserImg;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getIntroTxt() {
		return introTxt;
	}
	public void setIntroTxt(String introTxt) {
		this.introTxt = introTxt;
	}
}
