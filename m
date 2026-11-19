Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116522;
	b=jNgX1OIXefE0BuncQhVHgMzgEmxhVKFE9Hrpz7lG+6somL7BnVsn4NeMMPTnS72Ps8x8
	 VNJVlXegYbNkd5WuiXKi9IeknWdc7U5F4XqfuyrygRnskCCv8S0egFhpSNkC1dyBSkW0C
	 OgQDIhotKOUMzuS+PoJJct6SO7r/tNsczoiqsXekWoz7ZQuGd/gO5yKZrQijOrNlyjKaM
	 JATm7BI/ilzr78eJlDMvJjAnEOn+YUAS5c4pbMfGNLztKN1DbgNo8Pz4mCNEZMKi+LFLj
	 U5C6zhuGPCRH0Fc3zCjeEcLVa6kXlTln/QOtaIhgNOy6qnBf+NN64tLRhGWrGUp5ayw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116522;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=daCieWNeyyAkEEfSGL+gig14C8b2lK6bD4Sqxa/vxJ8=;
	b=v8vyLIK1xXAxNKVmwGdL1ny7ToE7WHuo/Z6IBaLSSrUhHgwFOiJfIKL6ET7RnDK3gfDh
	 nsbBLF0DT5pZqxH08pCloGumFipN8UuZmSoUuqJUPVwZKjK41MIML53PGqFgWJGZ8nLf1
	 XHSGwKDPIWA3YvL9ljLQsS2J5LInULELeMKccaSrW9BiS7m4BWsOVjzUC71G4+xBeARrj
	 0ulWklXsgWdr1yKZs5zpOdVW9akyydMRGaGX/DjV488uDQHucSULFYXmxrDmc52YSbW8h
	 DuTAfUonw2byzMBMltdViNfISmK2rO7ma6B2O06/OUJqvbmeoyzpwA4cdVGUd5xN1eQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="tu20Gqk/";
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22A4606A320
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 19:28:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E22A4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=tu20Gqk/
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-4a9be758734so45551f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 11:28:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795116520; x=1795721320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=daCieWNeyyAkEEfSGL+gig14C8b2lK6bD4Sqxa/vxJ8=;
        b=tu20Gqk/R+74eslqU7J+Qfe6fCPgO4z10zl9W/g+ahjktmWwy2JW7Pyk5DMtk7Npri
         DWK9YC+vyF0laiaM1V8JE130P3Pqean1axFhXx+ax8wiPIS8RTV2CI9DzjfJpEtsZS9i
         395vPURZPnd/woNmWSQGqV1wsOaaS0EvS07d6VsHDfCXlJIFEcJeHbMBg+1mGEeyAP9J
         9jEn4aCTbjergCG7KG8jEJP/Bc6R4SurYMYyhWGcjp/uKMxa57LL3Xh0jIct8EWFkklv
         w7xXc2qeAuPOJWrEowkLN7t9bplc32MaJzEPItjHzhJgE0XGCB24Rv04zi/6it5NEALW
         oY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795116520; x=1795721320;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=daCieWNeyyAkEEfSGL+gig14C8b2lK6bD4Sqxa/vxJ8=;
        b=tSrtjTo8VQbAr0y0Syx485OYdlwyP+RkrgcY4r2W9DmaC8Qr808RoDKrzJJrq8Ihk+
         ZLbyovQi0XVPqcctsMsKBN5R2Nvi6O3eh63j5BUkLoVblDYLGVNhZsGtFdbVCjHvVtOe
         qIEC2B9dvnMutmRm2rDUIiUAlLL/eA41/+RUWw+XvCqc8A9GF5CsxrAqTGC3Iwf6fiNm
         sEj6oBQiEkUB7eMOEkNlN5Tru7tgvCVlT+JqfOVT1mwM1YW4I1F1lsqC55p567ST1neQ
         GfwkzKMr296TcSQiXiwc7w31PSYC2zacOOBSzLxrpxQXRqVjp2IeD5Pk2SqIER/k4jr+
         4BeQ==
X-Forwarded-Encrypted: i=1; AL+hErEsjPth/ygcwyHFb6dMCWOLzBw8+ShH7Gl2hdK4l3/WVlE0WT+p67MEeBLYy3KZmN1dOKmLhOORHrOIQpSEui2VCIU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zSRxFYIpAZYna0hSjQ88ITJaLQNZ6fyRKGpb+sDob0/cNjREp
	MDNXsAEvDz8/PrmTDafO42hBMrpG2S1IwdDq22jKKhn/6W17g9Sj24m2
X-Gm-Gg: AZFdTZfMs/4G74qO6zpeiSjzLPP1QWJ6MGI1sDiwaSIA3oFkgh9UT8qoWXbYCxRAvHA
	o8nOhO2mREmSjArha9+89E+wZimm71xlyEsdf0MUbCzsMqC0xP/3NhU8d8OQDgkKLFPU0Mm+CNN
	zwxc7TnFs8s/B/ljkB58Qmn6tlvW4DBMB3mcD2mJWLraKrPsALLTQi5hgnAsoJkOsy6ppidjaSb
	WygqeAqjVWgSsyzzciUySWWlVJluAMWwWFhG/b1X8RpGTwKXzZavlGnWAb/eT2P25ULsBDg/KGR
	+2tXKcGTPb8tcVy4AVmbEI3Kzd8+oeCp3tFbljXM1o3HCPzXDbhFjs/Q5eCH0le4F6nraAR7oBy
	tmBV78F/yfzU1NUah1bQw1OALMg8m+pyvwARaIkSdWWnfWXN6VNtMFMaEC/E7Edrvy2abTmxacS
	TXI/fromsunUC0WairGAmfxZR5qYjxJ7FF+Bcz5/CJAYczf7xttiQx2EiIFk3jwUYyH9WgJZw/U
	woJYSJC7z/4c6gWABimZGsFOrLFg++bcu2iiaiRD3jK6JlZbXiHDSlmqWoRGVNuuyyHFJ9a3jQd
	DUIiPcAQRlzk6bbPB0TqM94t2Si6WUfmpUPhUds=
X-Received: by 2002:a05:6000:4b1e:b0:48c:7143:610c with SMTP id ffacd0b85a97d-4abb2910b8fmr809897f8f.36.1795116520113;
        Thu, 19 Nov 2026 11:28:40 -0800 (PST)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a67f204sm1477581f8f.21.2026.11.19.11.28.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 11:28:39 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 19 Nov 2026 20:28:37 +0100
To: bot+bpf-ci@kernel.org
Cc: mike.bazov@gmail.com, song@kernel.org, ihor.solodrai@linux.dev,
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
	yonghong.song@linux.dev, emil@etsalapatis.com, kpsingh@kernel.org,
	matt@bobrowski.net, rostedt@goodmis.org, mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	martin.lau@kernel.org, mason@kernel.org
Subject: Re: [PATCH bpf-next v2] bpf: Use an on-stack pt_regs in the raw
 tracepoint helpers
Message-ID: <av9N5RqhdRhW1fVh@krava>
References: <20261119-bpf-raw-tp-regs-preempt-v2-1-e1e1b90857d6@gmail.com>
 <77d978d7f9343e907651b4d4d81ec1c1405dce42f75e33b169f729f208029fcc@mail.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77d978d7f9343e907651b4d4d81ec1c1405dce42f75e33b169f729f208029fcc@mail.kernel.org>

On Thu, Nov 19, 2026 at 11:14:51AM +0000, bot+bpf-ci@kernel.org wrote:
> > bpf: Use an on-stack pt_regs in the raw tracepoint helpers
> 
> TL;DR: Without the per-CPU slots, nested raw_tp/fentry programs may hit the
> WARN_ON_ONCE in bpf_perf_event_output() (panic with panic_on_warn); the commit
> message's claim of no more -EBUSY also looks wrong.
> 
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> 
> [ ... ]
> 
> >  BPF_CALL_5(bpf_perf_event_output_raw_tp, struct bpf_raw_tracepoint_args *, args,
> >  	   struct bpf_map *, map, u64, flags, void *, data, u64, size)
> >  {
> > -	struct pt_regs *regs = get_bpf_raw_tp_regs();
> > -	int ret;
> > -
> > -	if (IS_ERR(regs))
> > -		return PTR_ERR(regs);
> > -
> > -	perf_fetch_caller_regs(regs);
> > -	ret = ____bpf_perf_event_output(regs, map, flags, data, size);
> > +	struct pt_regs regs = {};
> >  
> > -	put_bpf_raw_tp_regs();
> > -	return ret;
> > +	perf_fetch_caller_regs(&regs);
> > +	return ____bpf_perf_event_output(&regs, map, flags, data, size);
> >  }
> 
> Can this reach the WARN_ON_ONCE() in bpf_perf_event_output() using only
> raw_tp and tracing programs?
> 
> bpf_perf_event_output() still has a three-level limit:
> 
>     nest_level = this_cpu_inc_return(bpf_trace_nest_level);
> 
>     if (WARN_ON_ONCE(nest_level > ARRAY_SIZE(sds->sds))) {
>         err = -EBUSY;
>         goto out;
>     }
> 
> Before this patch, every raw_tp/tracing caller first took a
> bpf_raw_tp_nest_level slot, so a fourth nested caller got a silent -EBUSY
> from get_bpf_raw_tp_regs().  That function's WARN_ON_ONCE was removed by
> commit 3880cdbed1c4 ("bpf: Fix WARN() in get_bpf_raw_tp_regs") after a
> syzbot report of this kind of nesting.  The WARN above could only fire if a
> kprobe, tracepoint or perf_event program was also in the chain.
> 
> With the slots gone, a chain of only raw_tp/tracing programs can get there.
> For example, a raw_tp program A calls bpf_perf_event_output() (nest 1),
> and its __bpf_perf_event_output() calls perf_event_output().  Fentry
> programs B, C and D attached to perf_event_output() also call
> bpf_perf_event_output(), and each is let through once by its own
> prog->active check, so they run at nest 2, 3 and 4.  At D the WARN_ON_ONCE
> fires, and with panic_on_warn the kernel panics.  The same depth is
> reachable across task, softirq, hardirq and NMI context.
> 
> This also seems to contradict the commit message:
> 
> > the helpers no longer fail with -EBUSY when nested more than three deep
> 
> For bpf_perf_event_output() the three-level limit remains, coming from
> bpf_trace_sds and bpf_trace_nest_level.
> 
> Should the WARN_ON_ONCE in bpf_perf_event_output() be dropped, as
> 3880cdbed1c4 did for get_bpf_raw_tp_regs(), and should the commit message
> say that bpf_perf_event_output() keeps its three-level limit?

+1 we can now nest more than 3 times, hitting that limit shouldn't warn

jirka

> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44508926690

