<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<div class="ibox float-e-margins">
    <div class="ibox-content">
        <div class="row">
            <form class="form" id="J_resultForm" action="${ctx}/parameter/save" method="post">
                <input type="hidden" name="id" id="id" value="${bean.id}">
                <input type="hidden" name="apiId" id="apiId" value="${bean.apiId}">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label>结果名称</label>
                        <input type="text" class="form-control" id="name" name="name" value="${bean.name}"
                               placeholder="请输入接口名称">
                    </div>


                    <div class="form-group">
                        <label for="type">类型</label>

                        <select class="form-control" name="type" id="type">
                            ${typeOptions}
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="type">返回结果</label>
                        <textarea name="content" id="content" class="form-control">${bean.content}</textarea>
                    </div>

                    <div class="form-group">
                        <div id="json"></div>
                    </div>


                    <div class="form-group">
                        <label for="description">描述</label>
                        <input type="text" id="description" class="form-control" name="description"
                               value="${bean.description}">
                    </div>

                </div>

            </form>

        </div>
    </div>
</div>
