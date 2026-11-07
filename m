Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794063726;
	b=i9O0AJkGBERIrgIe/nBGqXm1u6s8rMNl00+zl3h24GCoyhcFa7mivhfsYQbmQqeQkOnZ
	 y6XEKNuGc/kRQToPV7oHnT8RjYsuVKy3uFD5hkur00acpzScdc/ShwKIF04BlD+Z0ong1
	 UlJybZsH1F6SvrYwbbxsVVeM4XQF7KjJh2heWS1Zwye1at9Ora6bW+B8hPMvzl/MqLu+m
	 tVUJk7ONAJDkKHEvWC/FRNwn+2T+80fXCLgNNlNQyGshj1fA+w9xdaVHo/ncpE5dDx6cH
	 laO0u/JmN+0o7iJYfxyrXGdpy9PdocY2lch1LkCeFjm/VyQInRmLZnqjA7yk2fRFuig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794063726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=a50E+Fvt5ASjF0FfSCQEj9LG/9E42rR75fXOcgNtSxw=;
	b=l4fNXc+BpcZhh6v682saeb8QIzG5ejspmHC+aqrPcG0GG62wzTVxaq7jQZMV53fC9m4K
	 +WsHaMIrrWBDqT43DILYSCPbWgofAzrGMHlummcMAoE9pzmh8Vl6b3pVvzRaCjpOz0kqj
	 YTd0Kc8OiowwoOkOkSEiNcoADf+s/Kt+k9E16b6zgSSwrY71SKItVHoBAKw8ReGoTauX/
	 X36btajY9mzI9WZtBW7BvSxsXHioPJMTGFBXwa2ejaAJfLgiPhFtoPIy4AkadP8HA056f
	 T+DgWlGrS1Kp8tC6ml3TUhQm7p9ufYdyMOcm4QH6D3KmyAfyzA4HaoW2eXGSB5S4IEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llmhYPjJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960F2606EEB8;
	Sat,  7 Nov 2026 15:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=llmhYPjJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 757AD1F0089F;
	Sat,  7 Nov 2026 15:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794063726;
	bh=a50E+Fvt5ASjF0FfSCQEj9LG/9E42rR75fXOcgNtSxw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=llmhYPjJ+GzdXZ1bL7Nl745ZrzsRXxPb0DE5cyaSLnBRGP79EDsK0AL/r7Z8sodX2
	 nTkqUXU8vDQpwhquOsINibjO7/fTbn6heypOnhr6IPcVmZhHw0dgfMzpQKbZEpbFta
	 VyoliSHukwm3DuRMQSIoaxIGxh4WH4aA4WU/FaoyJ4he/BEmaOAnJQuqCec1THqF7z
	 PIsRiGfyzP0MTJhlvr/wqJudoZe76EnctUNTTe9poffsfeO4R36DJSLtSH72rfttFs
	 Z318ZbvKa2YToR25bRzdvSQRxLcuCI8pbRvwgpHuZoCog7+jzcGlYnLPqggY5raCn2
	 EN62C1k4X+VVA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/eprobe: Install the trigger for every instance that enables the eprobe
Date: Sun, 08 Nov 2026 00:02:04 +0900
Message-ID: <undine-1794063724002256344-706ebdac8e2df825@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261107101233.151434-1-devnexen@gmail.com>
References: <20261107101233.151434-1-devnexen@gmail.com>
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

On Sat,  7 Nov 2026 10:12:32 +0000, David Carlier <devnexen@gmail.com> wrote:
> The eprobe trigger lives in the instance of the enabling file, but it is
> only added when the eprobe is first enabled and only removed when the
> last file goes away. A second instance then records nothing, and the
> first instance's trigger is left behind once the eprobe is disabled
> there, so the eprobe can be deleted while that trigger still uses it.
>
> Add and remove the trigger for each file. The file is never NULL here,
> so warn if it is and drop the dead perf paths.
>
> Fixes: 7491e2c44278 ("tracing: Add a probe that attaches to trace events")
> Cc: stable@vger.kernel.org
>
> Signed-off-by: David Carlier <devnexen@gmail.com>

This looks good to me. let me pick it.

Thanks,

> ---
> Changes in v2:
> - WARN and return -EINVAL on a NULL file, drop the dead !file paths (Masami)
> - v1: https://lore.kernel.org/linux-trace-kernel/20261031203915.491866-1-devnexen@gmail.com/
>
>  kernel/trace/trace_eprobe.c | 56 ++++++++++++-------------------------
>  1 file changed, 18 insertions(+), 38 deletions(-)
>
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 998e6390937a..474be2f5ccd9 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -644,37 +644,32 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  {
>  	struct trace_probe *tp;
>  	struct trace_eprobe *ep;
> -	bool enabled;
>  	int ret = 0;
>  	int cnt = 0;
>  
> +	if (WARN_ON_ONCE(!file))
> +		return -EINVAL;
> +
>  	tp = trace_probe_primary_from_call(call);
>  	if (WARN_ON_ONCE(!tp))
>  		return -ENODEV;
> -	enabled = trace_probe_is_enabled(tp);
>  
>  	/* This also changes "enabled" state */
> -	if (file) {
> -		ret = trace_probe_add_file(tp, file);
> -		if (ret)
> -			return ret;
> -	} else
> -		trace_probe_set_flag(tp, TP_FLAG_PROFILE);
> -
> -	if (enabled)
> -		return 0;
> +	ret = trace_probe_add_file(tp, file);
> +	if (ret)
> +		return ret;
>  
> +	/* The trigger lives in the instance of the file, add it for each file */
>  	for_each_trace_eprobe_tp(ep, tp) {
>  		ret = enable_eprobe(ep, file);
>  		if (ret)
>  			break;
> -		enabled = true;
>  		cnt++;
>  	}
>  
>  	if (ret) {
>  		/* Failed to enable one of them. Roll back all */
> -		if (enabled) {
> +		if (cnt) {
>  			/*
>  			 * It's a bug if one failed for something other than memory
>  			 * not being available but another eprobe succeeded.
> @@ -687,10 +682,7 @@ static int enable_trace_eprobe(struct trace_event_call *call,
>  					break;
>  			}
>  		}
> -		if (file)
> -			trace_probe_remove_file(tp, file);
> -		else
> -			trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
> +		trace_probe_remove_file(tp, file);
>  	}
>  
>  	return ret;
> @@ -702,33 +694,21 @@ static int disable_trace_eprobe(struct trace_event_call *call,
>  	struct trace_probe *tp;
>  	struct trace_eprobe *ep;
>  
> +	if (WARN_ON_ONCE(!file))
> +		return -EINVAL;
> +
>  	tp = trace_probe_primary_from_call(call);
>  	if (WARN_ON_ONCE(!tp))
>  		return -ENODEV;
>  
> -	if (file) {
> -		if (!trace_probe_get_file_link(tp, file))
> -			return -ENOENT;
> -		if (!trace_probe_has_single_file(tp))
> -			goto out;
> -		trace_probe_clear_flag(tp, TP_FLAG_TRACE);
> -	} else
> -		trace_probe_clear_flag(tp, TP_FLAG_PROFILE);
> +	if (!trace_probe_get_file_link(tp, file))
> +		return -ENOENT;
>  
> -	if (!trace_probe_is_enabled(tp)) {
> -		for_each_trace_eprobe_tp(ep, tp)
> -			disable_eprobe(ep, file->tr);
> -	}
> +	for_each_trace_eprobe_tp(ep, tp)
> +		disable_eprobe(ep, file->tr);
>  
> - out:
> -	if (file)
> -		/*
> -		 * Synchronization is done in below function. For perf event,
> -		 * file == NULL and perf_trace_event_unreg() calls
> -		 * tracepoint_synchronize_unregister() to ensure synchronize
> -		 * event. We don't need to care about it.
> -		 */
> -		trace_probe_remove_file(tp, file);
> +	/* Synchronization is done in below function. */
> +	trace_probe_remove_file(tp, file);
>  
>  	return 0;
>  }
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
