<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!--左侧导航开始-->
<nav class="navbar-default navbar-static-side" role="navigation">
    <div class="nav-close"><i class="fa fa-times-circle"></i></div>
    <div class="sidebar-collapse">
        <ul class="nav" id="side-menu">

            <li class="nav-header">
                <div class="dropdown profile-element">
                    <%--<span><img alt="image" class="img-circle" src="/resources/hplus/lib/img/profile_small.jpg" /></span>--%>
                    <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                            <span class="clear"><span class="block m-t-xs"><strong class="font-bold"></strong></span>
                            <span class="text-muted text-xs block">超级管理员<b class="caret"></b></span></span>
                    </a>
                    <ul class="dropdown-menu animated fadeInRight m-t-xs">
                        <li>
                            <a class="J_menuItem" href="#"/>修改密码</a>
                        </li>
                        <li class="divider"></li>
                        <li><a href="${ctx}/logout">安全退出</a></li>
                    </ul>
                </div>
                <div class="logo-element">管理后台</div>
            </li>


            <c:forEach items="${sessionScope.menus}" var="menu">
                <c:if test="${empty menu.children}">
                    <c:set var="url" value="${menu.action}"/>
                </c:if>
                <c:if test="${!empty menu.children}">
                    <c:set var="url" value="#"/>
                </c:if>

                <li <c:if test="${PARENT_MENU_CODE eq menu.code}">class="active"</c:if>>
                    <a href="${ctx}${url}">
                        <i class="glyphicon glyphicon-cog"></i>
                        <span class="nav-label">${menu.name}</span>
                        <span class="fa arrow"></span>
                    </a>
                    <c:if test="${PARENT_MENU_CODE eq menu.code}">
                        <ul class="nav nav-second-level collapse in" aria-expanded="true">
                            <c:forEach items="${menu.children}" var="child">
                                <li <c:if test="${CHILD_MENU_CODE eq child.code}">class="active"</c:if>>
                                    <a class="J_menuItem"
                                       href="${ctx}/${child.action}">${child.name}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                    <c:if test="${PARENT_MENU_CODE != menu.code}">
                        <ul class="nav nav-second-level collapse" aria-expanded="false">
                            <c:forEach items="${menu.children}" var="child">
                                <li>
                                    <a class="J_menuItem"
                                       href="${ctx}/${child.action}">${child.name}</a>
                                </li>
                            </c:forEach>
                        </ul>
                    </c:if>
                </li>
            </c:forEach>
        </ul>
    </div>
</nav>
<!--左侧导航结束-->