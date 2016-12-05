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

 
});