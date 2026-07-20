using System.ComponentModel.DataAnnotations;

namespace ActivityHub.Admin.Models;

public class Post
{
    public int PostId { get; set; }

    public int GroupId { get; set; }

    public int AuthorId { get; set; }

    [Required(ErrorMessage = "Please enter a title.")]
    [StringLength(100, ErrorMessage = "The title can be up to 100 characters long.")]

    public string Title { get; set; } = string.Empty;

    [Required(ErrorMessage = "Please enter the content.")]
    
    public string Content { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; }
}