Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8A265CC0;
	Fri, 29 Aug 2025 12:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470348; cv=none; b=AWQig3H/7STtCixTWi9dBdzCtgXT50QQ8nIdrqcvI1HAdXhrdX2diR6zwaU+MoTAlz3+jlekDOPwpDRZ1GVcWeCHRW30KxxE2UbQ/F+FHizaX5orU41G15/FY4K8Q4LjoMYCCmQPRNCXk9TwZj2LkrP5B4pnNsjmBr9pUUBIubY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470348; c=relaxed/simple;
	bh=3u1+i5KWMvzk3PcIfscyZ1ILqglDLdFXMkr2wdThA14=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IEyP9lFQkziefZNradTymoHkdMN6DZSN2Ip0VeKKNtcZAmDfCO+RpsrBneBd/MYUocjQn6R3b5zjMRLzkx8qFRH0+6ffbMJ1H62CW2GI9b+/+xE7TFvctt/cEv7oWg7naPcopPTX8tjRKZVy/6VdFLKyLjrqbeEmYf8EKUw2eAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 5EE46BADE0;
	Fri, 29 Aug 2025 12:25:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id 5CCF120027;
	Fri, 29 Aug 2025 12:25:42 +0000 (UTC)
Date: Fri, 29 Aug 2025 08:26:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Fix tracing_marker may trigger page fault
 during preempt_disable
Message-ID: <20250829082604.1e3fd06e@gandalf.local.home>
In-Reply-To: <436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
References: <20250819105152.2766363-1-luogengkun@huaweicloud.com>
	<20250819135008.5f1ba00e@gandalf.local.home>
	<436e4fa7-f8c7-4c23-a28a-4e5eebe2f854@huaweicloud.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5CCF120027
X-Stat-Signature: z4qee96ax9gocnkpiu6zi9es954bzpw8
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//eG0SPh1gXzSvhvFw/mS6TyA0QJDKqYs=
X-HE-Tag: 1756470342-908911
X-HE-Meta: U2FsdGVkX195ZgDOTbivrDBTaufOHEnsk6PH2OHOVpi9ojybHHHjo+zy+PeSzr/EOxHT+tJW9yhUm44IbnMOZIbQ9I5ne1xKch07oeuKvb843vUBYWVLBhmzJmPTdMMwUrD3UZ5jKD0jWcwB+oouhMyHzFKenViz4q+lSCtfhzKxn5fCJBjZAfjiF/lS7i1B8eE2ND5nI+rBiA9a6ZWJ+2UiTAhUWYAmR4C5ooFf7VFPF/LXnrAnb36shVcxzstQwJp5t9eeyJhrs0mn5AH8v/zHwvU1YGJLeG9Xsavq3ongCZTqfdoVEMKzCcz1SMRbh1dgLJSiwgD1jxqrLBzE2r8JHLs5DsA8h53z7hGGNQ8SjLGpCFqkWqYEhEpLDX+r


[ Adding arm64 maintainers ]

On Fri, 29 Aug 2025 16:29:07 +0800
Luo Gengkun <luogengkun@huaweicloud.com> wrote:

> On 2025/8/20 1:50, Steven Rostedt wrote:
> > On Tue, 19 Aug 2025 10:51:52 +0000
> > Luo Gengkun <luogengkun@huaweicloud.com> wrote:
> >  
> >> Both tracing_mark_write and tracing_mark_raw_write call
> >> __copy_from_user_inatomic during preempt_disable. But in some case,
> >> __copy_from_user_inatomic may trigger page fault, and will call schedule()
> >> subtly. And if a task is migrated to other cpu, the following warning will  
> > Wait! What?
> >
> > __copy_from_user_inatomic() is allowed to be called from in atomic context.
> > Hence the name it has. How the hell can it sleep? If it does, it's totally
> > broken!
> >
> > Now, I'm not against using nofault() as it is better named, but I want to
> > know why you are suggesting this change. Did you actually trigger a bug here?  
> 
> yes, I trigger this bug in arm64.

And I still think this is an arm64 bug.

> 
> >  
> >> be trigger:
> >>          if (RB_WARN_ON(cpu_buffer,
> >>                         !local_read(&cpu_buffer->committing)))
> >>
> >> An example can illustrate this issue:
> >>
> >> process flow						CPU
> >> ---------------------------------------------------------------------
> >>
> >> tracing_mark_raw_write():				cpu:0
> >>     ...
> >>     ring_buffer_lock_reserve():				cpu:0
> >>        ...
> >>        cpu = raw_smp_processor_id()			cpu:0
> >>        cpu_buffer = buffer->buffers[cpu]			cpu:0
> >>        ...
> >>     ...
> >>     __copy_from_user_inatomic():				cpu:0
> >>        ...
> >>        # page fault
> >>        do_mem_abort():					cpu:0  
> > Sounds to me that arm64 __copy_from_user_inatomic() may be broken.
> >  
> >>           ...
> >>           # Call schedule
> >>           schedule()					cpu:0
> >> 	 ...
> >>     # the task schedule to cpu1
> >>     __buffer_unlock_commit():				cpu:1
> >>        ...
> >>        ring_buffer_unlock_commit():			cpu:1
> >> 	 ...
> >> 	 cpu = raw_smp_processor_id()			cpu:1
> >> 	 cpu_buffer = buffer->buffers[cpu]		cpu:1
> >>
> >> As shown above, the process will acquire cpuid twice and the return values
> >> are not the same.
> >>
> >> To fix this problem using copy_from_user_nofault instead of
> >> __copy_from_user_inatomic, as the former performs 'access_ok' before
> >> copying.
> >>
> >> Fixes: 656c7f0d2d2b ("tracing: Replace kmap with copy_from_user() in trace_marker writing")  
> > The above commit was intorduced in 2016. copy_from_user_nofault() was
> > introduced in 2020. I don't think this would be the fix for that kernel.
> >
> > So no, I'm not taking this patch. If you see __copy_from_user_inatomic()
> > sleeping, it's users are not the issue. That function is.
> >
> > -- Steve
> >
> >  
> I noticed that in most places where __copy_from_user_inatomic() is used,

"most" but not all?

> it is within the pagefault_disable/enable() section. When pagefault_disable()
> is called, user access methods will no sleep. So I'm going to send a v2patch which use pagefault_disable/enable()to fix this problem. -- Gengkun

No, I don't want that either. __copy_from_user_inatomic() SHOULD NOT SLEEP!
If it does, than it is a bug!

If it can sleep, "inatomic" is a very bad name. The point of being
"inatomic" is that you are in a location that IS NOT ALLOWED TO SLEEP!

I don't want to fix a symptom and leave a bug around.

BTW, the reason not to fault is because this might be called in code that is
already doing a fault and could cause deadlocks. The no sleeping part is a
side effect.

-- Steve
