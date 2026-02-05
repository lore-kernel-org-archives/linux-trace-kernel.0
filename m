Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B153A784A
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Feb 2026 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770281841; cv=none; b=hMtxHO/XhCxxrTuz17tfGipe4kjwaDZ/I406PWjTqz1ywsHwtoLv4VxIj+rrZHKqXkEtxg2/lPj831I5r8w5RMyXyWTZgFUvnbifZjQgaaxoFIbR2C/3gkuB8Te+5Krj1vrlnr9zyasnixuG8ljgvkoJZsug2b1wtepkN4ccVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770281841; c=relaxed/simple;
	bh=X33MvehfDzFy5G+x/8MD4X7C0oKq3Gd855MY4flA61w=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYd/BWS7K29fFY4Nc9ODaN3cSUjUHhqg1n+wLcyRdBZ4VQbdRaWTZZ58nU/e0o5W969ro3ynlTxS+MofxH9KJoGTismb9+HLRdbeiUlwlaxy73Sbyfpo0hRAxX0LyhL81a/mOJhpIS1HL1A2fce27z1TlqQmf/WhmkN8xy1/TcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l7ajSCEE; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7ajSCEE"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48068127f00so6119055e9.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Feb 2026 00:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770281839; x=1770886639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LA/F9UoinJbMcoNJBXzOZcpf42t/L4SBmgG6R3SDux4=;
        b=l7ajSCEE2+HJQcFP2T9o7b+XC4ti/fdLVaXEi8r4Ay/b93OURInNY+kPRY6+Cs3PEL
         h2mma9+yhYQ8sZe+5an8Z3/2o42X94xqtTZAlMm9y+0K4dK/Wa2KQ1EH1PUQMPdAr89Q
         EpG27VpaklnRTsGXb4tOtH15vxu3zM35dVIg5g4bWlN+aV60ioZw4MGWmMSHm5R20m+Q
         gtpB+2KFYKmgn/mmZyw3uXk7PZZGyLaF2I2TNrrMDgkx7qi3JkIZ1DX51sOygGCYl58i
         FbYk0+07p98l3L/g9J8BaVCl1Od4oVhUIJvaCJ596enheq8Ss/I+40aRVeyCs626P2s8
         pLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770281839; x=1770886639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LA/F9UoinJbMcoNJBXzOZcpf42t/L4SBmgG6R3SDux4=;
        b=QlSt2iUSSKHaWuIYzmdY+BL4b8jyJVvMfJxdDzn4AlNX/hvsZABjhZ7vTKJzkL4TX2
         z7AZJY+aBTOrzcCGubALDtPwSv+8JYWM4PNo63lKwc24+sI6VDuvfcDlGm58TW4Xa/VB
         lcOkPe5JrRkrycVg1tQW/rjFq8/StBdxytlPwkwlT8N5fURsuQlHTDbCdrHRBKGhZcYY
         0UrEFWICMsrT5+c59VKHzKARVLVsBpUp5mqEwUWxwWP0ozxEhx2+tluYJ3qEMcUPwQl4
         TDUA74CNTNTgByPDJWsk95darG492C9kpgIxYah2IijngNFiGoG7Sl90nv006auhMF8B
         WJLw==
X-Forwarded-Encrypted: i=1; AJvYcCWDFFDpT9gEIRUxe6inagVdf4GjHNqwzRHMHwXHn9q6yjeRjRSQY2ctvTtgQ+roPou+ubpUGkUAiT+smenW/afW7u4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzekYkLdgLwKioHBB1742ZjbQeYGc4Ogo/WeTFelr2WjayprIzo
	HaFFmD0EdQ4EyBZvv70wjFBEPLsTC/l4oLSYH6TXLBzQS3EaD7eVLSeWJ/5j7Qlc
X-Gm-Gg: AZuq6aJw5KHYz4a6x82+BrcMQJ/Pip4HbvhP/iqXUhCzBL2CnQ1ykKirLiFbyzhz1N6
	v2nnKIkj1eDlIFLKPnG7V0hfEN0XOdphMjYDGcCDRtzkMZ/QLTg8RQkwBaC7vIfEsjqx67Zlltw
	d9HWuWM/I4oeCb1VxfjfdVcTXUim2GIlXHNQO/DkkH2FO78yFsdsiKotUn/Ay9B/FZj5/A9Zf0b
	whikCr6B3jngU8ZNQuOD/KcZ8fQ2C0NIbH5TZzSOnA8kPhL5GsVTkCWxicciCJg/kDrdFJZIr+t
	o1fiijkey4uuTeZy3hAFz9JLfykDDaEH9gbgVOAw4MtSRzZ3RxaUYUEvxlFshKZ/D/6sRnchHUA
	TWJn3f9LQ2y7F0E7mszg9vAB0833E/2gJFDLlkeUgPPbUcrOZdncZgtvPnDk2
X-Received: by 2002:a05:600c:350e:b0:477:fcb:2256 with SMTP id 5b1f17b1804b1-4830e966c2fmr82320975e9.17.1770281838858;
        Thu, 05 Feb 2026 00:57:18 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4830ec5cc24sm58841725e9.3.2026.02.05.00.57.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 00:57:18 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 5 Feb 2026 09:57:16 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 08/12] libbpf: Add btf__find_by_glob_kind function
Message-ID: <aYRbbL-QCnAZ6PGD@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-9-jolsa@kernel.org>
 <CAEf4BzY7zZmEqFq577NiG2wh0aU0_og1_RjVSURjaqTOnTc-Bw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY7zZmEqFq577NiG2wh0aU0_og1_RjVSURjaqTOnTc-Bw@mail.gmail.com>

On Wed, Feb 04, 2026 at 11:04:09AM -0800, Andrii Nakryiko wrote:
> On Tue, Feb 3, 2026 at 1:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding btf__find_by_glob_kind function that returns array of
> > BTF ids that match given kind and allow/deny patterns.
> >
> > int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> >                            const char *allow_pattern,
> >                            const char *deny_pattern,
> >                            __u32 **__ids);
> >
> > The __ids array is allocated and needs to be manually freed.
> >
> > The pattern check is done by glob_match function.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/lib/bpf/btf.c | 41 +++++++++++++++++++++++++++++++++++++++++
> >  tools/lib/bpf/btf.h |  3 +++
> >  2 files changed, 44 insertions(+)
> >
> > diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> > index 83fe79ffcb8f..64502b3ef38a 100644
> > --- a/tools/lib/bpf/btf.c
> > +++ b/tools/lib/bpf/btf.c
> > @@ -1010,6 +1010,47 @@ __s32 btf__find_by_name_kind(const struct btf *btf, const char *type_name,
> >         return btf_find_by_name_kind(btf, 1, type_name, kind);
> >  }
> >
> > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > +                          const char *allow_pattern, const char *deny_pattern,
> > +                          __u32 **__ids)
> > +{
> > +       __u32 i, nr_types = btf__type_cnt(btf);
> > +       int cnt = 0, alloc = 0;
> > +       __u32 *ids = NULL;
> > +
> > +       for (i = 1; i < nr_types; i++) {
> > +               const struct btf_type *t = btf__type_by_id(btf, i);
> > +               const char *name;
> > +               __u32 *p;
> > +
> > +               if (btf_kind(t) != kind)
> > +                       continue;
> > +               name = btf__name_by_offset(btf, t->name_off);
> > +               if (!name)
> > +                       continue;
> > +
> > +               if (deny_pattern && glob_match(name, deny_pattern))
> > +                       continue;
> > +               if (allow_pattern && !glob_match(name, allow_pattern))
> > +                       continue;
> > +
> > +               if (cnt == alloc) {
> > +                       alloc = max(16, alloc * 3 / 2);
> > +                       p = libbpf_reallocarray(ids, alloc, sizeof(__u32));
> > +                       if (!p) {
> > +                               free(ids);
> > +                               return -ENOMEM;
> > +                       }
> > +                       ids = p;
> > +               }
> > +               ids[cnt] = i;
> > +               cnt++;
> > +       }
> > +
> > +       *__ids = ids;
> > +       return cnt;
> > +}
> > +
> >  static bool btf_is_modifiable(const struct btf *btf)
> >  {
> >         return (void *)btf->hdr != btf->raw_data;
> > diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> > index b30008c267c0..d7b47bb0ba99 100644
> > --- a/tools/lib/bpf/btf.h
> > +++ b/tools/lib/bpf/btf.h
> > @@ -661,6 +661,9 @@ static inline struct btf_decl_tag *btf_decl_tag(const struct btf_type *t)
> >         return (struct btf_decl_tag *)(t + 1);
> >  }
> >
> > +int btf__find_by_glob_kind(const struct btf *btf, __u32 kind,
> > +                          const char *allow_pattern, const char *deny_pattern,
> > +                          __u32 **__ids);
> 
> 
> as AI pointed out, this should be an internal helper, no? Let's also
> not use double underscore pattern here,
> "collect_btf_ids_by_glob_kind()" perhaps?

ok

> 
> Also, you don't seem to be using deny_pattern, where you planning to?

the tests are just rudimentary before we agree we want to do it this way

but I'm not sure I have a usecase for deny_pattern.. I think we added it
just to be complete, I recall we copied that function from somewhere,
it's long time ago ;-)

> 
> Also, are there functions that we'll have BTF for, but they won't be
> attachable? What if I do SEC("fentry.multi/*")? Will it attach or fail
> to attach some functions (and thus fail the overall attachment)?

yes, for the benchmark tests I had to add is_allowed_func which mimics
btf_distill_func_proto and denies attach for some functions

also I had to filter out some core kernel functions like rcu*,trace*,..
which seemed to cause trouble when you attach them

jirka
