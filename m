Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F8522F386
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 05:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763616587; cv=none; b=hVrowyyIod7EDVUHtCWOUq3RstrF8waaFfINYcbPXMTAji7FfeEPZ7BUDMS5wDeNZyjf41xUI5ddiZ1YIvxKCgIhUVnncFuMuCeHAoeOHTpi9QFxc4F/H0XIBSoUXzxONw+Rk4tGvHfs5UZ29RQUnF5oRHVIy0meCRnEdQWpuJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763616587; c=relaxed/simple;
	bh=YHDLsIpTmt7VE1wNd2xoG3QIZdjR0RBXPFb12Wq7qss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BMRw0PCh3wdjhvQe6Uflv7xZz0TA2HCIXbtneXkqjj5FsuCJe9v/ecfqQuVLiCgHF8A9jwmWJKzDujflNF2b7sZYSNg1w0VFR6WJvAnTFWXGsbcnCTNcD2a8UsZ4dd8mRF9mYxbOBufca01zLjC1OsZ0S3Ld3/eqA/68CgYJRJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j29EWWsj; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j29EWWsj"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-297e13bf404so113875ad.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Nov 2025 21:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763616585; x=1764221385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TW5aVHVpnngD0pwo3SfGO76Ix5ez8063opvM3M5CLFE=;
        b=j29EWWsjujLYxVbGHygSzxD7MuKvb4kbn/rYHADfmB7OG34y5s33+zj9CG0+C/mGun
         bFg5FP4QlVXcN15JsbClrTVmdnMiylwzvqaSD9U0yJ86ESKKDiJDPyvp3F6jS7dz1XFa
         gvIskBpNzjjjUsM5OdyCMP0Rl7UA7Fd4zpo5jDtQVfmvL+ib4/CNYjkWFG9144jCegFD
         MQD2rd/+dGyh7or0tmjQgQCaN/zGRMsfMF7WxeY90j/IgnPrhKf48TMZxAxr68GHCB2v
         iiWgDb6feD5nPciBoqr++mYQB2VxVe3UaZRm4ZJJonwWWqXynXYo47m30Xa92o0xAE/V
         EQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763616585; x=1764221385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TW5aVHVpnngD0pwo3SfGO76Ix5ez8063opvM3M5CLFE=;
        b=jPrF0k2VSAFbGuoO0u/IllkSjpm8gAEX55Nmix3FXAxx48NlOBNDhe3Dx6Jtn6Hkz1
         8WhbVNeDpghCDSWNVIV4xe/jCx2m+6o33jozB7q2A1tiAutVK7V1MvTEmysAwS84jup0
         1fv3ncUXFNdDOCNZOrwR8MZzgIdB+2sIH0IpII4BYXUmtAPHdeMz1f2U/+DfJQexxUC0
         d5XmTLl4LdKma/lSuJ/85+51KwHrSfJztVrqTqvL2ckuxlu1rH7AHP9QmmsJUsMMyw6R
         Ys/pmGJ+XEcdvvgIWOxJ6eKuVXSy+gvqJqdewwlzszjBzcrmEfL2MoL2ZEDIi8doY8Zk
         UrrA==
X-Forwarded-Encrypted: i=1; AJvYcCUPbHtcyCt/EZDEh03+iPj3hQJGKMgtsAY3s92nlFRsWaebuU/ro4vqjzi9/q8tQlzjCv7BvKSHWbtIjrBtEKxQtvM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuD9D33C3Tct2U0YvuNB6EAWdbNU2PdMQqMc8X9tTg5bq5BH75
	y/X1EciAL/JZapXkZljWs09UfqyBs+MkVtpy6LVUQCIRS2sj72Opb10U3iNBnmb6CFLV5DBLXPG
	mR0aVVatkOfRtfOnTcHHMQ4hQaU5ht4+x290Qj21c
X-Gm-Gg: ASbGncunGISs9iuC3X7HPd7iE6KL3KbhwQYz+gy6BxbRJo9lT8vvca4dZb76zJy/RcS
	7EijUUV9ubBKftshxyQqYpp0QoiVhjKcvo0qJWyNUfXgEDA2cIJPhMzCHIaI/RCXg1B1Neeuf50
	hMfpuB9E+QTcXVl5cIg5PKHofA0C0bGyDo1bIQNUFLpj1/8loKVo29r9QoRnjzYIQqWfgjW6AzX
	pw2J1TXDg3XqQP5tGa2sAuD0zXug7jikQeIaajQjw42v1dVIWzumnFgujQQ0avxVvJBwde4
X-Google-Smtp-Source: AGHT+IFz21m1gvtJ+c4Oz5Xw91aFL1sfJL0YxVGA63lOLUkBDQShrn7qcWGtR3K/OnaWZwh4nUG1vbmcxYGLjIUUpt0=
X-Received: by 2002:a17:902:da83:b0:298:144f:b759 with SMTP id
 d9443c01a7336-29b5dc138e1mr1457515ad.9.1763616585298; Wed, 19 Nov 2025
 21:29:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120021046.94490-1-namhyung@kernel.org> <20251120021046.94490-7-namhyung@kernel.org>
In-Reply-To: <20251120021046.94490-7-namhyung@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 19 Nov 2025 21:29:34 -0800
X-Gm-Features: AWmQ_bniEbT9bZAsiC3VOQbMkfFcl3CbQa7pPIN-PoUwLJdoM4P-V4uu45KLj0Q
Message-ID: <CAP-5=fVZcmYgyRJVNbet9ZLjihAiXNy7D8cX+QqHe8EKqJ1qOQ@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] perf tools: Flush remaining samples w/o deferred callchains
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

On Wed, Nov 19, 2025 at 6:11=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> It's possible that some kernel samples don't have matching deferred
> callchain records when the profiling session was ended before the
> threads came back to userspace.  Let's flush the samples before
> finish the session.
>
> Also 32-bit systems can see partial mmap for the data.  In that case,
> deferred samples won't point to the correct data once the mapping moves
> to the next portion of the file.  Copy the original sample before it
> unmaps the current data.

I think it is simpler to always copy. We may have events from
synthesis, inject, .. and not the reader. Relying on callers to know
that someone made a copy of the event and to make a defensive copy on
their behalf just feels error prone.

In the python session API I need to deal with the lifetime of events.
Currently the events are copied:
https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-next.gi=
t/tree/tools/perf/util/python.c?h=3Dperf-tools-next#n507
and I'm doing this for session tool callbacks:
https://lore.kernel.org/lkml/20251029053413.355154-12-irogers@google.com/
I think it can be made lazier by knowing the tool callback can assume
the event and sample are valid. We can delay the copying of the
event/sample for if the pyevent has a reference count >1 and we're
returning out of the tool callback. Doing some kind of global
knowledge in the reader for maintaining the correctness of memory, I'm
just not clear on how to make it always work.

Thanks,
Ian

> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  tools/perf/util/session.c | 98 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 98 insertions(+)
>
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 2e777fd1bcf6707b..b781e01ddcb4876b 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1288,8 +1288,13 @@ static int evlist__deliver_sample(struct evlist *e=
vlist, const struct perf_tool
>  struct deferred_event {
>         struct list_head list;
>         union perf_event *event;
> +       bool allocated;
>  };
>
> +/*
> + * This is called when a deferred callchain record comes up.  Find all m=
atching
> + * samples, merge the callchains and process them.
> + */
>  static int evlist__deliver_deferred_samples(struct evlist *evlist,
>                                             const struct perf_tool *tool,
>                                             union  perf_event *event,
> @@ -1331,6 +1336,86 @@ static int evlist__deliver_deferred_samples(struct=
 evlist *evlist,
>                         free(orig_sample.callchain);
>
>                 list_del(&de->list);
> +               if (de->allocated)
> +                       free(de->event);
> +               free(de);
> +
> +               if (ret)
> +                       break;
> +       }
> +       return ret;
> +}
> +
> +/*
> + * This is called when the backing mmap is about to go away.  It needs t=
o save
> + * the original sample data until it finds the matching deferred callcha=
ins.
> + */
> +static void evlist__copy_deferred_samples(struct evlist *evlist,
> +                                         const struct perf_tool *tool,
> +                                         struct machine *machine)
> +{
> +       struct deferred_event *de, *tmp;
> +       struct evsel *evsel;
> +       int ret =3D 0;
> +
> +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> +               struct perf_sample sample;
> +               size_t sz =3D de->event->header.size;
> +               void *buf;
> +
> +               if (de->allocated)
> +                       continue;
> +
> +               buf =3D malloc(sz);
> +               if (buf) {
> +                       memcpy(buf, de->event, sz);
> +                       de->event =3D buf;
> +                       de->allocated =3D true;
> +                       continue;
> +               }
> +
> +               /* The allocation failed, flush the sample now */
> +               ret =3D evlist__parse_sample(evlist, de->event, &sample);
> +               if (ret =3D=3D 0) {
> +                       evsel =3D evlist__id2evsel(evlist, sample.id);
> +                       evlist__deliver_sample(evlist, tool, de->event,
> +                                              &sample, evsel, machine);
> +               }
> +
> +               list_del(&de->list);
> +               BUG_ON(de->allocated);
> +               free(de);
> +       }
> +}
> +
> +/*
> + * This is called at the end of the data processing for the session.  Fl=
ush the
> + * remaining samples as there's no hope for matching deferred callchains=
.
> + */
> +static int evlist__flush_deferred_samples(struct evlist *evlist,
> +                                         const struct perf_tool *tool,
> +                                         struct machine *machine)
> +{
> +       struct deferred_event *de, *tmp;
> +       struct evsel *evsel;
> +       int ret =3D 0;
> +
> +       list_for_each_entry_safe(de, tmp, &evlist->deferred_samples, list=
) {
> +               struct perf_sample sample;
> +
> +               ret =3D evlist__parse_sample(evlist, de->event, &sample);
> +               if (ret < 0) {
> +                       pr_err("failed to parse original sample\n");
> +                       break;
> +               }
> +
> +               evsel =3D evlist__id2evsel(evlist, sample.id);
> +               ret =3D evlist__deliver_sample(evlist, tool, de->event,
> +                                            &sample, evsel, machine);
> +
> +               list_del(&de->list);
> +               if (de->allocated)
> +                       free(de->event);
>                 free(de);
>
>                 if (ret)
> @@ -1374,6 +1459,7 @@ static int machines__deliver_event(struct machines =
*machines,
>                                 return -ENOMEM;
>
>                         de->event =3D event;
> +                       de->allocated =3D false;
>                         list_add_tail(&de->list, &evlist->deferred_sample=
s);
>                         return 0;
>                 }
> @@ -2218,6 +2304,8 @@ reader__mmap(struct reader *rd, struct perf_session=
 *session)
>         }
>
>         if (mmaps[rd->mmap_idx]) {
> +               evlist__copy_deferred_samples(session->evlist, session->t=
ool,
> +                                             &session->machines.host);
>                 munmap(mmaps[rd->mmap_idx], rd->mmap_size);
>                 mmaps[rd->mmap_idx] =3D NULL;
>         }
> @@ -2372,6 +2460,11 @@ static int __perf_session__process_events(struct p=
erf_session *session)
>         if (err)
>                 goto out_err;
>         err =3D auxtrace__flush_events(session, tool);
> +       if (err)
> +               goto out_err;
> +       err =3D evlist__flush_deferred_samples(session->evlist,
> +                                            session->tool,
> +                                            &session->machines.host);
>         if (err)
>                 goto out_err;
>         err =3D perf_session__flush_thread_stacks(session);
> @@ -2494,6 +2587,11 @@ static int __perf_session__process_dir_events(stru=
ct perf_session *session)
>         if (ret)
>                 goto out_err;
>
> +       ret =3D evlist__flush_deferred_samples(session->evlist, tool,
> +                                            &session->machines.host);
> +       if (ret)
> +               goto out_err;
> +
>         ret =3D perf_session__flush_thread_stacks(session);
>  out_err:
>         ui_progress__finish();
> --
> 2.52.0.rc1.455.g30608eb744-goog
>
