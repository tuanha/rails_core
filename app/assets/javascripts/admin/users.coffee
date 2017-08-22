$('.user_role').on 'change', ->
  id = $(this).attr('data-id')
  role = $(this).val()
  $('#loading').show()
  $.ajax
    url: '/admin/users/assign_role'
    type: 'POST'
    data: 'id=' + id + '&role=' + role
    dataType: 'json'
    success: (data) ->
      $('#loading').hide()
      alert data.error if data.error
      return
  return

# Preview avatar before upload

readURL = (input) ->
  if input.files and input.files[0]
    reader = new FileReader

    reader.onload = (e) ->
      $('#privew_user_avatar').attr 'src', e.target.result
      return

    reader.readAsDataURL input.files[0]
  return

$('#user_avatar').change ->
  readURL this
  return

#------------#
