Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794581790;
	b=t7e8ZATj135yn2pyKAt9dFD9eV2pviWcELZC9mdfmAse44G8UEVb+Fj+cGzPqGIyziiD
	 8JwxIzv84DIG1skv9SyIRvWBfV53zhs5pc6SlzG7hy/AT5/+c/AaPxR9ORq5HUihnApcl
	 N0OCCjSTR1xGI9sg4ja4VXckpoUervuPqUrisnYNhe0DdkPZqbzuI6xwmeRx5wUBKrNij
	 pIiyqmlu9UmmEGoK+5v9TwN82+uzch0wz2Tf32dX8shxoPyajlkQQkoRHPzzIX76zVR8g
	 ICyB7QeQReF0e7PXLzUxS3WxUL9mpUnQQmm+C1a8Py1UpVVMHPYSNpQ5ZKOJ1jNNrqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794581790;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=djMQ9Rq5O2IwlxIxPHVCe+0cQ6bgchm1ltqKDGJGPWA=;
	b=oXbJzCZKJx9m0mfsuv+Qp3/QfzjYu56IMCEQiqHKAgKvwlTjNYUaY2WncKAooVKk0Nfy
	 0jhoAISr5T41qBxVumqsDSfjK82y4od1qANgYJG9P2Yf9hGrRsQqsPAz0Ca85fmWfkoAE
	 DoOYb2Tv8rNmDBvbSO4NYqYHFcBdVXJp3wmUE/UC50qUzwCInJE8qEnVCf7uGBoPaUyHL
	 OMN30EoZoBuD+50RRFzcglYWRG0cI5RUswpJigLrV2Wnb3vpV6K/13heX+vRy2cgPsz0m
	 yAvGiDRuZ0grDBscp3KNW9mCHyFGM5M+27vRxq9wJ5gCLTH8QH/Z2wAtKXtdrXUXQuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OfSh6y5X;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VPzeeLFP;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32449606A32D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 14:56:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32449606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=OfSh6y5X;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VPzeeLFP
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794581787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djMQ9Rq5O2IwlxIxPHVCe+0cQ6bgchm1ltqKDGJGPWA=;
	b=OfSh6y5XzvXKLPTJeaMP0FyKaS9E2vtYZLt5MnIeAbTMsmKCdFh9DS2BTPZyU9Kz06yJd0
	Bs1b1wNcHTOI8vys+pfMetmYmvw0GtivY/t+ddUW9TeFmNRceYfuGURlxwH9twefBrMN/7
	UzcihZ3IRhWVXK7/auuXatE0LIQ1WTuDqeQhx3ZOmo76hXxZ+/clN+4OzOmCJuIKGF1wwp
	c7miIvWZ0oBqfN1GbF7/0JCbl1I+DOOStKblQj67SnpIC7bPicidI0lOmrPTmAxkio+E/R
	38HczTTa4FZF6woRp4qnQ2jzLgFIY4tCHXtdbQXnudWgA2idin4UxZxypXGf+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794581787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=djMQ9Rq5O2IwlxIxPHVCe+0cQ6bgchm1ltqKDGJGPWA=;
	b=VPzeeLFP7y6FGPj3vf4/kARuHJXyXcVpgKHn09dDFHlkCQ16d8vPzQhLvMLIxPHQNWb4SC
	VrinhYJOuW94bKAQ==
To: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>,
 Tomas Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH v2] rtla/timerlat: Lock the memory of the user-space
 threads
In-Reply-To: <20261113-rtla-mlock-v2-1-14382f140da0@monom.org>
References: <20261113-rtla-mlock-v2-1-14382f140da0@monom.org>
Date: Fri, 13 Nov 2026 16:02:26 +0106
Message-ID: <87o6bswzj9.fsf@jogness.linutronix.de>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Hi Daniel,

On 2026-11-13, Daniel Wagner <wagi@monom.org> wrote:
> diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
> index c80edaf07b00..5e7a23fb9fc3 100644
> --- a/tools/tracing/rtla/src/timerlat_u.c
> +++ b/tools/tracing/rtla/src/timerlat_u.c
> @@ -37,6 +38,13 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
>  	cpu_set_t set;
>  	int retval;
>  
> +	/*
> +	 * Fault in and lock all memory before switching to a real-time
> +	 * priority, so that page faults don't show up as latency.
> +	 */

It isn't because the page faults show up as latencies. It is because
doing non-real-time work with a real-time priority is stealing the CPU
away from other real-time tasks that presumably have actual real-time
work to do.

This program peforms severeal non-real-time activities with the
real-time priority, which is not setting a good example. But I am only
reviewing your patch, not the full source.

John
