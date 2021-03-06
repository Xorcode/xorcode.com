var github = (function(){
  function escapeHtml(str) {
    return $('<div/>').text(str).html();
  }
  function render(target, repos){
    var i = 0, fragment = '', t = $(target)[0];

    for(i = 0; i < repos.length; i++) {
      fragment += '<li><a href="'+repos[i].html_url+'">'+repos[i].name+'</a>\n'+escapeHtml(repos[i].description||'')+'</li>';
    }
    t.innerHTML = fragment;
  }
  return {
    showRepos: function (options) {
      $.getJSON("https://api.github.com/users/"+options.user+"/repos", function (data) {
        var repos = [];
        if (!data) { return; }
        for (var i = 0; i < data.length; i++) {
          if (options.skip_forks && data[i].fork) { continue; }
          repos.push(data[i]);
        }
        repos.sort(function(a, b) {
          var aDate = new Date(a.pushed_at).valueOf(),
              bDate = new Date(b.pushed_at).valueOf();

          if (aDate === bDate) { return 0; }
          return aDate > bDate ? -1 : 1;
        });

        if (options.count) { repos.splice(options.count); }
        render(options.target, repos);
      }).fail(function () {
        $(options.target + ' li.loading').addClass('error').text("Error loading feed");
      });
    }
  };
})();
