namespace ActivityHub.Admin.Models;

public class Post
{
    public int PostId { get; set; }

    public int GroupId { get; set; }

    public int AuthorId { get; set; }

    public string Title { get; set; } = string.Empty;

    public string Content { get; set; } = string.Empty;

    public DateTime CreatedAt { get; set; }
}