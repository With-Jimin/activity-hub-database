using ActivityHub.Admin.Models;
using Microsoft.EntityFrameworkCore;

namespace ActivityHub.Admin.Data;

public class ApplicationDbContext : DbContext
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }

    public DbSet<Post> Posts { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<Post>(entity =>
        {
            entity.ToTable("Posts");

            entity.HasKey(post => post.PostId);

            entity.Property(post => post.PostId)
                .HasColumnName("post_id");

            entity.Property(post => post.GroupId)
                .HasColumnName("group_id");

            entity.Property(post => post.AuthorId)
                .HasColumnName("author_id");

            entity.Property(post => post.Title)
                .HasColumnName("title");

            entity.Property(post => post.Content)
                .HasColumnName("content");

            entity.Property(post => post.CreatedAt)
                .HasColumnName("created_at");
        });
    }
}