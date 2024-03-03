function checkOrientation() {
  var currentPath = window.location.pathname;
  var targetPath = window.matchMedia("(orientation: landscape)").matches
    ? "/pc.html"
    : "/";
  if (currentPath !== targetPath) {
    window.location.href = targetPath;
  }
  if (currentPath === "/") {
    randomizeBackground();
  }
}

function randomizeBackground() {
  var bgElement = document.getElementById("bg");
  var bgImages = [
    'url("assets/bg/S1-01-n.webp")',
    'url("assets/bg/S1-05.webp")',
  ];
  var randomIndex = Math.floor(Math.random() * bgImages.length);
  var selectedBackground = bgImages[randomIndex];
  bgElement.style.backgroundImage = selectedBackground;
  if (randomIndex === 1) {
    bgElement.style.filter = "brightness(90%)";
  } else {
    bgElement.style.filter = "brightness(100%)";
  }
}

window.addEventListener("orientationchange", checkOrientation);
document.addEventListener("DOMContentLoaded", checkOrientation);
checkOrientation();

document.querySelector(".android").addEventListener("click", function () {
  fetch("app/new/upgrade.json")
    .then((response) => {
      if (response.ok) {
        return response.json();
      } else {
        throw new Error("打开异常：upgrade.json");
      }
    })
    .then((data) => {
      const version = data.version;
      const baseUrl = `${window.location.protocol}//${window.location.host}`;
      const downloadUrl = `${baseUrl}/app/new/app-release-${version}.apk`;
      window.location.href = downloadUrl;
    })
    .catch((error) => {
      console.error("下载异常:", error);
    });
});

var mainButton = document.querySelector(".mainButton");
var popupMenu = document.getElementById("popupMenu");
mainButton.addEventListener("click", function (event) {
  event.stopPropagation();
  popupMenu.style.display =
    popupMenu.style.display === "block" ? "none" : "block";
});

document.addEventListener("click", function () {
  if (popupMenu.style.display === "block") {
    popupMenu.style.display = "none";
  }
});

document.getElementById("bilibili-icon").addEventListener("click", function () {
  window.open(
    "https://space.bilibili.com/387701682/channel/seriesdetail?sid=1845136&ctype=0",
    "_blank"
  );
});

document.getElementById("hykb-icon").addEventListener("click", function () {
  window.open("https://www.3839.com/a/156008.htm", "_blank");
});

document.getElementById("qq-icon").addEventListener("click", function () {
  window.open(
    "https://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=-pPGHln9yKNzS00OdFJRxZ69Q-rEX_nx&authKey=kLPWmtcFJCAPpgv18epf4MW9SxGPVGTqPKKWtbOt1C%2FTX%2ByIOEyjpYeMSGxe9KWZ&noverify=0&group_code=465805687",
    "_blank"
  );
});

document.getElementById("tap-icon").addEventListener("click", function () {
  window.open("https://www.taptap.cn/app/378027", "_blank");
});

document
  .getElementById("popup-item-tap")
  .addEventListener("click", function () {
    window.open("https://www.taptap.cn/moment/469163830157512175", "_blank");
    if (popupMenu.style.display === "block") {
      popupMenu.style.display = "none";
    }
  });
