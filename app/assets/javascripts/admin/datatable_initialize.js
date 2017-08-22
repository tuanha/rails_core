pageSetUp();

var responsiveHelper_dt_basic = undefined;
var responsiveHelper_datatable_fixed_column = undefined;

var breakpointDefinition = {
    tablet : 1024,
    phone : 480
};

/* COLUMN FILTER  */
var otable = $('#datatable_fixed_column').DataTable({
    "order": [], //disable sorting in the initial table
    //"ordering": false,
    //"bFilter": false,
    //"bInfo": false,
    //"bLengthChange": false
    //"bAutoWidth": false,
    "bPaginate": false,
    //"bStateSave": true, // saves sort state using localStorage
    //"sDom": "<'dt-toolbar'<'col-xs-12 col-sm-6'f><'col-sm-6 col-xs-12 hidden-xs'l>r>"+
    "sDom": "<'dt-toolbar'<'col-sm-6 col-xs-12 hidden-xs'l>r>"+
    "t"+
    "<'dt-toolbar-footer'<'col-sm-6 col-xs-12 hidden-xs'i><'col-xs-12 col-sm-6'p>>",
    "autoWidth" : true,
    "preDrawCallback" : function() {
        // Initialize the responsive datatables helper once.
        if (!responsiveHelper_datatable_fixed_column) {
            responsiveHelper_datatable_fixed_column = new ResponsiveDatatablesHelper($('#datatable_fixed_column'), breakpointDefinition);
        }
    },
    "rowCallback" : function(nRow) {
        responsiveHelper_datatable_fixed_column.createExpandIcon(nRow);
    },
    "drawCallback" : function(oSettings) {
        responsiveHelper_datatable_fixed_column.respond();
    }

});

// Apply the filter
$("#datatable_fixed_column thead th input[type=text]").on( 'keyup change', function () {
    otable
        .column( $(this).parent().index()+':visible' )
        .search( this.value )
        .draw();

});
/* END COLUMN FILTER */

$('.deleteLin').prop("onclick", null);

$('#datatable_fixed_column').DataTable( {
    "paging": true,
    "pageLength": 20,
    "bDestroy": true,
    "searching": false,
    "lengthMenu":[10,20,30,50,100],
    "dom":'<"left"l><"top"p><"clear">',
    "ordering": false
});