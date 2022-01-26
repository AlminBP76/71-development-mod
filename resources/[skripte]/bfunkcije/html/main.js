$(function(){
	window.onload = (e) => {  
		window.addEventListener('message', (event) => {
			var item = event.data;
			if (item !== undefined) {
				if (item.pokazano === "test") {
					init({
						fade_in : 500 ,
						fade_out : 1000 ,
						position : 'top-center'
					});

          if (item.style) {

            toast({
              title: '<span style="color:#f9f9f9">'+item.naslov+'</span>',
              description: '<span style="color:#bdc3c7">'+item.text+'</span>',
              close_color: '#212121',
              border_color: '#383ee5',
              color: '#0e1527c1',
              type: 'custom',
              timeout: item.duzina * 1000
              });

          } else {

            toast({
              title: '<span style="color:#f9f9f9">'+item.naslov+'</span>',
              description: '<span style="color:#bdc3c7">'+item.text+'</span>',
              close_color: '#212121',
              border_color: 'rgba(183, 5, 5, 0.87)',
              color: '#0e1527c1',
              type: 'custom',
              timeout: item.duzina * 1000
              });
          }

          if (item.admin) {
            repeat(function () {}, 20);
          }
			
				} else if (item.pokazano === "sve") {
          if (item.sve) {
            $("#notifikacije").css("display", "block");
          } else {
            $("#notifikacije").css("display", "none");
          }
        } else if(item.loading === "broji") {
          $("#tekstovi").css("display", "block");
          document.getElementById("Naslov").innerHTML = item.naslov;
          if (item.abort) {
            $("#blockanje").css("opacity", "1.0");
          } else {
            $("#blockanje").css("opacity", "0.0");
          }

          updateProgress(item.postotak)
        } else if(item.loading === "sakrij") {
          $("#tekstovi").css("display", "none");
        } else if (item.ticknotif) {
            if (item.bool) {
              if (item.tick){

                if (typeof prosliTekst === "undefined" || prosliTekst != item.text || prosliTekst === null) {
                  var audio = new Audio('../s.ogg');
                  audio.volume = 0.15;
                  audio.play();
                }

                prosliTekst = item.text

                if (typeof tt !== 'undefined') {
                  clearTimeout(tt);
                } 



                $("#ticknotif").html(item.text)
                $("#ticknotif").show();
                tt = setTimeout(function(){ $("#ticknotif").fadeOut("slow"); prosliTekst = null }, 1500);

              } else {
                $("#ticknotif").html(item.text)
                $("#ticknotif").fadeIn("slow");
              }
              
            } else {
              $("#ticknotif").fadeOut("slow");
            }

        }
      }
    });
	};
});


function repeat(func, times) {
  $(".msha_toast").fadeOut(500).fadeIn(500).fadeOut(500).fadeIn(500)
    times && --times && repeat(func, times);
}

"use strict";

function _typeof(obj) { if (typeof Symbol === "function" && typeof Symbol.iterator === "symbol") { _typeof = function _typeof(obj) { return typeof obj; }; } else { _typeof = function _typeof(obj) { return obj && typeof Symbol === "function" && obj.constructor === Symbol && obj !== Symbol.prototype ? "symbol" : typeof obj; }; } return _typeof(obj); }

if (true) {

  var init = function init(object) {
    var _ = object;

    if (_typeof(object) == 'object') {
      _fade_out = _.fade_out != null ? _.fade_out : _fade_out;
      _fade_in = _.fade_in != null ? _.fade_in : _fade_in;
      _position = _.position != null ? _.position : _position;
    }

    var e = document.getElementsByClassName("msha_toast_container")[0];

    switch (_position) {
      case 'top-left':
        e.className = 'msha_toast_container';
        e.setAttribute("style", "");
        e.classList.add(_position);
        break;

      case 'top-center':
        e.className = 'msha_toast_container';
        e.style.top = 0;
        e.style.left = '50%';
        e.style.transform = 'translateX(-50%)';
        break;

      case 'top-right':
        e.className = 'msha_toast_container';
        e.setAttribute("style", "");
        e.classList.add(_position);
        break;

      case 'bottom-left':
        e.className = 'msha_toast_container';
        e.setAttribute("style", "");
        e.classList.add(_position);
        break;

      case 'bottom-center':
        e.className = 'msha_toast_container';
        e.style.bottom = 0;
        e.style.left = '50%';
        e.style.transform = 'translateX(-50%)';
        break;

      case 'bottom-right':
        e.className = 'msha_toast_container';
        e.setAttribute("style", "");
        e.classList.add(_position);
        break;

      default:
        e.style.bottom = 0;
        e.style.left = 0;
        e.style.transform = null;
        break;
    }
  };

  var toast = function toast(object) {
    var toast_timeout = 0;
    var toast_desc = "Life is short. Live passionately.";
    var toast_title = "Hi";
    var toast_type = "success";
    var toast_color = "#fff";
    var toast_close_color = "#999";
    var _ = object; //Custom

    var _bordercolor = "rgba(94, 9, 9, 0.61)";
    var _icon;
    var _radius = 3;

    if (_typeof(object) == 'object') {
      toast_desc = _.description != null && _.description.length > 0 ? _.description : toast_desc;
      toast_title = _.title != null && _.title.length > 0 ? _.title : toast_title;
      toast_timeout = _.timeout != null ? _.timeout : toast_timeout;
      toast_type = _.type != null ? _.type : toast_type;
      toast_color = _.color != null ? _.color : toast_color;
      toast_close_color = _.close_color != null ? _.close_color : toast_close_color;
    }

    document.getElementsByClassName("msha_toast_container")[0].insertAdjacentHTML("beforeend", "<div class=\"msha_toast ".concat(toast_type, "\"><div class=\"msha_toast_icon msha_").concat(toast_type, "_icon\">    </div><div class=\"msha_toast_contents\"><div class=\"msha_toast_title\">").concat(toast_title, "</div><div class=\"msha_toast_desc\"> ").concat(toast_desc, " </div></div>"));
	  var toast = document.getElementsByClassName("msha_toast")[_i];
    toast.style.animation = "fadeIn ".concat(_fade_in / 1000, "s");
    toast.style.WebkitAnimation = "fadeIn ".concat(_fade_in / 1000, "s");
    toast.style.MozAnimation = "fadeIn ".concat(_fade_in / 1000, "s");
    toast.style.backgroundColor = toast_color;

    if (toast_type == "custom") {
     _bordercolor = _.border_color != null ? _.border_color : _bordercolor;
      _icon = _.icon != null ? _.icon : _icon;
      _radius = _.radius != null ? _.radius : _radius;
      toast.style.borderLeft = "5px solid ".concat(_bordercolor);
      toast.style.borderRadius = "".concat(_radius, "px");
      _icon != null ? toast.getElementsByClassName("msha_custom_icon")[0].style.background = _icon : toast.getElementsByClassName("msha_custom_icon")[0].style.display = 'none';
    }

	document.getElementById('notifikacije').insertAdjacentHTML("beforeend", "<div class=\"sve_toast ".concat(toast_type, "\"><div class=\"sve_toast_icon msha_").concat(toast_type, "_icon\">    </div><div class=\"sve_toast_contents\"><div class=\"sve_toast_title\">").concat(toast_title, "</div><div class=\"sve_toast_desc\"> ").concat(toast_desc, " </div></div>"));
  var toast3 = document.getElementsByClassName("sve_toast");
  var broj = toast3.length
  var toast2 = toast3[broj - 1];
  toast2.style.borderLeft = "5px solid ".concat(_bordercolor);
  toast2.style.borderRadius = "".concat(_radius, "px");
  toast2.style.backgroundColor = toast_color;



	if (toast_timeout != null && toast_timeout > 0) {
      var c = document.getElementsByClassName("msha_toast")[_i];
      setTimeout(function () {
        del(null, c);
      }, toast_timeout + _fade_in);
    } //display block


	_i++;
	
  };

  var del = function del(e) {
    var _ee = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : null;
    var _t;

    if (_ee != null) {
      _t = _ee;
    } else {
      _t = event.target.parentElement;
    }

    _t.style.WebkitAnimation = "fadeOut ".concat(_fade_out / 1000, "s forwards");
    _t.style.MozAnimation = "fadeOut ".concat(_fade_out / 1000, "s forwards");
    _t.style.animation = "fadeOut ".concat(_fade_out / 1000, "s forwards");
    setTimeout(function () {
      _t.classList.add("remove");
    }, _fade_out);
    setTimeout(function () {
      _t.remove();
      _i-- ? _i != 0 : null;
    }, _fade_out + 300);
  };

  var _fade_in = 800;
  var _fade_out = 800;
  var _position = 'bottom-left';
  var _i = 0;
  
if (!('remove' in Element.prototype)) {
  Element.prototype.remove = function() {
      if (this.parentNode) {
          this.parentNode.removeChild(this);
      }
  };
}
}

