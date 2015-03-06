function arrayg(first) {
	var array = [];
	function more(next) {
		if (next === undefined) {
			return array;
		}
		array.push(next);
		return more;
	}
	return more(first);
}


function arrayg(first) {
	if (first === undefined) {
		return [];
	}
	return liftg(

	)
}

function unaryc(unary) {
	return function (callback, x) {
		return callback(unary(x));
	};
}

wwww.crockford.com/pp/problems.pptx