//Show/Hide datepicker
const $announcement = document.querySelector('#event_announcement');
const $important = document.querySelector('#event_important');
const $date_toggle = document.querySelector('#date-toggle');

//Toggle important checkbox
const setBox = function (e) {
    if(e.target.checked)
    {
        $important.checked = true;
        $important.disabled = true;
    } else
        $important.disabled = false;

    toggleDatePicker();
};

//Toggle datepicker
const toggleDatePicker = function (e) {
    if($important != null && $important.checked) $date_toggle.classList.remove("hidden");
    else if($date_toggle != null) $date_toggle.classList.add("hidden");
};

if ($announcement != null && $important != null)
{
    $announcement.addEventListener('input', setBox);
    $important.addEventListener('input', toggleDatePicker);
}
jQuery(function ($) {
    $(document).ready(function() {
        toggleDatePicker();
    });
});