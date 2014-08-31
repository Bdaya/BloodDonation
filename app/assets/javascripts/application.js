// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require underscore
//= require gmaps/google
//= require_tree .

$(function(){ $(document).foundation(); });

function getLocation() {
    if (navigator.geolocation) {
        navigator.geolocation.getCurrentPosition(showPosition);
    } else {
        var x = document.getElementById("coordinates");
        x.innerHTML = "Geolocation is not supported by this browser.";
    }
}
function showPosition(position) {
    var x = document.getElementById("coordinates");
    x.innerHTML = "Latitude: " + position.coords.latitude +
    "<br>Longitude: " + position.coords.longitude;
}

$(document).foundation();



$('.cover-content a').click( function() {
  $(".cover").animate({ height:"0"}, 2000, function() { $(".cover").hide();});
});

$('.cover a').click( function() {
  var elem = $( this );

  if (elem.attr("href") == "#signup-donator") {
    $(".main_content .about-content").hide();
    $(".main_content a.donator").parent().addClass("active");
    $(".top-bar li.register").addClass("active").removeClass("register");
    $(".main_content .register-content").show();
  };
  if (elem.attr("href") == "#signup-patient") {
    $(".main_content .about-content").hide();
    $(".main_content a.patient").parent().addClass("active");
    $(".top-bar li.register").addClass("active").removeClass("register");
    $(".main_content .register-content").show();

  };
  if (elem.attr("href") == "#signin") {
    $(".main_content .about-content").hide();
    $(".top-bar li.register").addClass("active").removeClass("register");
    $(".main_content .register-content").show();
  };
  if (elem.attr("href") == "#about") {
    $(".main_content .register-content").hide();
    $(".main_content .about-content").show();
    $(".top-bar a[href='about.html']").parent().addClass("active");
  };
});

$(".sign-up input").click( function() {
  $(".sign-in").hide();
  if ($(".sign-up").hasClass("large-6")) {
    $(".sign-up").removeClass("large-6");
    $(".sign-up").addClass("large-12");
    $(".show").show();
    $(".show a[href='#signin']").show();
  };
});

$(".sign-in input").click( function() {
  $(".sign-up").hide();
  if ($(".sign-in").hasClass("large-6")) {
    $(".sign-in").removeClass("large-6");
    $(".sign-in").addClass("large-12");
    $(".show").show();
    $(".show a[href='#signup']").show();
  };
});

$(".show a").click( function() {
  if ($(".sign-in").hasClass("large-12")) {
    $(".sign-in").removeClass("large-12");
    $(".sign-in").addClass("large-6");

  }

  $(".sign-up").show();
    if ($(".sign-up").hasClass("large-12")) {
    $(".sign-up").removeClass("large-12");
    $(".sign-up").addClass("large-6");

  }
  $(".sign-in").show();
  $(".show").hide();
  $(".show a").hide();
});

 $(window).bind("load", function () {
var footer = $(".footer");
var pos = footer.position();
var height = $(window).height();
height = height - pos.top;
height = height - footer.height();
if (height > 0) {
footer.css({
    'margin-top': height + 'px'
});
}
});


  $("#user-information").find("input").change( function() {
    var complete = false;
    $("#user-information").find("input").each( function() {
      if ($(this).val().length === 0) {
        complete = false;
        return false;
      }
    else {
      complete = true;
    }
  });

  if (complete) {
    $("#user-information").find("a.disabled").removeClass("disabled").addClass("enabled");
    $("dd.first-level").addClass("complete");
  };

  $("#user-bloodtype").find("input").change( function() {
    var complete = false;
    $("#user-bloodtype").find("input").each( function() {
      if ($(this).val().length === 0) {
        complete = false;
        return false;
      }
    else {
      complete = true;
    }
  });

  if (complete) {
    $("#user-bloodtype").find("a.disabled").removeClass("disabled").addClass("enabled");
    $("dd.second-level").addClass("complete");
  };

  });
  });

  $("#user-location").find("input").change( function() {
    var complete = false;
    $("#user-location").find("input").each( function() {
      if ($(this).val().length === 0) {
        complete = false;
        return false;
      }
    else {
      complete = true;
    }
  });

  if (complete) {
    $("#user-location").find("button").removeClass("disabled").addClass("enabled");
    $("dd.third-level").addClass("complete");
  };

  });

  $("#complete1").click( function () {
    $("dd.first-level").removeClass("active");
    $("dd.second-level").removeClass("disabled").addClass("active");
  });

  $("#complete2").click( function () {
    $("dd.second-level").removeClass("active");
    $("dd.third-level").removeClass("disabled").addClass("active");
  });

  $("#contact-information").find("input").change( function() {
    var complete = false;
    $("#contact-information").find("input").each( function() {
      if ($(this).val().length === 0) {
        complete = false;
        return false;
      }
    else {
      complete = true;
    }
  });

  if (complete) {
    $("#contact-information").find("a.disabled").removeClass("disabled").addClass("enabled");
    $("dd.first-level").addClass("complete");
  };

  $("#patient-information").find("input").change( function() {
    var complete = false;
    $("#patient-information").find("input").each( function() {
      if ($(this).val().length === 0) {
        complete = false;
        return false;
      }
    else {
      complete = true;
    }
  });

  if (complete) {
    $("#patient-information").find("a.disabled").removeClass("disabled").addClass("enabled");
    $("dd.second-level").addClass("complete");
  };

  });
  });

  $("#hospital-information").find("input").change( function() {
    var complete = false;
    $("#hospital-information").find("input").each( function() {
      if ($(this).val().length === 0) {
        complete = false;
        return false;
      }
    else {
      complete = true;
    }
  });

  if (complete) {
    $("#hospital-information").find("button").removeClass("disabled").addClass("enabled");
    $("dd.third-level").addClass("complete");
  };

  });

  $("#complete1").click( function () {
    $("dd.first-level").removeClass("active");
    $("dd.second-level").removeClass("disabled").addClass("active");
  });

  $("#complete2").click( function () {
    $("dd.second-level").removeClass("active");
    $("dd.third-level").removeClass("disabled").addClass("active");
  });


var geocoder;
var map;
var marker;

function initialize(){
//MAP
  var latlng = new google.maps.LatLng(30.0444196,31.23571160000006);
  var options = {
    zoom: 16,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.SATELLITE
  };

  map = new google.maps.Map(document.getElementById("map_canvas"), options);

  //GEOCODER
  geocoder = new google.maps.Geocoder();

  marker = new google.maps.Marker({
    map: map,
    draggable: true
  });

};

$(document).ready(function() {

  initialize();

  $(function() {
    $("#user_location").autocomplete({
      //This bit uses the geocoder to fetch address values
      source: function(request, response) {
        geocoder.geocode( {'address': request.term }, function(results, status) {
          response($.map(results, function(item) {
            return {
              label:  item.formatted_address,
              value: item.formatted_address,
              latitude: item.geometry.location.lat(),
              longitude: item.geometry.location.lng()
            }
          }));
        })
      },
      //This bit is executed upon selection of an address
      select: function(event, ui) {
        $("#user_latitude").val(ui.item.latitude);
        $("#user_longitude").val(ui.item.longitude);
        var location = new google.maps.LatLng(ui.item.latitude, ui.item.longitude);
        marker.setPosition(location);
        map.setCenter(location);
      }
    });
  });
});
