// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// This is needed since Rails 3.0.4 to ensure that the CSRF token is sent with all Ajax requests
$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});

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

// TODO: Will need to apply this to the taskboard ONLY
$(function() {
  var resizeTaskboard = function() {
    $('.taskBoardRow').each(function(index, row) {
      var subPanels = $('.subPanel', row);
      var maxHeight = 0;
      subPanels.each(function(panelIndex, panel) {
        maxHeight = Math.max(maxHeight, $(panel).height());
      });
      subPanels.css('min-height', maxHeight + 'px');
    });
  }
  var positionDocument = function() {
    var document = $('#document');
    var header = $('#header');
    document.css('margin-top', header.height() + 'px');
  }
  resizeTaskboard();
  $('.taskPanel').draggable({axis: 'x', revert: 'invalid'});
  $('.taskSubPanel').droppable({
    drop: function(event, ui) {
      ui.draggable.css('left', '');
      ui.draggable.appendTo(event.target);
      var newStatus = $(event.target).attr('data-status');
      var storyId = ui.draggable.attr('data-story-id');
      var id = ui.draggable.attr('data-id');
      $.post('/stories/' + storyId + '/tasks/' + id + '/update_status?status=' + newStatus, 
        {},
        function(result) {
          ui.draggable.replaceWith(result);
          $('.taskPanel').draggable({axis: 'x'});
          resizeTaskboard();
        }
      );
    }
  });
  positionDocument();
  $(window).resize(positionDocument);
});

