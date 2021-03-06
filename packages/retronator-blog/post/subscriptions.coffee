AE = Artificial.Everywhere
Blog = Retronator.Blog

# Get a subset of all blog posts.
Blog.Post.all.publish (limit) ->
  check limit, Match.OptionalOrNull Number

  Blog.Post.documents.find {},
    sort:
      time: -1
    limit: limit
    fields:
      data: 0

# Get blog posts for a certain date range.
Blog.Post.forDateRange.publish (dateRange) ->
  check dateRange, AE.DateRange

  query = {}

  dateRange.addToMongoQuery query, 'time'

  Blog.Post.documents.find query,
    fields:
      data: 0

# Get a specific blog post.
Blog.Post.forId.publish (id) ->
  check id, Match.DocumentId

  Blog.Post.documents.find id,
    fields:
      data: 0

# Get a specific blog post based on tumblr ID.
Blog.Post.forTumblrId.publish (id) ->
  check id, Match.Integer

  Blog.Post.documents.find
    'tumblr.id': id
  ,
    fields:
      data: 0
