Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB8423D2;
	Wed, 11 Sep 2024 00:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726014094; cv=none; b=XNhZgLiHJKl7/sxXbrjBVdlt7TV9qb4lAWtXpo9Akfnw1VU5SGIklCshz71xWQPcdNkvbxIgKyiqVokuHWKC+8K7Z2RlmyCcza7ZbF+BBeW6up0ZGOh3zspJsdXDoc0042g2sT4jAOTz6apCUaE1D3NjQ7lmwl4KBLZtc8dc7k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726014094; c=relaxed/simple;
	bh=2c33F73JjETshDpHhpn22hC7tKCXgwXZeTVaME0U3Hs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PK0ki0pDNxTHoZyZycG3TFbrjoolLTq1HXPUQGOWBcBV00z4yWzS0U88Mp4KOneuKpw5lPmfZtL+G8xXi/zwmVRlEfUfdMiyRQRSLqYVC9ZOkgm2cSA93sCnnJ1YGOmm2oRpBG08XfhOVZ3sQ9r/wZpLelC8/6M1f/e+WE+uAos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdGa9app; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdGa9app"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A1EC4CEC3;
	Wed, 11 Sep 2024 00:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726014094;
	bh=2c33F73JjETshDpHhpn22hC7tKCXgwXZeTVaME0U3Hs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fdGa9appx7ggX4pzdq6PX8DOWmUua26A0lCeemQIamqL9k7PcIerO2c9ij7tNe8na
	 YI9Ox1cGP0rQ5HlzFpTnW5FCi/7PQcpRtd689BzsEy+AqJ1HDuhYF0YB/Cd5GVwTiY
	 0jrxM1zDS6LQDb1S1ZqqrZDIeHPRH7Op4/NMKyqkwJxDDtHtCVE7b5TZTxHZwCBUKE
	 7zyUOBBkAOm6Lut9gpgEDY6RburVO4SjMXJpb8CkycdbyH4oSHHGTcTjyCeqrK1m9H
	 /WbuTv0jUc8pg6lM2vz/DbgmLZQshVtoC306ST0b801EWC2WG0BV35PZOWm6U5Ecg6
	 IFKrnPtCOaE6Q==
Date: Wed, 11 Sep 2024 09:21:30 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, don <zds100@gmail.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] tracepoint: Support tterating tracepoints in a
 loading module
Message-Id: <20240911092130.747cd0e5aa540770b4588559@kernel.org>
In-Reply-To: <172397778740.286558.15781131277732977643.stgit@devnote2>
References: <172397776900.286558.8986646398199362026.stgit@devnote2>
	<172397778740.286558.15781131277732977643.stgit@devnote2>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The subject has a typo, "tterating" -> "iterating".

I'll fix it and import this to probes/for-next.

Thank you,

On Sun, 18 Aug 2024 19:43:07 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Add for_each_tracepoint_in_module() function to iterate tracepoints in
> a module. This API is needed for handling tracepoints in a loading
> module from tracepoint_module_notifier callback function.
> This also update for_each_module_tracepoint() to pass the module to
> callback function so that it can find module easily.
> 
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  Changes in v3:
>   - Newly added.
> ---
>  include/linux/tracepoint.h |   17 +++++++++++++++--
>  kernel/tracepoint.c        |   37 +++++++++++++++++++++++++++++--------
>  2 files changed, 44 insertions(+), 10 deletions(-)
> 
> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 837fcf8ec0d5..93a9f3070b48 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -64,8 +64,13 @@ struct tp_module {
>  bool trace_module_has_bad_taint(struct module *mod);
>  extern int register_tracepoint_module_notifier(struct notifier_block *nb);
>  extern int unregister_tracepoint_module_notifier(struct notifier_block *nb);
> -void for_each_module_tracepoint(void (*fct)(struct tracepoint *, void *),
> +void for_each_module_tracepoint(void (*fct)(struct tracepoint *,
> +					struct module *, void *),
>  				void *priv);
> +void for_each_tracepoint_in_module(struct module *,
> +				   void (*fct)(struct tracepoint *,
> +					struct module *, void *),
> +				   void *priv);
>  #else
>  static inline bool trace_module_has_bad_taint(struct module *mod)
>  {
> @@ -82,10 +87,18 @@ int unregister_tracepoint_module_notifier(struct notifier_block *nb)
>  	return 0;
>  }
>  static inline
> -void for_each_module_tracepoint(void (*fct)(struct tracepoint *, void *),
> +void for_each_module_tracepoint(void (*fct)(struct tracepoint *,
> +					struct module *, void *),
>  				void *priv)
>  {
>  }
> +static inline
> +void for_each_tracepoint_in_module(struct module *mod,
> +				   void (*fct)(struct tracepoint *,
> +					struct module *, void *),
> +				   void *priv)
> +{
> +}
>  #endif /* CONFIG_MODULES */
>  
>  /*
> diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
> index bed4aad36d92..8879da16ef4d 100644
> --- a/kernel/tracepoint.c
> +++ b/kernel/tracepoint.c
> @@ -736,24 +736,45 @@ static __init int init_tracepoints(void)
>  }
>  __initcall(init_tracepoints);
>  
> +/**
> + * for_each_tracepoint_in_module - iteration on all tracepoints in a module
> + * @mod: module
> + * @fct: callback
> + * @priv: private data
> + */
> +void for_each_tracepoint_in_module(struct module *mod,
> +				   void (*fct)(struct tracepoint *tp,
> +				    struct module *mod, void *priv),
> +				   void *priv)
> +{
> +	tracepoint_ptr_t *begin, *end, *iter;
> +
> +	lockdep_assert_held(&tracepoint_module_list_mutex);
> +
> +	if (!mod)
> +		return;
> +
> +	begin = mod->tracepoints_ptrs;
> +	end = mod->tracepoints_ptrs + mod->num_tracepoints;
> +
> +	for (iter = begin; iter < end; iter++)
> +		fct(tracepoint_ptr_deref(iter), mod, priv);
> +}
> +
>  /**
>   * for_each_module_tracepoint - iteration on all tracepoints in all modules
>   * @fct: callback
>   * @priv: private data
>   */
> -void for_each_module_tracepoint(void (*fct)(struct tracepoint *tp, void *priv),
> +void for_each_module_tracepoint(void (*fct)(struct tracepoint *tp,
> +				 struct module *mod, void *priv),
>  				void *priv)
>  {
>  	struct tp_module *tp_mod;
> -	struct module *mod;
>  
>  	mutex_lock(&tracepoint_module_list_mutex);
> -	list_for_each_entry(tp_mod, &tracepoint_module_list, list) {
> -		mod = tp_mod->mod;
> -		for_each_tracepoint_range(mod->tracepoints_ptrs,
> -			mod->tracepoints_ptrs + mod->num_tracepoints,
> -			fct, priv);
> -	}
> +	list_for_each_entry(tp_mod, &tracepoint_module_list, list)
> +		for_each_tracepoint_in_module(tp_mod->mod, fct, priv);
>  	mutex_unlock(&tracepoint_module_list_mutex);
>  }
>  #endif /* CONFIG_MODULES */
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
