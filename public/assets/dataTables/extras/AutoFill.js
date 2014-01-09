/*
 * File:        AutoFill.js
 * Version:     1.1.2
 * CVS:         $Id$
 * Description: AutoFill for DataTables
 * Author:      Allan Jardine (www.sprymedia.co.uk)
 * Created:     Mon  6 Sep 2010 16:54:41 BST
 * Modified:    $Date$ by $Author$
 * Language:    Javascript
 * License:     GPL v2 or BSD 3 point
 * Project:     DataTables
 * Contact:     www.sprymedia.co.uk/contact
 *
 * Copyright 2010-2011 Allan Jardine, all rights reserved.
 *
 * This source file is free software, under either the GPL v2 license or a
 * BSD style license, available at:
 *   http://datatables.net/license_gpl2
 *   http://datatables.net/license_bsd
 *
 */
<<<<<<< HEAD

/* Global scope for AutoFill */

var AutoFill;

(function($) {

/**
 * AutoFill provides Excel like auto fill features for a DataTable
 * @class AutoFill
 * @constructor
 * @param {object} DataTables settings object
 * @param {object} Configuration object for AutoFill
 */
AutoFill = function( oDT, oConfig )
{
	/* Santiy check that we are a new instance */
	if ( !this.CLASS || this.CLASS != "AutoFill" )
	{
		alert( "Warning: AutoFill must be initialised with the keyword 'new'" );
		return;
	}

	if ( !$.fn.dataTableExt.fnVersionCheck('1.7.0') )
	{
		alert( "Warning: AutoFill requires DataTables 1.7 or greater - www.datatables.net/download");
		return;
	}


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Public class variables
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * @namespace Settings object which contains customisable information for AutoFill instance
	 */
	this.s = {
		/**
		 * @namespace Cached information about the little dragging icon (the filler)
		 */
		"filler": {
			"height": 0,
			"width": 0
		},

		/**
		 * @namespace Cached information about the border display
		 */
		"border": {
			"width": 2
		},

		/**
		 * @namespace Store for live information for the current drag
		 */
		"drag": {
			"startX": -1,
			"startY": -1,
			"startTd": null,
			"endTd": null,
			"dragging": false
		},

		/**
		 * @namespace Data cache for information that we need for scrolling the screen when we near
		 *   the edges
		 */
		"screen": {
			"interval": null,
			"y": 0,
			"height": 0,
			"scrollTop": 0
		},

		/**
		 * @namespace Data cache for the position of the DataTables scrolling element (when scrolling
		 *   is enabled)
		 */
		"scroller": {
			"top": 0,
			"bottom": 0
		},


		/**
		 * @namespace Information stored for each column. An array of objects
		 */
		"columns": []
	};


	/**
	 * @namespace Common and useful DOM elements for the class instance
	 */
	this.dom = {
		"table": null,
		"filler": null,
		"borderTop": null,
		"borderRight": null,
		"borderBottom": null,
		"borderLeft": null,
		"currentTarget": null
	};



	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Public class methods
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * Retreieve the settings object from an instance
	 *  @method fnSettings
	 *  @returns {object} AutoFill settings object
	 */
	this.fnSettings = function () {
		return this.s;
	};


	/* Constructor logic */
	this._fnInit( oDT, oConfig );
	return this;
};



AutoFill.prototype = {
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Private methods (they are of course public in JS, but recommended as private)
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * Initialisation
	 *  @method _fnInit
 	 *  @param {object} oDT DataTables settings object
 	 *  @param {object} oConfig Configuration object for AutoFill
	 *  @returns void
	 */
	"_fnInit": function ( oDT, oConfig )
	{
		var
			that = this,
			i, iLen;

		/*
		 * Settings
		 */
		this.s.dt = oDT.fnSettings();

		this.dom.table = this.s.dt.nTable;

		/* Add and configure the columns */
		for ( i=0, iLen=this.s.dt.aoColumns.length ; i<iLen ; i++ )
		{
			this._fnAddColumn( i );
		}

		if ( typeof oConfig != 'undefined' && typeof oConfig.aoColumnDefs != 'undefined' )
		{
			this._fnColumnDefs( oConfig.aoColumnDefs );
		}

		if ( typeof oConfig != 'undefined' && typeof oConfig.aoColumns != 'undefined' )
		{
			this._fnColumnsAll( oConfig.aoColumns );
		}


		/*
		 * DOM
		 */

		/* Auto Fill click and drag icon */
		var filler = document.createElement('div');
		filler.className = "AutoFill_filler";
		document.body.appendChild( filler );
		this.dom.filler = filler;

		filler.style.display = "block";
		this.s.filler.height = $(filler).height();
		this.s.filler.width = $(filler).width();
		filler.style.display = "none";

		/* Border display - one div for each side. We can't just use a single one with a border, as
		 * we want the events to effectively pass through the transparent bit of the box
		 */
		var border;
		var appender = document.body;
		if ( that.s.dt.oScroll.sY !== "" )
		{
			that.s.dt.nTable.parentNode.style.position = "relative";
			appender = that.s.dt.nTable.parentNode;
		}

		border = document.createElement('div');
		border.className = "AutoFill_border";
		appender.appendChild( border );
		this.dom.borderTop = border;

		border = document.createElement('div');
		border.className = "AutoFill_border";
		appender.appendChild( border );
		this.dom.borderRight = border;

		border = document.createElement('div');
		border.className = "AutoFill_border";
		appender.appendChild( border );
		this.dom.borderBottom = border;

		border = document.createElement('div');
		border.className = "AutoFill_border";
		appender.appendChild( border );
		this.dom.borderLeft = border;

		/*
		 * Events
		 */

		$(filler).mousedown( function (e) {
			this.onselectstart = function() { return false; };
			that._fnFillerDragStart.call( that, e );
			return false;
		} );

		$('tbody>tr>td', this.dom.table).live( 'mouseover mouseout', function (e) {
			that._fnFillerDisplay.call( that, e );
		} );
	},


	"_fnColumnDefs": function ( aoColumnDefs )
	{
		var
			i, j, k, iLen, jLen, kLen,
			aTargets;

		/* Loop over the column defs array - loop in reverse so first instace has priority */
		for ( i=aoColumnDefs.length-1 ; i>=0 ; i-- )
		{
			/* Each column def can target multiple columns, as it is an array */
			aTargets = aoColumnDefs[i].aTargets;
			for ( j=0, jLen=aTargets.length ; j<jLen ; j++ )
			{
				if ( typeof aTargets[j] == 'number' && aTargets[j] >= 0 )
				{
					/* 0+ integer, left to right column counting. */
					this._fnColumnOptions( aTargets[j], aoColumnDefs[i] );
				}
				else if ( typeof aTargets[j] == 'number' && aTargets[j] < 0 )
				{
					/* Negative integer, right to left column counting */
					this._fnColumnOptions( this.s.dt.aoColumns.length+aTargets[j], aoColumnDefs[i] );
				}
				else if ( typeof aTargets[j] == 'string' )
				{
					/* Class name matching on TH element */
					for ( k=0, kLen=this.s.dt.aoColumns.length ; k<kLen ; k++ )
					{
						if ( aTargets[j] == "_all" ||
						     this.s.dt.aoColumns[k].nTh.className.indexOf( aTargets[j] ) != -1 )
						{
							this._fnColumnOptions( k, aoColumnDefs[i] );
						}
					}
				}
			}
		}
	},


	"_fnColumnsAll": function ( aoColumns )
	{
		for ( var i=0, iLen=this.s.dt.aoColumns.length ; i<iLen ; i++ )
		{
			this._fnColumnOptions( i, aoColumns[i] );
		}
	},


	"_fnAddColumn": function ( i )
	{
		this.s.columns[i] = {
			"enable": true,
			"read": this._fnReadCell,
			"write": this._fnWriteCell,
			"step": this._fnStep,
			"complete": null
		};
	},

	"_fnColumnOptions": function ( i, opts )
	{
		if ( typeof opts.bEnable != 'undefined' )
		{
			this.s.columns[i].enable = opts.bEnable;
		}

		if ( typeof opts.fnRead != 'undefined' )
		{
			this.s.columns[i].read = opts.fnRead;
		}

		if ( typeof opts.fnWrite != 'undefined' )
		{
			this.s.columns[i].write = opts.fnWrite;
		}

		if ( typeof opts.fnStep != 'undefined' )
		{
			this.s.columns[i].step = opts.fnStep;
		}

		if ( typeof opts.fnCallback != 'undefined' )
		{
			this.s.columns[i].complete = opts.fnCallback;
		}
	},


	/**
	 * Find out the coordinates of a given TD cell in a table
	 *  @method  _fnTargetCoords
	 *  @param   {Node} nTd
	 *  @returns {Object} x and y properties, for the position of the cell in the tables DOM
	 */
	"_fnTargetCoords": function ( nTd )
	{
		var nTr = $(nTd).parents('tr')[0];

		return {
			"x": $('td', nTr).index(nTd),
			"y": $('tr', nTr.parentNode).index(nTr)
		};
	},


	/**
	 * Display the border around one or more cells (from start to end)
	 *  @method  _fnUpdateBorder
	 *  @param   {Node} nStart Starting cell
	 *  @param   {Node} nEnd Ending cell
	 *  @returns void
	 */
	"_fnUpdateBorder": function ( nStart, nEnd )
	{
		var
			border = this.s.border.width,
			offsetStart = $(nStart).offset(),
			offsetEnd = $(nEnd).offset(),
			x1 = offsetStart.left - border,
			x2 = offsetEnd.left + $(nEnd).outerWidth(),
			y1 = offsetStart.top - border,
			y2 = offsetEnd.top + $(nEnd).outerHeight(),
			width = offsetEnd.left + $(nEnd).outerWidth() - offsetStart.left + (2*border),
			height = offsetEnd.top + $(nEnd).outerHeight() - offsetStart.top + (2*border),
			oStyle;

		if ( this.s.dt.oScroll.sY !== "" )
		{
			/* The border elements are inside the DT scroller - so position relative to that */
			var
				offsetScroll = $(this.s.dt.nTable.parentNode).offset(),
				scrollTop = $(this.s.dt.nTable.parentNode).scrollTop(),
				scrollLeft = $(this.s.dt.nTable.parentNode).scrollLeft();

			x1 -= offsetScroll.left - scrollLeft;
			x2 -= offsetScroll.left - scrollLeft;
			y1 -= offsetScroll.top - scrollTop;
			y2 -= offsetScroll.top - scrollTop;
		}

		/* Top */
		oStyle = this.dom.borderTop.style;
		oStyle.top = y1+"px";
		oStyle.left = x1+"px";
		oStyle.height = this.s.border.width+"px";
		oStyle.width = width+"px";

		/* Bottom */
		oStyle = this.dom.borderBottom.style;
		oStyle.top = y2+"px";
		oStyle.left = x1+"px";
		oStyle.height = this.s.border.width+"px";
		oStyle.width = width+"px";

		/* Left */
		oStyle = this.dom.borderLeft.style;
		oStyle.top = y1+"px";
		oStyle.left = x1+"px";
		oStyle.height = height+"px";
		oStyle.width = this.s.border.width+"px";

		/* Right */
		oStyle = this.dom.borderRight.style;
		oStyle.top = y1+"px";
		oStyle.left = x2+"px";
		oStyle.height = height+"px";
		oStyle.width = this.s.border.width+"px";
	},


	/**
	 * Mouse down event handler for starting a drag
	 *  @method  _fnFillerDragStart
	 *  @param   {Object} e Event object
	 *  @returns void
	 */
	"_fnFillerDragStart": function (e)
	{
		var that = this;
		var startingTd = this.dom.currentTarget;

		this.s.drag.dragging = true;

		that.dom.borderTop.style.display = "block";
		that.dom.borderRight.style.display = "block";
		that.dom.borderBottom.style.display = "block";
		that.dom.borderLeft.style.display = "block";

		var coords = this._fnTargetCoords( startingTd );
		this.s.drag.startX = coords.x;
		this.s.drag.startY = coords.y;

		this.s.drag.startTd = startingTd;
		this.s.drag.endTd = startingTd;

		this._fnUpdateBorder( startingTd, startingTd );

		$(document).bind('mousemove.AutoFill', function (e) {
			that._fnFillerDragMove.call( that, e );
		} );

		$(document).bind('mouseup.AutoFill', function (e) {
			that._fnFillerFinish.call( that, e );
		} );

		/* Scrolling information cache */
		this.s.screen.y = e.pageY;
		this.s.screen.height = $(window).height();
		this.s.screen.scrollTop = $(document).scrollTop();

		if ( this.s.dt.oScroll.sY !== "" )
		{
			this.s.scroller.top = $(this.s.dt.nTable.parentNode).offset().top;
			this.s.scroller.bottom = this.s.scroller.top + $(this.s.dt.nTable.parentNode).height();
		}

		/* Scrolling handler - we set an interval (which is cancelled on mouse up) which will fire
		 * regularly and see if we need to do any scrolling
		 */
		this.s.screen.interval = setInterval( function () {
			var iScrollTop = $(document).scrollTop();
			var iScrollDelta = iScrollTop - that.s.screen.scrollTop;
			that.s.screen.y += iScrollDelta;

			if ( that.s.screen.height - that.s.screen.y + iScrollTop < 50 )
			{
				$('html, body').animate( {
					"scrollTop": iScrollTop + 50
				}, 240, 'linear' );
			}
			else if ( that.s.screen.y - iScrollTop < 50 )
			{
				$('html, body').animate( {
					"scrollTop": iScrollTop - 50
				}, 240, 'linear' );
			}

			if ( that.s.dt.oScroll.sY !== "" )
			{
				if ( that.s.screen.y > that.s.scroller.bottom - 50 )
				{
					$(that.s.dt.nTable.parentNode).animate( {
						"scrollTop": $(that.s.dt.nTable.parentNode).scrollTop() + 50
					}, 240, 'linear' );
				}
				else if ( that.s.screen.y < that.s.scroller.top + 50 )
				{
					$(that.s.dt.nTable.parentNode).animate( {
						"scrollTop": $(that.s.dt.nTable.parentNode).scrollTop() - 50
					}, 240, 'linear' );
				}
			}
		}, 250 );
	},


	/**
	 * Mouse move event handler for during a move. See if we want to update the display based on the
	 * new cursor position
	 *  @method  _fnFillerDragMove
	 *  @param   {Object} e Event object
	 *  @returns void
	 */
	"_fnFillerDragMove": function (e)
	{
		if ( e.target && e.target.nodeName.toUpperCase() == "TD" &&
		 	e.target != this.s.drag.endTd )
		{
			var coords = this._fnTargetCoords( e.target );

			if ( coords.x != this.s.drag.startX )
			{
				e.target = $('tbody>tr:eq('+coords.y+')>td:eq('+this.s.drag.startX+')', this.dom.table)[0];
			 	coords = this._fnTargetCoords( e.target );
			}

			if ( coords.x == this.s.drag.startX )
			{
				var drag = this.s.drag;
				drag.endTd = e.target;

				if ( coords.y >= this.s.drag.startY )
				{
					this._fnUpdateBorder( drag.startTd, drag.endTd );
				}
				else
				{
					this._fnUpdateBorder( drag.endTd, drag.startTd );
				}
				this._fnFillerPosition( e.target );
			}
		}

		/* Update the screen information so we can perform scrolling */
		this.s.screen.y = e.pageY;
		this.s.screen.scrollTop = $(document).scrollTop();

		if ( this.s.dt.oScroll.sY !== "" )
		{
			this.s.scroller.scrollTop = $(this.s.dt.nTable.parentNode).scrollTop();
			this.s.scroller.top = $(this.s.dt.nTable.parentNode).offset().top;
			this.s.scroller.bottom = this.s.scroller.top + $(this.s.dt.nTable.parentNode).height();
		}
	},


	/**
	 * Mouse release handler - end the drag and take action to update the cells with the needed values
	 *  @method  _fnFillerFinish
	 *  @param   {Object} e Event object
	 *  @returns void
	 */
	"_fnFillerFinish": function (e)
	{
		var that = this;

		$(document).unbind('mousemove.AutoFill');
		$(document).unbind('mouseup.AutoFill');

		this.dom.borderTop.style.display = "none";
		this.dom.borderRight.style.display = "none";
		this.dom.borderBottom.style.display = "none";
		this.dom.borderLeft.style.display = "none";

		this.s.drag.dragging = false;

		clearInterval( this.s.screen.interval );

		var coordsStart = this._fnTargetCoords( this.s.drag.startTd );
		var coordsEnd = this._fnTargetCoords( this.s.drag.endTd );
		var aTds = [];
		var bIncrement;

		if ( coordsStart.y <= coordsEnd.y )
		{
			bIncrement = true;
			for ( i=coordsStart.y ; i<=coordsEnd.y ; i++ )
			{
				aTds.push( $('tbody>tr:eq('+i+')>td:eq('+coordsStart.x+')', this.dom.table)[0] );
			}
		}
		else
		{
			bIncrement = false;
			for ( i=coordsStart.y ; i>=coordsEnd.y ; i-- )
			{
				aTds.push( $('tbody>tr:eq('+i+')>td:eq('+coordsStart.x+')', this.dom.table)[0] );
			}
		}


		var iColumn = coordsStart.x;
		var bLast = false;
		var aoEdited = [];
		var sStart = this.s.columns[iColumn].read.call( this, this.s.drag.startTd );
		var oPrepped = this._fnPrep( sStart );

		for ( i=0, iLen=aTds.length ; i<iLen ; i++ )
		{
			if ( i==iLen-1 )
			{
				bLast = true;
			}

			var original = this.s.columns[iColumn].read.call( this, aTds[i] );
			var step = this.s.columns[iColumn].step.call( this, aTds[i], oPrepped, i, bIncrement,
				'SPRYMEDIA_AUTOFILL_STEPPER' );
			this.s.columns[iColumn].write.call( this, aTds[i], step, bLast );

			aoEdited.push( {
				"td": aTds[i],
				"newValue": step,
				"oldValue": original
			} );
		}

		if ( this.s.columns[iColumn].complete !== null )
		{
			this.s.columns[iColumn].complete.call( this, aoEdited );
		}
	},


	/**
	 * Chunk a string such that it can be filled in by the stepper function
	 *  @method  _fnPrep
	 *  @param   {String} sStr String to prep
	 *  @returns {Object} with parameters, iStart, sStr and sPostFix
	 */
	"_fnPrep": function ( sStr )
	{
		var aMatch = sStr.match(/[\d\.]+/g);
		if ( !aMatch || aMatch.length === 0 )
		{
			return {
				"iStart": 0,
				"sStr": sStr,
				"sPostFix": ""
			};
		}

		var sLast = aMatch[ aMatch.length-1 ];
		var num = parseInt(sLast, 10);
		var regex = new RegExp( '^(.*)'+sLast+'(.*?)$' );
		var decimal = sLast.match(/\./) ? "."+sLast.split('.')[1] : "";

		return {
			"iStart": num,
			"sStr": sStr.replace(regex, "$1SPRYMEDIA_AUTOFILL_STEPPER$2"),
			"sPostFix": decimal
		};
	},


	/**
	 * Render a string for it's position in the table after the drag (incrememt numbers)
	 *  @method  _fnStep
	 *  @param   {Node} nTd Cell being written to
	 *  @param   {Object} oPrepped Prepared object for the stepper (from _fnPrep)
	 *  @param   {Int} iDiff Step difference
	 *  @param   {Boolean} bIncrement Increment (true) or decriment (false)
	 *  @param   {String} sToken Token to replace
	 *  @returns {String} Rendered information
	 */
	"_fnStep": function ( nTd, oPrepped, iDiff, bIncrement, sToken )
	{
		var iReplace = bIncrement ? (oPrepped.iStart+iDiff) : (oPrepped.iStart-iDiff);
		if ( isNaN(iReplace) )
		{
			iReplace = "";
		}
		return oPrepped.sStr.replace( sToken, iReplace+oPrepped.sPostFix );
	},


	/**
	 * Read informaiton from a cell, possibly using live DOM elements if suitable
	 *  @method  _fnReadCell
	 *  @param   {Node} nTd Cell to read
	 *  @returns {String} Read value
	 */
	"_fnReadCell": function ( nTd )
	{
		var jq = $('input', nTd);
		if ( jq.length > 0 )
		{
			return $(jq).val();
		}

		jq = $('select', nTd);
		if ( jq.length > 0 )
		{
			return $(jq).val();
		}

		return nTd.innerHTML;
	},


	/**
	 * Write informaiton to a cell, possibly using live DOM elements if suitable
	 *  @method  _fnWriteCell
	 *  @param   {Node} nTd Cell to write
	 *  @param   {String} sVal Value to write
	 *  @param   {Boolean} bLast Flag to show if this is that last update
	 *  @returns void
	 */
	"_fnWriteCell": function ( nTd, sVal, bLast )
	{
		var jq = $('input', nTd);
		if ( jq.length > 0 )
		{
			$(jq).val( sVal );
			return;
		}

		jq = $('select', nTd);
		if ( jq.length > 0 )
		{
			$(jq).val( sVal );
			return;
		}

		var pos = this.s.dt.oInstance.fnGetPosition( nTd );
		this.s.dt.oInstance.fnUpdate( sVal, pos[0], pos[2], bLast );
	},


	/**
	 * Display the drag handle on mouse over cell
	 *  @method  _fnFillerDisplay
	 *  @param   {Object} e Event object
	 *  @returns void
	 */
	"_fnFillerDisplay": function (e)
	{
		/* Don't display automatically when dragging */
		if ( this.s.drag.dragging)
		{
			return;
		}

		/* Check that we are allowed to AutoFill this column or not */
		var nTd = (e.target.nodeName.toLowerCase() == 'td') ? e.target : $(e.target).parents('td')[0];
		var iX = this._fnTargetCoords(nTd).x;
		if ( !this.s.columns[iX].enable )
		{
			return;
		}

		var filler = this.dom.filler;
		if (e.type == 'mouseover')
		{
			this.dom.currentTarget = nTd;
			this._fnFillerPosition( nTd );

			filler.style.display = "block";
		}
		else if ( !e.relatedTarget || !e.relatedTarget.className.match(/AutoFill/) )
		{
			filler.style.display = "none";
		}
	},


	/**
	 * Position the filler icon over a cell
	 *  @method  _fnFillerPosition
	 *  @param   {Node} nTd Cell to position filler icon over
	 *  @returns void
	 */
	"_fnFillerPosition": function ( nTd )
	{
		var offset = $(nTd).offset();
		var filler = this.dom.filler;
		filler.style.top = (offset.top - (this.s.filler.height / 2)-1 + $(nTd).outerHeight())+"px";
		filler.style.left = (offset.left - (this.s.filler.width / 2)-1 + $(nTd).outerWidth())+"px";
	}
};




/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Constants
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Name of this class
 *  @constant CLASS
 *  @type     String
 *  @default  AutoFill
 */
AutoFill.prototype.CLASS = "AutoFill";


/**
 * AutoFill version
 *  @constant  VERSION
 *  @type      String
 *  @default   1.1.2
 */
AutoFill.VERSION = "1.1.2";
AutoFill.prototype.VERSION = AutoFill.VERSION;


})(jQuery);
=======
/* Global scope for AutoFill */
var AutoFill;(function(a){AutoFill=function(b,c){if(!this.CLASS||this.CLASS!="AutoFill"){alert("Warning: AutoFill must be initialised with the keyword 'new'");return}if(!a.fn.dataTableExt.fnVersionCheck("1.7.0")){alert("Warning: AutoFill requires DataTables 1.7 or greater - www.datatables.net/download");return}return this.s={filler:{height:0,width:0},border:{width:2},drag:{startX:-1,startY:-1,startTd:null,endTd:null,dragging:!1},screen:{interval:null,y:0,height:0,scrollTop:0},scroller:{top:0,bottom:0},columns:[]},this.dom={table:null,filler:null,borderTop:null,borderRight:null,borderBottom:null,borderLeft:null,currentTarget:null},this.fnSettings=function(){return this.s},this._fnInit(b,c),this},AutoFill.prototype={_fnInit:function(b,c){var d=this,e,f;this.s.dt=b.fnSettings(),this.dom.table=this.s.dt.nTable;for(e=0,f=this.s.dt.aoColumns.length;e<f;e++)this._fnAddColumn(e);typeof c!="undefined"&&typeof c.aoColumnDefs!="undefined"&&this._fnColumnDefs(c.aoColumnDefs),typeof c!="undefined"&&typeof c.aoColumns!="undefined"&&this._fnColumnsAll(c.aoColumns);var g=document.createElement("div");g.className="AutoFill_filler",document.body.appendChild(g),this.dom.filler=g,g.style.display="block",this.s.filler.height=a(g).height(),this.s.filler.width=a(g).width(),g.style.display="none";var h,i=document.body;d.s.dt.oScroll.sY!==""&&(d.s.dt.nTable.parentNode.style.position="relative",i=d.s.dt.nTable.parentNode),h=document.createElement("div"),h.className="AutoFill_border",i.appendChild(h),this.dom.borderTop=h,h=document.createElement("div"),h.className="AutoFill_border",i.appendChild(h),this.dom.borderRight=h,h=document.createElement("div"),h.className="AutoFill_border",i.appendChild(h),this.dom.borderBottom=h,h=document.createElement("div"),h.className="AutoFill_border",i.appendChild(h),this.dom.borderLeft=h,a(g).mousedown(function(a){return this.onselectstart=function(){return!1},d._fnFillerDragStart.call(d,a),!1}),a("tbody>tr>td",this.dom.table).live("mouseover mouseout",function(a){d._fnFillerDisplay.call(d,a)})},_fnColumnDefs:function(a){var b,c,d,e,f,g,h;for(b=a.length-1;b>=0;b--){h=a[b].aTargets;for(c=0,f=h.length;c<f;c++)if(typeof h[c]=="number"&&h[c]>=0)this._fnColumnOptions(h[c],a[b]);else if(typeof h[c]=="number"&&h[c]<0)this._fnColumnOptions(this.s.dt.aoColumns.length+h[c],a[b]);else if(typeof h[c]=="string")for(d=0,g=this.s.dt.aoColumns.length;d<g;d++)(h[c]=="_all"||this.s.dt.aoColumns[d].nTh.className.indexOf(h[c])!=-1)&&this._fnColumnOptions(d,a[b])}},_fnColumnsAll:function(a){for(var b=0,c=this.s.dt.aoColumns.length;b<c;b++)this._fnColumnOptions(b,a[b])},_fnAddColumn:function(a){this.s.columns[a]={enable:!0,read:this._fnReadCell,write:this._fnWriteCell,step:this._fnStep,complete:null}},_fnColumnOptions:function(a,b){typeof b.bEnable!="undefined"&&(this.s.columns[a].enable=b.bEnable),typeof b.fnRead!="undefined"&&(this.s.columns[a].read=b.fnRead),typeof b.fnWrite!="undefined"&&(this.s.columns[a].write=b.fnWrite),typeof b.fnStep!="undefined"&&(this.s.columns[a].step=b.fnStep),typeof b.fnCallback!="undefined"&&(this.s.columns[a].complete=b.fnCallback)},_fnTargetCoords:function(b){var c=a(b).parents("tr")[0];return{x:a("td",c).index(b),y:a("tr",c.parentNode).index(c)}},_fnUpdateBorder:function(b,c){var d=this.s.border.width,e=a(b).offset(),f=a(c).offset(),g=e.left-d,h=f.left+a(c).outerWidth(),i=e.top-d,j=f.top+a(c).outerHeight(),k=f.left+a(c).outerWidth()-e.left+2*d,l=f.top+a(c).outerHeight()-e.top+2*d,m;if(this.s.dt.oScroll.sY!==""){var n=a(this.s.dt.nTable.parentNode).offset(),o=a(this.s.dt.nTable.parentNode).scrollTop(),p=a(this.s.dt.nTable.parentNode).scrollLeft();g-=n.left-p,h-=n.left-p,i-=n.top-o,j-=n.top-o}m=this.dom.borderTop.style,m.top=i+"px",m.left=g+"px",m.height=this.s.border.width+"px",m.width=k+"px",m=this.dom.borderBottom.style,m.top=j+"px",m.left=g+"px",m.height=this.s.border.width+"px",m.width=k+"px",m=this.dom.borderLeft.style,m.top=i+"px",m.left=g+"px",m.height=l+"px",m.width=this.s.border.width+"px",m=this.dom.borderRight.style,m.top=i+"px",m.left=h+"px",m.height=l+"px",m.width=this.s.border.width+"px"},_fnFillerDragStart:function(b){var c=this,d=this.dom.currentTarget;this.s.drag.dragging=!0,c.dom.borderTop.style.display="block",c.dom.borderRight.style.display="block",c.dom.borderBottom.style.display="block",c.dom.borderLeft.style.display="block";var e=this._fnTargetCoords(d);this.s.drag.startX=e.x,this.s.drag.startY=e.y,this.s.drag.startTd=d,this.s.drag.endTd=d,this._fnUpdateBorder(d,d),a(document).bind("mousemove.AutoFill",function(a){c._fnFillerDragMove.call(c,a)}),a(document).bind("mouseup.AutoFill",function(a){c._fnFillerFinish.call(c,a)}),this.s.screen.y=b.pageY,this.s.screen.height=a(window).height(),this.s.screen.scrollTop=a(document).scrollTop(),this.s.dt.oScroll.sY!==""&&(this.s.scroller.top=a(this.s.dt.nTable.parentNode).offset().top,this.s.scroller.bottom=this.s.scroller.top+a(this.s.dt.nTable.parentNode).height()),this.s.screen.interval=setInterval(function(){var b=a(document).scrollTop(),d=b-c.s.screen.scrollTop;c.s.screen.y+=d,c.s.screen.height-c.s.screen.y+b<50?a("html, body").animate({scrollTop:b+50},240,"linear"):c.s.screen.y-b<50&&a("html, body").animate({scrollTop:b-50},240,"linear"),c.s.dt.oScroll.sY!==""&&(c.s.screen.y>c.s.scroller.bottom-50?a(c.s.dt.nTable.parentNode).animate({scrollTop:a(c.s.dt.nTable.parentNode).scrollTop()+50},240,"linear"):c.s.screen.y<c.s.scroller.top+50&&a(c.s.dt.nTable.parentNode).animate({scrollTop:a(c.s.dt.nTable.parentNode).scrollTop()-50},240,"linear"))},250)},_fnFillerDragMove:function(b){if(b.target&&b.target.nodeName.toUpperCase()=="TD"&&b.target!=this.s.drag.endTd){var c=this._fnTargetCoords(b.target);c.x!=this.s.drag.startX&&(b.target=a("tbody>tr:eq("+c.y+")>td:eq("+this.s.drag.startX+")",this.dom.table)[0],c=this._fnTargetCoords(b.target));if(c.x==this.s.drag.startX){var d=this.s.drag;d.endTd=b.target,c.y>=this.s.drag.startY?this._fnUpdateBorder(d.startTd,d.endTd):this._fnUpdateBorder(d.endTd,d.startTd),this._fnFillerPosition(b.target)}}this.s.screen.y=b.pageY,this.s.screen.scrollTop=a(document).scrollTop(),this.s.dt.oScroll.sY!==""&&(this.s.scroller.scrollTop=a(this.s.dt.nTable.parentNode).scrollTop(),this.s.scroller.top=a(this.s.dt.nTable.parentNode).offset().top,this.s.scroller.bottom=this.s.scroller.top+a(this.s.dt.nTable.parentNode).height())},_fnFillerFinish:function(b){var c=this;a(document).unbind("mousemove.AutoFill"),a(document).unbind("mouseup.AutoFill"),this.dom.borderTop.style.display="none",this.dom.borderRight.style.display="none",this.dom.borderBottom.style.display="none",this.dom.borderLeft.style.display="none",this.s.drag.dragging=!1,clearInterval(this.s.screen.interval);var d=this._fnTargetCoords(this.s.drag.startTd),e=this._fnTargetCoords(this.s.drag.endTd),f=[],g;if(d.y<=e.y){g=!0;for(i=d.y;i<=e.y;i++)f.push(a("tbody>tr:eq("+i+")>td:eq("+d.x+")",this.dom.table)[0])}else{g=!1;for(i=d.y;i>=e.y;i--)f.push(a("tbody>tr:eq("+i+")>td:eq("+d.x+")",this.dom.table)[0])}var h=d.x,j=!1,k=[],l=this.s.columns[h].read.call(this,this.s.drag.startTd),m=this._fnPrep(l);for(i=0,iLen=f.length;i<iLen;i++){i==iLen-1&&(j=!0);var n=this.s.columns[h].read.call(this,f[i]),o=this.s.columns[h].step.call(this,f[i],m,i,g,"SPRYMEDIA_AUTOFILL_STEPPER");this.s.columns[h].write.call(this,f[i],o,j),k.push({td:f[i],newValue:o,oldValue:n})}this.s.columns[h].complete!==null&&this.s.columns[h].complete.call(this,k)},_fnPrep:function(a){var b=a.match(/[\d\.]+/g);if(!b||b.length===0)return{iStart:0,sStr:a,sPostFix:""};var c=b[b.length-1],d=parseInt(c,10),e=new RegExp("^(.*)"+c+"(.*?)$"),f=c.match(/\./)?"."+c.split(".")[1]:"";return{iStart:d,sStr:a.replace(e,"$1SPRYMEDIA_AUTOFILL_STEPPER$2"),sPostFix:f}},_fnStep:function(a,b,c,d,e){var f=d?b.iStart+c:b.iStart-c;return isNaN(f)&&(f=""),b.sStr.replace(e,f+b.sPostFix)},_fnReadCell:function(b){var c=a("input",b);return c.length>0?a(c).val():(c=a("select",b),c.length>0?a(c).val():b.innerHTML)},_fnWriteCell:function(b,c,d){var e=a("input",b);if(e.length>0){a(e).val(c);return}e=a("select",b);if(e.length>0){a(e).val(c);return}var f=this.s.dt.oInstance.fnGetPosition(b);this.s.dt.oInstance.fnUpdate(c,f[0],f[2],d)},_fnFillerDisplay:function(b){if(this.s.drag.dragging)return;var c=b.target.nodeName.toLowerCase()=="td"?b.target:a(b.target).parents("td")[0],d=this._fnTargetCoords(c).x;if(!this.s.columns[d].enable)return;var e=this.dom.filler;if(b.type=="mouseover")this.dom.currentTarget=c,this._fnFillerPosition(c),e.style.display="block";else if(!b.relatedTarget||!b.relatedTarget.className.match(/AutoFill/))e.style.display="none"},_fnFillerPosition:function(b){var c=a(b).offset(),d=this.dom.filler;d.style.top=c.top-this.s.filler.height/2-1+a(b).outerHeight()+"px",d.style.left=c.left-this.s.filler.width/2-1+a(b).outerWidth()+"px"}},AutoFill.prototype.CLASS="AutoFill",AutoFill.VERSION="1.1.2",AutoFill.prototype.VERSION=AutoFill.VERSION})(jQuery);
>>>>>>> hsa
