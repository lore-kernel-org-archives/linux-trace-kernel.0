Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063407;
	b=3C02ekjgAAh4U367OLT1jyxQQADcL2vWkN0coH27qYh7LkMuyavqStvyPj3YEaOl8zxf
	 0b/uOpLORxTW1zsg3smjsdV9hNrRc/jq8FTo27Q+9DTttP9dCc20EFjT5ip/gt0Qkszmd
	 IyKDjVaosMNj/bOi0PRUKZXHyq5072/rEOUe349d0BJvJRu0+EjQ/dv4CPPmeo/yNlUKP
	 mZ3YGNK91nzclC8AE+95mKzHpQqybiyAcfoVH9Cnc2erwDHg3upLJnyJXCsKVpsbgw88r
	 ZfCWji7sMq7xPl7CLgke7zExvaKBPycFQI9SbE6hU8E40h3pYnaQJMj90/VDsvmBMeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063407;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zWydiZHIyWvc6/MWXFpYPpNynTNHAYYiaP3ylt1+2Sc=;
	b=CPitLePBwYbQVMpukVaLXwdN6hsn/TR4nUER7fydNStI4mLChVtGYwoyrjSQM0C8Lg77
	 Jj/QRSgWKmMKR73sZr4xY6Cc5N2e9Y+Z+avlaVKRsk6wkkfciHOwA+noOaN/wlf9EK+QD
	 TEhl81Qf3ApTOi5fAxqKCDZzTJbclgRv+piUeSD9HOBBqDNKjhavs+3pCJImY7UAhcZmV
	 LGKBTumgW+5I2/dS3sX8D80gblZfODF2sOf8/UgUXQvrU0JoS6qzKCTs53tY0o/6yG2VZ
	 ZllPo7G0wXYR1wXrGP0n3qFHj0lqgNky95KvNvfg3+lDQIr5TQLfmnKtJDpq5JqpfDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owcdwXXy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F40D606D832;
	Sat,  7 Nov 2026 14:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=owcdwXXy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 265D41F0089F;
	Sat,  7 Nov 2026 14:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063407;
	bh=zWydiZHIyWvc6/MWXFpYPpNynTNHAYYiaP3ylt1+2Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=owcdwXXyyadB06qmWfPfF2FjPrETAXvqfONmdIhIu9sGSMXt8UM6jjUrz5c8XLI/S
	 UUeFjqLPxXHHPJoW/0nj51CPMMPHZDm/fwyG5Ng0TLvgAExTIo5/rnDAXQc1kSyjLv
	 ophM07zWgP3nXNHmju2CzHTKA5mI0htDVl9nGhxTp6LdPRCTSQ+a0FPWBTdINsOyXb
	 fgQNAC7N3mAyP8CPN+qwbyEoJKlCCjmWRkDYdPgpg2YtM+PgvYqUsn3Ig5/FOEgMs7
	 M/0kn/tly3b4NmkU5MX4xX3sN2itkRWgJR54cJkP7aUuArEz9xU6CO1OjC8ndN+SVx
	 SrbwA+/qIk/lQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Pengfei Li <ljdlns1987@gmail.com>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, zhangbo56@xiaomi.com
Subject: Re: [PATCH] tracing: Wait for marker writers when copy_trace_marker is cleared
Date: Sat, 07 Nov 2026 23:56:44 +0900
Message-ID: <undine-1794063404423071775-c4525958cf021399@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261107110722.1241413-1-lipengfei28@xiaomi.com>
References: <20261107110722.1241413-1-lipengfei28@xiaomi.com>
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

On Sat,  7 Nov 2026 19:07:22 +0800, Pengfei Li <ljdlns1987@gmail.com> wrote:
> Clearing copy_trace_marker removes the instance from marker_copies
> without waiting for trace_marker writers still walking the list. If the
> option is set again right away, a writer on that entry can revisit
> instances and write the same marker twice.
> 
> Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
> Assisted-by: LLM
> Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thanks,

> ---
>  kernel/trace/trace.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 18710c190c92..b0357f1b5a69 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -4016,7 +4016,9 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
>  		break;
>  
>  	case TRACE_ITER(COPY_MARKER):
> -		update_marker_trace(tr, enabled);
> +		/* Writers of the top level trace_marker may still be on this instance */
> +		if (update_marker_trace(tr, enabled) && !enabled)
> +			synchronize_rcu();
>  		/* update_marker_trace updates the tr->trace_flags */
>  		return 0;
>  	}
> 
> base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
> -- 
> 2.34.1
> 
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
