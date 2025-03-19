Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29145380;
	Wed, 19 Mar 2025 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742342814; cv=none; b=QITLMUaeOwbXMo+ZAiGPUYRYqwvhSHiNWIxrWR4nIZF5komoU2KHFl5kJIW4ybubcTzU7FLzJjEnyApord85qG8BxQRrJpDjmfDACg8gdejwG7MD1zp/1mdcHJ+aG7jgE7hhFm44BVn253SJUCYmnjvdzrLONfzEe3EHupgBvsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742342814; c=relaxed/simple;
	bh=gcN/zzGvLZN1B7SFP4Y0Bx9RKBrFoJ68+g/rSpOfAqo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=BCDQBkkysUG++mCWp55Y1RR0uE+fEXF8pFBXfvWXzDcyv0yneGsJt+3x6fVJyJ/s7oaCTBfEYN1cbIASCJmXfUUu8mqi4dRrbh5RO6szHDt+EqSFEth6REHFiEbV2XPOBwkj6movVUAwRY+XuebQM076B68r+PWFfsG/NsiW+0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rj6JlJvy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rj6JlJvy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453EBC4CEE9;
	Wed, 19 Mar 2025 00:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742342813;
	bh=gcN/zzGvLZN1B7SFP4Y0Bx9RKBrFoJ68+g/rSpOfAqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rj6JlJvyeptJ6QULtFZB+Y+rkaauesly+lIS6Y38HFU0tj0s7ylMfVPfcbk1XYKMl
	 3J7Uvk8Vy2PtnskV5nf19oo8Er3zUEJYEllMb69PTLt50eblA1HiE27/tBgX8ktuHs
	 vg0mbTKajx1YitI8wWK6V8UMlk7R29RpqfI16bVqYB52K5osmu9sOc0ONHT96zVX3a
	 mp9dZJJOOFqGntH4/NrwBHEOUiLGrI9FV8RGLLt0j9JSKsJNGUbEljB1BpPNZLAizq
	 Lvi4/Fbtoed/Cn1KyTVlE+NmdUveEKx3B55psnQ5TcEAe0FR0J/OyUeRXK7JhW11qQ
	 QMR8fxQhTe1tA==
Date: Wed, 19 Mar 2025 09:06:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Miaoqian Lin <linmq006@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tom Zanussi <zanussi@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix error handling in event_trigger_parse
Message-Id: <20250319090650.fe63164eac3ac32bb559ffc8@kernel.org>
In-Reply-To: <20250318112737.4174-1-linmq006@gmail.com>
References: <20250318112737.4174-1-linmq006@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Mar 2025 19:27:37 +0800
Miaoqian Lin <linmq006@gmail.com> wrote:

> According to event_trigger_alloc() doc, event_trigger_free() should be
> used to free an event_trigger_data object. This fixes a mismatch introduced
> when kzalloc was replaced with event_trigger_alloc without updating
> the corresponding deallocation calls.
> 

Hmm, it seems more complicated problems are there. e.g. in `remove = true`
case, since the trigger_data is not initialized (no event_trigger_init()),
the `trigger_data->ref` is 0. Thus, ;

static void
event_trigger_free(struct event_trigger_data *data)
{
	if (WARN_ON_ONCE(data->ref <= 0))
		return;

	data->ref--;
	if (!data->ref)
		trigger_data_free(data);
}

this will never call `trigger_data_free(data)`. 

But latter part(after out_free) seems correct.

Tom, could you check it?

Thank you,

> Fixes: e1f187d09e11 ("tracing: Have existing event_command.parse() implementations use helpers")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---
>  kernel/trace/trace_events_trigger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
> index d45448947094..8389314b8c2d 100644
> --- a/kernel/trace/trace_events_trigger.c
> +++ b/kernel/trace/trace_events_trigger.c
> @@ -995,7 +995,7 @@ event_trigger_parse(struct event_command *cmd_ops,
>  
>  	if (remove) {
>  		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
> -		kfree(trigger_data);
> +		event_trigger_free(trigger_data);
>  		ret = 0;
>  		goto out;
>  	}
> @@ -1022,7 +1022,7 @@ event_trigger_parse(struct event_command *cmd_ops,
>  
>   out_free:
>  	event_trigger_reset_filter(cmd_ops, trigger_data);
> -	kfree(trigger_data);
> +	event_trigger_free(trigger_data);
>  	goto out;
>  }
>  
> -- 
> 2.39.5 (Apple Git-154)
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
