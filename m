Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD654A07;
	Tue,  4 Jun 2024 11:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717499311; cv=none; b=B2ZL9wQk1FhVO8UDp4g6ph/5flM2Xx0vqsBQPcSrFRiPxpPsLNp/uhR2A8jm5pNVsb2YdTXdiL9RGErfF4Lhpv6SZp1Lne9D8VmFDYmrkTeNhDs2VfCGLaPVxaNUIGZ1I9fXJHd01gNfWVLWV4/3UQCbGg/wAGNU2wUObpGYPoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717499311; c=relaxed/simple;
	bh=O/y6u8vfxnyc9M0sYToQE9eckbW/BoNY61LnLEuAsXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YM18s0GC1sZyN5/PEdUB+3SyM8qKJCbK/+7DV30y7RJAC15cpjixI6g6vBY8IFxQ/xZIkPU6Zj2/lHPOggtcDL1fSYUrFGtmuEHUbRXBgRNGmpzdY4BUh7Wficv2l6sLxKzZ1ulWBYk0bI5W9/RKOhjgZwNYLiBQ0MCpvHOMRPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E82C2BBFC;
	Tue,  4 Jun 2024 11:08:27 +0000 (UTC)
Date: Tue, 4 Jun 2024 07:08:26 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
 <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Guenter
 Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 wklin@google.com, Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel
 Fernandes <joel@joelfernandes.org>, Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mike Rapoport
 <rppt@kernel.org>
Subject: Re: [PATCH 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240604070826.030c5202@gandalf.local.home>
In-Reply-To: <CAMj1kXFoNT25+ZTFaqF8zj4VkN6FFbtX5Fntf+J-c33tW3TPUA@mail.gmail.com>
References: <20240603233330.801075898@goodmis.org>
	<20240603233631.452433539@goodmis.org>
	<CAMj1kXFoNT25+ZTFaqF8zj4VkN6FFbtX5Fntf+J-c33tW3TPUA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 08:03:54 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

> On Tue, 4 Jun 2024 at 01:35, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> > In order to allow for requesting a memory region that can be used for
> > things like pstore on multiple machines where the memory layout is not the
> > same, add a new option to the kernel command line called "reserve_mem".
> >
> > The format is:  reserve_mem=nn:align:name
> >
> > Where it will find nn amount of memory at the given alignment of align.
> > The name field is to allow another subsystem to retrieve where the memory
> > was found. For example:
> >
> >   reserve_mem=12M:4096:oops ramoops.mem_name=oops
> >
> > Where ramoops.mem_name will tell ramoops that memory was reserved for it
> > via the reserve_mem option and it can find it by calling:
> >
> >   if (reserve_mem_find_by_name("oops", &start, &size)) {
> >         // start holds the start address and size holds the size given
> >
> > Link: https://lore.kernel.org/all/ZjJVnZUX3NZiGW6q@kernel.org/
> >
> > Suggested-by: Mike Rapoport <rppt@kernel.org>
> > Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>  
> 
> You failed to point out in the commit message that the assumption here
> is that this memory will retain its contents across a soft reboot. Or
> am I misunderstanding this?

Yes that is the intention. I should update the commit message.

> 
> In any case, as I pointed out before, playing these games unilaterally
> from the kernel side, i.e., without any awareness whatsoever from the
> firmware and bootloader (which will not attempt to preserve RAM
> contents), is likely to have a rather disappointing success ratio in
> the general case. I understand this may be different for vertically
> integrated software stacks like ChromeOS so perhaps it should live
> there as a feature.

I have been using this on two different test machines, as well as a
chromebook, and it appears to work on all ofthem. As well as for VMs. I
plan on adding this to my workstation and server too (they use EFI).

> 
> Then, as Kees points out, there is also the risk that the kernel
> itself may be stepping on this memory before having realized that it
> is reserved. At least ARM and x86 have decompressors with a
> substantial amount of non-trivial placement logic that would need to
> be made aware of this reservation. Note that EFI vs. non-EFI boot also
> makes a difference here.

Agreed. Note, it should definitely state that this is not 100% reliable,
and depending on the setup it may not be reliable at all. Whatever uses it
should add something to confirm that the memory is the same.

If corner cases become an issue, this could be extended to work with them.
We could update KASLR to be aware of this allocation. The documentation
update to kernel-parameters.txt on this usage should definitely stress that
this can be unreliable, and use should be tested to see if it works. And
also stress that if it does work, it may not work all the time. The best
usage for this is for statistical debugging. For instance, in our use case,
we have 1000s of crashes that we have no idea why. If this worked only 10%
of the time, the data retrieved from 100 of those crashes would be very
valuable.

-- Steve
