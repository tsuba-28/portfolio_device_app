import { Controller } from "@hotwired/stimulus"
// Swiperに必要なモジュールをインポート
import Swiper from 'swiper';

// Connects to data-controller="swiper"
export default class extends Controller {
  connect() {
    // ページが読み込まれたらSwiperを起動
    new Swiper(this.element, {
      loop: true, //最後までいったら最初に戻る
      pagination: {
        el: '.swiper-pagination',
        clickable:  true,
      },
      navigation: {
        nextEl: '.swiper-button-next',
        prevEl: '.swiper-button-prev'
      },
    });
  }
}
