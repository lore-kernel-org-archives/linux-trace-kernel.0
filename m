Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0427B35B;
	Wed, 29 Apr 2026 15:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777476103; cv=none; b=K837IWvQoauqXPH69v6u7aiupnV42rXI6tM32sjEIOYrZlChbbJ5tr+sN180pS268/zFyTNr4I5ipRCwq7WKW/9V0YcWWAOv5/4Lmk2WRCvcNzvPmrmV7omLsOA21vlbNdmOirGqzxeCAz7wEWR5lWLFrNysxuerJpa3sWlx5YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777476103; c=relaxed/simple;
	bh=DSYoQLeKmR5kS8394wFYsYzBGy66CBuLT27W6NUeeK8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=nrYeGyfLAG1nqUfKaC5/QMSi+8Ac5bDEhW8qFho7pXl/HRjzS2NLrBnYoMSfdtbdr66jHvo4lmH4T7COGQCqw6U/9Qp9Oo+XBD9XIhBVvDHB8hR88YJrSJ4wwPRuyhn6ir4CfQ+alZUkbKi4Qr1YXaKmpkvgJRUokM3vv2gVljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBWc37un; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBWc37un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10012C19425;
	Wed, 29 Apr 2026 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777476102;
	bh=DSYoQLeKmR5kS8394wFYsYzBGy66CBuLT27W6NUeeK8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LBWc37un6FXwtUJ8TTvdTzJpJ4A8lFVOiZXDNLS4gdTDLba6mC61hWZMHzSWCnvTz
	 SubuKzcRBWhWMkzht9UGNzmWGkHFaxQBuRLhXxn3kGpKxWcb8D2iXn7OKpNtaBp3nm
	 icqtzYb6HY8VXsFzGsZga3hotWp/HN8wTQY3dEjiVWdDROT9mTVfSdG97CIeWiVfcq
	 d4b1lluj90oByN4QIyYCw26BF8smMJSb3xYkKSVNAeYwn9cJCew5mA6ugNthGZow99
	 80OqVi3DcAHeve3hZ83KgT+oj3M4y5xPhAVb1bVsfVtswSdiNyQv7kTG7Rq9DWU8LO
	 mE9FkDhIZBXWw==
Date: Thu, 30 Apr 2026 00:21:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 7/8] ring-buffer: Cleanup persistent ring buffer
 validation
Message-Id: <20260430002139.c3b0e4c92ae52aeeaf86e1bf@kernel.org>
In-Reply-To: <20260428162457.1ca8c4b6@gandalf.local.home>
References: <177701351903.2223789.17087009302463188638.stgit@mhiramat.tok.corp.google.com>
	<177701357903.2223789.1327164275262010250.stgit@mhiramat.tok.corp.google.com>
	<20260428162457.1ca8c4b6@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Apr 2026 16:24:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 24 Apr 2026 15:52:59 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Cleanup rb_meta_validate_events() function to make it easier to read.
> > This includes the following cleanups:
> >  - Introduce rb_validatation_state to hold working variables in
> >    validation.
> >  - Move repleated validation state updates into rb_validate_buffer().
> >  - Move reader_page injection code outside of rb_meta_validate_events().
> > 
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> >  kernel/trace/ring_buffer.c |  186 ++++++++++++++++++++++----------------------
> >  1 file changed, 95 insertions(+), 91 deletions(-)
> > 
> > diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> > index de653a8e3cec..9850a0d8d24b 100644
> > --- a/kernel/trace/ring_buffer.c
> > +++ b/kernel/trace/ring_buffer.c
> > @@ -1883,8 +1883,16 @@ static int rb_read_data_buffer(struct buffer_data_page *dpage, int tail, int cpu
> >  	return events;
> >  }
> >  
> > -static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
> > -			      struct ring_buffer_cpu_meta *meta, u64 prev_ts, u64 next_ts)
> > +struct rb_validation_state {
> > +	unsigned long entries;
> > +	unsigned long entry_bytes;
> > +	int discarded;
> > +	u64 ts;
> > +};
> > +
> > +static int __rb_validate_buffer(struct buffer_page *bpage, int cpu,
> > +				struct ring_buffer_cpu_meta *meta,
> > +				u64 prev_ts, u64 next_ts)
> >  {
> 
> This can still use those comments (from patch 4).
> 
> Also, could you rebase on top of v7.1-rc1?

Is it v7.1-rc1, not ring-buffer/for-next?

Thanks,

> 
> Thanks Masami!
> 
> -- Steve
> 
> >  	struct buffer_data_page *dpage = bpage->page;
> >  	unsigned long long ts;
> > @@ -1914,16 +1922,82 @@ static int rb_validate_buffer(struct buffer_page *bpage, int cpu,
> >  	return ret;
> >  }


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
