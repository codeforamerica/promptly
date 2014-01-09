/* Default class modification */
<<<<<<< HEAD

$.extend( $.fn.dataTableExt.oStdClasses, {
	"sWrapper": "dataTables_wrapper form-inline"
} );

/* API method to get paging information */
$.fn.dataTableExt.oApi.fnPagingInfo = function ( oSettings )
{
	return {
		"iStart":         oSettings._iDisplayStart,
		"iEnd":           oSettings.fnDisplayEnd(),
		"iLength":        oSettings._iDisplayLength,
		"iTotal":         oSettings.fnRecordsTotal(),
		"iFilteredTotal": oSettings.fnRecordsDisplay(),
		"iPage":          Math.ceil( oSettings._iDisplayStart / oSettings._iDisplayLength ),
		"iTotalPages":    Math.ceil( oSettings.fnRecordsDisplay() / oSettings._iDisplayLength )
	};
}

/* Bootstrap style pagination control */
$.extend( $.fn.dataTableExt.oPagination, {
	"bootstrap": {
		"fnInit": function( oSettings, nPaging, fnDraw ) {
			var oLang = oSettings.oLanguage.oPaginate;
			var fnClickHandler = function ( e ) {
				e.preventDefault();
				if ( oSettings.oApi._fnPageChange(oSettings, e.data.action) ) {
					fnDraw( oSettings );
				}
			};

			$(nPaging).addClass('pagination').append(
				'<ul>'+
					'<li class="prev disabled"><a href="#">&larr; '+oLang.sPrevious+'</a></li>'+
					'<li class="next disabled"><a href="#">'+oLang.sNext+' &rarr; </a></li>'+
				'</ul>'
			);
			var els = $('a', nPaging);
			$(els[0]).bind( 'click.DT', { action: "previous" }, fnClickHandler );
			$(els[1]).bind( 'click.DT', { action: "next" }, fnClickHandler );
		},

		"fnUpdate": function ( oSettings, fnDraw ) {
			var iListLength = jQuery.fn.dataTableExt.oPagination.iFullNumbersShowPages;
			var oPaging = oSettings.oInstance.fnPagingInfo();
			var an = oSettings.aanFeatures.p;
			var i, j, sClass, iStart, iEnd, iHalf=Math.floor(iListLength/2);

			if ( oPaging.iTotalPages < iListLength) {
				iStart = 1;
				iEnd = oPaging.iTotalPages;
			}
			else if ( oPaging.iPage <= iHalf ) {
				iStart = 1;
				iEnd = iListLength;
			} else if ( oPaging.iPage >= (oPaging.iTotalPages-iHalf) ) {
				iStart = oPaging.iTotalPages - iListLength + 1;
				iEnd = oPaging.iTotalPages;
			} else {
				iStart = oPaging.iPage - iHalf + 1;
				iEnd = iStart + iListLength - 1;
			}

			for ( i=0, iLen=an.length ; i<iLen ; i++ ) {
				// Remove the middle elements
				$('li:gt(0)', an[i]).filter(':not(:last)').remove();

				// Add the new list items and their event handlers
				for ( j=iStart ; j<=iEnd ; j++ ) {
					sClass = (j==oPaging.iPage+1) ? 'class="active"' : '';
					$('<li '+sClass+'><a href="#">'+j+'</a></li>')
						.insertBefore( $('li:last', an[i])[0] )
						.bind('click', function (e) {
							e.preventDefault();
							oSettings._iDisplayStart = (parseInt($('a', this).text(),10)-1) * oPaging.iLength;
							fnDraw( oSettings );
						} );
				}

				// Add / remove disabled classes from the static elements
				if ( oPaging.iPage === 0 ) {
					$('li:first', an[i]).addClass('disabled');
				} else {
					$('li:first', an[i]).removeClass('disabled');
				}

				if ( oPaging.iPage === oPaging.iTotalPages-1 || oPaging.iTotalPages === 0 ) {
					$('li:last', an[i]).addClass('disabled');
				} else {
					$('li:last', an[i]).removeClass('disabled');
				}
			}
		}
	}
} );
=======
$.extend($.fn.dataTableExt.oStdClasses,{sWrapper:"dataTables_wrapper form-inline"}),$.fn.dataTableExt.oApi.fnPagingInfo=function(a){return{iStart:a._iDisplayStart,iEnd:a.fnDisplayEnd(),iLength:a._iDisplayLength,iTotal:a.fnRecordsTotal(),iFilteredTotal:a.fnRecordsDisplay(),iPage:Math.ceil(a._iDisplayStart/a._iDisplayLength),iTotalPages:Math.ceil(a.fnRecordsDisplay()/a._iDisplayLength)}},$.extend($.fn.dataTableExt.oPagination,{bootstrap:{fnInit:function(a,b,c){var d=a.oLanguage.oPaginate,e=function(b){b.preventDefault(),a.oApi._fnPageChange(a,b.data.action)&&c(a)};$(b).addClass("pagination").append('<ul><li class="prev disabled"><a href="#">&larr; '+d.sPrevious+"</a></li>"+'<li class="next disabled"><a href="#">'+d.sNext+" &rarr; </a></li>"+"</ul>");var f=$("a",b);$(f[0]).bind("click.DT",{action:"previous"},e),$(f[1]).bind("click.DT",{action:"next"},e)},fnUpdate:function(a,b){var c=jQuery.fn.dataTableExt.oPagination.iFullNumbersShowPages,d=a.oInstance.fnPagingInfo(),e=a.aanFeatures.p,f,g,h,i,j,k=Math.floor(c/2);d.iTotalPages<c?(i=1,j=d.iTotalPages):d.iPage<=k?(i=1,j=c):d.iPage>=d.iTotalPages-k?(i=d.iTotalPages-c+1,j=d.iTotalPages):(i=d.iPage-k+1,j=i+c-1);for(f=0,iLen=e.length;f<iLen;f++){$("li:gt(0)",e[f]).filter(":not(:last)").remove();for(g=i;g<=j;g++)h=g==d.iPage+1?'class="active"':"",$("<li "+h+'><a href="#">'+g+"</a></li>").insertBefore($("li:last",e[f])[0]).bind("click",function(c){c.preventDefault(),a._iDisplayStart=(parseInt($("a",this).text(),10)-1)*d.iLength,b(a)});d.iPage===0?$("li:first",e[f]).addClass("disabled"):$("li:first",e[f]).removeClass("disabled"),d.iPage===d.iTotalPages-1||d.iTotalPages===0?$("li:last",e[f]).addClass("disabled"):$("li:last",e[f]).removeClass("disabled")}}}});
>>>>>>> hsa
