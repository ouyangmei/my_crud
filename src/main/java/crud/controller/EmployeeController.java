package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import crud.bean.Msg;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

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
    public Msg savaEmp(Employee employee){
        employeeService.saveEmp(employee);
        return Msg.success();
    }

    //检查用户名是否可用的函数
    @ResponseBody
    @RequestMapping("/checkuser")
    public  Msg checkuser(@RequestParam("empName") String empName){
        boolean b=employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }else{
            return Msg.fail();
        }


    }
}
