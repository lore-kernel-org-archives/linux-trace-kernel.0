Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510580B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Oct 2023 03:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSBa7yWA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44527C433C7;
	Sun, 29 Oct 2023 03:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698549578;
	bh=+oYL5eA4v2B17ViuMWrOPb+gJdwv7yQ8J3vt+2/9oTU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hSBa7yWANxvmlLYPlJMSAjeInHNuuPoaLhdAb6pkdZ1LCCfkwdI7lbVF99xg+6WFw
	 kaaBXiQhiLsi6eqZ2TKyUoOn9RDsgI8bHswYwV+uauE+jOkqNBms/CfYzV7OhqGCGw
	 9nPlFeVCAyWHj7TzCDakArHVIW2UHCp5gJd5BxNuomtbXZNC3hPrAj0Ldlkr+lqv21
	 fmybswgNrBsTFs0G09Xg3xR5oUqyc6lmEzQUJNMGDfgSkulen5SX72n5XplFPleIgx
	 09NY0M41TW23D3tUF/+uVXBmZ8QUEne5+4JLCSn2xPRzHGkjnhMXOm21EgBLAUnXVG
	 pTJwI9dfM7rfQ==
Date: Sun, 29 Oct 2023 12:19:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "Arnd Bergmann"
 <arnd@arndb.de>, "Naresh Kamboju\" <naresh.kamboju@linaro.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, "Ajay Kaher" <akaher@vmware.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] eventfs: Test for ei->is_freed when accessing
 ei->dentry
Message-Id: <20231029121933.5fc0df1793d406e82813b0b6@kernel.org>
In-Reply-To: <20231028164650.4f5ea18a@rorschach.local.home>
References: <20231028164650.4f5ea18a@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Oct 2023 16:46:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The eventfs_inode (ei) is protected by SRCU, but the ei->dentry is not. It
> is protected by the eventfs_mutex. Anytime the eventfs_mutex is released,
> and access to the ei->dentry needs to be done, it should first check if
> ei->is_freed is set under the eventfs_mutex. If it is, then the ei->dentry
> is invalid and must not be used. The ei->dentry must only be accessed
> under the eventfs_mutex and after checking if ei->is_freed is set.
> 
> When the ei is being freed, it will (under the eventfs_mutex) set is_freed
> and at the same time move the dentry to a free list to be cleared after
> the eventfs_mutex is released. This means that any access to the
> ei->dentry must check first if ei->is_freed is set, because if it is, then
> the dentry is on its way to be freed.
> 
> Also add comments to describe this better.
> 
> Link: https://lore.kernel.org/all/CA+G9fYt6pY+tMZEOg=SoEywQOe19fGP3uR15SGowkdK+_X85Cg@mail.gmail.com/
> Link: https://lore.kernel.org/all/CA+G9fYuDP3hVQ3t7FfrBAjd_WFVSurMgCepTxunSJf=MTe=6aA@mail.gmail.com/
> 

Looks good to me.

Revieewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> Fixes: 5790b1fb3d672 ("eventfs: Remove eventfs_file and just use eventfs_inode")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Beau Belgrave <beaub@linux.microsoft.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
> 
> Changes since v1: https://lore.kernel.org/all/20231028163749.0d3429a1@rorschach.local.home/
> 
>  - Add comment about ei->is_freed is a union along with ei->rcu and
>    ei->del_list so that others can find where ei->is_freed is set and
>    not get confused about why ei->dentry is being removed but ei->is_freed
>    isn't mentioned.
> 
>  - And fixed change log to remove the double "Reported-by".
> 
>  fs/tracefs/event_inode.c | 65 +++++++++++++++++++++++++++++++++-------
>  fs/tracefs/internal.h    |  3 +-
>  2 files changed, 56 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> index 4d2da7480e5f..45bddce7c747 100644
> --- a/fs/tracefs/event_inode.c
> +++ b/fs/tracefs/event_inode.c
> @@ -24,7 +24,20 @@
>  #include <linux/delay.h>
>  #include "internal.h"
>  
> +/*
> + * eventfs_mutex protects the eventfs_inode (ei) dentry. Any access
> + * to the ei->dentry must be done under this mutex and after checking
> + * if ei->is_freed is not set. The ei->dentry is released under the
> + * mutex at the same time ei->is_freed is set. If ei->is_freed is set
> + * then the ei->dentry is invalid.
> + */
>  static DEFINE_MUTEX(eventfs_mutex);
> +
> +/*
> + * The eventfs_inode (ei) itself is protected by SRCU. It is released from
> + * its parent's list and will have is_freed set (under eventfs_mutex).
> + * After the SRCU grace period is over, the ei may be freed.
> + */
>  DEFINE_STATIC_SRCU(eventfs_srcu);
>  
>  static struct dentry *eventfs_root_lookup(struct inode *dir,
> @@ -234,6 +247,10 @@ create_file_dentry(struct eventfs_inode *ei, struct dentry **e_dentry,
>  	bool invalidate = false;
>  
>  	mutex_lock(&eventfs_mutex);
> +	if (ei->is_freed) {
> +		mutex_unlock(&eventfs_mutex);
> +		return NULL;
> +	}
>  	/* If the e_dentry already has a dentry, use it */
>  	if (*e_dentry) {
>  		/* lookup does not need to up the ref count */
> @@ -307,6 +324,8 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
>  	struct eventfs_inode *ei_child;
>  	struct tracefs_inode *ti;
>  
> +	lockdep_assert_held(&eventfs_mutex);
> +
>  	/* srcu lock already held */
>  	/* fill parent-child relation */
>  	list_for_each_entry_srcu(ei_child, &ei->children, list,
> @@ -320,6 +339,7 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
>  
>  /**
>   * create_dir_dentry - Create a directory dentry for the eventfs_inode
> + * @pei: The eventfs_inode parent of ei.
>   * @ei: The eventfs_inode to create the directory for
>   * @parent: The dentry of the parent of this directory
>   * @lookup: True if this is called by the lookup code
> @@ -327,12 +347,17 @@ static void eventfs_post_create_dir(struct eventfs_inode *ei)
>   * This creates and attaches a directory dentry to the eventfs_inode @ei.
>   */
>  static struct dentry *
> -create_dir_dentry(struct eventfs_inode *ei, struct dentry *parent, bool lookup)
> +create_dir_dentry(struct eventfs_inode *pei, struct eventfs_inode *ei,
> +		  struct dentry *parent, bool lookup)
>  {
>  	bool invalidate = false;
>  	struct dentry *dentry = NULL;
>  
>  	mutex_lock(&eventfs_mutex);
> +	if (pei->is_freed || ei->is_freed) {
> +		mutex_unlock(&eventfs_mutex);
> +		return NULL;
> +	}
>  	if (ei->dentry) {
>  		/* If the dentry already has a dentry, use it */
>  		dentry = ei->dentry;
> @@ -435,7 +460,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  	 */
>  	mutex_lock(&eventfs_mutex);
>  	ei = READ_ONCE(ti->private);
> -	if (ei)
> +	if (ei && !ei->is_freed)
>  		ei_dentry = READ_ONCE(ei->dentry);
>  	mutex_unlock(&eventfs_mutex);
>  
> @@ -449,7 +474,7 @@ static struct dentry *eventfs_root_lookup(struct inode *dir,
>  		if (strcmp(ei_child->name, name) != 0)
>  			continue;
>  		ret = simple_lookup(dir, dentry, flags);
> -		create_dir_dentry(ei_child, ei_dentry, true);
> +		create_dir_dentry(ei, ei_child, ei_dentry, true);
>  		created = true;
>  		break;
>  	}
> @@ -583,7 +608,7 @@ static int dcache_dir_open_wrapper(struct inode *inode, struct file *file)
>  
>  	list_for_each_entry_srcu(ei_child, &ei->children, list,
>  				 srcu_read_lock_held(&eventfs_srcu)) {
> -		d = create_dir_dentry(ei_child, parent, false);
> +		d = create_dir_dentry(ei, ei_child, parent, false);
>  		if (d) {
>  			ret = add_dentries(&dentries, d, cnt);
>  			if (ret < 0)
> @@ -637,6 +662,13 @@ static int dcache_readdir_wrapper(struct file *file, struct dir_context *ctx)
>  	return ret;
>  }
>  
> +static void free_ei(struct eventfs_inode *ei)
> +{
> +	kfree_const(ei->name);
> +	kfree(ei->d_children);
> +	kfree(ei);
> +}
> +
>  /**
>   * eventfs_create_dir - Create the eventfs_inode for this directory
>   * @name: The name of the directory to create.
> @@ -700,12 +732,20 @@ struct eventfs_inode *eventfs_create_dir(const char *name, struct eventfs_inode
>  	ei->nr_entries = size;
>  	ei->data = data;
>  	INIT_LIST_HEAD(&ei->children);
> +	INIT_LIST_HEAD(&ei->list);
>  
>  	mutex_lock(&eventfs_mutex);
> -	list_add_tail(&ei->list, &parent->children);
> -	ei->d_parent = parent->dentry;
> +	if (!parent->is_freed) {
> +		list_add_tail(&ei->list, &parent->children);
> +		ei->d_parent = parent->dentry;
> +	}
>  	mutex_unlock(&eventfs_mutex);
>  
> +	/* Was the parent freed? */
> +	if (list_empty(&ei->list)) {
> +		free_ei(ei);
> +		ei = NULL;
> +	}
>  	return ei;
>  }
>  
> @@ -787,13 +827,11 @@ struct eventfs_inode *eventfs_create_events_dir(const char *name, struct dentry
>  	return ERR_PTR(-ENOMEM);
>  }
>  
> -static void free_ei(struct rcu_head *head)
> +static void free_rcu_ei(struct rcu_head *head)
>  {
>  	struct eventfs_inode *ei = container_of(head, struct eventfs_inode, rcu);
>  
> -	kfree_const(ei->name);
> -	kfree(ei->d_children);
> -	kfree(ei);
> +	free_ei(ei);
>  }
>  
>  /**
> @@ -880,7 +918,12 @@ void eventfs_remove_dir(struct eventfs_inode *ei)
>  		for (i = 0; i < ei->nr_entries; i++)
>  			unhook_dentry(&ei->d_children[i], &dentry_list);
>  		unhook_dentry(&ei->dentry, &dentry_list);
> -		call_srcu(&eventfs_srcu, &ei->rcu, free_ei);
> +		/*
> +		 * Note, ei->is_freed is a union along with ei->rcu
> +		 * and ei->del_list. When the ei is added to either
> +		 * of those lists, it automatically sets ei->is_freed.
> +		 */
> +		call_srcu(&eventfs_srcu, &ei->rcu, free_rcu_ei);
>  	}
>  	mutex_unlock(&eventfs_mutex);
>  
> diff --git a/fs/tracefs/internal.h b/fs/tracefs/internal.h
> index 64fde9490f52..21a1fa682b74 100644
> --- a/fs/tracefs/internal.h
> +++ b/fs/tracefs/internal.h
> @@ -30,7 +30,7 @@ struct eventfs_inode {
>  	const struct eventfs_entry	*entries;
>  	const char			*name;
>  	struct list_head		children;
> -	struct dentry			*dentry;
> +	struct dentry			*dentry; /* Check is_freed to access */
>  	struct dentry			*d_parent;
>  	struct dentry			**d_children;
>  	void				*data;
> @@ -39,6 +39,7 @@ struct eventfs_inode {
>  	 * @del_list:	list of eventfs_inode to delete
>  	 * @rcu:	eventfs_inode to delete in RCU
>  	 * @is_freed:	node is freed if one of the above is set
> +	 *   Note if is_freed is set, then dentry is corrupted.
>  	 */
>  	union {
>  		struct list_head	del_list;
> -- 
> 2.42.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
