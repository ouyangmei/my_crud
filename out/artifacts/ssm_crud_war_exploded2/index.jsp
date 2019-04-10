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
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="email_add_input" placeholder="email@ecut.com">
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
            <button class="btn btn-danger">删除</button>
        </div>
    </div>
    <!--显示表格数据-->
    <div class="row">
        <div calss="col-md-12">
            <table class="table table-hover" id="emp_table">
                <thead>
                    <tr>
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
    var totalRecord;
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
            var empIdTd = $("<td></td>").append(item.empId);
            var empNameTd = $("<td></td>").append(item.empName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            //此处不能正常显示部门信息
            var deptName = $("<td></td>").append(item.deptName);
            var editBtn = $("<botton></botton>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-pencil")
                .append("编辑");
            //为编辑按钮添加属性，来表示当前id
            editBtn.attr("edit-id",item.empId);
            var delBtn = $("<botton></botton>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>")).addClass("glyphicon glyphicon-trash")
                .append("删除");
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
            $("<tr></tr>").append(empIdTd)
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
    //点击新增按钮弹出模态框
    $("#emp_add_modal_btn").click(function(){
        //发送ajax请求，查出部门信息，显示在下拉列表
        getDepts();

        //弹出模态框
      $("#empAddModal").modal({
          backdrop:"static"
      });
    });
    //查出所有的部门信息
    function getDepts() {
        $("#empAddModal select").empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function (result) {
                //显示所有部门信息在模态框里面
                //$("#empAddModal select").append("")
                $.each(result.extend.depts,function () {
                    var optionEle=$("<option></option>").append(this.deptName).attr("value",this.deptId);
                    optionEle.appendTo($("#empAddModal select"));
                });
            }
        });
    }
        $("#emp_save_btn").click(function () {
            //1.模态框中填写的表单数据提交给服务器进行保存
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

</script>
</body>
</html>