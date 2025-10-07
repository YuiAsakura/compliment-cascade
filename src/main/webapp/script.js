/**
 * 褒め言葉の滝を生成するスクリプト
 */
var compliment = new Object();

// 褒め言葉リスト
compliment.list = [
	"かわいい", "かっこいい", "天才", "おしゃれ",
	"ゲーム上手い", "料理上手", "センスある", "ポジティブ",
	"頼りになる", "誠実", "面白い", "努力家"
];

compliment.count = 0;	// 文字の番号カウント
compliment.limit = 100; // 表示する文字の戸数の上限値

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
	
	// body要素に<span>を追加
	document.body.appendChild( span );	
	
	// 上限値でストップ
	if ( document.querySelectorAll(".compliment").length >= compliment.limit ){
		clearInterval( compliment.tmr );
	}
};

// ページの読み込みが完了したらタイマーを起動する
window.addEventListener('DOMContentLoaded', (event) => {
	// 500ミリ秒間隔で実行
	compliment.tmr = setInterval( compliment.set, 500 );
}) 