Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5E03EC2F4;
	Tue, 31 Mar 2026 09:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774948839; cv=none; b=VqsDJKSyilPXoDc4ZOJmgJpBK9hXiOWCXWVohRWdVqQfRrYC6CaeX8QcQk3IuIVVuVAgv20HoS5SmKu2eeckt0MNyzhRkOZNeZ/lPmjFAMM7OtTTqPC0VcC0bUd80o4nD6h8qNGBr+JAPZiN4ErW7al3R21fVZhiOJnuhJ+vNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774948839; c=relaxed/simple;
	bh=0hYgvycOw+xvoMxod36Yiq+Bo/qUsSK7RGGl+o9XAf0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pBJCxG3hff/cbspbpHZkY6ha1pE78BeOOc6Si31RqMa1JQPcsfdIod2ILvqUSpcrZNHEKkhxQZGPllNkmNjaWUp6yU4spYghl5F/S9wS/lLUYQL0wFYfwns3AtYct/98NAkUIl+IE28M8XhDVPamM+RX5olMjx2Czs8SXLJW2Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qNYdR0DE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qNYdR0DE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28D8DC19423;
	Tue, 31 Mar 2026 09:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774948839;
	bh=0hYgvycOw+xvoMxod36Yiq+Bo/qUsSK7RGGl+o9XAf0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qNYdR0DE5svjZcBBD4BMAidnUnCOeECyeQvbb4ONJJmrcq1afnM5BfVyt4jRzRFWo
	 it9Piz05+F/O0KNUWtZ0zYoeZoeAPLTgP5uJAeqwg4fFn2YxA2V/CDDqEThwkwFXIY
	 vkilqFB3KkfMjt0Uo6AHKgq6L6fefMq6XhujwX2HN0A+zRiLQ/Exx0m5CMuj4qFkyd
	 diJHH2xtMWRm7PRsGzUD5LuNlz3ik6tTiF5g52OV90EFxyj8skmxN9F0mJ7ZATIr1Z
	 Bh/aQvEbiYde/p6BbfUDvmCfD7pgEcLKPC4itfJc09Li7IHy8hiAgMQ7twQvQsBmP0
	 3OSgFaH6L4vOA==
Date: Tue, 31 Mar 2026 18:20:36 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: always provide a prototype for
 tracing_alloc_snapshot()
Message-Id: <20260331182036.e62143d5a9a59776d8cf7ae2@kernel.org>
In-Reply-To: <20260331082001.31345-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260331082001.31345-1-bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 31 Mar 2026 10:20:01 +0200
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com> wrote:

> The tracing_alloc_snapshot() symbol is always exported even with
> !CONFIG_TRACER_SNAPSHOT so the prototype too must be always visible or
> we'll see the following warning:
> 
> kernel/trace/trace.c:820:5: warning: no previous prototype for ‘tracing_alloc_snapshot’ [-Wmissing-prototypes]
>   820 | int tracing_alloc_snapshot(void)
>       |     ^~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: bade44fe5462 ("tracing: Move snapshot code out of trace.c and into trace_snapshot.c")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Good catch!

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks!

> ---
>  kernel/trace/trace.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 6abd9e16ef21..e8612b8b0a34 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -2275,6 +2275,8 @@ static inline void __init trace_event_init(void) { }
>  static inline void trace_event_update_all(struct trace_eval_map **map, int len) { }
>  #endif
>  
> +int tracing_alloc_snapshot(void);
> +
>  #ifdef CONFIG_TRACER_SNAPSHOT
>  extern const struct file_operations snapshot_fops;
>  extern const struct file_operations snapshot_raw_fops;
> @@ -2282,7 +2284,6 @@ extern const struct file_operations snapshot_raw_fops;
>  /* Used when creating instances */
>  int trace_allocate_snapshot(struct trace_array *tr, int size);
>  
> -int tracing_alloc_snapshot(void);
>  void tracing_snapshot_cond(struct trace_array *tr, void *cond_data);
>  int tracing_snapshot_cond_enable(struct trace_array *tr, void *cond_data, cond_update_fn_t update);
>  int tracing_snapshot_cond_disable(struct trace_array *tr);
> -- 
> 2.47.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
