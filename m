Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9323064AF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769420886; cv=none; b=SiBtKgbD6jzlxaAAfuK64gbER/UDrzcwcIxTzB7EpS+XYUVqOv0alX9tFvViTFf8VQWKpy4aJ/OnLk3B2CufeZJ6uL2W9pvRXy1Hs7NaUXEU4mLRYIN4aNuvtOnIj+tRx9nMputpE5DpSWBZrQQX/ipwEgOdoJClX8lgHLKiLDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769420886; c=relaxed/simple;
	bh=JuWl88GUT2xNpe/aGWnkgndeh1Tr9QkfFN1BABiUC4s=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TuD5VY3U6ZH3KaOQ1Tz8gmf/N7yucsPnJHOzjtAxoNPh7Xmwv1q6QGD8GixiawoLhSrPWUN89vysLr3fT9TZm1k5JL8j8G4CURMX3VIbnhyQRi7h+KOY8iaPh+u7gEZxXxlxtonRvlHaucYokWXa1QqA6YJBGxDwlj/kxf8cE+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rgq10quC; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rgq10quC"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-42fed090e5fso2572210f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Jan 2026 01:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769420883; x=1770025683; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ku8hCC/KeIeBXZMKlasY4QhX+B4SFXs580a4fks1WRY=;
        b=Rgq10quC8okGybKbwcLnOjxD7i9kxrX8UsYRXDsPnh7QbgytFON32IjqCWZ1avwaEq
         HX2emsjQuhLivsN0jH70V+c9B2DFR9oln+qV6C2R6MccVFJ+AsQS/B8UaZpV7/wFHxK2
         sHQmMBDWDeCd6onFRyFS79mhrR5+4H6PhGEtXhqG20W6IGLRzeL+ZnBMUIqEOvEsel0p
         q8cosLuYMA0xIfB6QoTatH34gjY3I34nAdwN/CwPLBRFAxyMHd39nDY3C2wpqgPCxiBs
         J2WshpDRVLBArpB79trm1WxOJ8/tQEdhPHvKgbURfYBfPvzgpT9NTIgYevXXGGecU8z8
         mFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769420883; x=1770025683;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ku8hCC/KeIeBXZMKlasY4QhX+B4SFXs580a4fks1WRY=;
        b=dcMMbXRJI3cr/2s1ZeCY8b2rmlcs/wXWctPbc6QMmmbdnqrUs6hO3ptO/s01l6RoQf
         5u+ZMC4f2T6nG3IaC1L7V2YhvFsFNht30NDfvP0AzNyrtABUfgrWVsAXKt5KsNUggjMc
         krhe8IiF/KZT2cnJaub+nbXLfZRRhaP2CVEbFcnjWkS47+ikVe+Wn8fZ+/lNzp/nV8zW
         1+ow9/YMi4uQ2L3dhRWTwgooIWw0aUusCUJsI1sIYujNOXPETAIA0QUKVa7ghksvPQXs
         I8riKftORHNk2/rxsLlWlhC4dlXywdxb6h1LLDYt4ZYovoyN2Qkg36S5wSxs7+0b4FJM
         Tm4Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIw5GXNVedftlz4YB0fhuoPvz3CWFlZWZG3130RETZj99SjvC9Y3koWWRqWgI0oZ487e3EEZmzSrJi/wVq4CyHc1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+pVyXx7So8O24rS5VLKr3aj59Fhs3hbKK2ZFPMmje48YSSTBe
	tqdestEu8p2ykbeXznZR2LkgDjGzJRV807Dqnq7E/BMVVkMJrtNn1e51
X-Gm-Gg: AZuq6aJecdiP+oA53EHbS7bBeF7tYUOmD0kad53vD02gGVVisYtX/NlwTcFTjpUwQVz
	i1oOT2zh24eHPgBri0XMF6l/ppWEgMPNwjB6yoLLjohgyBWOO8h6dSIAOTsIM3hyiFSMSZCmEG7
	I2nC9Az77/xEfF1kx8VvuFZl15bp5C/QBYhaFLR8dpjyHUYJNjHrAkw4mjVTR4DXr+0p/mFZkUl
	1ZAJM1C2ESSm5yrSBdVITniZ9eh49o22pxrPHm2CMVIEXuPeHNkAUxEV5ljpuDauTB6t86jAmag
	ePlfR/bZ2khlqqsUWSUA9XjOqY8WZ78lPCD2ecqRTjXKyB2dv7FOLQWcVOq7OK4MiLVYlXnynKJ
	rfIH/KuAc+yHXX6VFnZx16VTtPzxSxsgOXs0b3ZckODz2ya7JGEk8/PVjyfMX
X-Received: by 2002:a05:6000:2403:b0:430:f97a:6f42 with SMTP id ffacd0b85a97d-435ca39c59bmr8042341f8f.54.1769420883063;
        Mon, 26 Jan 2026 01:48:03 -0800 (PST)
Received: from krava ([2a02:8308:a00c:e200::b44f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1f7b4d8sm27562381f8f.38.2026.01.26.01.48.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:48:02 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 Jan 2026 10:48:01 +0100
To: Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Song Liu <song@kernel.org>
Subject: Re: [PATCHv6 bpf-next 0/9] ftrace,bpf: Use single direct ops for bpf
 trampolines
Message-ID: <aXc4UesvE3zYfPqn@krava>
References: <20251230145010.103439-1-jolsa@kernel.org>
 <CAEf4BzaRU0DoM9hHtW5Bm7njodfg06JzTOe=ABAqZ6iMjAt4iQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaRU0DoM9hHtW5Bm7njodfg06JzTOe=ABAqZ6iMjAt4iQ@mail.gmail.com>

hi,
gentle ping, thanks

jirka

On Thu, Jan 15, 2026 at 10:54:09AM -0800, Andrii Nakryiko wrote:
> On Tue, Dec 30, 2025 at 6:50 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > while poking the multi-tracing interface I ended up with just one ftrace_ops
> > object to attach all trampolines.
> >
> > This change allows to use less direct API calls during the attachment changes
> > in the future code, so in effect speeding up the attachment.
> >
> > In current code we get a speed up from using just a single ftrace_ops object.
> >
> > - with current code:
> >
> >   Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c true':
> >
> >      6,364,157,902      cycles:k
> >        828,728,902      cycles:u
> >      1,064,803,824      instructions:u                   #    1.28  insn per cycle
> >     23,797,500,067      instructions:k                   #    3.74  insn per cycle
> >
> >        4.416004987 seconds time elapsed
> >
> >        0.164121000 seconds user
> >        1.289550000 seconds sys
> >
> >
> > - with the fix:
> >
> >    Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c true':
> >
> >      6,535,857,905      cycles:k
> >        810,809,429      cycles:u
> >      1,064,594,027      instructions:u                   #    1.31  insn per cycle
> >     23,962,552,894      instructions:k                   #    3.67  insn per cycle
> >
> >        1.666961239 seconds time elapsed
> >
> >        0.157412000 seconds user
> >        1.283396000 seconds sys
> >
> >
> >
> > The speedup seems to be related to the fact that with single ftrace_ops object
> > we don't call ftrace_shutdown anymore (we use ftrace_update_ops instead) and
> > we skip the synchronize rcu calls (each ~100ms) at the end of that function.
> >
> > rfc: https://lore.kernel.org/bpf/20250729102813.1531457-1-jolsa@kernel.org/
> > v1:  https://lore.kernel.org/bpf/20250923215147.1571952-1-jolsa@kernel.org/
> > v2:  https://lore.kernel.org/bpf/20251113123750.2507435-1-jolsa@kernel.org/
> > v3:  https://lore.kernel.org/bpf/20251120212402.466524-1-jolsa@kernel.org/
> > v4:  https://lore.kernel.org/bpf/20251203082402.78816-1-jolsa@kernel.org/
> > v5:  https://lore.kernel.org/bpf/20251215211402.353056-10-jolsa@kernel.org/
> >
> > v6 changes:
> > - rename add_hash_entry_direct to add_ftrace_hash_entry_direct [Steven]
> > - factor hash_add/hash_sub [Steven]
> > - add kerneldoc header for update_ftrace_direct_* functions [Steven]
> > - few assorted smaller fixes [Steven]
> > - added missing direct_ops wrappers for !CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
> >   case [Steven]
> >
> 
> So this looks good from BPF side, I think. Steven, if you don't mind
> giving this patch set another look and if everything is to your liking
> giving your ack, we can then apply it to bpf-next. Thanks!
> 
> > v5 changes:
> > - do not export ftrace_hash object [Steven]
> > - fix update_ftrace_direct_add new_filter_hash leak [ci]
> >
> > v4 changes:
> > - rebased on top of bpf-next/master (with jmp attach changes)
> >   added patch 1 to deal with that
> > - added extra checks for update_ftrace_direct_del/mod to address
> >   the ci bot review
> >
> > v3 changes:
> > - rebased on top of bpf-next/master
> > - fixed update_ftrace_direct_del cleanup path
> > - added missing inline to update_ftrace_direct_* stubs
> >
> > v2 changes:
> > - rebased on top fo bpf-next/master plus Song's livepatch fixes [1]
> > - renamed the API functions [2] [Steven]
> > - do not export the new api [Steven]
> > - kept the original direct interface:
> >
> >   I'm not sure if we want to melt both *_ftrace_direct and the new interface
> >   into single one. It's bit different in semantic (hence the name change as
> >   Steven suggested [2]) and I don't think the changes are not that big so
> >   we could easily keep both APIs.
> >
> > v1 changes:
> > - make the change x86 specific, after discussing with Mark options for
> >   arm64 [Mark]
> >
> > thanks,
> > jirka
> >
> >
> > [1] https://lore.kernel.org/bpf/20251027175023.1521602-1-song@kernel.org/
> > [2] https://lore.kernel.org/bpf/20250924050415.4aefcb91@batman.local.home/
> > ---
> > Jiri Olsa (9):
> >       ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
> >       ftrace: Make alloc_and_copy_ftrace_hash direct friendly
> >       ftrace: Export some of hash related functions
> >       ftrace: Add update_ftrace_direct_add function
> >       ftrace: Add update_ftrace_direct_del function
> >       ftrace: Add update_ftrace_direct_mod function
> >       bpf: Add trampoline ip hash table
> >       ftrace: Factor ftrace_ops ops_func interface
> >       bpf,x86: Use single ftrace_ops for direct calls
> >
> >  arch/x86/Kconfig        |   1 +
> >  include/linux/bpf.h     |   7 ++-
> >  include/linux/ftrace.h  |  31 +++++++++-
> >  kernel/bpf/trampoline.c | 259 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
> >  kernel/trace/Kconfig    |   3 +
> >  kernel/trace/ftrace.c   | 406 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
> >  6 files changed, 632 insertions(+), 75 deletions(-)
> >
