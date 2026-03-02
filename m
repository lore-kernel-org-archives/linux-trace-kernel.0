Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C5A26ED35;
	Mon,  2 Mar 2026 16:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772470322; cv=none; b=HJgiSQhq8FjyxkL4vTNjC7bIR26+cqMMFHZ3nzL1WQd0z9oiw3psppD2ld5mYvWLRz9/AqEvwmwBfY/HOV73En4b8bIerRjFQabONdcPoqCMiDUuNh1KCde5w0q5M6AwrytOwAw3FsuETJPmYm7XgmGiN9HAZHjKYuOneS4iVYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772470322; c=relaxed/simple;
	bh=bOhuC40TuS7j/YSkbSBDjWXZHo8UaljdoZAehMm1HCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TF5WbczvMEv+tWEPMi8KZDvTtL3iAuatNkDse8vbTT2FO5M9iJ2rnHLkmHTOcUeyvI5EIG15v22qBQW+skDmaa0IDa67HeyF8TcjkkR7rLkO5q/lCYb+1lSTEv4o4NaXU+pTh1gpBVpRGh8+dMHweaWMzNi8JSn6cA/bhg9mkG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id F3F16B6F12;
	Mon,  2 Mar 2026 16:51:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 12AEB24;
	Mon,  2 Mar 2026 16:51:54 +0000 (UTC)
Date: Mon, 2 Mar 2026 11:52:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Vincent Donnefort <vdonnefort@google.com>, Qing Wang
 <wangqing7171@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka
 <vbabka@suse.cz>, David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Message-ID: <20260302115220.163f1249@gandalf.local.home>
In-Reply-To: <e4deff21-2fb5-4f37-a7d3-ede5f69a4489@lucifer.local>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
	<aaFrmHzIAkEe7ufy@google.com>
	<aaF0zS3xh5KgM_yy@google.com>
	<aaF-bhAIhCgusG9k@google.com>
	<20260227102038.0fef81e9@gandalf.local.home>
	<20260227155601.18ebd3ca@gandalf.local.home>
	<e4deff21-2fb5-4f37-a7d3-ede5f69a4489@lucifer.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ga8zxnmmaot1unp1q5b7kx6effrhy9ft
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 12AEB24
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19h1PiaoNVqS8DxrhucMqrMvzpHGLzoem8=
X-HE-Tag: 1772470314-185035
X-HE-Meta: U2FsdGVkX18kHmqeYV5hrJyMsFisrRETeIsoWEpDA43T6JHuCdhwRt0JW75CZSS2ymTO0nidfGfavI0iciUpuawHd7vwGwvgCOlN4uVWdew/Hl7B0gvHkVuqy9AMfRSkAh8eNnP/iECo9y/okKPSWmwLTph1yQvBPV5TUenM21pXGwCTR0jG6HQ/gz4p2MW3FKEZfXjfCGJVjGsdJ7OcnwHQhxVT59OkPwRTyVBGTPrFNS9aHGzcBrO+Bsm/gR51IXgrFc3Fa94tBNlWF9mFfaOrcvlmGaCR4DTxEnbDFgpdZSRjLWRHwkfNWlEJkklXosVSxOxoY7I4Adh/7I8SCiVIcWf0qaS5

On Mon, 2 Mar 2026 12:13:24 +0000
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

Hi Lorenzo,

Thanks for looking into this.

> > But looking at the various flags, I see there's a VM_SPECIAL. I'm wondering
> > if that is what we should use?  
> 
> VM_SPECIAL is not a VMA flag, it's a bitmask of all the flags which cause us not
> to permit things like splitting/merging of VMAs (because we can't safely do
> them), i.e. that are one or more of:

Yep, I knew it wasn't a flag, and actually picked it because it looked to
have the flags we may have wanted.

> 
>         VM_IO - Memory-mapped I/O range.
> 
>     VM_PFNMAP - A mapping without struct folio's/page's backing them, e.g. perhaps a
>                 raw kernel mapping.
> 
>   VM_MIXEDMAP - A combination of page/folio-backed memory and/or PFN-backed memory.
> 
> VM_DONTEXPAND - Disallow expansion of memory in mremap().
> 
> You already set VM_DONTEXPAND so you get these semantics already.
> 
> Setting VM_IO just to trigger a failure case in madvise() feels like a hack? I
> guess it'd do the trick though, but you're not going to be able to reclaim that
> memory, and you might get some unexpected behaviour in code paths that assume
> VM_IO means it's memory-mapped I/O... (for instance GUP will stop working, if
> you need that).

Well, we don't reclaim that memory anyway.

> 
> I'd take a step back and wonder why you are wanting to not allow copying on
> fork? Is this kernel-allocated memory? In which case you should set VM_MIXEDMAP
> or VM_PFNMAP as appropriate... If not and it has a folio etc. then it seems like
> strange semantics.
> 
> Are you really bothered also by users doing strange things? Maybe the solution
> is to tolerate a fork-copy even if it's broken? I presume somethings straight up
> breaks right now?

Yeah, right now the accounting gets screwed up as the mappings get out of
sync when it is forked.

> 
> Without more context that I don't really have much time to acquire it's hard to
> know what to advise.

Fair enough, let me explain everything then ;-)

This is a mapping of the ftrace ring buffer to user space. Until recently,
the only way user space could get access to the ftrace ring buffer was to
either read it, or splice() it to a file/pipe/whatever.

The way the ftrace ring buffer works is that it is made up of a bunch of
sub-buffers (must be multiple of PAGE_SIZE and usually is a single page).
There is one sub-buffer called the "reader-page" which writers never write
to (with an exception out of scope for understanding the mappings).

The "reader-page" is a sub-buffer that belongs to the reader. When the
reader is finish with it and wants to read more of the buffer, an operation
is performed to swap the current reader-page with one of the pages that the
writers have. The new page is now owned by the reader and writers will
leave it alone. This allows readers to do a zero copy splice of the data in
the ring buffer.

Now we added a feature to memory map this buffer to user space. The
reader-page and writer sub-buffers are all mapped read-only into the user's
memory address.

Another page is mapped called the "meta page" which tells user space how to
read the buffer (which sub-buffer is the current reader-page and the order
of the write sub-buffers).

The read-page is what user space will read directly, and when it is done,
it does an ioctl() on the file descriptor for the buffer:

  /sys/kernel/tracing/per_cpu/cpu*/trace_pipe_raw

One command of the ioctl() will tell the kernel to swap the reader-page with
a writer sub-buffer. The meta page is updated and the user space
application can read that.

Now the meta page is unique per ring buffer and not per process. If there's
a fork, any change to the meta page will affect all processes that have
this mapped.

If two processes map the same buffer, one process will see any updates in
its meta page that another process does to it.

Now there is nothing wrong with doing that, accept the user space processes
will likely get confused. And we currently allow two separate tasks to mmap
it at the same time (maybe we shouldn't have!).

What we didn't allow was forking, as the code didn't update the proper
accounting. It needs to know that the buffer is mapped because it handles
splice differently. As the pages are mapped to user space, the kernel can't
just allow splice to steal a page and send it off to whatever pipe. Instead
it makes a copy of the page (basically killing the performance splice()
gives it in the first place).

We originally added the DONTFORK so that we didn't need to handle the fork
case, but I'm guessing that you are suggesting that we should do that
instead of preventing it from being duplicated on fork. Am I correct?

-- Steve

