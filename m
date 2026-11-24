Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795536871;
	b=qiWOHiCPWXgQw5fvLC+5Mg5LQLiKGvd9S9YdkIxWwzsbI9oHuiRL6/gU3q+gADz4T1wb
	 dFeM2PtfldraibqcOIY6nze5GSkvynFz2B69i2mmwn/qvdkx0J/T+HOlnJ0M1aOHnDv4s
	 OBugkZw48DiegAbLaBHxZ/i2uXFNF51I9hQ2JLHm0isUSDHA6EPug4PTF7wLKMaZtFBRE
	 IA6lhcq/k5bg9JqLKK2Ys2ZzYPS2lmgun22ep0bgEck2mFhxz8j36qlouDoyHh/vPBlmD
	 WC5ofHGZF1QDuva4hivu87sc94x4Bs1xsT9UAiah39RV0szIFBubWHnceQuvsxJ3N8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795536871;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=xpJrJ/aj4rovQZsntfqxAg1AVJd2kg647AlEgjHHWsY=;
	b=qH74NioCgCwsPKZIiZ/ouHfZiWvyHmFed4fDGlyycbgjz5iFgUN8qdhAhtRvM3qb0L+6
	 GDQ9ROgWjmqAG0WhjJlXQh/DWo0VAkkIgIAtP66sD7xGMABm1doeLOP8h0H2VDBPc90pW
	 OTOMGyJTlxptUH9Al0WUoCOsjbHbIBj/KP72AmdL/uTYXcQto8eX/aJIe2JAGM6Rtauvy
	 Ju3qwJ4fLuS0BrrsX0pxmTizUno8LzgZYB9bo2KVswC/22IcAO2THXsMC1cE3Q3f/e9kj
	 yAeH6V1llpuiU255ITYdGGyagl5KyFFBJUiWXw0XksPSrJbdNsX4OXg7Jq3P+Gnw2kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=AX+SJDPx;
	arc=none smtp.remote-ip=216.40.44.16
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB5606A329;
	Tue, 24 Nov 2026 16:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52FB5606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=AX+SJDPx
Received: from omf03.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id A1243C07C0;
	Tue, 24 Nov 2026 16:14:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id A1A6C6000D;
	Tue, 24 Nov 2026 16:14:26 +0000 (UTC)
Date: Tue, 24 Nov 2026 11:14:25 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, Song Liu <song@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: Keep preemption disabled until the recursion
 bit is cleared
Message-ID: <20261124111425.487a2ec8@gandalf.local.home>
In-Reply-To: <20261113011333.20813-1-kmehltretter@gmail.com>
References: <20261113011333.20813-1-kmehltretter@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: A1A6C6000D
X-Stat-Signature: wgpirjrdtoguppwk65gb17y81kqxpcu9
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18h3o0V+j73p7zeCPDRwnEuIWK057HZwTs=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=xpJrJ/aj4rovQZsntfqxAg1AVJd2kg647AlEgjHHWsY=; b=AX+SJDPxDOVjWGcDZzIv66gzSJqmaW5nM17jjI10SGQ9EYdwdc2F4bVtYdl0LZpLchYQhTSaoIuubLvGQfD5of4yB5jTDvEuYoRBRCgwKBT7E+RTYf9Ym2T8az+wESNfxtSbOQDJoLjIhr6G6tYo5YBWg+v+Ty3OdCU17CrRu3E=
X-HE-Tag: 1795536866-202913
X-HE-Meta: U2FsdGVkX1/sKKD/8PuaEW7vJEhYuHEvAHXxgsNVKpgh5IlVfPS7VZ/KrMj+smvgwXlbKb0dV8tqcHAQ6IYMOM0CvFKypaJu6MpMM0tRQV1x7WCgUXna8wSpjjQtkaCn2wJD/oMmTjzWGb+WqkdGqs01h+p7hLWTNlDQdO3fysfiKRpSIkGEvTBI8ZgjXFysMfUnnpeZHh/d42+kFKWqxWyGy/PS9puCL7xch3giaxgSf2pp25o6sQunXHClkRRYNl9uosygsG486UHEDI64HnrvKoZlm9f5ZtayH2gOOoFpITW2+IKDhFO3LjeYWFUfISnsXmTnWI9izFn/oi4GtEBHNkgNakMJ

On Fri, 13 Nov 2026 02:13:33 +0100
Karl Mehltretter <kmehltretter@gmail.com> wrote:

> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
> index e6ca052b2a85a..a7c66313bf360 100644
> --- a/include/linux/trace_recursion.h
> +++ b/include/linux/trace_recursion.h
> @@ -132,6 +132,8 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
>  	if (trace_warn_on_no_rcu(ip))
>  		return -1;
>  
> +	preempt_disable_notrace();
> +
>  	bit = trace_get_context_bit() + start;
>  	if (unlikely(val & (1 << bit))) {
>  		/*
> @@ -145,6 +147,7 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
>  		bit = TRACE_CTX_TRANSITION + start;
>  		if (val & (1 << bit)) {
>  			do_ftrace_record_recursion(ip, pip);
> +			preempt_enable_notrace();
>  			return -1;

Honestly, the reason I did it this way was because if for some reason
something in preempt_disable_notrace() was traced, this would catch it.

I guess we could change it to do it this way, but if something were to be
traced in preempt_disable_notrace() it would triple fault and reboot the
machine with no warning. :-/

-- Steve


>  		}
>  	}
> @@ -153,8 +156,6 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
>  	current->trace_recursion = val;
>  	barrier();
>  
> -	preempt_disable_notrace();
> -
>  	return bit;
>  }
>  
> @@ -163,9 +164,9 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
>   */
>  static __always_inline void trace_clear_recursion(int bit)
>  {
> -	preempt_enable_notrace();
>  	barrier();
>  	trace_recursion_clear(bit);
> +	preempt_enable_notrace();
>  }
>  
>  /**
> base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
