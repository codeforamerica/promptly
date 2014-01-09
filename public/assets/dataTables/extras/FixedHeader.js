/*
 * File:        FixedHeader.js
 * Version:     2.0.6
 * Description: "Fix" a header at the top of the table, so it scrolls with the table
 * Author:      Allan Jardine (www.sprymedia.co.uk)
 * Created:     Wed 16 Sep 2009 19:46:30 BST
 * Language:    Javascript
 * License:     GPL v2 or BSD 3 point style
 * Project:     Just a little bit of fun - enjoy :-)
 * Contact:     www.sprymedia.co.uk/contact
 *
 * Copyright 2009-2012 Allan Jardine, all rights reserved.
 *
 * This source file is free software, under either the GPL v2 license or a
 * BSD style license, available at:
 *   http://datatables.net/license_gpl2
 *   http://datatables.net/license_bsd
 */
<<<<<<< HEAD

=======
>>>>>>> hsa
/*
 * Function: FixedHeader
 * Purpose:  Provide 'fixed' header, footer and columns on an HTML table
 * Returns:  object:FixedHeader - must be called with 'new'
 * Inputs:   mixed:mTable - target table
 *					   1. DataTable object - when using FixedHeader with DataTables, or
 *					   2. HTML table node - when using FixedHeader without DataTables
 *           object:oInit - initialisation settings, with the following properties (each optional)
 *             bool:top -    fix the header (default true)
 *             bool:bottom - fix the footer (default false)
 *             bool:left -   fix the left most column (default false)
 *             bool:right -  fix the right most column (default false)
 *             int:zTop -    fixed header zIndex
 *             int:zBottom - fixed footer zIndex
 *             int:zLeft -   fixed left zIndex
 *             int:zRight -  fixed right zIndex
 */
<<<<<<< HEAD

var FixedHeader = function ( mTable, oInit ) {
	/* Sanity check - you just know it will happen */
	if ( typeof this.fnInit != 'function' )
	{
		alert( "FixedHeader warning: FixedHeader must be initialised with the 'new' keyword." );
		return;
	}

	var that = this;
	var oSettings = {
		"aoCache": [],
		"oSides": {
			"top": true,
			"bottom": false,
			"left": false,
			"right": false
		},
		"oZIndexes": {
			"top": 104,
			"bottom": 103,
			"left": 102,
			"right": 101
		},
		"oMes": {
			"iTableWidth": 0,
			"iTableHeight": 0,
			"iTableLeft": 0,
			"iTableRight": 0, /* note this is left+width, not actually "right" */
			"iTableTop": 0,
			"iTableBottom": 0 /* note this is top+height, not actually "bottom" */
		},
		"oOffset": {
			"top": 0
		},
		"nTable": null,
		"bUseAbsPos": false,
		"bFooter": false
	};

	/*
	 * Function: fnGetSettings
	 * Purpose:  Get the settings for this object
	 * Returns:  object: - settings object
	 * Inputs:   -
	 */
	this.fnGetSettings = function () {
		return oSettings;
	};

	/*
	 * Function: fnUpdate
	 * Purpose:  Update the positioning and copies of the fixed elements
	 * Returns:  -
	 * Inputs:   -
	 */
	this.fnUpdate = function () {
		this._fnUpdateClones();
		this._fnUpdatePositions();
	};

	/*
	 * Function: fnPosition
	 * Purpose:  Update the positioning of the fixed elements
	 * Returns:  -
	 * Inputs:   -
	 */
	this.fnPosition = function () {
		this._fnUpdatePositions();
	};

	/* Let's do it */
	this.fnInit( mTable, oInit );

	/* Store the instance on the DataTables object for easy access */
	if ( typeof mTable.fnSettings == 'function' )
	{
		mTable._oPluginFixedHeader = this;
	}
};


/*
 * Variable: FixedHeader
 * Purpose:  Prototype for FixedHeader
 * Scope:    global
 */
FixedHeader.prototype = {
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Initialisation
	 */

	/*
	 * Function: fnInit
	 * Purpose:  The "constructor"
	 * Returns:  -
	 * Inputs:   {as FixedHeader function}
	 */
	fnInit: function ( oTable, oInit )
	{
		var s = this.fnGetSettings();
		var that = this;

		/* Record the user definable settings */
		this.fnInitSettings( s, oInit );

		/* DataTables specific stuff */
		if ( typeof oTable.fnSettings == 'function' )
		{
			if ( typeof oTable.fnVersionCheck == 'functon' &&
			     oTable.fnVersionCheck( '1.6.0' ) !== true )
			{
				alert( "FixedHeader 2 required DataTables 1.6.0 or later. "+
					"Please upgrade your DataTables installation" );
				return;
			}

			var oDtSettings = oTable.fnSettings();

			if ( oDtSettings.oScroll.sX != "" || oDtSettings.oScroll.sY != "" )
			{
				alert( "FixedHeader 2 is not supported with DataTables' scrolling mode at this time" );
				return;
			}

			s.nTable = oDtSettings.nTable;
			oDtSettings.aoDrawCallback.push( {
				"fn": function () {
					FixedHeader.fnMeasure();
					that._fnUpdateClones.call(that);
					that._fnUpdatePositions.call(that);
				},
				"sName": "FixedHeader"
			} );
		}
		else
		{
			s.nTable = oTable;
		}

		s.bFooter = ($('>tfoot', s.nTable).length > 0) ? true : false;

		/* "Detect" browsers that don't support absolute positioing - or have bugs */
		s.bUseAbsPos = (jQuery.browser.msie && (jQuery.browser.version=="6.0"||jQuery.browser.version=="7.0"));

		/* Add the 'sides' that are fixed */
		if ( s.oSides.top )
		{
			s.aoCache.push( that._fnCloneTable( "fixedHeader", "FixedHeader_Header", that._fnCloneThead ) );
		}
		if ( s.oSides.bottom )
		{
			s.aoCache.push( that._fnCloneTable( "fixedFooter", "FixedHeader_Footer", that._fnCloneTfoot ) );
		}
		if ( s.oSides.left )
		{
			s.aoCache.push( that._fnCloneTable( "fixedLeft", "FixedHeader_Left", that._fnCloneTLeft ) );
		}
		if ( s.oSides.right )
		{
			s.aoCache.push( that._fnCloneTable( "fixedRight", "FixedHeader_Right", that._fnCloneTRight ) );
		}

		/* Event listeners for window movement */
		FixedHeader.afnScroll.push( function () {
			that._fnUpdatePositions.call(that);
		} );

		jQuery(window).resize( function () {
			FixedHeader.fnMeasure();
			that._fnUpdateClones.call(that);
			that._fnUpdatePositions.call(that);
		} );

		/* Get things right to start with */
		FixedHeader.fnMeasure();
		that._fnUpdateClones();
		that._fnUpdatePositions();
	},


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Support functions
	 */

	/*
	 * Function: fnInitSettings
	 * Purpose:  Take the user's settings and copy them to our local store
	 * Returns:  -
	 * Inputs:   object:s - the local settings object
	 *           object:oInit - the user's settings object
	 */
	fnInitSettings: function ( s, oInit )
	{
		if ( typeof oInit != 'undefined' )
		{
			if ( typeof oInit.top != 'undefined' ) {
				s.oSides.top = oInit.top;
			}
			if ( typeof oInit.bottom != 'undefined' ) {
				s.oSides.bottom = oInit.bottom;
			}
			if ( typeof oInit.left != 'undefined' ) {
				s.oSides.left = oInit.left;
			}
			if ( typeof oInit.right != 'undefined' ) {
				s.oSides.right = oInit.right;
			}

			if ( typeof oInit.zTop != 'undefined' ) {
				s.oZIndexes.top = oInit.zTop;
			}
			if ( typeof oInit.zBottom != 'undefined' ) {
				s.oZIndexes.bottom = oInit.zBottom;
			}
			if ( typeof oInit.zLeft != 'undefined' ) {
				s.oZIndexes.left = oInit.zLeft;
			}
			if ( typeof oInit.zRight != 'undefined' ) {
				s.oZIndexes.right = oInit.zRight;
			}

			if ( typeof oInit.offsetTop != 'undefined' ) {
				s.oOffset.top = oInit.offsetTop;
			}
		}

		/* Detect browsers which have poor position:fixed support so we can use absolute positions.
		 * This is much slower since the position must be updated for each scroll, but widens
		 * compatibility
		 */
		s.bUseAbsPos = (jQuery.browser.msie &&
			(jQuery.browser.version=="6.0"||jQuery.browser.version=="7.0"));
	},

	/*
	 * Function: _fnCloneTable
	 * Purpose:  Clone the table node and do basic initialisation
	 * Returns:  -
	 * Inputs:   -
	 */
	_fnCloneTable: function ( sType, sClass, fnClone )
	{
		var s = this.fnGetSettings();
		var nCTable;

		/* We know that the table _MUST_ has a DIV wrapped around it, because this is simply how
		 * DataTables works. Therefore, we can set this to be relatively position (if it is not
		 * alreadu absolute, and use this as the base point for the cloned header
		 */
		if ( jQuery(s.nTable.parentNode).css('position') != "absolute" )
		{
			s.nTable.parentNode.style.position = "relative";
		}

		/* Just a shallow clone will do - we only want the table node */
		nCTable = s.nTable.cloneNode( false );
		nCTable.removeAttribute( 'id' );

		var nDiv = document.createElement( 'div' );
		nDiv.style.position = "absolute";
		nDiv.style.top = "0px";
		nDiv.style.left = "0px";
		nDiv.className += " FixedHeader_Cloned "+sType+" "+sClass;

		/* Set the zIndexes */
		if ( sType == "fixedHeader" )
		{
			nDiv.style.zIndex = s.oZIndexes.top;
		}
		if ( sType == "fixedFooter" )
		{
			nDiv.style.zIndex = s.oZIndexes.bottom;
		}
		if ( sType == "fixedLeft" )
		{
			nDiv.style.zIndex = s.oZIndexes.left;
		}
		else if ( sType == "fixedRight" )
		{
			nDiv.style.zIndex = s.oZIndexes.right;
		}

		/* remove margins since we are going to poistion it absolutely */
		nCTable.style.margin = "0";

		/* Insert the newly cloned table into the DOM, on top of the "real" header */
		nDiv.appendChild( nCTable );
		document.body.appendChild( nDiv );

		return {
			"nNode": nCTable,
			"nWrapper": nDiv,
			"sType": sType,
			"sPosition": "",
			"sTop": "",
			"sLeft": "",
			"fnClone": fnClone
		};
	},

	/*
	 * Function: _fnUpdatePositions
	 * Purpose:  Get the current positioning of the table in the DOM
	 * Returns:  -
	 * Inputs:   -
	 */
	_fnMeasure: function ()
	{
		var
			s = this.fnGetSettings(),
			m = s.oMes,
			jqTable = jQuery(s.nTable),
			oOffset = jqTable.offset(),
			iParentScrollTop = this._fnSumScroll( s.nTable.parentNode, 'scrollTop' ),
			iParentScrollLeft = this._fnSumScroll( s.nTable.parentNode, 'scrollLeft' );

		m.iTableWidth = jqTable.outerWidth();
		m.iTableHeight = jqTable.outerHeight();
		m.iTableLeft = oOffset.left + s.nTable.parentNode.scrollLeft;
		m.iTableTop = oOffset.top + iParentScrollTop;
		m.iTableRight = m.iTableLeft + m.iTableWidth;
		m.iTableRight = FixedHeader.oDoc.iWidth - m.iTableLeft - m.iTableWidth;
		m.iTableBottom = FixedHeader.oDoc.iHeight - m.iTableTop - m.iTableHeight;
	},

	/*
	 * Function: _fnSumScroll
	 * Purpose:  Sum node parameters all the way to the top
	 * Returns:  int: sum
	 * Inputs:   node:n - node to consider
	 *           string:side - scrollTop or scrollLeft
	 */
	_fnSumScroll: function ( n, side )
	{
		var i = n[side];
		while ( n = n.parentNode )
		{
			if ( n.nodeName == 'HTML' || n.nodeName == 'BODY' )
			{
				break;
			}
			i = n[side];
		}
		return i;
	},

	/*
	 * Function: _fnUpdatePositions
	 * Purpose:  Loop over the fixed elements for this table and update their positions
	 * Returns:  -
	 * Inputs:   -
	 */
	_fnUpdatePositions: function ()
	{
		var s = this.fnGetSettings();
		this._fnMeasure();

		for ( var i=0, iLen=s.aoCache.length ; i<iLen ; i++ )
		{
			if ( s.aoCache[i].sType == "fixedHeader" )
			{
				this._fnScrollFixedHeader( s.aoCache[i] );
			}
			else if ( s.aoCache[i].sType == "fixedFooter" )
			{
				this._fnScrollFixedFooter( s.aoCache[i] );
			}
			else if ( s.aoCache[i].sType == "fixedLeft" )
			{
				this._fnScrollHorizontalLeft( s.aoCache[i] );
			}
			else
			{
				this._fnScrollHorizontalRight( s.aoCache[i] );
			}
		}
	},

	/*
	 * Function: _fnUpdateClones
	 * Purpose:  Loop over the fixed elements for this table and call their cloning functions
	 * Returns:  -
	 * Inputs:   -
	 */
	_fnUpdateClones: function ()
	{
		var s = this.fnGetSettings();
		for ( var i=0, iLen=s.aoCache.length ; i<iLen ; i++ )
		{
			s.aoCache[i].fnClone.call( this, s.aoCache[i] );
		}
	},


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Scrolling functions
	 */

	/*
	 * Function: _fnScrollHorizontalLeft
	 * Purpose:  Update the positioning of the scrolling elements
	 * Returns:  -
	 * Inputs:   object:oCache - the cahced values for this fixed element
	 */
	_fnScrollHorizontalRight: function ( oCache )
	{
		var
			s = this.fnGetSettings(),
			oMes = s.oMes,
			oWin = FixedHeader.oWin,
			oDoc = FixedHeader.oDoc,
			nTable = oCache.nWrapper,
			iFixedWidth = jQuery(nTable).outerWidth();

		if ( oWin.iScrollRight < oMes.iTableRight )
		{
			/* Fully right aligned */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', (oMes.iTableLeft+oMes.iTableWidth-iFixedWidth)+"px", 'left', nTable.style );
		}
		else if ( oMes.iTableLeft < oDoc.iWidth-oWin.iScrollRight-iFixedWidth )
		{
			/* Middle */
			if ( s.bUseAbsPos )
			{
				this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
				this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
				this._fnUpdateCache( oCache, 'sLeft', (oDoc.iWidth-oWin.iScrollRight-iFixedWidth)+"px", 'left', nTable.style );
			}
			else
			{
				this._fnUpdateCache( oCache, 'sPosition', 'fixed', 'position', nTable.style );
				this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop-oWin.iScrollTop)+"px", 'top', nTable.style );
				this._fnUpdateCache( oCache, 'sLeft', (oWin.iWidth-iFixedWidth)+"px", 'left', nTable.style );
			}
		}
		else
		{
			/* Fully left aligned */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
	},

	/*
	 * Function: _fnScrollHorizontalLeft
	 * Purpose:  Update the positioning of the scrolling elements
	 * Returns:  -
	 * Inputs:   object:oCache - the cahced values for this fixed element
	 */
	_fnScrollHorizontalLeft: function ( oCache )
	{
		var
			s = this.fnGetSettings(),
			oMes = s.oMes,
			oWin = FixedHeader.oWin,
			oDoc = FixedHeader.oDoc,
			nTable = oCache.nWrapper,
			iCellWidth = jQuery(nTable).outerWidth();

		if ( oWin.iScrollLeft < oMes.iTableLeft )
		{
			/* Fully left align */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
		else if ( oWin.iScrollLeft < oMes.iTableLeft+oMes.iTableWidth-iCellWidth )
		{
			/* Middle */
			if ( s.bUseAbsPos )
			{
				this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
				this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
				this._fnUpdateCache( oCache, 'sLeft', oWin.iScrollLeft+"px", 'left', nTable.style );
			}
			else
			{
				this._fnUpdateCache( oCache, 'sPosition', 'fixed', 'position', nTable.style );
				this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop-oWin.iScrollTop)+"px", 'top', nTable.style );
				this._fnUpdateCache( oCache, 'sLeft', "0px", 'left', nTable.style );
			}
		}
		else
		{
			/* Fully right align */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', (oMes.iTableLeft+oMes.iTableWidth-iCellWidth)+"px", 'left', nTable.style );
		}
	},

	/*
	 * Function: _fnScrollFixedFooter
	 * Purpose:  Update the positioning of the scrolling elements
	 * Returns:  -
	 * Inputs:   object:oCache - the cahced values for this fixed element
	 */
	_fnScrollFixedFooter: function ( oCache )
	{
		var
			s = this.fnGetSettings(),
			oMes = s.oMes,
			oWin = FixedHeader.oWin,
			oDoc = FixedHeader.oDoc,
			nTable = oCache.nWrapper,
			iTheadHeight = jQuery("thead", s.nTable).outerHeight(),
			iCellHeight = jQuery(nTable).outerHeight();

		if ( oWin.iScrollBottom < oMes.iTableBottom )
		{
			/* Below */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop+oMes.iTableHeight-iCellHeight)+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
		else if ( oWin.iScrollBottom < oMes.iTableBottom+oMes.iTableHeight-iCellHeight-iTheadHeight )
		{
			/* Middle */
			if ( s.bUseAbsPos )
			{
				this._fnUpdateCache( oCache, 'sPosition', "absolute", 'position', nTable.style );
				this._fnUpdateCache( oCache, 'sTop', (oDoc.iHeight-oWin.iScrollBottom-iCellHeight)+"px", 'top', nTable.style );
				this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
			}
			else
			{
				this._fnUpdateCache( oCache, 'sPosition', 'fixed', 'position', nTable.style );
				this._fnUpdateCache( oCache, 'sTop', (oWin.iHeight-iCellHeight)+"px", 'top', nTable.style );
				this._fnUpdateCache( oCache, 'sLeft', (oMes.iTableLeft-oWin.iScrollLeft)+"px", 'left', nTable.style );
			}
		}
		else
		{
			/* Above */
			this._fnUpdateCache( oCache, 'sPosition', 'absolute', 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop+iCellHeight)+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
	},

	/*
	 * Function: _fnScrollFixedHeader
	 * Purpose:  Update the positioning of the scrolling elements
	 * Returns:  -
	 * Inputs:   object:oCache - the cahced values for this fixed element
	 */
	_fnScrollFixedHeader: function ( oCache )
	{
		var
			s = this.fnGetSettings(),
			oMes = s.oMes,
			oWin = FixedHeader.oWin,
			oDoc = FixedHeader.oDoc,
			nTable = oCache.nWrapper,
			iTbodyHeight = 0,
			anTbodies = s.nTable.getElementsByTagName('tbody');

		for (var i = 0; i < anTbodies.length; ++i) {
			iTbodyHeight += anTbodies[i].offsetHeight;
		}

		if ( oMes.iTableTop > oWin.iScrollTop + s.oOffset.top )
		{
			/* Above the table */
			this._fnUpdateCache( oCache, 'sPosition', "absolute", 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', oMes.iTableTop+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
		else if ( oWin.iScrollTop + s.oOffset.top > oMes.iTableTop+iTbodyHeight )
		{
			/* At the bottom of the table */
			this._fnUpdateCache( oCache, 'sPosition', "absolute", 'position', nTable.style );
			this._fnUpdateCache( oCache, 'sTop', (oMes.iTableTop+iTbodyHeight)+"px", 'top', nTable.style );
			this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
		}
		else
		{
			/* In the middle of the table */
			if ( s.bUseAbsPos )
			{
				this._fnUpdateCache( oCache, 'sPosition', "absolute", 'position', nTable.style );
				this._fnUpdateCache( oCache, 'sTop', oWin.iScrollTop+"px", 'top', nTable.style );
				this._fnUpdateCache( oCache, 'sLeft', oMes.iTableLeft+"px", 'left', nTable.style );
			}
			else
			{
				this._fnUpdateCache( oCache, 'sPosition', 'fixed', 'position', nTable.style );
				this._fnUpdateCache( oCache, 'sTop', s.oOffset.top+"px", 'top', nTable.style );
				this._fnUpdateCache( oCache, 'sLeft', (oMes.iTableLeft-oWin.iScrollLeft)+"px", 'left', nTable.style );
			}
		}
	},

	/*
	 * Function: _fnUpdateCache
	 * Purpose:  Check the cache and update cache and value if needed
	 * Returns:  -
	 * Inputs:   object:oCache - local cache object
	 *           string:sCache - cache property
	 *           string:sSet - value to set
	 *           string:sProperty - object property to set
	 *           object:oObj - object to update
	 */
	_fnUpdateCache: function ( oCache, sCache, sSet, sProperty, oObj )
	{
		if ( oCache[sCache] != sSet )
		{
			oObj[sProperty] = sSet;
			oCache[sCache] = sSet;
		}
	},



	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Cloning functions
	 */

	/*
	 * Function: _fnCloneThead
	 * Purpose:  Clone the thead element
	 * Returns:  -
	 * Inputs:   object:oCache - the cahced values for this fixed element
	 */
	_fnCloneThead: function ( oCache )
	{
		var s = this.fnGetSettings();
		var nTable = oCache.nNode;

		/* Set the wrapper width to match that of the cloned table */
		oCache.nWrapper.style.width = jQuery(s.nTable).outerWidth()+"px";

		/* Remove any children the cloned table has */
		while ( nTable.childNodes.length > 0 )
		{
			jQuery('thead th', nTable).unbind( 'click' );
			nTable.removeChild( nTable.childNodes[0] );
		}

		/* Clone the DataTables header */
		var nThead = jQuery('thead', s.nTable).clone(true)[0];
		nTable.appendChild( nThead );

		/* Copy the widths across - apparently a clone isn't good enough for this */
		jQuery("thead>tr th", s.nTable).each( function (i) {
			jQuery("thead>tr th:eq("+i+")", nTable).width( jQuery(this).width() );
		} );

		jQuery("thead>tr td", s.nTable).each( function (i) {
			jQuery("thead>tr td:eq("+i+")", nTable).width( jQuery(this).width() );
		} );
	},

	/*
	 * Function: _fnCloneTfoot
	 * Purpose:  Clone the tfoot element
	 * Returns:  -
	 * Inputs:   object:oCache - the cahced values for this fixed element
	 */
	_fnCloneTfoot: function ( oCache )
	{
		var s = this.fnGetSettings();
		var nTable = oCache.nNode;

		/* Set the wrapper width to match that of the cloned table */
		oCache.nWrapper.style.width = jQuery(s.nTable).outerWidth()+"px";

		/* Remove any children the cloned table has */
		while ( nTable.childNodes.length > 0 )
		{
			nTable.removeChild( nTable.childNodes[0] );
		}

		/* Clone the DataTables footer */
		var nTfoot = jQuery('tfoot', s.nTable).clone(true)[0];
		nTable.appendChild( nTfoot );

		/* Copy the widths across - apparently a clone isn't good enough for this */
		jQuery("tfoot:eq(0)>tr th", s.nTable).each( function (i) {
			jQuery("tfoot:eq(0)>tr th:eq("+i+")", nTable).width( jQuery(this).width() );
		} );

		jQuery("tfoot:eq(0)>tr td", s.nTable).each( function (i) {
			jQuery("tfoot:eq(0)>tr th:eq("+i+")", nTable)[0].style.width( jQuery(this).width() );
		} );
	},

	/*
	 * Function: _fnCloneTLeft
	 * Purpose:  Clone the left column
	 * Returns:  -
	 * Inputs:   object:oCache - the cached values for this fixed element
	 */
	_fnCloneTLeft: function ( oCache )
	{
		var s = this.fnGetSettings();
		var nTable = oCache.nNode;
		var nBody = $('tbody', s.nTable)[0];
		var iCols = $('tbody tr:eq(0) td', s.nTable).length;
		var bRubbishOldIE = ($.browser.msie && ($.browser.version == "6.0" || $.browser.version == "7.0"));

		/* Remove any children the cloned table has */
		while ( nTable.childNodes.length > 0 )
		{
			nTable.removeChild( nTable.childNodes[0] );
		}

		/* Is this the most efficient way to do this - it looks horrible... */
		nTable.appendChild( jQuery("thead", s.nTable).clone(true)[0] );
		nTable.appendChild( jQuery("tbody", s.nTable).clone(true)[0] );
		if ( s.bFooter )
		{
			nTable.appendChild( jQuery("tfoot", s.nTable).clone(true)[0] );
		}

		/* Remove unneeded cells */
		$('thead tr', nTable).each( function (k) {
			$('th:gt(0)', this).remove();
		} );

		$('tfoot tr', nTable).each( function (k) {
			$('th:gt(0)', this).remove();
		} );

		$('tbody tr', nTable).each( function (k) {
			$('td:gt(0)', this).remove();
		} );

		this.fnEqualiseHeights( 'tbody', nBody.parentNode, nTable );

		var iWidth = jQuery('thead tr th:eq(0)', s.nTable).outerWidth();
		nTable.style.width = iWidth+"px";
		oCache.nWrapper.style.width = iWidth+"px";
	},

	/*
	 * Function: _fnCloneTRight
	 * Purpose:  Clone the right most colun
	 * Returns:  -
	 * Inputs:   object:oCache - the cahced values for this fixed element
	 */
	_fnCloneTRight: function ( oCache )
	{
		var s = this.fnGetSettings();
		var nBody = $('tbody', s.nTable)[0];
		var nTable = oCache.nNode;
		var iCols = jQuery('tbody tr:eq(0) td', s.nTable).length;
		var bRubbishOldIE = ($.browser.msie && ($.browser.version == "6.0" || $.browser.version == "7.0"));

		/* Remove any children the cloned table has */
		while ( nTable.childNodes.length > 0 )
		{
			nTable.removeChild( nTable.childNodes[0] );
		}

		/* Is this the most efficient way to do this - it looks horrible... */
		nTable.appendChild( jQuery("thead", s.nTable).clone(true)[0] );
		nTable.appendChild( jQuery("tbody", s.nTable).clone(true)[0] );
		if ( s.bFooter )
		{
			nTable.appendChild( jQuery("tfoot", s.nTable).clone(true)[0] );
		}
		jQuery('thead tr th:not(:nth-child('+iCols+'n))', nTable).remove();
		jQuery('tfoot tr th:not(:nth-child('+iCols+'n))', nTable).remove();

		/* Remove unneeded cells */
		$('tbody tr', nTable).each( function (k) {
			$('td:lt('+(iCols-1)+')', this).remove();
		} );

		this.fnEqualiseHeights( 'tbody', nBody.parentNode, nTable );

		var iWidth = jQuery('thead tr th:eq('+(iCols-1)+')', s.nTable).outerWidth();
		nTable.style.width = iWidth+"px";
		oCache.nWrapper.style.width = iWidth+"px";
	},


	/**
	 * Equalise the heights of the rows in a given table node in a cross browser way. Note that this
	 * is more or less lifted as is from FixedColumns
	 *  @method  fnEqualiseHeights
	 *  @returns void
	 *  @param   {string} parent Node type - thead, tbody or tfoot
	 *  @param   {element} original Original node to take the heights from
	 *  @param   {element} clone Copy the heights to
	 *  @private
	 */
	"fnEqualiseHeights": function ( parent, original, clone )
	{
		var that = this,
			jqBoxHack = $(parent+' tr:eq(0)', original).children(':eq(0)'),
			iBoxHack = jqBoxHack.outerHeight() - jqBoxHack.height(),
			bRubbishOldIE = ($.browser.msie && ($.browser.version == "6.0" || $.browser.version == "7.0"));

		/* Remove cells which are not needed and copy the height from the original table */
		$(parent+' tr', clone).each( function (k) {
			/* Can we use some kind of object detection here?! This is very nasty - damn browsers */
			if ( $.browser.mozilla || $.browser.opera )
			{
				$(this).children().height( $(parent+' tr:eq('+k+')', original).outerHeight() );
			}
			else
			{
				$(this).children().height( $(parent+' tr:eq('+k+')', original).outerHeight() - iBoxHack );
			}

			if ( !bRubbishOldIE )
			{
				$(parent+' tr:eq('+k+')', original).height( $(parent+' tr:eq('+k+')', original).outerHeight() );
			}
		} );
	}
};


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Static properties and methods
 *   We use these for speed! This information is common to all instances of FixedHeader, so no
 * point if having them calculated and stored for each different instance.
 */

/*
 * Variable: oWin
 * Purpose:  Store information about the window positioning
 * Scope:    FixedHeader
 */
FixedHeader.oWin = {
	"iScrollTop": 0,
	"iScrollRight": 0,
	"iScrollBottom": 0,
	"iScrollLeft": 0,
	"iHeight": 0,
	"iWidth": 0
};

/*
 * Variable: oDoc
 * Purpose:  Store information about the document size
 * Scope:    FixedHeader
 */
FixedHeader.oDoc = {
	"iHeight": 0,
	"iWidth": 0
};

/*
 * Variable: afnScroll
 * Purpose:  Array of functions that are to be used for the scrolling components
 * Scope:    FixedHeader
 */
FixedHeader.afnScroll = [];

/*
 * Function: fnMeasure
 * Purpose:  Update the measurements for the window and document
 * Returns:  -
 * Inputs:   -
 */
FixedHeader.fnMeasure = function ()
{
	var
		jqWin = jQuery(window),
		jqDoc = jQuery(document),
		oWin = FixedHeader.oWin,
		oDoc = FixedHeader.oDoc;

	oDoc.iHeight = jqDoc.height();
	oDoc.iWidth = jqDoc.width();

	oWin.iHeight = jqWin.height();
	oWin.iWidth = jqWin.width();
	oWin.iScrollTop = jqWin.scrollTop();
	oWin.iScrollLeft = jqWin.scrollLeft();
	oWin.iScrollRight = oDoc.iWidth - oWin.iScrollLeft - oWin.iWidth;
	oWin.iScrollBottom = oDoc.iHeight - oWin.iScrollTop - oWin.iHeight;
};


FixedHeader.VERSION = "2.0.6";
FixedHeader.prototype.VERSION = FixedHeader.VERSION;


/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Global processing
 */

/*
 * Just one 'scroll' event handler in FixedHeader, which calls the required components. This is
 * done as an optimisation, to reduce calculation and proagation time
 */
jQuery(window).scroll( function () {
	FixedHeader.fnMeasure();
	for ( var i=0, iLen=FixedHeader.afnScroll.length ; i<iLen ; i++ )
	{
		FixedHeader.afnScroll[i]();
	}
} );
=======
var FixedHeader=function(a,b){if(typeof this.fnInit!="function"){alert("FixedHeader warning: FixedHeader must be initialised with the 'new' keyword.");return}var c=this,d={aoCache:[],oSides:{top:!0,bottom:!1,left:!1,right:!1},oZIndexes:{top:104,bottom:103,left:102,right:101},oMes:{iTableWidth:0,iTableHeight:0,iTableLeft:0,iTableRight:0,iTableTop:0,iTableBottom:0},oOffset:{top:0},nTable:null,bUseAbsPos:!1,bFooter:!1};this.fnGetSettings=function(){return d},this.fnUpdate=function(){this._fnUpdateClones(),this._fnUpdatePositions()},this.fnPosition=function(){this._fnUpdatePositions()},this.fnInit(a,b),typeof a.fnSettings=="function"&&(a._oPluginFixedHeader=this)};FixedHeader.prototype={fnInit:function(a,b){var c=this.fnGetSettings(),d=this;this.fnInitSettings(c,b);if(typeof a.fnSettings=="function"){if(typeof a.fnVersionCheck=="functon"&&a.fnVersionCheck("1.6.0")!==!0){alert("FixedHeader 2 required DataTables 1.6.0 or later. Please upgrade your DataTables installation");return}var e=a.fnSettings();if(e.oScroll.sX!=""||e.oScroll.sY!=""){alert("FixedHeader 2 is not supported with DataTables' scrolling mode at this time");return}c.nTable=e.nTable,e.aoDrawCallback.push({fn:function(){FixedHeader.fnMeasure(),d._fnUpdateClones.call(d),d._fnUpdatePositions.call(d)},sName:"FixedHeader"})}else c.nTable=a;c.bFooter=$(">tfoot",c.nTable).length>0?!0:!1,c.bUseAbsPos=jQuery.browser.msie&&(jQuery.browser.version=="6.0"||jQuery.browser.version=="7.0"),c.oSides.top&&c.aoCache.push(d._fnCloneTable("fixedHeader","FixedHeader_Header",d._fnCloneThead)),c.oSides.bottom&&c.aoCache.push(d._fnCloneTable("fixedFooter","FixedHeader_Footer",d._fnCloneTfoot)),c.oSides.left&&c.aoCache.push(d._fnCloneTable("fixedLeft","FixedHeader_Left",d._fnCloneTLeft)),c.oSides.right&&c.aoCache.push(d._fnCloneTable("fixedRight","FixedHeader_Right",d._fnCloneTRight)),FixedHeader.afnScroll.push(function(){d._fnUpdatePositions.call(d)}),jQuery(window).resize(function(){FixedHeader.fnMeasure(),d._fnUpdateClones.call(d),d._fnUpdatePositions.call(d)}),FixedHeader.fnMeasure(),d._fnUpdateClones(),d._fnUpdatePositions()},fnInitSettings:function(a,b){typeof b!="undefined"&&(typeof b.top!="undefined"&&(a.oSides.top=b.top),typeof b.bottom!="undefined"&&(a.oSides.bottom=b.bottom),typeof b.left!="undefined"&&(a.oSides.left=b.left),typeof b.right!="undefined"&&(a.oSides.right=b.right),typeof b.zTop!="undefined"&&(a.oZIndexes.top=b.zTop),typeof b.zBottom!="undefined"&&(a.oZIndexes.bottom=b.zBottom),typeof b.zLeft!="undefined"&&(a.oZIndexes.left=b.zLeft),typeof b.zRight!="undefined"&&(a.oZIndexes.right=b.zRight),typeof b.offsetTop!="undefined"&&(a.oOffset.top=b.offsetTop)),a.bUseAbsPos=jQuery.browser.msie&&(jQuery.browser.version=="6.0"||jQuery.browser.version=="7.0")},_fnCloneTable:function(a,b,c){var d=this.fnGetSettings(),e;jQuery(d.nTable.parentNode).css("position")!="absolute"&&(d.nTable.parentNode.style.position="relative"),e=d.nTable.cloneNode(!1),e.removeAttribute("id");var f=document.createElement("div");return f.style.position="absolute",f.style.top="0px",f.style.left="0px",f.className+=" FixedHeader_Cloned "+a+" "+b,a=="fixedHeader"&&(f.style.zIndex=d.oZIndexes.top),a=="fixedFooter"&&(f.style.zIndex=d.oZIndexes.bottom),a=="fixedLeft"?f.style.zIndex=d.oZIndexes.left:a=="fixedRight"&&(f.style.zIndex=d.oZIndexes.right),e.style.margin="0",f.appendChild(e),document.body.appendChild(f),{nNode:e,nWrapper:f,sType:a,sPosition:"",sTop:"",sLeft:"",fnClone:c}},_fnMeasure:function(){var a=this.fnGetSettings(),b=a.oMes,c=jQuery(a.nTable),d=c.offset(),e=this._fnSumScroll(a.nTable.parentNode,"scrollTop"),f=this._fnSumScroll(a.nTable.parentNode,"scrollLeft");b.iTableWidth=c.outerWidth(),b.iTableHeight=c.outerHeight(),b.iTableLeft=d.left+a.nTable.parentNode.scrollLeft,b.iTableTop=d.top+e,b.iTableRight=b.iTableLeft+b.iTableWidth,b.iTableRight=FixedHeader.oDoc.iWidth-b.iTableLeft-b.iTableWidth,b.iTableBottom=FixedHeader.oDoc.iHeight-b.iTableTop-b.iTableHeight},_fnSumScroll:function(a,b){var c=a[b];while(a=a.parentNode){if(a.nodeName=="HTML"||a.nodeName=="BODY")break;c=a[b]}return c},_fnUpdatePositions:function(){var a=this.fnGetSettings();this._fnMeasure();for(var b=0,c=a.aoCache.length;b<c;b++)a.aoCache[b].sType=="fixedHeader"?this._fnScrollFixedHeader(a.aoCache[b]):a.aoCache[b].sType=="fixedFooter"?this._fnScrollFixedFooter(a.aoCache[b]):a.aoCache[b].sType=="fixedLeft"?this._fnScrollHorizontalLeft(a.aoCache[b]):this._fnScrollHorizontalRight(a.aoCache[b])},_fnUpdateClones:function(){var a=this.fnGetSettings();for(var b=0,c=a.aoCache.length;b<c;b++)a.aoCache[b].fnClone.call(this,a.aoCache[b])},_fnScrollHorizontalRight:function(a){var b=this.fnGetSettings(),c=b.oMes,d=FixedHeader.oWin,e=FixedHeader.oDoc,f=a.nWrapper,g=jQuery(f).outerWidth();d.iScrollRight<c.iTableRight?(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+c.iTableWidth-g+"px","left",f.style)):c.iTableLeft<e.iWidth-d.iScrollRight-g?b.bUseAbsPos?(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft",e.iWidth-d.iScrollRight-g+"px","left",f.style)):(this._fnUpdateCache(a,"sPosition","fixed","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop-d.iScrollTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft",d.iWidth-g+"px","left",f.style)):(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+"px","left",f.style))},_fnScrollHorizontalLeft:function(a){var b=this.fnGetSettings(),c=b.oMes,d=FixedHeader.oWin,e=FixedHeader.oDoc,f=a.nWrapper,g=jQuery(f).outerWidth();d.iScrollLeft<c.iTableLeft?(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+"px","left",f.style)):d.iScrollLeft<c.iTableLeft+c.iTableWidth-g?b.bUseAbsPos?(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft",d.iScrollLeft+"px","left",f.style)):(this._fnUpdateCache(a,"sPosition","fixed","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop-d.iScrollTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft","0px","left",f.style)):(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+c.iTableWidth-g+"px","left",f.style))},_fnScrollFixedFooter:function(a){var b=this.fnGetSettings(),c=b.oMes,d=FixedHeader.oWin,e=FixedHeader.oDoc,f=a.nWrapper,g=jQuery("thead",b.nTable).outerHeight(),h=jQuery(f).outerHeight();d.iScrollBottom<c.iTableBottom?(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+c.iTableHeight-h+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+"px","left",f.style)):d.iScrollBottom<c.iTableBottom+c.iTableHeight-h-g?b.bUseAbsPos?(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",e.iHeight-d.iScrollBottom-h+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+"px","left",f.style)):(this._fnUpdateCache(a,"sPosition","fixed","position",f.style),this._fnUpdateCache(a,"sTop",d.iHeight-h+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft-d.iScrollLeft+"px","left",f.style)):(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+h+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+"px","left",f.style))},_fnScrollFixedHeader:function(a){var b=this.fnGetSettings(),c=b.oMes,d=FixedHeader.oWin,e=FixedHeader.oDoc,f=a.nWrapper,g=0,h=b.nTable.getElementsByTagName("tbody");for(var i=0;i<h.length;++i)g+=h[i].offsetHeight;c.iTableTop>d.iScrollTop+b.oOffset.top?(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+"px","left",f.style)):d.iScrollTop+b.oOffset.top>c.iTableTop+g?(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",c.iTableTop+g+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+"px","left",f.style)):b.bUseAbsPos?(this._fnUpdateCache(a,"sPosition","absolute","position",f.style),this._fnUpdateCache(a,"sTop",d.iScrollTop+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft+"px","left",f.style)):(this._fnUpdateCache(a,"sPosition","fixed","position",f.style),this._fnUpdateCache(a,"sTop",b.oOffset.top+"px","top",f.style),this._fnUpdateCache(a,"sLeft",c.iTableLeft-d.iScrollLeft+"px","left",f.style))},_fnUpdateCache:function(a,b,c,d,e){a[b]!=c&&(e[d]=c,a[b]=c)},_fnCloneThead:function(a){var b=this.fnGetSettings(),c=a.nNode;a.nWrapper.style.width=jQuery(b.nTable).outerWidth()+"px";while(c.childNodes.length>0)jQuery("thead th",c).unbind("click"),c.removeChild(c.childNodes[0]);var d=jQuery("thead",b.nTable).clone(!0)[0];c.appendChild(d),jQuery("thead>tr th",b.nTable).each(function(a){jQuery("thead>tr th:eq("+a+")",c).width(jQuery(this).width())}),jQuery("thead>tr td",b.nTable).each(function(a){jQuery("thead>tr td:eq("+a+")",c).width(jQuery(this).width())})},_fnCloneTfoot:function(a){var b=this.fnGetSettings(),c=a.nNode;a.nWrapper.style.width=jQuery(b.nTable).outerWidth()+"px";while(c.childNodes.length>0)c.removeChild(c.childNodes[0]);var d=jQuery("tfoot",b.nTable).clone(!0)[0];c.appendChild(d),jQuery("tfoot:eq(0)>tr th",b.nTable).each(function(a){jQuery("tfoot:eq(0)>tr th:eq("+a+")",c).width(jQuery(this).width())}),jQuery("tfoot:eq(0)>tr td",b.nTable).each(function(a){jQuery("tfoot:eq(0)>tr th:eq("+a+")",c)[0].style.width(jQuery(this).width())})},_fnCloneTLeft:function(a){var b=this.fnGetSettings(),c=a.nNode,d=$("tbody",b.nTable)[0],e=$("tbody tr:eq(0) td",b.nTable).length,f=$.browser.msie&&($.browser.version=="6.0"||$.browser.version=="7.0");while(c.childNodes.length>0)c.removeChild(c.childNodes[0]);c.appendChild(jQuery("thead",b.nTable).clone(!0)[0]),c.appendChild(jQuery("tbody",b.nTable).clone(!0)[0]),b.bFooter&&c.appendChild(jQuery("tfoot",b.nTable).clone(!0)[0]),$("thead tr",c).each(function(a){$("th:gt(0)",this).remove()}),$("tfoot tr",c).each(function(a){$("th:gt(0)",this).remove()}),$("tbody tr",c).each(function(a){$("td:gt(0)",this).remove()}),this.fnEqualiseHeights("tbody",d.parentNode,c);var g=jQuery("thead tr th:eq(0)",b.nTable).outerWidth();c.style.width=g+"px",a.nWrapper.style.width=g+"px"},_fnCloneTRight:function(a){var b=this.fnGetSettings(),c=$("tbody",b.nTable)[0],d=a.nNode,e=jQuery("tbody tr:eq(0) td",b.nTable).length,f=$.browser.msie&&($.browser.version=="6.0"||$.browser.version=="7.0");while(d.childNodes.length>0)d.removeChild(d.childNodes[0]);d.appendChild(jQuery("thead",b.nTable).clone(!0)[0]),d.appendChild(jQuery("tbody",b.nTable).clone(!0)[0]),b.bFooter&&d.appendChild(jQuery("tfoot",b.nTable).clone(!0)[0]),jQuery("thead tr th:not(:nth-child("+e+"n))",d).remove(),jQuery("tfoot tr th:not(:nth-child("+e+"n))",d).remove(),$("tbody tr",d).each(function(a){$("td:lt("+(e-1)+")",this).remove()}),this.fnEqualiseHeights("tbody",c.parentNode,d);var g=jQuery("thead tr th:eq("+(e-1)+")",b.nTable).outerWidth();d.style.width=g+"px",a.nWrapper.style.width=g+"px"},fnEqualiseHeights:function(a,b,c){var d=this,e=$(a+" tr:eq(0)",b).children(":eq(0)"),f=e.outerHeight()-e.height(),g=$.browser.msie&&($.browser.version=="6.0"||$.browser.version=="7.0");$(a+" tr",c).each(function(c){$.browser.mozilla||$.browser.opera?$(this).children().height($(a+" tr:eq("+c+")",b).outerHeight()):$(this).children().height($(a+" tr:eq("+c+")",b).outerHeight()-f),g||$(a+" tr:eq("+c+")",b).height($(a+" tr:eq("+c+")",b).outerHeight())})}},FixedHeader.oWin={iScrollTop:0,iScrollRight:0,iScrollBottom:0,iScrollLeft:0,iHeight:0,iWidth:0},FixedHeader.oDoc={iHeight:0,iWidth:0},FixedHeader.afnScroll=[],FixedHeader.fnMeasure=function(){var a=jQuery(window),b=jQuery(document),c=FixedHeader.oWin,d=FixedHeader.oDoc;d.iHeight=b.height(),d.iWidth=b.width(),c.iHeight=a.height(),c.iWidth=a.width(),c.iScrollTop=a.scrollTop(),c.iScrollLeft=a.scrollLeft(),c.iScrollRight=d.iWidth-c.iScrollLeft-c.iWidth,c.iScrollBottom=d.iHeight-c.iScrollTop-c.iHeight},FixedHeader.VERSION="2.0.6",FixedHeader.prototype.VERSION=FixedHeader.VERSION,jQuery(window).scroll(function(){FixedHeader.fnMeasure();for(var a=0,b=FixedHeader.afnScroll.length;a<b;a++)FixedHeader.afnScroll[a]()});
>>>>>>> hsa
