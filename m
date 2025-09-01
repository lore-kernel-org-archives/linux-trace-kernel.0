Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97ED113E02A;
	Mon,  1 Sep 2025 15:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756742209; cv=none; b=RovOVivoXqbS07kJV8VgJj6MwdjGc8F0mlY9PoEyLBEDj9i3ma3zAPDBTh6jb7n/ca+EanW+TJB0TBd7in3PKD4F8h1f1wxqE+H88w+KC0ECphgZSuk3KdQd+d6j/6qmZaoed/R0XS/Pndo5auDSYAwnTKz2bwBoTHYNHs07nR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756742209; c=relaxed/simple;
	bh=QRrP1L09Z/tIsyyTHnZE5kLupetP4zN0OUXv+gdnLxM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=uNupso6mPITjLJwNcKy/kLVOM554gY6EQlFDstY61zlzos8pBYtB6Z4ZktEvaThYPO0oVrjdRbDBIYJYmyRo9BBAFN5qOGP2gfHoAGkJuS3tgkkkxv6LN1On17tJulPiFGsNtZJu8XIVrCVqHCL4NGdI8Gu3r2hieEjJFPGfcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s+hHGCrV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s+hHGCrV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88B1C4CEF1;
	Mon,  1 Sep 2025 15:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756742209;
	bh=QRrP1L09Z/tIsyyTHnZE5kLupetP4zN0OUXv+gdnLxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s+hHGCrVP5/Uqb2MOTw2HVgpr6oRsF7MUtdSFcFhI89V8gRTjRULuEJoLc8Gpq0hw
	 F1BdujSnDIEvOHM4ihyrNytqHkb8fvgsjy15fYhOhxn7tRljLmCOJU1bFOKcE6onK5
	 Le69W7GBDmgmh5rwo2zvdxM3Y4Tz74rPfPmEaHh1xlzVA/Y5g5DNRYsBUdZEEqOnHB
	 Crdk6XF6mWBQYX0yZoRkV+hxUA70hdzoMFDuWCSs7O2g8rxthmvccZ3etoDMYiyABR
	 dB6yqUkYYfHZsaKUzxyMR3zpUeNklwKUH/tDMCYI3rSlJqwRQ9RyM7Nu7U8OcA7dQv
	 MPp2jFt4xrlzA==
Date: Tue, 2 Sep 2025 00:56:45 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Luo Gengkun <luogengkun@huaweicloud.com>, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-Id: <20250902005645.8c6436b535731a4917745c5d@kernel.org>
In-Reply-To: <20250829082604.1e3fd06e@gandalf.local.home>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
	<20250819135008.5f1ba00e@gandalf.local.home>
	<436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
	<20250829082604.1e3fd06e@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 08:26:04 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> [ Adding arm64 maintainers ]
> 
> On Fri, 29 Aug 2025 16:29:07 +0800
> Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> 
> > On 2025/8/20 1:50, Steven Rostedt wrote:
> > > On Tue, 19 Aug 2025 10:51:52 +0000
> > > Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> > >  
> > >> Both tracing_mark_write and tracing_mark_raw_write call
> > >> __copy_from_user_inatomic during preempt_disable. But in some case,
> > >> __copy_from_user_inatomic may trigger page fault, and will call schedule()
> > >> subtly. And if a task is migrated to other cpu, the following warning will  
> > > Wait! What?
> > >
> > > __copy_from_user_inatomic() is allowed to be called from in atomic context.
> > > Hence the name it has. How the hell can it sleep? If it does, it's totally
> > > broken!
> > >
> > > Now, I'm not against using nofault() as it is better named, but I want to
> > > know why you are suggesting this change. Did you actually trigger a bug here?  
> > 
> > yes, I trigger this bug in arm64.
> 
> And I still think this is an arm64 bug.

I think it could be.

> > >  
> > >> be trigger:
> > >>          if (RB_WARN_ON(cpu_buffer,
> > >>                         !local_read(&cpu_buffer->committing)))
> > >>
> > >> An example can illustrate this issue:

You've missed an important part.

> > >>
> > >> process flow						CPU
> > >> ---------------------------------------------------------------------
> > >>
> > >> tracing_mark_raw_write():				cpu:0
> > >>     ...
> > >>     ring_buffer_lock_reserve():				cpu:0
> > >>        ...

	preempt_disable_notrace(); --> this is unlocked by ring_buffer_unlock_commit()

> > >>        cpu = raw_smp_processor_id()			cpu:0
> > >>        cpu_buffer = buffer->buffers[cpu]			cpu:0
> > >>        ...
> > >>     ...
> > >>     __copy_from_user_inatomic():				cpu:0

So this is called under preempt-disabled.

> > >>        ...
> > >>        # page fault
> > >>        do_mem_abort():					cpu:0  
> > > Sounds to me that arm64 __copy_from_user_inatomic() may be broken.
> > >  
> > >>           ...
> > >>           # Call schedule
> > >>           schedule()					cpu:0

If this does not check the preempt flag, it is a problem.
Maybe arm64 needs to do fixup and abort instead of do_mem_abort()?

> > >> 	 ...
> > >>     # the task schedule to cpu1
> > >>     __buffer_unlock_commit():				cpu:1
> > >>        ...
> > >>        ring_buffer_unlock_commit():			cpu:1
> > >> 	 ...
> > >> 	 cpu = raw_smp_processor_id()			cpu:1
> > >> 	 cpu_buffer = buffer->buffers[cpu]		cpu:1

	preempt_enable_notrace(); <-- here we enable preempt again.

> > >>
> > >> As shown above, the process will acquire cpuid twice and the return values
> > >> are not the same.
> > >>
> > >> To fix this problem using copy_from_user_nofault instead of
> > >> __copy_from_user_inatomic, as the former performs 'access_ok' before
> > >> copying.
> > >>
> > >> Fixes: 656c7f0d2d2b ("tracing: Replace kmap with copy_from_user() in trace_marker writing")  
> > > The above commit was intorduced in 2016. copy_from_user_nofault() was
> > > introduced in 2020. I don't think this would be the fix for that kernel.
> > >
> > > So no, I'm not taking this patch. If you see __copy_from_user_inatomic()
> > > sleeping, it's users are not the issue. That function is.


BTW, the biggest difference between __copy_from_user() and
 __copy_from_user_inatomic() is `might_fault()` and `should_fail_usercopy()`.
The latter is a fault injection, so we can ignore it. But since
the `might_fail()` is NOT in __copy_from_user_inatomic(), it is designed
not to cause fault as Steve said?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
