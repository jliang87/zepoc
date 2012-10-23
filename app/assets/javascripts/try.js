/**
 * Created with JetBrains RubyMine.
 * User: jackliang
 * Date: 2012-10-23
 * Time: 12:32 AM
 * To change this template use File | Settings | File Templates.
 */
var jcrop_api, boundx, boundy;

$('#target').Jcrop({
    onChange: updatePreview,
    onSelect: updatePreview,
    aspectRatio: 1
},function(){
    // Use the API to get the real image size
    var bounds = that.getBounds();
    boundx = bounds[0];
    boundy = bounds[1];
    // Store the API in the jcrop_api variable
    jcrop_api = that;
});

function updatePreview(c)
{
    if (parseInt(c.w) > 0)
    {
        var rx = 100 / c.w;
        var ry = 100 / c.h;

        $('#preview').css({
            width: Math.round(rx * boundx) + 'px',
            height: Math.round(ry * boundy) + 'px',
            marginLeft: '-' + Math.round(rx * c.x) + 'px',
            marginTop: '-' + Math.round(ry * c.y) + 'px'
        });
    }
};