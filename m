Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A92468C28;
	Wed, 12 Aug 2026 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556307; cv=none; b=hhs90BA/JZhzzRNQ+nGXyagrhl08w6o93xWNvYRGPNJkTVANakVev/91Bu/tAf954Q9TmiWvMeKCF+CsUYeX1mEbaKM5AXQAD1CHRg7CTZla9E8Li7gDqkow5MhW0RVXELtJCTYJnkxoA5WIMi2+fDreDCd49qSo7d8iYh+i6Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556307; c=relaxed/simple;
	bh=fJzO7e0Q8iP+Ej/NJHYI6yHWAdforBeW/CP2WgRZj+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A7jY2sjF4oeE5fNZClW2oRAlzskJlDFxz28bkQ74+RGhbOl1tneGy/WxHcG3aVg5/J7dgnVcns007X4IAHscB6YqVheQNUWJZ/DMVFknDEodeB23DJOIMcboUJX5Tgc9A9G8XBQNN0ef8TTebdIBZocTd6/t6WxcPVwRwcipj9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 197411A0161;
	Wed, 12 Aug 2026 17:38:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 4D5C020032;
	Wed, 12 Aug 2026 17:38:21 +0000 (UTC)
Date: Wed, 12 Aug 2026 13:38:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, "sashiko-bot@kernel.org"
 <sashiko-bot@kernel.org>, "sashiko-reviews@lists.linux.dev"
 <sashiko-reviews@lists.linux.dev>
Subject: Re: [PATCH] eventfs: Add warning for out of bounds pos in
 __eventfs_iterate()
Message-ID: <20260812133835.1061a1f6@gandalf.local.home>
In-Reply-To: <20260810175928.5f4d9d5c@gandalf.local.home>
References: <20260810175928.5f4d9d5c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ybta6w8a8si84q5byaasdze8jt4cghpg
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 4D5C020032
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18x8jmvOVScr5R+YnXs8XMOUq/SDV76dhs=
X-HE-Tag: 1786556301-560312
X-HE-Meta: U2FsdGVkX1+JvYcfryk3MQKZxxVohr6o7uFap/DydYPVkuayqCHdsQVZ1VbECb8DmJ2nsjKlwmQQzreyEVawMlaTOC93lDp61IpefSaxKQjjVoraj33vQDWtrP24pV0Xna22QvYHKjIMcdt1xDqT8o+OnnmsBxZVZjw2i70PEgmqx5EHmPmPrKq/MwtGeFIul9D1nIlXri06RVkM/XYhKx3/OA6eELE956OD6KkVo1o8kerrdSRpSIo4eCeAsBxS9k/MlnR9+4XaPkQ98dKia8NZccnXUITCtvdSMcO/qJnK0T/11+i8IPsHbLrYrI/fl4ygZ/8bMpTWWDHymUl/re89mzlCC4t2KK0rYyQcFYe7ymT3T+DDQj167YYk6O2abncaVcQcJJ/9h1vmUE7Zio2rVRrplqL8NME58hYl/HHRWOHjk5SB7RT1C5/ixnUR

Replying to Sashiko: https://sashiko.dev/#/patchset/20260810175928.5f4d9d5c%40gandalf.local.home

> --- Patch [1]: [PATCH] eventfs: Add warning for out of bounds pos in __eventfs_iterate() ---
> commit 2f3bdca57e4eb4f6f462c12ceab80527f383bb86
> Author: Steven Rostedt <rostedt@goodmis.org>
> 
> eventfs: Add warning for out of bounds pos in __eventfs_iterate()
> 
> This commit adds a WARN_ON_ONCE to eventfs_iterate() to catch out of bounds
> positions. It ensures that ctx->pos remains within the expected range, 
> guarding against potential overflow issues from 64-bit seeks.
> 
> Link: https://sashiko.dev/#/patchset/20260810160708.3460a2fd%40gandalf.local.home
> 
> > diff --git a/fs/tracefs/event_inode.c b/fs/tracefs/event_inode.c
> > index a524584353279..604ba3e841d24 100644
> > --- a/fs/tracefs/event_inode.c
> > +++ b/fs/tracefs/event_inode.c
> > @@ -594,6 +594,10 @@ static int eventfs_iterate(struct file *file, struct dir_context *ctx)
> >  	if (!(ti->flags & TRACEFS_EVENT_INODE))
> >  		return -EINVAL;
> >  
> > +	/* Logic should prevent ctx->pos from going out of range */
> > +	if (WARN_ON_ONCE(ctx->pos < 2 || ctx->pos > 0x7fffffffULL))
> > +		return -EINVAL;
> > +
> >  	c = ctx->pos - 2;
> >  
> >  	guard(srcu)(&eventfs_srcu);
> 
> [ ... ]
> 
> >  	list_for_each_entry_srcu(ei_child, &ei->children, list,
> >  				 srcu_read_lock_held(&eventfs_srcu)) {
> 
> [ ... ]
> 
> >  		smp_rmb();
> >  		if (ei->is_freed)
> >  			return -EINVAL;
> >  
> >  		if (c > 0) {
> >  			c--;
> >  			continue;
> >  		}
> 
> This is a pre-existing issue, but does the skip logic here using the
> absolute index c risk omitting valid directory entries during concurrent
> modifications?
> 
> If a user calls getdents on an eventfs directory and it returns partially
> (e.g., due to a full buffer), and a child entry is concurrently removed from
> ei->children via list_del_rcu(), the list shrinks.
> 
> When getdents resumes on the next syscall, eventfs_iterate() recalculates
> c = ctx->pos - 2. Since the list physically shrank, using this absolute
> index might skip too many elements in the now-shrunken list, bypassing valid
> entries that have shifted forward.
> 
> Is there a mechanism preventing this race between getdents and concurrent
> removals?

No and we do not care. The tracefs / eventfs file system is only modified
when new events are added or removed. During those transactions, reading
the directory has an undefined behavior. Always has, and always will. If
events are dropped because the admin is both reading the directories as
they add or remove events, then it is expected that the result may be
garbage.

-- Steve
