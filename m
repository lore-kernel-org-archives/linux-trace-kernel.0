Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3F266580;
	Tue,  2 Sep 2025 07:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798518; cv=none; b=NIoM/zYtcBByDHWhG98N2hp9pXEBur/MV5Vy2lcNLbahUsMHwG+vdGJiDp0mFW5oiptY1V80ByL8CtrWT5sXw+XLN8qDflzF/RJjUcGGOLuShaNxYznH3RrnnfQAG0DNL5GOAhAqkqDvVqEM7iEwCQ85y3FYYzl0ww4d5n40V94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798518; c=relaxed/simple;
	bh=E/WY5o6a97fVHU8e5uy2CoWMRAn7yHxp4l1Tt05M7pQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ot7dRY1wfxlddNIYHJQPAwm4H6glBU27FzHgRkByax6o/OliYyMolYMBz6w3pXRW3y30HHNDbdzVGlKosFt7TqQFvOsm+M17C/KrOrNsKYPXl5Qgz/5MCi+hhgDuA1ojbWCMSC9HfTTgoB+brBwB+obqFe1CzAnzYlUmVD9Cqsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nymPyFHa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nymPyFHa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32F30C4CEED;
	Tue,  2 Sep 2025 07:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756798517;
	bh=E/WY5o6a97fVHU8e5uy2CoWMRAn7yHxp4l1Tt05M7pQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nymPyFHaAcgHY3kjoLFAWTfg/VeqM5171gZw/UhNyg9PSulFo70S9+Uf89ywYHI2F
	 TP0kj0tj7CVr8uk31H7r6i8kgwp/Vz/lIMQJfsFXZ+qe5QdumAEUtB7oaB6fWS30oA
	 ba0B1Z4l66xfrJs0oNuIbiVCvOJzTxdFntl4jR8aunxFyTXYVkITEOMVs9zZvzFT9I
	 BksleDrnd05NzHesNhvNdLu7bpN3EkUHHVKhhYu27OCgSambrPhwWIieAEK8n3eQys
	 9QgBDGPKGDm6KMWAW2efFr5R/C+a3M3oSggjnqSZSBuK2CHxWS5GxKmt453CYagsKq
	 0tCjlMKVdJOnA==
Date: Tue, 2 Sep 2025 16:35:14 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-Id: <20250902163514.f877d9c96e913f08c0c6b0b1@kernel.org>
In-Reply-To: <cc6eb973-d82b-4afc-83fb-a2c28cc79d36@huaweicloud.com>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
	<20250819135008.5f1ba00e@gandalf.local.home>
	<436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
	<20250829082604.1e3fd06e@gandalf.local.home>
	<20250902005645.8c6436b535731a4917745c5d@kernel.org>
	<cc6eb973-d82b-4afc-83fb-a2c28cc79d36@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Sep 2025 11:47:32 +0800
Luo Gengkun <luogengkun@huaweicloud.com> wrote:

> 
> On 2025/9/1 23:56, Masami Hiramatsu (Google) wrote:
> > On Fri, 29 Aug 2025 08:26:04 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> >> [ Adding arm64 maintainers ]
> >>
> >> On Fri, 29 Aug 2025 16:29:07 +0800
> >> Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> >>
> >>> On 2025/8/20 1:50, Steven Rostedt wrote:
> >>>> On Tue, 19 Aug 2025 10:51:52 +0000
> >>>> Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> >>>>   
> >>>>> Both tracing_mark_write and tracing_mark_raw_write call
> >>>>> __copy_from_user_inatomic during preempt_disable. But in some case,
> >>>>> __copy_from_user_inatomic may trigger page fault, and will call schedule()
> >>>>> subtly. And if a task is migrated to other cpu, the following warning will
> >>>> Wait! What?
> >>>>
> >>>> __copy_from_user_inatomic() is allowed to be called from in atomic context.
> >>>> Hence the name it has. How the hell can it sleep? If it does, it's totally
> >>>> broken!
> >>>>
> >>>> Now, I'm not against using nofault() as it is better named, but I want to
> >>>> know why you are suggesting this change. Did you actually trigger a bug here?
> >>> yes, I trigger this bug in arm64.
> >> And I still think this is an arm64 bug.
> > I think it could be.
> >
> >>>>   
> >>>>> be trigger:
> >>>>>           if (RB_WARN_ON(cpu_buffer,
> >>>>>                          !local_read(&cpu_buffer->committing)))
> >>>>>
> >>>>> An example can illustrate this issue:
> > You've missed an important part.
> >
> >>>>> process flow						CPU
> >>>>> ---------------------------------------------------------------------
> >>>>>
> >>>>> tracing_mark_raw_write():				cpu:0
> >>>>>      ...
> >>>>>      ring_buffer_lock_reserve():				cpu:0
> >>>>>         ...
> > 	preempt_disable_notrace(); --> this is unlocked by ring_buffer_unlock_commit()
> >
> >>>>>         cpu = raw_smp_processor_id()			cpu:0
> >>>>>         cpu_buffer = buffer->buffers[cpu]			cpu:0
> >>>>>         ...
> >>>>>      ...
> >>>>>      __copy_from_user_inatomic():				cpu:0
> > So this is called under preempt-disabled.
> >
> >>>>>         ...
> >>>>>         # page fault
> >>>>>         do_mem_abort():					cpu:0
> >>>> Sounds to me that arm64 __copy_from_user_inatomic() may be broken.
> >>>>   
> >>>>>            ...
> >>>>>            # Call schedule
> >>>>>            schedule()					cpu:0
> > If this does not check the preempt flag, it is a problem.
> > Maybe arm64 needs to do fixup and abort instead of do_mem_abort()?
> 
> My kernel was built without CONFIG_PREEMPT_COUNT, so the preempt_disable()
> does nothing more than act as a barrier. In this case, it can pass the
> check by schedule(). Perhaps this is another issue?

OK, I got it. Indeed, in that case, we have no way to check this
happens in the preempt critical section.
Anyway, as in discussed here, __copy_from_user_inatomic() is for
the internal function, so I'm also OK to this patch.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

BTW, currently we just write a fault message if the
__copy_from_user_*() hits a fault, but I think we can retry with
normal __copy_from_user() to a kernel buffer and copy it in the
ring buffer as slow path.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
