<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/WEB-INF/common/taglibs.jsp" %>
<div class="ibox float-e-margins">
    <div class="ibox-content">
        <div class="row">
            <form class="form" id="J_parameterForm" action="${ctx}/parameter/save" method="post">
                <input type="hidden" name="id" id="id" value="${bean.id}">
                <input type="hidden" name="apiId" id="apiId" value="${bean.apiId}">
                <div class="col-sm-12">
                    <div class="form-group">
                        <label>参数名称</label>
                        <input type="text" class="form-control" id="name" name="name" value="${bean.name}"
                               placeholder="请输入接口名称">
                    </div>


                    <div class="form-group">
                        <label>是否必填</label>

                        <div class="onoffswitch">
                            <c:if test="${bean.isRequired eq 1}">
                                <input type="checkbox" checked="checked" class="onoffswitch-checkbox" id="isRequired"
                                       name="isRequired" value="1">
                            </c:if>
                            <c:if test="${bean.isRequired !=  1}">
                                <input type="checkbox" class="onoffswitch-checkbox" id="isRequired"
                                       name="isRequired" value="1">
                            </c:if>
                            <label class="onoffswitch-label" for="isRequired">
                                <span class="onoffswitch-inner"></span>
                                <span class="onoffswitch-switch"></span>
                            </label>
                        </div>
                        <%--<div class="checkbox checkbox-inline">--%>
                        <%--<input type="checkbox" id="inlineCheckbox1" value="option1">--%>
                        <%--<label for="inlineCheckbox1"> 选项01 </label>--%>
                        <%--</div>--%>
                        <%--<div class="onoffswitch">--%>
                        <%--<input type="checkbox" checked="" class="onoffswitch-checkbox" id="example1">--%>
                        <%--<label class="onoffswitch-label" for="example1">--%>
                        <%--<span class="onoffswitch-inner"></span>--%>
                        <%--<span class="onoffswitch-switch"></span>--%>
                        <%--</label>--%>
                        <%--</div>--%>
                        <%--<label class="checkbox-inline">--%>
                        <%--<input type="checkbox" name="isRequired" id="isRequired" class=""/>--%>
                        <%--是否必须 </label>--%>
                    </div>
                    <div class="form-group">
                        <label for="type">类型</label>

                        <select class="form-control" name="type" id="type">
                            ${typeOptions}
                        </select>
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
