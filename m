Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546E321B9C1;
	Mon, 31 Mar 2025 20:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743454625; cv=none; b=pr7doJOrsnoThz0a4b0oq9WqNP4Oe7cH/4GvshacpRCQiN+OuODmizAj7+uhnBn3XwFN+RATL1J/JQnWj3kTWJDVLVgSVK4bTV4cBtxvWjvTxnsO+03aZlmFqDqTrelDaO1hrPI7GaTqDgkpffk1Phbn91O1Qe25lF96rIySyNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743454625; c=relaxed/simple;
	bh=grjGL6ZIKMvZ89GhSxoNkBZGfmrbW7YwQq6dlnLMIhU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KFg9PnrYAW5ZK70ClaggW7NLKztYZNI0Cx9rrdsP8/Ya3ijhtIUCybBnFALa6QZHJpMmy5iCIClTLCPKVe5yfHCykw5lUfeNcnalbw4jyGoclcE302iV9LcbzEs3J3qNHhJaCSrLQ2FKrQVuTZoNxYF4n9xULKJ/IbCRJZu21kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A55C4CEE3;
	Mon, 31 Mar 2025 20:57:03 +0000 (UTC)
Date: Mon, 31 Mar 2025 16:58:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees
 Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250331165801.715aba48@gandalf.local.home>
In-Reply-To: <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
References: <20250331143426.947281958@goodmis.org>
	<20250331143532.459810712@goodmis.org>
	<CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
	<20250331133906.48e115f5@gandalf.local.home>
	<CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 12:12:08 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:


> > OK, so I did copy this from fs/pstore/ram_core.c as this does basically the
> > same thing as pstore. And it looks like pstore should be updated too.  
> 
> Please just stop copying code from random drivers or filesystems.

Note, I did not blindly copy it. I knew ramoops did exactly what I wanted
to do, so I looked at how it did it. I read the code, it looked reasonable,
and I mapped it.

I needed a way to map physical memory to vmap memory. How am I supposed to
know it was not doing it the proper way?

> 
> Christ.
> 
> I've said this before: core kernel code has higher quality
> requirements than random drivers (or even random filesystems).

I did not believe pstore was a random file system. It does similar code
that tracing does.

> 
> You can't copy crazy incorrect snippets from random sources and put it
> in core kernel code.

Note, even though this code lives in kernel/, it is not much different than
pstore code. It's a way to trace / debug the kernel, very much like pstore
in that it's used to debug. I saw that code was written in 2012 and thought
it was mature. It made sense, and yes I could have looked for a range, but
I trusted the people who wrote that code. This wasn't just a random looking
at something and copying it. I really wanted to understand how it worked.

And I did talk with some of the mm folks, and they seemed OK with this.


> If it's not part of the kernel memory allocator, it does not
> necessarily have a "struct page *" associated with it. Using a pointer
> to 'struct page' and passing it off is just fundamentally more than a
> bug: it's seriously and deeply broken.
> 
> It's probably much more obviously broken if the physical addresses
> came from a PCI device, and this all just happens to work because it's
> actually real RAM and we ended up having a 'struct page []' for it for
> some random reason.

Note, this only works with RAM.


> Or it might just be because that memory *has* been in the E280 memory
> map before it was reserved, and the 'strict page' arrays may have been
> sized for the original E280 information, not the "after stealing"
> information.

I guess you mean E820.

Mike can correct me if I'm wrong, but the memory that was stolen was actual
memory returned by the system (E820 in x86). It reserves the memory before
the memory allocation reserves this memory. So what reserve_mem returns is
valid memory that can be used by memory allocator, but is currently just
"reserved" which means it wants to prevent the allocator from using it.


> And yes, I'm not at all surprised that we'd have other mis-users of
> this. We have some very historical code that depends on reserved pages
> going back all the way to linux-0.01 I suspect, because things like
> the original VGA code knew that the physical addresses were in the
> BIOS hole region that was backed by 'struct page'.

I believe this is what Mike set up. A way to have normal RAM reserved
before it gets added to the memory allocator. This was by design.

In fact, if you do pull my v2[*] pull request of the ring buffer code (that
removes this user space mapping of the persistent ring buffer logic) it
actually adds the ability to free the memory and add it back into the memory
allocator.

 https://lore.kernel.org/linux-trace-kernel/173989134814.230693.18199312930337815629.stgit@devnote2/

-- Steve

[*] https://lore.kernel.org/all/20250328173533.7fa7810d@gandalf.local.home/
