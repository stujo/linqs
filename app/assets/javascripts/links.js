// $(document).ready(function() {


//     // $('#form').on('submit', function(e) {
//     //     e.preventDefault();
//     //     var data = {
//     //         var title = $('#link_title').val();
//     //         var url = $('#link_url').val();
//     //         var tags = $('#link_tags_name');
//     //     }
//     //     if (!title.length) {
//     //         return;
//     //     } else { // send user input to json
//     //         $.ajax({
//     //             url: '/links/create',
//     //             method: 'post',
//     //             data: {
//     //                 "link": {
//     //                     "title": title,
//     //                     "url": url,
//     //                     "link_tag_attributes": {
//     //                         "tags_attributes": {
//     //                             "name": name
//     //                         }
//     //                     }
//     //                 }
//     //             },
//     //             dataType: "json",
//     //             success: function(data) {
//     //                 console.log(data);
//     //                 var ul = $('ul')
//     //                 var newLink = $('<li><b>' + data.link.title + ':</b> ' + data.link.url + '</li><br><p>Tags: ' + data.link.link_tag_attributes.tags_attributes.name) + '</p>';
//     //                 newLink.append(+'<span class="delete">delete</span><span class="edit">edit</span>');
//     //                 newLink.hide().appendTo('ul').fadeIn(500);
//     //             };
//     //             //return false;
//     //             // error: function() {
//     //             //     alert("Yo its broke");
//     //             // }
//     //         });
//     //         $('#link_title').val("");
//     //         $('#link_url').val("");
//     //         $('#link_tags_name').val("");
//     //     }
//     // });


//     // Function to load all links in database via AJAX get request
//     var loadLinks = function() {
//         $.ajax("/links", {
//             type: 'get'
//         }).success(function(data) {
//             for (var i in data['links']) {
//                 $('ul').append('<li><b>' + data['links'][i]['title'] + ':</b> ' + data['links'][i]['url'] + '</li>');
//             }
//         });
//     }
//     loadLinks();

// });