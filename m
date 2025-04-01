Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BB12D05E;
	Tue,  1 Apr 2025 01:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471635; cv=none; b=Zl3meW3Q7ADIKStALDAXrWfeE7p+xlwGxjB74YAS8Gpa6i+lTLrvRmeqqNvosFoaD8T70viZR49/7zr/cRZQxb8E3qkQBeBlM2hNCGYLathDmzxFXDwYRPsJg7bfCfKWB8sF+BepH1UKrHeDwg6hVkYQmecU1wPubYX8by5n7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471635; c=relaxed/simple;
	bh=PgbgXK0kPzOGAadwEnIzB4+9qURGyqYHDS42AKdQbfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YoL8EyM466mpOKj9Xtz+cFqEmVdUCCcJbnxXBtS81aZnu9db45UchgGHjWjVhBe0DPoz+AarYkgqrn1oBMPfoMDMOpJXYjP23Exm4DUeoyyMosfzunjBza0qZ1s3JeyyC2XqF3BDI9G0qlJk0k0+ItXaCa4BdSJy3FtF1z/mH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38ADEC4CEE3;
	Tue,  1 Apr 2025 01:40:33 +0000 (UTC)
Date: Mon, 31 Mar 2025 21:41:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees
 Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code
 do the vmap of physical memory
Message-ID: <20250331214132.49622459@gandalf.local.home>
In-Reply-To: <CAHk-=wi=GNaLzNt5zjee6m9OHNvr=Sc1S-xsnS0cNMfdVp15hg@mail.gmail.com>
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
	<CAHk-=wi=GNaLzNt5zjee6m9OHNvr=Sc1S-xsnS0cNMfdVp15hg@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 18:30:33 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Mon, 31 Mar 2025 at 18:01, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Note, I believe that Linus brought up the issue that because this physical
> > memory is not currently part of the memory allocator (it's not aware of it
> > yet), that the getting struct page or a "pfn" for it may not be reliable.  
> 
> 'pfn' is always reliable.
> 
> The pfn ('page frame number') is literally just the physical address
> expressed in 'page units', ie just shifted down by the page shift.

Ah, for some reason I thought the pfn mapped directly to struct pages.

> 
> So pfn and phys_addr_t are interchangeable when it comes to mapping
> pages. The pfn is in fact often the preferred form, because on 32-bit
> architectures a pfn is 32-bit, but a phys_addr_t is often 64-bit and
> generates extra code.
> 
> I think 'pfn' was introduced as a name ong long ago because it was
> what the alpha architecture used in the VM documentation. It probably
> predates that too, but it's where I got it from, iirc.
> 

It is old, as I remember using it when I first started Linux kernel
development back in 1998. But my memory of it was it was also used as an
index into a struct page array. Which is why I was thinking it was somewhat
interchangeable with struct page. But that was a long time ago when I was
an embedded developer, but I've only been using struct page for my needs in
the last couple of decades.

-- Steve
