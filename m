Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A8CB8F64;
	Thu,  5 Jun 2025 01:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749085501; cv=none; b=KknNm+mDqyWEagFEnYNX4JsqXjcbk9YYylv2W4ZhxFjnaoQGE07eR+HwJybgwGeaSWf1dduk1yxWMOykIQ0jgDB+FkL7VmgW3ah7w+8eOvimP1ixL7rWYVSS0ZUPwlaLeFaKrZqHqfU46fbmWkPDZfdRvp0MkwUZf3jwjPvcLSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749085501; c=relaxed/simple;
	bh=1xWCYJUzcVE9fastKj+mLIk0SikYvKYRyzfd7zwHjqU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g4NzahqaeCr9F56gvIG2lSa0/8Y5NCyoBvvFdu9t4kxxfNdW2h9UcCMUWymygay5Wwk3ocWmyyfzAwUc1CVr1GMTA60nIBo14uqbro8etsGNnzaVYyV2kjNl7DjWSH8PjhD3Et63TgpQvbNXTkO3mtthrL9mNQ2bqUUZpUiKsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DymsQzvg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DymsQzvg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4DFAC4CEE4;
	Thu,  5 Jun 2025 01:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749085500;
	bh=1xWCYJUzcVE9fastKj+mLIk0SikYvKYRyzfd7zwHjqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DymsQzvgdtAO4Mnbi+bVuX8f3gI4Jt12psyC0q27OQfw7Wzna0aChA43jbQb4GGE1
	 tsDNbD71qsgoAP3fsjd9/woO2Ze8AzI+khNIPmfUwrbgULIADMu7M15Jidg0UER2v2
	 v3gKG3NQa2pD2QyZfPr4MWyPXEQ/XL73EGoslOqPpyGWUUnyQ/wC6QISmEBoUsA07b
	 JOuSUvEroBOh4p9vzRtuRQemTMpC94QRGOXdO31R6XcAfnvqYz7KyaRxBzzpsEhD/4
	 jYUm2H0tcRjgT28pmpcmgoMmFer7KzTATs7NBEDf7Ost4p6SyFvf5zVXt+NLIkDl7o
	 DKjvgIUo98SMg==
Date: Thu, 5 Jun 2025 10:04:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] eventfs: Simplify code using guard()s
Message-Id: <20250605100458.dc8c85fec33d8f8ca54dbc44@kernel.org>
In-Reply-To: <20250604151625.250d13e1@gandalf.local.home>
References: <20250604151625.250d13e1@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 4 Jun 2025 15:16:25 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Use guard(mutex), scoped_guard(mutex) and guard(src) to simplify the code
> and remove a lot of the jumps to "out:" labels.
> 

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  fs/tracefs/event_inode.c | 96 +++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 60 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 8705c77a9e75..117110fbabbf 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -180,29 +180,25 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
>  	const char *name;
>  	int ret;
>  
> -	mutex_lock(&eventfs_mutex);
> +	guard(mutex)(&eventfs_mutex);
>  	ei = dentry->d_fsdata;
> -	if (ei->is_freed) {
> -		/* Do not allow changes if the event is about to be removed. */
> -		mutex_unlock(&eventfs_mutex);
> +	/* Do not allow changes if the event is about to be removed. */
> +	if (ei->is_freed)
>  		return -ENODEV;
> -	}
>  
>  	/* Preallocate the children mode array if necessary */
>  	if (!(dentry->d_inode->i_mode & S_IFDIR)) {
>  		if (!ei->entry_attrs) {
>  			ei->entry_attrs = kcalloc(ei->nr_entries, sizeof(*ei->entry_attrs),
>  						  GFP_NOFS);
> -			if (!ei->entry_attrs) {
> -				ret = -ENOMEM;
> -				goto out;
> -			}
> +			if (!ei->entry_attrs)
> +				return -ENOMEM;
>  		}
>  	}
>  
>  	ret = simple_setattr(idmap, dentry, iattr);
>  	if (ret < 0)
> -		goto out;
> +		return ret;
>  
>  	/*
>  	 * If this is a dir, then update the ei cache, only the file
> @@ -225,8 +221,6 @@ static int eventfs_set_attr(struct mnt_idmap *idmap, struct dentry *dentry,
>  			}
>  		}
>  	}
> - out:
> -	mutex_unlock(&eventfs_mutex);
>  	return ret;
>  }
>  
> @@ -528,26 +522,24 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  	struct tracefs_inode *ti;
>  	struct eventfs_inode *ei;
>  	const char *name = dentry->d_name.name;
> -	struct dentry *result = NULL;
>  
>  	ti = get_tracefs(dir);
>  	if (WARN_ON_ONCE(!(ti->flags & TRACEFS_EVENT_INODE)))
>  		return ERR_PTR(-EIO);
>  
> -	mutex_lock(&eventfs_mutex);
> +	guard(mutex)(&eventfs_mutex);
>  
>  	ei = ti->private;
>  	if (!ei || ei->is_freed)
> -		goto out;
> +		return NULL;
>  
>  	list_for_each_entry(ei_child, &ei->children, list) {
>  		if (strcmp(ei_child->name, name) != 0)
>  			continue;
>  		/* A child is freed and removed from the list at the same time */
>  		if (WARN_ON_ONCE(ei_child->is_freed))
> -			goto out;
> -		result = lookup_dir_entry(dentry, ei, ei_child);
> -		goto out;
> +			return NULL;
> +		return lookup_dir_entry(dentry, ei, ei_child);
>  	}
>  
>  	for (int i = 0; i < ei->nr_entries; i++) {
> @@ -561,14 +553,12 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  
>  		data = ei->data;
>  		if (entry->callback(name, &mode, &data, &fops) <= 0)
> -			goto out;
> +			return NULL;
> +
> +		return lookup_file_dentry(dentry, ei, i, mode, data, fops);
>  
> -		result = lookup_file_dentry(dentry, ei, i, mode, data, fops);
> -		goto out;
>  	}
> - out:
> -	mutex_unlock(&eventfs_mutex);
> -	return result;
> +	return NULL;
>  }
>  
>  /*
> @@ -584,7 +574,6 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  	struct eventfs_inode *ei;
>  	const char *name;
>  	umode_t mode;
> -	int idx;
>  	int ret = -EINVAL;
>  	int ino;
>  	int i, r, c;
> @@ -598,16 +587,13 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  
>  	c = ctx->pos - 2;
>  
> -	idx = srcu_read_lock(&eventfs_srcu);
> +	guard(srcu)(&eventfs_srcu);
>  
> -	mutex_lock(&eventfs_mutex);
> -	ei = READ_ONCE(ti->private);
> -	if (ei && ei->is_freed)
> -		ei = NULL;
> -	mutex_unlock(&eventfs_mutex);
> -
> -	if (!ei)
> -		goto out;
> +	scoped_guard(mutex, &eventfs_mutex) {
> +		ei = READ_ONCE(ti->private);
> +		if (!ei || ei->is_freed)
> +			return -EINVAL;
> +	}
>  
>  	/*
>  	 * Need to create the dentries and inodes to have a consistent
> @@ -622,21 +608,19 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  		entry = &ei->entries[i];
>  		name = entry->name;
>  
> -		mutex_lock(&eventfs_mutex);
>  		/* If ei->is_freed then just bail here, nothing more to do */
> -		if (ei->is_freed) {
> -			mutex_unlock(&eventfs_mutex);
> -			goto out;
> +		scoped_guard(mutex, &eventfs_mutex) {
> +			if (ei->is_freed)
> +				return -EINVAL;
> +			r = entry->callback(name, &mode, &cdata, &fops);
>  		}
> -		r = entry->callback(name, &mode, &cdata, &fops);
> -		mutex_unlock(&eventfs_mutex);
>  		if (r <= 0)
>  			continue;
>  
>  		ino = EVENTFS_FILE_INODE_INO;
>  
>  		if (!dir_emit(ctx, name, strlen(name), ino, DT_REG))
> -			goto out;
> +			return -EINVAL;
>  	}
>  
>  	/* Subtract the skipped entries above */
> @@ -659,19 +643,13 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
>  
>  		ino = eventfs_dir_ino(ei_child);
>  
> -		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR))
> -			goto out_dec;
> +		if (!dir_emit(ctx, name, strlen(name), ino, DT_DIR)) {
> +			/* Incremented ctx->pos without adding something, reset it */
> +			ctx->pos--;
> +			return -EINVAL;
> +		}
>  	}
> -	ret = 1;
> - out:
> -	srcu_read_unlock(&eventfs_srcu, idx);
> -
> -	return ret;
> -
> - out_dec:
> -	/* Incremented ctx->pos without adding something, reset it */
> -	ctx->pos--;
> -	goto out;
> +	return 1;
>  }
>  
>  /**
> @@ -728,11 +706,10 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>  	INIT_LIST_HEAD(&ei->children);
>  	INIT_LIST_HEAD(&ei->list);
>  
> -	mutex_lock(&eventfs_mutex);
> -	if (!parent->is_freed)
> -		list_add_tail(&ei->list, &parent->children);
> -	mutex_unlock(&eventfs_mutex);
> -
> +	scoped_guard(mutex, &eventfs_mutex) {
> +		if (!parent->is_freed)
> +			list_add_tail(&ei->list, &parent->children);
> +	}
>  	/* Was the parent freed? */
>  	if (list_empty(&ei->list)) {
>  		cleanup_ei(ei);
> @@ -877,9 +854,8 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
>  	if (!ei)
>  		return;
>  
> -	mutex_lock(&eventfs_mutex);
> +	guard(mutex)(&eventfs_mutex);
>  	eventfs_remove_rec(ei, 0);
> -	mutex_unlock(&eventfs_mutex);
>  }
>  
>  /**
> -- 
> 2.47.2
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
