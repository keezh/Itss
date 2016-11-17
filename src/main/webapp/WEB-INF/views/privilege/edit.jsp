<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<div class="ibox float-e-margins">
    <div class="ibox-content">
        <div class="row">
            <form class="form" id="J_privilegeForm" action="${ctx}/privilege/save" method="post">
                <input type="hidden" name="id" id="id" value="${bean.id}">
                <input type="hidden" name="parentId" id="parentId" value="${bean.parent.id}">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label>权限</label>
                        <input type="text" class="form-control" id="name" name="name" value="${bean.name}"
                               placeholder="请输入权限名称">
                    </div>
                    <div class="form-group">
                        <label>分类</label>
                        <select class="form-control" id="type" name="type">
                            ${selectOptions}
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="code" class="form-label">CODE</label>
                        <input type="text" class="form-control" id="code" name="code" value="${bean.code}"
                               placeholder="请输入角色CODE">
                    </div>
                    <div class="form-group">
                        <label for="action" class="form-label">地址</label>
                        <input type="text" class="form-control" id="action" name="action" value="${bean.action}"
                               placeholder="请输入权限地址">
                    </div>
                </div>

            </form>

        </div>
    </div>
</div>
