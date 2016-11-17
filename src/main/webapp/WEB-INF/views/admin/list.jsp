<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<%@ taglib prefix="ts" uri="http://www.touch-spring.com" %>
<%@ taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>ITSS管理后台</title>

    <%@include file="/WEB-INF/common/static.jsp" %>

    <c:set var="PARENT_MENU_CODE" value="SYSTEM_MANAGE"/>
    <c:set var="CHILD_MENU_CODE" value="ADMIN_LIST"/>

    <script>
        var ctx = '${ctx}';
    </script>

    <style>

    </style>

</head>
<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">

    <%@include file="/WEB-INF/common/slideBar.jsp" %>

    <!--右侧部分开始-->
    <div id="page-wrapper" class="wrapper wrapper-content ">
        <div class="row border-bottom">
            <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
                <div class="navbar-header">
                    <h1>ITSS管理后台</h1>
                </div>
            </nav>
        </div>
        <div class="row content-tabs">
            <nav class="page-tabs J_menuTabs">
                <div class="page-tabs-content">
                    <div class="">管理员列表</div>
                </div>
            </nav>

            <a href="${ctx}/logout" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
        </div>
        <div class="row animated fadeInRight" id="content-main">
            <div class="col-xs-12">

                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>管理员
                            <small>添加,编辑,查询</small>
                        </h5>
                        <div class="ibox-tools">
                            <a class="collapse-link" id="J_adminAdd">
                                <i class="fa fa-plus"></i>新建
                            </a>
                            <a class="collapse-link">
                                <i class="fa fa-close"></i>返回
                            </a>
                        </div>
                    </div>
                    <div class="ibox-content">

                        <table id="J_adminList" class="table table-striped table-bordered table-hover">
                            <thead>
                            <tr>
                                <th>帐号</th>
                                <th>创建时间</th>
                                <th>修改时间</th>
                                <th>edit</th>
                            </tr>
                            </thead>
                        </table>

                    </div>
                </div>

            </div>
        </div>
        <div class="footer">
            <div class="pull-right">
                &copy; 2015-2016 <a href="javascript:void(0);" target="_blank">无锡点春科技股份有限公司</a>
            </div>
        </div>
        <!--右侧部分结束-->

    </div>

    <script src="${ctx}/static/require/require.js"></script>
    <script src="${ctx}/static/require/require.config.js"></script>
    <script>
        require(['jquery', 'yaya', 'datatables.net'], function ($, yaya) {

            var $JAdminList = $('#J_adminList');


            var table = $JAdminList.DataTable({
                'processing': true,
                'searching': false,
                'lengthChange': false,
                'sort': false,
                'serverSide': true,
                'scrollY': 550,
                'lengthMenu': [10, 20, 50, 100],
                'ajax': ctx + '/admin/list-data',
                'columns': [
                    {'data': 'username'},
                    {'data': 'createAt'},
                    {'data': 'updateAt'},
                    {
                        'data': 'id',
                        'render': function (data, type, full, meta) {
                            console.log(data);
                            return '<a href="javascript:;;" data-id="' + data + '" class="J_edit"><i class="fa fa-edit" aria-hidden="true"></i>编辑</a>&nbsp;&nbsp;' +
                                    '<a href="javascript:;;" data-id="' + data + '" class="J_changePassword"><i class="fa fa-lock" aria-hidden="true"></i>重置密码</a>';
                        }
                    }
                ],
                'language': {
                    'lengthMenu': '每页显示 _MENU_ 条记录',
                    'zeroRecords': '没有检索到数据',
                    'info': '第 _START_ 至 _END_ 条数据 共 _TOTAL_ 条记录',
                    'infoEmpty': '没有数据',
                    'processing': '正在加载数据...',
                    'paginate': {
                        'first': '首页',
                        'previous': '前页',
                        'next': '后页',
                        'last': '尾页'
                    },
                    'search': '查询',
                    searchPlaceholder: '请输入用户姓名'

                }

            });

            $('#J_adminAdd').click(function () {
                $.ajax({
                    url: ctx + '/admin/add',
                    method: 'get',
                    dataType: 'html',
                    success: function (str) {
                        yaya.layer.open({
                            type: 1,
                            title: '用户编辑',
                            content: str, //注意，如果str是object，那么需要字符拼接。
                            area: '500px',
                            shadeClose: true,
                            btn: ['保存'],
                            success: function (layer, index) {
                                yaya.validate({
                                    el: '#J_adminForm',
                                    rules: {
                                        username: "required",
                                        password: {
                                            required: true
                                        }
                                    },
                                    messages: {
                                        username: "用户名不能为空",
                                        password: {
                                            required: "密码不能为空"
                                        }
                                    }
                                })
                            },
                            yes: function (index) {
                                var isValid = $("#J_adminForm").valid();

                                if (isValid) {

                                    $.ajax({
                                        url: ctx + '/admin/save',
                                        data: $('#J_adminForm').serialize(),
                                        method: 'post',
                                        dataType: 'json',
                                        success: function (data) {
                                            if (data.code) {
                                                table.draw();
                                                yaya.layer.close(index);

                                            }
                                            else {

                                            }
                                        },
                                        error: function () {

                                        }
                                    });
                                }

                            }

                        });
                    },
                    error: function () {

                    }
                });
            })
            ;

            $JAdminList.on('click', '.J_edit', function () {
                $.ajax({
                    url: ctx + '/admin/edit',
                    data: {
                        id: $(this).data('id')
                    },
                    method: 'get',
                    dataType: 'html',
                    success: function (str) {
                        yaya.layer.open({
                            type: 1,
                            title: '用户编辑',
                            content: str, //注意，如果str是object，那么需要字符拼接。
                            area: '550px',
                            shadeClose: true,
                            btn: ['保存'],
                            success: function (layero, index) {

                            },
                            yes: function (index) {
                                $.ajax({
                                    url: ctx + '/admin/save',
                                    data: $('#J_adminForm').serialize(),
                                    method: 'post',
                                    dataType: 'json',
                                    success: function (data) {
                                        if (data.code) {
                                            table.draw();
                                            yaya.layer.close(index);
                                        }
                                        else {

                                        }
                                    },
                                    error: function () {

                                    }
                                });
                            }

                        });
                    },
                    error: function () {

                    }
                });
            });

            $JAdminList.on('click', '.J_changePassword', function () {
                $.ajax({
                    url: ctx + '/admin/reset-password',
                    data: {
                        id: $(this).data('id')
                    },
                    method: 'get',
                    dataType: 'json',
                    success: function (result) {
                        yaya.layer.msg(result.message);
                    },
                    error: function () {

                    }
                });


                yaya.layer.msg('功能开发中！');
            });

        })


    </script>

</body>

</html>