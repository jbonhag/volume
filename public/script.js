var sending = false;

function setVolume(volume) {
  sending = true;
  var xhr = new XMLHttpRequest();
  xhr.addEventListener("load", function() {
    sending = false;
  });
  xhr.open('PUT', '/volume');
  xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
  xhr.send('volume=' + volume);
}

document.getElementById('volume').oninput = function(e) {
  if (!sending) {
    setVolume(e.target.value);
  }
};

// always send final value
document.getElementById('volume').onchange = function(e) {
  setVolume(e.target.value);
};
