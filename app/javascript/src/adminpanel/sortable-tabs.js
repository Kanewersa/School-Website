(function($) {
    $.fn.railsSortable = function(options) {
        options = options || {};
        var settings = $.extend({}, options);

        settings.update = function(event, ui) {
            if (typeof options.update === 'function') {
                options.update(event, ui);
            }

            $.ajax({
                type: 'POST',
                beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
                url: '/sortable/reorder'  + "?&authenticity_token=",
                dataType: 'json',
                contentType: 'application/json',
                data: JSON.stringify({
                    rails_sortable: $(this).sortable('toArray'),
                }),
            });
        };

        this.sortable(settings);
    };
})(jQuery);
$(function() {
    $('.sortable').railsSortable({
        revert : true
    });
});