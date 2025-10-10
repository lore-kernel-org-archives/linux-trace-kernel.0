Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD5A2F5339;
	Fri, 10 Oct 2025 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760106558; cv=none; b=et/+c2iG+wIeIE2sd/FjO0Dq9iqTozEtpcJ5x9Lqu2uWcvrsvVqQX7TxsNLwxJKHPw7LlBabomnZ/CtVlSArKPasoZlBJEqZNQqbj9fETF9+9QvhHqXXAkV+ZQuLRtVqzoyeqhstlk58UehWLXvfu3jWAaXjf0VALtVGgm7rt3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760106558; c=relaxed/simple;
	bh=QlsZDipxHrbViEEbVVqOtsSC9AZw1QPkMgOMNzC2mh4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LADox/bX9msg1jsClWVWVzWF3XYQWbO3kpJK6YDea55NeiVAwPsZH+Uv2HIKG3y64Z+ptJZs2gAXW+Yw/cfrtjHtsAUfl6mnACMg9YLGXfAzSAmmNzuDbfeUa+a2Uv2EnkUEWU39vJ8e2sAB925dctRgXjR5JVkL7fnK8HRLwBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TPUz/1N3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NALgCIVO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TPUz/1N3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NALgCIVO"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760106555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpu4coQ327PAjnrLaKBz1LUEuWSOE3u8pf8NdZvuXoY=;
	b=TPUz/1N3rGzLGmIJBeNWSgnvQ1/5gcH8Yc9mwEeBCVn0XuuhIgLbiSEsViWsewIBjNWRXi
	J0IDpILvmsqfxJcKhwRs9RL1OlkQMoEcCR5g3sftygPMmcBkYzLA3pCu2J16Sbq207x9ir
	Yr2SLTHKiFW5tC4icF0iykYf8cnD/k7vasuf+MONkrtv+yHlMXPmvE0toxrLrZxV30x7Rm
	zHPW/3fcI4jTYwU8I2q2UZmC40FcImQsY88WblQmI319lINkpfuJqBclMe5HUH8rB67S7b
	SdxwLKCEof5noJIKp9r/mhbuzopBs/rCUJh/UTQ8aXJF4UXBboNrfzeZipd0Jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760106555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wpu4coQ327PAjnrLaKBz1LUEuWSOE3u8pf8NdZvuXoY=;
	b=NALgCIVOvwFqFkii50DTrxs9Xp+V/Qd5UPq0hdYipoOIOPZv+f5WCjPW02G0+VEEqHVgVL
	NoJyANpefuQAFkBQ==
To: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>, Tomas Glozar <tglozar@redhat.com>,
 Juri Lelli <jlelli@redhat.com>, Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v2 15/20] rv: Convert the opid monitor to a hybrid
 automaton
In-Reply-To: <20250919140954.104920-16-gmonaco@redhat.com>
References: <20250919140954.104920-1-gmonaco@redhat.com>
 <20250919140954.104920-16-gmonaco@redhat.com>
Date: Fri, 10 Oct 2025 16:29:14 +0200
Message-ID: <87cy6uygn9.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> -                 |                     sched_need_resched
> -                 |                     sched_waking
> -                 |                     irq_entry
> -                 |                   +--------------------+
> -                 v                   v                    |
> -               +------------------------------------------------------+
> -  +----------- |                     disabled                         | <+
> -  |            +------------------------------------------------------+  |
> -  |              |                 ^                                     |
> -  |              |          preempt_disable      sched_need_resched      |
> -  |       preempt_enable           |           +--------------------+    |
> -  |              v                 |           v                    |    |
> -  |            +------------------------------------------------------+  |
> -  |            |                   irq_disabled                       |  |
> -  |            +------------------------------------------------------+  |
> -  |                              |             |        ^                |
> -  |     irq_entry            irq_entry         |        |                |
> -  |     sched_need_resched       v             |   irq_disable           |
> -  |     sched_waking +--------------+          |        |                |
> -  |           +----- |              |     irq_enable    |                |
> -  |           |      |    in_irq    |          |        |                |
> -  |           +----> |              |          |        |                |
> -  |                  +--------------+          |        |          irq_disable
> -  |                     |                      |        |                |
> -  | irq_enable          | irq_enable           |        |                |
> -  |                     v                      v        |                |
> -  |            #======================================================#  |
> -  |            H                     enabled                          H  |
> -  |            #======================================================#  |
> -  |              |                   ^         ^ preempt_enable     |    |
> -  |       preempt_disable     preempt_enable   +--------------------+    |
> -  |              v                   |                                   |
> -  |            +------------------+  |                                   |
> -  +----------> | preempt_disabled | -+                                   |
> -               +------------------+                                      |
> -                 |                                                       |
> -                 +-------------------------------------------------------+
> -
> +
> +   |
> +   |
> +   v
> + #=========#   sched_need_resched;irq_off == 1
> + H         H   sched_waking;irq_off == 1 && preempt_off == 1
> + H   any   H ------------------------------------------------+
> + H         H                                                 |
> + H         H <-----------------------------------------------+
> + #=========#

Nice!

> +		 * If CONFIG_PREEMPTION is enabled, then the tracepoint itself disables
> +		 * preemption (adding one to the preempt_count). Since we are
> +		 * interested in the preempt_count at the time the tracepoint was
> +		 * hit, we consider 1 as still enabled.
> +		 */
> +		if (IS_ENABLED(CONFIG_PREEMPTION))
> +			return (preempt_count() & PREEMPT_MASK) > 1;

FYI, there is plan to keep preemption enabled during tracepoint
handling. So keep that in mind when this monitor breaks.

Nam
