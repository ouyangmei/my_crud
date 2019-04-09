package crud.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import crud.bean.Employee;
import crud.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    //查询所有员工
    @RequestMapping("/emps")
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
}
