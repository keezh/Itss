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


    <script>
        var ctx = '${ctx}';
    </script>

    <style>

        .nav > li.active {
            border-left: none;
        }

        nav li > a {
            display: block;
            padding: 0;
            margin: 0 10px;

        }

        .group-nav li > a {
            padding: 0 10px;
            color: #ffffff;

        }

        .group-nav li {
            background-color: #1ab394;
            margin: 0 10px;
        }

    </style>

</head>
<body class="fixed-sidebar full-height-layout gray-bg">

<div class="container">
    <div class="ibox float-e-margins">
        <div class="ibox-title">
            <span class="label label-primary pull-right">v1.1</span>
            <h5>点春互联股份有限公司接口发布系统</h5>
        </div>
        <div class="ibox-content">
            <h1 class="no-margins">${project.name}</h1>

            <small>测试服务器地址：</small>
            <small>正式服务器地址：</small>
        </div>
    </div>

    <div class="ibox float-e-margins">

        <div class="ibox-title clearfix">

            <h5>接口列表</h5>
            <ul class="group-nav nav navbar-nav pull-right">
                <c:forEach items="${apiGroupList}" var="item">
                    <li class="<c:if test="${item.id eq apiGroupDto.id}">active</c:if> ">
                        <a href="${ctx}/content?projectId=${project.id}&groupId=${item.id}"> ${item.name}</a>
                    </li>

                </c:forEach>
            </ul>

        </div>


        <c:forEach items="${apiGroupDto.apiDtoList}" var="api">

            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>${api.name}
                        <small class="m-l-sm">${api.url}</small>
                    </h5>
                    <div class="ibox-tools">
                        <c:if test="${api.methodType eq 1}">
                            <span class="label label-primary ">GET</span>
                        </c:if>
                        <c:if test="${api.methodType eq 2}">
                            <span class="label label-primary ">POST</span>
                        </c:if>
                        <c:if test="${api.methodType eq 3}">
                            <span class="label label-primary ">PUT</span>
                        </c:if>
                        <c:if test="${api.methodType eq 4}">
                            <span class="label label-primary ">DELETE</span>
                        </c:if>
                        <c:if test="${api.methodType eq 5}">
                            <span class="label label-primary ">HEAD</span>
                        </c:if>
                        <c:if test="${api.methodType eq 6}">
                            <span class="label label-primary ">PATCH</span>
                        </c:if>
                        <c:if test="${api.methodType eq 7}">
                            <span class="label label-primary ">OPTIONS</span>
                        </c:if>
                        <a class="collapse-link">
                            <i class="fa fa-chevron-up"></i>
                        </a>

                    </div>
                </div>
                <div class="ibox-content">
                    <div class="alert alert-success">
                            ${api.purpose}
                    </div>

                    <div class="row">
                        <div class="col-md-4 ">

                            <blockquote>

                                <table class="" width="100%">
                                    <c:forEach items="${api.parameterDtoList}" var="parameter">

                                        <tr>
                                            <td>
                                                    ${parameter.name}
                                            </td>

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
                                                    ${parameter.description}
                                            </td>
                                            <td>
                                                <c:if test="${parameter.isRequired eq 1}">
                                                    <span class="label label-danger">必填</span>
                                                </c:if>
                                                &nbsp;
                                            </td>
                                        </tr>
                                    </c:forEach>

                                </table>
                            </blockquote>

                        </div>
                        <div class="col-md-8">

                            <div class="tabs-container">

                                <ul class="nav nav-tabs">
                                    <c:forEach items="${api.resultDtoList}" var="result" varStatus="s">
                                        <li class="<c:if test="${s.index eq 0}">active</c:if>">
                                            <a data-toggle="tab" href="#tab-${result.id}"
                                               aria-expanded="false">
                                                    ${result.name}
                                            </a>
                                        </li>
                                    </c:forEach>
                                </ul>
                                <div class="tab-content">
                                    <c:forEach items="${api.resultDtoList}" var="result" varStatus="s">
                                        <div id="tab-${result.id}"
                                             class="tab-pane <c:if test="${s.index eq 0}">active</c:if> ">
                                            <div style="margin: 10px auto">
                                                <span class="label label-danger">注</span>&nbsp;${result.description}
                                            </div>
                                            <div class="J_resultContent">
                                                    ${result.content}
                                            </div>
                                        </div>
                                    </c:forEach>

                                </div>

                            </div>

                        </div>
                    </div>
                </div>
            </div>


        </c:forEach>


    </div>

</div>


<script src="${ctx}/static/require/require.js"></script>
<script src="${ctx}/static/require/require.config.js"></script>
<script>
    require(['jquery', 'yaya', 'jsonFormat', 'datatables.net'], function ($, yaya, jsonFormat) {


        $('.J_resultContent').each(function () {
            var options = {
                dom: this,//对应容器的css选择器
                imgCollapsed: ctx + "/static/jsonFormat/img/Collapsed.gif", //收起的图片路径
                imgExpanded: ctx + "/static/jsonFormat/img/Expanded.gif"  //展开的图片路径
            };
            var jf = new jsonFormat(options); //创建对象
            jf.doFormat($(this).html());
        })

        $(".collapse-link").click(function () {
            var o = $(this).closest("div.ibox"), e = $(this).find("i"), i = o.find("div.ibox-content");
            i.slideToggle(200), e.toggleClass("fa-chevron-up").toggleClass("fa-chevron-down"), o.toggleClass("").toggleClass("border-bottom"), setTimeout(function () {
                o.resize(), o.find("[id^=map-]").resize()
            }, 50)
        })


    });


</script>


</body>

</html>