Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C722F8EB9;
	Wed, 27 May 2026 01:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779844221; cv=none; b=UdOUJTVh3Z82y4VYQHv+XUP/t9Xn1BxNR32aQEVFux7z0XZBSbfYLzV5gjS7aAx9IrmRL+nU7cfUZPDk3evggn2Lg8a+2q3o2u0+Am2oFFaMu58haGBNGhBwa8jDZgPgAoPxNVr/d1BEtREptJNH/xGC7+pZecidU5SFkL+4fZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779844221; c=relaxed/simple;
	bh=tOwAeFCDPkz0bta3UuwR3ymkHxIWAUi7udGowEBkMJs=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oZ++5QT4bgX8bPHBrD7kvrhnHdTOyCfYRpfdjKV6O6npWSTDllmUfSsq/rQ4HNJBUeYzdquXwEv5ESv4hG/GtbyzbWA12lF77mOjWLia/cYf4fDbch54Z+lmBlDOMdHjNwDu9m3sP5F0PA8aRN0Ht7xQ2cx8WFPnp1V+Aat4zow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzVx0Qag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzVx0Qag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CA41F000E9;
	Wed, 27 May 2026 01:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779844220;
	bh=RN0TDKc1lUzQ3EYWO8+G0Y4s8NhSoplT6uXK+48owRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PzVx0QagLlNQY6kfIM7WOp3AcLiCZ6gwDHMAAHXuXXTPW1l9Fl9EQ4R7OFL/Dnp+8
	 B4YrXsErD/1mNI1l+6WkgN8fPJVJIt8DqHS93Ub4K/s91Vbx0/DPGdqxNpK4WgvfvI
	 tOlseZqukVe8jYRuIkkAI7XP5EfHCWZb2d6noOzBQXtRhm76RBloMHASDBjt3b0ySE
	 SLnkbnEWhSUqV/tnYYbAaQbFu+UU+5oIHantbS/0h/roUQxtv+bFvDwrb1e1QfLo1q
	 Lgw62j9d2MKWzBkQlXFs9gwWfIVRz1QUKVIE5YPiWesEn76+Rq5RxmV83zQIyfPHCs
	 LgWyQyfFwVHNg==
Date: Wed, 27 May 2026 10:10:15 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Yu Peng <pengyu@kylinos.cn>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Use kstrdup_const() for constant hist field
 type
Message-Id: <20260527101015.74fc2d54860f16e4aba83cd7@kernel.org>
In-Reply-To: <20260526095105.1330810-1-pengyu@kylinos.cn>
References: <20260526095105.1330810-1-pengyu@kylinos.cn>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 17:51:05 +0800
Yu Peng <pengyu@kylinos.cn> wrote:

> The HIST_FIELD_FL_CONST path duplicates the literal "u64" type with
> kstrdup(), then releases it through kfree_const().
> 
> Use kstrdup_const() instead, avoiding the allocation for a .rodata string
> while keeping the matching free helper.
> 

Since we are using kfree_const() to free hist_field->type,
we can just point it as same as HIST_FIELD_FL_HITCOUNT case.

Thanks,

> Signed-off-by: Yu Peng <pengyu@kylinos.cn>
> ---
>  kernel/trace/trace_events_hist.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> index eb2c2bc8bc3d..6ffe9f4720a0 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -1992,7 +1992,7 @@ static struct hist_field *create_hist_field(struct hist_trigger_data *hist_data,
>  	if (flags & HIST_FIELD_FL_CONST) {
>  		hist_field->fn_num = HIST_FIELD_FN_CONST;
>  		hist_field->size = sizeof(u64);
> -		hist_field->type = kstrdup("u64", GFP_KERNEL);
> +		hist_field->type = kstrdup_const("u64", GFP_KERNEL);
>  		if (!hist_field->type)
>  			goto free;
>  		goto out;
> -- 
> 2.43.0


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
