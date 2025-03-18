// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require_tree .
//

function setFogginess(){
  radius = Math.round($(document).scrollTop()/400.0);
  
  console.log(radius, 1/Math.sqrt(radius))
  $('#veil').foggy({
    blurRadius: radius,
    opacity: 1/Math.sqrt(radius),   
    cssFilterSupport: true 
  });
}
$(document).ready(function(){
  $(".send-code-link").on("click", function(e){
    e.preventDefault();
    if($("#patient_email").is(':valid') == false || $("#patient_email").val()===""){
      alert("Please enter a valid email");
    }else{
      $.ajax({
        url: "/welcome/get_otp",
        data: {
          type: "patient",
          email: $("#patient_email").val()
        }
      })
    }
  });
  $(".doc-send-code-link").on("click", function(e){
    e.preventDefault();
    if($("#doctor_email").is(':valid') == false || $("#doctor_email").val()===""){
      alert("Please enter a valid email");
    }else{
      $.ajax({
        url: "/welcome/get_otp",
        data: {
          type: "doctor",
          email: $("#doctor_email").val()
        }
      })
    }
  });
  $('#fullpage').fullpage({
    anchors:['into', "slide2", "dataSources", 'howItWorks'],
    animateAnchor: true,
    paddingTop: "50px",
    keyboardScrolling: true,
    css3: true,
    verticalCentered: true,
    scrollBar:true, 
    scrollOverflow: true
  });

  setFogginess();
  $(document).on("scroll", function(e){
    setFogginess();  
  })
})
/*
$(document).ready(function(){
  $('#veil').foggy({
    blurRadius: 3,
    opacity: 0.8,   
    cssFilterSupport: true
  });
  $('#fullpage').fullpage({
      responsive: 800,
      css: true,
     afterLoad: function(anchorLink, index){
      var radius = 3*index;
      var opacity = 0.8/index;
      $('#veil').foggy({
        blurRadius: radius,
        opacity: opacity,   
        cssFilterSupport: true
      });
    },
  });
})
*/
