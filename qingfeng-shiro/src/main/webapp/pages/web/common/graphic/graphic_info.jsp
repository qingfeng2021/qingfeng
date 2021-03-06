<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../system/admin/top.jsp"%>

<form class="layui-form" action="" id="form">
    <table class="layui-table" style="width:95%;margin:10px auto;">
        <tr>
            <td width="15%" align="right"><label class="layui-form-label">标题：<span style="color: red">*</span></label></td>
            <td colspan="3">${p.title}</td>
        </tr>
        <tr>
            <td width="15%" align="right"><label class="layui-form-label">发布人：</label></td>
            <td>${p.publish_user}</td>
            <td width="15%" align="right"><label class="layui-form-label">发布时间：</label></td>
            <td>${p.publish_time}</td>
        </tr>
        <tr>
            <td width="15%" align="right"><label class="layui-form-label">附件：</label></td>
            <td colspan="3">
                <div id="file_show" style="float: left;padding-top: 8px">
                    <c:forEach items="${fileList}" var="v" varStatus="vs">
                        <a type="button" onclick="downloadFile('${v.id}','${v.file_path}','${v.name}');" class="layui-btn layui-btn-xs">${v.name}</a>
                    </c:forEach>
                </div>
            </td>
        </tr>
        <tr>
            <td align="right"><label class="layui-form-label">排序号：</label></td>
            <td colspan="3">${p.order_by}</td>
        </tr>
        <tr>
            <td align="right"><label class="layui-form-label">简介：</label></td>
            <td colspan="3">${p.intro}</td>
        </tr>
        <tr>
            <td align="right"><label class="layui-form-label">内容：</label></td>
            <td colspan="3">${p.content}</td>
        </tr>
        <tr>
            <td align="right"><label class="layui-form-label">备注：</label></td>
            <td colspan="3">${p.remark}</td>
        </tr>
        <tr>
            <td style="text-align: center; padding-top: 10px;" colspan="4">
                <div class="layui-form-item">
                    <button type="button" class="layui-btn layui-btn-danger layui-btn-sm" id="cancel">关闭</button>
                </div>
            </td>
        </tr>
    </table>
</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/xadmin/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/qfverify.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/qfAjaxReq.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    var form,layer;
    layui.use(['form'], function(){
        form = layui.form;
        layer = layui.layer;

        $('#cancel').on('click',function (){
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        })
    });
</script>

<%@include file="../../system/admin/bottom.jsp"%>