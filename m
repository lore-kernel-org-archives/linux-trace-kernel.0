Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D2F64D;
	Wed,  9 Oct 2024 13:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728479136; cv=none; b=DjhQMboeRvCVBDhMFA2Ar/H0CrgAjLWEN/EzmGRvXpAP7a/airAUoQjj/U/TK84C8uWJWKk93peYEHvPuvXgk7JrF8teVtxzyhEJ5R00gh31Ug3dYv/xeTxdSL2mFfBFmPv73Cg8+DgdHjiz080J3UxzVICp+QDH1hL0WLDKzpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728479136; c=relaxed/simple;
	bh=HpDwMMW0EbfJmDtxqlj+QsOGnpID1Vx5S2TVTENvwcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7+tPpRTLuCMWXuEz/vDMEm3dSwPJm1wHLyHZovehmKXG62u3Wed7Ik2Q2tDGgnVHplW/ef/84kz8lvG3m0qYhr1o5D7d49gNMQRWMjidLz5vnHVOldjtuyhiwXQA/o8yJ5NMfiYjC4rrOraeyYjZ2BaHHkX6QNaE8ySo4FOnSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pI0/eF6i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ItCAJJN3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pI0/eF6i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ItCAJJN3"
Date: Wed, 9 Oct 2024 15:05:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728479132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7am4Xq3FF1ZP/UXdXnJGWmSInOHqTwnSQ0K6Ad/CZs=;
	b=pI0/eF6il+U8UScFEt49X+x94i9ahFGbOjQ03wX7Rd0PRXANnFosxu82PKP67YxQ2UNLSG
	JvGOuDieY+LFRCPGgzkURb39QVLYtLI2HWa6RUQbFUghWokVwpatFzbP/fE1ySIUaVpugF
	qiQMw+K8JAAycmtT5U3cDFceLQhSMltL7cZi1UcoWdwaRm6mvMhJBVYqob/vXaMnSomk2M
	D47ij+Ldv27aQaEPMj2n1fQr+amm7v8lffDDTvLUPGvpkiArOGRHwhbN0KZQo4QtLP2gJk
	4zDIK9QphIVIbMeROEgBoA1d5N283coHPvW3ZCp6EaxliTHoniBQyDdELTU0fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728479132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T7am4Xq3FF1ZP/UXdXnJGWmSInOHqTwnSQ0K6Ad/CZs=;
	b=ItCAJJN3bJ2dRUIbLldK7UFjwgnjSPCOB0fG1tyE1+WeJ/X1Q9ebKi3ikph8AKo0D3sa6T
	rWQi3vDMrr944mCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
	vschneid@redhat.com, ankur.a.arora@oracle.com, efault@gmx.de,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jisheng Zhang <jszhang@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/3] riscv: add PREEMPT_LAZY support
Message-ID: <20241009130530.2Sv2p0Eo@linutronix.de>
References: <20241009105709.887510-1-bigeasy@linutronix.de>
 <20241009105709.887510-4-bigeasy@linutronix.de>
 <20241009130307.GN17263@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241009130307.GN17263@noisy.programming.kicks-ass.net>

On 2024-10-09 15:03:07 [+0200], Peter Zijlstra wrote:
> > diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
> > index 9c10fb180f438..8b5a5ddea4293 100644
> > --- a/arch/riscv/include/asm/thread_info.h
> > +++ b/arch/riscv/include/asm/thread_info.h
> > @@ -107,6 +107,7 @@ int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
> >   * - pending work-to-be-done flags are in lowest half-word
> >   * - other flags in upper half-word(s)
> >   */
> > +#define TIF_NEED_RESCHED_LAZY	0       /* Lazy rescheduling needed */
> >  #define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
> >  #define TIF_SIGPENDING		2	/* signal pending */
> >  #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
> 
> So for x86 I shuffled the flags around to have the two NEED_RESCHED ones
> side-by-side. Not strictly required ofcourse, but...

I can shuffle them. I don't think the riscv camp will complain (saying
this for them to actual complain if so).

Sebastian
