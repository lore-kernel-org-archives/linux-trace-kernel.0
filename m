Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AA521CC68;
	Mon, 31 Mar 2025 15:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743435531; cv=none; b=IcSi7/HrxetCkzckbZXZgmFYM93q1SdVcHi5N5UpH8gGtokhEWcVr3/SD2X6jrnObhKxRcFJG0p/YQTsa7+Ga2tXEtuiOj1MN/Nj91xSMXO1bMtUVeXYY/Ygexsbqfny5xx44LNoD90G5Iv18gIlvpMmPzTXwCn76Lsi/dbNroA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743435531; c=relaxed/simple;
	bh=Oz77cFlqw5DPmwbKSrlj7neM+agoaLjuUmLJLZuKvZE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=XNyul2JeVoaW5UneBKU0SWvzygEMT7sgwsrdU9uSC9uPC/0hg7BOPTdPdU2wij5YZMmTEDicy055jIQt8fc6BF+KtGswMMjwEF375MiULo8R8UrzDQG7JBE7IBSMzdb8XAI7wEoF69sIHvXBDCy72YGJ4d1NXAQSUbhGqklcIVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naDzZhIn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naDzZhIn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D94C4CEE9;
	Mon, 31 Mar 2025 15:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743435530;
	bh=Oz77cFlqw5DPmwbKSrlj7neM+agoaLjuUmLJLZuKvZE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=naDzZhInFIu7ojKFiE8dgAYcoFhZb/uIZH6bS5xW0FHt4854cJKMrKMCT7ylBppTK
	 DrKPQDCxW92veNEgLnRbgUv8RfkiX3ur23VbuZEIbsQocPOSE+JvNoFs6iE64lY7Xh
	 Zm9hnFGIPLzXGCg0V4zMcpPImfUmAJ9spViTxp9cqdRWQLqBp/1gP7Kw0e9HXkU48Q
	 +sN0D6ztAgulbdQcml0rNrb8ErEEFE9X3GSOkQOkqM78/rDupZbSvJUWoebjiRQmM6
	 QZWZ88R/NKDkaa5gloS0bZ1f2kwY9p2J7uVS/eubsdeouKWrt6HUjXmqs73VNzSjca
	 yuq8mumUiGJBg==
Date: Tue, 1 Apr 2025 00:38:46 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] tracing: fprobe events: Fix possible UAF on
 modules
Message-Id: <20250401003846.0e4c0176c3410281dee27c05@kernel.org>
In-Reply-To: <174343533593.843280.8788277038071990492.stgit@devnote2>
References: <174343532655.843280.15317319860632975273.stgit@devnote2>
	<174343533593.843280.8788277038071990492.stgit@devnote2>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Oops, I have already sent this as;

https://lore.kernel.org/all/174342990779.781946.9138388479067729366.stgit@devnote2/

please ignore this.

On Tue,  1 Apr 2025 00:35:36 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Commit ac91052f0ae5 ("tracing: tprobe-events: Fix leakage of module
> refcount") moved try_module_get() from __find_tracepoint_module_cb()
> to find_tracepoint() caller, but that introduced a possible UAF
> because the module can be unloaded before try_module_get(). In this
> case, the module object should be freed too. Thus, try_module_get()
> does not only fail but may access to the freed object.
> 
> To avoid that, try_module_get() in __find_tracepoint_module_cb()
> again.
> 
> Fixes: ac91052f0ae5 ("tracing: tprobe-events: Fix leakage of module refcount")
> Cc: stable@vger.kernel.org
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/trace_fprobe.c |   26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
> index 985ff98272da..2cd9ff1049f1 100644
> --- a/kernel/trace/trace_fprobe.c
> +++ b/kernel/trace/trace_fprobe.c
> @@ -919,9 +919,15 @@ static void __find_tracepoint_module_cb(struct tracepoint *tp, struct module *mo
>  	struct __find_tracepoint_cb_data *data = priv;
>  
>  	if (!data->tpoint && !strcmp(data->tp_name, tp->name)) {
> -		data->tpoint = tp;
> -		if (!data->mod)
> +		/* If module is not specified, try getting module refcount. */
> +		if (!data->mod && mod) {
> +			/* If failed to get refcount, ignore this tracepoint. */
> +			if (!try_module_get(mod))
> +				return;
> +
>  			data->mod = mod;
> +		}
> +		data->tpoint = tp;
>  	}
>  }
>  
> @@ -933,7 +939,11 @@ static void __find_tracepoint_cb(struct tracepoint *tp, void *priv)
>  		data->tpoint = tp;
>  }
>  
> -/* Find a tracepoint from kernel and module. */
> +/*
> + * Find a tracepoint from kernel and module. If the tracepoint is on the module,
> + * the module's refcount is incremented and returned as *@tp_mod. Thus, if it is
> + * not NULL, caller must call module_put(*tp_mod) after used the tracepoint.
> + */
>  static struct tracepoint *find_tracepoint(const char *tp_name,
>  					  struct module **tp_mod)
>  {
> @@ -962,7 +972,10 @@ static void reenable_trace_fprobe(struct trace_fprobe *tf)
>  	}
>  }
>  
> -/* Find a tracepoint from specified module. */
> +/*
> + * Find a tracepoint from specified module. In this case, this does not get the
> + * module's refcount. The caller must ensure the module is not freed.
> + */
>  static struct tracepoint *find_tracepoint_in_module(struct module *mod,
>  						    const char *tp_name)
>  {
> @@ -1169,11 +1182,6 @@ static int trace_fprobe_create_internal(int argc, const char *argv[],
>  	if (is_tracepoint) {
>  		ctx->flags |= TPARG_FL_TPOINT;
>  		tpoint = find_tracepoint(symbol, &tp_mod);
> -		/* lock module until register this tprobe. */
> -		if (tp_mod && !try_module_get(tp_mod)) {
> -			tpoint = NULL;
> -			tp_mod = NULL;
> -		}
>  		if (tpoint) {
>  			ctx->funcname = kallsyms_lookup(
>  				(unsigned long)tpoint->probestub,
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
