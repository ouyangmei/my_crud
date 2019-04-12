package crud.service;

import crud.bean.Employee;
import crud.bean.EmployeeExample;
import crud.dao.EmployeeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.SQLOutput;
import java.util.List;

@Service
public class EmployeeService {

    @Autowired
    EmployeeMapper employeeMapper;


    public List<Employee> getAll(){
        return employeeMapper.selectByExampleWithDept(null);
    }
    //员工保存
    public void saveEmp(Employee employee) {
        employeeMapper.insertSelective(employee);
    }

    //检验用户名是否可用
    //return true 代表当前姓名可用否则用户名重名
    public boolean checkUser(String empName) {
        EmployeeExample example=new EmployeeExample();
        //创建查询条件
        EmployeeExample.Criteria criteria=example.createCriteria();
        criteria.andEmpNameEqualTo(empName);
        //看符合条件的数据有多少项
        employeeMapper.countByExample(example);
        long count=employeeMapper.countByExample(example);
        return count==0;
    }

    //按照员工Id查询员工
    public Employee  getEmp(Integer id){
        Employee employee=employeeMapper.selectByPrimaryKey(id);
        return employee;
    }
}