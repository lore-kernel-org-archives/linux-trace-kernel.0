Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFF320DD51;
	Thu, 18 Dec 2025 05:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766037490; cv=none; b=GpAnZU/EExLVToP+6zKA2rXn3E2QZIzzC4aP/cx9c7ysE1YRplVVffU1AL7g8wuKrzZSOpSzq2wknySRuYcepGL3TlEjrQI5eKNyMZMZ84Y+VBfNjJPt095j5OfKK1h79u0YB9dYtK6aprS2ol3H0oWEF/Almog3z8EE2oOmZDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766037490; c=relaxed/simple;
	bh=W0fRZkFmokF6FkmAT6hOK2YcfrTJCvaVwwyD8QuXot0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K1rZJz7PEe1wtdqj6zVSBYplg1TOq3J8YRcSQH6npsEbpidYlOi/OJ08mDJ4/B1vBsW5n+YBcguFzFvv3689rNYuLwyRebI8zRhXzVbVbwypqIRll6/VLXLoCJjkyWoV6h06dVzXN5y/p/AQ0dhnExLmMJpKq8EeF/0IoDGGRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PXAs2jl9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AbFY61ph; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PXAs2jl9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AbFY61ph"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1766037486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OtU9hUO8RRxjtCf857nU0HGOviXtYmeinipt3SOOs70=;
	b=PXAs2jl9HmncWU43z+Veaepe0RYC+1hOWpCLj/32wwLh6VtsjCbsVeGBGYVtbocw7oreQq
	15G64Df3lwJ7zE1mPpo+0xCOUT88Tx50Spu8D8ZPag8fLyP7TqO1xgG8mESmv/zdDej6k9
	ZIJBQp0fWChXuoIFP82Vr1cO4fj0KKip7ftgsSggjR3f6sMKKUZWO7kIXa1KqSDxLGtOiL
	wkp2eeChssaUwmMhGqX1rGIDs9fuQYdxFkqAmAKeD/ZNkGCCrxLz3UeDcUOz/GOg85Q39q
	HZtJixDFtAcGXUZkhW2rvGIN7RUDYzjybkAtu0dsTzM4Yw7u9sVQHrGewxCWaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1766037486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OtU9hUO8RRxjtCf857nU0HGOviXtYmeinipt3SOOs70=;
	b=AbFY61ph4iV7ZGAS62mRrWxR+D8HU0Q7o6pmyl33DYQba4vozNpKTd1rqr8LV3CxYuEga9
	XezUfu2GsVkEdKCw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 02/13] rv: Add Hybrid Automata monitor type
In-Reply-To: <20251205131621.135513-3-gmonaco@redhat.com>
References: <20251205131621.135513-1-gmonaco@redhat.com>
 <20251205131621.135513-3-gmonaco@redhat.com>
Date: Thu, 18 Dec 2025 12:57:55 +0700
Message-ID: <87y0n0ib6k.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +static inline void ha_start_timer_ns(struct ha_monitor *ha_mon, enum envs env,
> +				     u64 expire, u64 time_ns)
> +{
> +	u64 passed = ha_invariant_passed_ns(ha_mon, env, expire, time_ns);
> +
> +	ha_start_timer_jiffy(ha_mon, ENV_MAX_STORED,
> +			     nsecs_to_jiffies(expire - passed) + 1, time_ns);

What is the +1 for? I guess to prevent it being rounded down to zero? If
so, maybe we should do

     nsecs_to_jiffies(expire - passed + TICK_NSEC - 1)

instead.

Anyway, no big deal:
Reviewed-by: Nam Cao <namcao@linutronix.de>
