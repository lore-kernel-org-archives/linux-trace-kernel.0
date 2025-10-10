Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C542F7AD8;
	Fri, 10 Oct 2025 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760108667; cv=none; b=hzmqO0O9H0dBuBVZQb4MBW6wkP3VCXIbC9phXdIrmfvWwN/E6JpzQ6UqFwRWN9+THpOJO8EYgHSo/qvrfW7FnjUHipcIsyNKrIb/YEhCHhEyPcTS79GfPm/QVsP3XGF+X9m6XSfeU4IpGGPIxuI0zx3uXB3DLz/JCnMQli6Pn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760108667; c=relaxed/simple;
	bh=GfJuozII+KfzUcoxGxodQql3nDzRknSlAkbdqk4rpmU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rvhXhJRH3qvWnFt3Zl7AuvXEOCTxs27I7YH83E9JNEwe3gf5ntTGnpLaqtbudscEFW61lPmD2nLBYCrDAYhVHKSj2v13vUqtRlxJ+2KCH4UGAPMv4RzGyKlcSjoawiSyUcA8FMGaPfrKNF+WBWSZQ/5hG+TFJ67jp11env2K5p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iE4KOTlz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+BVHmD9P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iE4KOTlz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+BVHmD9P"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760108663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg6gbhiEb2b9MJ+4TBeN5TtqEY4lXSk7G+sLUT4nD4w=;
	b=iE4KOTlzSoaSLXpDv053i2/qeVegBOOzykZKD7iWCBaAoj22a0rUM3By2zfmzcr3fmjypy
	+thyyEsufA0ExX+nulR4UZtH50/bFUAiPRO2GkPHjXE89K4q5jWf0v/9uHzzgHDc4l82kG
	+k0AZPWvm8feP4azoHwFL2twRlXj0v9itsyZqh1ZEyZHz8jLAnpQICb31IZl16SoPXLUjm
	vFmsfZulFF56wK1zyBeJwD3FNGXDjqaOdAf90cG3LAgI6r6nY+MQA8Nle6f7U4JewVI4wJ
	ginmBFnLm6OHrHb8AGE06quiWF70a252JecbQuII212wmVic5sJAUb6iroLm4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760108663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lg6gbhiEb2b9MJ+4TBeN5TtqEY4lXSk7G+sLUT4nD4w=;
	b=+BVHmD9PDx7Psn9jBHZQ5HifBpC6JkbEbxicCHY/xuAScMO1PCmTHm22bNeL1ernVrsooQ
	vtXZXQksGBEdw5Aw==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 20/20] rv: Add deadline monitors
In-Reply-To: <20250919140954.104920-21-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-21-gmonaco@redhat.com>
Date: Fri, 10 Oct 2025 17:04:23 +0200
Message-ID: <87a51yyf0o.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> +/*
> + * Dummy values if not available
> + */
> +#ifndef __NR_sched_setscheduler
> +#define __NR_sched_setscheduler -1
> +#endif
> +#ifndef __NR_sched_setattr
> +#define __NR_sched_setattr -2
> +#endif

You can use __COUNTER__ intead, would make it easier to add to or remove
from this list later on.

> +static void handle_syscall(void *data, struct pt_regs *regs, long id)
> +{
> +	struct task_struct *p;
> +	int new_policy = -1;
> +
> +	new_policy = extract_params(regs, id, &p);
> +	if (new_policy < 0 || new_policy == p->policy)
> +		return;
> +	if (p->policy == SCHED_DEADLINE)
> +		da_reset(EXPAND_ID(&p->dl, DL_TASK));
> +	else if (new_policy == SCHED_DEADLINE)
> +		da_create_conditional(EXPAND_ID(&p->dl, DL_TASK), GFP_NOWAIT);
> +}

What if the syscall fails for any reason? Wouldn't the monitor stores
incorrect information?

Nam
