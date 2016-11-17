<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<%@ taglib prefix="ts" uri="http://www.touch-spring.com" %>
<%@ taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>ITSS管理后台</title>

    <%@include file="/WEB-INF/common/static.jsp" %>

    <c:set var="PARENT_MENU_CODE" value="PROJECT_MANAGE"/>
    <c:set var="CHILD_MENU_CODE" value="PROJECT_LIST"/>

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
                    <div class="">项目列表</div>
                </div>
            </nav>

            <a href="${ctx}/api/list?projectId=${api.projectId}" class="roll-nav roll-right J_tabExit"><i
                    class="fa fa fa-level-up"></i> 返回</a>        </div>
        <div class="row animated fadeInRight" id="content-main">
            <div class="col-xs-12">

                <div class="row">
                    <div class="col-xs-3">
                        <div class="ibox">
                            <div class="ibox-title">
                                <h5>接口分组</h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link" id="J_groupAdd">
                                        <i class="fa fa-plus"></i>添加分组
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <ul id="J_groupList">
                                    <c:forEach items="${apiGroupList}" var="apiGroup">
                                        <li>${apiGroup.name}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="ibox float-e-margins">

                            <div class="ibox-title">
                                接口列表
                            </div>
                            <div class="ibox-content">

                                <div class="project-list">

                                    <table id="J_projectList" class="table table-hover">

                                        <thead>
                                        <tr>
                                            <th>项目名称</th>
                                            <th>描述</th>
                                            <th>编辑</th>
                                        </tr>
                                        </thead>

                                    </table>
                                </div>

                            </div>
                        </div>
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


            var $JProjectList = $('#J_projectList');


            $('#J_groupAdd').click(function () {
                $.ajax({
                    url: ctx + '/apiGroup/add',
                    method: 'get',
                    dataType: 'html',
                    success: function (str) {
                        yaya.layer.open({
                            type: 1,
                            title: '分类编辑',
                            content: str, //注意，如果str是object，那么需要字符拼接。
                            area: '500px',
                            shadeClose: true,
                            btn: ['保存'],
                            success: function (layer, index) {
                                yaya.validate({
                                    el: '#J_groupForm',
                                    rules: {
                                        username: "required",
                                        password: {
                                            required: true
                                        }
                                    },
                                    messages: {
                                        username: "项目名不能为空",
                                        password: {
                                            required: "密码不能为空"
                                        }
                                    }
                                })
                            },
                            yes: function (index) {
                                var isValid = $("#J_projectForm").valid();

                                if (isValid) {

                                    $.ajax({
                                        url: ctx + '/project/save',
                                        data: $('#J_projectForm').serialize(),
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

            });


            var table = $JProjectList.DataTable({
                'processing': true,
                'searching': false,
                'lengthChange': false,
                'sort': false,
                'serverSide': true,
                'scrollY': 550,
                'lengthMenu': [10, 20, 50, 100],
                'ajax': ctx + '/project/list-data',
                'columns': [
                    {
                        'data': 'name',
                        'render': function (data, type, full, meta) {
                            return '<span>' + data + '</span><br><small>创建于 ' + full.createAt + '</small>';
                        }
                    },
                    {
                        'data': 'description',
                        'render': function (data) {
                            return data;
                        }
                    },
                    {
                        'data': 'id',
                        'render': function (data, type, full, meta) {
                            console.log(data);
                            return '<a href="javascript:;;" class="btn btn-white btn-sm J_projectEdit" data-id="' + data + '" class="J_edit"><i class="fa fa-edit" aria-hidden="true"></i>编辑</a>&nbsp;&nbsp;' +
                                    '<a href="${ctx}/api/list" data-id="' + data + '" class="btn btn-white btn-sm "><i class="fa fa-lock" aria-hidden="true"></i>接口</a>';
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
                    searchPlaceholder: '请输入项目姓名'

                },
                "headerCallback": function (thead, data, start, end, display) {
                    //可以分别打印 thead, data, start, end, display 看看究竟是什么

                    console.log(thead);
                    $(thead).find('th').eq(0).html('显示 ' + (end - start) + ' 条记录');


                    $(thead).css('display', 'none');
                }

            });

            $('#J_projectAdd').click(function () {
                $.ajax({
                    url: ctx + '/project/add',
                    method: 'get',
                    dataType: 'html',
                    success: function (str) {
                        yaya.layer.open({
                            type: 1,
                            title: '项目编辑',
                            content: str, //注意，如果str是object，那么需要字符拼接。
                            area: '500px',
                            shadeClose: true,
                            btn: ['保存'],
                            success: function (layer, index) {
                                yaya.validate({
                                    el: '#J_projectForm',
                                    rules: {
                                        username: "required",
                                        password: {
                                            required: true
                                        }
                                    },
                                    messages: {
                                        username: "项目名不能为空",
                                        password: {
                                            required: "密码不能为空"
                                        }
                                    }
                                })
                            },
                            yes: function (index) {
                                var isValid = $("#J_projectForm").valid();

                                if (isValid) {

                                    $.ajax({
                                        url: ctx + '/project/save',
                                        data: $('#J_projectForm').serialize(),
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

            $JProjectList.on('click', '.J_projectEdit', function () {
                $.ajax({
                    url: ctx + '/project/edit',
                    data: {
                        id: $(this).data('id')
                    },
                    method: 'get',
                    dataType: 'html',
                    success: function (str) {
                        yaya.layer.open({
                            type: 1,
                            title: '项目编辑',
                            content: str, //注意，如果str是object，那么需要字符拼接。
                            area: '550px',
                            shadeClose: true,
                            btn: ['保存'],
                            success: function (layero, index) {

                            },
                            yes: function (index) {
                                $.ajax({
                                    url: ctx + '/project/save',
                                    data: $('#J_projectForm').serialize(),
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


        });


    </script>


</body>

</html>