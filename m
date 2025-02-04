Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B4814B094
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Feb 2025 03:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738639736; cv=none; b=cbQpddwUW1ON6zZGuFxm92GnzNI1p9oUdxl4q4yvIK7tT9V8pQRyScK+agu2DADxJ68UI9Nqehgqj+CGvISDr4+zYv/3c2Npq5stmLZMa0Lcr/ue7pHYyQonKG3oK+SY6xxKzaz+Eb8cIfaFWBvpngvRSoLErh4G9vBoOUFVRqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738639736; c=relaxed/simple;
	bh=CFY6+1/iZfibT4R4WsfwMdIKrQLWAAC0lZzgGcaBwk8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BpW1byxOvJgiTOfDf/rdRuy/IThisiFSwoStJ/iUSQDCL284MZKW5S11/NpwBvtDNt4rR1gIhs+dR9FAjN8sbiVLIWcQBQVJ2YiW5RJ+1ZCUFvNHDSDT9DAx4O3ZOuvbvT4+f52YXC8Dws4EeN92q47umY/lrSqsoyqoV7d7/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qPTzYbjv; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qPTzYbjv"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-467b086e0easo22727541cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Feb 2025 19:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738639733; x=1739244533; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ypnXRpVd7BRYU9e6tSX+xvv2lBSXpI+Wfpw7I5WJkzk=;
        b=qPTzYbjv0YPnVXVC9mJTLJrwkO+oetxLStk1RWnchMqkU9PhDL3mmBRqk6aqAbK5L3
         gw7F2p44lnOjjak1K2TiBfuhelRFRpLNJNpadzOYV9dspLixhXwuzI5vbhMAxhgi5NiX
         wuI1ZbOEGOXLyD93DDAOI0IA2qXrePGGBFswuvCVx42Hn5Kky66O8x72VVeku9axsF97
         SZBMooR4K8bSBd+v6WOD2GQoCjvbN7bAhINo1Ods019s1s2Xjy2FrfqS89wGycbr2/qb
         MRoee5QYCYNW/ka400uOf15MKY+0l6Hus4nN15/+DGoVTY8XW6KV6Q0d3ugmayTnCQQW
         00Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738639733; x=1739244533;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ypnXRpVd7BRYU9e6tSX+xvv2lBSXpI+Wfpw7I5WJkzk=;
        b=N0OwLvXihPs89LUAyjbBWuf+RMd40EnxgMqTdvisyqmrmgpkDFAuy68WSrXYv3V1/M
         S6f5RIs0HoiHxenMgIARLJ5asCgcxs8tvsn9LJTw5ezeWZW8QUg2H7Q3FNU6hBb7qzjg
         6IP4iSYZT/lqh/H+woXFxLSTTOdCM5lwgeXVzSbqgZLgIgEHUyrAbsArnLnqK0JBYZMH
         6KZm0O/HO3gFKlkaZf/lMVYPXTMH9OCAWjD0I4gZEeZMZ3PxqST2eQ/mENb+ICb5knEk
         7VpU4ExTqyz73Ng5MfH6hIViJn2C9Hc3LEmEl1t8I/BE2GrgNoEbkwyJGaEMeM7J0KNY
         vNSA==
X-Forwarded-Encrypted: i=1; AJvYcCXLYhFUtGdJ/gD1T3eqPF5TZbjc5T6KeTwkZQZeRoUUG6GSw1wWyUP/ncJbID4AWbft6PrpYMo/C83JJ2Tu2cLyZuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHrdC8NgKZvvZ+cZ2hEBq3G/PauprUU4nHfYNY5uYfQ9qyBBea
	7UCwAzrKyEQiLnKtG6NhlJaVT6GqCFYxRXO/EWdlTXXCov3W6zmM/WcO/dUVluOHaKr1M4n9uWT
	uU4oyh2+RL3fL8DXmtBu41ypVq3p408vuqOjx1JeMZ7jicu4nh+kpvs4=
X-Gm-Gg: ASbGncszlnJ3SONUIXaxy4NGzNnzWK3WNIUyeOpjLpUJxAIfF/f67WyhV2O4ND9rRTD
	DXHJAETAlKYwYWVUimOFzIiwYTrIsannyE97LtCq+ZIGBLgGd0RNzAIkIILaWDH0AzxXGpl26eu
	yCYyleb6X4FXBec74zRBdLx1Co4A==
X-Google-Smtp-Source: AGHT+IG5bOEDDHBdfJysE32rv2Imzn60PeJoxF/B9tX2984Ezu+5ZzfbWrfZIq59LG6nkA3gIiWC1N23lnlu/1Qr4wg=
X-Received: by 2002:ac8:5993:0:b0:466:9738:22de with SMTP id
 d75a77b69052e-46fd0b68779mr367277781cf.41.1738639733200; Mon, 03 Feb 2025
 19:28:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131225837.972218232@goodmis.org> <20250131225942.365475324@goodmis.org>
 <20250201115906.GB8256@noisy.programming.kicks-ass.net> <F30E23B6-7452-46F9-BF53-48799AE02F75@goodmis.org>
 <20250201181129.GA34937@noisy.programming.kicks-ass.net> <20250201180617.491ce087@batman.local.home>
 <20250203084306.GC505@noisy.programming.kicks-ass.net> <20250203114537.6a30c7c0@gandalf.local.home>
In-Reply-To: <20250203114537.6a30c7c0@gandalf.local.home>
From: Suleiman Souhlal <suleiman@google.com>
Date: Tue, 4 Feb 2025 12:28:41 +0900
X-Gm-Features: AWEUYZmgt56g4D3b3bmbMMZ61mu-kUiNaRXzg0GoHJpisOtcyPReyq-Z10vSKxg
Message-ID: <CABCjUKA2w9Xip2QDjMRDCWnvmZc52SWbn74-57q52gmpXcT+EA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Ankur Arora <ankur.a.arora@oracle.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm@kvack.org, x86@kernel.org, akpm@linux-foundation.org, 
	luto@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, willy@infradead.org, 
	mgorman@suse.de, jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, 
	Vineeth Pillai <vineethrp@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Clark Williams <clark.williams@gmail.com>, 
	bigeasy@linutronix.de, daniel.wagner@suse.com, joseph.salisbury@oracle.com, 
	broonie@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 4, 2025 at 1:45=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Mon, 3 Feb 2025 09:43:06 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > Lazy is not the default, nor even the recommended preemption method at
> > this time.
>
> That's OK. If it is considered to be the default in the future, this can
> wait.
>
> >
> > Lazy will not ever be the only preemption method, full isn't going
> > anywhere.
>
> That's fine too, as full preemption has the same issue of preempting
> kernel mutexes. Full preemption is for something that likely doesn't want
> this feature anyway.
>
> >
> > Lazy only applies to fair (and whatever bpf things end up using
> > resched_curr_lazy()).
>
> Is that a problem? User spin locks for RT tasks are very dangerous. If an
> RT task preempts the owner that is of lower priority, it can cause a
> deadlock (if the two tasks are pinned to the same CPU). Which BTW,
> Sebastion mentioned in the Stable RT meeting that glibc supplies a
> pthread_spin_lock() and doesn't have in the man page anything about this
> possible scenario.
>
> >
> > Lazy works on tick granularity, which is variable per the HZ config, an=
d
> > way too long for any of this nonsense.
>
> Patch 2 changes that to do what you wrote the last time. It has a max wai=
t
> time of 50us.
>
> >
> > So by tying this to lazy, you get something that doesn't actually work
> > most of the time, and when it works, it has variable and bad behaviour.
>
> Um no. If we wait for lazy to become the default behavior, it will work
> most of the time. And when it does work, it has strict behavior of 50us.
>
> >
> > So yeah, crap.
>
> As your rationale was not correct, I will disagree with this being crap.
>
>
> >
> > This really isn't difficult to understand, and I've told you this
> > before.
>
> And I listened to what you told me before. Patch 2 implements the 50us ma=
x
> that you suggested. I separated it out because it made the code simpler t=
o
> understand and debug. The change log even mentioned:
>
>      For the moment, it lets it run for one more tick (which will be
>      changed later).
>
> That "changed later" is the second patch in this series.
>
> With the "this can wait until lazy is default", is because we have an
> "upstream first" policy. As long as there is some buy-in to the changes, =
we
> can go ahead and implement it on our devices. We do not have to wait for =
it
> to be accepted. But if there's a strong NAK to the idea, it is much harde=
r
> to get it implemented internally.

Can you explain why this approach requires PREEMPT_LAZY?

Could  exit_to_user_mode_loop() be changed to something like the
following (with maybe some provision to only do it once)?

if ((ti_work & _TIF_NEED_RESCHED) && !rseq_delay_resched())
    schedule();

I suppose there would also need to be some additional changes to make
sure full preemption also doesn't preempt, maybe in
preempt_schedule*().

-- Suleiman
