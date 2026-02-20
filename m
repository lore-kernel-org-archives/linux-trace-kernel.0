Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB79341041
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Feb 2026 11:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585673; cv=none; b=ejBgD6nLNqal/z5YpLKKcGhCrxo3r60TWjRScV00mvWiJX8AjjYxm1y9Lffds3HaM8zwhhKQPrOsdMTA8jL8s6qiCnzXlfst1jKlWbdMWDQdmerdKnO4JGVwYhUoXeht0eUi2GR/2k+vGS1eH/5kmkyH5X0aAYm4cJVgariMgfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585673; c=relaxed/simple;
	bh=DvaPHgn8GiaYqwL6gmdPaOYFgACCW2voqQxyErFHcUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rlZvvYFNv9kgnKlrs40HlOAaZKTGccZM1eYal/J7bUaSgwBzsCuXcEIgpDeu1ulCdwGDFD1erZmjwj4LrDESndhqH/YSwL8iL9qZLeEWYA3jcnnaxKw3x4k9+Z7TqevoMXBH68ewsAjNi+oisjku77CuiVAWmvECh2kObGpEYEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KG1fILvH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=S5nqOlUo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mX6Zn0tY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=pv0E1s3J; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KG1fILvH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="S5nqOlUo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mX6Zn0tY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="pv0E1s3J"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B1ECF3E6D8;
	Fri, 20 Feb 2026 11:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771585669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLv+hA5hd7MVtuLJRJZBuqjxVwO8h8t75XfQY9oDWAo=;
	b=KG1fILvHZvhZuKFnwQga7mSrv7B5/ivr5bdAke6Hh049E9a81GFjDaw4SPBKqpsfJp4+Ze
	fd6EMaeBlh/rjFyZoOOOt9LksTeVQKSMN8ADGspachfdZp2K8OEQAMwP15fao/XXeTcD9b
	NdYKQZ44NdgV/jkVqO8ziJqaBhpp5yQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771585669;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLv+hA5hd7MVtuLJRJZBuqjxVwO8h8t75XfQY9oDWAo=;
	b=S5nqOlUoY59dooEbrnRQXHpR+eQcDHuF7gej0JWBPdJxI4dbEQqWFsFF3xzvQgNvmWnEWh
	9N2sjew5O/vpWyAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771585668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLv+hA5hd7MVtuLJRJZBuqjxVwO8h8t75XfQY9oDWAo=;
	b=mX6Zn0tYmj5iBTFHvzo0OzGHKBPS/iRUbzlfiDY4dy6bY19c2wyJbX+/ZwEafzRIbf9ZAc
	UC/ZiG6GiclDyV8bK7QsNHBv+qur+qPVbx06IdSTn1/KWflI3nyPJhvlUwCSOOVf34699u
	PjZtIVinbzA4Rg8ZL1CCg6LWBth32GY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771585668;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TLv+hA5hd7MVtuLJRJZBuqjxVwO8h8t75XfQY9oDWAo=;
	b=pv0E1s3Jd5NzINhqD7MZPs8hO4hfhXVGbuvqilxIeepAEbK6GeG5Dp9W0vVJ9QhpWbhIBM
	ENRuA6MTmsbYEjBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 250843EA65;
	Fri, 20 Feb 2026 11:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jaKzBYNAmGmERQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 20 Feb 2026 11:07:47 +0000
Date: Fri, 20 Feb 2026 11:07:45 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, rostedt@goodmis.org, joel@joelfernandes.org, 
	kernel-team@android.com, android-mm@google.com, 
	"David Hildenbrand (Arm)" <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Minchan Kim <minchan@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jann Horn <jannh@google.com>, Martin Liu <liumartin@google.com>, 
	David Rientjes <rientjes@google.com>, Zi Yan <ziy@nvidia.com>, 
	Wander Lairson Costa <wander@redhat.com>, Petr Mladek <pmladek@suse.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/tracing: rss_stat: Ensure curr is false from kthread
 context
Message-ID: <6wljnbdh2tvi5egjd462hel7zkxvxedqgeqbjsdpoibc5n2j43@fsjneenogr3y>
References: <20260219233708.1971199-1-kaleshsingh@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219233708.1971199-1-kaleshsingh@google.com>
X-Spamd-Result: default: False [-7.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,linux-foundation.org:email]
X-Spam-Flag: NO
X-Spam-Score: -7.80
X-Spam-Level: 

On Thu, Feb 19, 2026 at 03:36:56PM -0800, Kalesh Singh wrote:
> The rss_stat trace event allows userspace tools, like Perfetto [1],
> to inspect per-process RSS metric changes over time.
> 
> The curr field was introduced to rss_stat in commit e4dcad204d3a
> ("rss_stat: add support to detect RSS updates of external mm").
> It's intent is to  indicate whether the RSS update is for the
> mm_struct of the current execution context; and is set to false
> when operating on a remote mm_struct (e.g., via kswapd or a
> direct reclaimer).
> 
> However, an issue arises when a kernel thread temporarily adopts
> a user process's mm_struct. Kernel threads do not have their own
> mm_struct and normally have current->mm set to NULL. To operate
> on user memory, they can "borrow" a memory context using
> kthread_use_mm(), which sets current->mm to the user process's mm.
> 
> This can be observed, for example, in the USB Function Filesystem
> (FFS) driver. The ffs_user_copy_worker() handles AIO completions
> and uses kthread_use_mm() to copy data to a user-space buffer.
> If a page fault occurs during this copy, the fault handler executes
> in the kthread's context.
> 
> At this point, current is the kthread, but current->mm points to the
> user process's mm. Since the rss_stat event (from the page fault)
> is for that same mm, the condition current->mm == mm becomes true,
> causing curr to be incorrectly set to true when the trace event is
> emitted.
> 
> This is misleading because it suggests the mm belongs to the kthread,
> confusing userspace tools that track per-process RSS changes and
> corrupting their mm_id-to-process association.
> 
> Fix this by ensuring curr is always false when the trace event is
> emitted from a kthread context by checking for the PF_KTHREAD flag.
> 
> [1] https://perfetto.dev/
> 
> Fixes: e4dcad204d3a ("rss_stat: add support to detect RSS updates of external mm")
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: "David Hildenbrand (Arm)" <david@kernel.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Looks cromulent, thanks :)

-- 
Pedro
