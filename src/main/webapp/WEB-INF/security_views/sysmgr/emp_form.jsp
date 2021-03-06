<%@page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<script type="text/javascript">
	var form_url = yhq.basePath+"/sysmgr/employee/add.do" ;
	
	$(function() {
		$("#select1").combotree({
			url : yhq.basePath+"/sysmgr/org/treegrid.do",
			width:157, idFiled:'pid', textFiled:'fullname', editable: false,
			lines:true, autoShowPanel: true,
			onSelect:function(node){
		 		$("#orgname").val(node.text);
		 	}
	    });
		
		//编辑，加载表单数据
		if($('input[name=id]').val().length > 0) {
			form_url = yhq.basePath+"/sysmgr/employee/edit.do" ;
			$.post(yhq.basePath+"/sysmgr/employee/get.do", {id:$('input[name=id]').val()}, function(result) {
				if (result.id != undefined) {
					$('form').form('load', {
						'id' : result.id,
						'account' : result.account,
						'password' : result.password,
						'status' : result.status,
						'truename' : result.truename,
						'sex' : result.sex,
						'email' : result.email,
						'tel' : result.tel,
						'orgname' : result.orgname
					});
				}
			}, 'json');
		}
		$("#form input:visible")[0].focus();
	});
	
	//提交表单数据
	var submitNow = function($dialog, $datagrid) {
		$.post(form_url, $("#form").form("getData"), function(result) {
			if (result.status) {
				$datagrid.datagrid('reload') ;
				$.easyui.messager.show({ icon: "info", msg: "保存记录成功。" });
		console.info(2);
			} else {
				$.easyui.messager.show({ icon: "info", msg: "保存记录失败。" });
				return false ;
			}
		}, 'json');
		console.info(1);
	};
	
	//验证表单
	var submitForm = function($dialog, $datagrid) {
		if($('#form').form('validate')) {
			return submitNow($dialog, $datagrid) ;
		} else{
			return false ;
		}
	};
</script>

<form id="form" class="easyui-form">
	<input type="hidden" name="id" value="${id}" />
	<table id="tab_box">
		<tr>
			<th>账号：</th>
			<td><input name="account" class="easyui-validatebox" type="text" data-options="required:true, prompt: '登陆账号'" /></td>
			<th>密码：</th>
			<td><input name="password" class="easyui-validatebox" type="text" data-options="required:true, prompt: '登陆密码'" /></td>
		</tr>
		<tr>
			<th>姓名：</th>
			<td><input name="truename" class="easyui-validatebox" type="text" data-options="required:true, prompt: '真实姓名'" /></td>
			<th>性别：</th>
			<td>
				<input class="easyui-combobox" style="width:157px;" name="sex" data-options="
					valueField: 'label', textField: 'value', editable: false, value : 'male',
					data: [{ label: 'male', value: '男' },{ label: 'female', value: '女' }],
					panelHeight:'auto', editable:false" />
			</td>
		</tr>
		<tr>
			<th>邮箱：</th>
			<td><input name="email" class="easyui-validatebox" type="text" data-options="prompt: '邮箱地址'" /></td>
			<th>电话：</th>
			<td><input name="tel" class="easyui-validatebox" type="text" data-options="prompt: '联系电话'" /></td>
		</tr>
		<tr>
			<th>状态：</th>
			<td>
				<input class="easyui-combobox" style="width:157px;" name="status" data-options="
					valueField: 'label', textField: 'value', editable: false, value : 'Y',
					data: [{ label: 'Y', value: '激活' },{ label: 'N', value: '禁用' }],
					panelHeight:'auto', editable:false" />
			</td>
			<th>机构：</th>
			<td><input id="select1" name="orgid" /><input name="orgname" id="orgname"  type="hidden"/></td>
		</tr>
	</table>
	
</form>
