document.addEventListener("DOMContentLoaded", function() {
  const images = document.querySelectorAll("#image-slider .slider-image");
  let currentIndex = 0;

  function showNextImage() {
    images[currentIndex].classList.remove("active");
    currentIndex = (currentIndex + 1) % images.length;
    images[currentIndex].classList.add("active");
  }

  // 最初の画像を表示
  images[currentIndex].classList.add("active");

  // 5秒ごとに次の画像に切り替える
  setInterval(showNextImage, 4000);
});