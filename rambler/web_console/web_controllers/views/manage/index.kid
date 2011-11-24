<html py:layout="template('layout')" xmlns:py="http://purl.org/kid/ns#">
  <script py:def="page_specific_header()" language="javascript" type="text/javascript"><!--
    var CMDHistory = new function(){
        this.history = [];
        this.pos = 0;

        this.complete = function(){
          var console = $('#console');
          var val = $('#cmd').val();
          if(val){ // ignore empty
            if(this.history[0] != val)
              this.history.unshift(val);
            this.pos = 0;
            console.append("<div class='input'>&gt;&gt;&gt;&nbsp;" + val + "</div>").scrollTop(console.innerHeight());
            $('#cmd').val('');

            $.get('eval', {'cmd':val}, function(data){
              $.each(data.split('\n'), function(i, line){
                console.append("<div class='output'>" + line + "</div>").scrollTop(console.innerHeight());
              });
            });
          }

        }
        this.moveUp = function(){
          if (this.pos < this.history.length){
            $('#cmd').val(this.history[this.pos]);
            this.pos += 1;
          }
        }

        this.moveDown = function(){
          if(this.pos > 0){
            this.pos -= 1;
            $('#cmd').val(this.history[this.pos]);
          }
        }

    }
    $(function() {
      $('#cmd').keyup(function(e){
        switch(e.keyCode){
          case 13:
            CMDHistory.complete();
            break;
          case 38:
            CMDHistory.moveUp();
            break;
          case 40:
            CMDHistory.moveDown();
            break
        }
      });

  $("#cmd").focus();

  });
  //-->
  </script>
  
  <div style="border: 1px solid red; height: 100%" class="grid_8 prefix_4" py:match="item.tag == 'content'" >
    <div id="console" style="overflow: auto;  height:100%">
    </div>

    <form id="cmdline" method="POST" style="width:100%;" onsubmit="return false;" autocomplet="off">
      <div style="padding: 2px; ">
    &gt;&gt;&gt;<input id='cmd' name='cmd' style="border: none; width:90% " autocomplete="off"/>
        </div>

    </form>
  </div>

</html>