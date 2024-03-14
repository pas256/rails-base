# app/utils

My thinking is that backend-only utilities go here, with their tests in `test/utils`. This is to separate `helpers` which are primarily front-end and accessible by views. `utils` on the other hand are primarily backend and are not accessible by views.
