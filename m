Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611C32DE702;
	Thu, 25 Sep 2025 14:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758811167; cv=none; b=F63EnkuSM1MxlN9jzIFK1lMYner/Md/MUtWv+Togl77hq/Y9mCH+3P2zhCwNwcMuT8G9S4wjQ2VLTbU486TZxsegcdSEukt2+EcCEuctDD+RwCGZRJ/qKy8fm207/5o6JR+0cSiCbIN7nZOcMrOr12kp5pUrjWzDzOaBm56CTA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758811167; c=relaxed/simple;
	bh=KnjfQLJD3s3IWHONb8K9H+RKdyMPO0YV1Hhif4rJMAA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DEX27IG+iI+fUp2dtpWqM9g1itFpuQgdF00r2BCyg1NUfeW/dkceamqX3/b0Ge5QSrh9EAX8IAlugPbSG+yEiY05v19vMWtytqZtCo3G3yvetJq5b6/mMH3ZQ8dM2LS0zoUI31fM8X+V55dehj47gXWKnODUSoAR9c1HHoOuezo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZGthc295; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CpGVnkjC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZGthc295";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CpGVnkjC"
Date: Thu, 25 Sep 2025 16:39:18 +0200 (GMT+02:00)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758811164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnjfQLJD3s3IWHONb8K9H+RKdyMPO0YV1Hhif4rJMAA=;
	b=ZGthc295HZ47YWeuNoepvmlgQDhdTUmNXO4LmkvLCTWZ03sK/oA0ogBAA1NBz8Ho0lO7n4
	mcuo+3LHR0aPX3VLs9ezhRN10faEA8aSiTYQQwugKRwDku0zSohinysdBD6v3PchN/qJqA
	oDX4Zk0Oo0XmVXCNQUlIiIs25jZMIaWYG3jYz36kP/0ZZ7Kz9vLKv+iK2JLjqhrhOwDSlQ
	kUZvU4HRsamNH7FXSCuIxU16c0DBnh7W6PdxEW6AVsVUfQ64F0riyXmrR32oLa6S15uZ8j
	pq2ijyJEsFzjxJ2wsAS2pjBkJGnUYPKuVOnBBNTX5egstaFcXm373JRh/vqUgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758811164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KnjfQLJD3s3IWHONb8K9H+RKdyMPO0YV1Hhif4rJMAA=;
	b=CpGVnkjC6Tm3kwhb52A8t15B07L3QpV+CVUsHSzQPZsFBkk5EM/Fu4dWJwmfp/eOgTaPgO
	8HMCgW+7FLao8/Ag==
From: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Message-ID: <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>
In-Reply-To: <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
References: <20250919-rv-reactor-signal-v1-1-fb0012034158@linutronix.de> <d0aaaf1f47f0d948b60b0575e179564e3c024188.camel@redhat.com> <20250922162900.eNwI7CS0@linutronix.de> <ced1cdde298d105ba2d789e4e4704caac8dec518.camel@redhat.com>
Subject: Re: [PATCH] rv: Add signal reactor
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Correlation-ID: <6a5fde33-b3e3-44e2-8ea5-5f4cf350cf35@linutronix.de>

Hi Gabriele and Nam,

Sep 23, 2025 09:43:05 Gabriele Monaco <gmonaco@redhat.com>:

> On Mon, 2025-09-22 at 18:29 +0200, Nam Cao wrote:
>> On Fri, Sep 19, 2025 at 02:26:12PM +0200, Gabriele Monaco wrote:
>>> On Fri, 2025-09-19 at 12:49 +0200, Thomas Wei=C3=9Fschuh wrote:
>>>> +static void rv_reaction_signal(int signal, const char *fmt, va_list a=
rgs)
>>>> +{
>>>> +=C2=A0=C2=A0 struct rv_signal_work *work;
>>>> +=C2=A0=C2=A0 char message[256];
>>>> +
>>>> +=C2=A0=C2=A0 work =3D mempool_alloc_preallocated(rv_signal_task_work_=
pool);
>>>> +=C2=A0=C2=A0 if (!work) {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr_warn_ratelimited("Unable to s=
ignal through task_work,
>>>> sending directly\n");
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 vsnprintf(message, sizeof(messag=
e), fmt, args);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rv_signal_force_sig(signal, mess=
age);
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>>>> +=C2=A0=C2=A0 }
>>>
>>> Why do you use the task_work at all instead of signalling directly?
>>> If that's something not safe from a (any) tracepoint because it can sle=
ep
>>
>> If I remember correctly, sending signals requires a spinlock and therefo=
re
>> may sleep on PREEMPT_RT.
>
> Yeah that's what I quickly glanced at. Which seems to be the case also fo=
r
> mempool_alloc_preallocated by the way, so I'm not sure that's safer than
> signalling directly on PREEMPT_RT.
>
> Thomas, did you test your reactor on PREEMPT_RT? I'd expect a few fat war=
nings
> when this is called from sched tracepoints. Unless you're lucky and never=
 get
> contention. Lockdep (CONFIG_PROVE_LOCKING) may help here.

I trusted the documentation, which promised not to sleep.
I'll rework it for v2.

> Thanks,
> Gabriele
>
>>
>>> you should definitely not call it if allocation fails.
>>
>> Yep.

Ack.

>>
>> We probably can get away with not reacting at all if allocation fails, b=
y
>> crafting our tests such that only one reaction happens at a time, and
>> allocation won't fail.

Ack.


I am wondering if it would make sense to add a new tracepoint that fires in=
 addition of the reactors.
That would allow multiple simultaneous consumers and also bespoke handlers =
in userspace.


Thomas
