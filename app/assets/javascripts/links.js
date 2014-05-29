$(document).ready(function(){

//this function will show and hide the new link form when clicked
	 $("#displayText").on("click",function toggle(){
              var ele = document.getElementById("new_link");
                var text = document.getElementById("displayText");
                if(ele.style.display == "block"){
                    ele.style.display = "none";
                    text.innerHTML = "Add A Link";
                }
                else {
                    ele.style.display = "block";
                    text.innerHTML = "Hide Form";
                }

        });
	 //this function will show and hide the search form when clicked

	 $("#findlink").on("click",function toggle(){
              var ele = document.getElementById("find_link");
                var text = document.getElementById("findlink");
                if(ele.style.display == "block"){
                    ele.style.display = "none";
                    text.innerHTML = "Search A Link";
                }
                else {
                    ele.style.display = "block";
                    text.innerHTML = "Hide Form";
                }

        });
	 //getting the data from the user and add it to the list

	$('#new_link').on('submit', function(e){
		e.preventDefault();
		var title = $('#title').val();
        var link = $('#url').val();
        var tag = $('#name').val();

        if (!title.length) {
              return;
            } else { 
             $.ajax({
                  url: '/links.json',
                  method: 'post',
                  data: {
                  	"link": {
                          "title": title,
                          "url": link,
                          "link_tags_attributes": {
                              "0": {
                                "tag_attributes": {
                                  "name": tag
                                  }
                              }
                          }
                      }


                  },
                  dataType: "json"})
             .done(function(data){
             	var publiclist = $('#publiclist')
                var privatelist = $('#privatelist')

                var newLink =  $('<a href="/links/' +data.id + '/edit">edit</a> <a data-method="delete" href="/links/' + data.id + '" rel="nofollow">delete</a> <b>' + data.title + '</b> - <a href="' + data.url + '">' + data.url + '</a> <br>')

                if (data.tags[0].name === "private") {
                    privatelist.prepend(newLink) 
                } else {
                    publiclist.prepend(newLink) 
	            };
	            

             });
             //clean the input fields 
             $('#link_title').val("");
             $('#link_url').val("");
             $('#link_tags_name').val("");
			

		}

    });

 });
                 
