<<<<<<< HEAD
$.fn.dataTableExt.oApi.fnReloadAjax = function ( oSettings, sNewSource, fnCallback, bStandingRedraw )
{
    if ( typeof sNewSource != 'undefined' && sNewSource != null )
    {
        oSettings.sAjaxSource = sNewSource;
    }
    this.oApi._fnProcessingDisplay( oSettings, true );
    var that = this;
    var iStart = oSettings._iDisplayStart;
    var aData = [];

    this.oApi._fnServerParams( oSettings, aData );

    oSettings.fnServerData( oSettings.sAjaxSource, aData, function(json) {
        /* Clear the old information from the table */
        that.oApi._fnClearTable( oSettings );

        /* Got the data - add it to the table */
        var aData =  (oSettings.sAjaxDataProp !== "") ?
            that.oApi._fnGetObjectDataFn( oSettings.sAjaxDataProp )( json ) : json;

        for ( var i=0 ; i<aData.length ; i++ )
        {
            that.oApi._fnAddData( oSettings, aData[i] );
        }

        oSettings.aiDisplay = oSettings.aiDisplayMaster.slice();
        that.fnDraw();

        if ( typeof bStandingRedraw != 'undefined' && bStandingRedraw === true )
        {
            oSettings._iDisplayStart = iStart;
            that.fnDraw( false );
        }

        that.oApi._fnProcessingDisplay( oSettings, false );

        /* Callback user function - for event handlers etc */
        if ( typeof fnCallback == 'function' && fnCallback != null )
        {
            fnCallback( oSettings );
        }
    }, oSettings );
}
;
=======
$.fn.dataTableExt.oApi.fnReloadAjax=function(a,b,c,d){typeof b!="undefined"&&b!=null&&(a.sAjaxSource=b),this.oApi._fnProcessingDisplay(a,!0);var e=this,f=a._iDisplayStart,g=[];this.oApi._fnServerParams(a,g),a.fnServerData(a.sAjaxSource,g,function(b){e.oApi._fnClearTable(a);var g=a.sAjaxDataProp!==""?e.oApi._fnGetObjectDataFn(a.sAjaxDataProp)(b):b;for(var h=0;h<g.length;h++)e.oApi._fnAddData(a,g[h]);a.aiDisplay=a.aiDisplayMaster.slice(),e.fnDraw(),typeof d!="undefined"&&d===!0&&(a._iDisplayStart=f,e.fnDraw(!1)),e.oApi._fnProcessingDisplay(a,!1),typeof c=="function"&&c!=null&&c(a)},a)};
>>>>>>> hsa
