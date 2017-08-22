var idRecord = [];
var sortable = $("#sortable");
sortable.sortable({
    helper: fixWidthHelper,
    update: function(event, ui){
        var i = 1;
        $('.data').each(function(){
            idRecord[i] = ($(this).data('id'));
            i++;
        });
        jQuery.ajax
        ({
            type: "POST",
            dataType: 'json',
            url: sortable.attr('data-url'),
            data: 'pid='+JSON.stringify(idRecord),
            success: function(r){}
        });
        idRecord = [];
    }
}).disableSelection();

function fixWidthHelper(e, ui) {
    ui.children().each(function() {
        $(this).width($(this).width());
    });
    return ui;
}