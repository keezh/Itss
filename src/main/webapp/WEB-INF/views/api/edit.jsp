<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<div class="ibox float-e-margins">
    <div class="ibox-content">
        <div class="row">
            <form class="form" id="J_apiForm" action="${ctx}/api/save" method="post">
                <input type="hidden" name="id" id="id" value="${bean.id}">
                <input type="hidden" name="projectId" id="projectId" value="${projectId}">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label>接口名称</label>
                        <input type="text" class="form-control" id="name" name="name" value="${bean.name}"
                               placeholder="请输入接口名称">
                    </div>
                    <div class="form-group">
                        <label>接口地址</label>
                        <input type="text" class="form-control" id="url" name="url" value="${bean.url}"
                               placeholder="请输入接口名称">
                    </div>
                    <div class="form-group">
                        <label>用途</label>
                        <input type="text" class="form-control" id="purpose" name="purpose" value="${bean.purpose}"
                               placeholder="请输入接口用途">
                    </div>
                    <div class="form-group">
                        <label for="methodType">方法</label>
                        <select class="form-control" name="methodType" id="methodType">
                            ${methodType}
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="groupId">分组</label>
                        <select class="form-control" name="groupId" id="groupId">
                            <c:forEach items="${groupList}" var="group">
                                <option value="${group.id}"
                                        <c:if test="${group.id == groupId}">selected</c:if> >${group.name}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="groupId">描述</label>
                        <textarea name="description" id="description" class="form-control">${bean.description}</textarea>
                    </div>

                </div>

            </form>

        </div>
    </div>
</div>
