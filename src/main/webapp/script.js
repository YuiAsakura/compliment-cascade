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

	// 各フォントボタンの要素を取得
	const defaultButton = document.getElementById('font-default');
	const gothicButton = document.getElementById('font-gothic');
	const minchoButton = document.getElementById('font-mincho');
	const meiryoButton = document.getElementById('font-meiryo');

	// ページ全体の要素（body）を取得
	const bodyElement = document.body;

	// ページ読み込み時にフォントを適用する
	const savedFont = localStorage.getItem('selectedFont');
	if (savedFont) {
	    bodyElement.style.fontFamily = savedFont;
	}
	
	// ボタンにクリックイベントリスナーを設定
	if (defaultButton) {
	    defaultButton.addEventListener('click', function() {
	        bodyElement.style.fontFamily = '';
			localStorage.removeItem('selectedFont');
	    });
	}
	if (gothicButton) {
	    gothicButton.addEventListener('click', function() {
	        const font = '"游ゴシック", "Yu Gothic", "メイリオ", "Meiryo", sans-serif';
	        bodyElement.style.fontFamily = font;
	        localStorage.setItem('selectedFont', font);
	    });
	}
	if (minchoButton) {
	    minchoButton.addEventListener('click', function() {
	        const font = '"游明朝", "Yu Mincho", "ヒラギノ明朝 ProN W3", "Hiragino Mincho ProN", serif';
	        bodyElement.style.fontFamily = font;
	        localStorage.setItem('selectedFont', font);
	    });
	}
	if (meiryoButton) {
	    meiryoButton.addEventListener('click', function() {
	        const font = '"メイリオ", "Meiryo", sans-serif';
	        bodyElement.style.fontFamily = font;
	        localStorage.setItem('selectedFont', font);
	    });
	}
	
	// カラーセットの定義
	const colorSets = {
		'color-default': {
			bgColor:'#fff',
			fontColor: '#000'
		},
		'color-set-1': {
			bgColor: '#e6f4ff',
			fontColor: '#5c98d4'
		},
		'color-set-2': {
			bgColor: '#fff8dc',
			fontColor: '#8b4513'
		}
	};
	
	// 各カラーボタンの要素を取得
	const colorButtons = document.querySelectorAll('.menu-dropup-item p.color-preview');
	const mainColorIcon = document.getElementById('main-color-icon');
	
	// カラーセットを適用する関数
	const applyColorSet = (setId) => {
		const colors = colorSets[setId];
		if (colors) {
			// bodyにスタイルを適用
			document.body.style.backgroundColor = colors.bgColor;
			document.body.style.color = colors.fontColor;
			
			// メニューアイコンに色を表示
			const mainLeftHalf = mainColorIcon.querySelector('.left-half-bg');
			const mainRightHalf = mainColorIcon.querySelector('.right-half-font');
			mainLeftHalf.style.backgroundColor = colors.bgColor;
			mainRightHalf.style.backgroundColor = colors.fontColor;
			
			// localStorageに保存
			localStorage.setItem('selectedColorSet', setId);
		}
	};
	
	// ページ読み込み時に保存されたカラーセットを適用
	const savedColorSet = localStorage.getItem('selectedColorSet');
	if (savedColorSet) {
		applyColorSet(savedColorSet);
	} else {
		// 保存されていない場合はデフォルトを適用
		applyColorSet('color-default');
	}
	
	// 各ボタンにクリックイベントリスナーを設定
	colorButtons.forEach(button => {
		button.addEventListener('click', () => {
			const setId = button.id;
			applyColorSet(setId);
		});
	});
})