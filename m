Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4882D3C3BE9;
	Tue,  3 Mar 2026 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772551506; cv=none; b=Ar7dscELKtmoe06VsoE1F9Pz+Q2cPzCny8l+WtIsQtd/N2pEiP7EIdFIOLwC82o7wIC3wkpKqrCJYu7WLndkuB8qOzfO7EOo44JUsmHR3pd/GqoBOdHwGUnaWcnxyUpFaZqVTOlB3F0e8ZPuJKfmm8VxsOsilHHgAV8E/MMO58I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772551506; c=relaxed/simple;
	bh=fF9e1mZArvaSeyRwOywEoGBzyyk+YaHvK3G0qRYyWhc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CyAww8zQyc2CP2ihfXquXbNW74fxjSE0qvHFX/ghiRTEupEaxqug+mguDFsXhMGMO592SJ6H+i0u/qgWmwvoAKpn9c+mwqdhUk2yVWfCeiUJU3fOxwtOELBjJOsFdra+fbyL/e0d9bLJ9PgUfsI1Gs2BxiBYL9PkuBJhx7e/G9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 12D481B7133;
	Tue,  3 Mar 2026 15:24:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 9A45C2000F;
	Tue,  3 Mar 2026 15:24:54 +0000 (UTC)
Date: Tue, 3 Mar 2026 10:25:28 -0500
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
Message-ID: <20260303102528.744d57ae@gandalf.local.home>
In-Reply-To: <71c3a923-dc00-471c-9555-c08d5e135dee@lucifer.local>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
	<aaFrmHzIAkEe7ufy@google.com>
	<aaF0zS3xh5KgM_yy@google.com>
	<aaF-bhAIhCgusG9k@google.com>
	<20260227102038.0fef81e9@gandalf.local.home>
	<20260227155601.18ebd3ca@gandalf.local.home>
	<e4deff21-2fb5-4f37-a7d3-ede5f69a4489@lucifer.local>
	<20260302115220.163f1249@gandalf.local.home>
	<71c3a923-dc00-471c-9555-c08d5e135dee@lucifer.local>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9A45C2000F
X-Stat-Signature: 3hz885ypkoypc367hso7gzicnnuezpsz
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/zCUL7l9k7aAQL9zP7zTX9PtIr2mrAw/4=
X-HE-Tag: 1772551494-105759
X-HE-Meta: U2FsdGVkX1/U5dGM2Ji56yBvpitHsyp/1MMnC/4RWiVNbQHmR4bqhmw5c7bj6a29vcZwVoZZZXpQ6h7pGSDYxGAWk+78G66Fe6b3cZybZzfatPp1Z7ZXi7YF26lb43ALlMHaOuLgCkYbWT0N0hiLzdJbdikXpWnnEPHDpks7DFKR5Mm+H0rgfJjn6w7lBNaAc6DgiWap1z/G+lOmIPWXc4ImvAqhyqzwzfyKEPVNllRfdyXIfnarjrNpGj52MmOQXW8FvTgNd9KCBNZJcfbGkgsouYyMTgo8aZS03U1cPNh5fwaRV6AC1QXo2yE/Pb67GhaRfiLbJAIpGhK6b3aXviCB2muvNjSFGP6ncgO2Bmy6JCm9latSXMnnF5ybXPHYHURLBsI0XOM=

On Tue, 3 Mar 2026 10:19:52 +0000
Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:

> > > Setting VM_IO just to trigger a failure case in madvise() feels like a hack? I
> > > guess it'd do the trick though, but you're not going to be able to reclaim that
> > > memory, and you might get some unexpected behaviour in code paths that assume
> > > VM_IO means it's memory-mapped I/O... (for instance GUP will stop working, if
> > > you need that).  
> >
> > Well, we don't reclaim that memory anyway.  
> 
> OK so maybe not such an issue then! As long as GUP not working with it wouldn't
> break anything?

Yeah, we don't ever use get_user_page() for this memory. It's pretty much
all handled on the kernel side. User space just has it mapped as read only.
The kernel doesn't care what user space does with it.


> > Yeah, right now the accounting gets screwed up as the mappings get out of
> > sync when it is forked.  
> 
> Ack, is that in a way that could screw up things from a kernel point of view at
> all? Presumably there was some report that triggered this work, like an assert
> fail or something, or a warning?

Yes, it triggered a warning. The start of this thread added a patch to allow
madvise to remove DONTCOPY from this memory without screwing things up
(by adding an open() handler for the vm_operations_struct).


> 
> If a user is explicitly going to an ftrace buffer and madvise()'ing it in random
> ways they've only themselves to blame for being so stupid :)
> 
> As long as it's not exploitable in some way I don't think that's too much of an
> issue?
> 
> It'd be nice to keep the semantics of 'don't copy on fork' if we could, even if
> some crazy users might override it with madvise().

OK, so should we add the VM_IO flag?

> 
> Kind of separate from the question, but I mean if it's kernel-allocated memory
> which you're managing separately it should surely be VM_PFNMAP?

OK, I'm a bit confused. What do you mean "managing separately"? You mean
managing the user space side of things? if so then yes.

Hmm, I haven't heard of VM_PFNMAP, can you explain more its use case.

> 
> It depends if you want to have a refcounted folio underneath though. If you do
> then yeah don't do that :)

I have no idea what a refcounted folio would do here :-p

> 
> In general I'd suggest supporting the fork case if you can, or just let things
> be wrong if a user does something crazy and undoes the VM_DONTCOPY flag.

OK, so don't add these flags and just allow the forking to happen as this
patch does (if they screw it up, it's their problem).

This patch is here:

  https://lore.kernel.org/all/20260227025842.1085206-1-wangqing7171@gmail.com/

I mean, we allow two separate tasks to mmap the same buffer, and they will
have the same issues as a fork would have. Thus, I guess the answer is to
apply this patch?

-- Steve
