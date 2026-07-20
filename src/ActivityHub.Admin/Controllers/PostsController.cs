using ActivityHub.Admin.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ActivityHub.Admin.Models;

namespace ActivityHub.Admin.Controllers;

public class PostsController : Controller
{
    private readonly ApplicationDbContext _context;

    public PostsController(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IActionResult> Index(int page = 1)
    {
        int pageSize = 10;

        var totalPosts = await _context.Posts.CountAsync();

        ViewBag.CurrentPage = page;
        ViewBag.TotalPages = (int)Math.Ceiling(totalPosts / (double)pageSize);

        var posts = await _context.Posts
            .OrderByDescending(post => post.PostId)   // 기존 정렬 유지
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToListAsync();

        return View(posts);
    }

    public async Task<IActionResult> Details(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var post = await _context.Posts
            .FirstOrDefaultAsync(post => post.PostId == id);

        if (post == null)
        {
            return NotFound();
        }

        return View(post);
    }

    // GET: Posts/Create
    [HttpGet]
    public IActionResult Create()
    {
        return View();
    }

    // POST: Posts/Create
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Create(Post post)
    {
        if (ModelState.IsValid)
        {
            post.GroupId = 1;
            post.AuthorId = 1;
            post.CreatedAt = DateTime.Now;

            _context.Posts.Add(post);
            await _context.SaveChangesAsync();

            return RedirectToAction(nameof(Index));
        }

        return View(post);
    }

    // GET: Posts/Delete/5
    [HttpGet]
    public async Task<IActionResult> Delete(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var post = await _context.Posts
            .FirstOrDefaultAsync(post => post.PostId == id);

        if (post == null)
        {
            return NotFound();
        }

        return View(post);
    }

    // POST: Posts/Delete/5
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Delete(int postId)
    {
        var post = await _context.Posts.FindAsync(postId);

        if (post == null)
        {
            return NotFound();
        }

        _context.Posts.Remove(post);
        await _context.SaveChangesAsync();

        return RedirectToAction(nameof(Index));
    }

    // GET: Posts/Edit/5
    [HttpGet]
    public async Task<IActionResult> Edit(int? id)
    {
        if (id == null)
        {
            return NotFound();
        }

        var post = await _context.Posts.FindAsync(id);

        if (post == null)
        {
            return NotFound();
        }

        return View(post);
    }

    // POST: Posts/Edit/5
    [HttpPost]
    [ValidateAntiForgeryToken]
    public async Task<IActionResult> Edit(Post post)
    {
        if (!ModelState.IsValid)
        {
            return View(post);
        }

        var existingPost = await _context.Posts.FindAsync(post.PostId);

        if (existingPost == null)
        {
            return NotFound();
        }

        existingPost.Title = post.Title;
        existingPost.Content = post.Content;

        await _context.SaveChangesAsync();

        return RedirectToAction(nameof(Index));
    }
}