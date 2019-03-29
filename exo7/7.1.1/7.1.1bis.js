const app = document.getElementById('root')

const container = document.createElement('div')
container.setAttribute('class', 'container')


app.appendChild(container)

var request = new XMLHttpRequest();

request.open('GET', 'https://www.bitmex.com/api/v1/orderBook/L2?symbol=XBT&depth=1', true)


request.onload = function() {
  // Begin accessing JSON data here

  var data = JSON.parse(this.response)
  if (request.status >= 200 && request.status < 400) {
    data.forEach(exchange => {
      const card = document.createElement('div')
      card.setAttribute('class', 'card')

      const h1 = document.createElement('h1')
      h1.textContent = exchange.side

      const p = document.createElement('p')
      exchange.description = exchange.description.substring(0, 300)
      p.textContent = `${exchange.description}...`

      container.appendChild(card)
      card.appendChild(h1)
      card.appendChild(p)
    })
  } else {
    const errorMessage = document.createElement('marquee')
    errorMessage.textContent = `Gah, it's not working!`
    app.appendChild(errorMessage)
  }
}

request.send()
