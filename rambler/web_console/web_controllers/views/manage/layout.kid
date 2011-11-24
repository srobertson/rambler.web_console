<?python
def page_specific_header():
  return None
?>

<html xmlns:py="http://purl.org/kid/ns#">
  <head>
    <title>Manage - {action}</title>
    <style type="text/css" title="currentStyle">
      @import "/css/reset.css";
      @import "/css/text.css";
      @import "/css/960.css";
      @import "/javascripts/DataTables-1.7.3/media/css/demo_page.css";
      @import "/javascripts/DataTables-1.7.3/media/css/demo_table.css";
      
      body{font-family:Helvetica;}
      
      html,body{height:90%;}
      #content{
        -webkit-border-radius: 8px;
        -webkit-box-shadow: 0 0 -1px white,  0 0 1px rgba(0,0,0,.5) ;
        padding: 5px;
        background: -webkit-gradient(linear, left top, left bottom, color-stop(0.1, #ffffff), color-stop(0, #eeeeee));
      }
      input{
        -webkit-border-radius: 4px;
        -webkit-box-shadow: 0 0 -1px white,  0 0 1px rgba(0,0,0,.5) ;
      }
      #navigation{
        padding: 10px;
        background-color: #cccccc;
        -webkit-border-radius: 4px;
        -webkit-box-shadow: 0 0 -1px white,  0 0 1px rgba(0,0,0,.5) ;
        background: -webkit-gradient(linear, left top, left bottom, from(#ccc), to(#eeeeee)); /* for webkit browsers */
      }
      #navigation a{
        padding-left: 10px;
        padding-right: 10px;
        color: rgba(26,26,26,1);
        font-family: 'Lucida Grande', Geneva, Arial, Verdana, sans-serif;
        text-shadow: white 0px 0px -10px, rgba(0,0,0,.5) 0px 0px 1px;
        text-shadow: white 1px 1px 1px;
        text-decoration:none;
        border-left: 1px solid black;
       
      }
      #navigation a:before{
        border-left: 1px solid red;
        content: "";
        position:absolute;
      }
      
      #navigation a:first-child{
        border-left: none;
      }
      #navigation input:last-child{
        float:right;
      }
      
    </style>
    <script language="javascript" type="text/javascript" src="/javascripts/jquery.js"></script>
    <script language="javascript" type="text/javascript" src="/javascripts/jquery.jeditable.mini.js"></script>
    <script type="text/javascript" language="javascript" src="/javascripts/DataTables-1.7.3/media/js/jquery.dataTables.js"></script>
    
    ${page_specific_header()}
    
  </head>
  
  <body >
    
    
    <div class="container_12">    
      <div id="navigation">
        <a href="/manage/">Console</a>
        <a href="/manage/stats">Stats</a>
        <a href="/manage/operations">Operations</a>
        <a href="/manage/options">Options</a>
        <input type="search" />
      </div>
      
      <content>Default content</content>

    </div>
    
  </body>
</html>