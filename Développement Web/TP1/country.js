// 2 variables globales à modifier dans l'écouteur window.onload
var countries = {
    "names": [], // ["Afghanistan", ...]
    "codes": {}, // {"Afghanistan":"AF", ...}
    "flags": {} // {"Afghanistan":"data:image...", ...}
};

var continents = []; // [{"Asia":["Afghanistan","Armenia",...]}, ...]


window.addEventListener("load", (event) => {
    // Q1 Extraction des noms de pays à partir du tableau HTML

    const table = document.querySelector("table");

    Array.from(table.rows).map(row => {
        Array.from(row.cells).map((cell) => {
            countries.names.push(cell.innerHTML)
        })
    })

    console.log("Countries names : ", countries.names);

    // Q2 Extraction des codes de pays du fichier country_codes.json
    fetch('country_codes.json', {
            method: 'GET'
        })
        .then((response) => response.json())
        .then((country_codes) => {
            //console.log('Suc:', country_codes);
            
            country_codes.forEach((country =>  {
                for (const [countryName, countryCode] of Object.entries(country))
                {
                    countries.codes[countryName] = countryCode
                }
            }))

            //console.log("Country code : ", countries.codes);

            return countries.codes;
        })
        .catch((error) => {
            console.error('Error Q2:', error);
        });

    // Q3 Extraction des continents de pays à partir du tableau country_continents (importé de country_continents.js) 
    // A COMPLETER <---
    // [{"country":"Afghanistan","continent":"Asia"}, ...] --> [{"Asia":["Afghanistan","Armenia",...]}, ...]
    // --> A COMPLETER

    const continentWithoutDoubles = new Set([])

    Array.from(country_continents.map((country) => {
        if(!continentWithoutDoubles.has(country.continent))
            continentWithoutDoubles.add(country.continent)
    }))

    continentWithoutDoubles.forEach((c) => {
        const countriesPerContinents = Array.from(country_continents.filter((country) => country.continent === c))

        const justCountryNames = countriesPerContinents.map((countryPerContinent) =>  countryPerContinent.country)

        const continent = {}
        continent[c] = justCountryNames

        continents.push(continent)
    })

    console.log("Continents and countries : ", continents);

    // Q4 Extraction des drapeaux de pays à partir de la constante country_flags (importée de country_flags.js) 

    Array.from(country_flags.map((country_flag) => {
        countries.flags[country_flag.country] = country_flag.flag_base64
    }))

    console.log(countries.flags);

    // Q5 Mise en forme CSS

    table.style.textAlign = "center"
    table.style.fontSize = "75%"
    
    Array.from(table.rows).map(row => {

        row.style.textAlign = "center"
        row.style.fontSize = "75%"

        Array.from(row.cells).map((cell) => {
            cell.style.textAlign = "center"
            cell.style.fontSize = "75%"
        })
    })

    const body = document.querySelector("body")
    const secondDiv = body.querySelectorAll("div")[1]
    secondDiv.classList.add("row")

    const firstSubDiv = secondDiv.querySelectorAll("div")[0]
    firstSubDiv.classList.add("side")
});



let handleSelectors = function() {
    // Q6 Gestion du menu
    // A COMPLETER <---
    // --> A COMPLETER

    const menuDeroulant = document.getElementById("continents")
    menuDeroulant.addEventListener("change", function() {

        
    const filteredCountries = filterContinent(menuDeroulant.value)

    const table = document.querySelector("table")
    Array.from(table.rows).map(row => {
        Array.from(row.cells).map((cell) => {

            if(menuDeroulant.value === "all") 
                cell.style.visibility = "visible"

            else {
                if(!filteredCountries.includes(cell.id))
                {
                    cell.style.visibility = "hidden"
                }

                else cell.style.visibility = "visible"
            }
        })
    })
})
}();

const filterContinent = (continent) => {

    if(continent === "all") 
        return;

    let tempArray = []

    continents.forEach((c) => {
        for (const [continentName, arrayCountries] of Object.entries(c))
        {
            if(continentName === continent) 
                tempArray = [...arrayCountries];
        }  
    })

    return tempArray
}


let handleRadios = function() {

    const table = document.querySelector("table");

    const radioButtons = document.querySelectorAll('input[name="pays"]');

    for (const radioButton of radioButtons) {        
        radioButton.addEventListener("change", function() {
            if(radioButton.checked) 
            {
                switch(radioButton.value) {

                    case 'noms' :
                        Array.from(table.rows).map((row) => {
                            Array.from(row.cells).map((cell) => {
                                cell.innerText = cell.id
                            })
                        })
                        break;
                    case 'drapeaux' :
                        Array.from(table.rows).map((row) => {
                            Array.from(row.cells).map((cell) => {

                                cell.innerHTML = ""
                                const image = document.createElement("img")
                                image.src = countries.flags[cell.id]
                                image.alt = cell.id
                                image.classList.add("flag")
                                cell.appendChild(image)

                            })
                        })
                        break;
                    case 'codes' :
                        Array.from(table.rows).map((row) => {
                            Array.from(row.cells).map((cell) => {

                                cell.innerText = countries.codes[cell.id]
                            })
                        })

                        break;
                    
                }
            }
        })
    }

    paysRadio.addEventListener('')

    console.log(radios)
}();

let handleHeader = function f() {
    let tds = document.querySelectorAll("td");
    tds.forEach(function(td) {
        td.addEventListener("click", function(e) {
            let country_name = e.target.id;
            if (country_name) {
                fetch('get_country_features.php', {
                        method: 'POST',
                        body: new URLSearchParams("country_name=" + country_name),
                    })
                    .then((response) => response.json())
                    .then((country) => {
                        console.log('Success:', country);
                        // Q8 clic sur cellule
                        // A COMPLETER <---
                        // --> A COMPLETER
                        return country;
                    })
                    .catch((error) => {
                        console.error('Error:', error);
                    });
            }
        });
    });
}();