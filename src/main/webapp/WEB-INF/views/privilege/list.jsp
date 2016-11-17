<%--suppress ALL --%>
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
    <c:set var="CHILD_MENU_CODE" value="MENU_LIST"/>

    <script>
        var ctx = '${ctx}';
    </script>


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
                    <div class="">权限管理</div>
                </div>
            </nav>

            <a href="${ctx}/logout" class="roll-nav roll-right J_tabExit"><i class="fa fa fa-sign-out"></i> 退出</a>
        </div>
        <div class="row animated fadeInRight" id="content-main">
            <div class="col-xs-12">

                <div class="row">
                    <div class="col-xs-3">
                        <div class="ibox">
                            <div class="ibox-title">
                                <h5>权限</h5>
                                <div class="ibox-tools" id="J_privilegeTools">
                                    <a class="collapse-link" id="J_privilegeAdd">
                                        <i class="fa fa-plus"></i>添加
                                    </a>
                                    <a class="collapse-link" id="J_privilegeEdit">
                                        <i class="fa fa-edit"></i>修改
                                    </a>
                                    <a class="collapse-link" id="J_privilegeUp">
                                        <i class="fa fa-caret-square-o-up"></i>上移
                                    </a>
                                    <a class="collapse-link" id="J_privilegeDown">
                                        <i class="fa fa-caret-square-o-down"></i>下移
                                    </a>
                                    <a class="collapse-link" id="J_privilegeDelete">
                                        <i class="fa fa-close"></i>删除
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <ul id="J_privilegeTree" class="ztree"></ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-9">
                        <div class="ibox-content">
                            <table id="J_privilegeList" class="table table-striped table-bordered table-hover">
                                <thead>
                                <tr>
                                    <th>名称</th>
                                    <th>CODE</th>
                                    <th>分类</th>
                                    <th>地址</th>
                                </tr>
                                </thead>
                            </table>

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
        require(['jquery', 'yaya', 'ztree', 'datatables'], function ($, yaya) {

            /**
             * 菜单列表
             */
            var $JPrivilegeList = $('#J_privilegeList');

            /**
             * 菜单树
             */
            var $JPrivilegeTree = $('#J_privilegeTree');


            /**
             * 菜单操作
             */
            var $J_privilegeTools = $("#J_privilegeTools");

            /**
             * 菜单列表对象
             */
            var privilegeList;


            var pageParm = {
                privilegeId: null
            };

            /**
             * ztree 对象
             */
            var zTree;


            var PrivilegeModel = {
                add: function (parentId) {
                    $.ajax({
                        url: ctx + '/privilege/add',
                        data: {
                            parentId: parentId
                        },
                        method: 'get',
                        dataType: 'html',
                        success: function (str) {
                            yaya.layer.open({
                                type: 1,
                                title: '添加菜单',
                                content: str, //注意，如果str是object，那么需要字符拼接。
                                area: '550px',
                                shadeClose: true,
                                btn: ['保存'],
                                success: function (layero, index) {
                                    yaya.validate({
                                        el: '#J_privilegeForm',
                                        rules: {
                                            name: "required",
                                            code: {
                                                required: true
                                            }
                                        },
                                        messages: {
                                            name: "权限名称不能为空",
                                            code: {
                                                required: "权限编码不能为空"
                                            }
                                        }
                                    })
                                },
                                yes: function (index) {
                                    var isValid = $("#J_privilegeForm").valid();
                                    if (isValid) {
                                        $.ajax({
                                            url: ctx + '/privilege/save',
                                            data: $('#J_privilegeForm').serialize(),
                                            method: 'post',
                                            dataType: 'json',
                                            success: function (result) {
                                                if (result.code) {
                                                    yaya.layer.msg('添加成功!');
                                                    var nodes = zTree.getSelectedNodes();
                                                    if (nodes && nodes.length > 0) {

                                                        zTree.expandNode(nodes[0]);
                                                        zTree.addNodes(nodes[0], -1, result.data);

                                                    }

                                                    privilegeList.draw();
                                                    yaya.layer.close(index);
                                                }
                                                else {

                                                }
                                            },
                                            error: function () {
                                                yaya.layer.msg('系统异常');

                                            }
                                        });
                                    }

                                }

                            });
                        },
                        error: function () {
                            yaya.layer.msg('系统异常');
                        }
                    })

                },
                edit: function (id) {
                    $.ajax({
                        url: ctx + '/privilege/edit',
                        data: {
                            id: id
                        },
                        method: 'get',
                        dataType: 'html',
                        success: function (str) {
                            yaya.layer.open({
                                type: 1,
                                title: '菜单编辑',
                                content: str, //注意，如果str是object，那么需要字符拼接。
                                area: '550px',
                                shadeClose: true,
                                btn: ['保存'],
                                success: function (layero, index) {
                                    yaya.validate({
                                        el: '#J_privilegeForm',
                                        rules: {
                                            name: "required",
                                            code: {
                                                required: true
                                            }
                                        },
                                        messages: {
                                            name: "权限名称不能为空",
                                            code: {
                                                required: "权限编码不能为空"
                                            }
                                        }
                                    })
                                },
                                yes: function (index) {
                                    var isValid = $("#J_privilegeForm").valid();
                                    if (isValid) {

                                        $.ajax({
                                            url: ctx + '/privilege/save',
                                            data: $('#J_privilegeForm').serialize(),
                                            method: 'post',
                                            dataType: 'json',
                                            success: function (result) {
                                                if (result.code) {
                                                    yaya.layer.msg('修改成功!');
                                                    var nodes = zTree.getSelectedNodes();
                                                    if (nodes && nodes.length > 0) {

                                                        nodes[0].name = result.data.name;
                                                        zTree.updateNode(nodes[0]);
                                                    }
                                                    privilegeList.draw();
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
                    })
                },
                delete: function (id) {
                    $.ajax({
                        url: ctx + '/privilege/delete',
                        data: {
                            id: id
                        },
                        method: 'post',
                        dataType: 'json',
                        success: function (result) {
                            if (result.code) {
                                privilegeList.draw();
                                yaya.layer.msg('删除成功!');
                                var nodes = zTree.getSelectedNodes();
                                if (nodes && nodes.length > 0) {
                                    zTree.removeNode(nodes[0]);
                                }
                            } else {
                                yaya.layer.msg('删除失败，该节点下还有子节点!');
                            }

                        },
                        error: function () {
                            yaya.layer.msg('系统异常');
                        }
                    })
                }

            }


            /**
             * 菜单添加
             */
            $J_privilegeTools.on('click', '#J_privilegeAdd', function () {
                var nodes = zTree.getSelectedNodes();
                if (nodes && nodes.length > 0) {
                    if (nodes[0].type === 2) {
                        yaya.layer.msg('该节点为【按钮】,不能添加子节点');
                        return;
                    }
                    if (nodes[0].id === '#') {
                        PrivilegeModel.add();
                    } else {
                        PrivilegeModel.add(nodes[0].id);
                    }
                }
            });

            /**
             * 菜单编辑
             */
            $J_privilegeTools.on('click', '#J_privilegeEdit', function () {
                var nodes = zTree.getSelectedNodes();
                if (nodes && nodes.length > 0) {
                    if (nodes[0].id === '#') {
                        yaya.layer.msg('根结点不能修改！');
                    } else {
                        PrivilegeModel.edit(nodes[0].id);
                    }
                }
            });

            /**
             * 菜单上移
             */
            $J_privilegeTools.on('click', '#J_privilegeUp', function () {
                yaya.layer.msg('功能正在开发中！');
                //todo

            });

            /**
             * 菜单下移
             */
            $J_privilegeTools.on('click', '#J_privilegeDown', function () {
                yaya.layer.msg('功能正在开发中！');

                //todo
            });


            /**
             * 菜单删除
             */
            $J_privilegeTools.on('click', '#J_privilegeDelete', function () {
                debugger;

                var nodes = zTree.getSelectedNodes();

                if (nodes && nodes.length > 0) {
                    PrivilegeModel.delete(nodes[0].id);
                }
            });

            var treeSetting = {
                async: {
                    enable: true,
                    url: ctx + '/privilege/tree-data',
                    autoParam: ['id'],

                },
                callback: {
                    onAsyncSuccess: function (event, treeId, treeNode, msg) {

                        if (!treeNode) {
                            zTree.expandNode(zTree.getNodes()[0], true);
                        }

                    },
                    onClick: function (event, treeId, treeNode) {
                        if (treeNode.id === '#') {
                            pageParm.privilegeId = null;
                            privilegeList.draw();
                        } else {
                            pageParm.privilegeId = treeNode.id;
                            privilegeList.draw();
                        }

                    }
                }

            };

            $.fn.zTree.init($JPrivilegeTree, treeSetting);


            zTree = $.fn.zTree.getZTreeObj("J_privilegeTree");


            /**
             * 菜单列表初始化
             */
            privilegeList = $JPrivilegeList.DataTable({
                'processing': true,
                'serverSide': true,
                'searching': false,
                'lengthChange': false,
                'sort': false,
                'scrollY': 550,
                'ajax': {
                    url: ctx + '/privilege/list-data',
                    data: function (data) {
                        data.parentId = pageParm.privilegeId;
                    }
                },
                'columns': [
                    {'data': 'name'},
                    {'data': 'code'},
                    {'data': 'type'},
                    {'data': 'action'}
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


        })
    </script>

</body>

</html>

