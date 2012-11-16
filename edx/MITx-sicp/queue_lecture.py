class Queue(object):
    def __init__(self):
        self.values = []
    def insert(self, v):
        self.values.append(v)
    def remove(self):
        if len(self.values) == 0:
            raise ValueError("remove from empty queue")
        result = self.values[0]
        del(self.values[0])
        return result
q = Queue()
q.insert(5)
q.insert(6)
print q.remove()
q.insert(7)
print q.remove()
print q.remove()
print q.remove()
