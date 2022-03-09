String.prototype.startsWith = function (a) {
    return this.substr(0, a.length) === a;
}

String.prototype.endsWith = function (a) {
    return this.substr(this.length - a.length) === a;
}

function Change_Document_By_id(packageno)
{
 window.location.href=document.getElementById(packageno).href

}

function toggle_visibility_by_classname_fexp(hideShowClassName, hideShowImg) {
    /*var elemToHideShow = document.getElementById(hideShowId);*/
    var elemToHideShow = document.getElementsByTagName('span');
    var imgToHideShow = document.getElementById(hideShowImg);

    var toExpand = "true";
    var expandCollapseString = "expandCollapse";

    if (imgToHideShow.src.endsWith('collapseArrow.png')) {
        toExpand = "false";
    }

    for (i = 0; i < (elemToHideShow.length) ; i++) {

        if (elemToHideShow[i].className.startsWith(hideShowClassName)) {
            if (toExpand == "false") {
                elemToHideShow[i].style.display = 'none';

                if (!elemToHideShow[i].className.startsWith("detaildisplay"))
                    document.getElementById(expandCollapseString.concat(elemToHideShow[i].id)).src = "Data\\expandArrow.png";
            }
            else {
                elemToHideShow[i].style.display = 'block';

                if (!elemToHideShow[i].className.startsWith("detaildisplay"))
                    document.getElementById(expandCollapseString.concat(elemToHideShow[i].id)).src = "Data\\collapseArrow.png";
            }
        }
    }
}


function toggle_visibility_by_classname(hideShowClassName, hideShowImg) {
    /*var elemToHideShow = document.getElementById(hideShowId);*/
    var elemToHideShow = document.getElementsByTagName('span');
    var imgToHideShow = document.getElementById(hideShowImg);

    var toExpand = "true";
    var expandCollapseString = "expandCollapse";

    if (imgToHideShow.src.endsWith('collapseArrow.png')) {
        toExpand = "false";
    }

    for (i = 0; i < elemToHideShow.length; i++) {
        if (elemToHideShow[i].className.startsWith(hideShowClassName)) {
            if (toExpand == "false") {
                elemToHideShow[i].style.display = 'none';
                document.getElementById(expandCollapseString.concat(elemToHideShow[i].id)).src = "Data\\expandArrow.png";
            }
            else {
                elemToHideShow[i].style.display = 'block';
                document.getElementById(expandCollapseString.concat(elemToHideShow[i].id)).src = "Data\\collapseArrow.png";
            }
        }
    }
}

function toggle_visibility_by_labelname(listName)
 {
	var elemToHideShow = document.getElementsByTagName('label');
    var selValue = document.getElementById(listName).value;
    
	for (i=0;i<elemToHideShow.length;i++)
	{
		if ( selValue == 'ALL')
		{
			elemToHideShow[i].firstChild.style.display = 'block'; 
            }
		else
		{
			if (elemToHideShow[i].getAttribute('name')!=selValue)
			{
				elemToHideShow[i].firstChild.style.display = 'none'; 
                }
			else
			{
				elemToHideShow[i].firstChild.style.display = 'block'; 
            }
        }
    }
}

function toggle_visibility_by_id(hideShowId, hideShowImg) {
    var elemToHideShow = document.getElementById(hideShowId);
    var imgToHideShow = document.getElementById(hideShowImg);
    var imgSrcString = imgToHideShow.src;
    if (elemToHideShow != null) {
        if (hideShowImg.startsWith('plusminus')) {
            if (imgToHideShow.src.endsWith('Plus.gif')) {
                elemToHideShow.style.display = 'block';
                imgToHideShow.src = "Data\\Minus.gif";
            }
            else {
                elemToHideShow.style.display = 'none';
                imgToHideShow.src = "Data\\Plus.gif";
            }
        }
        if (hideShowImg.startsWith('expandCollapse')) {
            if (imgSrcString.match('expand') != null) {
                elemToHideShow.style.display = 'block';
                imgToHideShow.src = imgSrcString.replace('expand', 'collapse');
            }
            else {
                elemToHideShow.style.display = 'none';
                imgToHideShow.src = imgSrcString.replace('collapse', 'expand');
            }
        }
    }
}

function toggle_visibility(hideShowId) {
    var elemToHideShow = document.getElementById(hideShowId);
    if (elemToHideShow != null) {
        if (elemToHideShow.style.display == 'block') {
            elemToHideShow.style.display = 'none';
        }
        else {
            elemToHideShow.style.display = 'block';
        }
    }
}


function toggle_visibility_by_condition(hideShowId, hideShowCondition, conditionType) {
    var elemToHideShow = document.getElementById(hideShowId);
    var elemConditionHideShow = document.getElementById(hideShowCondition);

    if (elemToHideShow != null && elemConditionHideShow != null) {
        if (conditionType == 'expandSameStateOrToggle') {
            if (hideShowCondition.startsWith('plusminus')) {
                if (elemConditionHideShow.src.match('Plus') != null || elemConditionHideShow.src.match('Minus') != null) {
                    if (!((elemConditionHideShow.src.match('Plus') != null && elemToHideShow.src.match('expand') != null) || (elemConditionHideShow.src.match('Minus') != null && elemToHideShow.src.match('collapse') != null))) {
                        if (elemToHideShow.src.match('expand') != null) {
                            elemToHideShow.src = elemToHideShow.src.replace('expand', 'collapse');
                        }
                        else {
                            elemToHideShow.src = elemToHideShow.src.replace('collapse', 'expand');
                        }

                    }
                }
            }
            else if (hideShowCondition.startsWith('expandCollapse')) {
                if (!((elemConditionHideShow.src.match('expand') != null && elemToHideShow.src.match('expand') != null) || (elemConditionHideShow.src.match('collapse') != null && elemToHideShow.src.match('collapse') != null))) {
                    if (elemToHideShow.src.match('expand') != null) {
                        elemToHideShow.src = elemToHideShow.src.replace('expand', 'collapse');
                    }
                    else {
                        elemToHideShow.src = elemToHideShow.src.replace('collapse', 'expand');
                    }

                }
            }
            else {
                if (!((elemConditionHideShow.style.display == 'none' && elemToHideShow.src.match('expand') != null) || (elemConditionHideShow.style.display == 'block' && elemToHideShow.src.match('collapse') != null))) {
                    if (elemToHideShow.src.match('expand') != null) {
                        elemToHideShow.src = elemToHideShow.src.replace('expand', 'collapse');
                    }
                    else {
                        elemToHideShow.src = elemToHideShow.src.replace('collapse', 'expand');
                    }

                }
            }
        }
        if (conditionType == 'showOrToggle') {/* If condition elemn is visible, then show the element hideShowId, otherwise toggle visibility of hideShowId
			depending on its visibility status.
				hideShowCondition:Visible -> hideShowId:Visible
				otherwise : hideShowId:Visible-> hideShowId:NotVisible or hideShowId:NotVisible-> hideShowId:Visible
				*/
            if (elemConditionHideShow.style.display == 'block') {
                if (hideShowId.startsWith('expandCollapse')) {
                    elemToHideShow.src = elemToHideShow.src.replace('expand', 'collapse');
                }
                else {
                    if (hideShowId.startsWith('plusminus')) {
                        elemToHideShow.src = elemToHideShow.src.replace('Plus', 'Minus');
                    }
                    else {
                        elemToHideShow.style.display = 'block';
                    }
                }
            }
            else {
                if (hideShowId.startsWith('expandCollapse')) {
                    if (elemToHideShow.src.match('expand') != null) {
                        elemToHideShow.src = elemToHideShow.src.replace('expand', 'collapse');
                    }
                    else {
                        elemToHideShow.src = elemToHideShow.src.replace('collapse', 'expand');
                    }
                }
                else {
                    if (hideShowId.startsWith('plusminus')) {
                        if (elemToHideShow.src.match('Plus') != null) {
                            elemToHideShow.src = elemToHideShow.src.replace('Plus', 'Minus');
                        }
                        else {
                            elemToHideShow.src = elemToHideShow.src.replace('Minus', 'Plus');
                        }
                    }
                    else {
                        if (elemToHideShow.style.display == 'block') {
                            elemToHideShow.style.display = 'none';
                        }
                        else {
                            elemToHideShow.style.display = 'block';
                        }
                    }
                }
            }
        }
        if (conditionType == 'hideOnly') {/* If condition elemn is not visible, then hide the element hideShowId.
				*/
            if (elemConditionHideShow.style.display == 'none') {
                if (hideShowId.startsWith('expandCollapse')) {
                    elemToHideShow.src = elemToHideShow.src.replace('collapse', 'expand');
                }
                else {
                    elemToHideShow.style.display = 'none';
                }

            }
        }
    }

}

function toggle_Img_by_condition(hideShowIdImg, condition) {
    var imgToChange = document.getElementById(hideShowIdImg);

    if (imgToChange != null) {
        var imgSrcString = imgToChange.src;
        if (condition == 'toggle') {
            if (hideShowIdImg.startsWith('expandCollapse')) {
                if (imgSrcString.match('expand') != null) {
                    imgToChange.src = imgSrcString.replace('expand', 'collapse');
                }
                else {
                    imgToChange.src = imgSrcString.replace('collapse', 'expand');
                }
            }
        }

        if (condition == 'hideOnly') {
            if (hideShowIdImg.startsWith('expandCollapse')) {
                imgToChange.src = imgSrcString.replace('collapse', 'expand');
            }
        }
        if (condition == 'showOnly') {
            if (hideShowIdImg.startsWith('expandCollapse') && imgToChange.src.match('expand') != null) {
                imgToChange.src = imgSrcString.replace('expand', 'collapse');
            }
        }
    }
}



function expand_detail_by_id(detailId) {
    var expandCollapseString = "expandCollapse";
    var imgElemDetail = document.getElementById(expandCollapseString.concat(detailId));
    var elemDetail = document.getElementById(detailId);


    expand_section_by_id('Details');

    if (imgElemDetail.src.endsWith('expandArrow.png')) {
        elemDetail.style.display = 'block';
        imgElemDetail.src = "Data\\collapseArrow.png";
    }

}

function expand_section_by_id(sectionName) {
    var sectionString = 'Section';
    var plusminusString = 'plusminus';
    var tempString = plusminusString.concat(sectionName);
    var imgDetailSection = document.getElementById(tempString.concat(sectionString));
    var elemDetailSection = document.getElementById(sectionName.concat(sectionString));

    if (imgDetailSection.src.endsWith('Plus.gif')) {
        elemDetailSection.style.display = 'block';
        imgDetailSection.src = "Data\\Minus.gif";
    }
}

function getValue(varname) {
    // First, we load the URL into a variable
    var url = window.location.href;

    // Next, split the url by the ?
    var qparts = url.split("?");

    // Check that there is a querystring, return "" if not
    if (qparts.length <= 1) {
        return "";
    }

    // Then find the querystring, everything after the ?
    var query = qparts[1];

    // Split the query string into variables (separates by &s)
    var vars = query.split("&");

    // Initialize the value with "" as default
    var value = "";

    // Iterate through vars, checking each one for varname
    for (i = 0; i < vars.length; i++) {
        // Split the variable by =, which splits name and value
        var parts = vars[i].split("=");

        // Check if the correct variable
        if (parts[0] == varname) {
            // Load value into variable
            value = parts[1];

            // End the loop
            break;
        }
    }

    // Convert escape code
    value = unescape(value);

    // Convert "+"s to " "s
    value.replace(/\+/g, " ");

    // Return the value
    return value;
}
