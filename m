Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEF4258EC2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 13:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773236471; cv=pass; b=e3eKa3hPJ3qYARAgTx+1207uP/+qcvjKCMcaVSYzcIa9y1ps1m8TkO/WP1B7YYTByqonDbwcx46aI0Jp11BbVl3eaM8gfhLEEzEcrWpK09mh6UMnw+961KVMXwTdSayZ1FCQqsOWE5GSNeBz9T9JAdm7AMe0kDUfFjwGClQR17Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773236471; c=relaxed/simple;
	bh=lSW5upmFprSKtGIOsNElfFyIV8vbtM7UayW6zlyxVqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sl0GOSvEYQAa1L+5vvw9HrcEKXh8qR0Q/8Ps1sfAM4y9XJjAcYHALtgt+agPID/I1gLJ1woCd3/QiwYmIx0HsF7vK62Sl/PtglqeDhYzhNUw8Xh8yf00uQauvoBOA/q9dcCZN+sLv6wRtA8xBgqGSCYLuSC/2I2wR8UFCJmjOeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FANEOZvG; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FANEOZvG"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7947cf097c1so132614257b3.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Mar 2026 06:41:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773236469; cv=none;
        d=google.com; s=arc-20240605;
        b=ACVsfj+VekGT4rOknvnuh276qWN9XjCiu8LlmP6MQ0IQB/SaFk8/ZNV1s53JE59sk4
         yn5JUQpg9oGKTQxJVs6mJLk0CDZbHXPU3H2A3jmKkteMn9+jpDbn68oTLBMfruUDf2eC
         I+FSvUoSGd/zs99cgJEqz0TIyhStdikHpHmJAC31bHfMFM6JJM5EbZpIidFnAKzKr7Dm
         gdiICJQ64dM7AebXsbrvDs6AcDi9iI+zqbG94YR620ZiQnwhpJoZc3NuxiuRe2l5PEJ5
         Jsi+4IoH84sCrO1UZbD/YS0Eh5huDr3v0IV8zbcMw+AIYkciXSJti+vmUK6q+X1wCF81
         3+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=omlHZauAtrTylwv8vq8w221VDC1uSPsCYyzOg6I1AeY=;
        fh=acH+1CFZq4zaMXGCzte562NQjBcUCwm6+4fO5gG0Fkw=;
        b=i5FrLkBn5i9HcuogzsasId3DBr1pT2bb+tBVKP7Ow5K9x5gT0fzf+dkaUgTFt5eJGq
         JdC0CiBzfLYO2hHbujPPuvOYrCqO9QDt0mqWt92E8Pj8lgcVYatqvhWojPkVsnvZraf7
         VSsLyhXmXsphv3NVQPJFvGykQZW7gqATiiW0+88szlbgCAC2dRgVDFoEH1KzcI05RfvM
         xsrTJAX+kCvagbnf7vx65p80S0l1Py4/tIFZQgXODVT5wZWDon2aPv5bSCI9djCukaRo
         p3W3eAt0hWfyXQAOkQWSUVLHTt54D91onIqLIg3qlrXu7m4a6oicte0KWX+z4B+7Rp3Z
         vnqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773236469; x=1773841269; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=omlHZauAtrTylwv8vq8w221VDC1uSPsCYyzOg6I1AeY=;
        b=FANEOZvGDAnmaBImMeBhuEfrZWYLYLS9OUI+Xbs5e6dlI5Vr8igHqQ+AZXw9uBUh6Z
         Mny17bOLwToL5Xg0R2MOzvVSM8b9tPRMZGzfluSMbkAUfVysfphC3T5nNGRpKbNg8gyR
         eIXZvBW/rb8gdapyEdjcznglJipBhYlQiSFLTJJ5P8gIaJIHqKBZwtnixSU8c87BjkXH
         V4gTYEvsgWVCCKvIf6B4ukm+Dk/fofIuJtGyuaVCnFqUdWw4/CL1D4u7+j/Dy8JoSJJK
         WrdsZTXV1ik0upFu9D92r2hEDvp54odeauSYoWVIYr1NUcJAGMbh50ibql+avCpyT4PV
         xFwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773236469; x=1773841269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=omlHZauAtrTylwv8vq8w221VDC1uSPsCYyzOg6I1AeY=;
        b=wo7bWi3AOLemwKtvtmJJe2QlXAE2kPI9whPYcXcMmtrwC8NKtxzoaT5Q6r0dE/2ONG
         KS+vjw70PgQNHDF9GXlXJWGE1N4BYYoQZ2pwZ5spvUqyUIlx/B2L7bEIv2FxnGkaqTo6
         rMHFaEDJgT4CgxI6weTLLgYDW9JHVZKqdqbMu1Koyvs0QJLMLbd6wtps17paaTumfsJ5
         UQt9nB84fNoDEP37CG2cRHfYxnd2lemQon8zUhEDUmzA3bs5o2Cxdtl0XHNvIPRSqhsO
         xJ63r8/Rz4/uwihfqaWC0tk1GU7q1FGoftUJOY3espdgzzzoLji7qrTJzDPasWQgnYN1
         u90w==
X-Forwarded-Encrypted: i=1; AJvYcCVyJkw2HLuxLaoQ/sd1RFxdfGFoKho64hxIXGGxTtRZ3xNNgcyWk1haBCpIchqBG+dQoGwriWG0CO93E1zf0miiKyc=@vger.kernel.org
X-Gm-Message-State: AOJu0YykM3Trl95FUgekyEM6bH0yBxESqgD4oj8tw68c1s7ZwUShzfW7
	IinL1CE0FbO4Zi4C/ObKM4vxU/SAYcU3sVeel0yE/8Tqfn4FsRQteshNfRfn5iG45WTVPwPVhSc
	MNFEAtlFLWLkdxN95FwznLOQRSIXekWI=
X-Gm-Gg: ATEYQzy9FOQdi0tI80miwiTQqcctfvkVcX/tNEyqs0MR+4BSYhEuvcxdKYMFKr3UTpY
	p43klxssWOdG8Kt3Qn6cVYSwBjHxi/iYnU7j+gXRmyGvm9FZ5sGJAsHfRlxSUsq7OGwfRqWrDSl
	VdhyMV4DtKIdSegpfI9bN5ypmxin4RJgs3fEaDbUSatcr8Den6YL5fGi85jx9NuXEtFIpqiF7nS
	SPWrrx6+A9KQKp+Pfl/ua2HFupdpW0wCrO0cPJOmWJy9k4xnNRC4KGrtMPWDjwynDSExtuYjJs8
	tVlo/k3N
X-Received: by 2002:a05:690c:698a:b0:799:1f23:6e42 with SMTP id
 00721157ae682-7991f2371e3mr7043337b3.9.1773236469270; Wed, 11 Mar 2026
 06:41:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260311115250.78488-1-laoar.shao@gmail.com> <20260311115426.GN606826@noisy.programming.kicks-ass.net>
 <20260311125350.1d89341f@pumpkin>
In-Reply-To: <20260311125350.1d89341f@pumpkin>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 11 Mar 2026 21:40:32 +0800
X-Gm-Features: AaiRm524erCYqACnVFe23j6m-ZVjclM-nSFR1JGtJBmkuYdF3boGoq6ggzv7XP0
Message-ID: <CALOAHbDqYjJngQmmOaPRA=k4Bb8Or39YNp5R98f_op4dti2_TQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/3] disable optimistic spinning for ftrace_lock
To: David Laight <david.laight.linux@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, will@kernel.org, 
	boqun@kernel.org, longman@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mark.rutland@arm.com, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 8:53=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Wed, 11 Mar 2026 12:54:26 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Wed, Mar 11, 2026 at 07:52:47PM +0800, Yafang Shao wrote:
> > > Recently, we resolved a latency spike issue caused by concurrently ru=
nning
> > > bpftrace processes. The root cause was high contention on the ftrace_=
lock
> > > due to optimistic spinning. We can optimize this by disabling optimis=
tic
> > > spinning for ftrace_lock.
> > >
> > > While semaphores may present similar challenges, I'm not currently aw=
are of
> > > specific instances that exhibit this exact issue. Should we encounter
> > > problematic semaphores in production workloads, we can address them a=
t that
> > > time.
> > >
> > > PATCH #1: introduce slow_mutex_[un]lock to disable optimistic spinnin=
g
> > > PATCH #2: add variant for rtmutex
> > > PATCH #3: disable optimistic spinning for ftrace_lock
> > >
> >
> > So I really utterly hate this.
>
> Yep...
> Adding the extra parameter is likely to have a measurable impact
> on everything else.
>
> The problematic path is obvious:        find_kallsyms_symbol+142
>         module_address_lookup+104
>         kallsyms_lookup_buildid+203
>         kallsyms_lookup+20
>         print_rec+64
>         t_show+67
>         seq_read_iter+709
>         seq_read+165
>         vfs_read+165
>         ksys_read+103
>         __x64_sys_read+25
>         do_syscall_64+56
>         entry_SYSCALL_64_after_hwframe+100
>
> The code needs to drop the ftrace_lock across t_show.

It's unclear whether we can safely release ftrace_lock within t_show =E2=80=
=94
doing so would probably necessitate a major redesign of the current
implementation.

>
> Although there is a bigger issue of why on earth the code is reading the
> list of filter functions at all - never mind all the time.

bpftrace reads the complete list of available functions into
userspace, then performs matching against the target function to
determine if it is traceable.

> I'll do it by hand when debugging, but I'd have though anything using bpf
> will know exactly where to add its hooks.


--=20
Regards
Yafang
