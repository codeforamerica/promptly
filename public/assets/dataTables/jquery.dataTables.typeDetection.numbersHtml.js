<<<<<<< HEAD
jQuery.fn.dataTableExt.aTypes.unshift( function ( sData )
{
    sData = typeof sData.replace == 'function' ?
        sData.replace( /<.*?>/g, "" ) : sData;
    sData = $.trim(sData);

    var sValidFirstChars = "0123456789-";
    var sValidChars = "0123456789.";
    var Char;
    var bDecimal = false;

    /* Check for a valid first char (no period and allow negatives) */
    Char = sData.charAt(0);
    if (sValidFirstChars.indexOf(Char) == -1)
    {
        return null;
    }

    /* Check all the other characters are valid */
    for ( var i=1 ; i<sData.length ; i++ )
    {
        Char = sData.charAt(i);
        if (sValidChars.indexOf(Char) == -1)
        {
            return null;
        }

        /* Only allowed one decimal place... */
        if ( Char == "." )
        {
            if ( bDecimal )
            {
                return null;
            }
            bDecimal = true;
        }
    }

    return 'num-html';
} );
=======
jQuery.fn.dataTableExt.aTypes.unshift(function(a){a=typeof a.replace=="function"?a.replace(/<.*?>/g,""):a,a=$.trim(a);var b="0123456789-",c="0123456789.",d,e=!1;d=a.charAt(0);if(b.indexOf(d)==-1)return null;for(var f=1;f<a.length;f++){d=a.charAt(f);if(c.indexOf(d)==-1)return null;if(d=="."){if(e)return null;e=!0}}return"num-html"});
>>>>>>> hsa
