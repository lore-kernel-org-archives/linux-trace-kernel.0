Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CB23B47CC;
	Thu, 28 May 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779959401; cv=none; b=tcfuQS2TxcBKb9JNvU5GOwnV4F9qDiU13cRz86c1uj3cEAyoDhh4iil3S9HqifjitUEU3DyWKLx434a6SKxvYtOyWJDlApY5zaWRvBKGJ9OI6yaD9M+JMTDdq38ulXyL9c2yEUVddKHJXaQdQ6w3EZ7Rtd3+qVhORWdFOvA0SK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779959401; c=relaxed/simple;
	bh=4+L9nZaaCoyr39MqT9xEQzSUUL9mlktVwFkhLnstnGo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jFwVXP06I0r9Y1HzmkpYLDDYhkfl5GzFn4cOCTDAh4h0Wqbo/bah1sR9OWKwb7N8d0L1qeNWE3EWVS1e5nAXAesEcFaiVsMBipFOrIMBKyWY1WT67T9yZQh+vQ9xiVCTkQn82tQ1I020Zkl44yEV/hEzIzdnNInxqQmBdfpPUDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gwlGZDJr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pVQsxdyx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gwlGZDJr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pVQsxdyx"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1779959395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ulZS8t4qLWvRYoR2PyeK1rsOcnPm9qR9ixxjaTeQmw=;
	b=gwlGZDJrbZGW/c3q9AM85Hv3NLJyGMhGGfnHaJ8B7XLNpO7S7jfJAHfpEdRR2FaLOGFDSQ
	kXywlt8DnW0gIho457pJIyNWQbuDqcEvkQvz/dKcuBv+6+Yn/EF2Pns/1NsnkPx3IoCgrI
	tNocfkhcje/TehOsYVJgpARj4oJpw9+8Fxp2bu+bem0HxdjO9rUGBd1FkZa7nvADDtMeIM
	OaO9tW1YY6YskusbVEEBXjeJU4lnlzcvmR7zOdG1lwXJo4P+G3C5zW5kDCKvYNTHoioXTU
	NSSaNDfJQzYVSFZuC5NYEBQ3BAuv8wxDf5PPZuy8yTE7xUXaCDFEDNSBkZd4PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1779959395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0ulZS8t4qLWvRYoR2PyeK1rsOcnPm9qR9ixxjaTeQmw=;
	b=pVQsxdyxNke/mwgYeSWgqrqr/dmJaF9QlzA9YrV87ODTsaqpuZ65BTLrd71wY7H/Ix2J/4
	ylX8eQEUe0bl1XCg==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
Cc: Wen Yang <wen.yang@linux.dev>
Subject: Re: [PATCH v2 07/12] rv: Fix monitor start ordering and memory
 ordering for monitoring flag
In-Reply-To: <20260527062313.39908-8-gmonaco@redhat.com>
References: <20260527062313.39908-1-gmonaco@redhat.com>
 <20260527062313.39908-8-gmonaco@redhat.com>
Date: Thu, 28 May 2026 11:09:55 +0200
Message-ID: <877bonoq70.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> From: Wen Yang <wen.yang@linux.dev>
>
> da_monitor_start() set monitoring=1 before calling da_monitor_init_hook(),
> may racing with the sched_switch handler:
>
>   da_monitor_start()               sched_switch handler
>   -------------------------        ---------------------------------
>   da_mon->monitoring = 1;
>                                    if (da_monitoring(da_mon))  /* true  */
>                                        ha_start_timer_ns(...);
>                                        /* hrtimer->base == NULL, crash */
>   da_monitor_init_hook(da_mon);
>   /* hrtimer_setup() sets base */
>
> Fix the ordering and pair with release/acquire semantics:
>
>   da_monitor_init_hook(da_mon);
>   smp_store_release(&da_mon->monitoring, 1);    /* da_monitor_start()  */
>   return smp_load_acquire(&da_mon->monitoring); /* da_monitoring()     */
>
> On ARM64 a plain STR + LDR does not form a release-acquire pair, so
> the load can observe monitoring=1 while hrtimer->base is still NULL.
> The plain accesses are also data races under KCSAN.
>
> Use WRITE_ONCE for the monitoring=0 store in da_monitor_reset() to
> cover the reset path.
>
> Fixes: 792575348ff7 ("rv/include: Add deterministic automata monitor definition via C macros")
> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

Looks correct to me.
Reviewed-by: Nam Cao <namcao@linutronix.de>

Wen, I am curious, how did you find this issue?

Nam
