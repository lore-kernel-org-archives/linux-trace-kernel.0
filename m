Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167CA19CCF5;
	Tue, 14 Oct 2025 07:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760427493; cv=none; b=XgkrpYms8mgcxyoz54ev6aHOPwilWbLiDJRf1xiwgg8H8Cxqvh3+mS/9De1zBnjjqr6yecBMnElFxs/2S6kDJoeh2NRqQxfpbBIQIgHvjJAoJCqaLLdLEKMJVjSK1bb9V6dtCazukyMnUd8jD0qIUugvK0gvsY8hsesVJ3x0wZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760427493; c=relaxed/simple;
	bh=F0Mg+J0+zm+OwAPhE0UDXX6rumwRUApt1Vs3DRAWGAc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oQ2dpT2R8JCIB0egP9w8XStRvD9TpVx5ZFYiUHTEJZnNZebQ6DVqL7mlCaPImPebKTyW98EkHR9ZoXl7bH/DujaJOfLP9s3OFwjDdRLI8HDgIjVIGYj0B6THcRiJ1XQugSmlZaX2VLFPc1v/+5WQWAl+2J832Dmd64sqfHqwA10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K3PerqZQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1V8kBdrw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K3PerqZQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1V8kBdrw"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760427489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlOr2XjRh8OrhPkU87HpnG9aCOMXMRKQHPmclFaJI0M=;
	b=K3PerqZQOi8faA900JvTgmL+8d3hUKhq0ZWfGo6/zZbgAkaYKJBYR+GYJu/EsnlZW/PUSv
	aPQLCUCa0dOT3+FTcglPkunoChFFaU7+R3ze7JVi0imLWFupkZg6T9lDogPpEB1P9P02Ej
	/NN/gwxtNbR9GyK1toSSlWLuTI8n7+GNKAMWJEeaoGi8165I3zjNuCQev1k6yCyUUez+ZK
	DShNjKTJ9FKc6cvae1d3nS6vD7sDJ+Opb0SALbrLBceFW4oH+34Pt/V5ritlDm5iNHymJB
	UBtwMWxUZXEhdp3hQFFqpt83HkZMsjTIPwob++XJrLF5ey3vVj15EIqSBLqK3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760427489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlOr2XjRh8OrhPkU87HpnG9aCOMXMRKQHPmclFaJI0M=;
	b=1V8kBdrw9+S+bqlTv1IfeHwokRxXSeMqKPhHmrkmObdYeM+45eCZtiIp3fV/5g/4VzTxUJ
	INXbV6ovgIb9NsDA==
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Steven Rostedt
 <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
In-Reply-To: <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
Date: Tue, 14 Oct 2025 09:38:09 +0200
Message-ID: <87qzv6szku.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de> writes:
> Reactors can be called from any context through tracepoints.
> When developing reactors care needs to be taken to only call APIs which
> are safe. As the tracepoints used during testing may not actually be
> called from restrictive contexts lockdep may not be helpful.
>
> Add explicit overrides to help lockdep find invalid code patterns.
>
> The usage of LD_WAIT_FREE will trigger lockdep warnings in the panic
> reactor. These are indeed valid warnings but they are out of scope for
> RV and will instead be fixed by the printk subsystem.
>
> Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
> ---
...
>  void rv_react(struct rv_monitor *monitor, const char *msg, ...)
>  {
> +	static DEFINE_WAIT_OVERRIDE_MAP(rv_react_map, LD_WAIT_FREE);
>  	va_list args;
>=20=20
>  	if (!rv_reacting_on() || !monitor->react)
> @@ -487,7 +489,9 @@ void rv_react(struct rv_monitor *monitor, const char =
*msg, ...)
>=20=20
>  	va_start(args, msg);
>=20=20
> +	lock_map_acquire_try(&rv_react_map);
>  	monitor->react(msg, args);
> +	lock_map_release(&rv_react_map);
>=20=20
>  	va_end(args);
>  }

The reactors are invoked in tracepoints' handlers, thus they must not
trigger another tracepoint, otherwise we may be stuck in an infinite loop.
(this is why preempt_enable_notrace() exists alongside preempt_enable()).

I'm not familiar with the internal lockdep. But I think these would
trigger trace_lock_acquire() and trace_lock_release().

Nam
