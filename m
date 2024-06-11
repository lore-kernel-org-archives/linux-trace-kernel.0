Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F0C6116;
	Tue, 11 Jun 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718086994; cv=none; b=FOUyCgZlxYGO13+VioCuwA2B5lYxQJLiH6OM1Am97hhdNtrJ0ox4Lk2NPx2TNtO6BRhm9cFO6hE3nLsC7AH26HPkgKrCCTtD9JEi0el/Hlp7WmP/D+Yh2fiwH/pLTwUgQedcal0/IuBFV+OOyT+MvI5jlIeF/8pNHjYOnjtMb58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718086994; c=relaxed/simple;
	bh=ve4gT6CyxU4E2TQ43WtxEhXL8/ATKIHsYr3UXy4cHyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJN18xxn2YK+qzeAAygyEuuxXrsV9vZgxvYJnafQS9Bv8ODq6W5b1xSyvjCIJ3asSs7Rb5gBLPFJkmx+Sc4AdZh6rMS0RoVzLxoDG7o99Z3ZEAOTsnmYS9GXyiH9pq6wFaWXxrW9p9fb9Kg2XCpkjGr5l4Bx2/ulIYWbWHwn/6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=18Jf531q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="18Jf531q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFC3C2BD10;
	Tue, 11 Jun 2024 06:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718086994;
	bh=ve4gT6CyxU4E2TQ43WtxEhXL8/ATKIHsYr3UXy4cHyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=18Jf531qULxA/w23HwCUdkd/2Y3nJjWIdgleWTellkonv3YQTG0F1QG0wlv7DzTdW
	 SrvqlNIF0jkDgNfIVHsbIhRqxh0YFLAYsjfSXfHUs9RH/SH5tZBk3lwxcOEK7pNReM
	 f1GLVwOyOPoxXC+2uL+/vb+ZybUC97FNph2f4/6w=
Date: Tue, 11 Jun 2024 08:23:11 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	kernel-janitors@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	"workflows@vger.kernel.org" <workflows@vger.kernel.org>,
	Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <2024061143-transfer-jalapeno-afa0@gregkh>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
 <20240609082726.32742-6-Julia.Lawall@inria.fr>
 <20240610112223.151faf65@rorschach.local.home>
 <b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
 <20240610163606.069d552a@gandalf.local.home>
 <70c093a5-df9c-4665-b9c9-90345c7f2139@suse.cz>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70c093a5-df9c-4665-b9c9-90345c7f2139@suse.cz>

On Mon, Jun 10, 2024 at 11:40:54PM +0200, Vlastimil Babka wrote:
> On 6/10/24 10:36 PM, Steven Rostedt wrote:
> > On Mon, 10 Jun 2024 08:46:42 -0700
> > "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > 
> >> > > index 7c29f4afc23d..338c52168e61 100644
> >> > > --- a/fs/tracefs/inode.c
> >> > > +++ b/fs/tracefs/inode.c
> >> > > @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
> >> > >  	return &ti->vfs_inode;
> >> > >  }
> >> > >  
> >> > > -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
> >> > > -{
> >> > > -	struct tracefs_inode *ti;
> >> > > -
> >> > > -	ti = container_of(rcu, struct tracefs_inode, rcu);
> >> > > -	kmem_cache_free(tracefs_inode_cachep, ti);  
> >> > 
> >> > Does this work?
> >> > 
> >> > tracefs needs to be freed via the tracefs_inode_cachep. Does
> >> > kfree_rcu() handle specific frees for objects that were not allocated
> >> > via kmalloc()?  
> >> 
> >> A recent change to kfree() allows it to correctly handle memory allocated
> >> via kmem_cache_alloc().  News to me as of a few weeks ago.  ;-)
> > 
> > If that's the case then:
> > 
> > Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> > 
> > Do we have a way to add a "Depends-on" tag so that anyone backporting this
> > will know that it requires the change to whatever allowed that to happen?
> 
> Looks like people use that tag, although no grep hits in Documentation, so
> Cc'ing workflows@ and Thorsten.
> 
> In this case it would be
> 
> Depends-on: c9929f0e344a ("mm/slob: remove CONFIG_SLOB")

Ick, no, use the documented way of handling this as described in the
stable kernel rules file.

thanks,

greg k-h
