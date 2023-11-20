Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83104374ED
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Nov 2023 20:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2022BC433C8;
	Mon, 20 Nov 2023 20:36:10 +0000 (UTC)
Date: Mon, 20 Nov 2023 15:36:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 mhiramat@kernel.org, mark.rutland@arm.com, lkft@linaro.org
Subject: Re: selftests: ftrace: WARNING: __list_del_entry_valid_or_report
 (lib/list_debug.c:62 (discriminator 1))
Message-ID: <20231120153623.49c5119b@gandalf.local.home>
In-Reply-To: <20231116123016.140576-1-naresh.kamboju@linaro.org>
References: <20231116123016.140576-1-naresh.kamboju@linaro.org>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Nov 2023 18:00:16 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Following kernel crash noticed while running selftests: ftrace on arm64 Juno-r2
> device running stable-rc linux-6.6.y kernel.
> 
> This kernel crash is hard to reproduce.
> 

Can you test this patch.

Note, there's a similar bug on 6.7-rc1 which I'll fix first. And when
that's accepted, I'll push this one for v6.6. This may be two patches as
one if the d_invalidate() issue, and another is a memory leak fix.

-- Steve

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 5fcfb634fec2..b60048469df1 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -289,6 +289,8 @@ void eventfs_set_ef_status_free(struct tracefs_inode *ti, struct dentry *dentry)
 		ef = dentry->d_fsdata;
 		if (ef)
 			free_ef(ef);
+		else
+			kfree(ei);
 		return;
 	}
 
@@ -342,7 +344,6 @@ static void eventfs_post_create_dir(struct eventfs_file *ef)
 static struct dentry *
 create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
 {
-	bool invalidate = false;
 	struct dentry *dentry;
 
 	mutex_lock(&eventfs_mutex);
@@ -387,23 +388,24 @@ create_dentry(struct eventfs_file *ef, struct dentry *parent, bool lookup)
 			eventfs_post_create_dir(ef);
 		dentry->d_fsdata = ef;
 	} else {
-		/* A race here, should try again (unless freed) */
-		invalidate = true;
-
 		/*
+		 * If we are here then the directory is being freed.
+		 * The simple_recursive_removal() will get rid of the dentry
+		 * here.
+		 */
+		dentry = NULL;
+		 /*
 		 * Should never happen unless we get here due to being freed.
 		 * Otherwise it means two dentries exist with the same name.
 		 */
 		WARN_ON_ONCE(!ef->is_freed);
 	}
 	mutex_unlock(&eventfs_mutex);
-	if (invalidate)
-		d_invalidate(dentry);
 
-	if (lookup || invalidate)
+	if (lookup)
 		dput(dentry);
 
-	return invalidate ? NULL : dentry;
+	return dentry;
 }
 
 static bool match_event_file(struct eventfs_file *ef, const char *name)
-- 
2.42.0

