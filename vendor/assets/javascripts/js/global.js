/* GTI - LOOKPRINT*/

 $(function() {

  $('#hidden-table-info').dataTable({

        "iDisplayLength": 50,
        "sPaginationType": "bootstrap",

          dom: 'lfrtBip',
             buttons: [
             'copy', 'csv', 'excel', 'pdf'
            ] 
    });


});