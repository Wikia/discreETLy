

DEFAULT_COLORS = {
    3: "#f86c6b",
    2: "#ffc107",
    1: "#4dbd74",
    0: "black"
}


def tree_diagram(
        values,
        width=400,
        height=250,
        padding=5,
        circle_size=400,
        text_size=12,
        colors=None,
        provide_links = False):
    vis = {
        "$schema": "https://vega.github.io/schema/vega/v4.json",
        "width": width,
        "height": height,
        "padding": padding,
        "signals": [{
            "name": "colors",
            "value": DEFAULT_COLORS
        }],
        "data": [{
            "name": "tree",
            "values": values,
            "transform": [{
                    "type": "stratify",
                    "key": "id",
                "parentKey": "parent"
            },
            {
                "type": "tree",
                        "method": "tidy",
                        "size": [{
                            "signal": "height"
                        }, {
                            "signal": "width - 100"
                        }],
                "as": ["y", "x", "depth", "children"]
            },
            {
                "type": "formula",
                "as": "tlink",
                "expr": "\"tables#\" + datum.tid"
            }]
        },
            {
                "name": "links",
                "source": "tree",
                "transform": [{
                        "type": "treelinks"
                },
                    {
                        "type": "linkpath",
                        "orient": "horizontal",
                        "shape": "diagonal"
                }
                ]
        }
        ],
        "marks": [{
            "type": "path",
            "from": {
                    "data": "links"
            },
            "encode": {
                "update": {
                    "path": {
                        "field": "path"
                    },
                    "stroke": {
                        "value": "#5f7a7b"
                    },
                    "stroke-width": {
                        "value": "60"
                    }
                }
            }
        },
            {
                "type": "symbol",
                "from": {
                    "data": "tree"
                },
                "encode": {
                    "enter": {
                        "size": {
                            "value": circle_size
                        },
                        "stroke": {
                            "value": "#1a1a1a"
                        }
                    },
                    "update": {
                        "x": {
                            "field": "x"
                        },
                        "y": {
                            "field": "y"
                        },
                        "fill": {
                            "signal": "colors[datum.success]"
                            # "scale": "color", "field": "success"
                        }
                    }
                }
        },
            {
                "type": "text",
                "from": {
                    "data": "tree"
                },
                "encode": {
                    "enter": {
                        "text": {
                            "field": "name"
                        },
                        "fontSize": {
                            "value": text_size
                        },
                        "baseline": {
                            "value": "bottom"
                        }
                    },
                    "update": {
                        "x": {
                            "field": "x"
                        },
                        "y": {
                            "field": "y"
                        },
                        "dx": {
                            "signal": "datum.children ? -12 : 12"
                        },
                        "dy": {
                            "signal": "datum.children ? 10 : -5"
                        },
                        "align": {
                            "signal": "datum.children ? 'right' : 'left'"
                        },
                        "opacity": 1
                    }
                }
        }
        ]
    }

    if provide_links:
        activate_links = {"href": {
                            "signal":"datum.tlink"
                        }}

        vis['marks'][1]['encode']['update'].update(activate_links)

    return vis
