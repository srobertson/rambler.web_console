from Rambler import outlet,component
import sys
import cgi
import urllib
import gc
from cStringIO import StringIO

# TODO: If we error out while iterating, we should get the error message
import pkg_resources


import traceback
class ManageController(component('WebController')):
  compReg = outlet('ComponentRegistry')
  debug_service = outlet('DebugService')
  
  OperationQueue = outlet('OperationQueue')
  TimeSeries = outlet('TimeSeries')
  ConfigService = outlet('ConfigService')
    
  context = {}
  
  def index(self):
    return
  console = index
  
  def eval(self):
    cmd = self.params.get('cmd')
    self.context['self'] = self
    self.context['app'] = self.app
    if cmd:
      # temp redirect stdout to memory
      old = sys.stdout
      sys.stdout = stdout = StringIO()
      try:
        code = compile(cmd,'<string>','single')
        eval(code, globals(), self.context)
        output = cgi.escape(stdout.getvalue())
      except:
        output = traceback.format_exc()
      sys.stdout = old
      
      self.render(text=output)
      
  def refcount(self):
    self.render(text=self.debug_service.refcount(25))
    
  def operations(self):
    accept = self.request.accept.best_match(['text/html','application/json'])
    if 'application/json' != accept:
      # Not an AJAX call, return so the default template will render
      return
      
    queues = [i for i in gc.get_referrers(self.OperationQueue) if isinstance(i, self.OperationQueue)]
    # see if a queue_name was specified on the URL http://../operation_queue/<name>
    queue_name = urllib.unquote_plus(self.request.path_info.rsplit('/',1)[1])

    result = {'queues': [q.name for q in queues]}
    try:
      queue_name = self.params.getone('id')
    except KeyError:
      queue_name = result['queues'][0]
      
    # find the queue specified
    for queue in queues:
      if queue.name == queue_name:
        operations = []
        for op in queue.operations:
          operations.append(str(op))
        result['operations'] = operations
        result['name'] = queue.name

    self.render(json=result)
    
  def stats(self):
    accept = self.request.accept.best_match(['text/html', 'application/json'])
    time_series = self.TimeSeries.series.values()
    if accept == 'text/html':
      self.title = "Stats"
      self.series = time_series
    elif accept == 'application/json':
      ret = []

      for ts in time_series:
        # {  'name':'SQS', 
        #  'series':[
        #           {'label': 'Blah',
        #             'data':[]    }]}

        labels = sorted(ts.keys)
        chart = {'name': ts.name}
        chart['rows'] = [{'label': label, 'data':[]} for label in labels]
        for s in ts:
          for x,label in enumerate(labels):
            chart['rows'][x]['data'].append([s.id,s[label]])
        ret.append(chart)

      self.render(json=ret)
      
  def options(self):
    """Returns all options
    Formated as an HTML page when GET
    Saves the option on a POST
    Returns as json when Accept: application/json
    
    """
    self.title = self.action
    accept = self.request.accept.best_match(['text/html', 'application/json'])

    if accept == 'application/json':
      self.render(json=list(self.ConfigService.items()))
    else:
      if self.request.method == 'POST':
        params = self.params
        self.ConfigService.set(params['id'], params['value'])
        self.render(text=params['value'])
        return
    # if we made it here, render the html
        

    