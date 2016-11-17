<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<div class="ibox float-e-margins">
    <div class="ibox-content">
        <div class="row">
            <form role="form" id="J_adminForm">
                <input type="hidden" name="id" value="${bean.id}">

                <c:if test="${empty bean.id}">
                    <div class="col-sm-6 b-r">
                        <h3 class="m-t-none m-b">基础信息</h3>
                        <div class="form-group">
                            <label>用户名</label>
                            <input type="text" placeholder="请输入帐号" class="form-control" name="username"
                                   value="${bean.username}">
                        </div>
                        <div class="form-group">
                            <label>密码</label>
                            <input type="password" placeholder="请输入密码" class="form-control" name="password"
                                   value="${bean.password}">
                        </div>
                    </div>
                </c:if>
                <c:if test="${not empty bean.id}">
                    <div class="col-sm-6 b-r">
                        <h3 class="m-t-none m-b">基础信息</h3>
                        <div class="form-group">
                            <label>用户名</label>
                            <input type="text" placeholder="请输入帐号" class="form-control" value="${bean.username}"
                                   readonly>
                        </div>
                    </div>
                </c:if>


                <div class="col-sm-6">
                    <h3 class="m-t-none m-b">角色选择</h3>

                    <c:forEach items="${roles}" var="item" varStatus="s">
                        <div class="check-box">
                            <label>
                                <input type="checkbox" name="role" value="${item.id}"
                                       <c:if test="${adminRoleMap[item.code]}">checked="checked"</c:if>> ${item.name}
                            </label>
                        </div>
                    </c:forEach>
                </div>
            </form>

        </div>
    </div>
</div>
