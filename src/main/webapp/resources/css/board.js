var control = "";

var listpath;
var viewpath;
var writepath;
var replypath;
var modifypath;
var deletepath;

function initPath(){
	listpath = control + "/list.dnb";
	viewpath = control + "/view.dnb";
	writepath = control + "/write.dnb";
	replypath = control + "/reply.dnb";
	modifypath = control + "/modify.dnb";
	deletepath = control + "/delete.dnb";
}

	
function moveBoard(pg, key, word, path) {
	$("#pg").val(pg);
	$("#key").val(key);
	$("#word").val(word);
	$("#commonform").attr("method", "get").attr("action", path).submit();
}