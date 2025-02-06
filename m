Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EFD1C700E;
	Thu,  6 Feb 2025 15:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738855600; cv=none; b=TooX6TyWhC10Jx/KPkDJgGt2Fv50uCSC5zrFGrzfO2NrO3ZdWl51rl5X8Syly81WDnGhsGsLdUZt4W+S2l0Vo9fBXXEK3hKyXV7dcZDyhPUkOtvY0yVw6fOqwwlLHs/VX+XV6VvbTEd2yzeeqQlXJih7dUZCVERqDoIdnCWOFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738855600; c=relaxed/simple;
	bh=F9Rz2Q6E+Wzqfvvh0HW0lgSSQjBGxcjxaNnHLhTnOZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmSb1BG8M1BUvxeG5MuxhW98Fn1v0GSydq2WYb2R1qa7tyuVzmL/8caWcu6I861PLJthA3xQr08lFDVOTtHh2B1zr+EPhMSb8TSHbXHjR2uFQYJlxpJCGEJni8Ef/fBhmOEqmonii0qdlRQId4UHBHHwOqdFqpluf7dPEP49ttI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A7AC4CEDD;
	Thu,  6 Feb 2025 15:26:38 +0000 (UTC)
Date: Thu, 6 Feb 2025 10:27:20 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr
 Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
Message-ID: <20250206102720.0fd57129@gandalf.local.home>
In-Reply-To: <20250206142817.91853f475c681bc2ef7ca962@kernel.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.760856859@goodmis.org>
	<20250206142817.91853f475c681bc2ef7ca962@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 14:28:17 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -3809,6 +3809,20 @@ bool is_module_text_address(unsigned long addr)
> >  	return ret;
> >  }
> >    
> 
> It is better to add a kerneldoc for this API.

Agreed, but I was planning on this changing. Waiting to hear from the
module maintainers.

> 
> /** 
>  * module_for_each_mod() - iterate all modules
>  * @func: Callback function
>  * @data: User data
>  *
>  * Call the @func with each module in the system. If @func returns !0, this
>  * stops itrating. Note that @func must not sleep since it is called under
>  * the preemption disabled.
>  */
> 
> BTW, do we really need to disable preempt or is it enough to call
> rcu_read_lock()?

Bah, as I expected this function to be changed, I didn't spend too much
time on looking at its implementation. I just cut and pasted how the other
loops worked. But yes, it should not be disabling preemption. In fact, I
think the module code itself should not be disabling preemption!

I'll have to go and look into that.

Thanks!

-- Steve


> 
> Thank you,
> 
> > +void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
> > +{
> > +	struct module *mod;
> > +
> > +	preempt_disable();
> > +	list_for_each_entry_rcu(mod, &modules, list) {
> > +		if (mod->state == MODULE_STATE_UNFORMED)
> > +			continue;
> > +		if (func(mod, data))
> > +			break;
> > +	}
> > +	preempt_enable();
> > +}
> > +
> >  /**
> >   * __module_text_address() - get the module whose code contains an address.
> >   * @addr: the address.
> > -- 
