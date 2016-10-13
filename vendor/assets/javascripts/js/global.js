/* GTI - LOOKPRINT*/

$(document).ready(function() { 

  $('#hidden-table-info').dataTable({
          dom: 'lfrtBip',
             buttons: [
             'copy', 'csv', 'excel', 'pdf'
            ] 
    });


});