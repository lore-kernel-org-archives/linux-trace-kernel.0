Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793962598;
	b=ELf3J6UWwieIEd4zQvyl3gVCJrV7OY+ZCXcDM7HEBrl6/V5RJiaKJENUguxr3juI2IQ6
	 Z7vA/F91tPR3HkAAFfGW+lLI48vAy2tmFB4QJuD35W7M/iOSYHK667tm83nbuLCsV+BiU
	 HBcmMVG5LOPa+PCTbtt+EJ21p05r7AR3nRmzNGb1537jnhA8uoXKzWg0zbfY8bkMpPvfp
	 FrKKsvhKC9Xqk+cUygjLvvZ1q4x2zsJDqayzk8MYThszZGOq1slEA6uAQA9FxHUfMqG+4
	 bktyakroHmX+B2BOrPT8tbl1Xp6uaNBxLaIulLvzC1gfbDTW6KHwLX13XEMrfVxQJWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793962598;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=s305hO0KBJvRejl6sk7LGLBwvV1+IeHzGIvNdvCCKQQ=;
	b=fgBF68yHm1N/TjtsaKawyKgivbYQgi6ZkT1jaS1+Ny5BIbNwmVkrAsphRipMlTDTRz/x
	 yhYfcDfcOwKKan+/5TApDtV+eY0fhIZseZnFLl+aIcZMFzj8i0bCf3paSLM6AcRzKGBdD
	 pC5TiDQzzTJOgbMVdrjfdV7EoJH0GGcB2bSq2DIYVPjBiKQgm1utnlnw2mJnCdydxKT74
	 krf+LmH3ekXE7y9wu4J58U03OqzxW2m5GBzHVtRoh06HpvKr8ceji4DGxZT6qTg6v10C5
	 uUZtsnoj5NmKLjyxCzgRTXDmZfQ9G/I/65lhYx4ff2geTgUehk64GX+dP6U6kQi+TTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBx3XHeR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745FB606D821;
	Fri,  6 Nov 2026 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nBx3XHeR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5AE1F008A3;
	Fri,  6 Nov 2026 10:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793962597;
	bh=s305hO0KBJvRejl6sk7LGLBwvV1+IeHzGIvNdvCCKQQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nBx3XHeRpG02ZYLI5Kq6Z2IkTRZdupflkupfUCQw60EO21PjXL898vGLNJLTlUnY2
	 AjyukYUeTArOo/Hptg4i1zB5X0Kp6KIuy4h7Y5dTB3yJs9d4I8DFvdvXzXZV/NqiyR
	 iPtimM+vYWnxxN/nhcid9RTcw3NT4tPrUq3jY132LLzqVr21Wvd2sMcyKMyLT+eyFy
	 nla4CA7pXjUc3AJ1WXHDyl4tOaQ9jXZB0CB2G8VmuETqQZW0dv2ZQo+8OX7MSSPgQw
	 RAHXLyyfEwf8J5RVovhmJooUJyXHmWOir8M59r7xnVzWnaWF2pzRF6Zn24Fs9cjAm2
	 8F2YjafthJ4Lw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/eprobe: Install the trigger for every instance that enables the eprobe
Date: Fri, 06 Nov 2026 19:56:31 +0900
Message-ID: <undine-1793962591672170762-c497b3f31197b188@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261031203915.491866-1-devnexen@gmail.com>
References: <20261031203915.491866-1-devnexen@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Sat, 31 Oct 2026 20:39:15 +0000, David Carlier <devnexen@gmail.com> wrote:

> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -661,20 +661,20 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
>  
> +	/* The trigger lives in the instance of the file, add it for each file */
> +	if (!file && enabled)

Hmm, when reviewing this patch, I found file should not be NULL
because enable/disable_trace_eprobe() are only ever called via
eprobe_register() with `TRACE_REG_REGISTER/UNREGISTER` where `file` is
always non-NULL.

So we should expect !file case is a bug. So at the entry of these functions
we can add:

	if (WARN_ON_ONCE(!file))
		return -EINVAL;

and remove !file blocks.

Thanks!

>  		return 0;
>  
>  	for_each_trace_eprobe_tp(ep, tp) {

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
