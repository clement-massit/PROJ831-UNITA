var data =
    [
        {name: 'Application', link: '#', side: "left", submenu:
            [
                {  "name": "Manage Roles", "link" : "underconstruction.html" }
                , {  "name": "Manage Users", "link" : "underconstruction.html" }
                , {  "name": "separator", "link" : "" }
                , {  "name": "Login Emulator", "link" : "loginemulator.html" }
                , {  "name": "separator", "link" : "" }
                , {  "name": "Logger", "link" : "underconstruction.html" }
                , {  "name": "Tracker", "link" : "underconstruction.html" }
            ]
        },
        {name: 'Universities', link: '#', side: "left", submenu:
            [
                {  "name": "Manage Universities", "link" : "underconstruction.html" }
                , {  "name": "separator", "link" : "" }
                , {  "name": "Load Data for each university from XLS", "link" : "underconstruction.html" }
                , {  "name": "Load Data for each university from CSV", "link" : "underconstruction.html" }
                , {  "name": "Load Data for each university from JSON", "link" : "underconstruction.html" }
            ]
        },
        {name: 'University', link: '#', side: "left", submenu:
            [
                {  "name": "My Univeristy", "link" : "underconstruction.html" }
            ]
        },
        {name: 'Carto Data', link: '#', side: "left", submenu:
            [
                {  "name": "Load Data from XLS", "link" : "underconstruction.html" }
                , {  "name": "Load Data from CSV", "link" : "underconstruction.html" }
                , {  "name": "Load Data from JSON", "link" : "underconstruction.html" }
            ]
        },
        {name: 'Formations', link: '#', side: "right", submenu:
            [
                {  "name": "Formations", "link" : "underconstruction.html" }
            ]
        },
        {name: 'Mobility', link: '#', side: "right", submenu:
            [
                {  "name": "Build your mobility", "link" : "underconstruction.html" }
                , {  "name": "Correlation for your mobility", "link" : "underconstruction.html" }
            ]
        },
        {name: 'Network', link: '#', side: "right", submenu:
            [
                {  "name": "Network your mobility", "link" : "underconstruction.html" }
            ]
        }
    ];
 var dataLogOut=   [{name: 'Logout', link: './home.html', side: "right", submenu: []}];

$(document).ready(function () {
    parseMenu("left", data);
    parseMenu("right", data);
    parseMenu("right", dataLogOut);
});
/*LOAD MENU*/
function parseMenu(side, data) {
	for (var i=0;i<data.length;i++) {
        if(data[i].side ==  side){
            var menu = "";
            if(data[i].submenu.length > 0) {  
                var submenu = "";           
                for(var j = 0; j < data[i].submenu.length; j++) {
                    if ("separator" == data[i].submenu[j]["name"] )
                        submenu += '<div class="dropdown-divider"></div>';
                    else
                        submenu += "<a class='dropdown-item' href=" + '"' + "javascript:$('#content').load('" +  data[i].submenu[j]["link"] + "') ;" + '" >' + data[i].submenu[j]["name"] + "</a>";
        
                }
                menu = '<li class="nav-item dropdown">'
                + '<a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">'
                + data[i].name
                + '</a>'
                + '<div class="dropdown-menu" aria-labelledby="navbarDropdown">'
                + submenu
                + "</div>"
                + "</li>";
            }else{
                menu = "<li class='nav-item'>"
                + "<a class='nav-link' href='"+ data[i].link + "'> " + data[i].name + " </a>"
                + "</li>";
            }
            $("#menu-"+side).append(menu);
        }
	}
}

