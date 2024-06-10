Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328CA1CF9B;
	Mon, 10 Jun 2024 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718054298; cv=none; b=F5b24PkU7ZVOPJBmYA3CP6UVnog7fxLprnwqORdW8YO5Dplb/kuoxsgz4Eff2kj0XOGMfJx7tN4GiHxBzZItuvAAAqf7y85kJAcJfVbaixel+AwqPsAnXC3HrG14ojdiflUF3QWonZnM9MxEgp+vilKSYaQEkeEJIGfbGskfyv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718054298; c=relaxed/simple;
	bh=ZaHiKnBxA77uwO2CC6i3ByS9yqvBQrlgoSu4iRF2odA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lBEEivF+W0R7APtSBi/89yeBjXW3GJT5NHIMBPvd4rUd5j2RH9he8MdKnLYiDkHuzm8igbXkTb07dvaEzH9UpLG33nfQZzfl+sQFS9mgG6R528wOYzb2MgQ6v3y7KcoAktdFuT3aWCFzTWeV7B7iCNoz6ks8XouGotrrE3gfmdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4E5C2BBFC;
	Mon, 10 Jun 2024 21:18:15 +0000 (UTC)
Date: Mon, 10 Jun 2024 17:18:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: paulmck@kernel.org, Julia Lawall <Julia.Lawall@inria.fr>,
 kernel-janitors@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 05/14] tracefs: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
Message-ID: <20240610171826.75cef33d@gandalf.local.home>
In-Reply-To: <ce62eb86-8539-4c7f-b929-926cec94e1f0@suse.cz>
References: <20240609082726.32742-1-Julia.Lawall@inria.fr>
	<20240609082726.32742-6-Julia.Lawall@inria.fr>
	<20240610112223.151faf65@rorschach.local.home>
	<b647eacd-f6f3-4960-acfd-36c30f376995@paulmck-laptop>
	<ce62eb86-8539-4c7f-b929-926cec94e1f0@suse.cz>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jun 2024 22:42:30 +0200
Vlastimil Babka <vbabka@suse.cz> wrote:

> On 6/10/24 5:46 PM, Paul E. McKenney wrote:
> > On Mon, Jun 10, 2024 at 11:22:23AM -0400, Steven Rostedt wrote:  
> >> On Sun,  9 Jun 2024 10:27:17 +0200
> >> Julia Lawall <Julia.Lawall@inria.fr> wrote:
> >>   
> >> > diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> >> > index 7c29f4afc23d..338c52168e61 100644
> >> > --- a/fs/tracefs/inode.c
> >> > +++ b/fs/tracefs/inode.c
> >> > @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
> >> >  	return &ti->vfs_inode;
> >> >  }
> >> >  
> >> > -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
> >> > -{
> >> > -	struct tracefs_inode *ti;
> >> > -
> >> > -	ti = container_of(rcu, struct tracefs_inode, rcu);
> >> > -	kmem_cache_free(tracefs_inode_cachep, ti);  
> >> 
> >> Does this work?
> >> 
> >> tracefs needs to be freed via the tracefs_inode_cachep. Does
> >> kfree_rcu() handle specific frees for objects that were not allocated
> >> via kmalloc()?  
> > 
> > A recent change to kfree() allows it to correctly handle memory allocated
> > via kmem_cache_alloc().  News to me as of a few weeks ago.  ;-)  
> 
> Hey, I did try not to keep that a secret :)
> https://lore.kernel.org/all/20230310103210.22372-8-vbabka@suse.cz/
> 

Heh, I didn't look at that patch very deeply.

-- Steve
