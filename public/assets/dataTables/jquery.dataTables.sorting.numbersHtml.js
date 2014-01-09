<<<<<<< HEAD
jQuery.fn.dataTableExt.oSort['num-html-asc']  = function(a,b) {
    var x = a.replace( /<.*?>/g, "" );
    var y = b.replace( /<.*?>/g, "" );
    x = parseFloat( x );
    y = parseFloat( y );
    return ((x < y) ? -1 : ((x > y) ?  1 : 0));
};

jQuery.fn.dataTableExt.oSort['num-html-desc'] = function(a,b) {
    var x = a.replace( /<.*?>/g, "" );
    var y = b.replace( /<.*?>/g, "" );
    x = parseFloat( x );
    y = parseFloat( y );
    return ((x < y) ?  1 : ((x > y) ? -1 : 0));
};
=======
jQuery.fn.dataTableExt.oSort["num-html-asc"]=function(a,b){var c=a.replace(/<.*?>/g,""),d=b.replace(/<.*?>/g,"");return c=parseFloat(c),d=parseFloat(d),c<d?-1:c>d?1:0},jQuery.fn.dataTableExt.oSort["num-html-desc"]=function(a,b){var c=a.replace(/<.*?>/g,""),d=b.replace(/<.*?>/g,"");return c=parseFloat(c),d=parseFloat(d),c<d?1:c>d?-1:0};
>>>>>>> hsa
