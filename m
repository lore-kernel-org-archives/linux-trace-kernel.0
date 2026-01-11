Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB03150997
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Jan 2026 23:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768174732; cv=none; b=Qbf46DcKMAxugxmJywMfQYZIwfrop1wOL+WaV5CdqmrlhQd2HTmyGDOwUZiFmF1XUaxqfNzAJFp18XdibByVyAvEDyl4qiKUVUPy8tiLGv8r2GXwLHgXtWA/8R799Xs/JMfohu67HRwRFcuuW5WRfTFbJmf61YtKOIwpZ7XQRHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768174732; c=relaxed/simple;
	bh=kiXWuKzIX1x06aBMcxfYYewoOyDtnrGOZE+OOoXbLNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K6NSpk1tVY6zh1TlCxjLYEIR99nFmP+QwnH5DiZIl0YEcATL5cEU2XZfGTrxDehexP8WHZDveoUmM1d6vBrlcuRtvenw5wiyLtWf7rA8ae5fNe7AuPQ3cg9ewevMZ7XucbB3AryaJ9BrM4OP9eZNXnXBKssWqZlW5exHi1BH9Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1GsXbc7; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1GsXbc7"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so4337960f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Jan 2026 15:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768174729; x=1768779529; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kiXWuKzIX1x06aBMcxfYYewoOyDtnrGOZE+OOoXbLNM=;
        b=V1GsXbc7qHCqdkB30tri7P3dRfDxGmDg0h3datuwhBVVKAOL5jgFJGSqVrdNh3BVBP
         nZ9mEM/ZJVFaOtyz4T4p8FvlYEzgOgdFipeGG08JMgQiGPCzgOLYkuKxJnR1JB5losbd
         eCgF4tvyZG3SwinyLbXgQ3GYf6Q0c3vXHnaM5vIhzEOUYfoCBXRVypCiVIaaUj5jNaYg
         Iu6rFaUfK4zPKfFHO+ofbtpWH6ts5f+HH3rktq6suD9b9AfXyqF7fW/HwGZL2hKYKY/6
         adPlUKDesamGBDUxC0m6bJscDn5RCoOJbIfmFT+/Yu2JXFED52+JeUwtKeBP+TpdBuBZ
         N4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768174729; x=1768779529;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kiXWuKzIX1x06aBMcxfYYewoOyDtnrGOZE+OOoXbLNM=;
        b=XJASfazVpHvjbJUp9WRSFagz6hzbkWQSkAYCeUIu/m4vTuETZiNLJeFYOVm2vjmffV
         r5aIERo5UlFBz+58RkEiWrNWurTG6sH9kbmq1xMhOCYS1ejr60OfO2MIK8ICZPs0hLj2
         oHE3vwg2RgYXPb8Lw7h8fgPjpYyjHuhvdhRSH4aFnNsAQ59L16pFJsKLF2Sjzr/2siwM
         kkaaaSMP8f6jDJmt76wuFaG1trIgFopD2X3y2qY/COQWbZt+uEkARkzqnaax2is8xUql
         FgYxkc7qRWF0tWlMbr2kIGJIWEQWZmOGUJXWwL0KrCHzfLgW8pkxlrXNKfkB4eNP5tVv
         OAwA==
X-Forwarded-Encrypted: i=1; AJvYcCUy2enUyYWcLdY6U0yl+yhmrlhVp4GOjK+EEXCFe2cNaqgreeF5dvtdupylfiE0b1zJBGMwWHvZ7N+qQ1pT0FKCcKM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzWydH1t5hC+hspR14CJdylVvSODKGEegxYAOJeeAevNR7uPa5
	FWseaacfHo+7EMAmqVAqbTePvpIc7O+wDne9SP1mFG+cBAuFcqC5/1iyQvY5stMe0Y2f1XbMP/K
	QF+HBu5ChDFWVBuktbK9NhJ/QIxBG9/w=
X-Gm-Gg: AY/fxX6CFg6LUerN7arIYL4BxNJs7sxVP35FbsjVGCpX8mNC0YlrtMPTtHXGgHSyB25
	H3xToi0wkTpvEAR4U0A9JpSTejoNpRihsT40R8WezXEAJlxtvoFb1HY2dfMqn+sQFr/zx1jhYLg
	DnjrS73sQnb/i087aXTyYk8NyLIk8xWFcvcmB7OtanEipDiXFOkcXvOWelXphF5k4D6GaMB+CBZ
	was9dpoVaYTLMjCr7rGclq1cQGbqxji6cG97wldTelcckfQa36NyGoODAGKDXtVj2TGLxtbXlmc
	15z060hi6ZhWPBYTMU/R3nmBYC0ToERmRnrzZ3c=
X-Google-Smtp-Source: AGHT+IFUOvDT34dvyomwn3c7ZwM6ALEAOAqRH7FWOKzQCzQUJjuK/9NtjeBwyRJsMcrShx2AnzXOyQRd8inlOoww4Fo=
X-Received: by 2002:a05:6000:4287:b0:430:f41f:bd5d with SMTP id
 ffacd0b85a97d-432c37a300emr17145280f8f.55.1768174729186; Sun, 11 Jan 2026
 15:38:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108220550.2f6638f3@fedora> <da261242-482f-4b47-81c6-b065c5a95c4b@efficios.com>
 <CAADnVQJMa+p_BcYxKUgve2=sqRBwSs3wLGAGhbA0r6hwFpJ+6Q@mail.gmail.com>
 <20260109141930.6deb2a0a@gandalf.local.home> <3c0df437-f6e5-47c6-aed5-f4cc26fe627a@efficios.com>
 <CAADnVQLeCLRhx1Oe5DdJCT0e+WWq4L3Rdee1Ky0JNNh3LdozeQ@mail.gmail.com>
 <20260109170028.0068a14d@fedora> <CAADnVQKGm-t2SdN_vFVMn0tNiQ5Fs6FutD2Au-jO69aGdhKS7Q@mail.gmail.com>
 <20260109173326.616e873c@fedora> <20260109173915.1e8a784e@fedora>
 <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
 <20260110111454.7d1a7b66@fedora> <CAADnVQJ_L_TvFogq0+-qOH=vxe5bzU9iz3c-6-N7VFYE6cBnjQ@mail.gmail.com>
 <20260111170953.49127c00@fedora>
In-Reply-To: <20260111170953.49127c00@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 11 Jan 2026 15:38:38 -0800
X-Gm-Features: AZwV_QhL36czEI7sCQwGEwK5X-GlTAcDBYsReVH0tRCSZhjpYR06hlv9A0Tnzbo
Message-ID: <CAADnVQJiEhDrfYVEyV8eGUECE_XFt7PGG=PFJRKU4jRBn-TsvA@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 2:09=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Sun, 11 Jan 2026 12:04:51 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > The diff has nothing to do with bpf needs and/or bpf internals.
> > It's really about being a good citizen of PREEMP_RT.
> > bpf side already does migrate_disable,
> > rcu_read_lock, srcu_fast/task_trace when necessary.
> > Most of the time we don't rely on any external preempt state or rcu/src=
u.
> > Removing guard(preempt_notrace)(); from tracepoint invocation
> > would be just fine for bpf. Simple remove will trigger bug
> > on cant_sleep(), but that's a trivial fix.
>
> Oh, so you are OK replacing the preempt_disable in the tracepoint
> callbacks with fast SRCU?

yes, but..

> Then I guess we can simply do that. Would it be fine to do that for
> both RT and non-RT? That will simplify the code quite a bit.

Agree. perf needs preempt_disable in their callbacks (as this patch does)
and bpf side needs to add migrate_disable in __bpf_trace_run for now.
Though syscall tracepoints are sleepable we don't take advantage of
that on the bpf side. Eventually we will, and then rcu_lock
inside __bpf_trace_run will become srcu_fast_lock.

The way to think about generic infrastructure like tracepoints is
to minimize their overhead no matter what out-of-tree and in-tree
users' assumptions are today, so why do we need preempt_disable
or srcu_fast there?
I think today it's there because all callbacks (perf, ftrace, bpf)
expect preemption to be disabled, but can we just remove it from tp side?
and move preempt_disable to callbacks that actually need it?

I'm looking at release_probes(). It's fine as-is, no?
