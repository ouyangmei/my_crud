<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>员工列表</title>
    <%
        request.setAttribute("APP_PATH", request.getContextPath());
    %>
    <!--web路径:
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出问题。
    以/开始的相对路径，找资源，以服务器的路径为标准（http://localhost:3306);需要加上项目名
                  http://localhost:3306/crud
    -->
    <!--Bootstrap-->
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <!--若jquery的引入在bootstrap后面则在添加模态框时会无效果，此处将顺序调整过来即可-->
    <!--引入jquery-->
    <script type="text/javascript" src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <!--引入jquery-->

</head>
<body>
<!-- 员工增加的模态框 -->
<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="emp_Name_add_input" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@ecut.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_add_select">
                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工修改的模态框 -->
<div class="modal fade" id="empUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title">员工修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static"></p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_update_input" placeholder="email@ecut.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <!--部门提交部门id即可-->
                            <select class="form-control" name="dId" id="dept_update_select">
                            </select>
                        </div>
                    </div>


                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!--搭建显示页面-->
<div class="container">
    <!--标题-->
    <div class="row">
        <div class=".col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>
    <!-- 按钮-->
    <div classs="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp_delete_all_btn">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div calss="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all"/>
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                </tbody>
            </table>
        </div>

    </div>
    <!--显示分页信息-->
    <div class="row">
        <!--分页文字信息-->
        <div class="col-md-6" id="page_info_area">
        </div>
        <!--分页条信息-->
        <div class="col-md-6" id="page_nav_area">
        </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    var totalRecord,currentNumPage;
    //1.页面加载完成以后，直接去发送一个ajax请求，要到分页数据
    $(function (){
        to_page(1);
    });

    function to_page(pn){
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                //console.log(result);
                //1.解析并显示员工数据
                //2.解析并显示分页信息
                build_emps_table(result);
                bulid_page_info(result);
                bulid_page_nav(result);
            }
        });
    }
    function build_emps_table(result) {
        //每次发送ajax请求时要对表格体进行清空，否则将重叠在一起
        $("#emp_table tbody").empty();
        var emps = result.extend.pageInfo.list;
        $.each(emps, function (index, item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item' /></td>");
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            //此处不能正常显示部门信息
            var deptName = $("<td></td>").append(item.deptName);
            var editBtn = $("<botton></botton>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-pencil")
                .append("编辑");
            //为编辑按钮添加自定义属性，来表示当前id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<botton></botton>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-trash")
                .append("删除");
            delBtn.attr("delete-id",item.empId);
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptName)
                .append(btnTd)
                .appendTo("#emp_table tbody");
        });
    }
    function bulid_page_info(result) {
        //每次请求发送ajax 请求时要将显示分页信息的内容清空否则将重叠在一起
        $("#page_info_area").empty();
        $("#page_info_area").append("当前"+result.extend.pageInfo.pageNum+"页，总共"
            + result.extend.pageInfo.pages+"页，共"
            + result.extend.pageInfo.total+"条记录");
        totalRecord=result.extend.pageInfo.total;
        currentNumPage=result.extend.pageInfo.pageNum;
    }
    function bulid_page_nav(result) {
        //每次发送ajax请求时要将分页导航栏信息清空，否则将出现重叠的情况
        $("#page_nav_area").empty();
        var ul=$("<ul></ul>").addClass("pagination");
        var firstPageLi =$("<li></li>").append($("<a></a>").append("首页").attr("href","#"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        //判断是否有前一页，若有则将首页和上一页元素禁用
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }
        else{
        firstPageLi.click(function () {
            to_page(1);})
        prePageLi.click(function () {
            to_page(result.extend.pageInfo.pageNum-1);})
        }
        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi =$("<li></li>").append($("<a></a>").append("末页").attr("href","#"));
        //判断是否有后一页一页，若有则将末页和下一页元素禁用
        if(result.extend.pageInfo.hasNextPage==false)
        {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        else{
            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum+1);})
        lastPageLi.click(function () {
            to_page(result.extend.pageInfo.pages);})
        }
        //添加首页和前一页的提示
        ul.append(firstPageLi).append(prePageLi);
        //遍历给<ul>中添加页码提示
        $.each(result.extend.pageInfo.navigatepageNums,function (index,item){
            var numLi=$("<li></li>").append($("<a></a>").append(item));
            if(result.extend.pageInfo.pageNum==item)
            {
                numLi.addClass("active");
            }
            numLi.click(function () {
                to_page(item);
            });
            ul.append(numLi);
        });
        //添加下一页和末页的提示
        ul.append(nextPageLi).append(lastPageLi);
        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }
    //清空表单样式及内容
    function reset_form(ele){
        //清空表单数据
        $(ele)[0].reset();
        //清空表单中的样式
        $(ele).find("*").removeClass("has-success has-error");
        //清空表单中的文字提示信息
        $(ele).find(".help-block").text("");

    }
    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function(){
        //每次点击后清空表单中的数据信息
        //去document元素,然后使用dom 的reset函数清空
        //$("#empAddModal form")[0].reset();
        //表单完整重置
        reset_form("#empAddModal form");
        //发送ajax请求，查出部门信息，显示在下拉列表
        getDepts("#empAddModal select");
        //弹出模态框
      $("#empAddModal").modal({
          backdrop:"static"
      });
    });
    //查出所有的部门信息
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                //显示所有部门信息在模态框里面
                //$("#empAddModal select").append("")
                $.each(result.extend.depts,function () {
                    var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo($(ele));
                });
            }
        });
    }
    //校验表单数据
    function validate_add_form(){
        //1.先拿到要检验的数据，校验用户名
       var empName= $("#emp_Name_add_input").val();
       var regName=/(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFE]{2,5}$)/;
       if(!regName.test(empName)){
           show_validate_msg("#emp_Name_add_input","error","用户名必须是2-5位中文或6-16位英文和数字及_-的组合");
           return false;
       }
       else {
           show_validate_msg("#emp_Name_add_input","success","");
       }
       //校验邮箱信息
        var email=$("#email_add_input").val();
        var regEmail= /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
      if( !regEmail.test(email)){
          show_validate_msg("#email_add_input","error","请输入正确的邮箱地址");
          return false;
      }
      else {
          show_validate_msg("#email_add_input","success","");
      }
      return true;
    }
    //显示校验结果的提示信息
    function show_validate_msg(ele,statue,msg){
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if(statue=="success"){
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }
        else if(statue=="error"){
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //点击保存员工的方法
        $("#emp_save_btn").click(function () {
            //1.模态框中填写的表单数据提交给服务器进行保存
                //1.先对要提交给服务器的数据进行校验
            if(!validate_add_form()){
                return false;
            }
            //判断ajax用户名校验是否成功（）是否重复？
            if( $("#emp_save_btn").attr("ajax_va")=="error"){
                return false;
            }
            //2.发送ajax请求保存员工
          $.ajax({
              url:"${APP_PATH}/emp",
              type:"POST",
              data:$("#empAddModal form").serialize(),
              success:function (result) {
                  //1.关闭模态框
                  $("#empAddModal").modal('hide');
                  //2.来到最后一页，显示刚才保存的数据
                  //发送ajax请求显示最后一页数据即可
                  //可以将总记录数当做页码，来跳转到最后一页
                  to_page(totalRecord);
              }
          });
        });
    //检验用户名是否可用
    $("#emp_Name_add_input").change(function () {

        //发送ajax请求判断用户名是否可用
        var empName=$("#emp_Name_add_input").val();
        $.ajax({
            url:"${APP_PATH}/checkuser",
            data:"empName="+empName,
            type:"POST",
            success:function(result){
                if(result.code==100)
                {
                    show_validate_msg("#emp_Name_add_input","success","用户名可用");
                    //设置一个属性来标志用户名是否合法，合法则将ajax_va属性赋值俄日success
                    $("#emp_Name_add_input").attr("ajax_va","success");
                }
                else{
                    show_validate_msg("#emp_Name_add_input","error",result.extend.va_msg);
                    //设置一个属性来标志用户名是否合法，不合法则将ajax_va属性赋值俄日error
                    $("#emp_Name_add_input").attr("ajax_va","error");
                }
            }
        });
    });
    //按钮创建之前就绑定了click，所以绑定不成功
    //1.可以在创建按钮的时候绑定时间
    //2.绑定点击.live(),但是jquery新版没有live，可以使用on 进行替换
    //on 的使用方法：参考JQuery文档，on("事件"，"元素",动作)
    $(document).on("click",".edit_btn",function(){
        //alert("5");
        //1.查出员工信息，显示员工信息
        //2.查出部门信息，显示部门信息
        getEmp($(this).attr("edit-id"));
        getDepts("#empUpdateModal select");
        //把员工的Id传递给模态框按钮
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModal").modal({
            backdrop:"static"
        });
    });
    //获取员工数据并显示在页面中
    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function(result){
                //将员工数据进行显示
                var empDate=result.extend.emp;
                $("#empName_update_static").text(empDate.empName);
                $("#email_update_input").val(empDate.email);
                $("#empUpdateModal input[name=gender]").val([empDate.gender]);
                $("#empUpdateModal select").val([empDate.dId]);
            },
        });
    }
    //添加对点击更新按钮的单击事件，使其保存数据并进行校验
    $("#emp_update_btn").click(function () {
        //1.校验邮箱信息
        var email=$("#email_update_input").val();
        var regEmail= /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if( !regEmail.test(email)){
            show_validate_msg("#email_update_input","error","请输入正确的邮箱地址");
            return false;
        }
        else {
            show_validate_msg("#email_update_input","success","");
        }
        //2.发送ajax请求保存员工的数据
        //我们要支持直接发送PUT类的请求还要封装请求体中的数据
        //在配置文件中配置HttpPutFormContentFilter
        //他的作用就是讲请求要中的数据解析包装成一个map
        //request被重新包装，request.getParamter()被重写，就会从直接封装的map中取出对象
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            //员工修改序列化后的结果
            //data:$("#empUpdateModal form").serialize()+"&_method=PUT",
            data:$("#empUpdateModal form").serialize(),
            success:function(result){
                //关闭会话框
                $("#empUpdateModal").modal('hide');
                //回到本页面
                to_page(currentNumPage);
            }
        });
    });
    //单个删除功能
    $(document).on("click",".delete_btn",function(){
        //弹出确认删除对话框
        //先取出要2删除的行的名字
        var empId=$(this).attr("delete-id");
        var empName=$(this).parents("tr").find("td:eq(2)").text()
        if(confirm("确认删除【"+empName+"】吗？")){
            //点击确认则发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+empId,
                type:"DELETE",
                success:function (result) {
                    to_page(currentNumPage);
                }
            });
        }
    });
    //点击全选按钮时下面的按钮全为选中状态
    $("#check_all").click(function(){
        //attr获取checked的值为undefined
        //dom元生的属性不要用attr去获取，要用prop去获取，而attr一般用于获取自定义属性的值
        //alert($(this).prop("checked"));
        $(".check_item").prop("checked",$(this).prop("checked"));
    });
    $(document).on("click",".check_item",function () {
        //判断当前选择选中的元素是不是当前页面的记录个数
       var flag= $(".check_item:checked").length==$(".check_item").length;
       $("#check_all").prop("checked",flag);
    });
    $("#emp_delete_all_btn").click(function () {
        //提示要删除的员工姓名
        //先找到被选中的元素
        var empName="";
        var del_idstr="";
        $.each($(".check_item:checked"),function(){
           empName=empName+($(this).parents("tr").find("td:eq(2)").text())+",";
           //组装员工id的字符串
            del_idstr=del_idstr+$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        //取出empName中多余的,
        empName=empName.substring(0,empName.length-1);
        //去除员工id 多余的-
        del_idstr=del_idstr.substring(0,empName.length-1);
        if(confirm("确认删除【"+empName+"】吗？")){
            //发送ajax请求
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(currentNumPage);
                }
            });

        }
    });

    //点击全部删除则披批量删除
</script>
</body>
</html>