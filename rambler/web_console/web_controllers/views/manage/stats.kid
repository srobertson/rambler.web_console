<html py:layout="template('layout')" xmlns:py="http://purl.org/kid/ns#">
  <script language="javascript" type="text/javascript" src="/javascripts/jquery.flot.js"></script>
  
  <script py:def="page_specific_header()" language="javascript" type="text/javascript"><!--
  function fetchData(){
    $.ajax({
      url: '/manage/stats',
      method: 'GET',
      dataType: 'json',
      success: function(charts){
        $.plot($(".placeholder"), charts[0].rows);
      }
    });
  }
  setInterval(fetchData, 15000);
 
  //-->
  </script>
  
  <div py:match="item.tag == 'content'">
    <div py:for="ts in series">
    <h2 py:content="ts.name">Stat Name</h2>
    <div class="placeholder" style="width:600px;height:300px;"></div> 
    <table style="border: 1px solid red">
      <tr><th>Name</th> <span py:strip="True" py:for="s in ts"><th py:content="s.id">0</th></span></tr>
      
      <tr py:for="key in ts.keys"><td py:content="key">Key Name</td><span py:strip="True" py:for="s in ts"><td py:content="s[key]">0</td></span></tr>
      
    </table>
    </div>
  </div>

</html>
