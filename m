Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1C92DECBF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 22:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771365982; cv=none; b=pe56pp22DKJ06/GZacpls8kFwvIDmnwczJOYPw7OUvbmvE6LLFwhTbXvtkjBXiEryVzegQoc4r2CDbOXcXhYSDI8X1ZhCARMmUksrtNwdxS9aAhIRWW58eJ5pRT+VVsF2toSfWldasAkHvPefbe7ByCfRmBynf0OuCoB8/OkL1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771365982; c=relaxed/simple;
	bh=JCA1qMiCxzAtCoCeSQpdmAqjBSMrZ+OOI5+Ud6ZHzhk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/K7bDILfveQDZLovVxU5Nz4HtfQqqely+dywfKc4O/dMkSFuVq8lmpVrqrVlVBX/xitapp1KbHljZR78CdRjioWOwssmdLcaHZA1ZjDsLAPk7iMaS/OATU9IV4NYbAybWIhUVhGec1kb//MWnIMlp+G+lOgFl8dguHjKwCulbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoQiCOZg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoQiCOZg"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48069a48629so44037805e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Feb 2026 14:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771365980; x=1771970780; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BG5fQ+vUk3j5s5f+WiPxvgcgpfeiNq1iyqWWrYFDPi8=;
        b=RoQiCOZgjkwP+6jSu9A40TrbqYqwY5OMGGBMzTcnL06YMRl6eeGQMItULgEW9fPGjS
         nsvKlvnq0uNTWcz7CCbBsR2j5SEk0DB5OvS72d4blNIkvraOg3RMCP0h4rnqMafhw4GQ
         RTGAlIQ1tFUlt+DGLFvQMvHLYXaVtMudvyRGRvWlXmXr65Bqt4c77P2y9rp+M3fnSfLE
         ZxQIfq+1k9E6W66TOeFp+7dnBfp7y1CUwdqn9vvhFjdGuXT76ZKSqyo9KjLs/bpEpIhQ
         u3Ef3nNo1z4LhIFfj6Lz77S9aSuFm3WdILuD5LL8Rcq4bSXcSFKKrvTWBMfRJ6LFMw16
         Ezew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771365980; x=1771970780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BG5fQ+vUk3j5s5f+WiPxvgcgpfeiNq1iyqWWrYFDPi8=;
        b=Di5AtgKv/YQfmRzGPsfTkEQ7GkswdbbdQaKrrNXIDYLHPxEo81ehOQZpHmMeqmvFOi
         /+VR19hh8t9khdtT2dpgT+CU3Y+w69vK0qafctVoz3nvk9g9DPXoZSX6rCiZsxT/bwfP
         NZYOn/CgSV4y1RU1OIWWXlEtBMAtNg20Bn6J4DGxEdHY0oLZjOQldPtqw86fQ5wmOBO8
         LS+U3QQh6ivsLQ04aHKGSmQpUs30cMTIZGDVSgJwYd0eEMtdw/Ad3bAogilWUyE9wMJc
         Mp7kCDJotfrcM1um7CJ4laeaavo2dbF8cuzt10vpe+3VKVfItRnDhhQLG/gwFg6sqpVP
         8p0w==
X-Forwarded-Encrypted: i=1; AJvYcCVYu7rpxKKq1RL0aJa7KBptU1btIujMDqdMC8YZ+u1mfnZUfZZqwnK44OKXvtvQLNuTs4vhl04olOGW8Tm08FPcP30=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrNcJaqe5OXduGHzr2kk0W1tE9x7bhJjQqHbaATLMei8PHWe6u
	YnTvLOzNl1OxA0mon76rf+35OPUHQSgsKwl2KRoaDf9Uv5k4TnxZhIx5
X-Gm-Gg: AZuq6aKuixoLp8iYt95LaKt2GECaVuObb5Rf3LS2D5MceZ3DOp5Lv3Zsb8l3bPbIuQ1
	GRuuI2kUEgC301L3zKWqHuYUFZk0rQELn3KbY4lTtC+xtc63Cwzi+ziXLHzPQf5FSo75KpWVPOX
	UmmK2smEXwL8kqOFyoAiLs2Qial0abb/oqqGnSW28mmNcl5DkKhXES1GF3oAcAyYNw7xJX+fxXs
	OkF4HORJTEIjI2pyvY5wWzpO2HRxrlMVpIhqhTxbmziEwer+JIXE9v/252p4lq7sG3vPrVE5pTi
	T7tKWzxuQjUYWQ6WnBSdD6207j/xmEJQQp/SST95OpRjTpoh7OvKIFcvHSfi8CsZKaVA7ML0bWW
	gsdTrZoFJxG3RrNE3PGGbH3Qt53eMT3Aeu02WuaCuJNZoj4lrncPuaOIP7ZJ9aUhHP0MimPLhiy
	fZzI1DbHcKerRWIFPo1MSZ1vemNmNV8ttz
X-Received: by 2002:a05:600c:1c21:b0:483:47ae:7c00 with SMTP id 5b1f17b1804b1-48373a3eac4mr288069915e9.20.1771365979460;
        Tue, 17 Feb 2026 14:06:19 -0800 (PST)
Received: from krava (37-188-249-12.red.o2.cz. [37.188.249.12])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483983cf7c3sm2188375e9.15.2026.02.17.14.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 14:06:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 17 Feb 2026 23:06:12 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 09/12] libbpf: Add support to create tracing multi
 link
Message-ID: <aZTmVCK0OMFtrS8X@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-10-jolsa@kernel.org>
 <CAEf4BzYhP8CdS_Xpw1iEvGNxYGnf3Zq5zkb-HEZKvx5cxEJBqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYhP8CdS_Xpw1iEvGNxYGnf3Zq5zkb-HEZKvx5cxEJBqw@mail.gmail.com>

On Wed, Feb 04, 2026 at 11:05:16AM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 3, 2026 at 1:40 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new interface function to attach programs with tracing
> > multi link:
> >
> >   bpf_program__attach_tracing_multi(const struct bpf_program *prog,
> >                                     const char *pattern,
> >                                     const struct bpf_tracing_multi_opts *opts);
> >
> > The program is attach to functions specified by pattern or by
> > btf IDs specified in bpf_tracing_multi_opts object.
> >
> > Adding support for new sections to attach programs with above
> > functions:
> >
> >    fentry.multi/pattern
> >    fexit.multi/pattern
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/bpf.c      |  7 ++++
> >  tools/lib/bpf/bpf.h      |  4 ++
> >  tools/lib/bpf/libbpf.c   | 87 ++++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/libbpf.h   | 14 +++++++
> >  tools/lib/bpf/libbpf.map |  1 +
> >  5 files changed, 113 insertions(+)
> 
> [...]
> 
> >  static const char * const map_type_name[] = {
> > @@ -9814,6 +9817,7 @@ static int attach_kprobe_session(const struct bpf_program *prog, long cookie, st
> >  static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_lsm(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >  static int attach_iter(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> > +static int attach_tracing_multi(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> >
> >  static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("socket",               SOCKET_FILTER, 0, SEC_NONE),
> > @@ -9862,6 +9866,8 @@ static const struct bpf_sec_def section_defs[] = {
> >         SEC_DEF("fexit.s+",             TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> >         SEC_DEF("fsession+",            TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF, attach_trace),
> >         SEC_DEF("fsession.s+",          TRACING, BPF_TRACE_FSESSION, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
> > +       SEC_DEF("fentry.multi+",        TRACING, BPF_TRACE_FENTRY_MULTI, 0, attach_tracing_multi),
> > +       SEC_DEF("fexit.multi+",         TRACING, BPF_TRACE_FEXIT_MULTI, 0, attach_tracing_multi),
> >         SEC_DEF("freplace+",            EXT, 0, SEC_ATTACH_BTF, attach_trace),
> >         SEC_DEF("lsm+",                 LSM, BPF_LSM_MAC, SEC_ATTACH_BTF, attach_lsm),
> >         SEC_DEF("lsm.s+",               LSM, BPF_LSM_MAC, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_lsm),
> > @@ -12237,6 +12243,87 @@ static int attach_uprobe_multi(const struct bpf_program *prog, long cookie, stru
> >         return ret;
> >  }
> >
> > +struct bpf_link *
> > +bpf_program__attach_tracing_multi(const struct bpf_program *prog, const char *pattern,
> > +                                 const struct bpf_tracing_multi_opts *opts)
> > +{
> > +       LIBBPF_OPTS(bpf_link_create_opts, lopts);
> > +       __u32 *btf_ids, cnt, *free_ids = NULL;
> > +       int prog_fd, link_fd, err;
> > +       struct bpf_link *link;
> > +
> > +       btf_ids = OPTS_GET(opts, btf_ids, false);
> > +       cnt = OPTS_GET(opts, cnt, false);
> > +
> > +       if (!pattern && !btf_ids && !cnt)
> 
> let's check that either both btf_ids and cnt are specified or none
> 
> then we can check that either pattern or btf_ids are specified
> 
> still two checks, but will capture all the bad cases

ok

> 
> > +               return libbpf_err_ptr(-EINVAL);
> > +       if (pattern && (btf_ids || cnt))
> > +               return libbpf_err_ptr(-EINVAL);
> > +
> 
> [...]
> 
> >  struct bpf_uprobe_opts {
> >         /* size of this struct, for forward/backward compatibility */
> >         size_t sz;
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index d18fbcea7578..a3ffb21270e9 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -358,6 +358,7 @@ LIBBPF_1.0.0 {
> >                 bpf_program__attach_ksyscall;
> >                 bpf_program__autoattach;
> >                 bpf_program__set_autoattach;
> > +               bpf_program__attach_tracing_multi;
> 
> stuck in the past? ;) we are in 1.7 cycle

a bit :) will fix, thnx

jirka
