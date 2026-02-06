Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7834CFB5
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Feb 2026 08:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770367398; cv=none; b=k/xV96AJ3uBp4nJSZewxVtDIAxe6QINSjljx6R/yqZTMngE9ZtE+DsJa0BToPoSrJiUBxL6AgIYdwJhOdE4lwzccpMNvgP2zVI2DnCbGnXvuri4gXmBnIq0riEEJB3nyMdnaiFUx3tZJwcM4oJ8DLhXoFhl4FrzUAFI1q410XCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770367398; c=relaxed/simple;
	bh=nmT6jlogQH5AZPKuyGJ72RwfLpmX8vxOowKL0ee/364=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAUtuxHaWBnWelPN0X/r2mhkf1r5IXIUVf2ONbZuj4PVfA6EYo0PDjGpR79hFgNSl7uuaN79Jr3myu3XIyWhNNoos1kzO2EuNdMLo+uVZgapV/7Ee/T2dKtEwrxcAJVE5CzdS7Gueq7Do+TU386JHeHde4DqHvfOwHXvmHRkWmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cx4MaJXu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cx4MaJXu"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4362cdf1d5aso197392f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Feb 2026 00:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770367397; x=1770972197; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mfgNjjC4FlGfey1zASb3yyxvwr/kmot3+J84KwzJnMY=;
        b=cx4MaJXulBpmG+0Cy5jhr+VCPB6hnkORWvG5gFFQXAKBKiVQC5O/lfEXGC2l944nYC
         8v5aB2MCifa7ZGcZq1TUxm9V94GKtPICIlOrfxe65W3n5D+vk2c8APiGSgzRmXY1gG7U
         mrIkR+MIrnSuHtxN6Au211bqZQ2+4kSD0l5b6AAweASWPANscqWa0Y7LfED0zw8C/YKH
         llJ1CCaluJZxmmxYPgtuk49xV2zYhPmN0xCUsqCHcKccVsMNU/ppg7DAFqnksHh5zEX7
         re1uenRko+S872F21e2bXLKOXblV5PHQfJfiWincZvNEVuznfMwuemR+WgUxtHw/OGmQ
         x5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770367397; x=1770972197;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mfgNjjC4FlGfey1zASb3yyxvwr/kmot3+J84KwzJnMY=;
        b=g/zg4O3xr5nrLpsm0K8Bbefl3WMTv/vg237+a6Pa/oxXGEMoHzuIY6F604f8WVOCe5
         JOp/N62ummU51CpgGEW+F6n2UV5/ExIKMugD74Tltdc8nbcpy4KhrFZzN+lP3+Vt/CvO
         6CBwMq+zA/hemiQOG/r5nAVPtczW5LLb+bBq+AvLfG/i6iD+JeUfOM3QRiSjDiSJOp+t
         yAe6CEMxnKst3DyYajTuG9ChWDIUhd9eMA7XAUvsyWJW3aG0k8KoBQ9rP4SB449JuyW+
         YOH7DtMqCgH5h7RjzPaqDsYprzkUnJebfhdKXQ5cc4Iv2Zf5VpCAFiJjLBfYfl2mr7Eb
         TYPw==
X-Forwarded-Encrypted: i=1; AJvYcCWr5p9Sbix2AMMIC3tg93uKQphL1rD7woL86N8bs5WdkOPFPVqdStLcspswXExgwN8MqhhOZO/JlZkAM6BvJFXpwxc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/VaZYQ8QA9z/ZkG47GFzqnM6q0nWSBtBWGIeCgS2lpD9LMdl
	p2Cx29GU1poQvBCj/WPZWX/lruo89AHqBNKrLNdDDXe0XQlGRiw8h/Ki
X-Gm-Gg: AZuq6aLZC+BWf6dh94khyY7FIqb0QDio+JFFSjmkesUcOWymLSUXwioKGlYzPffmn83
	rqnyTDdM6i9AmI66QO0hL3WVLY5fhkxA9Kt+boGsT0us3X3QYLpIXwT89T+ssjxFwKBiEH/9yQP
	XT6N7wxadFJ+7qQCtPx9N91V/co+B3OJEcHla6Gho26h22Tq6ZZUg8o0+Wa7+WdNuiMOMHTYd3N
	T7lt9Jhlw7FjRNdhsIT57uoLYAbKaEr7LI7lw8I+snuEzxvPthyevjUpGxHyLFUWzflLpFKkKrs
	gZa+/fwA4nCoRcxGMH6T3/KKg9NbJk7BU2gbJKwigmPNfiFiy1Pag1Ovnf5zU6yhKL3FL3hNK9L
	cvHA8AdSCCt9idSivb8Ot+WvXdJZqWAwtbV6jdKY9FjaxtwJZ2+BKrRI0Gzno
X-Received: by 2002:a05:6000:2f83:b0:435:a815:dd81 with SMTP id ffacd0b85a97d-4362933be7fmr2912739f8f.11.1770367396449;
        Fri, 06 Feb 2026 00:43:16 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4362972fc1bsm4345367f8f.28.2026.02.06.00.43.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:43:16 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Feb 2026 09:43:14 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 08/12] libbpf: Add btf__find_by_glob_kind function
Message-ID: <aYWpotJVLSZdiZgG@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-9-jolsa@kernel.org>
 <CAEf4BzY7zZmEqFq577NiG2wh0aU0_og1_RjVSURjaqTOnTc-Bw@mail.gmail.com>
 <aYRbbL-QCnAZ6PGD@krava>
 <CAEf4BzbzrPemyBe0xtEwuxG8d-JUC+Dd+B412VBLLAui=88LEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbzrPemyBe0xtEwuxG8d-JUC+Dd+B412VBLLAui=88LEw@mail.gmail.com>

On Thu, Feb 05, 2026 at 02:45:14PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 5, 2026 at 12:57 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Feb 04, 2026 at 11:04:09AM -0800, Andrii Nakryiko wrote:
> > > On Tue, Feb 3, 2026 at 1:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding btf__find_by_glob_kind function that returns array of
> > > > BTF ids that match given kind and allow/deny patterns.
> > > >
> > > > int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > >                            const char *allow_pattern,
> > > >                            const char *deny_pattern,
> > > >                            __u32 **__ids);
> > > >
> > > > The __ids array is allocated and needs to be manually freed.
> > > >
> > > > The pattern check is done by glob_match function.
> > > >
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
> > > >  tools/lib/bpf/btf.h |  3 +++
> > > >  2 files changed, 44 insertions(+)
> > > >
> > > > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > > > index 83fe79ffcb8f..64502b3ef38a 100644
> > > > --- a/tools/lib/bpf/btf.c
> > > > +++ b/tools/lib/bpf/btf.c
> > > > @@ -1010,6 +1010,47 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
> > > >         return btf_find_by_name_kind(btf, 1, type_name, kind);
> > > >  }
> > > >
> > > > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > > +                          const char *allow_pattern, const char *deny_pattern,
> > > > +                          __u32 **__ids)
> > > > +{
> > > > +       __u32 i, nr_types = btf__type_cnt(btf);
> > > > +       int cnt = 0, alloc = 0;
> > > > +       __u32 *ids = NULL;
> > > > +
> > > > +       for (i = 1; i < nr_types; i++) {
> > > > +               const struct btf_type *t = btf__type_by_id(btf, i);
> > > > +               const char *name;
> > > > +               __u32 *p;
> > > > +
> > > > +               if (btf_kind(t) != kind)
> > > > +                       continue;
> > > > +               name = btf__name_by_offset(btf, t->name_off);
> > > > +               if (!name)
> > > > +                       continue;
> > > > +
> > > > +               if (deny_pattern && glob_match(name, deny_pattern))
> > > > +                       continue;
> > > > +               if (allow_pattern && !glob_match(name, allow_pattern))
> > > > +                       continue;
> > > > +
> > > > +               if (cnt == alloc) {
> > > > +                       alloc = max(16, alloc * 3 / 2);
> > > > +                       p = libbpf_reallocarray(ids, alloc, sizeof(__u32));
> > > > +                       if (!p) {
> > > > +                               free(ids);
> > > > +                               return -ENOMEM;
> > > > +                       }
> > > > +                       ids = p;
> > > > +               }
> > > > +               ids[cnt] = i;
> > > > +               cnt++;
> > > > +       }
> > > > +
> > > > +       *__ids = ids;
> > > > +       return cnt;
> > > > +}
> > > > +
> > > >  static bool btf_is_modifiable(const struct btf *btf)
> > > >  {
> > > >         return (void *)btf->hdr != btf->raw_data;
> > > > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > > > index b30008c267c0..d7b47bb0ba99 100644
> > > > --- a/tools/lib/bpf/btf.h
> > > > +++ b/tools/lib/bpf/btf.h
> > > > @@ -661,6 +661,9 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
> > > >         return (struct btf_decl_tag *)(t + 1);
> > > >  }
> > > >
> > > > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > > > +                          const char *allow_pattern, const char *deny_pattern,
> > > > +                          __u32 **__ids);
> > >
> > >
> > > as AI pointed out, this should be an internal helper, no? Let's also
> > > not use double underscore pattern here,
> > > "collect_btf_ids_by_glob_kind()" perhaps?
> >
> > ok
> >
> > >
> > > Also, you don't seem to be using deny_pattern, where you planning to?
> >
> > the tests are just rudimentary before we agree we want to do it this way
> >
> > but I'm not sure I have a usecase for deny_pattern.. I think we added it
> > just to be complete, I recall we copied that function from somewhere,
> > it's long time ago ;-)
> >
> > >
> > > Also, are there functions that we'll have BTF for, but they won't be
> > > attachable? What if I do SEC("fentry.multi/*")? Will it attach or fail
> > > to attach some functions (and thus fail the overall attachment)?
> >
> > yes, for the benchmark tests I had to add is_allowed_func which mimics
> > btf_distill_func_proto and denies attach for some functions
> >
> > also I had to filter out some core kernel functions like rcu*,trace*,..
> > which seemed to cause trouble when you attach them
> 
> So the question I'm implying here is if libbpf should do what we do
> for kprobes: use libbpf_available_kprobes_parse and intersect?

right, I think it's good idea.. and in addition (just for patterns) we would
filter out functions that:

  - won't attach (is_allowed_func == false)
  - might cause problems (rcu*,trace*), maybe for that we could have
    opts config bool

jirka
