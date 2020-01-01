$(document).ready(function(){
    // Dropzone.autoDiscover = false;
    // Dropzone.options.filesField = {
    //     url: "/welcome/create",
    //     addRemoveLinks: true,
    //     autoProcessQueue: false,
    //     uploadMultiple: true,
    //     accept: function(file, done) {
    //         $("div#files-field").css({"height": "auto"});
    //         done();
    //     },
    //     init: function() {
    //         var myDropzone = this;
    //         var form = document.getElementById('dropzone-form-id');
    //         form.addEventListener('submit', function(event) {
    //             // stop the form's submit event
    //             if(myDropzone.getQueuedFiles().length > 0){
    //                 event.preventDefault();
    //                 event.stopPropagation();
    //                 myDropzone.processQueue();
    //             }
    //         });
    //
    //         myDropzone.on("sendingmultiple", function(file, xhr, formData) {
    //             formData.append("title", $('#myDropzoneForm_title').val());
    //             formData.append("text", $('#myDropzoneForm_text').val());
    //         });
    //     },
    //     successmultiple: function(data,response) {
    //         alert(response);
    //     }
    // };
    Dropzone.autoDiscover = false;
    $("div#gallery-field").dropzone({
        url: "/file/post",
        addRemoveLinks: true,
            autoProcessQueue: false,
            uploadMultiple: true,
            accept: function(file, done) {
                $("div#files-field").css({"height": "auto"});
                done();
            },
            init: function() {
                var myDropzone = this;
                var form = document.getElementById('dropzone-form-id');
                if(form)
                {
                    form.addEventListener('submit', function(event) {
                        // stop the form's submit event
                        if(myDropzone.getQueuedFiles().length > 0){
                            event.preventDefault();
                            event.stopPropagation();
                            myDropzone.processQueue();
                        }
                    });
                }

                myDropzone.on("sendingmultiple", function(file, xhr, formData) {
                    formData.append("title", $('#myDropzoneForm_title').val());
                    formData.append("text", $('#myDropzoneForm_text').val());
                });
            },
            successmultiple: function(data,response) {
                alert(response);
            }
    });
});
