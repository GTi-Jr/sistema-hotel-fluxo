/* GTI - LOOKPRINT*/

 $(function() {

  $('#hidden-table-info').dataTable({

        "iDisplayLength": 50,
        "oLanguage": {
            "sLengthMenu": "Entradas por página: <span class=''> _MENU_</span>",
        },

          dom: '<"widget-head clearfix"fl>rtBip',
          buttons: [
             'csv', 'excel', 'pdf'
            ] 
            
    });


  var d = moment().format('DD') + "-" + moment().format('MM') + "-" + moment().format('YYYY') + '_relatorio_bar';

  $('#hidden-table-info_bar').dataTable({

        "ordering": false,
        "iDisplayLength": 50,

        "oLanguage": {
            "sLengthMenu": "Entradas por página: <span class=''> _MENU_</span>",
        },

          dom: '<"widget-head clearfix"fl>rtBip',
          buttons: [{
                extend: 'excelHtml5',
                title: 'Relatorio do Bar - Hotel Porto Futuro - '+ moment().format('DD/MM/YYYY HH:mm:ss'),
                filename: d+'_excel'
            },
            {
                extend: 'pdfHtml5',
                title: 'Relatorio do Bar - Hotel Porto Futuro - '+ moment().format('DD/MM/YYYY HH:mm:ss'),
                filename: d+'_pdf'
            }
            ] 

            
    });


   $('#hidden-table-info_barq').dataTable({

        "ordering": false,
        "iDisplayLength": 50,

        "oLanguage": {
            "sLengthMenu": "Entradas por página: <span class=''> _MENU_</span>",
        },

          dom: '<"widget-head clearfix"fl>rtBip',
          buttons: [{
                extend: 'excelHtml5',
                title: 'Relatorio do Bar - Hotel Porto Futuro - '+ moment().format('DD/MM/YYYY HH:mm:ss'),
                filename: d+'quantidade_excel'
            },
            {
                extend: 'pdfHtml5',
                title: 'Relatorio do Bar - Hotel Porto Futuro - '+ moment().format('DD/MM/YYYY HH:mm:ss'),
                filename: d+'quantidade_pdf'
            }
            ] 

            
    });

 
});