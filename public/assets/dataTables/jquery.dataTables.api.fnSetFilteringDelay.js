<<<<<<< HEAD
jQuery.fn.dataTableExt.oApi.fnSetFilteringDelay = function ( oSettings, iDelay ) {
    var _that = this;

    if ( iDelay === undefined ) {
        iDelay = 250;
    }

    this.each( function ( i ) {
        $.fn.dataTableExt.iApiIndex = i;
        var
            $this = this,
            oTimerId = null,
            sPreviousSearch = null,
            anControl = $( 'input', _that.fnSettings().aanFeatures.f );

        anControl.unbind( 'keyup' ).bind( 'keyup', function() {
            var $$this = $this;

            if (sPreviousSearch === null || sPreviousSearch != anControl.val()) {
                window.clearTimeout(oTimerId);
                sPreviousSearch = anControl.val();
                oTimerId = window.setTimeout(function() {
                    $.fn.dataTableExt.iApiIndex = i;
                    _that.fnFilter( anControl.val() );
                }, iDelay);
            }
        });

        return this;
    } );
    return this;
};
=======
jQuery.fn.dataTableExt.oApi.fnSetFilteringDelay=function(a,b){var c=this;return b===undefined&&(b=250),this.each(function(a){$.fn.dataTableExt.iApiIndex=a;var d=this,e=null,f=null,g=$("input",c.fnSettings().aanFeatures.f);return g.unbind("keyup").bind("keyup",function(){var h=d;if(f===null||f!=g.val())window.clearTimeout(e),f=g.val(),e=window.setTimeout(function(){$.fn.dataTableExt.iApiIndex=a,c.fnFilter(g.val())},b)}),this}),this};
>>>>>>> hsa
