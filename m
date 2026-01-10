Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05E51C1F02
	for <linux-trace-kernel@vger.kernel.org>; Sat, 10 Jan 2026 00:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768005325; cv=none; b=UgvsadZkQ75CgiVVnK+lnrdcvKZNIY/U2GrLJugxDmUmDYp2fxYdeEHB7p8GjN6AKzG0Ck4ed4v/lfp/jask8JOisQCGnbmVuUSSN/yLrCL9lBf47O53Pi2eooujeB98jtnepxQuYpuGMpKvi/WGEAtquqxQvJmv1o14/6SMOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768005325; c=relaxed/simple;
	bh=nYiS4uilyETQDbIQtzOwkALPQdi5rc3kAMuT+u+f0uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssyFsKwebxegbwmjw40z2JFpRN3a2hFdFCUqj7W6wD2ytG34EI45pMD67st0uW3fQ3ws8RwSNlqXuESROycMmJZ+HwW2zC3idJcLspWWXBHXI09drp/eKTk6BswJM96vPhpRp0bNDI5u64XxcGbtHgWq7ToeEiZ1SL+59hsAt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CW8zmoty; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CW8zmoty"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4327778df7fso2953413f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 09 Jan 2026 16:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768005322; x=1768610122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYiS4uilyETQDbIQtzOwkALPQdi5rc3kAMuT+u+f0uI=;
        b=CW8zmotyWs/48jFTG1A6SnJAEYAU9nZaEFdquTl8HBy5LrEr0/Zn6B9cCCot0SxOzI
         C1RF3vmrDuJkb59UUR/gQGB5UYYE9lQbfMeWFOsaCHLFVsaD/sEUxZ7fcTnVttdVcAI3
         dUyXliUT+gogY8udZIWmZViZoh8JajFtIMiRp2zYxY8petKMeRDNyCUetvoN+LUcxKLF
         D0Pw9bteHOLOJE2zsscgaL1Tba2/3Yob1fGIAw6+hjvnwny++x5J2Yq9Z/KHuzcAQbRD
         4NBuBXJxeuLU7m6yYE3JsoJQCuZwTSF3p8aIf/MSHYZcnnTmeojO3Be8DlNcJe6IxwsJ
         4uzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768005322; x=1768610122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nYiS4uilyETQDbIQtzOwkALPQdi5rc3kAMuT+u+f0uI=;
        b=XEeV4vDiqz3DQ/jgc2TrhrmXM/IRRxMgsBuEw7IjSKC0bgJo9NHlzGZ1N666ruQrdx
         u+qSnYgObl1XUFmZKk07sSGQgE9+CPWrlXw3dge8vp90k9JTJPa3/fSD65SQTwozeZql
         nbPSOftq24shpwNE4alsRmAbieSEyaFDHOraVAueQea95hvK5ul1Yke8Bs6SK/pFMFva
         LXI6xiif12kTz1QlugucBCk4jUPU67YEBwlytrApc3/784ue8IhsV9/zIoGWWn/F8rpM
         MMyuEEDQWDwh4byaZkghoNr2Z2OmHNxNwKeqft55AQOuPGo3u70DmAHDqGxZdJH9MTrq
         ZLcg==
X-Forwarded-Encrypted: i=1; AJvYcCU2YghMLy7MRO90wmmQ+wQ3yQ04G8sGWN+ksMccQLKy2kcXuzgv3cAnEXEIiVFLQrcFrsoZWOWl3qWOoaPHRLj+gXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yywbv+uP7+GSPZqkWHMptZQVscTYbVyfn+JpAEsM7Bk8WeK5NXI
	XPIR76urUh4O36z1jMbZaFPHNrZ+j0/FrR8qS+jJSYcIb6tr95z6l4xnFWWvhdRuzIDRQb3/JX8
	LL5rxAW2uTdFQBv5PdKzWI/fpwuHKRgo=
X-Gm-Gg: AY/fxX7G8kMDCWP2BsMvrB2fwWgy3z6DWmPLYNWOX6WTOv7JpxZIrPqA8iPqTw60Gdx
	P5eP6HDRAATEfNcfizo1YKZ6i4+pWo8m/vZx3GxlFhL2hfvLWf80zxtoX3YM1FG0Wls+/f+0jaM
	VV7Y2F6knfEzZh3+OOGrmTgi2ROHHm7WXkIr7bDXGAm1poSdfbSc5dRUAQgiLon/G5jvKZm+t3B
	qP+3eW7WvEM6VK6Zuud+qDMXjW5JqkMbDXhk2Cqrs9bXOhI9Y80iIIK2tXbDWLyZXYvxdP80PRB
	Z2mRHgrDOweRU0IA2QyAd06ktOUe
X-Google-Smtp-Source: AGHT+IE4XaA3jxjGFghWJSP6TdEeGSeNUk/8yX/j0ToKhLfGGGq7jwkCc7XpN+TmOnkbW/zNz1GmPORhjHCbgjOMA7g=
X-Received: by 2002:a05:6000:2087:b0:430:f8b3:e834 with SMTP id
 ffacd0b85a97d-432c3629b4amr15079467f8f.11.1768005321410; Fri, 09 Jan 2026
 16:35:21 -0800 (PST)
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
In-Reply-To: <20260109173915.1e8a784e@fedora>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 9 Jan 2026 16:35:10 -0800
X-Gm-Features: AZwV_QisbaDK1B8dOAo5PHdFATblspEn41lOmKMZV_0j2nND-tC1Aq3Fxa83rZk
Message-ID: <CAADnVQKB4dAWtX7T15yh31NYNcBUugoqcnTZ3U9APo8SZkTuwg@mail.gmail.com>
Subject: Re: [PATCH v5] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 2:39=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 9 Jan 2026 17:33:26 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > How is this about lttng? Sure he cares about that, but even tracepoints
> > that lttng uses doesn't get affected any more than ftrace or bpf.
> > Because lttng is one of the callbacks. The migrate disable happens in
> > the in-tree portion of the code.
> >
> > So you are saying that all the tracepoints for xfs are not in a fastpat=
h?
>
> Regardless of tracing. I now have my RT hat on. The spin_locks that are
> converted to mutex use migrate disable. The fact that migrate_disable
> in modules are close to 10x slower than the same code in-kernel is
> troubling to say the least. It means that modules in RT take a hit
> every time they take a spin_lock().
>
> The migrate disable being slow for modules is no longer just a tracing
> issue. It's a PREEMPT_RT issue.

migrate_enable/disable() wasn't inlined for a long time.
It bothered us enough, since sleepable bpf is the main user
of it besides RT, so we made an effort to inline it.

RT, at the same time, doesn't inline rt_spin_lock() itself
so inlining migrate_disable() or not is not 10x at all.
Benchmark spin_lock on RT in-tree and in-module and I bet
there won't be a big difference.
