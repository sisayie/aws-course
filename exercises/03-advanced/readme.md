# Exercise 03 — Build an API Client

## 🎯 Goal

By the end of this exercise you should be able to:

- make an HTTP request
- handle the response
- deal with errors
- write a test for the client

## ⏱️ Estimated time

30–45 minutes

## 📚 Before you start

You should already understand:

- HTTP basics
- functions
- error handling

Read:

- [HTTP basics](../../docs/http.md)

## 📝 Task

Starting from the code in `starter/`:

1. Implement `getUser()`
2. Handle HTTP errors
3. Return the user data
4. Add a test

Don't look at the solution until you've tried it yourself.

## 💡 Hint 1

Think about what should happen when the server returns 404.

<details>
<summary>Show hint</summary>

Check the HTTP status code before parsing the response.

</details>

## ✅ Verify your solution

Run:

```bash
npm test


You should see:

✓ returns a user
✓ handles 404
✓ handles server errors

🏁 Done?

Once your tests pass:

➡️ Continue to Exercise 04
