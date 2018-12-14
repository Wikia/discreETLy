const render = (element, spec) => {
    new vega.View(vega.parse(spec))
        .renderer('svg') // set renderer (canvas or svg)
        .initialize(element) // initialize view within parent DOM container
        .run();
}