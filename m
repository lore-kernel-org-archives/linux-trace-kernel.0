Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F888F6D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Apr 2024 04:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712897558; cv=none; b=nq1FVFB2nc30noYwrXygMEBOGggvPrEN9BR23SiQYFNPrskWZPAHTZllEPVUf7SA3d0gmRMkSO62yd+z5yF7chVunjk2wHzZZ3axteXuhOnOLa/0woLKuVrWgedaDvldebFe4E0GwnWSm74efNGqjHtvvEEeObF4dLvVM5ghX08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712897558; c=relaxed/simple;
	bh=EHTXQfExvEKClzZc8qu7/rp3jXAcbV21sDzScgXNDME=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AFM+Nrilgi65J1c2150KFKcy2tG+ToIGBYK+X/Jap2VpUR8XlsDO4ZXel11R5f6zXbkqggBUEpJhW+j01W9q1eA34taJJLoPSqOKZD00p75z7m4s/4JOJY9Gcvm2dG/gmacyCE0QuFKCHq0G8LIelC573T1+dqkhpZL3kgjjj0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=C/XYVGUJ; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C/XYVGUJ"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-36a3a4c9d11so56205ab.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Apr 2024 21:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712897556; x=1713502356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j1gNz4dak4ArAyqdrT+Hy711rFqRI2e21Pd9/Cyi2Yc=;
        b=C/XYVGUJpwlRK1UHQj2FeSRw+PyCx1jVsMRi31Sn31r5Q1em9N+Dc6D2HLO8P9vZqQ
         3kDfeK1ZKOW4trHWAcx+beeC/uPJjUAbHBVVVIF6FSVpkzMn7N+DTfaF52ow/VCOQooW
         YhluwbBd8QKKSOqT/ualeEDxmadNcbXQ/dxYy3Y8Ij1qQozxo9+pf6xbiZyrFCsDwhrM
         z92sBDRgc0xi54QUWtRksUuhHyZKIEuZCU3uz2uRlbL+c7AtvxJet+psYKre6SyeVLsR
         7cQJMlw95kNZgr4swZEld1XshksSb8OKdbtAzXImdhNpnZus7TXm1tXxHYTBo6veTk/u
         qJZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712897556; x=1713502356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1gNz4dak4ArAyqdrT+Hy711rFqRI2e21Pd9/Cyi2Yc=;
        b=K5QdKZcGTex3Ln9wGjlNYiQvkspWDjh+t/+DxX/WqWsMyaV7JnL3j3UTbSJWps+bH/
         kIo38JxYvpLip9cJeo6am5pd1yajJbKY3oV1PLtwZBvT1T4s/4V6zhsEDeC132P1y/2V
         /piWmd/UPU6ZnRr76uKM54Tb6EGBZzewUujypqbW2QwsqcT1Sx8XPHL6lPw7pG9V2kL2
         nElgcq0v28nthCJZYHGC1+2BusRwnvX5vIa7xNNRy8HAG9zL0UvCcGeJ+oa/P4TIZdR3
         sY7sy9RdKf3NWCpXWQbtiWDsHaSPFpt/07nxd1MJRWuw6j+Zy47Nx1KUbDsaSVJD8VfV
         nPeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjvYdeWbLljmZC6y7h5pOOZ1BU48PbMl3miH8l02pNrTbPBDspeUS2z3d8RgFE5F/v/kI0fdwzZqZW2ukYejlUOn+E1ChGomtExJ18lxO299iV
X-Gm-Message-State: AOJu0Yxr23u2dTx26Qo6ApHP2Ol/pmMQlGVnMVhaEO6CyrJgZuFSREMe
	vGFb4/4y3PB+e9lzLB2dTDotJjVaxhdBLI3QlqemNEB9LlCsgqnycZZ7VND4hdFx7ccBN1T9MTS
	2Ev5BIjC3R3iVyUIidsZ2Ei5Tp1urdJY/x2Sd
X-Google-Smtp-Source: AGHT+IEPrdVc7vXlAwil+5Bi+DuQH+p49bvYaKFSFZiaEuf5w0/Tt/Gam+hGBFCE+dTy+hn9yDx/6J24VWxGhGeGmxQ=
X-Received: by 2002:a92:c8cd:0:b0:36a:2978:7cc1 with SMTP id
 c13-20020a92c8cd000000b0036a29787cc1mr139455ilq.12.1712897556330; Thu, 11 Apr
 2024 21:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240412001732.475-1-beaub@linux.microsoft.com>
In-Reply-To: <20240412001732.475-1-beaub@linux.microsoft.com>
From: Ian Rogers <irogers@google.com>
Date: Thu, 11 Apr 2024 21:52:22 -0700
Message-ID: <CAP-5=fVVQ5RGqEQo596to_3BYZ6vNFC_DR1nnunH_-Bb6bdpVg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/4] perf: Correlating user process data to samples
To: Beau Belgrave <beaub@linux.microsoft.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, primiano@google.com, aahringo@redhat.com, 
	dcook@linux.microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 5:17=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> In the Open Telemetry profiling SIG [1], we are trying to find a way to
> grab a tracing association quickly on a per-sample basis. The team at
> Elastic has a bespoke way to do this [2], however, I'd like to see a
> more general way to achieve this. The folks I've been talking with seem
> open to the idea of just having a TLS value for this we could capture

Presumably TLS =3D=3D Thread Local Storage.

> upon each sample. We could then just state, Open Telemetry SDKs should
> have a TLS value for span correlation. However, we need a way to sample
> the TLS or other value(s) when a sampling event is generated. This is
> supported today on Windows via EventActivityIdControl() [3]. Since
> Open Telemetry works on both Windows and Linux, ideally we can do
> something as efficient for Linux based workloads.
>
> This series is to explore how it would be best possible to collect
> supporting data from a user process when a profile sample is collected.
> Having a value stored in TLS makes a lot of sense for this however
> there are other ways to explore. Whatever is chosen, kernel samples
> taken in process context should be able to get this supporting data.
> In these patches on X64 the fsbase and gsbase are used for this.
>
> An option to explore suggested by Mathieu Desnoyers is to utilize rseq
> for processes to register a value location that can be included when
> profiling if desired. This would allow a tighter contract between user
> processes and a profiler.  It would allow better labeling/categorizing
> the correlation values.

It is hard to understand this idea. Are you saying stash a cookie in
TLS for samples to capture to indicate an activity? Restartable
sequences are about preemption on a CPU not of a thread, so at least
my intuition is that they feel different. You could stash information
like this today by changing the thread name which generates comm
events. I've wondered about having similar information in some form of
reserved for profiling stack slot, for example, to stash a pointer to
the name of a function being interpreted. Snapshotting all of a stack
is bad performance wise and for security. A stack slot would be able
to deal with nesting.

> An idea flow would look like this:
> User Task               Profile
> do_work();              sample() -> IP + No activity
> ...
> set_activity(123);
> ...
> do_work();              sample() -> IP + activity (123)
> ...
> set_activity(124);
> ...
> do_work();              sample() -> IP + activity (124)
>
> Ideally, the set_activity() method would not be a syscall. It needs to
> be very cheap as this should not bottleneck work. Ideally this is just
> a memcpy of 16-20 bytes as it is on Windows via EventActivityIdControl()
> using EVENT_ACTIVITY_CTRL_SET_ID.
>
> For those not aware, Open Telemetry allows collecting data from multiple
> machines and show where time was spent. The tracing context is already
> available for logs, but not for profiling samples. The idea is to show
> where slowdowns occur and have profile samples to explain why they
> slowed down. This must be possible without having to track context
> switches to do this correlation. This is because the profiling rates
> are typically 20hz - 1Khz, while the context switching rates are much
> higher. We do not want to have to consume high context switch rates
> just to know a correlation for a 20hz signal. Often these 20hz signals
> are always enabled in some environments.
>
> Regardless if TLS, rseq, or other source is used I believe we will need
> a way for perf_events to include it within a sample. The changes in this
> series show how it could be done with TLS. There is some factoring work
> under perf to make it easier to add more dump types using the existing
> ABI. This is mostly to make the patches clearer, certainly the refactor
> parts could get dropped and we could have duplicated/specialized paths.

fs and gs may be used for more than just the C runtime's TLS. For
example, they may be used by emulators or managed runtimes. I'm not
clear why this specific case couldn't be handled through BPF.

Thanks,
Ian

> 1. https://opentelemetry.io/blog/2024/profiling/
> 2. https://www.elastic.co/blog/continuous-profiling-distributed-tracing-c=
orrelation
> 3. https://learn.microsoft.com/en-us/windows/win32/api/evntprov/nf-evntpr=
ov-eventactivityidcontrol
>
> Beau Belgrave (4):
>   perf/core: Introduce perf_prepare_dump_data()
>   perf: Introduce PERF_SAMPLE_TLS_USER sample type
>   perf/core: Factor perf_output_sample_udump()
>   perf/x86/core: Add tls dump support
>
>  arch/Kconfig                      |   7 ++
>  arch/x86/Kconfig                  |   1 +
>  arch/x86/events/core.c            |  14 +++
>  arch/x86/include/asm/perf_event.h |   5 +
>  include/linux/perf_event.h        |   7 ++
>  include/uapi/linux/perf_event.h   |   5 +-
>  kernel/events/core.c              | 166 +++++++++++++++++++++++-------
>  kernel/events/internal.h          |  16 +++
>  8 files changed, 180 insertions(+), 41 deletions(-)
>
>
> base-commit: fec50db7033ea478773b159e0e2efb135270e3b7
> --
> 2.34.1
>
