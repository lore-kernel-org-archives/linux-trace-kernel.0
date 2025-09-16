Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1735F2F9DB5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059539; cv=none; b=pAmZFwGiCDeoxNsQQYJ5feDaynaqYy0NrGQYmdlFtn+kIhN0CG/gi41tc/Bdkj4eTWt6ATKSIttjlwD8a0uVWnRPVp82ThtpN8+8+1isIGKw8J1MjPzMAzpjazmVYhe8wZAuda86Xy34OjfC8rkvvPPwBDXb0mMyjv7KS/+vX/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059539; c=relaxed/simple;
	bh=I7vgzpb4iQRotjVoiX/pLxoru+xY5k4ZR4ZCWGtLhqk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QFDIU+E50or0vJKfYKYWk/M+tgL7bc3Jo/Kor7PlYGYKsVUHjkHnBJ/fhgJOJeK0+ckxRcrMJ/FhPYazQw18sazZA43qA/kfKGWmoqPf/bgTERHQWXdGWE8ZE9z01WUxzgjTIqHeJxSKSvXPmoP39sbsHD/OPNMH2zvDGOoreKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5EvIdYK; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5EvIdYK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b04ba3de760so753627866b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758059535; x=1758664335; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HmHjJhcmqy1sBBEmVO7MB7cGRMGtnkst9/nnRmc5EGM=;
        b=T5EvIdYKM7xdM80hgROGpZCjWUgiJyj6DNTUADzcCLD4yLYcqmtXVTmvW3+7fpwF49
         /1RkICJtwQU2llZPTyAbZVkHRQ8uBP9DR6mL1qO10ss66D6YTTDTN7wGITa2Rhtvk2r7
         RK4hPqbl5KImlcQaDGEzLjpKVuhnM8ds/63Bbl0leLu8GWKGf/JQStWel3qZvP/RXvEk
         MGjP21F4XJiTJNFGacNlozYeVZqnyj5Hmn2FWTvfY/BiIPG/rcoMu7LtNXq4jQH9k0rs
         wclDdfnjRr9VItIOY3f1gv66UroRHmbwr4G+V6FYmuq02IftQEapEmpaVQ3GbMFYtYAg
         tqKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758059535; x=1758664335;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HmHjJhcmqy1sBBEmVO7MB7cGRMGtnkst9/nnRmc5EGM=;
        b=e2Pgun4K8pIWl2KbQ7x1vTO8WmMFMyia3sBVR+P2d75iZGKjkVlAQs67GLsr1zOegd
         o5D44uaxstKxgC18ajPYONnQTBlkCeWTqlEgHm41dIqEnOKJnLn+S/gzWDShZTtFpOat
         F/jyIrEQW8WVazPeqMGhxWYUryvMzYQBCldCIOGPLUP1DK/n0u8KPZ3YUC1O4DE0CUa5
         ttPdii7S+EVfIYM37tGbVMFmMxSUSpVm5IvpLG9MiQGYCNoAYHmrAJwtVX9YY28LPSi/
         5EUbGTkvQnVC+ocqhGqjS+D7dIxvKP+0+CURmsTDdgKz7Y6QHHRyt7gdmL6uPcQYQDKk
         sd5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSZvj4xcpHX/gLMM8AqMwLK/NtWWrcSjVCQiAeksvubJGE35hq23RHqsy0zBUIGPeeFEAMIlOoMXpGJIKSqydF85k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlR6/gDLDGyBebqE4Oc1U0J+Mvkk4jNNywipH3vfq7rPoyqAoi
	CfsC3eV1LgvWuOr4q6nDWWjyjw4coYg2j2uVzgqJ3KrhKe3ZttIGkjNw
X-Gm-Gg: ASbGncsC7dnwWarNfmVtPGLgr4iz1FY2Z+tRLJKpAmVMmU/36IGaXzd2KvSkEyeVbZo
	8BmUIj+MS0NEZ/pSb12jTPm7hWluqeWSohwdSyQNPRYrTld4gLQa9UtGmpobDovztH3CFsRIsYv
	Kd0A5XaAe2OaZG5iuHOKaGrxqJbjPq/2vDMnkHMinbGXeuEuA5tj258I9RFCTAE/8kZWrWEU63a
	35A85IZn9hrWgzpt2AaacpoqrRZbDPDiy+WiHQjfiHaWrtU7CH3btwyNO4RTiglr18aCdqFoMZy
	WdCWh+0cH8oa92S/V8fVLb1EIF9S8AFws6xnSXFbx5ZcarG82lq6gT0H7zAlskGB8VRVMWdQRSE
	/KlqvkIU8xUxYWj4mByjSFm/O5Zzy2VYXC75OdFQ=
X-Google-Smtp-Source: AGHT+IEEPGcRJK3rkvIfHaTSzEc1f2K/e0Z2Jggqlv4rhtrevVG/kWh6oUJyYLTrD+W1XABPwN8FRQ==
X-Received: by 2002:a17:906:dc89:b0:b12:3f5f:603b with SMTP id a640c23a62f3a-b1bb08685eamr3355066b.3.1758059535004;
        Tue, 16 Sep 2025 14:52:15 -0700 (PDT)
Received: from krava (89-40-234-69.wdsl.neomedia.it. [89.40.234.69])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07c6110c27sm1027530466b.66.2025.09.16.14.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:52:14 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 16 Sep 2025 23:52:11 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCHv3 perf/core 1/6] bpf: Allow uprobe program to change
 context registers
Message-ID: <aMncCwre1QwJTNcL@krava>
References: <20250909123857.315599-1-jolsa@kernel.org>
 <20250909123857.315599-2-jolsa@kernel.org>
 <CAEf4Bzbw0uvfNgUHQM9iG2YRtnVbgdh_GgFGy4Q7eQiPPJ==dA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzbw0uvfNgUHQM9iG2YRtnVbgdh_GgFGy4Q7eQiPPJ==dA@mail.gmail.com>

On Tue, Sep 09, 2025 at 12:41:36PM -0400, Andrii Nakryiko wrote:
> On Tue, Sep 9, 2025 at 8:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Currently uprobe (BPF_PROG_TYPE_KPROBE) program can't write to the
> > context registers data. While this makes sense for kprobe attachments,
> > for uprobe attachment it might make sense to be able to change user
> > space registers to alter application execution.
> >
> > Since uprobe and kprobe programs share the same type (BPF_PROG_TYPE_KPROBE),
> > we can't deny write access to context during the program load. We need
> > to check on it during program attachment to see if it's going to be
> > kprobe or uprobe.
> >
> > Storing the program's write attempt to context and checking on it
> > during the attachment.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h      | 1 +
> >  kernel/events/core.c     | 4 ++++
> >  kernel/trace/bpf_trace.c | 7 +++++--
> >  3 files changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index cc700925b802..404a30cde84e 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1619,6 +1619,7 @@ struct bpf_prog_aux {
> >         bool priv_stack_requested;
> >         bool changes_pkt_data;
> >         bool might_sleep;
> > +       bool kprobe_write_ctx;
> >         u64 prog_array_member_cnt; /* counts how many times as member of prog_array */
> >         struct mutex ext_mutex; /* mutex for is_extended and prog_array_member_cnt */
> >         struct bpf_arena *arena;
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 28de3baff792..c3f37b266fc4 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -11238,6 +11238,10 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
> >         if (prog->kprobe_override && !is_kprobe)
> >                 return -EINVAL;
> >
> > +       /* Writing to context allowed only for uprobes. */
> > +       if (prog->aux->kprobe_write_ctx && !is_uprobe)
> > +               return -EINVAL;
> > +
> >         if (is_tracepoint || is_syscall_tp) {
> >                 int off = trace_event_get_offsets(event->tp_event);
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 3ae52978cae6..dfb19e773afa 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -1521,8 +1521,6 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
> >  {
> >         if (off < 0 || off >= sizeof(struct pt_regs))
> >                 return false;
> > -       if (type != BPF_READ)
> > -               return false;
> >         if (off % size != 0)
> >                 return false;
> >         /*
> > @@ -1532,6 +1530,7 @@ static bool kprobe_prog_is_valid_access(int off, int size, enum bpf_access_type
> >         if (off + size > sizeof(struct pt_regs))
> >                 return false;
> >
> > +       prog->aux->kprobe_write_ctx |= type == BPF_WRITE;
> 
> nit: minor preference for
> 
> if (type == BPF_WRITE)
>     prog->aux->kprobe_write_ctx = true;

ok, will change

jirka

> 
> 
> >         return true;
> >  }
> >
> > @@ -2913,6 +2912,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
> >         if (!is_kprobe_multi(prog))
> >                 return -EINVAL;
> >
> > +       /* Writing to context is not allowed for kprobes. */
> > +       if (prog->aux->kprobe_write_ctx)
> > +               return -EINVAL;
> > +
> >         flags = attr->link_create.kprobe_multi.flags;
> >         if (flags & ~BPF_F_KPROBE_MULTI_RETURN)
> >                 return -EINVAL;
> > --
> > 2.51.0
> >
