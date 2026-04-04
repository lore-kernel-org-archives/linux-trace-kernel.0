Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C4625;
	Sat,  4 Apr 2026 00:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775262754; cv=none; b=AcgmnfigEO5Zj5K1lqyEdFOJoonwt3EZPyrWuLNfILtMaqUlp3Bn5N44ejUCXIE0qGAE75R5U8nwVqdImzihlebFvR0ur2PzIHP9yjUo3V8FqFUpzd7IoWyUsGFcTrgJBvbxfyk2mJ4GW1nLSM2nbJzldiixu8jkmA0VXoE0Y/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775262754; c=relaxed/simple;
	bh=NYESnWA8nyBfPWTrYfHvv3+N0G9f3yRvmIQsHVnbpNU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dK6VmkeWdIVVv9azFVWxcQHe06e1MH4TEJM8umr2E1/+GV/c4Ho9fFRK5kGcBF1fbCxsFABuFf9fxA4PPnL8GLlXPqf+StFVruGprWyXsZrj/Ux9p2gizSpsqHuP8cx+Wlo1iYcP5WCUJbg8Uso7Smhs4aU+BcxZ9nhsXVe21Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSqwot39; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSqwot39"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 535E5C4CEF7;
	Sat,  4 Apr 2026 00:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775262754;
	bh=NYESnWA8nyBfPWTrYfHvv3+N0G9f3yRvmIQsHVnbpNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iSqwot39hb91fr0oK/3w8vmv9eltkDrgkhpICT0zlmWq9jeCsjuAPIxMB2h/wE9/+
	 EBjYW3VR8mYxr/D7q2/LFD0G7oiiK9GtMi8+HRjovNkMakiEKrWH36arOqcWcypaeh
	 dKHBNXhMsCJm4x0dK7G5zDuvHmVwggiADsc4wFY+loAmTLa2iMrRLGXRdqpSXvCcan
	 0xGgltOmU4QeRoJNoaloE6Ck92HRzSEJaZvVsdL1HRPi2Ee05rmhPOe+e4c/eNM/Y+
	 70MSpBmOtaQXyxuadU9oZmNsSsNn/uSrChpkmjsQCswZi+tCeORSEqjtBKLL2Np6UX
	 xyavJB2j72kfQ==
Date: Sat, 4 Apr 2026 09:32:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v15 4/5] ring-buffer: Add persistent ring buffer
 invalid-page inject test
Message-Id: <20260404093225.213ca848800cb47d388edf05@kernel.org>
In-Reply-To: <20260401184055.2f932674@gandalf.local.home>
References: <177494615421.71933.3679132057004156013.stgit@mhiramat.tok.corp.google.com>
	<177494619065.71933.9842685686800241005.stgit@mhiramat.tok.corp.google.com>
	<20260401184055.2f932674@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 1 Apr 2026 18:40:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> I replied with mostly grammar fixes and some rewrites of text.

Thanks for reviewing! Let me update it.

> 
> On Tue, 31 Mar 2026 17:36:30 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Add a self-destractive test for the persistent ring buffer.
> 
>   "self-destractive"? Do you mean "self-destructive"?
> 
> Probably better to call it a "self-corrupting test".
> 
> > 
> > This will inject erroneous value to some sub-buffer pages (where
> 
>             inject an erroneous
> 
> > the index is even or multiples of 5) in the persistent ring buffer
> > when kernel gets panic, and check whether the number of detected
> 
>   when the kernel panics, and checks whether
> 
> > invalid pages and the total entry_bytes are the same as recorded
> 
>                                                   same as the recorded
> 
> > values after reboot.
> > 
> > This can ensure the kernel correctly recover partially corrupted
> 
>   This ensures that the kernel can correctly recover a partially corrupted
> 
> > persistent ring buffer when boot.
> 
>                          after a reboot or panic.
> 
> > 
> > The test only runs on the persistent ring buffer whose name is
> > "ptracingtest". And user has to fill it up with events before
> 
>                   The user has to fill it with events before a kernel panic.
> 
> > kernel panics.
> > 
> > To run the test, enable CONFIG_RING_BUFFER_PERSISTENT_INJECT
> > and you have to setup the kernel cmdline;
> 
>   and add the following kernel cmdline:
> 
> Note, it's more proper to use a colon (:) than a semi-colon (;) when
> referencing an example on the next line.

OK, 

> 
> > 
> >  reserve_mem=20M:2M:trace trace_instance=ptracingtest^traceoff@trace
> >  panic=1
> > 
> > And run following commands after the 1st boot;
> 
>   Run the following commands after the 1st boot:
> 
> > 
> >  cd /sys/kernel/tracing/instances/ptracingtest
> >  echo 1 > tracing_on
> >  echo 1 > events/enable
> >  sleep 3
> >  echo c > /proc/sysrq-trigger
> > 
> > After panic message, the kernel will reboot and run the verification
> > on the persistent ring buffer, e.g.
> > 
> >  Ring buffer meta [2] invalid buffer page detected
> >  Ring buffer meta [2] is from previous boot! (318 pages discarded)
> >  Ring buffer testing [2] invalid pages: PASSED (318/318)
> >  Ring buffer testing [2] entry_bytes: PASSED (1300476/1300476)
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  Changes in v15:
> >   - Use pr_warn() for test result.
> >   - Inject errors on the page index is multiples of 5 so that
> >     this can reproduce contiguous empty pages.
> >  Changes in v14:
> >   - Rename config to CONFIG_RING_BUFFER_PERSISTENT_INJECT.
> >   - Clear meta->nr_invalid/entry_bytes after testing.
> >   - Add test commands in config comment.
> >  Changes in v10:
> >   - Add entry_bytes test.
> >   - Do not compile test code if CONFIG_RING_BUFFER_PERSISTENT_SELFTEST=n.
> >  Changes in v9:
> >   - Test also reader pages.
> > ---
> >  include/linux/ring_buffer.h |    1 +
> >  kernel/trace/Kconfig        |   31 ++++++++++++++++++
> >  kernel/trace/ring_buffer.c  |   74 +++++++++++++++++++++++++++++++++++++++++++
> >  kernel/trace/trace.c        |    4 ++
> >  4 files changed, 110 insertions(+)
> > 
> > diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> > index 994f52b34344..0670742b2d60 100644
> > --- a/include/linux/ring_buffer.h
> > +++ b/include/linux/ring_buffer.h
> > @@ -238,6 +238,7 @@ int ring_buffer_subbuf_size_get(struct trace_buffer *buffer);
> >  
> >  enum ring_buffer_flags {
> >  	RB_FL_OVERWRITE		= 1 << 0,
> > +	RB_FL_TESTING		= 1 << 1,
> >  };
> >  
> >  #ifdef CONFIG_RING_BUFFER
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index e130da35808f..07305ed6d745 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -1202,6 +1202,37 @@ config RING_BUFFER_VALIDATE_TIME_DELTAS
> >  	  Only say Y if you understand what this does, and you
> >  	  still want it enabled. Otherwise say N
> >  
> > +config RING_BUFFER_PERSISTENT_INJECT
> > +	bool "Enable persistent ring buffer error injection test"
> > +	depends on RING_BUFFER
> > +	help
> > +	  Run a selftest on the persistent ring buffer which names
> > +	  "ptracingtest" (and its backup) when panic_on_reboot by
> 
>   Does this do anything with the backup?

This meant that if you make a backup of ptracingtest
(instance=backup=ptracingtest) the check runs on backup instance too.
But it may be redundant. I'll drop it.

> 
> > +	  invalidating ring buffer pages.
> 
>  	  This option will have the kernel check if the persistent ring
>  	  buffer is named "ptracingtest", and if so, it will corrupt some
>  	  of its pages on a kernel panic. This is used to test if the
>  	  persistent ring buffer can recover from some of its sub-buffers
>  	  being corrupted.
> 
> [space]
> 
> > +	  To use this, boot kernel with "ptracingtest" persistent
> 
>                      , boot a kernel with a "ptracingtest" persistent
> 
> > +	  ring buffer, e.g.
> > +
> > +	   reserve_mem=20M:2M:trace trace_instance=ptracingtest@trace panic=1
> > +
> > +	  And after the 1st boot, run test command, like;
> 
>                                , run the following commands:
> 
> > +
> > +	   cd /sys/kernel/tracing/instances/ptracingtest
> > +	   echo 1 > events/enable
> > +	   echo 1 > tracing_on
> > +	   sleep 3
> > +	   echo c > /proc/sysrq-trigger
> > +
> > +	  After panic message, the kernel reboots and show test results
> > +	  on the boot log.
> 
>           After the panic message, the kernel will reboot and will show the
>           test results in the console output.
> 
> > +
> > +	  Note that user has to enable events on the persistent ring
> > +	  buffer manually to fill up ring buffers before rebooting.
> 
> 	  Note that events for the ring buffer needs to be enabled prior to
> 	  crashing the kernel so that the ring buffer has content that the
> 	  test will corrupt.
> 
> > +	  Since this invalidates the data on test target ring buffer,
> > +	  "ptracingtest" persistent ring buffer must not be used for
> > +	  actual tracing, but only for testing.
> 
> 	  As the test will corrupt events in the "ptracingtest" persistent
> 	  ring buffer, it should not be used for any other purpose other
> 	  than his test.
> 
> 
> > +
> > +	  If unsure, say N
> > +
> >  config MMIOTRACE_TEST
> >  	tristate "Test module for mmiotrace"
> >  	depends on MMIOTRACE && m
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index 5ff632ca3858..fb098b0b4505 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -64,6 +64,10 @@ struct ring_buffer_cpu_meta {
> >  	unsigned long	commit_buffer;
> >  	__u32		subbuf_size;
> >  	__u32		nr_subbufs;
> > +#ifdef CONFIG_RING_BUFFER_PERSISTENT_INJECT
> > +	__u32		nr_invalid;
> > +	__u32		entry_bytes;
> > +#endif
> >  	int		buffers[];
> >  };
> >  
> > @@ -2079,6 +2083,21 @@ static void rb_meta_validate_events(struct
> > 	  ring_buffer_per_cpu *cpu_buffer) if (discarded)
> >  		pr_cont(" (%d pages discarded)", discarded);
> >  	pr_cont("\n");
> > +
> > +#ifdef CONFIG_RING_BUFFER_PERSISTENT_INJECT
> > +	if (meta->nr_invalid)
> > +		pr_warn("Ring buffer testing [%d] invalid pages: %s (%d/%d)\n",
> > +			cpu_buffer->cpu,
> > +			(discarded == meta->nr_invalid) ? "PASSED" : "FAILED",
> > +			discarded, meta->nr_invalid);
> > +	if (meta->entry_bytes)
> > +		pr_warn("Ring buffer testing [%d] entry_bytes: %s (%ld/%ld)\n",
> > +			cpu_buffer->cpu,
> > +			(entry_bytes == meta->entry_bytes) ? "PASSED" : "FAILED",
> > +			(long)entry_bytes, (long)meta->entry_bytes);
> > +	meta->nr_invalid = 0;
> > +	meta->entry_bytes = 0;
> > +#endif
> >  	return;
> >  
> >   invalid:
> > @@ -2559,12 +2578,67 @@ static void rb_free_cpu_buffer(struct
> > 	  ring_buffer_per_cpu *cpu_buffer) kfree(cpu_buffer);
> >  }
> >  
> > +#ifdef CONFIG_RING_BUFFER_PERSISTENT_INJECT
> > +static void rb_test_inject_invalid_pages(struct trace_buffer *buffer)
> > +{
> > +	struct ring_buffer_per_cpu *cpu_buffer;
> > +	struct ring_buffer_cpu_meta *meta;
> > +	struct buffer_data_page *dpage;
> > +	u32 entry_bytes = 0;
> > +	unsigned long ptr;
> > +	int subbuf_size;
> > +	int invalid = 0;
> > +	int cpu;
> > +	int i;
> > +
> > +	if (!(buffer->flags & RB_FL_TESTING))
> > +		return;
> > +
> > +	guard(preempt)();
> > +	cpu = smp_processor_id();
> > +
> > +	cpu_buffer = buffer->buffers[cpu];
> > +	meta = cpu_buffer->ring_meta;
> > +	ptr = (unsigned long)rb_subbufs_from_meta(meta);
> > +	subbuf_size = meta->subbuf_size;
> > +
> > +	for (i = 0; i < meta->nr_subbufs; i++) {
> > +		int idx = meta->buffers[i];
> > +
> > +		dpage = (void *)(ptr + idx * subbuf_size);
> > +		/* Skip unused pages */
> > +		if (!local_read(&dpage->commit))
> > +			continue;
> > +
> > +		/*
> > +		 * Invalidate even pages or multiples of 5. This will lead 3
> 
> 							    This will cause 3

OK, thanks for your comments. I'll update it according your
review.

Thank you,

> 
> -- Steve
> 
> > +		 * contiguous invalidated(empty) pages.
> > +		 */
> > +		if (!(i & 0x1) || !(i % 5)) {
> > +			local_add(subbuf_size + 1, &dpage->commit);
> > +			invalid++;
> > +		} else {
> > +			/* Count total commit bytes. */
> > +			entry_bytes += local_read(&dpage->commit);
> > +		}
> > +	}
> > +
> > +	pr_info("Inject invalidated %d pages on CPU%d, total size: %ld\n",
> > +		invalid, cpu, (long)entry_bytes);
> > +	meta->nr_invalid = invalid;
> > +	meta->entry_bytes = entry_bytes;
> > +}


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
