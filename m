Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E719C140364;
	Mon, 10 Jun 2024 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718034403; cv=none; b=gtMWixQuwS2Fi3r9UIQlUgTf9WDqgqyiwKRU/+4a+cbG2Qe1HdaHbQ9ZFm/DqV7UGdPPTehM40NCTz/6Yl8hnSJXCtATREwferZNtwvEjU5jnsJXRmT2D97gBXT1r/JMUkOnb1AR/eUhWuC86nTssiiLEIoooXBNP5ffDj0nJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718034403; c=relaxed/simple;
	bh=+4/zPi4hkw9UfPxusBsUfwuVq79GZtvtVsjTstppxQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NBh+J2oMCMJ9xiLkZYzbIS7AGzcK/YWtLUU0+LBbmGF5Vt6ED+Q+Ll4uDvZxQNk1pEMKf3tB16bKd+eIL7AnWYECo+VVDGyitBkZkOyvz6Xi9HB/rKN7Dkm4MzUcrRE7Qzk45Z/pz8Cu/BD99mvtL0sZPth86e3t7otvDbLf1X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fwii7sXn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fwii7sXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C8DC2BBFC;
	Mon, 10 Jun 2024 15:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718034402;
	bh=+4/zPi4hkw9UfPxusBsUfwuVq79GZtvtVsjTstppxQc=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Fwii7sXnqnhyPe9nfsJEx4HelbDSAwAq539Cs4TUF7W/nwWo/mkQZnwbqkz1hJCsx
	 Gl7rGNsG6Y36dslQZqhMohi69OBawmwEWammQElV+FoIvi/t62YOM6TW6enEwgGOKE
	 ppouJINyhxUq85WZiR51gjaXEe+uiTRqdWXCnSizNl4ClunIQF/HIlhljzVXslV7zv
	 OeNcLtKfBQj2/M4NYZAEcz7By8mW5z+uNvP6XbbHCGkJPaOoHEvysPmJJ+Vdpz4451
	 YcgIftKDpf74Hr06mW4GdGG/67vUamk2Pg1UsSHXeVh/chMDR1k9JXvuCQ9rxGcJ9v
	 InhdFxKuunayQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0B026CE2373; Mon, 10 Jun 2024 08:46:42 -0700 (PDT)
Date: Mon, 10 Jun 2024 08:46:42 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-6-Julia.Lawall@inria.fr>
 <20240610112223.151faf65@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240610112223.151faf65@rorschach.local.home>

On Mon, Jun 10, 2024 at 11:22:23AM -0400, Steven Rostedt wrote:
> On Sun,  9 Jun 2024 10:27:17 +0200
> Julia Lawall <Julia.Lawall@inria.fr> wrote:
> 
> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> > index 7c29f4afc23d..338c52168e61 100644
> > --- a/fs/tracefs/inode.c
> > +++ b/fs/tracefs/inode.c
> > @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
> >  	return &ti->vfs_inode;
> >  }
> >  
> > -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
> > -{
> > -	struct tracefs_inode *ti;
> > -
> > -	ti = container_of(rcu, struct tracefs_inode, rcu);
> > -	kmem_cache_free(tracefs_inode_cachep, ti);
> 
> Does this work?
> 
> tracefs needs to be freed via the tracefs_inode_cachep. Does
> kfree_rcu() handle specific frees for objects that were not allocated
> via kmalloc()?

A recent change to kfree() allows it to correctly handle memory allocated
via kmem_cache_alloc().  News to me as of a few weeks ago.  ;-)

							Thanx, Paul

> -- Steve
> 
> 
> > -}
> > -
> >  static void tracefs_free_inode(struct inode *inode)
> >  {
> >  	struct tracefs_inode *ti = get_tracefs(inode);
> > @@ -70,7 +62,7 @@ static void tracefs_free_inode(struct inode *inode)
> >  	list_del_rcu(&ti->list);
> >  	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
> >  
> > -	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
> > +	kfree_rcu(ti, rcu);
> >  }
> >  
> >  static ssize_t default_read_file(struct file *file, char __user *buf,
> 
