Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09892063FD;
	Wed, 19 Mar 2025 12:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742386742; cv=none; b=oEGmxxWp7sIlXXQGSp5dmrk6xjUgdp2x3tADBddPHrJHFe5IuDmq8t8UqOfvga+79CQ+MosAHvO2k60dSXuvLZHSctXGg1RWcPvRkXyEuG2RIa0N3QA86BaTVw5JCMysHvxYBstKW471K6tDXPKSQnozBPQij2gvPAWPvOn36Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742386742; c=relaxed/simple;
	bh=jNNUx9ca2/ZhLS8cRJR2eUc4p4bV+bOteziGYAE80x4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=OREfUkMMhuLxdgaEFaXKzoVI1mGtX1iK8+hH/C9VYk0vKjg8kdnobYVLVnrvHjnc1SIyRY3mHtqEAVcCWbGmYZCNqdzOg+UY2bqIEYC3ybDcEUFm8yv+m/BZUDsA1MLaYbY9df8P2eiZAH1HJl5FQFDqtP7I/DuHJTSISLadoWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBIdGifu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KBIdGifu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 506DBC4CEEE;
	Wed, 19 Mar 2025 12:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742386742;
	bh=jNNUx9ca2/ZhLS8cRJR2eUc4p4bV+bOteziGYAE80x4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KBIdGifugnvdPgIU59FqNeB7xa4AJ0cuGvNMKSoRQPyYwgpsFwecgO1pHhQxPAx+c
	 qVvhz0Y0IKYyAY10vYac41olE8Jc0og59JgRLEGMEsYosmjuOYkaEclf9dqMVxwGmI
	 MQaodSdm4ESHYWJinQ2tWPnRw9VArjDeUT+upvza16cRcdFYCNZz1LpZVV8XKJlEM4
	 uL/WVQZRbF9KF9SdVbmp4Aoi8mnBy88XXGBBuNnGHGUm+XTuciH//FkPhQGOqE9C+P
	 d0//ixFnVwxBtMiVls8Oms1aruNaYRQENPjkZzPvLTQHFLzctfCGnXstCIQtyBd2Sr
	 9Fwk07wTS5SGw==
Date: Wed, 19 Mar 2025 21:18:58 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Douglas RAILLARD <douglas.raillard@arm.com>
Cc: rostedt@goodmis.org, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Fix synth event printk format for str fields
Message-Id: <20250319211858.6d8166e3fb202e6e5a658557@kernel.org>
In-Reply-To: <20250318180939.227696-1-douglas.raillard@arm.com>
References: <20250318180939.227696-1-douglas.raillard@arm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi,

On Tue, 18 Mar 2025 18:09:38 +0000
Douglas RAILLARD <douglas.raillard@arm.com> wrote:

> From: Douglas Raillard <douglas.raillard@arm.com>
> 
> The printk format for synth event uses "%.*s" to print string fields,
> but then only passes the pointer part as var arg.
> 
> Add the missing precision var arg.

I'm not sure what you want to. Would you mean showing the string length too?
But I think actual output(*) shows only string, right?

(*) the output data which can be read from `trace` file.

Thank you,

> 
> Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
> ---
>  kernel/trace/trace_events_synth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
> index e3f7d09e5512..274b9b1d9f7d 100644
> --- a/kernel/trace/trace_events_synth.c
> +++ b/kernel/trace/trace_events_synth.c
> @@ -620,7 +620,8 @@ static int __set_synth_event_print_fmt(struct synth_event *event,
>  		if (event->fields[i]->is_string &&
>  		    event->fields[i]->is_dynamic)
>  			pos += snprintf(buf + pos, LEN_OR_ZERO,
> -				", __get_str(%s)", event->fields[i]->name);
> +				", (int)__get_dynamic_array_len(%s), __get_str(%s)",
> +				event->fields[i]->name, event->fields[i]->name);
>  		else if (event->fields[i]->is_stack)
>  			pos += snprintf(buf + pos, LEN_OR_ZERO,
>  				", __get_stacktrace(%s)", event->fields[i]->name);
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
