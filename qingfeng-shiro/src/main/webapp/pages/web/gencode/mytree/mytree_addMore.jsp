<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="../../system/admin/top.jsp"%>

<form class="layui-form" action="" id="form">
    <table class="layui-table" style="width: 99%;margin: 0 auto">
        <thead>
        <tr>
            <th>父级名称<span style="color: red">*</span></th>
            <th>字典名称<span style="color: red">*</span></th>
            <th>字典简称</th>
            <th>排序</th>
            <th>备注</th>
            <th>操作</th>
        </tr>
        </thead>
        <tbody id="table">
        <tr>
            <td>${pd.name }</td>
            <td><input type="text" name="name" id="name_1" value="" lay-verify="required" autocomplete="off" placeholder="字典名称" class="layui-input"></td>
            <td><input type="text" name="short_name" id="short_name_1" value="" lay-verify="" autocomplete="off" placeholder="字典简称" class="layui-input"></td>
            <td><input type="text" name="order_by" id="order_by_1" value="" lay-verify="" autocomplete="off" placeholder="排序" class="layui-input"></td>
            <td><textarea name="remark" id="remark_1" lay-verify="" placeholder="请输入备注" class="layui-textarea"></textarea></td>
            <td style="width: 78px;"><div class="layui-btn-group"><button onclick="addLine();" type="button" class="layui-btn layui-btn-xs"><i class="layui-icon"></i></button></div></td>
        </tr>
        <tr></tr>
        </tbody>
        <tr>
            <td style="text-align: center; padding-top: 10px;" colspan="12">
                <div class="layui-form-item">
                        <input type="hidden" id="parent_id" name="parent_id" value="${pd.parent_id }">
                    <button type="button" class="layui-btn layui-btn-sm" id="submit_button" lay-submit="" lay-filter="submit_form">保存</button>
                    <button type="button" class="layui-btn layui-btn-danger layui-btn-sm" id="cancel">取消</button>
                </div>
            </td>
        </tr>
    </table>
</form>

<script type="text/javascript" src="${pageContext.request.contextPath}/resources/plugins/xadmin/lib/layui/layui.js" charset="utf-8"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/qfverify.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/qfAjaxReq.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/uploadFile.js"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->
<script>
    var form,layer,layedit,laydate,upload;
    layui.use(['form', 'layedit', 'laydate','upload'], function(){
        form = layui.form;
        layer = layui.layer;
        layedit = layui.layedit;
        laydate = layui.laydate;
        upload = layui.upload;

        $('#cancel').on('click',function (){
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.close(index);
        });

        //初始化

        //自定义验证规则
        form.verify(form_verify);

        //监听提交
        form.on('submit(submit_form)', function(data){
            layer.msg('正在提交数据。');
            $("#submit_button").attr('disabled',true);
            $.ajax({
                type: "POST",//方法类型
                dataType: "json",//预期服务器返回的数据类型
                url: "${pageContext.request.contextPath}/gencode/mytree/saveMore" ,//url
                data: $('#form').serialize(),
                success: function (res) {
                    if (res.success) {
                        layer.msg("数据保存成功。", {time: 2000},function(){
                            setOpenCloseParam("reload");
                            var index = parent.layer.getFrameIndex(window.name);
                            parent.layer.close(index);
                        });
                    }else{
                        $("#submit_button").attr('disabled',false);
                        if(res.loseSession=='loseSession'){
                            loseSession(res.msg,res.url)
                        }else{
                            layer.msg(res.msg, {time: 2000});
                        }
                    }
                },
                error : function() {
                    $("#submit_button").attr('disabled',false);
                    layer.msg("异常！");
                }
            });
            return false;
        });


    });

    var index = 1;
    function addLine(){
        index ++;
        var tt = '<tr id="tr_'+index+'">';
            tt += '<td>${pd.name }</td>';
            tt += '<td><input type="text" name="name" id="name_'+index+'" value="" lay-verify="required" autocomplete="off" placeholder="字典名称" class="layui-input"></td>';
            tt += '<td><input type="text" name="short_name" id="short_name_'+index+'" value="" lay-verify="" autocomplete="off" placeholder="字典简称" class="layui-input"></td>';
            tt += '<td><input type="text" name="order_by" id="order_by_'+index+'" value="" lay-verify="" autocomplete="off" placeholder="排序" class="layui-input"></td>';
            tt += '<td><textarea name="remark" id="remark_'+index+'" lay-verify="" placeholder="请输入备注" class="layui-textarea"></textarea></td>';
            tt += '<td style="width: 78px;"><div class="layui-btn-group"><button type="button" onclick="addLine();" class="layui-btn layui-btn-xs"><i class="layui-icon"></i></button><button type="button" onclick="delLine(\''+index+'\');" class="layui-btn layui-btn-xs layui-btn-danger"><i class="layui-icon"></i></button></div></td>';
            tt += '</tr>';
            $("#table tr:last").before(tt);

        //初始化
            form.render();
    }

    function delLine(index){
        $("#tr_"+index).remove();
    }


</script>

<%@include file="../../system/admin/bottom.jsp"%>