Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76BC2451C2;
	Wed, 11 Dec 2024 04:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733889659; cv=none; b=s7QOINw8Jqh9DhQmrpz3BBPsrkdOTdNCOqeASbvfbq32snv8BZasim73dQKAI30dddp3w9FlBAUTM/pyIBw+RrFZ0W5XawYNA8hmbUG1HikaJhXxhmNl4DTYTEuTcrqmExvBynEI0eIrhA+4bzgBRAIpUuTZOrnFoEovMofK+Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733889659; c=relaxed/simple;
	bh=sfeQj5583hdabYkPUL/lo/8AN06wJt4Ey3S1inZRGNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XGu/snn5sJ8DzC3S0DCGN4ElBpsfXBCMg/ViWBhp8cLbWWDKA/mpIfhruyhrJad3jpEf5oPu2AtQOrgZ3AuWNMk2ZjD0l/w767eI0JnHleU6o7hOUOAluPY3WNxlzTxWgvwDwdjlZb9FR9PFxeUIDKY/il5MTLnb+nxHp/kesYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 717C4C4CED2;
	Wed, 11 Dec 2024 04:00:58 +0000 (UTC)
Date: Tue, 10 Dec 2024 23:00:56 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar
 <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/ftrace: fix boot time slowdown
Message-ID: <20241210230056.185826cd@batman.local.home>
In-Reply-To: <Z07KnNk5AK_Jq6CU@kernel.org>
References: <20241124140705.2883-1-rppt@kernel.org>
	<Z07KnNk5AK_Jq6CU@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Dec 2024 11:08:44 +0200
Mike Rapoport <rppt@kernel.org> wrote:

> Gentle ping

I'll take this if nobody else will.

-- Steve

> 
> On Sun, Nov 24, 2024 at 04:07:05PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Steven Rostedt reported slowdown by over 30ms caused by commit 9bfc4824fd48
> > ("x86/module: prepare module loading for ROX allocations of text")
> > 
> >   Before:
> > 
> >    # cat /sys/kernel/tracing/dyn_ftrace_total_info
> >   57695 pages:231 groups: 9
> >   ftrace boot update time = 14733459 (ns)
> >   ftrace module total update time = 449016 (ns)
> > 
> >   After:
> > 
> >    # cat /sys/kernel/tracing/dyn_ftrace_total_info
> >   57708 pages:231 groups: 9
> >   ftrace boot update time = 47195374 (ns)
> >   ftrace module total update time = 592080 (ns)
> > 
> > The slowdown happened because initial patching of kernel code for ftrace
> > was switched from text_poke_early() to text_poke() to accommodate ftrace
> > updates of module text allocated as ROX.
> > 
> > Restore the use of text_poke_early() for boot time patching of the kernel
> > code.
> > 
> > Reported-by: Steven Rostedt <rostedt@goodmis.org>
> > Closes: https://lore.kernel.org/all/20241118132501.4eddb46c@gandalf.local.home
> > Fixes: 9bfc4824fd48 ("x86/module: prepare module loading for ROX allocations of text")
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/x86/kernel/ftrace.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
> > index 4dd0ad6c94d6..9e50288abbaa 100644
> > --- a/arch/x86/kernel/ftrace.c
> > +++ b/arch/x86/kernel/ftrace.c
> > @@ -111,7 +111,7 @@ static int ftrace_verify_code(unsigned long ip, const char *old_code)
> >   */
> >  static int __ref
> >  ftrace_modify_code_direct(unsigned long ip, const char *old_code,
> > -			  const char *new_code)
> > +			  const char *new_code, struct module *mod)
> >  {
> >  	int ret = ftrace_verify_code(ip, old_code);
> >  	if (ret)
> > @@ -120,6 +120,8 @@ ftrace_modify_code_direct(unsigned long ip, const char *old_code,
> >  	/* replace the text with the new text */
> >  	if (ftrace_poke_late) {
> >  		text_poke_queue((void *)ip, new_code, MCOUNT_INSN_SIZE, NULL);
> > +	} else if (!mod) {
> > +		text_poke_early((void *)ip, new_code, MCOUNT_INSN_SIZE);
> >  	} else {
> >  		mutex_lock(&text_mutex);
> >  		text_poke((void *)ip, new_code, MCOUNT_INSN_SIZE);
> > @@ -145,7 +147,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long ad
> >  	 * just modify the code directly.
> >  	 */
> >  	if (addr == MCOUNT_ADDR)
> > -		return ftrace_modify_code_direct(ip, old, new);
> > +		return ftrace_modify_code_direct(ip, old, new, mod);
> >  
> >  	/*
> >  	 * x86 overrides ftrace_replace_code -- this function will never be used
> > @@ -164,7 +166,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> >  	new = ftrace_call_replace(ip, addr);
> >  
> >  	/* Should only be called when module is loaded */
> > -	return ftrace_modify_code_direct(rec->ip, old, new);
> > +	return ftrace_modify_code_direct(rec->ip, old, new, NULL);
> >  }
> >  
> >  /*
> > 
> > base-commit: 9f16d5e6f220661f73b36a4be1b21575651d8833
> > -- 
> > 2.45.2
> >   
> 

