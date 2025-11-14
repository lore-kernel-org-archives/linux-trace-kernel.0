Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415C834D4C8
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 18:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763143967; cv=none; b=ko4SJ1JFQnRUsMx5WGV7nrAguv/Uq/wDBcV7sXmW0gnWqh0kdp8sYqJY3ihgX18atHrF7DlGRl+fkA56ladpA7n5f4o81ApygiugijZQXjM43hKHhNGFGceTE3fUgxKzq5hwHjUGnrozKjfJQnZ0uAgbRdvKQz5TZYJYvcQPAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763143967; c=relaxed/simple;
	bh=EQupp+04ELD6HQsXX6MzzyyC59DMMJpf+/oH4iZVPtI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKL1OvgCRB26wpOyVMfJ39IugRy7PmvrLhqCT2ToSHLOqN3W1PhtP7wteUgqYqG0g49wx6i/NlRY9k1xDBWCyaF++shCUAlvQSMENxdQjdbFrAta8HKSkPGuM19SVxPlQcc2EwvEy2pyZBGC0FE2Xa2QQq21PkJ/zSbB26sTeFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=brwiXc13; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="brwiXc13"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29852dafa7dso9815ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 10:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763143965; x=1763748765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DGQ3t09Vqky40RisUTfak9sVzJBgZBZXHsje53VwQQE=;
        b=brwiXc13kT4ft3t0fRj3eUdYR1X8iNF38Hl7JslrrRAmFCNdLxQecQ/M9+7vqmLyLm
         SYPLJZG2ZzAhFpwgnBosYP+J0uTwFfPz2igHtENnHOlcuSPT5Y5d9EkdJS8ZWCiz/usZ
         NTgznZYVO4DIjh2Fln458/CMBVQOCgOiR07XsOdeGqIVVn4sayYL11wTX0PulUtFH20P
         hBlxY6GpP7imw/ojkIaZigEvhn5tLIyaOxj/i8IcoEnp/Kl5CHA5ESxMCsZ+r1u7QbIa
         GwSp78xXsyhq7I3bXBoRF16Af9u52kh9ZhF/82ULzqultev9/ySQx6N7fju7iwTRABZI
         jbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763143965; x=1763748765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DGQ3t09Vqky40RisUTfak9sVzJBgZBZXHsje53VwQQE=;
        b=A1/JBFxSCmBvbWcd5FmqEdZ0qcpCKYg/oP+JaVBrKN5pCWidvmipROvMgl7YLFFedh
         tum8cDeYNf4m4on0nIy0BnzVgoc+R1P9T5Kf5nquy5J9SotPzrHcTzICrVIFYvMxX0Vw
         bQIgcQHEvmKVtTaNmw8e7YOJY9vqsy7SfEVoYp+ci9sObKpHfafFbWhu3NVcwcVj6fST
         UtmE9juPdiDxNAnWJ5glvpRO/AmytyEL8FyyAjEM0LGrIxCPhIYbpuC8lC6Eybvl60mZ
         V5AgzZn9r6fRsRrr59XvK+itPMEuRPPREmFpYpWyoif7VEZJ7b151JIUz6IHuVqoLYCh
         uoYA==
X-Forwarded-Encrypted: i=1; AJvYcCWL3D6boMCSu2Y/NA27018fPSq7ZDom9c3wO/aStcOQXWf6j3/rZhTxpJb+d70Jw89W6YX0AVjyD3KqLMOHqoGDZ6k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/ydKYYC0eTQLsX4Ly/8mgfzTkBdKJBX6wly7wXY82zuiu8TY
	zBn7nawTXAkkq6sPUPynHNcrVtUQESsq+gTse62aCCKL8Sr9GlC6T+gygAcCguZ3Ecp09b6Jg+R
	l7L6tJn+EvM8QtLTZGhW21/P4nLIi+1Bj00xfgwZJ
X-Gm-Gg: ASbGncs7P3XgnFZgo9iHRwOvR0E12VmfUqhHa6ublWXpsxuCPXAWBzCIEoPjG7ubz5z
	ytjlm6GXUsslTSrZuXzIZgduhZ5Bihtc9cv55Pr8hOorYCiTnSjt0nyOpRtShYd8K/jvJBCMk0d
	VtEdFNoroW6QgI+thV3w11nossBqtKFd93gOCUjN6B2w4a7TTYRXQefCanmZiZI6OJr/lTAAlka
	QI03AsVmWWMjqJohlY3hV74KEcX3LIPmv1MEzR5vVhdYO3p/pX1o3XCbIo4N6Avm1UK6p9VSQG3
	huSQq6NSwEurBjiyn/O8XF32
X-Google-Smtp-Source: AGHT+IHDTDwgoKmLeGkpy0Sf/1ZA31hWe2lctTrRIm2bk7mmJZBogd+fXeg7f70/HB+SavQtHbPE7f+h3XdZV5hiDsc=
X-Received: by 2002:a17:902:ea0e:b0:265:e66:6c10 with SMTP id
 d9443c01a7336-299c6a9873fmr36405ad.4.1763143965090; Fri, 14 Nov 2025 10:12:45
 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251114070018.160330-1-namhyung@kernel.org> <20251114070018.160330-4-namhyung@kernel.org>
 <CAP-5=fVEuYXw+P-+Z7bU7Z-+7dsHPPfABh5pdnPtfvH-23u4Qw@mail.gmail.com> <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com>
In-Reply-To: <CAP-5=fU33sEARn0tc1hSMahBVCvs0cy+Cu-J6+BG0Cm-nuwKnA@mail.gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Fri, 14 Nov 2025 10:12:34 -0800
X-Gm-Features: AWmQ_blmMIv0tlMTFyMW28bW9JAIo4EBPq5KJFNtE_1gspX1QPJ3s5vKmq9bH-A
Message-ID: <CAP-5=fVptEdzt363LpuZzzm=BJFFkB_xkOLW=x-2-TZa+cvS0g@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] perf record: Enable defer_callchain for user callchains
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, linux-perf-users@vger.kernel.org, 
	Steven Rostedt <rostedt@goodmis.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, Jens Remus <jremus@linux.ibm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 10:09=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Nov 14, 2025 at 9:59=E2=80=AFAM Ian Rogers <irogers@google.com> w=
rote:
> >
> > On Thu, Nov 13, 2025 at 11:01=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > And add the missing feature detection logic to clear the flag on old
> > > kernels.
> > >
> > >   $ perf record -g -vv true
> > >   ...
> > >   ------------------------------------------------------------
> > >   perf_event_attr:
> > >     type                             0 (PERF_TYPE_HARDWARE)
> > >     size                             136
> > >     config                           0 (PERF_COUNT_HW_CPU_CYCLES)
> > >     { sample_period, sample_freq }   4000
> > >     sample_type                      IP|TID|TIME|CALLCHAIN|PERIOD
> > >     read_format                      ID|LOST
> > >     disabled                         1
> > >     inherit                          1
> > >     mmap                             1
> > >     comm                             1
> > >     freq                             1
> > >     enable_on_exec                   1
> > >     task                             1
> > >     sample_id_all                    1
> > >     mmap2                            1
> > >     comm_exec                        1
> > >     ksymbol                          1
> > >     bpf_event                        1
> > >     defer_callchain                  1
> > >     defer_output                     1
> > >   ------------------------------------------------------------
> > >   sys_perf_event_open: pid 162755  cpu 0  group_fd -1  flags 0x8
> > >   sys_perf_event_open failed, error -22
> > >   switching off deferred callchain support
> > >
> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/evsel.c | 24 ++++++++++++++++++++++++
> > >  tools/perf/util/evsel.h |  1 +
> > >  2 files changed, 25 insertions(+)
> > >
> > > diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> > > index 244b3e44d090d413..f5652d00b457d096 100644
> > > --- a/tools/perf/util/evsel.c
> > > +++ b/tools/perf/util/evsel.c
> > > @@ -1061,6 +1061,14 @@ static void __evsel__config_callchain(struct e=
vsel *evsel, struct record_opts *o
> > >                 }
> > >         }
> > >
> > > +       if (param->record_mode =3D=3D CALLCHAIN_FP && !attr->exclude_=
callchain_user) {
> > > +               /*
> > > +                * Enable deferred callchains optimistically.  It'll =
be switched
> > > +                * off later if the kernel doesn't support it.
> > > +                */
> > > +               attr->defer_callchain =3D 1;
> > > +       }
> >
> > If a user has requested frame pointer call chains why would they want
> > deferred call chains? The point of deferral to my understanding is to
> > allow the paging in of debug data, but frame pointers don't need that
> > as the stack should be in the page cache.
> >
> > Is this being done for code coverage reasons so that deferral is known
> > to work for later addition of SFrames? In which case this should be an
> > opt-in not default behavior. When there is a record_mode of
> > CALLCHAIN_SFRAME then making deferral the default for that mode makes
> > sense, but not for frame pointers IMO.
>
> Just to be clear. I don't think the behavior of using frame pointers
> should change. Deferral has downsides, for example:
>
>   $ perf record -g -a sleep 1
>
> Without deferral kernel stack traces will contain both kernel and user
> traces. With deferral the user stack trace is only generated when the
> system call returns and so there is a chance for kernel stack traces
> to be missing their user part. An obvious behavioral change. I think
> for what you are doing here we can have an option something like:
>
>   $ perf record --call-graph fp-deferred -a sleep 1
>
> Which would need a man page update, etc. What is happening with the
> other call-graph modes and deferral? Could the option be something
> like `--call-graph fp,deferred` so that the option is a common one and
> say stack snapshots for dwarf be somehow improved?

Also, making deferral the norm will generate new perf events that
tools, other than perf, processing perf.data files will fail to
consume. So this change would break quite a lot of stuff, so it should
not just be made the default.

Thanks,
Ian

> Thanks,
> Ian
>
> > Thanks,
> > Ian
> >
> > > +
> > >         if (function) {
> > >                 pr_info("Disabling user space callchains for function=
 trace event.\n");
> > >                 attr->exclude_callchain_user =3D 1;
> > > @@ -1511,6 +1519,7 @@ void evsel__config(struct evsel *evsel, struct =
record_opts *opts,
> > >         attr->mmap2    =3D track && !perf_missing_features.mmap2;
> > >         attr->comm     =3D track;
> > >         attr->build_id =3D track && opts->build_id;
> > > +       attr->defer_output =3D track;
> > >
> > >         /*
> > >          * ksymbol is tracked separately with text poke because it ne=
eds to be
> > > @@ -2199,6 +2208,10 @@ static int __evsel__prepare_open(struct evsel =
*evsel, struct perf_cpu_map *cpus,
> > >
> > >  static void evsel__disable_missing_features(struct evsel *evsel)
> > >  {
> > > +       if (perf_missing_features.defer_callchain && evsel->core.attr=
.defer_callchain)
> > > +               evsel->core.attr.defer_callchain =3D 0;
> > > +       if (perf_missing_features.defer_callchain && evsel->core.attr=
.defer_output)
> > > +               evsel->core.attr.defer_output =3D 0;
> > >         if (perf_missing_features.inherit_sample_read && evsel->core.=
attr.inherit &&
> > >             (evsel->core.attr.sample_type & PERF_SAMPLE_READ))
> > >                 evsel->core.attr.inherit =3D 0;
> > > @@ -2473,6 +2486,13 @@ static bool evsel__detect_missing_features(str=
uct evsel *evsel, struct perf_cpu
> > >
> > >         /* Please add new feature detection here. */
> > >
> > > +       attr.defer_callchain =3D true;
> > > +       if (has_attr_feature(&attr, /*flags=3D*/0))
> > > +               goto found;
> > > +       perf_missing_features.defer_callchain =3D true;
> > > +       pr_debug2("switching off deferred callchain support\n");
> > > +       attr.defer_callchain =3D false;
> > > +
> > >         attr.inherit =3D true;
> > >         attr.sample_type =3D PERF_SAMPLE_READ | PERF_SAMPLE_TID;
> > >         if (has_attr_feature(&attr, /*flags=3D*/0))
> > > @@ -2584,6 +2604,10 @@ static bool evsel__detect_missing_features(str=
uct evsel *evsel, struct perf_cpu
> > >         errno =3D old_errno;
> > >
> > >  check:
> > > +       if ((evsel->core.attr.defer_callchain || evsel->core.attr.def=
er_output) &&
> > > +           perf_missing_features.defer_callchain)
> > > +               return true;
> > > +
> > >         if (evsel->core.attr.inherit &&
> > >             (evsel->core.attr.sample_type & PERF_SAMPLE_READ) &&
> > >             perf_missing_features.inherit_sample_read)
> > > diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
> > > index 3ae4ac8f9a37e009..a08130ff2e47a887 100644
> > > --- a/tools/perf/util/evsel.h
> > > +++ b/tools/perf/util/evsel.h
> > > @@ -221,6 +221,7 @@ struct perf_missing_features {
> > >         bool branch_counters;
> > >         bool aux_action;
> > >         bool inherit_sample_read;
> > > +       bool defer_callchain;
> > >  };
> > >
> > >  extern struct perf_missing_features perf_missing_features;
> > > --
> > > 2.52.0.rc1.455.g30608eb744-goog
> > >
> > >
