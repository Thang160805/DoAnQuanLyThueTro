// File: /assets/js/home.js
document.addEventListener("DOMContentLoaded", function () {
  const ctx = window.APP_CTX || "";

  const images = [
    `${ctx}/assets/img/anh1.jpg`,
    `${ctx}/assets/img/anh2.jpg`,
    `${ctx}/assets/img/anh3.jpg`,
    `${ctx}/assets/img/anh4.jpg`,
    `${ctx}/assets/img/anh5.jpg`,
  ];

  const banner = document.querySelector(".hero-banner");
  if (!banner) {
    console.warn("Không tìm thấy phần tử .hero-banner");
    return;
  }

  let currentIndex = 0;
  banner.style.backgroundImage = `url('${images[currentIndex]}')`;

  setInterval(() => {
    currentIndex = (currentIndex + 1) % images.length;
    banner.style.backgroundImage = `url('${images[currentIndex]}')`;
  }, 10000);
});
