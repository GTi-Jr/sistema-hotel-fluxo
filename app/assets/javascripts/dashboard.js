//= require bootstrap/bootstrap.min

//= require datatables/jquery.dataTables.min
//= require datatables/dataTables.bootstrap
//= require datatables/dataTables.buttons.min

//= require datatables/jszip.min
//= require datatables/pdfmake.min
//= require datatables/vfs_fonts
//= require datatables/buttons.html5.min
//= require datatables/buttons.print.min
//= require datatables/dataTables.fixedHeader.min
//= require datatables/dataTables.keyTable.min
//= require datatables/dataTables.responsive.min
//= require datatables/dataTables.scroller.min
//= require date/moment.min
//= require date/daterangepicker


//= require turbolinks



//= require js/global


function confirmation_transaction(tipo, code,price) {
	if(price==""){
 		var value = $('#valor').val();
 	} else {
 		var value = price;
 	}
	var data_trans = $('#data_trans').val();
    /*CONVERTER DATA */ 
    var convertDate = function(usDate) {
        var dateParts = usDate.split(/(\d{1,2})\/(\d{1,2})\/(\d{4})/);
        return dateParts[3] + "-" + dateParts[2] + "-" + dateParts[1];
    }
    data_trans = convertDate(data_trans);

 	var client_code = $('#cliente_codigo').val();
 	var quantity = $('#quantity').val();


 	var type = tipo ? 'SAÍDA' : 'ENTRADA';
    var type_enum = tipo ? 'sale' : 'purchase';
 	var text = '<span class="fa fa-exclamation-triangle" style="float:left; margin:0 7px 20px 0;"></span><b>Atenção:</b> Voçê confirma a '+type+' do produto de código #'+code+'?</br>';
 	text += '<b>Quantidade: </b> '+quantity+' - <b>Valor Total:</b> R$ '+(quantity*value)+'';

 	$.confirm({
    	title: type+' de um produto/serviço',
        message: text,
        buttons: {
        	'Confirmar': {
            	'class': 'yes',
            	'action': function() {
             		$.ajax({
             			url: '/product/transaction',
             			data: {'code':code,'quantity':quantity,'type':type_enum,'data_trans':data_trans,'client_code':client_code,'value':value},
             			type: 'post',
             			success: function(html){
             				$('#recebe_transaction').html(html);
             			},
             			error: function(erro){
             				$('#recebe_transaction').html("OPS! ERRO AO CADASTRAR.");
             				console.log(erro);
             			}
             		});
             	}
            },
            'Cancelar': {
                'class': 'no',
                'action': function() {}
            }
        }
    });
 }


 /*==RANGE DATE PICKER MAXFLE 06/12/13 ==*/
 $(function() {

    var start = moment();
    var end = moment();

    function cb(start, end) {
        $('#reportrange span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
    }

    $('#reportrange').daterangepicker({
         locale: {
            format: 'DD/MM/YYYY'
        },
        startDate: start,
        endDate: end,
        ranges: {
           'Hoje': [moment(), moment()],
           'Ontem': [moment().subtract(1, 'days'), moment().subtract(1, 'days')],
           'Últimos 7 dias': [moment().subtract(6, 'days'), moment()],
           'Últimos 30 dias': [moment().subtract(29, 'days'), moment()],
           'Este mês': [moment().startOf('month'), moment().endOf('month')],
           'Últimos mês': [moment().subtract(1, 'month').startOf('month'), moment().subtract(1, 'month').endOf('month')]
        }
    }, cb);

    cb(start, end);
    


    $('input[name="data_trans"]').daterangepicker({
        locale: {
            format: 'DD/MM/YYYY'
        },
        singleDatePicker: true,
        showDropdowns: true
    });



});


function confirmation_transaction_new(type,user_name){
  var client_code = $('#cliente_codigo').val();
  var quantity = $('#quantity').val();
  var product_code = $('#product_code').val();
  var data_trans = $('#data_trans').val();
  var value_prod = $('#value_prod').val();

  /*AJAX PARA CARREGAR NOME DO PRODUTO */


  /*LOAD TABLE */
  var newRow = $('<tr class="gradeX">');
  var cols = "";
  cols += '<td>'+product_code+'</td>';
  cols += '<td>nome do produto</td>';
  cols += '<td>'+user_name+'</td>';
  cols += '<td>'+data_trans+'</td>';
  cols += '<td>'+parseFloat(value_prod)*parseFloat(quantity)+'</td>';
  cols += '<td>'+quantity+'</td>';
  cols += '<td>'+type+'</td>';
  cols += '<td>TEXTO</td>';

  newRow.append(cols);

  $("#anteriores_table").prepend(newRow);
  /* ZERAR */
  $('#cliente_codigo').val("");
  $('#quantity').val("");
  $('#product_code').val("");
  $('#value_prod').val("");


}


/* Auto suggest CODE_PRODUCT*/   
function suggest(inputString) {
    if (inputString.length == 0) {
        $('#suggestions').fadeOut();
    } else {
        $('#product_code ').addClass('load');
        $.post("/product/suggestion", {queryString: "" + inputString + ""}, function(data) {
            if (data.length > 0) {
                $('#suggestions').fadeIn();
                $('#suggestionsList').html(data);
                $('#product_code').removeClass('load');
            }
        });
    }
}

function fill(thisValue) {
    $('#product_code').val(thisValue);
    setTimeout("$('#suggestions').fadeOut();", 600);
}