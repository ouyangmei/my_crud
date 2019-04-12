package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import crud.bean.Msg;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.validation.Valid;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    //需要导入jackson包，ResponseBody才能正常工作
    @RequestMapping("/emps")
    //若无下列注解运行该jsp页面会出现404错误
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1")Integer pn){
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageinfo 查询的结果,只需要将pageinfo交给页面就可以
        //封装了详细的分页信息，包括有我们查询出来的数据,连续传入显示的页数
        PageInfo page=new PageInfo(emps,5);
        return Msg.success().add("pageInfo",page);
    }
    //查询所有员工
    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn, Model model){
        //引入PageHelper分页插件
        //在查询之前只需要调用，传入页码以及分页每页的大小
        PageHelper.startPage(pn,5);
        //startPage后面紧跟的查询就是一个分页查询
        List<Employee> emps = employeeService.getAll();
        //使用pageinfo 查询的结果,只需要将pageinfo交给页面就可以
        //封装了详细的分页信息，包括有我们查询出来的数据,连续传入显示的页数
        PageInfo page=new PageInfo(emps,5);
        model.addAttribute("pageInfo",page);
        return "list";
    }
    //员工保存请求 ，/emp POST
    @RequestMapping(value="/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败，
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError : errors) {
                System.out.println("错误的字段名：" + fieldError.getField());
                System.out.println("错误的信息：" + fieldError.getDefaultMessage());
                map.put(fieldError.getField(), fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }
    //支持TSR303校验要导入hibernate-validator包
    //检查用户名是否可用的函数
    //正确的校验方式：前端加后端校验，防止非法数据的加入，时程序更加安全
    //可用spring mvc提供的JSR303进行后端校验，同时考虑给用户名添加唯一约束
    @ResponseBody
    @RequestMapping("/checkuser")
    public  Msg checkuser(@RequestParam("empName") String empName){
        //先判断用户名是否合法,java里面的正则表达式没有斜杠
        String regx="(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFE]{2,5}$)";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是2-5位中文或6-16位英文和数字及_-的组合");
        }
        //用户名重复校验
        boolean b=employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail().add("va_msg","用户名不可用");
        }
    }
}
