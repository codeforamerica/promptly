<<<<<<< HEAD
jQuery.fn.dataTableExt.oApi.fnFilterOnReturn = function (oSettings) {
    var _that = this;

    this.each(function (i) {
        $.fn.dataTableExt.iApiIndex = i;
        var $this = this;
        var anControl = $('input', _that.fnSettings().aanFeatures.f);
        anControl.unbind('keyup').bind('keypress', function (e) {
            if (e.which == 13) {
                $.fn.dataTableExt.iApiIndex = i;
                _that.fnFilter(anControl.val());
            }
        });
        return this;
    });
    return this;
};
=======
jQuery.fn.dataTableExt.oApi.fnFilterOnReturn=function(a){var b=this;return this.each(function(a){$.fn.dataTableExt.iApiIndex=a;var c=this,d=$("input",b.fnSettings().aanFeatures.f);return d.unbind("keyup").bind("keypress",function(c){c.which==13&&($.fn.dataTableExt.iApiIndex=a,b.fnFilter(d.val()))}),this}),this};
>>>>>>> hsa
