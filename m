Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1561DC726;
	Tue,  3 Sep 2024 19:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725393031; cv=none; b=BnPSvuBcvsE1JHo9D1ecgxsanFufJuY8m4UBxGMGyJbR9h6AwTu/yC2vrAp/dF3G0LW6X23ySE8aMkwPHn/aDkzw3ALZ01gaIQ5rPWi2ogz4jdzneDAZE1LVIQy+aSMFmO+elVUYYn0Q4X0WMkBTfUOSee6EWgzH3EsSv+nbw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725393031; c=relaxed/simple;
	bh=nxfDSL7XFajERSWNAjfIDt2oU1oJqzI1XAPp/P2YUxE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XnCexR6wPZcRTlm8bW4hDykKtSLCiW3ZDRHvKGEV5Ch7SZSf7DmZYDdLzehoH2FSGDAbxG2TGGzQ75dyd0C3pQxmXOF1sEiUUR3BX6De3SkOPmBB0/xv/63XIEkzowyPX9wSFYDf7M36RXMpCyIWfpGMmoXaUcnXn+ZPPfEPOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8311BC4CEC4;
	Tue,  3 Sep 2024 19:50:30 +0000 (UTC)
Date: Tue, 3 Sep 2024 15:51:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Chi Zhiling <chizhiling@163.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Chi
 Zhiling <chizhiling@kylinos.cn>
Subject: Re: [PATCH] eventfs: fix a null pointer access in eventfs_iterate
Message-ID: <20240903155128.5e02e40a@gandalf.local.home>
In-Reply-To: <20240829032436.2997321-1-chizhiling@163.com>
References: <20240829032436.2997321-1-chizhiling@163.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Aug 2024 11:24:36 +0800
Chi Zhiling <chizhiling@163.com> wrote:

> From: Chi Zhiling <chizhiling@kylinos.cn>
> 
> We found a null pointer accessing in tracefs[1], the reason is that
> the variable 'ei_child' is set to LIST_POISON1, that means the list
> was removed in eventfs_remove_rec. so when access the ei_child->is_freed,
> the panic triggered.
> 
> the linked list is protected by eventfs_mutex in eventfs_remove_rec,

Only writes of the link list is protected by the mutex. Reads are not.

> so when we access the list of ei_child in eventfs_iterate, we also need
> a mutex_lock in there to avoid eventfs_remove_rec modify the list.

Yes you hit a bug, but no this is *not* the solution!


> Signed-off-by: Chi Zhiling <chizhiling@kylinos.cn>
> ---
>  fs/tracefs/event_inode.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 01e99e98457d..4895ed07376b 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -642,6 +642,7 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  	/* Subtract the skipped entries above */
>  	c -= min((unsigned int)c, (unsigned int)ei->nr_entries);
>  
> +	mutex_unlock(&eventfs_mutex);

This list is protected by SRCU (hence the name of the iterator), if you
need to add a mutex around it, something else is broken.

>  	list_for_each_entry_srcu(ei_child, &ei->children, list,
>  				 srcu_read_lock_held(&eventfs_srcu)) {
>  
> @@ -659,9 +660,12 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  
>  		ino = eventfs_dir_ino(ei_child);
>  
> -		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
> +		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR)) {
> +			mutex_unlock(&eventfs_mutex);
>  			goto out_dec;
> +		}
>  	}
> +	mutex_unlock(&eventfs_mutex);
>  	ret = 1;
>   out:
>  	srcu_read_unlock(&eventfs_srcu, idx);

The real fix is:

diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
index 01e99e98457d..8705c77a9e75 100644
--- a/fs/tracefs/event_inode.c
+++ b/fs/tracefs/event_inode.c
@@ -862,7 +862,7 @@ static void eventfs_remove_rec(struct eventfs_inode *ei, int level)
 	list_for_each_entry(ei_child, &ei->children, list)
 		eventfs_remove_rec(ei_child, level + 1);
 
-	list_del(&ei->list);
+	list_del_rcu(&ei->list);
 	free_ei(ei);
 }
 
Can you test that and let me know if it fixes your issue. I'll just go
ahead and apply it as it is an obvious bug.

-- Steve
