var request = require('sync-request');

function makeRequest(url){
	var res = request('GET', url);
    var data = JSON.parse(res.body.toString('utf-8'));
    console.table("")
    console.table("******STATISTIQUES******")
    console.table("")
    console.table("Current price" )
    console.table(data.data.market_data.price_usd + " $/" + symbol)
    console.table("")
    console.table("Highest price")
    console.table(data.data.all_time_high.price + " $/" + symbol)
    console.table("Atteint le " + data.data.all_time_high.at)
    console.table("")
    console.table("Ratio emitted tokens by 2050")
    console.table(data.data.supply.y_2050_issued_percent + " %")
    console.table("")
    console.table("")
}
 

var symbol = process.argv.slice(2);

var url =  'https://data.messari.io/api/v1/assets/'+symbol+'/metrics'

var result = makeRequest(url);