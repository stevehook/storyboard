// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// This is needed since Rails 3.0.4 to ensure that the CSRF token is sent with all Ajax requests
$(document).ajaxSend(function(e, xhr, options) {
  var token = $("meta[name='csrf-token']").attr("content");
  xhr.setRequestHeader("X-CSRF-Token", token);
});

// This ensures that all Ajax calls request format js
$.ajaxSetup({ 
  'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")}
})

// Automatically set focus to the first field on a form
$(function() {
  $("input:text:visible:first").focus();
});

// Automatically set focus to the first field on a form
$(function() {
  var positionDocument = function() {
    var document = $('#document');
    var header = $('#header');
    document.css('margin-top', header.height() + 'px');
  }
  positionDocument();
  $(window).resize(positionDocument);
});

$(function() {
  $('#task_estimate').change(function() {
    var $this = $(this);
    var remaining = $('#task_remaining');
    if (remaining.val() === '') { remaining.val($this.val()); }
  });
});

// taskForm plugin - specific code for the task form
(function($) {
  var defaults = {};
  $.fn.taskForm = function() {        
    return this.each(function() {
      if (this.taskForm) { return false; }
      var self = {   
        initialize: function() {
          $(".listFilterPanel select").change(function() {
            var $this = $(this);
            $('#story_filter_form').submit();
          });
        }
      };
      this.taskForm = self;
      self.initialize();      
    });
  };
})(jQuery);

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

// productBacklog plugin - used only on the product backlog page
(function($) {
  var defaults = {};
  $.fn.productBacklog = function() {        
    return this.each(function() {
      if (this.productBacklog) { return false; }
      var self = {   
        initialize: function() {
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
          $(".listFilterPanel select").change(function() {
            var $this = $(this);
            $('#story_filter_form').submit();
          });
        }
      };
      this.productBacklog = self;
      self.initialize();      
    });
  };
})(jQuery);

// teamOrganisation plugin - used on the admin page to enable the drag and drop operations
// to move people between different teams
(function($) {
  var defaults = {};
  $.fn.teamOrganisation = function() {        
    return this.each(function() {
      if (this.teamOrganisation) { return false; }
      var self = {   
        initialize: function() {
          $('.dragSource').live('mouseover', function(event) {
            $this = $(this);
            if (!$this.data('initdrag')) {
              $this.data("initdrag", true); 
              $this.draggable({
                cursor: 'move',
                revert: 'invalid',
                handle: 'img',
                update: function(event, ui) {
                }
              });
            }
          });
          console.log($(".dragTarget").length);
          $(".dragTarget").droppable({
            tolerance: 'pointer',
            hoverClass: 'dragTargetHover',
            drop: function(event, ui) {
              ui.draggable.css('left', '');
              ui.draggable.css('position', '');
              ui.draggable.appendTo(event.target);
              var userId = ui.draggable.attr('data-id');
              var target = $(this);
              $this = $(this);
              var teamId = $this.attr('data-id');
              if (!teamId) { teamId = ''; }
              $.ajax({
                url: '/users/' + userId,
                type: 'POST',
                dataType: 'json',
                data: { _method: 'PUT', user: { team_id: teamId }, commit: true },
                success: function(result) { console.log('moved'); }
              });
            }
          });
        }
      };
      this.teamOrganisation = self;
      self.initialize();      
    });
  };
})(jQuery);

// sprintPlanning plugin - used on the sprint planning page to enable the drag and drop operations
// between backlog and committed lists
(function($) {
  var defaults = {};
  $.fn.sprintPlanning = function() {        
    return this.each(function() {
      if (this.sprintPlanning) { return false; }
      var self = {   
        initialize: function() {
          $('.dragSource .listItem').live('mouseover', function(event) {
            $this = $(this);
            if (!$this.data('initdrag')) {
              $this.data("initdrag", true); 
              $this.draggable({
                cursor: 'move',
                revert: 'invalid',
                update: function(event, ui) {
                }
              });
            }
          });
          $(".dragTarget").droppable({
            drop: function(event, ui) {
              ui.draggable.css('left', '');
              ui.draggable.css('position', '');
              ui.draggable.appendTo(event.target);
              var id = ui.draggable.attr('data-id');
              var target = $(this);
              var sprint_id = target.attr('data-sprint');
              if (sprint_id) {
                console.log('committing story ' + id + ' to sprint ' + sprint_id);
                $.post('/stories/' +  id + '/commit?sprint_id=' + sprint_id, 
                  {},
                  function(result) {
                    target.html(result); 
                    var updated_count = $('#updated_points_count', target);
                    $('#points_count').html('Total points ' + updated_count.val());
                  }
                );
              } else {
                console.log('uncommitting story ' + id);
                $.post('/stories/' +  id + '/uncommit', 
                  {},
                  function(result) {
                    target.html(result); 
                    var updated_count = $('#updated_points_count', target);
                    $('#points_count').html('Total points ' + updated_count.val());
                  }
                );
              }
            }
          });
          $('#planningBacklog .pagination a').live('click', function () {  
            $.get(this.href, function(result) {
                console.log(result);
                console.log($('#planningBacklog'));
                $('#planningBacklog').html(result); 
              });  
            return false;  
          });
        }
      };
      this.sprintPlanning = self;
      self.initialize();      
    });
  };
})(jQuery);

// taskBoard plugin - used on the taskboard page to enable drag and drop of tasks between different
// status columns
(function($) {
  var defaults = {};
  $.fn.taskBoard = function() {        
    return this.each(function() {
      if (this.taskBoard) { return false; }
      var self = {   
        initialize: function() {
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
        }
      };
      this.taskBoard = self;
      self.initialize();      
    });
  };
})(jQuery);

