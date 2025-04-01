Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C70EEDE;
	Tue,  1 Apr 2025 01:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472194; cv=none; b=TX0ggnHKqe1IzY/18sab4LFry0wrBrEtnlQ2R/SDbU/DBzZU5vPBC3A/j9U554DFfGZQzihSfYvTwYNBUxxvWRzVRDFvOn9F+G165Mj9b9/U0QtbB9AbWsmOptmnqpwX59pR6IpTHYwZDs95L7H6OJ4KtPERRoVktFo1vTBOIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472194; c=relaxed/simple;
	bh=Z2rOTv/JVFwFPnD/atJ+geM5Ch3Kz3AaBvHv9hGQe5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXP90CFv4XtXw5UitrXRWJbB3Iwzidy0uwq5yk0HIn5t4+fgSivkB3VGWphlGnedJ3cl7oKF8KW880n574fbVIn7WsxShV7w5c+S7Q0zXgYvJzH8DpeWsp/oAEum36F7vUTX1G38FRMS7leRFQeZU+D0Y6ekh5GbqEQtbGt+Xc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67568C4CEE3;
	Tue,  1 Apr 2025 01:49:52 +0000 (UTC)
Date: Mon, 31 Mar 2025 21:50:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jann Horn <jannh@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees
 Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250331215051.21d77cab@gandalf.local.home>
In-Reply-To: <CAG48ez1mZ4nq-_DXHqiHe8_tSX37DdcngnULqXQ71fFt0oQPyA@mail.gmail.com>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
	<20250331133906.48e115f5@gandalf.local.home>
	<CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
	<20250331165801.715aba48@gandalf.local.home>
	<CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
	<20250331194251.02a4c238@gandalf.local.home>
	<CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com>
	<20250331210245.585fff23@gandalf.local.home>
	<CAG48ez1mZ4nq-_DXHqiHe8_tSX37DdcngnULqXQ71fFt0oQPyA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 03:28:20 +0200
Jann Horn <jannh@google.com> wrote:

> I think you probably need flushes on both sides, since you might have
> to first flush out the dirty cacheline you wrote through the kernel
> mapping, then discard the stale clean cacheline for the user mapping,
> or something like that? (Unless these VIVT cache architectures provide
> stronger guarantees on cache state than I thought.) But when you're
> adding data to the tracing buffers, I guess maybe you only want to
> flush the kernel mapping from the kernel, and leave flushing of the
> user mapping to userspace? I think if you're running in some random
> kernel context, you probably can't even reliably flush the right
> userspace context - see how for example vivt_flush_cache_range() does
> nothing if the MM being flushed is not running on the current CPU.

I'm assuming I need to flush both the kernel (get the updates out to
memory) and user space (so it can read those updates).

The paths are all done via system calls from user space, so it should be on
the same CPU. User space will do an ioctl() on the buffer file descriptor
asking for an update, the kernel will populate the page with that update,
and then user space will read the update after the ioctl() returns. All
very synchronous. Thus, we don't need to worry about updates from one CPU
happening on another CPU.

Even when it wants to read the buffer. The ioctl() will swap out the old
reader page with one of the write pages making it the new "reader" page,
where no more updates will happen on that page. The flush happens after
that and before going back to user space.

-- Steve
