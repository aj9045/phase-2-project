// $(document).ready(function() {
//   $('#generate-container').on("submit", ".save", function(event){
//     event.preventDefault();
//     $target = $('event.target');



// });

$(document).ready(function() {
  // hides edit user form and edit note form
  $('.edit-form').hide();
  $('.note-edit').hide();

  // when edit profile clicked, shows the edit user form and hides the user profile
  $('#user-profile').on("click", function(event){
    event.preventDefault();

   $('.edit-form').show();
   $('#user-profile').hide();
  })



  // when saving changes to user profile, hides the edit user form and shows user specs
  $('#edit-user').on("submit", function(event){
    event.preventDefault();
    $form = $(event.target)

    $('.edit-form').hide();
    $('#user-profile').show();

    $.ajax({
        type: 'put',
        url: $form.attr('action'),
        dataType: "json",
        data: $form.serialize()
      }).done(function (response) {
          $('#users-name span').html(response.name);
          $('#about-user span').html(response.about);

          $('.edit-form').hide();
          $('#user-profile').show();
      })
  })


  //when click to add note or edit note, all note buttons hide and shows edit note form
  $('.note-btns').on("click", function(event){
    event.preventDefault();

   $('.note-btns').hide();
   $('.note-edit').show();
  })


  //when save on note edit form,
  $('.note-edit').on("submit", function(event){
    event.preventDefault();
    $form = $('event.target');
  })


  //when update note, saves and shows up
  $('.note-btns').on("click", function(event){
    event.preventDefault();
    $('.delete-note-form').hide();
    $('.note-btns').hide();
    $('.note-edit').show();
  })

  $('.note-edit').on("submit", function(event){
    event.preventDefault();
    // debugger
    $form = $(event.target)

    new_note = $form.find('textarea')
    entry_note = $(this).parent().parent().find('div.entry-note')

    $.ajax({
          type: $form.attr('method'),
          url: $form.attr('action'),
          dataType: "text",
          data: $form.serialize()
        }).done(function (response) {
          $(new_note).html(response);
          $(entry_note).html(response);

          $('.delete-note-form').show();
          $('.note-btns').show();
          $('.note-edit').hide();
        });
  })

 //  //no refresh on delete -- EGH
 // $('.delete-note-form').on("submit", function(event){
 //    event.preventDefault();
 //    // debugger
 //    $form = $(event.target)
 //    console.log("er")
 //    $.ajax({
 //          type: $form.attr('method'),
 //          url: $form.attr('action'),
 //          dataType: "text",
 //          data: $form.serialize()
 //        }).done(function (response) {
 //            console.log(response);


 //        });
 //  })








  //no refresh of saving generated names
  $('#generate-container').on("submit", function(event){
      event.preventDefault();
      $form = $(event.target)

      // new_note = $form.find('textarea')
      // entry_note = $(this).parent().parent().find('div.entry-note')

      $.ajax({
            type: $form.attr('method'),
            url: $form.attr('action'),
            dataType: "json",
            data: $form.serialize()
          }).done(function (response) {

            $('input:eq(1)').html(response.first_name);
            $('input:eq(2)').html(response.last_name);

          });
    })
    //generate new names without refreshing
  $('#generate-btn').on("submit", function() {
    $form = $(event.target)

      $.ajax({
          type: $form.attr('method'),
          url: $form.attr('action'),
          dataType: "json",
          data: $form.serialize()
        }).done(function (response) {

          $('.first').val(response.first_name);
          $('.last').val(response.last_name);

        });

  })



});



