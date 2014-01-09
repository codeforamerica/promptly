/*
 * File:        ColVis.js
 * Version:     1.0.8
 * CVS:         $Id$
 * Description: Controls for column visiblity in DataTables
 * Author:      Allan Jardine (www.sprymedia.co.uk)
 * Created:     Wed Sep 15 18:23:29 BST 2010
 * Modified:    $Date$ by $Author$
 * Language:    Javascript
 * License:     GPL v2 or BSD 3 point style
 * Project:     Just a little bit of fun :-)
 * Contact:     www.sprymedia.co.uk/contact
 *
 * Copyright 2010-2011 Allan Jardine, all rights reserved.
 *
 * This source file is free software, under either the GPL v2 license or a
 * BSD style license, available at:
 *   http://datatables.net/license_gpl2
 *   http://datatables.net/license_bsd
 */
<<<<<<< HEAD


(function($) {

/**
 * ColVis provides column visiblity control for DataTables
 * @class ColVis
 * @constructor
 * @param {object} DataTables settings object
 */
ColVis = function( oDTSettings, oInit )
{
	/* Santiy check that we are a new instance */
	if ( !this.CLASS || this.CLASS != "ColVis" )
	{
		alert( "Warning: ColVis must be initialised with the keyword 'new'" );
	}

	if ( typeof oInit == 'undefined' )
	{
		oInit = {};
	}


	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Public class variables
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * @namespace Settings object which contains customisable information for ColVis instance
	 */
	this.s = {
		/**
		 * DataTables settings object
		 *  @property dt
		 *  @type     Object
		 *  @default  null
		 */
		"dt": null,

		/**
		 * Customisation object
		 *  @property oInit
		 *  @type     Object
		 *  @default  passed in
		 */
		"oInit": oInit,

		/**
		 * Callback function to tell the user when the state has changed
		 *  @property fnStateChange
		 *  @type     function
		 *  @default  null
		 */
		"fnStateChange": null,

		/**
		 * Mode of activation. Can be 'click' or 'mouseover'
		 *  @property activate
		 *  @type     String
		 *  @default  click
		 */
		"activate": "click",

		/**
		 * Position of the collection menu when shown - align "left" or "right"
		 *  @property sAlign
		 *  @type     String
		 *  @default  right
		 */
		"sAlign": "left",

		/**
		 * Text used for the button
		 *  @property buttonText
		 *  @type     String
		 *  @default  Show / hide columns
		 */
		"buttonText": "Show / hide columns",

		/**
		 * Flag to say if the collection is hidden
		 *  @property hidden
		 *  @type     boolean
		 *  @default  true
		 */
		"hidden": true,

		/**
		 * List of columns (integers) which should be excluded from the list
		 *  @property aiExclude
		 *  @type     Array
		 *  @default  []
		 */
		"aiExclude": [],

		/**
		 * Store the original viisbility settings so they could be restored
		 *  @property abOriginal
		 *  @type     Array
		 *  @default  []
		 */
		"abOriginal": [],

		/**
		 * Show Show-All button
		 *  @property bShowAll
		 *  @type     Array
		 *  @default  []
		 */
		"bShowAll": false,

		/**
		 * Show All button text
		 *  @property sShowAll
		 *  @type     String
		 *  @default  Restore original
		 */
		"sShowAll": "Show All",

		/**
		 * Show restore button
		 *  @property bRestore
		 *  @type     Array
		 *  @default  []
		 */
		"bRestore": false,

		/**
		 * Restore button text
		 *  @property sRestore
		 *  @type     String
		 *  @default  Restore original
		 */
		"sRestore": "Restore original",

		/**
		 * Overlay animation duration in mS
		 *  @property iOverlayFade
		 *  @type     Integer
		 *  @default  500
		 */
		"iOverlayFade": 500,

		/**
		 * Label callback for column names. Takes three parameters: 1. the column index, 2. the column
		 * title detected by DataTables and 3. the TH node for the column
		 *  @property fnLabel
		 *  @type     Function
		 *  @default  null
		 */
		"fnLabel": null,

		/**
		 * Indicate if ColVis should automatically calculate the size of buttons or not. The default
		 * is for it to do so. Set to "css" to disable the automatic sizing
		 *  @property sSize
		 *  @type     String
		 *  @default  auto
		 */
		"sSize": "auto",

		/**
		 * Indicate if the column list should be positioned by Javascript, visually below the button
		 * or allow CSS to do the positioning
		 *  @property bCssPosition
		 *  @type     boolean
		 *  @default  false
		 */
		"bCssPosition": false
	};


	/**
	 * @namespace Common and useful DOM elements for the class instance
	 */
	this.dom = {
		/**
		 * Wrapper for the button - given back to DataTables as the node to insert
		 *  @property wrapper
		 *  @type     Node
		 *  @default  null
		 */
		"wrapper": null,

		/**
		 * Activation button
		 *  @property button
		 *  @type     Node
		 *  @default  null
		 */
		"button": null,

		/**
		 * Collection list node
		 *  @property collection
		 *  @type     Node
		 *  @default  null
		 */
		"collection": null,

		/**
		 * Background node used for shading the display and event capturing
		 *  @property background
		 *  @type     Node
		 *  @default  null
		 */
		"background": null,

		/**
		 * Element to position over the activation button to catch mouse events when using mouseover
		 *  @property catcher
		 *  @type     Node
		 *  @default  null
		 */
		"catcher": null,

		/**
		 * List of button elements
		 *  @property buttons
		 *  @type     Array
		 *  @default  []
		 */
		"buttons": [],

		/**
		 * Restore button
		 *  @property restore
		 *  @type     Node
		 *  @default  null
		 */
		"restore": null
	};

	/* Store global reference */
	ColVis.aInstances.push( this );

	/* Constructor logic */
	this.s.dt = oDTSettings;
	this._fnConstruct();
	return this;
};



ColVis.prototype = {
	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Public methods
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * Rebuild the list of buttons for this instance (i.e. if there is a column header update)
	 *  @method  fnRebuild
	 *  @returns void
	 */
	"fnRebuild": function ()
	{
		/* Remove the old buttons */
		for ( var i=this.dom.buttons.length-1 ; i>=0 ; i-- )
		{
			if ( this.dom.buttons[i] !== null )
			{
				this.dom.collection.removeChild( this.dom.buttons[i] );
			}
		}
		this.dom.buttons.splice( 0, this.dom.buttons.length );

		if ( this.dom.restore )
		{
			this.dom.restore.parentNode( this.dom.restore );
		}

		/* Re-add them (this is not the optimal way of doing this, it is fast and effective) */
		this._fnAddButtons();

		/* Update the checkboxes */
		this._fnDrawCallback();
	},



	/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
	 * Private methods (they are of course public in JS, but recommended as private)
	 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

	/**
	 * Constructor logic
	 *  @method  _fnConstruct
	 *  @returns void
	 *  @private
	 */
	"_fnConstruct": function ()
	{
		this._fnApplyCustomisation();

		var that = this;
		var i, iLen;
		this.dom.wrapper = document.createElement('div');
		this.dom.wrapper.className = "ColVis TableTools";

		this.dom.button = this._fnDomBaseButton( this.s.buttonText );
		this.dom.button.className += " ColVis_MasterButton";
		this.dom.wrapper.appendChild( this.dom.button );

		this.dom.catcher = this._fnDomCatcher();
		this.dom.collection = this._fnDomCollection();
		this.dom.background = this._fnDomBackground();

		this._fnAddButtons();

		/* Store the original visbility information */
		for ( i=0, iLen=this.s.dt.aoColumns.length ; i<iLen ; i++ )
		{
			this.s.abOriginal.push( this.s.dt.aoColumns[i].bVisible );
		}

		/* Update on each draw */
		this.s.dt.aoDrawCallback.push( {
			"fn": function () {
				that._fnDrawCallback.call( that );
			},
			"sName": "ColVis"
		} );

		/* If columns are reordered, then we need to update our exclude list and
		 * rebuild the displayed list
		 */
		$(this.s.dt.oInstance).bind( 'column-reorder', function ( e, oSettings, oReorder ) {
			for ( i=0, iLen=that.s.aiExclude.length ; i<iLen ; i++ ) {
				that.s.aiExclude[i] = oReorder.aiInvertMapping[ that.s.aiExclude[i] ];
			}

			var mStore = that.s.abOriginal.splice( oReorder.iFrom, 1 )[0];
			that.s.abOriginal.splice( oReorder.iTo, 0, mStore );

			that.fnRebuild();
		} );
	},


	/**
	 * Apply any customisation to the settings from the DataTables initialisation
	 *  @method  _fnApplyCustomisation
	 *  @returns void
	 *  @private
	 */
	"_fnApplyCustomisation": function ()
	{
		var oConfig = this.s.oInit;

		if ( typeof oConfig.activate != 'undefined' )
		{
			this.s.activate = oConfig.activate;
		}

		if ( typeof oConfig.buttonText != 'undefined' )
		{
			this.s.buttonText = oConfig.buttonText;
		}

		if ( typeof oConfig.aiExclude != 'undefined' )
		{
			this.s.aiExclude = oConfig.aiExclude;
		}

		if ( typeof oConfig.bRestore != 'undefined' )
		{
			this.s.bRestore = oConfig.bRestore;
		}

		if ( typeof oConfig.sRestore != 'undefined' )
		{
			this.s.sRestore = oConfig.sRestore;
		}

		if ( typeof oConfig.bShowAll != 'undefined' )
		{
			this.s.bShowAll = oConfig.bShowAll;
		}

		if ( typeof oConfig.sShowAll != 'undefined' )
		{
			this.s.sShowAll = oConfig.sShowAll;
		}

		if ( typeof oConfig.sAlign != 'undefined' )
		{
			this.s.sAlign = oConfig.sAlign;
		}

		if ( typeof oConfig.fnStateChange != 'undefined' )
		{
			this.s.fnStateChange = oConfig.fnStateChange;
		}

		if ( typeof oConfig.iOverlayFade != 'undefined' )
		{
			this.s.iOverlayFade = oConfig.iOverlayFade;
		}

		if ( typeof oConfig.fnLabel != 'undefined' )
		{
			this.s.fnLabel = oConfig.fnLabel;
		}

		if ( typeof oConfig.sSize != 'undefined' )
		{
			this.s.sSize = oConfig.sSize;
		}

		if ( typeof oConfig.bCssPosition != 'undefined' )
		{
			this.s.bCssPosition = oConfig.bCssPosition;
		}
	},


	/**
	 * On each table draw, check the visibility checkboxes as needed. This allows any process to
	 * update the table's column visibility and ColVis will still be accurate.
	 *  @method  _fnDrawCallback
	 *  @returns void
	 *  @private
	 */
	"_fnDrawCallback": function ()
	{
		var aoColumns = this.s.dt.aoColumns;

		for ( var i=0, iLen=aoColumns.length ; i<iLen ; i++ )
		{
			if ( this.dom.buttons[i] !== null )
			{
				if ( aoColumns[i].bVisible )
				{
					$('input', this.dom.buttons[i]).attr('checked','checked');
				}
				else
				{
					$('input', this.dom.buttons[i]).removeAttr('checked');
				}
			}
		}
	},


	/**
	 * Loop through the columns in the table and as a new button for each one.
	 *  @method  _fnAddButtons
	 *  @returns void
	 *  @private
	 */
	"_fnAddButtons": function ()
	{
		var
			nButton,
			sExclude = ","+this.s.aiExclude.join(',')+",";

		for ( var i=0, iLen=this.s.dt.aoColumns.length ; i<iLen ; i++ )
		{
			if ( sExclude.indexOf( ","+i+"," ) == -1 )
			{
				nButton = this._fnDomColumnButton( i );
				this.dom.buttons.push( nButton );
				this.dom.collection.appendChild( nButton );
			}
			else
			{
				this.dom.buttons.push( null );
			}
		}

		if ( this.s.bRestore )
		{
			nButton = this._fnDomRestoreButton();
			nButton.className += " ColVis_Restore";
			this.dom.buttons.push( nButton );
			this.dom.collection.appendChild( nButton );
		}

		if ( this.s.bShowAll )
		{
			nButton = this._fnDomShowAllButton();
			nButton.className += " ColVis_ShowAll";
			this.dom.buttons.push( nButton );
			this.dom.collection.appendChild( nButton );
		}
	},


	/**
	 * Create a button which allows a "restore" action
	 *  @method  _fnDomRestoreButton
	 *  @returns {Node} Created button
	 *  @private
	 */
	"_fnDomRestoreButton": function ()
	{
		var
			that = this,
			nButton = document.createElement('button'),
			nSpan = document.createElement('span');

		nButton.className = !this.s.dt.bJUI ? "ColVis_Button TableTools_Button" :
			"ColVis_Button TableTools_Button ui-button ui-state-default";
		nButton.appendChild( nSpan );
		$(nSpan).html( '<span class="ColVis_title">'+this.s.sRestore+'</span>' );

		$(nButton).click( function (e) {
			for ( var i=0, iLen=that.s.abOriginal.length ; i<iLen ; i++ )
			{
				that.s.dt.oInstance.fnSetColumnVis( i, that.s.abOriginal[i], false );
			}
			that._fnAdjustOpenRows();
			that.s.dt.oInstance.fnAdjustColumnSizing( false );
			that.s.dt.oInstance.fnDraw( false );
		} );

		return nButton;
	},


	/**
	 * Create a button which allows a "show all" action
	 *  @method  _fnDomShowAllButton
	 *  @returns {Node} Created button
	 *  @private
	 */
	"_fnDomShowAllButton": function ()
	{
		var
			that = this,
			nButton = document.createElement('button'),
			nSpan = document.createElement('span');

		nButton.className = !this.s.dt.bJUI ? "ColVis_Button TableTools_Button" :
			"ColVis_Button TableTools_Button ui-button ui-state-default";
		nButton.appendChild( nSpan );
		$(nSpan).html( '<span class="ColVis_title">'+this.s.sShowAll+'</span>' );

		$(nButton).click( function (e) {
			for ( var i=0, iLen=that.s.abOriginal.length ; i<iLen ; i++ )
			{
				if (that.s.aiExclude.indexOf(i) === -1)
				{
					that.s.dt.oInstance.fnSetColumnVis( i, true, false );
				}
			}
			that._fnAdjustOpenRows();
			that.s.dt.oInstance.fnAdjustColumnSizing( false );
			that.s.dt.oInstance.fnDraw( false );
		} );

		return nButton;
	},


	/**
	 * Create the DOM for a show / hide button
	 *  @method  _fnDomColumnButton
	 *  @param {int} i Column in question
	 *  @returns {Node} Created button
	 *  @private
	 */
	"_fnDomColumnButton": function ( i )
	{
		var
			that = this,
			oColumn = this.s.dt.aoColumns[i],
			nButton = document.createElement('button'),
			nSpan = document.createElement('span'),
			dt = this.s.dt;

		nButton.className = !dt.bJUI ? "ColVis_Button TableTools_Button" :
			"ColVis_Button TableTools_Button ui-button ui-state-default";
		nButton.appendChild( nSpan );
		var sTitle = this.s.fnLabel===null ? oColumn.sTitle : this.s.fnLabel( i, oColumn.sTitle, oColumn.nTh );
		$(nSpan).html(
			'<span class="ColVis_radio"><input type="checkbox"/></span>'+
			'<span class="ColVis_title">'+sTitle+'</span>' );

		$(nButton).click( function (e) {
			var showHide = !$('input', this).is(":checked");
			if ( e.target.nodeName.toLowerCase() == "input" )
			{
				showHide = $('input', this).is(":checked");
			}

			/* Need to consider the case where the initialiser created more than one table - change the
			 * API index that DataTables is using
			 */
			var oldIndex = $.fn.dataTableExt.iApiIndex;
			$.fn.dataTableExt.iApiIndex = that._fnDataTablesApiIndex.call(that);

			// Optimisation for server-side processing when scrolling - don't do a full redraw
			if ( dt.oFeatures.bServerSide && (dt.oScroll.sX !== "" || dt.oScroll.sY !== "" ) )
			{
				that.s.dt.oInstance.fnSetColumnVis( i, showHide, false );
				that.s.dt.oInstance.fnAdjustColumnSizing( false );
				that.s.dt.oInstance.oApi._fnScrollDraw( that.s.dt );
				that._fnDrawCallback();
			}
			else
			{
				that.s.dt.oInstance.fnSetColumnVis( i, showHide );
			}

			$.fn.dataTableExt.iApiIndex = oldIndex; /* Restore */

			if ( that.s.fnStateChange !== null )
			{
				that.s.fnStateChange.call( that, i, showHide );
			}
		} );

		return nButton;
	},


	/**
	 * Get the position in the DataTables instance array of the table for this instance of ColVis
	 *  @method  _fnDataTablesApiIndex
	 *  @returns {int} Index
	 *  @private
	 */
	"_fnDataTablesApiIndex": function ()
	{
		for ( var i=0, iLen=this.s.dt.oInstance.length ; i<iLen ; i++ )
		{
			if ( this.s.dt.oInstance[i] == this.s.dt.nTable )
			{
				return i;
			}
		}
		return 0;
	},


	/**
	 * Create the DOM needed for the button and apply some base properties. All buttons start here
	 *  @method  _fnDomBaseButton
	 *  @param   {String} text Button text
	 *  @returns {Node} DIV element for the button
	 *  @private
	 */
	"_fnDomBaseButton": function ( text )
	{
		var
			that = this,
			nButton = document.createElement('button'),
			nSpan = document.createElement('span'),
			sEvent = this.s.activate=="mouseover" ? "mouseover" : "click";

		nButton.className = !this.s.dt.bJUI ? "ColVis_Button TableTools_Button" :
			"ColVis_Button TableTools_Button ui-button ui-state-default";
		nButton.appendChild( nSpan );
		nSpan.innerHTML = text;

		$(nButton).bind( sEvent, function (e) {
			that._fnCollectionShow();
			e.preventDefault();
		} );

		return nButton;
	},


	/**
	 * Create the element used to contain list the columns (it is shown and hidden as needed)
	 *  @method  _fnDomCollection
	 *  @returns {Node} div container for the collection
	 *  @private
	 */
	"_fnDomCollection": function ()
	{
		var that = this;
		var nHidden = document.createElement('div');
		nHidden.style.display = "none";
		nHidden.className = !this.s.dt.bJUI ? "ColVis_collection TableTools_collection" :
			"ColVis_collection TableTools_collection ui-buttonset ui-buttonset-multi";

		if ( !this.s.bCssPosition )
		{
			nHidden.style.position = "absolute";
		}
		$(nHidden).css('opacity', 0);

		return nHidden;
	},


	/**
	 * An element to be placed on top of the activate button to catch events
	 *  @method  _fnDomCatcher
	 *  @returns {Node} div container for the collection
	 *  @private
	 */
	"_fnDomCatcher": function ()
	{
		var
			that = this,
			nCatcher = document.createElement('div');
		nCatcher.className = "ColVis_catcher TableTools_catcher";

		$(nCatcher).click( function () {
			that._fnCollectionHide.call( that, null, null );
		} );

		return nCatcher;
	},


	/**
	 * Create the element used to shade the background, and capture hide events (it is shown and
	 * hidden as needed)
	 *  @method  _fnDomBackground
	 *  @returns {Node} div container for the background
	 *  @private
	 */
	"_fnDomBackground": function ()
	{
		var that = this;

		var nBackground = document.createElement('div');
		nBackground.style.position = "absolute";
		nBackground.style.left = "0px";
		nBackground.style.top = "0px";
		nBackground.className = "ColVis_collectionBackground TableTools_collectionBackground";
		$(nBackground).css('opacity', 0);

		$(nBackground).click( function () {
			that._fnCollectionHide.call( that, null, null );
		} );

		/* When considering a mouse over action for the activation, we also consider a mouse out
		 * which is the same as a mouse over the background - without all the messing around of
		 * bubbling events. Use the catcher element to avoid messing around with bubbling
		 */
		if ( this.s.activate == "mouseover" )
		{
			$(nBackground).mouseover( function () {
				that.s.overcollection = false;
				that._fnCollectionHide.call( that, null, null );
			} );
		}

		return nBackground;
	},


	/**
	 * Show the show / hide list and the background
	 *  @method  _fnCollectionShow
	 *  @returns void
	 *  @private
	 */
	"_fnCollectionShow": function ()
	{
		var that = this, i, iLen;
		var oPos = $(this.dom.button).offset();
		var nHidden = this.dom.collection;
		var nBackground = this.dom.background;
		var iDivX = parseInt(oPos.left, 10);
		var iDivY = parseInt(oPos.top + $(this.dom.button).outerHeight(), 10);

		if ( !this.s.bCssPosition )
		{
			nHidden.style.top = iDivY+"px";
			nHidden.style.left = iDivX+"px";
		}
		nHidden.style.display = "block";
		$(nHidden).css('opacity',0);

		var iWinHeight = $(window).height(), iDocHeight = $(document).height(),
		 	iWinWidth = $(window).width(), iDocWidth = $(document).width();

		nBackground.style.height = ((iWinHeight>iDocHeight)? iWinHeight : iDocHeight) +"px";
		nBackground.style.width = ((iWinWidth<iDocWidth)? iWinWidth : iDocWidth) +"px";

		var oStyle = this.dom.catcher.style;
		oStyle.height = $(this.dom.button).outerHeight()+"px";
		oStyle.width = $(this.dom.button).outerWidth()+"px";
		oStyle.top = oPos.top+"px";
		oStyle.left = iDivX+"px";

		document.body.appendChild( nBackground );
		document.body.appendChild( nHidden );
		document.body.appendChild( this.dom.catcher );

		/* Resize the buttons */
		if ( this.s.sSize == "auto" )
		{
			var aiSizes = [];
			this.dom.collection.style.width = "auto";
			for ( i=0, iLen=this.dom.buttons.length ; i<iLen ; i++ )
			{
				if ( this.dom.buttons[i] !== null )
				{
					this.dom.buttons[i].style.width = "auto";
					aiSizes.push( $(this.dom.buttons[i]).outerWidth() );
				}
			}
			iMax = Math.max.apply(window, aiSizes);
			for ( i=0, iLen=this.dom.buttons.length ; i<iLen ; i++ )
			{
				if ( this.dom.buttons[i] !== null )
				{
					this.dom.buttons[i].style.width = iMax+"px";
				}
			}
			this.dom.collection.style.width = iMax+"px";
		}

		/* Visual corrections to try and keep the collection visible */
		if ( !this.s.bCssPosition )
		{
			nHidden.style.left = this.s.sAlign=="left" ?
				iDivX+"px" : (iDivX-$(nHidden).outerWidth()+$(this.dom.button).outerWidth())+"px";

			var iDivWidth = $(nHidden).outerWidth();
			var iDivHeight = $(nHidden).outerHeight();

			if ( iDivX + iDivWidth > iDocWidth )
			{
				nHidden.style.left = (iDocWidth-iDivWidth)+"px";
			}
		}

		/* This results in a very small delay for the end user but it allows the animation to be
		 * much smoother. If you don't want the animation, then the setTimeout can be removed
		 */
		setTimeout( function () {
			$(nHidden).animate({"opacity": 1}, that.s.iOverlayFade);
			$(nBackground).animate({"opacity": 0.1}, that.s.iOverlayFade, 'linear', function () {
				/* In IE6 if you set the checked attribute of a hidden checkbox, then this is not visually
				 * reflected. As such, we need to do it here, once it is visible. Unbelievable.
				 */
				if ( jQuery.browser.msie && jQuery.browser.version == "6.0" )
				{
					that._fnDrawCallback();
				}
			});
		}, 10 );

		this.s.hidden = false;
	},


	/**
	 * Hide the show / hide list and the background
	 *  @method  _fnCollectionHide
	 *  @returns void
	 *  @private
	 */
	"_fnCollectionHide": function (  )
	{
		var that = this;

		if ( !this.s.hidden && this.dom.collection !== null )
		{
			this.s.hidden = true;

			$(this.dom.collection).animate({"opacity": 0}, that.s.iOverlayFade, function (e) {
				this.style.display = "none";
			} );

			$(this.dom.background).animate({"opacity": 0}, that.s.iOverlayFade, function (e) {
				document.body.removeChild( that.dom.background );
				document.body.removeChild( that.dom.catcher );
			} );
		}
	},


	/**
	 * Alter the colspan on any fnOpen rows
	 */
	"_fnAdjustOpenRows": function ()
	{
		var aoOpen = this.s.dt.aoOpenRows;
		var iVisible = this.s.dt.oApi._fnVisbleColumns( this.s.dt );

		for ( var i=0, iLen=aoOpen.length ; i<iLen ; i++ ) {
			aoOpen[i].nTr.getElementsByTagName('td')[0].colSpan = iVisible;
		}
	}
};





/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Static object methods
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Rebuild the collection for a given table, or all tables if no parameter given
 *  @method  ColVis.fnRebuild
 *  @static
 *  @param   object oTable DataTable instance to consider - optional
 *  @returns void
 */
ColVis.fnRebuild = function ( oTable )
{
	var nTable = null;
	if ( typeof oTable != 'undefined' )
	{
		nTable = oTable.fnSettings().nTable;
	}

	for ( var i=0, iLen=ColVis.aInstances.length ; i<iLen ; i++ )
	{
		if ( typeof oTable == 'undefined' || nTable == ColVis.aInstances[i].s.dt.nTable )
		{
			ColVis.aInstances[i].fnRebuild();
		}
	}
};





/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Static object properties
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Collection of all ColVis instances
 *  @property ColVis.aInstances
 *  @static
 *  @type     Array
 *  @default  []
 */
ColVis.aInstances = [];





/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Constants
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/**
 * Name of this class
 *  @constant CLASS
 *  @type     String
 *  @default  ColVis
 */
ColVis.prototype.CLASS = "ColVis";


/**
 * ColVis version
 *  @constant  VERSION
 *  @type      String
 *  @default   See code
 */
ColVis.VERSION = "1.0.8";
ColVis.prototype.VERSION = ColVis.VERSION;





/* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
 * Initialisation
 * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * */

/*
 * Register a new feature with DataTables
 */
if ( typeof $.fn.dataTable == "function" &&
     typeof $.fn.dataTableExt.fnVersionCheck == "function" &&
     $.fn.dataTableExt.fnVersionCheck('1.7.0') )
{
	$.fn.dataTableExt.aoFeatures.push( {
		"fnInit": function( oDTSettings ) {
			var init = (typeof oDTSettings.oInit.oColVis == 'undefined') ?
				{} : oDTSettings.oInit.oColVis;
			var oColvis = new ColVis( oDTSettings, init );
			return oColvis.dom.wrapper;
		},
		"cFeature": "C",
		"sFeature": "ColVis"
	} );
}
else
{
	alert( "Warning: ColVis requires DataTables 1.7 or greater - www.datatables.net/download");
}

})(jQuery);
=======
(function(a){ColVis=function(a,b){return(!this.CLASS||this.CLASS!="ColVis")&&alert("Warning: ColVis must be initialised with the keyword 'new'"),typeof b=="undefined"&&(b={}),this.s={dt:null,oInit:b,fnStateChange:null,activate:"click",sAlign:"left",buttonText:"Show / hide columns",hidden:!0,aiExclude:[],abOriginal:[],bShowAll:!1,sShowAll:"Show All",bRestore:!1,sRestore:"Restore original",iOverlayFade:500,fnLabel:null,sSize:"auto",bCssPosition:!1},this.dom={wrapper:null,button:null,collection:null,background:null,catcher:null,buttons:[],restore:null},ColVis.aInstances.push(this),this.s.dt=a,this._fnConstruct(),this},ColVis.prototype={fnRebuild:function(){for(var a=this.dom.buttons.length-1;a>=0;a--)this.dom.buttons[a]!==null&&this.dom.collection.removeChild(this.dom.buttons[a]);this.dom.buttons.splice(0,this.dom.buttons.length),this.dom.restore&&this.dom.restore.parentNode(this.dom.restore),this._fnAddButtons(),this._fnDrawCallback()},_fnConstruct:function(){this._fnApplyCustomisation();var b=this,c,d;this.dom.wrapper=document.createElement("div"),this.dom.wrapper.className="ColVis TableTools",this.dom.button=this._fnDomBaseButton(this.s.buttonText),this.dom.button.className+=" ColVis_MasterButton",this.dom.wrapper.appendChild(this.dom.button),this.dom.catcher=this._fnDomCatcher(),this.dom.collection=this._fnDomCollection(),this.dom.background=this._fnDomBackground(),this._fnAddButtons();for(c=0,d=this.s.dt.aoColumns.length;c<d;c++)this.s.abOriginal.push(this.s.dt.aoColumns[c].bVisible);this.s.dt.aoDrawCallback.push({fn:function(){b._fnDrawCallback.call(b)},sName:"ColVis"}),a(this.s.dt.oInstance).bind("column-reorder",function(a,e,f){for(c=0,d=b.s.aiExclude.length;c<d;c++)b.s.aiExclude[c]=f.aiInvertMapping[b.s.aiExclude[c]];var g=b.s.abOriginal.splice(f.iFrom,1)[0];b.s.abOriginal.splice(f.iTo,0,g),b.fnRebuild()})},_fnApplyCustomisation:function(){var a=this.s.oInit;typeof a.activate!="undefined"&&(this.s.activate=a.activate),typeof a.buttonText!="undefined"&&(this.s.buttonText=a.buttonText),typeof a.aiExclude!="undefined"&&(this.s.aiExclude=a.aiExclude),typeof a.bRestore!="undefined"&&(this.s.bRestore=a.bRestore),typeof a.sRestore!="undefined"&&(this.s.sRestore=a.sRestore),typeof a.bShowAll!="undefined"&&(this.s.bShowAll=a.bShowAll),typeof a.sShowAll!="undefined"&&(this.s.sShowAll=a.sShowAll),typeof a.sAlign!="undefined"&&(this.s.sAlign=a.sAlign),typeof a.fnStateChange!="undefined"&&(this.s.fnStateChange=a.fnStateChange),typeof a.iOverlayFade!="undefined"&&(this.s.iOverlayFade=a.iOverlayFade),typeof a.fnLabel!="undefined"&&(this.s.fnLabel=a.fnLabel),typeof a.sSize!="undefined"&&(this.s.sSize=a.sSize),typeof a.bCssPosition!="undefined"&&(this.s.bCssPosition=a.bCssPosition)},_fnDrawCallback:function(){var b=this.s.dt.aoColumns;for(var c=0,d=b.length;c<d;c++)this.dom.buttons[c]!==null&&(b[c].bVisible?a("input",this.dom.buttons[c]).attr("checked","checked"):a("input",this.dom.buttons[c]).removeAttr("checked"))},_fnAddButtons:function(){var a,b=","+this.s.aiExclude.join(",")+",";for(var c=0,d=this.s.dt.aoColumns.length;c<d;c++)b.indexOf(","+c+",")==-1?(a=this._fnDomColumnButton(c),this.dom.buttons.push(a),this.dom.collection.appendChild(a)):this.dom.buttons.push(null);this.s.bRestore&&(a=this._fnDomRestoreButton(),a.className+=" ColVis_Restore",this.dom.buttons.push(a),this.dom.collection.appendChild(a)),this.s.bShowAll&&(a=this._fnDomShowAllButton(),a.className+=" ColVis_ShowAll",this.dom.buttons.push(a),this.dom.collection.appendChild(a))},_fnDomRestoreButton:function(){var b=this,c=document.createElement("button"),d=document.createElement("span");return c.className=this.s.dt.bJUI?"ColVis_Button TableTools_Button ui-button ui-state-default":"ColVis_Button TableTools_Button",c.appendChild(d),a(d).html('<span class="ColVis_title">'+this.s.sRestore+"</span>"),a(c).click(function(a){for(var c=0,d=b.s.abOriginal.length;c<d;c++)b.s.dt.oInstance.fnSetColumnVis(c,b.s.abOriginal[c],!1);b._fnAdjustOpenRows(),b.s.dt.oInstance.fnAdjustColumnSizing(!1),b.s.dt.oInstance.fnDraw(!1)}),c},_fnDomShowAllButton:function(){var b=this,c=document.createElement("button"),d=document.createElement("span");return c.className=this.s.dt.bJUI?"ColVis_Button TableTools_Button ui-button ui-state-default":"ColVis_Button TableTools_Button",c.appendChild(d),a(d).html('<span class="ColVis_title">'+this.s.sShowAll+"</span>"),a(c).click(function(a){for(var c=0,d=b.s.abOriginal.length;c<d;c++)b.s.aiExclude.indexOf(c)===-1&&b.s.dt.oInstance.fnSetColumnVis(c,!0,!1);b._fnAdjustOpenRows(),b.s.dt.oInstance.fnAdjustColumnSizing(!1),b.s.dt.oInstance.fnDraw(!1)}),c},_fnDomColumnButton:function(b){var c=this,d=this.s.dt.aoColumns[b],e=document.createElement("button"),f=document.createElement("span"),g=this.s.dt;e.className=g.bJUI?"ColVis_Button TableTools_Button ui-button ui-state-default":"ColVis_Button TableTools_Button",e.appendChild(f);var h=this.s.fnLabel===null?d.sTitle:this.s.fnLabel(b,d.sTitle,d.nTh);return a(f).html('<span class="ColVis_radio"><input type="checkbox"/></span><span class="ColVis_title">'+h+"</span>"),a(e).click(function(d){var e=!a("input",this).is(":checked");d.target.nodeName.toLowerCase()=="input"&&(e=a("input",this).is(":checked"));var f=a.fn.dataTableExt.iApiIndex;a.fn.dataTableExt.iApiIndex=c._fnDataTablesApiIndex.call(c),!g.oFeatures.bServerSide||g.oScroll.sX===""&&g.oScroll.sY===""?c.s.dt.oInstance.fnSetColumnVis(b,e):(c.s.dt.oInstance.fnSetColumnVis(b,e,!1),c.s.dt.oInstance.fnAdjustColumnSizing(!1),c.s.dt.oInstance.oApi._fnScrollDraw(c.s.dt),c._fnDrawCallback()),a.fn.dataTableExt.iApiIndex=f,c.s.fnStateChange!==null&&c.s.fnStateChange.call(c,b,e)}),e},_fnDataTablesApiIndex:function(){for(var a=0,b=this.s.dt.oInstance.length;a<b;a++)if(this.s.dt.oInstance[a]==this.s.dt.nTable)return a;return 0},_fnDomBaseButton:function(b){var c=this,d=document.createElement("button"),e=document.createElement("span"),f=this.s.activate=="mouseover"?"mouseover":"click";return d.className=this.s.dt.bJUI?"ColVis_Button TableTools_Button ui-button ui-state-default":"ColVis_Button TableTools_Button",d.appendChild(e),e.innerHTML=b,a(d).bind(f,function(a){c._fnCollectionShow(),a.preventDefault()}),d},_fnDomCollection:function(){var b=this,c=document.createElement("div");return c.style.display="none",c.className=this.s.dt.bJUI?"ColVis_collection TableTools_collection ui-buttonset ui-buttonset-multi":"ColVis_collection TableTools_collection",this.s.bCssPosition||(c.style.position="absolute"),a(c).css("opacity",0),c},_fnDomCatcher:function(){var b=this,c=document.createElement("div");return c.className="ColVis_catcher TableTools_catcher",a(c).click(function(){b._fnCollectionHide.call(b,null,null)}),c},_fnDomBackground:function(){var b=this,c=document.createElement("div");return c.style.position="absolute",c.style.left="0px",c.style.top="0px",c.className="ColVis_collectionBackground TableTools_collectionBackground",a(c).css("opacity",0),a(c).click(function(){b._fnCollectionHide.call(b,null,null)}),this.s.activate=="mouseover"&&a(c).mouseover(function(){b.s.overcollection=!1,b._fnCollectionHide.call(b,null,null)}),c},_fnCollectionShow:function(){var b=this,c,d,e=a(this.dom.button).offset(),f=this.dom.collection,g=this.dom.background,h=parseInt(e.left,10),i=parseInt(e.top+a(this.dom.button).outerHeight(),10);this.s.bCssPosition||(f.style.top=i+"px",f.style.left=h+"px"),f.style.display="block",a(f).css("opacity",0);var j=a(window).height(),k=a(document).height(),l=a(window).width(),m=a(document).width();g.style.height=(j>k?j:k)+"px",g.style.width=(l<m?l:m)+"px";var n=this.dom.catcher.style;n.height=a(this.dom.button).outerHeight()+"px",n.width=a(this.dom.button).outerWidth()+"px",n.top=e.top+"px",n.left=h+"px",document.body.appendChild(g),document.body.appendChild(f),document.body.appendChild(this.dom.catcher);if(this.s.sSize=="auto"){var o=[];this.dom.collection.style.width="auto";for(c=0,d=this.dom.buttons.length;c<d;c++)this.dom.buttons[c]!==null&&(this.dom.buttons[c].style.width="auto",o.push(a(this.dom.buttons[c]).outerWidth()));iMax=Math.max.apply(window,o);for(c=0,d=this.dom.buttons.length;c<d;c++)this.dom.buttons[c]!==null&&(this.dom.buttons[c].style.width=iMax+"px");this.dom.collection.style.width=iMax+"px"}if(!this.s.bCssPosition){f.style.left=this.s.sAlign=="left"?h+"px":h-a(f).outerWidth()+a(this.dom.button).outerWidth()+"px";var p=a(f).outerWidth(),q=a(f).outerHeight();h+p>m&&(f.style.left=m-p+"px")}setTimeout(function(){a(f).animate({opacity:1},b.s.iOverlayFade),a(g).animate({opacity:.1},b.s.iOverlayFade,"linear",function(){jQuery.browser.msie&&jQuery.browser.version=="6.0"&&b._fnDrawCallback()})},10),this.s.hidden=!1},_fnCollectionHide:function(){var b=this;!this.s.hidden&&this.dom.collection!==null&&(this.s.hidden=!0,a(this.dom.collection).animate({opacity:0},b.s.iOverlayFade,function(a){this.style.display="none"}),a(this.dom.background).animate({opacity:0},b.s.iOverlayFade,function(a){document.body.removeChild(b.dom.background),document.body.removeChild(b.dom.catcher)}))},_fnAdjustOpenRows:function(){var a=this.s.dt.aoOpenRows,b=this.s.dt.oApi._fnVisbleColumns(this.s.dt);for(var c=0,d=a.length;c<d;c++)a[c].nTr.getElementsByTagName("td")[0].colSpan=b}},ColVis.fnRebuild=function(a){var b=null;typeof a!="undefined"&&(b=a.fnSettings().nTable);for(var c=0,d=ColVis.aInstances.length;c<d;c++)(typeof a=="undefined"||b==ColVis.aInstances[c].s.dt.nTable)&&ColVis.aInstances[c].fnRebuild()},ColVis.aInstances=[],ColVis.prototype.CLASS="ColVis",ColVis.VERSION="1.0.8",ColVis.prototype.VERSION=ColVis.VERSION,typeof a.fn.dataTable=="function"&&typeof a.fn.dataTableExt.fnVersionCheck=="function"&&a.fn.dataTableExt.fnVersionCheck("1.7.0")?a.fn.dataTableExt.aoFeatures.push({fnInit:function(a){var b=typeof a.oInit.oColVis=="undefined"?{}:a.oInit.oColVis,c=new ColVis(a,b);return c.dom.wrapper},cFeature:"C",sFeature:"ColVis"}):alert("Warning: ColVis requires DataTables 1.7 or greater - www.datatables.net/download")})(jQuery);
>>>>>>> hsa
