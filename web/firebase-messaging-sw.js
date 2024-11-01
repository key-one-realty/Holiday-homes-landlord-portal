importScripts(
  "https://www.gstatic.com/firebasejs/9.6.10/firebase-app-compat.js"
);
importScripts(
  "https://www.gstatic.com/firebasejs/9.6.10/firebase-messaging-compat.js"
);

// todo Copy/paste firebaseConfig from Firebase Console
const firebaseConfig = {
  apiKey: "AIzaSyBvYNj2ZCkH-_raRCJg2mAKkgtYN7RIrts",
  authDomain: "landlordconnectnotify-28483.firebaseapp.com",
  projectId: "landlordconnectnotify-28483",
  storageBucket: "landlordconnectnotify-28483.appspot.com",
  messagingSenderId: "8149986184",
  appId: "1:8149986184:web:2db79157b95f0fb5a3e83d",
  measurementId: "G-C50Q471DTK",
};

firebase.initializeApp(firebaseConfig);
const messaging = firebase.messaging();

// todo Set up background message handler
messaging.onBackgroundMessage((message) => {
  console.log("onBackgroundMessage", message);
});
