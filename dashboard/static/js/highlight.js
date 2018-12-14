const highlightTable = (tid) => {
    document.getElementById(tid).style.backgroundColor = "pink";
    window.scrollBy(0, -100);
};

const checkHighlight = () => {
    if(window.location.hash) 
    { highlightTable(window.location.hash.substr(1));}};