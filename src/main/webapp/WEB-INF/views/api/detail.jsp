<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<%@ taglib prefix="ts" uri="http://www.touch-spring.com" %>
<%@ taglib prefix="sys" tagdir="/WEB-INF/tags/sys" %>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <title>ITSS管理后台</title>

    <%@include file="/WEB-INF/common/static.jsp" %>

    <link href="${ctx}/static/jsonFormat/style.css" type="text/css" rel="stylesheet"/>

    <c:set var="PARENT_MENU_CODE" value="PROJECT_MANAGE"/>
    <c:set var="CHILD_MENU_CODE" value="PROJECT_LIST"/>

    <script>
        var ctx = '${ctx}';
        console.log(ctx);
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
                    class="fa fa fa-level-up"></i> 返回</a>
        </div>
        <div class="row animated fadeInRight" id="content-main">
            <div class="col-xs-12">

                <div class="row">
                    <div class="col-xs-5">
                        <div class="ibox">
                            <div class="ibox-title">
                                <h5>请求参数</h5>
                                <div class="ibox-tools">
                                    <a class="collapse-link" id="J_parameterAdd">
                                        <i class="fa fa-plus"></i>添加参数
                                    </a>
                                </div>
                            </div>
                            <div class="ibox-content">
                                <table class="table table-hover">


                                    <c:forEach items="${parameterList}" var="parameter">
                                        <tr>
                                            <td>${parameter.name}</td>
                                            <td>
                                                <c:if test="${parameter.type eq 1}">
                                                    <span class="label label-primary">int</span>
                                                </c:if>
                                                <c:if test="${parameter.type eq 2}">
                                                    <span class="label label-primary">long</span>
                                                </c:if>
                                                <c:if test="${parameter.type eq 3}">
                                                    <span class="label label-primary">float</span>
                                                </c:if>
                                                <c:if test="${parameter.type eq 4}">
                                                    <span class="label label-primary">string</span>
                                                </c:if>
                                                <c:if test="${parameter.type eq 5}">
                                                    <span class="label label-primary">boolean</span>
                                                </c:if>
                                                <c:if test="${parameter.type eq 6}">
                                                    <span class="label label-primary">file</span>
                                                </c:if>
                                                <c:if test="${parameter.type eq 7}">
                                                    <span class="label label-primary">array</span>
                                                </c:if>
                                                <c:if test="${parameter.type eq 8}">
                                                    <span class="label label-primary">json</span>
                                                </c:if>
                                                <c:if test="${parameter.type eq 9}">
                                                    <span class="label label-primary">xml</span>
                                                </c:if>
                                            </td>
                                            <td>
                                                <c:if test="${parameter.isRequired eq 1}">
                                                    <span class="label label-danger">必填</span>
                                                </c:if>
                                                &nbsp;
                                            </td>
                                            <td>${parameter.description}</td>
                                            <td>
                                                <div class="btn-group">
                                                    <button class=" btn btn-white btn-xs J_parameterEdit"
                                                            data-id="${parameter.id}"><i
                                                            class="fa fa-thumbs-up"></i> 编辑
                                                    </button>
                                                    <button class="btn btn-white btn-xs J_parameterDelete"data-id="${parameter.id}"><i
                                                            class="fa fa-remove"></i>
                                                        删除
                                                    </button>
                                                </div>
                                            </td>
                                        </tr>

                                    </c:forEach>
                                </table>
                            </div>
                        </div>
                    </div>
                    <div class="col-xs-7">
                        <div class="ibox float-e-margins">

                            <div class="ibox-title">
                                返回结果
                                <div class="ibox-tools">

                                    <a class="collapse-link" id="J_resultAdd">
                                        <i class="fa fa-plus"></i>添加返回结果
                                    </a>
                                </div>

                            </div>
                            <div class="tabs-container">
                                <ul class="nav nav-tabs">
                                    <c:forEach items="${resultList}" var="result" varStatus="s">
                                        <li class="<c:if test="${s.index eq 0}">active</c:if> ">
                                            <a data-toggle="tab" href="#tab-${s.index}"
                                               aria-expanded="true">${result.name} </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <div class="tab-content">
                                    <c:forEach items="${resultList}" var="result" varStatus="s">
                                        <div id="tab-${s.index}"
                                             class="tab-pane <c:if test="${s.index eq 0}">active</c:if>">
                                            <div class="panel-body">
                                                <div class="btn-group">
                                                    <button class="btn btn-white btn-xs J_resultEdit "
                                                            data-id="${result.id}">
                                                        <i class="fa fa-thumbs-up"></i> 编辑
                                                    </button>
                                                    <button class="btn btn-white btn-xs J_resultDelete"
                                                            data-id="${result.id}">
                                                        <i class="fa fa-remove"></i> 删除
                                                    </button>
                                                </div>
                                                <div class="J_resultContent">
                                                        ${result.content}
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>

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
        require(['jquery', 'yaya', 'jsonFormat', 'datatables.net'], function ($, yaya, jsonFormat) {


            $('#J_parameterAdd').click(function () {
                $.ajax({
                    url: ctx + '/parameter/add?apiId=${api.id}',
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
                                    el: '#J_parameterForm',
                                    rules: {
                                        name: "required"
                                    },
                                    messages: {
                                        name: "项目名不能为空"
                                    }
                                })
                            },
                            yes: function (index) {
                                var isValid = $("#J_parameterForm").valid();

                                if (isValid) {

                                    $.ajax({
                                        url: ctx + '/parameter/save',
                                        data: $('#J_parameterForm').serialize(),
                                        method: 'post',
                                        dataType: 'json',
                                        success: function (data) {
                                            if (data.code) {
//                                                table.draw();
//                                                yaya.layer.close(index);
                                                location.reload();

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

            $('.J_parameterEdit').click(function () {
                var id = $(this).data('id');
                $.ajax({
                    url: ctx + '/parameter/edit?id=' + id,
                    method: 'get',
                    dataType: 'html',
                    success: function (str) {
                        yaya.layer.open({
                            type: 1,
                            title: '参数编辑',
                            content: str, //注意，如果str是object，那么需要字符拼接。
                            area: '500px',
                            shadeClose: true,
                            btn: ['保存'],
                            success: function (layer, index) {
                                yaya.validate({
                                    el: '#J_parameterForm',
                                    rules: {
                                        name: "required"
                                    },
                                    messages: {
                                        name: "项目名不能为空"
                                    }
                                })
                            },
                            yes: function (index) {
                                var isValid = $("#J_parameterForm").valid();

                                if (isValid) {

                                    $.ajax({
                                        url: ctx + '/parameter/save',
                                        data: $('#J_parameterForm').serialize(),
                                        method: 'post',
                                        dataType: 'json',
                                        success: function (data) {
                                            if (data.code) {
                                                location.reload();

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

            $('#J_resultAdd').click(function () {
                $.ajax({
                    url: ctx + '/result/add?apiId=${api.id}',
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
                                    el: '#J_resultForm',
                                    rules: {
                                        name: "required"
                                    },
                                    messages: {
                                        name: "项目名不能为空"
                                    }
                                })
                            },
                            yes: function (index) {
                                var isValid = $("#J_resultForm").valid();

                                if (isValid) {

                                    $.ajax({
                                        url: ctx + '/result/save',
                                        data: $('#J_resultForm').serialize(),
                                        method: 'post',
                                        dataType: 'json',
                                        success: function (data) {
                                            if (data.code) {
//                                                table.draw();
//                                                yaya.layer.close(index);
                                                location.reload();

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

            $('.J_resultEdit').click(function () {
                var id = $(this).data('id');
                $.ajax({
                    url: ctx + '/result/edit?id=' + id,
                    method: 'get',
                    dataType: 'html',
                    success: function (str) {
                        yaya.layer.open({
                            type: 1,
                            title: '参数编辑',
                            content: str, //注意，如果str是object，那么需要字符拼接。
                            area: '500px',
                            shadeClose: true,
                            btn: ['保存'],
                            success: function (layer, index) {
                                yaya.validate({
                                    el: '#J_resultForm',
                                    rules: {
                                        name: "required"
                                    },
                                    messages: {
                                        name: "项目名不能为空"
                                    }
                                })
                            },
                            yes: function (index) {
                                var isValid = $("#J_resultForm").valid();

                                if (isValid) {

                                    $.ajax({
                                        url: ctx + '/result/save',
                                        data: $('#J_resultForm').serialize(),
                                        method: 'post',
                                        dataType: 'json',
                                        success: function (data) {
                                            if (data.code) {
                                                location.reload();

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
            $('.J_resultDelete').click(function () {
                var id = $(this).data('id');
                yaya.layer.confirm('确认删除该结果吗?', {icon: 3, title: '提示'}, function (index) {
                    $.ajax({
                        method: 'post',
                        url: ctx + '/result/delete',
                        data: {
                            id: id
                        },
                        success: function (data) {
                            if (data.code) {
//                                msgBox.info("删除成功！");
                                location.href = ctx + '/api/detail?id=${api.id}';
                            } else {
//                                msgBox.error("该分类下存在产业，请先删除产业");
                            }
                        }
                    });
                    yaya.layer.close(index);
                });
            })
            $('.J_parameterDelete').click(function () {
                var id = $(this).data('id');
                yaya.layer.confirm('确认删除该参数吗?', {icon: 3, title: '提示'}, function (index) {
                    $.ajax({
                        method: 'post',
                        url: ctx + '/parameter/delete',
                        data: {
                            id: id
                        },
                        success: function (data) {
                            if (data.code) {
//                                msgBox.info("删除成功！");
                                location.href = ctx + '/api/detail?id=${api.id}';
                            } else {
//                                msgBox.error("该分类下存在产业，请先删除产业");
                            }
                        }
                    });
                    yaya.layer.close(index);
                });
            })


            $('.J_resultContent').each(function () {
                var options = {
                    dom: this,//对应容器的css选择器
                    imgCollapsed: ctx + "/static/jsonFormat/img/Collapsed.gif", //收起的图片路径
                    imgExpanded: ctx + "/static/jsonFormat/img/Expanded.gif"  //展开的图片路径
                };
                var jf = new jsonFormat(options); //创建对象
                jf.doFormat($(this).html());
            })


        });


    </script>


</body>

</html>