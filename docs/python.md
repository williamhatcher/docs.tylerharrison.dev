# Python

A comprehensive guide to the Python programming language.

## Fixing Pylint Import false positives

Pylint is a static code analysis tool for Python. It is a great tool for finding bugs and enforcing code style. However, it can be a bit annoying when it reports false positives for import errors. For example, if you have a file called `foo.py` and you import it in another file called `bar.py`, Pylint will report an error for the import statement in `bar.py` even though the import is valid. This is because Pylint does not know where to find the `foo.py` file. Some people report that this can be fixed by creating an empty `__init__.py` file in the root of the project, but I did not have luck with that. The approach that worked for me was adding the following to the root of your project:

```bash
[MASTER]
init-hook="from pylint.config import find_pylintrc; import os, sys; sys.path.append(os.path.dirname(find_pylintrc()))"
```

This will add the root of your project to the Python path, which will allow Pylint to find the files you are importing.

## Useful Python Libraries

Various Python libraries that I have found useful sorted by category.

### Data Structures

- [pydlib](https://pypi.org/project/pydlib/) - Crawls a nested structure and returns the value(s) at the specified path. Uses a dot-separated string to specify the path.

    Example:

    ```python
    >>> import pydlib as dl

    >>> dictionary = {
    >>>   'path': {
    >>>       'to': {
    >>>          'nested': {
    >>>             'field': 42
    >>>           }
    >>>        }
    >>>    }
    >>> }
    >>> dl.get(dictionary, path='path.to.nested.field', default=0)
    42
    ```
