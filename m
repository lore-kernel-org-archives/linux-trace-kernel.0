Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB03135A58;
	Mon, 10 Jun 2024 15:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718032946; cv=none; b=thvtKzmg15/zsOG1FpFm6mUf/onvvalf0KqyvzMN3V8KHuXZbsUxMY6/DcCGEiy7QYamBgQKiIvbDkodqlwx/wIXOZviTwmvuUZTQW7oNsQ4DQcBNEQIf5IUcWD+sf/Z5jaVHLXSVu5xzwjLEaI2YVQC59LGyQ6mEPCR5fAZRf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718032946; c=relaxed/simple;
	bh=fs/CUGRK42T1ZduMRBjsL7c/gZC5tVJMrLgdXvclfIc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FuhCvvb0sR9zL063mDVTVtfcL/tyMU4eiDPuXXdMZa4ft6wP8JrJCCmkmqbRd4KSnDWXRBO4Tk/OQco7drYCZPn+bluqKUq3Iw4ShbO6v6zsH1hJm1eqC816bQsfItHdwhvu7qNWksNBeazN5FWhqPHft1BlTWfCbh6d3vrelh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41345C2BBFC;
	Mon, 10 Jun 2024 15:22:25 +0000 (UTC)
Date: Mon, 10 Jun 2024 11:22:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, "Paul E .
 McKenney" <paulmck@kernel.org>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <20240610112223.151faf65@rorschach.local.home>
In-Reply-To: <20240609082726.32742-6-Julia.Lawall@inria.fr>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
	<20240609082726.32742-6-Julia.Lawall@inria.fr>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  9 Jun 2024 10:27:17 +0200
Julia Lawall <Julia.Lawall@inria.fr> wrote:

> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 7c29f4afc23d..338c52168e61 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
>  	return &ti->vfs_inode;
>  }
>  
> -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
> -{
> -	struct tracefs_inode *ti;
> -
> -	ti = container_of(rcu, struct tracefs_inode, rcu);
> -	kmem_cache_free(tracefs_inode_cachep, ti);

Does this work?

tracefs needs to be freed via the tracefs_inode_cachep. Does
kfree_rcu() handle specific frees for objects that were not allocated
via kmalloc()?

-- Steve


> -}
> -
>  static void tracefs_free_inode(struct inode *inode)
>  {
>  	struct tracefs_inode *ti = get_tracefs(inode);
> @@ -70,7 +62,7 @@ static void tracefs_free_inode(struct inode *inode)
>  	list_del_rcu(&ti->list);
>  	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
>  
> -	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
> +	kfree_rcu(ti, rcu);
>  }
>  
>  static ssize_t default_read_file(struct file *file, char __user *buf,

