Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F680205E0D;
	Tue,  4 Mar 2025 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741100182; cv=none; b=C72sywMTkszysXtWG6wmv1bY6xdALuzGrL6eyvpMxGTpCetEWWamqr/Z8p5cqcxt1BImvs3NPjPsBT+LeWkzuQ74q6dn5lr+OArjaZqLhFNDxbPK6h9QyRVRVtNcKUDPhv+/iMVK0aSWromotXiHQO7i6hmXa84JR5VIn2iSMak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741100182; c=relaxed/simple;
	bh=WkcT4BROTdtshKrn7PVipZZH5jr5YuyR+1h0Ukj8X/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAUrOLnru5HoQx9Ljvc8Nd90ys9OaTw7EXq+DY0c90BPJ7EXcK1ROoxN/UpzvRZwv6UMK0sozrfpi7A20uNEt2Jh9pFXNARfNRXLIMAc/x2elTqgq5dWBzCQ4O44k7UZL8sI6OsK+ySy5baXKTy4wB4+Grr+s1ZChr6XN9mJJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781FFC4CEE5;
	Tue,  4 Mar 2025 14:56:20 +0000 (UTC)
Date: Tue, 4 Mar 2025 09:57:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami
 Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-modules@vger.kernel.org
Subject: Re: [PATCH v3 5/8] module: Add module_for_each_mod() function
Message-ID: <20250304095714.47a171fa@gandalf.local.home>
In-Reply-To: <20250304012548.433669427@goodmis.org>
References: <20250304012516.282694507@goodmis.org>
	<20250304012548.433669427@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Luis,

Can I get an Acked-by from you?

This follows the changes you have in linux-next.

Thanks,

-- Steve




On Mon, 03 Mar 2025 20:25:21 -0500
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
> Changes since v2: https://lore.kernel.org/20250215034404.902259250@goodmis.org
> 
> - Use RCU guard instead of disabling preemption
> 
>  include/linux/module.h |  6 ++++++
>  kernel/module/main.c   | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 30e5b19bafa9..9a71dd2cb11f 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -782,6 +782,8 @@ static inline void *module_writable_address(struct module *mod, void *loc)
>  	return __module_writable_address(mod, loc);
>  }
>  
> +void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
> +
>  #else /* !CONFIG_MODULES... */
>  
>  static inline struct module *__module_address(unsigned long addr)
> @@ -894,6 +896,10 @@ static inline void *module_writable_address(struct module *mod, void *loc)
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
> index 1fb9ad289a6f..927a2e0ffd5f 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -3809,6 +3809,19 @@ bool is_module_text_address(unsigned long addr)
>  	return ret;
>  }
>  
> +void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data)
> +{
> +	struct module *mod;
> +
> +	guard(rcu)();
> +	list_for_each_entry_rcu(mod, &modules, list) {
> +		if (mod->state == MODULE_STATE_UNFORMED)
> +			continue;
> +		if (func(mod, data))
> +			break;
> +	}
> +}
> +
>  /**
>   * __module_text_address() - get the module whose code contains an address.
>   * @addr: the address.

