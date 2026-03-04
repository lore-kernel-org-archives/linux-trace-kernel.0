Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F73BE15B;
	Wed,  4 Mar 2026 17:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772645450; cv=none; b=uAQVWj2euqXb146YO/2UW5OeCgPRKf/VtWMO5aQ9Iul6GalDC2hVqQSmhNeKQm+2h5jTWmJc9Z/aBldd09Cu5bfkO0W/zjTVQsLFoGtbjfipCPruRLkimPaVolF/FYa7ro1ZfynQUgkvygoFzCPYnFbDGkLzXhIge7DDpjn+JOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772645450; c=relaxed/simple;
	bh=/fst7LQw2k45jc4t6FChxbkges9fZ21UIyJ6w+2+nfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rR/+2G+3AcbFCVJwBCrMeej5E0DzKoy1f5nyatOxYkMpg4KP/mvEj9FzpydP+LsJXSivgRAdNyIBJR//hNj5tQ/S05HDLj06gcFP0o2VrhgOR8iKzQsXH6/VHzgmKqglxOtj49UgKcwL7kjNrXQqojJ9XKGNBFCVdEhjo4m0RZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6N0bbeK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6N0bbeK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D61DC19425;
	Wed,  4 Mar 2026 17:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772645449;
	bh=/fst7LQw2k45jc4t6FChxbkges9fZ21UIyJ6w+2+nfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m6N0bbeKxVheSvkh0l4ssNtAh4SDpqlhj82LHNAqqA4zTWOZm+Syg2QZBnZZKLPfK
	 uRBQnjYZ5NzoXcBA//+H89x510M56J87wZZ51o3Ka56yD0WeC2neTjQk8pdApnkwCx
	 RmmItvIprg+g0A5m/5xEv+CU99QE/ZjUL88dy5OEW/zo/0qRHQBcyBFoqjOepkEKWy
	 mL+4gOKOhwARtyZCQIOP05C70LxrSrAlyfGvZLpUjMsh4fedacXpSm2pPAvlT8Myk3
	 5U76nrO1cNlGUy6j0WNrasaKjZR3Mu0RpFsxlw9SRQERNOKakdw5UESEBA/lmfFKAj
	 O2+nxWbbgiWQg==
Date: Wed, 4 Mar 2026 17:30:46 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Vincent Donnefort <vdonnefort@google.com>, Qing Wang <wangqing7171@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Message-ID: <ce01c391-0368-41b6-aae1-51b4b1153511@lucifer.local>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
 <aaFrmHzIAkEe7ufy@google.com>
 <aaF0zS3xh5KgM_yy@google.com>
 <aaF-bhAIhCgusG9k@google.com>
 <20260227102038.0fef81e9@gandalf.local.home>
 <20260227155601.18ebd3ca@gandalf.local.home>
 <e4deff21-2fb5-4f37-a7d3-ede5f69a4489@lucifer.local>
 <20260302115220.163f1249@gandalf.local.home>
 <71c3a923-dc00-471c-9555-c08d5e135dee@lucifer.local>
 <20260303102528.744d57ae@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303102528.744d57ae@gandalf.local.home>

On Tue, Mar 03, 2026 at 10:25:28AM -0500, Steven Rostedt wrote:
> On Tue, 3 Mar 2026 10:19:52 +0000
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > > > Setting VM_IO just to trigger a failure case in madvise() feels like a hack? I
> > > > guess it'd do the trick though, but you're not going to be able to reclaim that
> > > > memory, and you might get some unexpected behaviour in code paths that assume
> > > > VM_IO means it's memory-mapped I/O... (for instance GUP will stop working, if
> > > > you need that).
> > >
> > > Well, we don't reclaim that memory anyway.
> >
> > OK so maybe not such an issue then! As long as GUP not working with it wouldn't
> > break anything?
>
> Yeah, we don't ever use get_user_page() for this memory. It's pretty much
> all handled on the kernel side. User space just has it mapped as read only.
> The kernel doesn't care what user space does with it.

OK.

>
>
> > > Yeah, right now the accounting gets screwed up as the mappings get out of
> > > sync when it is forked.
> >
> > Ack, is that in a way that could screw up things from a kernel point of view at
> > all? Presumably there was some report that triggered this work, like an assert
> > fail or something, or a warning?
>
> Yes, it triggered a warning. The start of this thread added a patch to allow
> madvise to remove DONTCOPY from this memory without screwing things up
> (by adding an open() handler for the vm_operations_struct).

I mean that'd be preferable.

>
>
> >
> > If a user is explicitly going to an ftrace buffer and madvise()'ing it in random
> > ways they've only themselves to blame for being so stupid :)
> >
> > As long as it's not exploitable in some way I don't think that's too much of an
> > issue?
> >
> > It'd be nice to keep the semantics of 'don't copy on fork' if we could, even if
> > some crazy users might override it with madvise().
>
> OK, so should we add the VM_IO flag?

Would be preferable not to lie about the mapping if possible :P that'd be a hack.

>
> >
> > Kind of separate from the question, but I mean if it's kernel-allocated memory
> > which you're managing separately it should surely be VM_PFNMAP?
>
> OK, I'm a bit confused. What do you mean "managing separately"? You mean
> managing the user space side of things? if so then yes.
>
> Hmm, I haven't heard of VM_PFNMAP, can you explain more its use case.

means either no struct page (e.g. could be I/O mapped device memory) or 'don't
touch struct page it's not for userspace' e.g. kernel allocation.

>
> >
> > It depends if you want to have a refcounted folio underneath though. If you do
> > then yeah don't do that :)
>
> I have no idea what a refcounted folio would do here :-p

Well you are currently treating this as a userland folio.

>
> >
> > In general I'd suggest supporting the fork case if you can, or just let things
> > be wrong if a user does something crazy and undoes the VM_DONTCOPY flag.
>
> OK, so don't add these flags and just allow the forking to happen as this
> patch does (if they screw it up, it's their problem).
>
> This patch is here:
>
>   https://lore.kernel.org/all/20260227025842.1085206-1-wangqing7171@gmail.com/
>
> I mean, we allow two separate tasks to mmap the same buffer, and they will
> have the same issues as a fork would have. Thus, I guess the answer is to
> apply this patch?

Well note that vm_ops->open is also called on splitting a VMA (ok I guess you
disable this I think you said) and also mremap()'ing (before it removes the old
VMA, if MREMAP_DONTUNMAP is not set).

Probably all that's fine right? If so then good, and yeah something not-VM_IO
would be best I think!

>
> -- Steve

Cheers, Lorenzo
