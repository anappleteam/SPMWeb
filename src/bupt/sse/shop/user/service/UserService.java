package bupt.sse.shop.user.service;
import org.springframework.transaction.annotation.Transactional;

import bupt.sse.shop.user.dao.UserDao;
import bupt.sse.shop.user.vo.User;
import bupt.sse.shop.utils.MailUitls;
import bupt.sse.shop.utils.UUIDUtils;

@Transactional
public class UserService {
	//注入UserDao
	private UserDao userDao;
	
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	public User findByUsername(String username) {
		return userDao.findByUsername(username);
	}
	//实现用户注册
	public void save(User user) {
		//数据存入数据库
		user.setState(0); //0代表未激活，1代表已激活
		String code =UUIDUtils.getUUID()+UUIDUtils.getUUID();
		user.setCode(code);
		userDao.save(user);
		//发邮件
		try {
			MailUitls.sendMail(user.getEmail(), user.getName(),code);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public User findByCode(String code) {
		return userDao.findByCode(code);
	}
	//修改用户状态
	public void update(User existUser) {
		userDao.update(existUser);
	}
	public User login(User user) {
		return userDao.login(user);
	}
}
