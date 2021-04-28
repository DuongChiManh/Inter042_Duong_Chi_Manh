// missingValues
var A = [7, 2, 5, 3, 5, 3];
var B = [7, 2, 5, 4, 6, 3, 5, 3];
var result = []
var temp = true;
function missvalue(A, B) {
    var temp = true;
    for(var i = 0; i < A.length; i++) {
        for(var j = 0; j < B.length; j++){
            if(A[i] == B[j]) {
            temp = false;
            }   
            // console.log(temp)   
        }
        if(temp) {
           result.push(A[i]);
        }
        temp = true;
    }
    return result.sort(function(a, b){return a - b});
}
result = A.length > B.length ? missvalue(A, B) : missvalue(B, A); 
console.log(result);
// ======================================
var submit = document.querySelector('input[tyle="text"]');
console.log(submit);