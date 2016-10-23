//= require js/smooth-sliding-menu.js
//= require bs3/js/bootstrap.min

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


//= require js/jquery.noty
//= require js/themes/default
//= require js/layouts/bottom
//= require js/layouts/topRight
//= require js/layouts/top
//= require js/master

//= require bootstrap-datepicker/js/bootstrap-datepicker
 


//= require turbolinks

/* PAG: LISTAR PRODUTOS */
$(document).ready(function() {
	$('.default-date-picker').datepicker({
       format: 'dd/mm/yyyy'
    });
});

 function confirmation_transaction(tipo, code) {
 	var value = $('#valor').val();
	var data_trans = $('#data_trans').val();
 	var client_code = $('#cliente_codigo').val();
 	var quantity = $('#quantity').val();


 	var type = tipo ? 'SAÍDA' : 'ENTRADA';
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
             			data: {'code':code,'quantity':quantity,'type':type,'data_trans':data_trans,'client_code':client_code,'value':value},
             			type: 'post',
             			success: function(html){
             				$('#recebe_transaction').html(html);
             			},
             			error: function(erro){

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


