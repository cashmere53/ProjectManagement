function write_chart(id, dest1, dest2, dest3, dest4, dest5, dis1, dis2, dis3, dis4, dis5, denomi) {
  // レーダーチャートで表示するデータを用意
  var radarChartData = {
    labels: [dest1, dest2, dest3, dest4, dest5],
    datasets: [
      {
        fillColor: "rgba(151,187,205,0.5)", // 線で囲まれた部分の色
        strokeColor: "rgba(151,187,205,1)", // 線の色
        pointColor: "rgba(151,187,205,1)",  // 点の色
        pointStrokeColor: "#fff",           // 点を囲む線の色
        data: [dis1, dis2, dis3, dis4, dis5]
      }
    ]
  };

  var option = {
    scaleShowLabels: true,   // 目盛を表示
    pointLabelFontSize : 10, // ラベルを表示
    // 値の開始値などを自分で設定するか
    scaleOverride : true,

    // 以下の 3 オプションは scaleOverride: true の時に使用
    // 値のステップ数
    scaleSteps : 5,
    // 値のステップする大きさ
    scaleStepWidth : -Math.ceil(denomi/1000)*200,
    // 値の始まりの値
    scaleStartValue : Math.ceil(denomi/1000)*1000,
  }

  // Canvas にレーダーチャートを描画
  var canvas = document.getElementById(id);
  var context = canvas.getContext("2d");
  var chart = new Chart(context);
  var rader = chart.Radar(radarChartData, option);
};
