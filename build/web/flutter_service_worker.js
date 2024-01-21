'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"app/new/app-release-1.4.5.apk": "3f6684a3097f646ec24f8af35f5752ad",
"app/new/app-release.apk": "3f6684a3097f646ec24f8af35f5752ad",
"app/new/upgrade.json": "c4179a4a9b5dc15a960489c18bc2d588",
"assets/AssetManifest.bin": "51b0dcf4e0aa55064f5c36aecfaa21e1",
"assets/AssetManifest.json": "5032795dd93b5254737c30f181bcbdb8",
"assets/assets/bg/menu_bg.webp": "91c51ede5f15bdf32c39242a8ade3e35",
"assets/assets/bg/S1-01-n.webp": "bdde2fcf5d6ccb108191dea2f7396a09",
"assets/assets/bg/S1-05.webp": "d37043b4ac4427b5f3ae88c35f9c33e7",
"assets/assets/bg/S3-04.webp": "34323076cc587ff09ea33943827121db",
"assets/assets/bg/start_bg.webp": "52e00694be6dfb77d301935ebc84bb7c",
"assets/assets/friend_web/bilibili.webp": "ef6410615149d302fdba58caeabd10fe",
"assets/assets/friend_web/hykb.webp": "f88cfa4812592d9cd6f1869dc78aca09",
"assets/assets/friend_web/qq.webp": "e7825321efac3b25634772008bb9abfd",
"assets/assets/friend_web/tap.webp": "824cb2cba5aa0a513d749aaaff2b102f",
"assets/assets/logo/logo1.webp": "36fb846ee2dbd7f6139436bcacc47e15",
"assets/assets/logo/logo2.webp": "c6981758dd600d728534bac18841d904",
"assets/assets/logo/logo3.webp": "523d84d52644554b73b6bb61b8f3f1b9",
"assets/assets/other/qr_code.webp": "5721c35075764700a6497120f6db11ac",
"assets/assets/other/vcr.webm": "584dab1722541ed29c91c8821885f880",
"assets/assets/posts/first.md": "3b9e77109dc5b4fc6982649fa773273b",
"assets/assets/posts/pay.md": "d3e5593ad4b18d4b9eeda74655605436",
"assets/assets/posts/privacy.md": "c3f686cd7d2ed1481f2ad22c2f58d416",
"assets/assets/posts/taptap.md": "39914243f8119b235d5476701cd2f0b9",
"assets/assets/posts/taptap_qbj.md": "e5295854acd67a7dafae3c96e5fc1a57",
"assets/assets/role/Iris.webp": "1761dcd88482c7621cf16cf1cf58a32b",
"assets/assets/role/Iris_avatar.webp": "ce078d27369291aee141925291ed11c0",
"assets/assets/role/Iris_say.ogg": "d76c463a69c5bd8aec31224fcdaec177",
"assets/assets/role/Lily.webp": "873fd5c72455120d806a6bdda86a73aa",
"assets/assets/role/Lily_avatar.webp": "e14f4563176cd9388462f1b272d3fac3",
"assets/assets/role/Lily_say.ogg": "8dddfd907e7b2bbe81eb944b32314658",
"assets/assets/role/Miko.webp": "2e1a0dbf681b3cc2368a0db52b4ee184",
"assets/assets/role/Miko_avatar.webp": "3c2dadbcc89a7b1604dd337e10da4b96",
"assets/assets/role/Miko_say.ogg": "7e61486964e3244e87730a233abd047c",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/fonts/MaterialIcons-Regular.otf": "3034b6e8500c8f1f09104440d3742ea6",
"assets/NOTICES": "8f704b05230fc321249212db0ae95cd0",
"assets/shaders/ink_sparkle.frag": "f8b80e740d33eb157090be4e995febdf",
"canvaskit/canvaskit.js": "bbf39143dfd758d8d847453b120c8ebb",
"canvaskit/canvaskit.wasm": "19d8b35640d13140fe4e6f3b8d450f04",
"canvaskit/chromium/canvaskit.js": "96ae916cd2d1b7320fff853ee22aebb0",
"canvaskit/chromium/canvaskit.wasm": "1165572f59d51e963a5bf9bdda61e39b",
"canvaskit/skwasm.js": "95f16c6690f955a45b2317496983dbe9",
"canvaskit/skwasm.wasm": "d1fde2560be92c0b07ad9cf9acb10d05",
"canvaskit/skwasm.worker.js": "51253d3321b11ddb8d73fa8aa87d3b15",
"css/loading.css": "5474ff9065ab8dde1d0c84ae93986a43",
"favicon.png": "c3c9dfb30c32d17cc65ffe65e7ddf258",
"flutter.js": "6b515e434cea20006b3ef1726d2c8894",
"icons/Icon-192.png": "93ae2742b36702f6f765d39a09a52914",
"icons/Icon-512.png": "698ee5192bffb24de04bcce9959476cd",
"icons/Icon-maskable-192.png": "db5d16a9a06860a64327f56d107112c4",
"icons/Icon-maskable-512.png": "73eaa27068a9242db69f7cfd858dde12",
"icons/logo.png": "f13d28b01cfcd18385cefa99eed4afb6",
"icons/logo.webp": "c2505b861f1051939d2d7d5080f1768e",
"index.html": "667f77be71ed49cae04ddffbe7ac25a6",
"/": "667f77be71ed49cae04ddffbe7ac25a6",
"main.dart.js": "d1a0945ba92a223f8b7a27c89011f3f6",
"manifest.json": "b76e7ed9d258266ebabf6627764ea3cc",
"version.json": "b6ffbceb36969917d28f0438022ca3d5"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"assets/AssetManifest.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
