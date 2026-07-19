using ActivityHub.Admin.Data;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ActivityHub.Admin.Controllers;

public class PostsController : Controller
{
    private readonly ApplicationDbContext _context;

    public PostsController(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<IActionResult> Index()
    {
        var posts = await _context.Posts
        .OrderByDescending(post => post.PostId)
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

}