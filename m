Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A59273D8F;
	Thu,  9 Jul 2026 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602915; cv=none; b=JjBTF2l8Y1JgIlkAHxHlc429nkeAwXpHbEC+NQuBI2Mwfoqsvb9CLX8ZfuNp1/Bpv7eRW4d9OPx5fUEdW0jT78inLNjFgRzf5CZyVTp/niRlk8AyQD/yURslcKJ1AF5iuUm58YWE17uqErt4nRWLHwj5gMduBpex8vmE/YLnalw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602915; c=relaxed/simple;
	bh=A74DZ3n+WaImNgLn1Fj5wfej0g7UA+CMNIW8ESqng0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8qhMjDJ0+vEZ9Z/b/Wc0TyURepM2JMnfNUKGGcUoJkWZjM9cP7Zap/TRSU6QTnIWp7ayZY2KQbm0o70LdZR7tSS+MX5ARe9qKrJUKeFHY3LGJW/xluVqT2bmP3ozpD2Zz6YwGQ8hvB7gm8ezUMtCK2SnV3SiUSzKuo74mVfdh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcHM9UjY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=50jcczpJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcHM9UjY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="50jcczpJ"
Date: Thu, 9 Jul 2026 15:15:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783602911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eWXoJbsmPACrUiEI6Qes7YghoFFmPaabwm8a5YUjvg=;
	b=hcHM9UjY2WcIxUhWAQ5bfTfhnUDaIvNt0zTL1QGxytCGn2/Pt1JuQgl1O0B0c0Fh/k8xYl
	oozFDDllzS8gho4Q4Og9D95QhNfRy1QGX8kbN1RLp3JQnpqqz+1U/c8eQ6A/QKdH86EyDK
	Z8/Ka4vBvFI7rJ5OHYy9hYwxrAs1ZWQDgzvgA/O8FDPKWfN773GNs5xexJBWmmDcrMWIL6
	nhA9a5OhYmcZtXqQoKodZEp5jhMY7ck++PAE+6JX0vNZyjBZrUGr5BbqVBaaeWI49oouyK
	cKHUfDWhXC++QmyZeOfYpSAtcDA+dqPTQuT56KkV7istkRc79R2Iz3GVAyWVxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783602911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2eWXoJbsmPACrUiEI6Qes7YghoFFmPaabwm8a5YUjvg=;
	b=50jcczpJIGp28/Y+rrdo2bcKZ4fBBALge0z10UabFspXx1idCA3exxs+6JwKQ4tQ1HdLry
	TRfTEYvVRqMHTRDQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Wandun Chen <chenwandun1@gmail.com>, vbabka@kernel.org,
	rostedt@goodmis.org, mhiramat@kernel.org,
	Alexander.Krabler@kuka.com, hughd@google.com, fvdl@google.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	akpm@linux-foundation.org, surenb@google.com, mhocko@suse.com,
	jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
	ljs@kernel.org, riel@surriel.com, liam@infradead.org,
	harry@kernel.org, jannh@google.com, lance.yang@linux.dev,
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	pfalcato@suse.de
Subject: Re: [PATCH v2 4/4] mm/mlock: migrate folios out of CMA when mlocking
 a range
Message-ID: <20260709131509.iIPP2VBh@linutronix.de>
References: <20260707125925.3725177-1-chenwandun1@gmail.com>
 <20260707125925.3725177-5-chenwandun1@gmail.com>
 <9b227263-56d9-41d5-ba8e-c969d8d68785@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9b227263-56d9-41d5-ba8e-c969d8d68785@kernel.org>

On 2026-07-09 12:04:33 [+0200], David Hildenbrand (Arm) wrote:
> On 7/7/26 14:59, Wandun Chen wrote:
> > From: Wandun Chen <chenwandun@lixiang.com>
> > 
> > The region covered by mlock[all] may contain CMA pages. cma_alloc installs
> 
> What about ZONE_MOVABLE where memory is supposed to be migratable?

Would it be bad if the pages would not be movable anymore? Does this
effect just memory-hotplug or something else, too?

> Also, what about drivers that mmap() CMA memory to user space, and
> __mm_populate()->populate_vma_page_range() would actually try mlocking them, and
> they actually must remain on CMA areas?

It should be safe to skip those. They belong to device and they
shouldn't be affected by anything including getting swapped out.

Sebastian
