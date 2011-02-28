// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// TODO: Will need to generalise this into some kind of plugin for lists at some stage in the future...
$(function() {
  var tbody = $('.listTable tbody');
  tbody.click(function(event) {
    var node = event.target;
    while (node && node.tagName != 'TR') {
      node = node.parentNode;
    }
    if (node) { window.location = $(node).attr('data-href'); }
  });
});

// TODO: Will need to apply this to the product backlog ONLY
$(function() {
  $(".sortableList").sortable({
    axis: 'y',
    containment: 'parent',
    cursor: 'move',
    update: function(event, ui) {
      var id = ui.item.attr('data-id');
      var isMovingUp = ui.position.top < ui.originalPosition.top;
      // TODO: Need to get the previous item if we are moving the story down the list
      var nextItem = isMovingUp ? ui.item.next() : ui.item.prev();
      if (nextItem) {
        var new_priority = nextItem.attr('data-priority');
        $.post('/stories/' +  id + '/reprioritise?priority=' + new_priority, 
          {},
          function(result) { $('.listPanel').html(result); }
        );
      }
    }
  });
});
