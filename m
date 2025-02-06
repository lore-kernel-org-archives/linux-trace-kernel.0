Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53192376;
	Thu,  6 Feb 2025 05:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738819702; cv=none; b=fR2SYn25/s9B5AFmZ1hlKxdd3HuB+HNn09yasnczIIASbZk+rWCG+5FbjGPEA9TZ+a49eiSEGo/HAd57rdwOOEA6cusFkuHWZ91ib3rzlmBNTjHUF2dEOBd1BmVrqKepDH/1zueiDYVRPJrl4/qRLXJMzYyXYmNXKLH8YeWALWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738819702; c=relaxed/simple;
	bh=p6qRiWNTzvrTf4hk+vP0W1Rn4gHn2Xhlk2nTNDwSYFc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gln3QxiXMuB7JopG4tZenhfcStMC6Mqij4qPfhERGOEPdFqUTnKArqyXjiQSwrLSQ5ZuyhC1vPZgxkXb36Vx5MiuBvbXqwdelTlqGokV8ISeKHPgWPDOa5I3ZTnuWmCHSMSzaC3fdcnjCV2W+UjdNFWAhcfS3mbIqNANyKaBM0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dG/8bWMb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dG/8bWMb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCD7C4CEDD;
	Thu,  6 Feb 2025 05:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738819701;
	bh=p6qRiWNTzvrTf4hk+vP0W1Rn4gHn2Xhlk2nTNDwSYFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dG/8bWMbKr9pkPFUIuIh4T5HdKheWD46h1i+IN1nPAal1Rm5mjmF5PC2GOnZEm5p7
	 5qJbo+TeeSttd4DaVxECqgkyXJzekpLYxN4dcgK+mGtIaUR9uLgoJKw2JFyzpBRwGr
	 inyMQp4qaOMzjLpo5MrAOiQpv0cTAaRAE3A7Z+o9RhN3Bt0W2DRphfprE1v1a34Se2
	 rXlsPTcGkoVl8lN09TcWt58FmR6s/bP4sV+BHqs8u9+dXctILj6aD1G7rnj0BU/xKh
	 zV2W55ssrphzr6ScftVC13MBDwNDYgilxSJHzvI8X9Ojzuk80KoObZ5/4yxH8ZDGce
	 Bqtzi4xoryM5w==
Date: Thu, 6 Feb 2025 14:28:17 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr
 Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>,
 Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
Message-Id: <20250206142817.91853f475c681bc2ef7ca962@kernel.org>
In-Reply-To: <20250205225103.760856859@goodmis.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225103.760856859@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Feb 2025 17:50:36 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> The tracing system needs a way to save all the currently loaded modules
> and their addresses into persistent memory so that it can evaluate the
> addresses on a reboot from a crash. When the persistent memory trace
> starts, it will load the module addresses and names into the persistent
> memory. To do so, it will call the module_for_each_mod() function and pass
> it a function and data structure to get called on each loaded module. Then
> it can record the memory.
> 
> This only implements that function.
> 
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Petr Pavlu <petr.pavlu@suse.com>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Daniel Gomez <da.gomez@samsung.com>
> Cc: linux-modules@vger.kernel.org
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  include/linux/module.h |  6 ++++++
>  kernel/module/main.c   | 14 ++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 23792d5d7b74..9e1f42f03511 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -779,6 +779,8 @@ static inline void *module_writable_address(struct module *mod, void *loc)
>  	return __module_writable_address(mod, loc);
>  }
>  
> +void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
> +
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> @@ -891,6 +893,10 @@ static inline void *module_writable_address(struct module *mod, void *loc)
>  {
>  	return loc;
>  }
> +
> +static inline void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
> +{
> +}
>  #endif /* CONFIG_MODULES */
>  
>  #ifdef CONFIG_SYSFS
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index 1fb9ad289a6f..ea1fe313fb89 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3809,6 +3809,20 @@ bool is_module_text_address(unsigned long addr)
>  	return ret;
>  }
>  

It is better to add a kerneldoc for this API.

/** 
 * module_for_each_mod() - iterate all modules
 * @func: Callback function
 * @data: User data
 *
 * Call the @func with each module in the system. If @func returns !0, this
 * stops itrating. Note that @func must not sleep since it is called under
 * the preemption disabled.
 */

BTW, do we really need to disable preempt or is it enough to call
rcu_read_lock()?

Thank you,

> +void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
> +{
> +	struct module *mod;
> +
> +	preempt_disable();
> +	list_for_each_entry_rcu(mod, &modules, list) {
> +		if (mod->state == MODULE_STATE_UNFORMED)
> +			continue;
> +		if (func(mod, data))
> +			break;
> +	}
> +	preempt_enable();
> +}
> +
>  /**
>   * __module_text_address() - get the module whose code contains an address.
>   * @addr: the address.
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
