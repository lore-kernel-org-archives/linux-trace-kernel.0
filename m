Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085EA348883
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Feb 2026 08:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366452; cv=none; b=IxNTIr+OQ1xKViFUtFL4xroJcEH8zR4j7koHmFWfDxqVM+kkXB9Nql3gr8pNGbQVVdvZ9s3zpp+dln3UCnfCFB9/ibIFPexaFJoqMriULIMvmW5Hav/7vlDcrpsr7XMvF5co9/vQu8lapM/LGAWsJ9cgwxkCBrCDB812YbXLOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366452; c=relaxed/simple;
	bh=cJUFiVuff/KPlnx1eULVJx3hfbbTA1i+WxGtZimLSEo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KKmhZt8yNRZAfct3hn05JyZE22OncEl7CGN2NqfRO5NW1nndmUO3STIf66WgpJBIpEiYQa8VbF6qroEFMDZFNyTTf2Wd1NA+6QLOwDXj+vBir4cykiGORr5cTmU+zBrVVXYkx1PkDK4UQcajsJLe+emux62iBq8QwJM04CvYajI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCLPzcaI; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCLPzcaI"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4806dffc64cso15526615e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Feb 2026 00:27:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770366448; x=1770971248; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yK3NKY8aaTUDoPfEVQhx9I8PtsQ63/NYZYEF7PuRZjc=;
        b=SCLPzcaIBHfa0u65NVJfUj0vQWTmcHicdHZzt2h36sOQwG5Z1w6tspO5dV/7SekjNR
         SJs02zRH/q6xWu2ewis1iVOac/o5+wQEmHqgTCHfkFQo5+Hj29c01aw3STgm38k6uXDr
         B5N3v3ggebUNps1e3y4sGuHdbw4Vc8aTmERFUKAcQMGNetGyQrCx0cJPbDWkxqAJKciM
         5BHpz47cmYldleb2puOZdbXM148EpAkLDPPBKZAVtx7HfcpWr6C4MZLbXlyt1dYENPZ4
         DnB6r0k7vhcc/1cQ432VlXIgNmRJM25sy5NPzTFaUC1ySlSLrRzs1LZE9MmTD4YMbRxQ
         1dmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770366448; x=1770971248;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yK3NKY8aaTUDoPfEVQhx9I8PtsQ63/NYZYEF7PuRZjc=;
        b=cj9sNvC26sD+9FrFZTZzQ82ft2OYoXPDE6vroJPouxWuAtquvaAKkkSgLa89bcgGZC
         cQ93PdVZ8KaoCJhsrGsIm5cZcYNtyN21mMXzoEyAPfDPfJiZ2Ry1eRwV9Uc0QQIg1+vY
         3mXaP7ofs4Sj0ecOAjmhInc474xBm65HGlwHCMacQ7YikxllNWIJQDUZ9GBCf7617d3j
         7pKNHD3+VC4xU/BBQz1aZBEgQy4HgU/mtrrrX5njP3cb7teQfZbo4jjFDxX77taUl2hR
         DPzN0Wwmucu87go0kXbyBLiNXvhggrM85N+iqJ/qEQK8NoPepZEACYEjsCloiQ5BicVo
         dh9A==
X-Forwarded-Encrypted: i=1; AJvYcCU5DiFMCHJPtQ628vzozG/mhk2zDuEEVhytXJyxEcTEyDX/Odrw/xr9OIZoE7oy/S7mLkhO3YnW5dDc/9ZB85HrktM=@vger.kernel.org
X-Gm-Message-State: AOJu0YynmVtBuA6XZzeb2earScZbobzmsMtx7EBJAffsvJ+LaZNxJWaA
	3fURrqqPXYXbbxBwcb2B3s7TJMgi4pgsfRuyfH8MWYic1HKFDw/LFbjg
X-Gm-Gg: AZuq6aJ1oI0w0M2lKy+WLClDbnfeNe5Ml2Tf9KOnAtL3L/tjRAe95hd6j5m3XF77ITK
	vW7cfEtojdB0lt2f34Q0UBwbQUsWHQlc0xTC+Qqts/RNOKhOMnjGpfGH1YrhoQ9pE3QRD9s7DKR
	QcnX8xX572Er66N9q0cAe0rVgnf9atPj/vHluiXgv/XcPysxUiv1m+SjVNrI+MJqAAYDFkbG+Fn
	fGscGFxMnpt7EQYfbUzRfKRtOdCzCk2705JHL4trECsrJC3B7RgWqIqM/r2buURjCpsOJJk85ch
	q0IcKnt+VMcTPrK+06RdlpZ8a0xl0whvArFC6WlboFdaUE7/kZopE0bsRXpg/cM7Yum38YthSCv
	wqeCLAdFZX/Q9SK1qY94FEBglpHUEtfg2/HLeofWlKkFd0RT1a3ft+MYXJ8g7fds8uPrfPMY=
X-Received: by 2002:a05:600c:3148:b0:47a:8154:33e3 with SMTP id 5b1f17b1804b1-4832097e27fmr19030385e9.28.1770366448150;
        Fri, 06 Feb 2026 00:27:28 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320638ff7sm40060185e9.0.2026.02.06.00.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 00:27:27 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 6 Feb 2026 09:27:25 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Steven Rostedt <rostedt@kernel.org>
Subject: Re: [RFC bpf-next 04/12] bpf: Add struct bpf_tramp_node object
Message-ID: <aYWl7Y9ok32_eZXi@krava>
References: <20260203093819.2105105-1-jolsa@kernel.org>
 <20260203093819.2105105-5-jolsa@kernel.org>
 <CAEf4BzYWxmg7YO_ewENt1rr4R1YT=iL0fc5yJqanfQZJk6u1nQ@mail.gmail.com>
 <aYRbYY8f_wWoiZhk@krava>
 <CAEf4BzY=vqpnjrDNtLVvC3_nU5=Z7iROU_He=xbkEJDuGCoqug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzY=vqpnjrDNtLVvC3_nU5=Z7iROU_He=xbkEJDuGCoqug@mail.gmail.com>

On Thu, Feb 05, 2026 at 02:27:38PM -0800, Andrii Nakryiko wrote:
> On Thu, Feb 5, 2026 at 12:57 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Wed, Feb 04, 2026 at 11:00:57AM -0800, Andrii Nakryiko wrote:
> > > On Tue, Feb 3, 2026 at 1:39 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Adding struct bpf_tramp_node to decouple the link out of the trampoline
> > > > attachment info.
> > > >
> > > > At the moment the object for attaching bpf program to the trampoline is
> > > > 'struct bpf_tramp_link':
> > > >
> > > >   struct bpf_tramp_link {
> > > >        struct bpf_link link;
> > > >        struct hlist_node tramp_hlist;
> > > >        u64 cookie;
> > > >   }
> > > >
> > > > The link holds the bpf_prog pointer and forces one link - one program
> > > > binding logic. In following changes we want to attach program to multiple
> > > > trampolines but have just one bpf_link object.
> > > >
> > > > Splitting struct bpf_tramp_link into:
> > > >
> > > >   struct bpf_tramp_link {
> > > >        struct bpf_link link;
> > > >        struct bpf_tramp_node node;
> > > >   };
> > > >
> > > >   struct bpf_tramp_node {
> > > >        struct hlist_node tramp_hlist;
> > > >        struct bpf_prog *prog;
> > > >        u64 cookie;
> > > >   };
> > >
> > > I'm a bit confused here. For singular fentry/fexit attachment we have
> > > one trampoline and one program, right? For multi-fentry, we have
> > > multiple trampoline, but still one program pointer, no? So why put a
> > > prog pointer into tramp_node?.. You do want cookie in tramp_node, yes,
> > > but not the program.
> >
> > yes, but both links:
> >   - single link 'struct bpf_tramp_link'
> >   - multi link  'struct bpf_tracing_multi_link'
> >
> > are using same code to attach that code needs to have a hlist_node to
> > link the program to the trampoline and be able to reach the bpf_prog
> > (like in invoke_bpf_prog)
> >
> > current code is passing whole bpf_tramp_link object so it has access
> > to both, but multi link needs to keep link to each trampoline (nodes
> > below):
> >
> > struct bpf_tracing_multi_link {
> >        struct bpf_link link;
> >        enum bpf_attach_type attach_type;
> >        int nodes_cnt;
> >        struct bpf_tracing_multi_node nodes[] __counted_by(nodes_cnt);
> > };
> >
> > and we can't get get from &nodes[x] to bpf_tracing_multi_link.link.prog
> >
> > it's bit redundant, but not sure what else we can do
> 
> invoke_bpf_prog() specifically doesn't have to get prog pointer from
> bpf_tramp_link, it can be passed prog as a separate argument and then
> bpf_tramp_node  with cookie separately as well. I haven't looked at
> all other code, but I suspect we can refactor it to accept prog
> explicitly and the relevant parts (node+cookie) separately.

ok, makes sense.. will check on how to refactor that code

for some reason I thought we don't wan't to refactor jit code much,
because it means changes through all the archs code.. but this one
should mostly change just arguments, so it's probably ok

> 
> Just at the conceptual level, we have single prog and multiple places
> to patch (trampolines), so we shouldn't be co-locating in the same
> data structure. It feels like a complete hack to duplicate prog just
> to make some internal code access it.

ook

jirka
