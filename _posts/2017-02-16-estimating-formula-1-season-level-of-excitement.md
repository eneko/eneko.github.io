---
layout: post
permalink: /articles/:title
title: Estimating Formula 1® Season Level of Excitement
date: 2017-02-16
desc: Estimating Formula 1® Season Level of Excitement.
keywords: formula1, f1, formula, one, season, excitement, analysis, statistics
image: /media/swift-frameworks/12-schemes-after.png
redirect_from:
  - /2017/02/16/estimating-formula-1-season-level-of-excitement.html
---

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.bundle.js"></script>

Hello!

<table>
<tr>
<td>
<h4>2016</h4>
<canvas id="chart-2016" width="150" height="150"></canvas>
<script>
var data = {
    datasets: [{
        data: [385,380,256,212,204],
        backgroundColor: ["#3da48e","#3da48e","#381ea0","#EB212E","#381ea0"],
        label: '2016'
    }],
    labels: ["Rosberg","Hamilton","Ricciardo","Vettel","Verstappen"]
};

var options = { legend: { display: false } };
new Chart("chart-2016", {
    data: data,
    type: 'polarArea',
    options: options
});
</script>
</td>

<td>
<h4>2015</h4>
<canvas id="chart-2015" width="150" height="150"></canvas>
<script>
var data = {
    datasets: [{
        data: [381,322,278,150,136],
        backgroundColor: ["#3da48e","#3da48e","#EB212E","#EB212E","#fafafa"],
        label: '2015'
    }],
    labels: ["Hamilton","Rosberg","Vettel","Raïkkönnen","Botas"]
};

var options = { legend: { display: false } };
new Chart("chart-2015", {
    data: data,
    type: 'polarArea',
    options: options
});
</script>
</td>

<td>
<h4>2014</h4>
<canvas id="chart-2014" width="150" height="150"></canvas>
<script>
var data = {
    datasets: [{
        data: [381,322,278,150,136],
        backgroundColor: ["#3da48e","#3da48e","#EB212E","#EB212E","#fafafa"],
        label: '2014'
    }],
    labels: ["Hamilton","Rosberg","Vettel","Raïkkönnen","Botas"]
};

var options = { legend: { display: false } };
new Chart("chart-2014", {
    data: data,
    type: 'polarArea',
    options: options
});
</script>
</td>

<td>
<h4>2013</h4>
<canvas id="chart-2013" width="150" height="150"></canvas>
<script>
var data = {
    datasets: [{
        data: [381,322,278,150,136],
        backgroundColor: ["#3da48e","#3da48e","#EB212E","#EB212E","#fafafa"],
        label: '2013'
    }],
    labels: ["Hamilton","Rosberg","Vettel","Raïkkönnen","Botas"]
};

var options = { legend: { display: false } };
new Chart("chart-2013", {
    data: data,
    type: 'polarArea',
    options: options
});
</script>
</td>

</tr>
</table>



<script>
fetch("https://raw.githubusercontent.com/grand-prix-stats/generated/master/f1/seasons/summary.json")
  .then(response => response.json())
  .then(json => sessions(json));

function sessions(json) {
  console.log(json.length);
}
</script>
