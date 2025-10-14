/**
 * 褒め言葉の滝を生成するスクリプト
 */
// JSPから渡されたcomplimentListを使用する

var compliment = new Object();

compliment.list = complimentList;

compliment.set = function() {
	// <span>要素を生成
	var span = document.createElement("span");
	// クラス名を指定
	span.className = "compliment";
	// ランダム位置に配置
	span.style.left = ( Math.random() * 100 ) + "%";
	span.style.top = ( Math.random() * 100 ) + "%";
	// リスト中の文字列をランダムに表示
	span.textContent = compliment.list[ Math.floor( Math.random()*compliment.list.length) ];

	// アニメーション終了後に要素を削除する処理を追加
	span.addEventListener('transitionend', function(e) {
	    // opacityプロパティの変化が完了した時だけ処理を実行
	    if (e.propertyName === 'opacity') {
	        this.remove(); // 要素をDOMから削除
	    }
	});

	// body要素に<span>を追加
	document.body.appendChild( span );

	// 要素がDOMに追加された直後に'show'クラスを追加
	// 少し遅延させることで、transitionが有効になる
	setTimeout(function(){
	  span.classList.add('show');
	}, 10);
};

// ページの読み込みが完了したらタイマーを起動する
window.addEventListener('DOMContentLoaded', (event) => {
	// 500ミリ秒間隔で実行
	compliment.tmr = setInterval( compliment.set, 500 );

	// ゴシック体ボタンの要素を取得
	const gothicButton = document.getElementById('font-gothic');
	// 明朝体ボタンの要素を取得
	const minchoButton = document.getElementById('font-mincho'); // スペルミスを修正
	// メイリオボタンの要素を取得
	const meiryoButton = document.getElementById('font-meiryo');

	// ページ全体の要素（body）を取得
	const bodyElement = document.body;

	// ボタンにクリックイベントリスナーを設定
	if (gothicButton) {
	    gothicButton.addEventListener('click', function() {
	        bodyElement.style.fontFamily = '"游ゴシック", "Yu Gothic", "メイリオ", "Meiryo", sans-serif';
	    });
	}
	if (minchoButton) {
	    minchoButton.addEventListener('click', function() {
	        bodyElement.style.fontFamily = '"游明朝", "Yu Mincho", "ヒラギノ明朝 ProN W3", "Hiragino Mincho ProN", serif';
	    });
	}
	if (meiryoButton) {
	    meiryoButton.addEventListener('click', function() {
	        bodyElement.style.fontFamily = '"メイリオ", "Meiryo", sans-serif';
	    });
	}
})

/*
// ゴシック体ボタンの要素を取得
const gothicButton = document.getElementById('font-gothic');
// 明朝体ボタンの要素を取得
const minchoButton = document.getElementById('font-mincho');
// メイリオボタンの要素を取得
const meiryoButton = document.getElementById('font-meiryo');

// ページ全体の要素（body）を取得
const bodyElement = document.body;

// ゴシック体ボタンが押された時の処理
gothicButton.addEventListener('click', function() {
	// body要素のフォントスタイルを変更
	bodyElement.style.fontFamily = 'sans-serif, Arial, sans-serif'
});

// 明朝体ボタンがクリックされたときの処理
minchoButton.addEventListener('click', function() {
    // body要素のフォントスタイルを変更
    bodyElement.style.fontFamily = 'serif, "Times New Roman", serif';
});

// メイリオボタンがクリックされたときの処理
meiryoButton.addEventListener('click', function() {
    // body要素のフォントスタイルを変更
    bodyElement.style.fontFamily = '"メイリオ", "Meiryo", sans-serif';
});
*/
