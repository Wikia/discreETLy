class SearchProvider {
    constructor(fieldsClass) {
        this.fields = document.querySelectorAll(fieldsClass);
        this.search = document.getElementById('search');
        this.searchClear = document.getElementById('clear-search-container');
    }

    filterList(nodes, search) {
        nodes.forEach(node => {
            node.style.display = node.firstElementChild.innerText.toLowerCase().includes(search.toLowerCase()) ? "" :
                "none"
        })
    }

    main() {
        this.search.addEventListener('keyup', event => {
            if(event.target.value) { this.searchClear.style.visibility = "visible" } else { this.searchClear.style.visibility = "hidden" };
            this.filterList(this.fields, event.target.value)
          })

        this.searchClear.addEventListener("click", _ => {
            this.search.firstElementChild.value = "";
            this.searchClear.style.visibility = "hidden";
            this.filterList(this.fields, "");
        });
    }
}