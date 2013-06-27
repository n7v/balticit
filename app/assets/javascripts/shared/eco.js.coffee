EcoHelpers =
  merge: (objs...) ->
    dest = {}
    for obj in objs
      dest[k] = v for k, v of obj
    dest
  ,
  render: (template_name, context) ->
    _context = context || {}
    _context = EcoHelpers.merge(_context, EcoHelpers)
    JST["templates/#{template_name}"](_context)


$.app.render = (template_name, data) ->
  html = EcoHelpers.render(template_name, data)
  $(html)