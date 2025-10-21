Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 897AC3346A3;
	Tue, 21 Oct 2025 11:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761047746; cv=none; b=TPt1Hktv1ZEocoCEmL9+3OYo0pnu4Y1KaAt4BuNNBQHlj/OCBusdRqHm+AS0uYOxyqOA71q1/dIuilhE5+G1v/8TXW24/P3ciQeDOGc/auKr1sH6Ho8mD9w+l6iegeLrAJANDdoaLoNYNqxLKpbsjIaWY2enJQD0pLi49XMRByo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761047746; c=relaxed/simple;
	bh=sfrIkGFyQJLVpjb8aEBzy44vnyD09WwLu3/8FRkPxP0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O+xRTOGph/+/QC3qJe9w8fKpumwCJKYL2YNmzZ5qDuA+bTIP2vB0kWVhV//EkEXSfj4EGjdd96lZWBZFXsIJe0xMJSJ1DCxv39aGSBvECfkzIuxGgrjLlYYTzxEgr0jjSgiskdE6PhtTysZggM+EQoJKrBuT6ZZy8hxIYa6s0KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lONiR806; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=14v32Wss; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lONiR806";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="14v32Wss"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761047742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dK3mFQ3qr09kveAbbwewXdGK2hBD6okXrlQGLgqnl/k=;
	b=lONiR806L655urbjQJ2Ze14m7dtIpn8SF0dLyGlzlKM7tvVcuiRox3/VBWxHfjkejZXVKW
	+//1a5OzlX+DUheCfTS42oJjfxDZ0N7KU50tDi30qtWI8dR5UYpHPWJJTtcf5EfPA9JTXT
	Yt0h2FmMB7N6XVsggAV1iXWW5qqD4vIHdPxcwLmmW0K2LNyDmTMrnz3UNOaV5ovTxA3BOr
	ZZBCjaW6Ow8YFS8CVrPp0u9u7Y66ojg1lwMwELyYqdtziFrve6yZNZYNoYwsClCyWfoqkP
	ccuo4P0kRZWLJF9xaH22FQ1PSYKcxC8YfuCiKA6Q8W6uCz5H2OONNNQQhBcYfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761047742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dK3mFQ3qr09kveAbbwewXdGK2hBD6okXrlQGLgqnl/k=;
	b=14v32WssVnj3AgaaBtLdBPsF7WD+DpWpLjPvyIvb2Or1YgtZQ5h1KlOjA1H11w2qzMmiFs
	khxEhB/8nfPKyIAA==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 18/20] rv: Add support for per-object monitors in DA/HA
In-Reply-To: <20250919140954.104920-19-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-19-gmonaco@redhat.com>
Date: Tue, 21 Oct 2025 13:55:41 +0200
Message-ID: <87plag1nb6.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +static inline struct da_monitor *da_create_storage(da_id_type id,
> +						   monitor_target target,
> +						   struct da_monitor *da_mon,
> +						   gfp_t flags)
> +{
> +	struct da_monitor_storage *mon_storage;
> +
> +	if (da_mon)
> +		return da_mon;

I think this 'if' should be moved to da_create_conditional() instead,
because the "conditional" part should be implemented in the function
whose name includes "conditional". I think that would make the code
easier to follow, because one would already have a good guess what the
function does without looking into the details.
> +static inline bool da_handle_start_event(da_id_type id, monitor_target target,
> +					 enum events event)
> +{
> +	struct da_monitor *da_mon;
> +
> +	if (!da_monitor_enabled())
> +		return 0;
> +	guard(rcu)();
> +	da_mon = da_get_monitor(id, target);
> +	da_mon = da_monitor_start_hook(id, target, da_mon);

Do you plan this da_monitor_start_hook() macro to do anything other than
storage preparation? If not, perhaps it is better to name it
da_monitor_prepare_storage() or something like that, so that this is
easier to follow.

Nam
