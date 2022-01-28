class Node<T> {
  T value;
  Node<T>? next;
  Node({required this.value, this.next});

  @override
  String toString() {
    if (next == null) return '$value';
    return '$value -> ${next.toString()}';
  }
}

class LinkedList<E> extends Iterable<E> {
  Node<E>? head;
  Node<E>? tail;

  @override
  bool get isEmpty => head == null;

  // inserting operations
  // O(1)
  void push(E value) {
    head = Node(value: value, next: head);
    tail ??= head;
  }

  // O(1)
  void append(E value) {
    if (isEmpty) {
      push(value);
      return;
    }

    tail!.next = Node(value: value);
    tail = tail!.next;
  }

  // O(i)
  Node<E>? nodeAt(int index) {
    var currentNode = head;
    var currentIndex = 0;

    while (currentNode != null && currentIndex < index) {
      currentNode = currentNode.next;
      currentIndex += 1;
    }
    return currentNode;
  }

  // O(1)
  Node<E> insertAfter(Node<E> node, E value) {
    if (tail == node) {
      append(value);
      return tail!;
    }

    node.next = Node(value: value, next: node.next);
    return node.next!;
  }

  // removal operations
  // O(1)
  E? pop() {
    final value = head?.value;
    head = head?.next;
    if (isEmpty) {
      tail = null;
    }
    return value;
  }

  // O(n)
  E? removeLast() {
    if (head?.next == null) return pop();

    var current = head;
    while (current!.next != tail) {
      current = current.next;
    }
    final value = tail?.value;
    tail = current;
    tail?.next = null;
    return value;
  }

  // O(1)
  E? removeAfter(Node<E> node) {
    final value = node.next?.value;
    if (node.next == null) {
      tail = node;
    }
    node.next = node.next?.next;
    return value;
  }

  void reverse() {
    tail = head;
    var previous = head;
    var currentNode = head?.next;
    previous?.next = null;
    while (currentNode != null) {
      final next = currentNode.next;
      currentNode.next = previous;
      previous = currentNode;
      currentNode = next;
    }

    head = previous;
  }

  @override
  String toString() {
    if (isEmpty) return 'Empty list';
    return head.toString();
  }

  @override
  Iterator<E> get iterator => _LinkedListIterator(this);
}

class _LinkedListIterator<E> implements Iterator<E> {
  _LinkedListIterator(LinkedList<E> list) : _list = list;
  final LinkedList<E> _list;
  Node<E>? _currentNode;

  @override
  E get current => _currentNode!.value;

  bool _firstPass = true;

  @override
  bool moveNext() {
    if (_list.isEmpty) return false;

    if (_firstPass) {
      _currentNode = _list.head;
      _firstPass = false;
    } else {
      _currentNode = _currentNode?.next;
    }

    return _currentNode != null;
  }
}

void printInReverse<E>(LinkedList<E> list) {
  // for (var i = list.length - 1; i <= 0; i++) {
  //   final node = list.nodeAt(i - 1)!;
  //   final value = list.removeAfter(node);
  //   print(value);
  // }

  printNodesRecursively(list.head);
}

void printNodesRecursively<T>(Node<T>? node) {
  if (node == null) return;

  printNodesRecursively(node.next);

  print(node.value);
}


// my solution is faster than ray wenderlich's 😸😸
extension RemovableLinkedList<E> on LinkedList {
  // ray solution
  void removeAll(E value) {
    var previous = head;
    var current = head?.next;
    while (current != null) {
      if (current.value == value) {
        previous?.next = current.next;
        current = previous?.next;
        continue;
      }
      previous = current;
      current = current.next;
    }
    tail = previous;
  }

  // my solution
  void removeAllOccurrences(E target) {
    var currentNode = head;
    while (currentNode != null) {
      if (currentNode.next?.value == target) {
        currentNode.next = currentNode.next?.next;
      } else {
        currentNode = currentNode.next;
      }
    }
  }
}

LinkedList<E> reverseLinkedList<E>(LinkedList<E> list) {
  var currentNode = list.head;
  final newList = LinkedList<E>();
  if (list.isEmpty) return newList;
  while (currentNode != null) {
    newList.push(currentNode.value);
    currentNode = currentNode.next;
  }

  return newList;
}

//  correct solution
Node<E>? getMiddle<E>(LinkedList<E> list) {
  var slow = list.head;
  var fast = list.head;

  while (fast?.next != null) {
    fast = fast?.next?.next;
    slow = slow?.next;
  }

  return slow;
}

// wrong solution
void findTheMiddleNode<E>(LinkedList<E> list) {
  var length = lengthOfList(list);
  print(length);
  var middleNode = list.nodeAt(length ~/ 2);
  print(middleNode?.value);
}

int lengthOfList<E>(LinkedList<E> list) {
  var currentNode = list.head;
  var count = 0;
  if (list.isEmpty) return count;
  while (currentNode != null) {
    currentNode = currentNode.next;
    count += 1;
  }
  count += 1;
  return count;
}
