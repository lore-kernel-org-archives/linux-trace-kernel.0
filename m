Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539D21D5CD1;
	Tue, 31 Mar 2026 01:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774920297; cv=none; b=o7pwFSHbLgYpc+IyM02oFF44dXuwAfQU/eEpwJLnTmJFdZCwEigf32r5fbfxmm5qY5ejRZFlA6SMXKgtihhNeXyClxy8aEbZN5POhKrSL3oAX9pC2PT5OOZA3NHrVjnQuyHt2yt56S8l+4BHKOq6aQYEgUFP2Yj71h8rfUaC1c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774920297; c=relaxed/simple;
	bh=uzhnwoV+mM+GNSitKoGUojylzVaJORN//UYYjIRXso8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=F/1QOq6t7k9KB9xePscMxrsN82FuCtLni/Ttr7bvTRdkSjQv1isPWhGfL0rpYtuYnAATOqNrkSvNqj9Yq71eRkyApcJrL7330QRIXj1iak6AxXk9LSlVgcKOSB8idWYTSmBh732EAjO/ksJly72NRrrApTKHb2oUmBodrVGIn68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvY46Ilj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvY46Ilj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254F2C4CEF7;
	Tue, 31 Mar 2026 01:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774920297;
	bh=uzhnwoV+mM+GNSitKoGUojylzVaJORN//UYYjIRXso8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JvY46IljQ/bL9eTu8cJJyglyR8PgakZRVdDATd/GA2gxUBr9euComP9hg8V4wfDVT
	 eOXaMWCfyNzsUv7yy+vH82BCfuVv8KsaFPEgz8X0VQ+EOYlIWQSwu7P5iuvxH5/M/h
	 FRuZ7isCrSJeOQduqBPLPyOgV/pEi/vnDfqJDfC1wjaJ6hVEUlNV+8vMXAR1N5rD7R
	 gfOGEFIEHH4Qgg4T8tuq0Csu+FInbTizAT61Rc2QTRuZ2s1FZUWCpnKjW9+el5pzDx
	 Te/THxUjZdJbOs3wHdeTTB0c4aee4mNvEzvzhQMEgIG6tQW1qjOGzOE0Aa1EE+60ck
	 pMkidyPVkSpDA==
Date: Tue, 31 Mar 2026 10:24:54 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Ian
 Rogers <irogers@google.com>
Subject: Re: [PATCH v14 2/5] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-Id: <20260331102454.b94d304562bab25eb6fef63d@kernel.org>
In-Reply-To: <20260330162822.54f6bd02@gandalf.local.home>
References: <177487498530.3463592.12715592581212799257.stgit@mhiramat.tok.corp.google.com>
	<177487500432.3463592.13753720277119177967.stgit@mhiramat.tok.corp.google.com>
	<20260330162210.5e37b0c3@gandalf.local.home>
	<20260330162822.54f6bd02@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Mar 2026 16:28:22 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Mon, 30 Mar 2026 16:22:10 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Mon, 30 Mar 2026 21:50:04 +0900
> > "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> > 
> > > @@ -2042,7 +2065,8 @@ static void rb_meta_validate_events(struct ring_buffer_per_cpu *cpu_buffer)
> > >  	local_set(&cpu_buffer->entries, entries);
> > >  	local_set(&cpu_buffer->entries_bytes, entry_bytes);
> > >  
> > > -	pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
> > > +	pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
> > > +		cpu_buffer->cpu, discarded);  
> > 
> > As pages should never be discarded unless something went wrong, let's only
> > print that if there were discarded pages.
> > 
> > 	if (discarded) {
> > 		pr_info("Ring buffer meta [%d] is from previous boot! (%d pages discarded)\n",
> > 			cpu_buffer->cpu, discarded);
> > 	} else {
> > 		pr_info("Ring buffer meta [%d] is from previous boot!\n", cpu_buffer->cpu);
> > 	}
> 
> Or perhaps:
> 
> 	pr_info("Ring buffer meta [%d] is from previous boot!", cpu_buffer->cpu);
> 	if (discarded)
> 		pr_cont(" (%d pages discarded)", discarded);
> 	pr_cont("\n");

OK. I'll do this.

Thanks for the comment!

> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
