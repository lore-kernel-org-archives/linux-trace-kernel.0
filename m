Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04129ACF0;
	Tue, 30 Sep 2025 09:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759223643; cv=none; b=oaQFnjeDKTerradimbm5HZ2+fhnvsO0w9Nau4NdwsBKXUCegZSjJ360scsI0aetf99KnbM2PTE9HTwb9/Xl3kERA2d4IiIIpTU+a9Ttp63C/1cNtpbGQ3WtuNeFHqwwarAOMgGxnae/2H7Avq7Br8XC4bQRdO1EhxZgvQ/fOv9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759223643; c=relaxed/simple;
	bh=2AF9XmCmborZIjFa2MSxcTy1qyOu3e5IKKtUqbruAVY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FIOFXK6RJXf1ctq+BYE0Xo+DtE8E/eTVwGmO1JQ3ymPi2E5O2unzVeuN2KaeNMXdmGdhC1g5mQQq3NDO8EcPMtgt/8eXtsQ+OEBZWmakW6BRe6MShf8sdZsLIjYxfAZV0QCUiyNI8X1HGp2j5SjM1PvzAXkU8Ai2evt9jwGDUxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RwOFnm72; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZHI2I/ya; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RwOFnm72";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZHI2I/ya"
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759223636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//Nm6NvANAQn8ZCCRHsf+r3RS6FduiUteertKQI+Jg4=;
	b=RwOFnm72h8xT2eqA0X1mIjQZ6lm/9utrTjmxQxc7i1VdAnekjd4QtJFiBUmG9twiKzaXMt
	g+QTqha1FpFcv40mF2m2qMCy0GWGFam28VsB8XFQdhSoaMnsJUq6IBwhHOFuQdzCbp+uFF
	ej+cvnAdTHMKQqrSW3dfoCxvBr02Sf0lgXHnuLk2BdfLsxyfQdOVOLLUJW5ewXDwglwkU7
	7uANUTotWR/FZmuwQaNHLX8DhKJs/roWbFN46GDjAqVv5IN+Z1iezXIUTnulCIAlBnKfyw
	SYiRv0emT7hoaABrTLUdEe+5gHGpy1dGSiOhFC97/lJ3TAA+VPrqeMH2uRjwUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759223636;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=//Nm6NvANAQn8ZCCRHsf+r3RS6FduiUteertKQI+Jg4=;
	b=ZHI2I/yajMiYYGj1Puj5W+rvhPLxfenLhRk6oRbi24fJPlJdm7fVopqeF07xmSCswrjKXT
	anA8C66c8PylApCg==
To: chenyuan_fl@163.com, rostedt@goodmis.org, peterz@infradead.org
Cc: bigeasy@linutronix.de, chenyuan@kylinos.cn,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org
Subject: Re: [PATH v3] tracing: Fix race condition in kprobe initialization
 causing NULL pointer dereference
In-Reply-To: <20250930081848.433648-1-chenyuan_fl@163.com>
References: <84seg5d2p3.fsf@jogness.linutronix.de>
 <20250930081848.433648-1-chenyuan_fl@163.com>
Date: Tue, 30 Sep 2025 11:19:56 +0206
Message-ID: <843484l2uj.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-30, chenyuan_fl@163.com wrote:
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 842383fbc03b..98b838591edc 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -274,19 +274,19 @@ struct event_file_link {
>  static inline bool trace_probe_test_flag(struct trace_probe *tp,
>  					 unsigned int flag)
>  {
> -	return !!(tp->event->flags & flag);
> +	return !!(smp_load_acquire(&tp->event->flags) & flag);
>  }
>  
>  static inline void trace_probe_set_flag(struct trace_probe *tp,
>  					unsigned int flag)
>  {
> -	tp->event->flags |= flag;
> +	smp_store_release(&tp->event->flags, tp->event->flags | flag);
>  }
>  
>  static inline void trace_probe_clear_flag(struct trace_probe *tp,
>  					  unsigned int flag)
>  {
> -	tp->event->flags &= ~flag;
> +	smp_store_release(&tp->event->flags, tp->event->flags & ~flag);
>  }
>  
>  static inline bool trace_probe_is_enabled(struct trace_probe *tp)

I don't have any feedback about the correctness with regards to tracing
and kprobes. However, I recommend writing a comment at each necessary
memory barrier site. The comment should mention the pairing memory
barrier and the ordering it is guaranteeing.

John
