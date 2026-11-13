Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794573741;
	b=fTcje9EyHF07nTlTkpiPElYzTUX8fmBByS3ABfwmhOdmgEu/GTSroXG/RBuhtSaSJVFN
	 +0axu0ck0mRZXyPyRhHCykWA+Xa16H34hMMTVJ0gdI+R6Ufl9LGF1An0vVtxFgNvnHbmI
	 Uybu6aeFuXi/KLuKOxHPPXv+CmzQ6HKHYVauts2xwZHZq6c7Tu5EmZI/kP5UNHrOFbplc
	 faAdVWxa5TKOrg+pqChtqgh94M955jJwfBWrPgvdCHXQrEzr0h9aq9RkD/tN6zuzlMKPa
	 h9zuK0eQ8VA9bTQIJZ6V1gKOONUUz4EcfHTpxV8UAtq86uFvBsYtNWGlpAv25H98m1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794573741;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=JLUI7FK8wijRXIgsxgkbmCRNaskdZBcmIaMMGBQKBFo=;
	b=fozSivSCHabCCwYjZ4QNMV8dE9wVdkC/t6Z/h7BaHBIwQXPiImag6MiER7P+tR3RVeiX
	 OS4roPtpgFbgYYy/J7Jt6TWjNMZ2C4IkY7g0PGKN8t6kDDQRDEPwTmFu0U0r8/Nya0BfH
	 YUUtUR/QdNg8S43OcR4instb6GoEUOBbgyhKnQxD0Zq5dSfa0nD79ttA7JBd58+OXd+uK
	 LesfOx9tPpUu5I1zTrEdrBCyh2ZZUFyfBTnW7oDVIbre0d0R1UCCOaioe8+nYy9MSqCaB
	 B2wy/1Z37JEobJYrb5whkOJdACMvgNfsBmpLZvZzL+CqvbiBHDotk62/4e0PWlN7DMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="V/ZRW2Sr";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WQ+iY6r2;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57805606A330
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 12:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57805606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=V/ZRW2Sr;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=WQ+iY6r2
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794573739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLUI7FK8wijRXIgsxgkbmCRNaskdZBcmIaMMGBQKBFo=;
	b=V/ZRW2Sr4yciOmhEqKh2Wr1h5IpHV6FzTfysv3zuhAiKC7kPk1PefBs1o2DQ2YDeODwZj9
	aZF/zHRVxSqCYPmd31yVdBQFe5i16+ugTLYUcgE0e/RPoPn8Q9S+yj9PQMMF9+nNDfvDV2
	VykiqWfFS4d8YgFJz2SggSaijvj4Kd/FhdZifmEAve+wUGDw2gKlC6VbVCjTJEZ2kAG3om
	v33l1FW0SAd/yxiasEqtGU/4GJdIK4FIiK1s3qwLqm3Pa56bO+gf/vaxffXIqdQ9GkojZ9
	j0JQbNVvozDe42uDins0Kck6bdnL9CQCamk+2kJNmP7D/sttPzrH5Gkcjn9sWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794573739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLUI7FK8wijRXIgsxgkbmCRNaskdZBcmIaMMGBQKBFo=;
	b=WQ+iY6r28A4zagAf1Bp6obxiNpjdBrGY788qf6Sl5OYqe2EAc4atdVr+LEWlWW+PLfudX9
	xV6IJg2PAUMEy+Cg==
To: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>,
 Tomas Glozar <tglozar@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 Daniel Wagner <wagi@monom.org>
Subject: Re: [PATCH] rtla/timerlat: Lock the memory of the user-space threads
In-Reply-To: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
References: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
Date: Fri, 13 Nov 2026 13:48:18 +0106
Message-ID: <87qzgox5qt.fsf@jogness.linutronix.de>
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

On 2026-11-12, Daniel Wagner <wagi@monom.org> wrote:
> diff --git a/tools/tracing/rtla/src/timerlat_u.c b/tools/tracing/rtla/src/timerlat_u.c
> index c80edaf07b00..42aaf1d7f216 100644
> --- a/tools/tracing/rtla/src/timerlat_u.c
> +++ b/tools/tracing/rtla/src/timerlat_u.c
> @@ -69,6 +70,15 @@ static int timerlat_u_main(int cpu, struct timerlat_u_params *params)
>  		}
>  	}
>  
> +	/*
> +	 * Keep the measuring process in memory: the latency it reports
> +	 * runs until it is back in user space, and a page fault on the way
> +	 * (its code, stack or libc pages reclaimed under memory pressure)
> +	 * would count as latency. cyclictest does the same with -m.
> +	 */
> +	if (mlockall(MCL_CURRENT | MCL_FUTURE))
> +		err_msg("Could not lock timerlat u memory: %s\n", strerror(errno));
> +

Page faulting should happen _before_ the task has a real-time
priority. Real-time priorities are for real-time workloads.

Just move this up 30 lines.

John Ogness
