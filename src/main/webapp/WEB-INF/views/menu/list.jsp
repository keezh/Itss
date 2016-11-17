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

    <style type="text/css">
        div#J_rightMenu {
            position: absolute;
            visibility: hidden;
            top: 0;
            text-align: left;
            padding: 2px;
        }

        div#J_rightMenu ul li {
            margin: 1px 0;
            padding: 0 5px;
            cursor: pointer;
            list-style: none outside none;
            background-color: #eeeeee;
        }

        div#J_rightMenu ul li:hover {
            background: #dbdbdb;
        }
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
                    <div class="row">
                        <div class="col-xs-6">
                            <div class="ibox-content">

                                <ul id="J_menuTree" class="ztree"></ul>


                            </div>
                        </div>
                        <div class="col-xs-6">
                            <div class="ibox-content">
                                <table id="J_menuList" class="table table-striped table-bordered table-hover">
                                    <thead>
                                    <tr>
                                        <th></th>
                                        <th>名称</th>
                                        <th>CODE</th>
                                        <th>分类</th>
                                        <th>地址</th>
                                        <th>操作</th>
                                    </tr>
                                    </thead>
                                </table>

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
    <div id="J_rightMenu">
        <ul>
            <li id="J_MenuAdd">增加权限</li>
            <li id="J_MenuEdit">修改</li>
            <li id="J_MenuUp">上移</li>
            <li id="J_MenuDown">下移</li>
            <li id="J_MenuDelete">删除</li>
        </ul>
    </div>
    <script src="${ctx}/static/require/require.js"></script>
    <script src="${ctx}/static/require/require.config.js"></script>
    <script>
        require(['jquery', 'yaya', 'ztree', 'datatables'], function ($, yaya) {

            var $JMenuList = $('#J_menuList');
            var $JMenuTree = $('#J_menuTree');
            var J_rightMenu = $("#J_rightMenu");

            J_rightMenu.on('click', '#J_MenuAdd', function () {

            });
            J_rightMenu.on('click', '#J_MenuEdit', function () {

            });
            J_rightMenu.on('click', '#J_MenuUp', function () {

            });
            J_rightMenu.on('click', '#J_MenuDown', function () {

            });
            J_rightMenu.on('click', '#J_MenuDelete', function () {
                hideJ_rightMenu();
                var nodes = zTree.getSelectedNodes();
                if (nodes && nodes.length > 0) {
                    if (nodes[0].children && nodes[0].children.length > 0) {
                        var msg = "要删除的节点是父节点，如果删除将连同子节点一起删掉。\n\n请确认！";
                        if (confirm(msg) == true) {
                            zTree.removeNode(nodes[0]);
                        }
                    } else {
                        zTree.removeNode(nodes[0]);
                    }
                }
            });
            var setting = {
                async: {
                    enable: true,
                    url: ctx + '/menu/tree-data',
                    autoParam: ['id', 'name=n', 'level=lv'],
                    otherParam: {'otherParam': 'zTreeAsyncTest'},
                    dataFilter: filter
                },
                callback: {
                    onRightClick: OnRightClick
                }
            };

            function OnRightClick(event, treeId, treeNode) {
                if (!treeNode && event.target.tagName.toLowerCase() != "button" && $(event.target).parents("a").length == 0) {
                    zTree.cancelSelectedNode();
                    showJ_rightMenu("root", event.clientX, event.clientY);
                } else if (treeNode && !treeNode.noR) {
                    zTree.selectNode(treeNode);
                    showJ_rightMenu("node", event.clientX, event.clientY);
                }
            }


            function showJ_rightMenu(type, x, y) {
                $("#J_rightMenu ul").show();
                J_rightMenu.css({"top": y + "px", "left": x + "px", "visibility": "visible"});

                $("body").bind("mousedown", onBodyMouseDown);
            }

            function hideJ_rightMenu() {
                if (J_rightMenu) J_rightMenu.css({"visibility": "hidden"});
                $("body").unbind("mousedown", onBodyMouseDown);
            }

            function onBodyMouseDown(event) {
                if (!(event.target.id == "J_rightMenu" || $(event.target).parents("#J_rightMenu").length > 0)) {
                    J_rightMenu.css({"visibility": "hidden"});
                }
            }

            function filter(treeId, parentNode, childNodes) {
                if (!childNodes) return null;
                for (var i = 0, l = childNodes.length; i < l; i++) {
                    childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
                }
                return childNodes;
            }

            $.fn.zTree.init($JMenuTree, setting);


            var zTree = $.fn.zTree.getZTreeObj("J_menuTree");


            /**
             * 菜单列表初始化
             */
            var menuList = $JMenuList.DataTable({
                'processing': true,
                'serverSide': true,
                'searching': false,
                'lengthChange': false,
                'scrollY': 550,
                'ajax': ctx + '/menu/list-data',
                'columns': [
                    {
                        'class': 'details-control',
                        'orderable': false,
                        'data': null,
                        'defaultContent': ''
                    },
                    {'data': 'name'},
                    {'data': 'code'},
                    {'data': 'type'},
                    {'data': 'parent'},
                    {
                        'data': 'id',
                        'render': function (data, type, full, meta) {
                            return '<a href="javascript:;;" data-id="' + data + '" class="J_edit">编辑</a>' + '<a href="javascript:;;" data-id="' + data + '" class="J_delete">删除</a>';
                        }
                    }
                ],
                'language': {                          //汉化
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


            /**
             * 子菜单格式化显示
             */
            function format(d) {
                var html = '<table class="table table-striped table-bordered table-hover">';
                for (var i = 0; i < d.children.length; i++) {
                    html = html +
                            '<tr>' +
                            '<td>' + d.children[i].name + '</td>' +
                            '<td>' + d.children[i].code + '</td>' +
                            '</tr>';
                }
                html += '</table>';
                return html;
            }

            /**
             * 显示子菜单
             */
            $JMenuList.on('click', 'td.details-control', function () {
                var tr = $(this).closest('tr'); //closest() 方法获得匹配选择器的第一个祖先元素
                var row = menuList.row(tr);
                if (!row.child.isShown()) {
                    // Open this row
                    row.child(format(row.data())).show();
                    tr.addClass('shown');
                }
                else {
                    // This row is already open - close it
                    row.child.hide();
                    tr.removeClass('shown');
                }
            });

            /**
             * 菜单编辑
             */
            $JMenuList.on('click', '.J_edit', function () {
                console.log(this);
                $.ajax({
                    url: ctx + '/menu/edit',
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
                                    url: ctx + '/menu/save',
                                    data: $('#J_menuForm').serialize(),
                                    method: 'post',
                                    dataType: 'json',
                                    success: function (data) {
                                        if (data.code) {
                                            menuList.draw();
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
                })
            });
            /**
             * 菜单编辑
             */
            $JMenuList.on('click', '.J_delete', function () {
                console.log(this);
                $.ajax({
                    url: ctx + '/menu/delete',
                    data: {
                        id: $(this).data('id')
                    },
                    method: 'post',
                    dataType: 'json',
                    success: function (result) {
                        menuList.draw();
                        yaya.layer.msg('删除成功!');
                    },
                    error: function () {

                    }
                })
            });


        })
    </script>

</body>

</html>

