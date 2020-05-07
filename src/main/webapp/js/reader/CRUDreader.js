function add(){//添加
	 
	layer.open({
	  type: 2,
	  title: '添加读者',
	  skin: 'layui-layer-demo', //加上边框
	  area: ['800px', '500px'], //宽高
	  content: 'library/addReader.action'
	  });
}



function edit(data){//修改

	layer.open({
		  type: 2,
		  title: '修改读者信息',
		  skin: 'layui-layer-demo', //加上边框
		  area: ['800px', '500px'], //宽高
		  method: 'post',
		  content: 'library/editReader.action?'
			  +'reader_id='+data.reader_id
			  +'&name='+data.name
			  +'&sex='+data.sex
			  +'&birth2='+data.birth//这里赋值给String类型的时间字段
			  +'&address='+data.address
			  +'&telcode='+data.telcode
			  +'&card_state='+data.card_state
		  });
}

function find(data){
	layer.open({
		  type: 2,
		  title: '查看读者信息',
		  skin: 'layui-layer-demo', //加上边框
		  area: ['800px', '500px'], //宽高
		  method: 'post',
		  content: 'library/findReader.action?'
			  +'reader_id='+data.reader_id
			  +'&name='+data.name
			  +'&sex='+data.sex
			  +'&birth2='+data.birth//这里赋值给String类型的时间字段
			  +'&address='+data.address
			  +'&telcode='+data.telcode
			  +'&card_state='+data.card_state
		  });
}

