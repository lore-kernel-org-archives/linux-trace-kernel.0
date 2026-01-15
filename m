Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEFB3C0098
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 18:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768503264; cv=pass; b=RvHPNHMDfXgi+LYb4r5aE/J7nskzEAZ/kWdPj7dwI0nQ3tTf1ZQTUWWWzijTBnXNuWRpR0TSxeF4I8LJOxpiUL9Nmii2ilUgWy/ew24FBfmagh2h3jZyFAePaaZvChv1KU2naw+FlVBSrd6dkImd1m61w5cbJUVJxc+D1oHhIdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768503264; c=relaxed/simple;
	bh=7dV2gC3i6v7x5QNrTKY/jnqxzJHYoS51E3vSMMeqd+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swiPwCcJzGkUAAlC/13leIpp5nTVhrkQm2Aj3jzRLvuCx8A9pvRre84uJ5yXnLCCvdhb0KSf/6xWWAaPdYTN00gf2AiW9N/Mg3+tYTChTJAs8yvqN+jaezXDP4e8SZPIAP6jXjYdqrlaIxso+rs+RBrWWRwhuKZEsjxkoAN2Agk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbwEz/OD; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbwEz/OD"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c2dc870e194so539230a12.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Jan 2026 10:54:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768503262; cv=none;
        d=google.com; s=arc-20240605;
        b=YoQf3LWIGzuqVS0dACAxhzuKFdesGRGeY72Xn31xQhPmE8hm/cV2KBpAu9HIt8hBpb
         pwUCv12jT6et67JwkaRv8hrySgcDZ9QPNReumOCgN3Wl1TeS3NBL4o+nwySC/EjFjSd1
         uijHNjFTxGNTgIe4dhsqC0QOTrrTJH0bM6+3O07bJlkQ9UwNqu6no4DA6GeQNuN0lygd
         nUt6U/arwSkTn1/K8e0qqMKohIRLHBzKtjvGXrkNBsRTOSzvjBNbccaLTPNHWIatd6Ze
         nEbeEsvkjIJ85+NNbmC1dyuzKHfVNUP0MCE0LgeUAQe04qkHF/r2LvcrPVXd8kUZ/ytX
         IPfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EpbTbJbIYQW2HGVw5tfKbZOFlETWSnwKBDBmcbacs/s=;
        fh=bikBE0k/hvbpJcaXIZ4EVBJEiwwwQm3sLSeKe6bZuSs=;
        b=WUAYe8OpUGuwp7oIloB/Wx9HCOGjlI2q4RRe1V3uBgroFvvUQcjahBGjHxLwLF1ovN
         qvSZCCCingBHwck+AKPld0i8apO7R4IVCiEbsxZu6RTIAOtiWAqp/gZXmgwtS08gWv9M
         TjByvaba/LcnNasqbH8DglvmfouxFCtQl0SXp/j0gj1+s5ZcKH4XtHtb/UE1lebCH627
         Wla/MlUJAPKzJ3WtZk3zD6M2vsH5HKGutNvun1+VHme3YM3gpF4jeR9gGEskPoxHpWYe
         4Sh/JM4ZPwp3/flC/5viBL2RUnvraKMrFCj+Lh+xZCaHRd4/R8lyocaWAOiBudx5Z/Im
         Tfpw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768503262; x=1769108062; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EpbTbJbIYQW2HGVw5tfKbZOFlETWSnwKBDBmcbacs/s=;
        b=lbwEz/ODkoLfn+u/4BdN9MMY7c5cIpjhgEVetLD2VmTFnIF6pyWSCe91WD9eg8OpQP
         hHH0fb6rs+I488eIDqiTMGKm6XMi/mxMvAqy56YMXXgAMKNHom6SgWSP+MSdLOZ1Q+x3
         PMIgNgTmJznBrm2yT3ghk7UUEwHFQs/LjOAlh6nul2u+yjtOtjQp5YN54GCZ1l8px7qu
         bUjVxzkVbV4Yt9m3bzS87DsH55I6TYNsLTi65pXjb1/9BD5vmJLou7dpym5BaxI1pgse
         iiMztNoPe0aFSW8kEIzbZn+8ppCuiJGoTov+vC76nOb65Sf4uTjaM67CHlBj4G8+kwRv
         gV1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768503262; x=1769108062;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EpbTbJbIYQW2HGVw5tfKbZOFlETWSnwKBDBmcbacs/s=;
        b=dAwdm0G2bRDyYKtgGa7rleod7Sz93swzNOKNSySiWYW235lrC1EiOu7tWNNEZzjICD
         UVnnYsQwQlpmASAv/qzP3Xtv28+fcvRCV5TOpiIGz2IJNfKz/OW1UXOnvAG1RpWFZBUl
         m3ntDAs7PgcSHCOjR0rfGrwXPKa5USrdcQVGpz7aNlo6n0Xr86pVpE5Hm0Wbj0Y1xDl8
         07ZTtM7v0vSpkWI/E7ji2V6wCkYYs48gnhvtSp3HgjxoltgD0o7IVZD+9cv/jLHCn8lZ
         LG8CsSrkNuzzpo7QF0QA0j75JD4PCy1lfCD7pc/ah5BDlBUT80vDusEjf1t9gVAv8NqZ
         95QQ==
X-Forwarded-Encrypted: i=1; AJvYcCVytJSWObf1HtYlYWJ8GBA+2ARHJkm8iInk/I2p4ABMmWeC2DXOo+hSA3E9B2XHPB+cgFxXtqTagBS+3WQjluRkCOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6XSZz0fHTnXmLN/J8+ZwMzXqva46LeWcGkrU2ZSepd3foE96d
	YnRrNpF0mYZqDnxsH3qpua8o2J8XowQhOd5pJYHnRIWfAMlI89biuhI1ry0IpBFIiIlorc8hTdT
	1V9vyf1nHMd5cMAHaRBF4SD/VcR2zb/I2cw==
X-Gm-Gg: AY/fxX4zA0gUnBR3OZq6aBhItdFHHBANhvYiWFkyR9NctvIehbuwBbRjpbV/agYjzk6
	mLW0dK5QY1VRcWJjDRx828S5w71FzGSytAYDuTNuH1nHGmsj/w7KhB97KIEHkogWn1IthhMFRx+
	kCN1Rsm3HV6yZpLCo0kSGzJgPwc7zwgahWGltGPe3DFozTyLEaK1itBmQDpeqktcnUBfrb5rG2O
	oSWRMldUk23RndDzqbvJFlAyvGqLg7nzOorrEWH1H7jX3U0hazjrkg/AyVvm0IWX5RiBbrd7oHa
	B7q3MFV2
X-Received: by 2002:a17:90b:2682:b0:341:88c9:ca62 with SMTP id
 98e67ed59e1d1-35272f8c54bmr287868a91.31.1768503261661; Thu, 15 Jan 2026
 10:54:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230145010.103439-1-jolsa@kernel.org>
In-Reply-To: <20251230145010.103439-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Jan 2026 10:54:09 -0800
X-Gm-Features: AZwV_QiwkBtwLCiJrqG34-zTIw_OQKLb1v72y1BxE2HMZ_jpyB1tumI3srsjTrw
Message-ID: <CAEf4BzaRU0DoM9hHtW5Bm7njodfg06JzTOe=ABAqZ6iMjAt4iQ@mail.gmail.com>
Subject: Re: [PATCHv6 bpf-next 0/9] ftrace,bpf: Use single direct ops for bpf trampolines
To: Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@kernel.org>
Cc: Florent Revest <revest@google.com>, Mark Rutland <mark.rutland@arm.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 30, 2025 at 6:50=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> hi,
> while poking the multi-tracing interface I ended up with just one ftrace_=
ops
> object to attach all trampolines.
>
> This change allows to use less direct API calls during the attachment cha=
nges
> in the future code, so in effect speeding up the attachment.
>
> In current code we get a speed up from using just a single ftrace_ops obj=
ect.
>
> - with current code:
>
>   Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c =
true':
>
>      6,364,157,902      cycles:k
>        828,728,902      cycles:u
>      1,064,803,824      instructions:u                   #    1.28  insn =
per cycle
>     23,797,500,067      instructions:k                   #    3.74  insn =
per cycle
>
>        4.416004987 seconds time elapsed
>
>        0.164121000 seconds user
>        1.289550000 seconds sys
>
>
> - with the fix:
>
>    Performance counter stats for 'bpftrace -e fentry:vmlinux:ksys_* {} -c=
 true':
>
>      6,535,857,905      cycles:k
>        810,809,429      cycles:u
>      1,064,594,027      instructions:u                   #    1.31  insn =
per cycle
>     23,962,552,894      instructions:k                   #    3.67  insn =
per cycle
>
>        1.666961239 seconds time elapsed
>
>        0.157412000 seconds user
>        1.283396000 seconds sys
>
>
>
> The speedup seems to be related to the fact that with single ftrace_ops o=
bject
> we don't call ftrace_shutdown anymore (we use ftrace_update_ops instead) =
and
> we skip the synchronize rcu calls (each ~100ms) at the end of that functi=
on.
>
> rfc: https://lore.kernel.org/bpf/20250729102813.1531457-1-jolsa@kernel.or=
g/
> v1:  https://lore.kernel.org/bpf/20250923215147.1571952-1-jolsa@kernel.or=
g/
> v2:  https://lore.kernel.org/bpf/20251113123750.2507435-1-jolsa@kernel.or=
g/
> v3:  https://lore.kernel.org/bpf/20251120212402.466524-1-jolsa@kernel.org=
/
> v4:  https://lore.kernel.org/bpf/20251203082402.78816-1-jolsa@kernel.org/
> v5:  https://lore.kernel.org/bpf/20251215211402.353056-10-jolsa@kernel.or=
g/
>
> v6 changes:
> - rename add_hash_entry_direct to add_ftrace_hash_entry_direct [Steven]
> - factor hash_add/hash_sub [Steven]
> - add kerneldoc header for update_ftrace_direct_* functions [Steven]
> - few assorted smaller fixes [Steven]
> - added missing direct_ops wrappers for !CONFIG_DYNAMIC_FTRACE_WITH_DIREC=
T_CALLS
>   case [Steven]
>

So this looks good from BPF side, I think. Steven, if you don't mind
giving this patch set another look and if everything is to your liking
giving your ack, we can then apply it to bpf-next. Thanks!

> v5 changes:
> - do not export ftrace_hash object [Steven]
> - fix update_ftrace_direct_add new_filter_hash leak [ci]
>
> v4 changes:
> - rebased on top of bpf-next/master (with jmp attach changes)
>   added patch 1 to deal with that
> - added extra checks for update_ftrace_direct_del/mod to address
>   the ci bot review
>
> v3 changes:
> - rebased on top of bpf-next/master
> - fixed update_ftrace_direct_del cleanup path
> - added missing inline to update_ftrace_direct_* stubs
>
> v2 changes:
> - rebased on top fo bpf-next/master plus Song's livepatch fixes [1]
> - renamed the API functions [2] [Steven]
> - do not export the new api [Steven]
> - kept the original direct interface:
>
>   I'm not sure if we want to melt both *_ftrace_direct and the new interf=
ace
>   into single one. It's bit different in semantic (hence the name change =
as
>   Steven suggested [2]) and I don't think the changes are not that big so
>   we could easily keep both APIs.
>
> v1 changes:
> - make the change x86 specific, after discussing with Mark options for
>   arm64 [Mark]
>
> thanks,
> jirka
>
>
> [1] https://lore.kernel.org/bpf/20251027175023.1521602-1-song@kernel.org/
> [2] https://lore.kernel.org/bpf/20250924050415.4aefcb91@batman.local.home=
/
> ---
> Jiri Olsa (9):
>       ftrace,bpf: Remove FTRACE_OPS_FL_JMP ftrace_ops flag
>       ftrace: Make alloc_and_copy_ftrace_hash direct friendly
>       ftrace: Export some of hash related functions
>       ftrace: Add update_ftrace_direct_add function
>       ftrace: Add update_ftrace_direct_del function
>       ftrace: Add update_ftrace_direct_mod function
>       bpf: Add trampoline ip hash table
>       ftrace: Factor ftrace_ops ops_func interface
>       bpf,x86: Use single ftrace_ops for direct calls
>
>  arch/x86/Kconfig        |   1 +
>  include/linux/bpf.h     |   7 ++-
>  include/linux/ftrace.h  |  31 +++++++++-
>  kernel/bpf/trampoline.c | 259 ++++++++++++++++++++++++++++++++++++++++++=
++++++++++++++++++++++++---------------
>  kernel/trace/Kconfig    |   3 +
>  kernel/trace/ftrace.c   | 406 ++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++--------
>  6 files changed, 632 insertions(+), 75 deletions(-)
>
