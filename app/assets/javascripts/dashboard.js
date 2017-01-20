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
//= require datatables/responsive-tables.js
//= require datatables/dataTables.scroller.min
//= require date/moment.min
//= require date/daterangepicker

//= require js/global
//= require js/smooth-sliding-menu
//= require js/jquery.maskMoney.min
//= require js/jquery.PrintArea


/*== CONTADOR PARA O BAR */

function atualizaContador(ano,mes,dia,hora,min,sec){
   // setTimeout(function() {atualizaContador()}, 1000);
    var diffTime = moment().diff([ano, mes-1, dia, hora, min, sec, 125]);
    var duration = moment.duration(diffTime);

    var years = duration.years(),
    days = duration.days(),
    hrs = duration.hours(),
    mins = duration.minutes(),
    secs = duration.seconds();
   // var final = years + ' years ' + days + ' days ' + hrs + ' hrs ' + mins + ' mins ' + secs + ' sec';

    var final = '';
    if(hrs>0){
      final += hrs + ' hrs, '
    }
    if(mins>0){
      final += mins + ' mins e '
    }

    final += secs + ' segs '

    $('#perm_bar').html(final);
    setTimeout(function() {atualizaContador(ano,mes,dia,hora,min,sec)}, 1000);

}

/*== TOTAL BAR ==
$(function() {
    var total= 0;
    $.each($("td[name='total_bar']"), function () {
        total += parseFloat($(this).text().replace(",", ".").replace("R$ ", ""));
    });
     $("#totalBar").html("R$ " + total);
});*/

 /*==RANGE DATE PICKER ==*/
$(function() {
    $("#print").click(function(){
        var mode = 'iframe'; //popup
        var close = mode == "popup";
        var options = { mode : mode, popClose : close};
        $("div.printableArea").printArea( options );
    });
    $('#value_prod').maskMoney({prefix:'R$ ', allowNegative: true, thousands:'', decimal:'.', affixesStay: false}); //MASCARA DE GRANA
    $('#value_recebido').maskMoney({prefix:'R$ ', allowNegative: true, thousands:'', decimal:'.', affixesStay: false});
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


/* Auto suggest CODE_PRODUCT*/
function suggest(inputString, inputType, isbar) {
    if(!isbar)
        isbar = false
    if (inputString.trim().length == "") {
        $('#suggestions').fadeOut();
        $('#botao_confirmar').prop('disabled', true);
    } else {
        $('#product_code ').addClass('load');
        $.post("/product/suggestion", {
            queryString: "" + inputString + "",
            product_type_t: inputType,
            isbar: isbar
        }, function(data) {
            if (data.length > 0) {
                $('#suggestions').fadeIn();
                $('#suggestionsList').html(data);
                $('#product_code').removeClass('load');
            }
        });
    }
}

function fill(thisValue, price, name, unit) {
    $('#product_code').val(thisValue);
    setTimeout("$('#suggestions').fadeOut();", 600);
    if (price === '') {
        $('#value_prod').prop('disabled', false);
    } else {
        $('#value_prod').prop('disabled', true);
        $('#value_prod').val(price);
    }
    if (name == 'Hospedagem') {
        $('#cliente_codigo').prop('disabled', false);
        $('#quantity').prop('disabled', true);
    } else {
        $('#cliente_codigo').prop('disabled', true);
        $('#quantity').prop('disabled', false);
    }
    $('#name_prod').val(name);
    $('#unit').val(unit);
    $('#quantity').val(1);
    if (thisValue !== undefined) {
        $('#botao_confirmar').prop('disabled', false);
    } else {
        $('#botao_confirmar').prop('disabled', true);
    }
}

/* LANÇAMENTOS --- 19/11/2016 - PATRICK M. */
function confirmation_transaction_new(type, user_name) {
    /* BUSCAR DADOS */
    var client_code = $('#cliente_codigo').val();
    var quantity = $('#quantity').val();
    var unit = $('#unit').val();
    var product_code = $('#product_code').val();
    var data_trans = $('#data_trans').val();
    var value_prod = $('#value_prod').val();
    var name_prod = $('#name_prod').val();
    var payment_method= $('#payment_method').val();
    var sent = false; //PREVENIR 2 CLICK
    var payment_array = {money: "Dinheiro",
                         visa_credit:"Visa Crédito",
                         visa_debit: "Visa Débito",
                         master_credit: "MasterCard Crédito",
                         master_debit: "MasterCard Débito",
                         dinners_credit: "Dinners Crédito",
                         dinners_debit: "Dinners Débito",
                         amex_credit: "American Express Crédito",
                         amex_debit: "American Express Débito",
                         check: "Cheque",
                         elo_debit: "Elo Débito",
                         elo_credit: "Elo Crédito",
                         bank_deposit: "Depósito Bancário",
                         credit_authorized: "Crédito Autorizado"};
    /*CONVERTER DATA */
    var convertDate = function(usDate) {
        var dateParts = usDate.split(/(\d{1,2})\/(\d{1,2})\/(\d{4})/);
        return dateParts[3] + "-" + dateParts[2] + "-" + dateParts[1];
    }
    data_trans_n = convertDate(data_trans);
    var type_text = type == 'sale' ? 'Venda' : 'Compra'; 
    if (sent) return;
        sent = true;
        $.ajax({
            url: '/product/transaction',
            type: 'post',
            dataType: 'json',
            data: {
                'code': product_code,
                'quantity': quantity,
                'type': type,
                'data_trans': data_trans_n,
                'client_code': client_code,
                'value': value_prod,
                'payment_method': payment_method
            },
            beforeSend: function() {
               $('#botao_confirmar').prop('disabled', true);
               $('#recebe_transaction').html('Carregando...Aguarde!');
            },
            success: function(html) {
                    /* ZERAR */
                    $('#cliente_codigo').val("");
                    $('#quantity').val("");
                    $('#product_code').val("");
                    $('#value_prod').val("");
                    $('#name_prod').val("");
                    $('#unit').val("");

                     /*LOAD TABLE */
                    var newRow = $('<tr class="gradeX success">');
                    var cols = "";
                    cols += '<td>' + product_code + '</td>';
                    cols += '<td>' + name_prod + '</td>';
                    cols += '<td>' + user_name + '</td>';
                    cols += '<td>' + payment_array[payment_method] + '</td>';
                    cols += '<td>' + data_trans + '</td>';
                    cols += '<td>' + quantity + '</td>';
                    cols += '<td>R$ ' + parseFloat(value_prod) + '</td>';
                    cols += '<td>R$ ' + parseFloat(value_prod) * parseFloat(quantity) + '</td>';
                    cols += '<td>' + unit + '</td>';
                    cols += '<td>' + type_text + '</td>';
                    //cols += '<td>'+html[0].stock+'</td>';

                    newRow.append(cols);
                    $("#anteriores_table").prepend(newRow);
                    $('#botao_confirmar').prop('disabled', true);
                    //$("#recebe_transaction").html(html);
                    $("#receber_cash").html(html[0].amount_cash);
                    $('#recebe_transaction').html('Inserido com sucesso.');
                },
                error: function(erro) {
                    $('#recebe_transaction').html(erro['responseText']);
                }
        });

}


/* LANÇAMENTOS BAR--- 12/01/2016 - PATRICK M. */
function confirmation_transaction_bar(table_bar_id) {
    /* BUSCAR DADOS */
    var quantity = $('#quantity').val();
    var unit = $('#unit').val();
    var product_code = $('#product_code').val();
    var data_trans = $('#data_trans').val();
    var value_prod = $('#value_prod').val();
    var name_prod = $('#name_prod').val();
    var sent = false; //PREVENIR 2 CLICK
    /*CONVERTER DATA */
    var convertDate = function(usDate) {
        var dateParts = usDate.split(/(\d{1,2})\/(\d{1,2})\/(\d{4})/);
        return dateParts[3] + "-" + dateParts[2] + "-" + dateParts[1];
    }
    data_trans_n = convertDate(data_trans);
    if (sent) return;
        sent = true;
        $.ajax({
            url: '/bar/transaction',
            type: 'post',
            dataType: 'json',
            data: {
                'code': product_code,
                'quantity': quantity,
                'data_trans': data_trans_n,
                'table_bar_id': table_bar_id
            },
            beforeSend: function() {
               $('#botao_confirmar').prop('disabled', true);
               $('#recebe_transaction').html('Carregando...Aguarde!');
            },
            success: function(html) {
                    /* ZERAR */
                    $('#quantity').val("");
                    $('#product_code').val("");
                    $('#value_prod').val("");
                    $('#name_prod').val("");
                    $('#unit').val("");

                     /*LOAD TABLE */
                    var newRow = $('<tr class="gradeX success">');
                    var cols = "";
                    cols += '<td class="text-center">' + product_code + '</td>';
                    cols += '<td>' + name_prod + '</td>';
                    cols += '<td class="text-right">' + quantity + '</td>';
                    cols += '<td class="text-right">R$ ' + parseFloat(value_prod) + '</td>';
                    cols += '<td class="text-right">R$ ' + parseFloat(value_prod) * parseFloat(quantity) + '</td>';


                    newRow.append(cols);
                    $("#anteriores_table").prepend(newRow);
                    $('#botao_confirmar').prop('disabled', true);
                    //$("#recebe_transaction").html(html);
                    $('#recebe_transaction').html('Inserido com sucesso.');
                    var totalAtual = parseFloat($('#totalBar').html().replace(",", ".").replace("R$ ", ""));
                    totalAtual +=  parseFloat(value_prod) * parseFloat(quantity);
                    $("#totalBar").html("R$ " + totalAtual.toString().replace(".", ","));
                },
                error: function(erro) {
                    $('#recebe_transaction').html(erro['responseText']);
                }
        });

}
function transaction_bar_payment(table_id){
    var payment_method= $('#payment_method').val();
    var value_recebido= $('#value_recebido').val();
    if(value_recebido===''){
        $('#recebe_transaction_pag').html('Digite o valor recebido para calcular o troco.');
        return false;
    }

    $.ajax({
            url: '/bar/pay',
            type: 'post',
            dataType: 'json',
            data: {
                'id': table_id,
                'price_pago': value_recebido,
                'payment_method': payment_method
            },
            beforeSend: function() {
               $('#botao_confirmar_pag').prop('disabled', true);
               $('#recebe_transaction_pag').html('Carregando...Aguarde!');
            },
            success: function(html) {
                if(html[0].status==true){
                    window.location.href = '/bar/table';
                } else {
                    $('#botao_confirmar_pag').prop('disabled', false);
                    $('#recebe_transaction_pag').html(html[0].msg);
                }
            },
            error: function(erro) {
               // $('#recebe_transaction').html(erro['responseText']);
            }
        });

}

function troco_bar(valor){
    var total = parseFloat($('#totalBar').html().replace("R$ ", "").replace(",", "."));
    var recebido = parseFloat(valor.replace("R$ ", ""));
    if(recebido>=total) {
        $('#troco_bar').val('R$ '+(recebido-total).toFixed(2));
    } else {
        $('#troco_bar').val('');
    }
}

function press(key){
   if(key==1){
    window.location.href = '/';
   } else if(key==12){
    window.location.href = '/product';
   } else if(key==19){
    window.location.href = '/product/type/sale';
   } else if(key==6){
    window.location.href = '/product/type/purchase';
   }

}
