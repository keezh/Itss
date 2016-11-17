<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<div class="ibox float-e-margins">
    <div class="ibox-content">
        <div class="row">
            <form class="form" id="J_groupForm" action="${ctx}/api-group/save" method="post">
                <input type="hidden" name="id" id="id" value="${bean.id}">
                <input type="hidden" name="projectId" id="projectId" value="${bean.projectId}">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label>分组名称</label>
                        <input type="text" class="form-control" id="name" name="name" value="${bean.name}"
                               placeholder="请输入分组名称">
                    </div>
                    <div class="form-group">
                        <label for="description" class="form-label">分组描述</label>
                        <textarea name="description" id="description"
                                  class="form-control">${bean.description}</textarea>
                    </div>

                </div>

            </form>

        </div>
    </div>
</div>
