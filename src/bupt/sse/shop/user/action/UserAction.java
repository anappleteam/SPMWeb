package bupt.sse.shop.user.action;

import java.io.IOException;

import javax.servlet.http.HttpServletResponse;
import org.apache.struts2.ServletActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;
import bupt.sse.shop.user.service.UserService;
import bupt.sse.shop.user.vo.User;

public class UserAction extends ActionSupport implements ModelDriven<User>{
	private User user=new User();
	//注入UserService
	private UserService userService;
	//接收验证码
	private String checkcode;
	public void setCheckcode(String checkcode) {
		this.checkcode = checkcode;
	}
	/**
	 * AJAX校验用户名
	 * @return
	 * @throws IOException 
	 */
	public String findByName() throws IOException{
		User existUser=userService.findByUsername(user.getUsername());
		//获得response对象，向页面输出
		HttpServletResponse response=ServletActionContext.getResponse();
		response.setContentType("text/html;charset=UTF-8");
		if(existUser!=null){
			response.getWriter().print(true);
		}else {
			response.getWriter().print(false);
		}
		return NONE;
	}
	@Override
	public User getModel() {
		return user;
	}
	public String registPage() {
		return "registPage";
	}
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	public String regist(){
		//判断验证码
		//从session中获得验证码
		String checkcodeString=(String) ServletActionContext.getRequest().getSession().getAttribute("checkcode");
		if(!checkcode.equalsIgnoreCase(checkcodeString)){
			this.addActionError("验证码输入错误");
			return "registcheckcodeFail";
		}
		userService.save(user);
		this.addActionMessage("注册成功！请去邮箱激活！");
		return "msg";
	}
	/**
	 * 用户激活
	 */
	public String active() {
		//根据激活码查询用户
		User existUser=userService.findByCode(user.getCode());
		if(existUser==null){
			//激活码错误
			this.addActionMessage("激活失败，激活码错误！");
		}else {
			//激活成功
			//修改用户状态
			existUser.setState(1);
			existUser.setCode(null);
			userService.update(existUser);
			this.addActionMessage("激活成功,请去登录！");
		}
		return "msg";
	}
	/**
	 * 跳转到登录界面
	 */
	public String loginPage() {
		return "loginPage";
	}
	/**
	 * 登录
	 */
	public String login() {
		//判断验证码
		//从session中获得验证码
		String checkcodeString=(String) ServletActionContext.getRequest().getSession().getAttribute("checkcode");
		if(!checkcode.equalsIgnoreCase(checkcodeString)){
			this.addActionError("验证码输入错误");
			return "logincheckcodeFail";
		}
		User existUser=userService.login(user);
		if(existUser==null){
			this.addActionError("登录失败：用户名或密码有误或用户未激活！");
			return LOGIN;
		}
		else {
			ServletActionContext.getRequest().getSession().setAttribute("existUser", existUser);
			return "loginSuccess";
		}
	}
	/**
	 * 用户退出
	 */
	public String quit() {
		ServletActionContext.getRequest().getSession().invalidate();
		return "quit";
	}
}
