//= require active_admin/base
//= require active_admin/searchable_select
//= require activeadmin/quill_editor/quill
//= require activeadmin/quill_editor_input


$(document ).ready(function() {
  addSearchFocusOverride();
});

function addSearchFocusOverride() {
  $('.searchable-select-input, .select2').on('select2:open', function (e) {
    if (e.target.multiple) {
      return
      // $($('.select2-search.select2-search--inline .select2-search__field')[0]).next().find('.select2-search--inline .select2-search__field')[0].focus();
    } else {
      $('.select2-search.select2-search--dropdown .select2-search__field').slice(-1)[0].focus();
    }
  });
}