Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D522EFDA4;
	Wed, 29 Apr 2026 18:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488899; cv=none; b=P0fti1RAy+qPSSpdkXEEn9EyxMM0UlXnbJmdT4NPrN39UCGnUqAlRiqFWuxx7VLJg6F60OGCoLrrCW2moFWg4eL84d0NVNeQUbm7YBpjom9glmMcGNjsY0x11X+GZNnMvqr9DNbTA/9NPMF4w63wK0/ll5zNAkMY5L7zM3DmzZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488899; c=relaxed/simple;
	bh=cHlnP9nNZLu9/uqqABygV8ieWNDMxnbOd7qtRJLxecY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eqf2timJyMjAxW1CzeMPaOAUaaZc+0wwyhCX5IYAjTm98wfUvfiBjv/vDvLa08g09ku4f+PDnw110wL7HNj5yCWFpAnvRz/WGG9fBKiYrbTUxEDyEv2lbtBC20cPrPAQG7mafEgNhKvLOLa93bAxisOpOrLxonHlbmPNWLK2xw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eIbZVLuy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eIbZVLuy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4AFCC19425;
	Wed, 29 Apr 2026 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777488899;
	bh=cHlnP9nNZLu9/uqqABygV8ieWNDMxnbOd7qtRJLxecY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eIbZVLuy8A7jpExFrOOi5Vw1auoYpfQbBeatuGausg7UCgpqIwrc5yI1fFILMFuFM
	 41DpLtr2yZN8REAbzky8Kr6NnhxnyBY6aq0lw8LZ2oekGonF0MS0gD2BEZjjK+XbBJ
	 lTkDvuI7QmUO5oY8WMqdauOO8ed+hzCsY+gwHJiL6bZ51Y9lpeZcNX2SyycPmytkCW
	 5NumxxFcTt5yIVwBLr2s6mdz1ugvc5goc0FTOorj52rnqHAKXYSxCLG5LbyHl4i1TS
	 KvycgHnrb1tGuFIr3xijy1pHcncf2/ni6pPYfqM4UvhEa/pQuM1vDyMfH/zil3a2rp
	 zqnOLuyA7wucA==
Date: Wed, 29 Apr 2026 14:55:12 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo
 <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, Carlos
 O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [RFC][PATCH] unwind: Add stacktrace_setup system call
Message-ID: <20260429145512.461e09fe@gandalf.local.home>
In-Reply-To: <ade15347-6eca-4204-9f64-9b2eed9e9aec@efficios.com>
References: <20260429114355.6c712e6a@gandalf.local.home>
	<ade15347-6eca-4204-9f64-9b2eed9e9aec@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 14:42:52 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> On 2026-04-29 11:43, Steven Rostedt wrote:
> [...]
> 
> AFAIU this is a functional iteration of my prior RFC here:
> 
> https://lore.kernel.org/lkml/2fa31347-3021-4604-bec3-e5a2d57b77b5@efficios.com/
> 
> perhaps it would be valuable to refer to that thread ?

Thanks, I actually decided to start this from scratch as I took a slightly
different approach than yours. But you're right, I should have mentioned it
anyway.

> 
> >   }
> > +
> > +/**
> > + * sys_stacktrace_setup - register an address for user space stacktrace walking.
> > + * @op: Type of operation to perform
> > + * @addr_start: The virtual address of the stacktrace information
> > + * @addr_length: The length of the stacktrace information
> > + * @text_start: The virtual address of the text that @addr_start represents
> > + * @text_length: The length of teh text  
> 
> the
> 
> also, perhaps add @flags just in case ? This allows changing the
> behavior without having to insert entirely new set of ops.

I thought about it and decided it was somewhat redundant to the ops. After
working on the futex code, I thought following that API was a better
approach.

> 
> > + *
> > + * This system call is used by dynamic library utilities to inform the kernel  
> 
> Out of curiosity: what would happen if the application chooses to invoke
> this system call to register sframe for the main executable ? Should it be
> allowed ?

I haven't tried, and should look at the code. Ideally, no two sframes
sections should cover the same code. I think it should error out if it does.

If the main executable doesn't have a sframe section, I don't see why this
shouldn't be allowed to add one.

> 
> > + * of meta data that it loaded that can be used by the kernel to know how
> > + * to stack walk the given text locations.
> > + *
> > + * Currently only sframes are supported, but in the future, this may be used
> > + * to tell the kernel about JIT code which will most likely have a different
> > + * format.
> > + *
> > + * The type command may be extended and parameters may be used for other
> > + * purposes.  
> 
> "type" or "op" ?

Bah, I originally had called it "type" and then renamed it to "op" (to
be consistent with the futex commands). I missed updating this. Thanks for
catching that.

-- Steve
