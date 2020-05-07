package controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import pojo.Admin;
import pojo.AlsoBorrow;
import service.AdminService;
import service.BookService;
import service.BorrowService;
import utils.PythonUtil;

import javax.servlet.http.HttpSession;

@Controller
@SessionAttributes(value={"admin2","category", "alsoBorrow"})
public class LoginController {
	// 推荐算法
//	private static final String python_str = "C:\\Users\\jin\\Desktop\\4\\mylibrary\\src\\main\\resources\\also_borrow_recommendation_func.py";
	private static final String python_str = "D:\\毕业项目\\4\\mylibrary\\src\\main\\resources\\also_borrow_recommendation_func.py";
	@Autowired
	private BookService bookService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private BorrowService borrowService;

	//用于跳转,ajax返回成功跳转到管理员界面index.jsp
	@RequestMapping(value = "/index")
	public String login(Model model, HttpSession session) {
		model.addAttribute("category",bookService.listCategory());
		Admin admin = (Admin)session.getAttribute("admin2");
		String access  =  admin.getAccess();
		if (access.equals("0")){
			String leaderId = admin.getAdminId();
			Integer bookId = borrowService.historyBook(leaderId);
			// 执行推荐算法
			PythonUtil.executePython(bookId,python_str);

			AlsoBorrow alsoBorrow = new AlsoBorrow();
			alsoBorrow.setUserId(leaderId);
			alsoBorrow.setBookId(bookId);
			model.addAttribute("alsoBorrow", alsoBorrow);
			System.out.println(access);
		}
		return "index";
	}
	//读者借阅界面readerIndex.jsp
	@RequestMapping(value = "/frontIndex")
	public String login2(Model model,HttpSession session) {
		Admin admin = (Admin)session.getAttribute("admin2");
		String access  =  admin.getAccess();
		if (access.equals("1")){
			String leaderId = admin.getAdminId();
			Integer bookId = borrowService.historyBook(leaderId);
			// 执行推荐算法
			PythonUtil.executePython(bookId,python_str);

			AlsoBorrow alsoBorrow = new AlsoBorrow();
			alsoBorrow.setUserId(leaderId);
			alsoBorrow.setBookId(bookId);
			model.addAttribute("alsoBorrow", alsoBorrow);
			System.out.println(access);
		}
		model.addAttribute("category",bookService.listCategory());
		return "frontIndex";
	}
	
	//ajax请求过来/login
	@RequestMapping(value = "/library/login")
	public  @ResponseBody
		String list(Admin admin,Model model){
		System.out.println("登录用户信息："+admin);
		Admin admin2=adminService.login(admin);
		//返回视图index.jsp
		//权限标志0或1
		model.addAttribute("admin2",admin2);
		return admin2.getAccess();
	}
	//检查原密码
	@RequestMapping(value = "/checkPwd")
	public  @ResponseBody
	String checkPwd(@RequestParam(value = "password",defaultValue = "0") String password, HttpSession session){
		Admin admin=(Admin) session.getAttribute("admin2");
		//直接获取session中的密码进行比较
		return admin.getPassword().equals(password)?"1":"0";
	}
	//跳转到修改密码界面
	@RequestMapping(value = "/toAlterpwdPage")
	public String toAlterpwdPage() {
		return "alterPwd";
	}
	//修改密码
	@RequestMapping(value = "/alterpwd")
	public  @ResponseBody
	String alterpwd(Admin admin,HttpSession session){
		Admin admin1=(Admin) session.getAttribute("admin2");
		admin1.setPassword(admin.getPassword());
		adminService.alterpwd(admin1);
		return "1";
	}

	//注销
	@RequestMapping(value = "/loginout")
	public  String loginout(HttpSession session){
		session.invalidate();
		return "redirect:login.jsp";
	}
}
