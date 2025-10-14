Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D82023373D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760477603; cv=none; b=TxGjDn6WYIolCPr14AWrI64laTYBPx3W2DPDRU2YA72AWGfndyMjHy1IUdVqEm9HqtJf1XqCDSoMzavt2KT+ve5NBcpnkH7T0PPwbvUvjGnaK61N33kb06JIyqbZCsz6wQi4sdENAejqy3UBk08GI6H2ex/BhDPah793xbePV78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760477603; c=relaxed/simple;
	bh=jn4dzshEK0b/q4LSAmrY5+2g0zSY/o3rLvb537ZUDJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kJIuDN0KSImpPLkcibKK/Bu/BAEpUv1P2F7ja9QdY4WfLdjfu1pbXp/jrFxZ5r2HThuqR/snb6u7lbnz6E2jXZ6NZ+GV3Fqe99hSyL2Y9H3iO5vC+cCjpgcNZITv9IZhnmBoOvvYrLrN3yPkYW9TLVpXJmck0JCqHFqgvWXtE0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zyu9ZyrR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zyu9ZyrR"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2681645b7b6so20965ad.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Oct 2025 14:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760477598; x=1761082398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DRskKZpnIRIllGR+ESE73jq8/mOCylC4thtJYDQxpyE=;
        b=zyu9ZyrRiUHxvk90NeQUsnqVX8hgXtI18dDTOv6JWjUpm79UguEuVPQL6aAY8mwBKr
         cFfgHg6zXDrOsFaNRW8z7ZhbBYIe073WqEPmTtyexYxi0U+GjN26UCdtWIAHyJDUL28C
         tO1ywpw+YBflw/qjg9+oyfulwkRhf9ZQE+9JEqHjqy0mOdKkeVwZehTXMcQ9O/K7WBF4
         Tso3pWHZ6CScEE58tzc/YMbeN4mEcX/DDncwtQqUnHRO3C2k1Hlf38V4vb2pZS1Vxeh6
         QlyOGTcsF3u3PLMEGzfdJz7KZnDbTsIrzkuv9xlorvYlXG1DZLEN7n0nXL3EnpPVaeDJ
         bbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760477598; x=1761082398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DRskKZpnIRIllGR+ESE73jq8/mOCylC4thtJYDQxpyE=;
        b=ZzJ9F8GUl04e/taGqMjGZLx2K0uIiUf8ph4JGesr/zFYZKTcMbVgmBgv/MZ9cB14ZU
         w1qJTph5EBxmv1AaZe/xmG4/FhjLT6KAyv0ABPR1TA6GABY2g/oaHBuazOw2itauLI6J
         nktKO/YmJCtKLJtV2bRZ3Pc4RWsu3iZLXojyxaHBuMtG7/S8y95k2ai19qLAorT0xQ55
         T79SKr1jM7LGfAEVtPODdRo75THGG2v6fjCA1Bm4U3zlDfeux6RiSHoOyyp7INQP6TxM
         rIPg1hkVHwWvFpvgwspEPSkdA5blrhU7uNQgus0vuhahfa0jJW1zjSxyB6Qhhqb/4tc0
         be5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXYUs2zt4Arl50F0RNtTQRRKECcGOgDK/nzWUm1yv9Zkl4IDgYh+dWq6K4uiahCTq0SNxWk7rDrcEK8oN6GAqQAk7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyLAfbxt964AFwgWaxnLZ1pRqgON4XhsHqNVSclw1BPs5ccjQ6
	hMdNPA2egKJwBrxtz9+2r8SPuXf077XvrG1asTG8h1MXoBIWcYm6vn/MfNLzjgk9/AX659DL9hs
	Vd+JGqVh2I4H1iZdwfuLtJIFRk5nIU5LnKvX0QmmY
X-Gm-Gg: ASbGncvbEgqMebYB2OiJ7ANEpRET2daHWeF6NkSb3rBgmLtUcy9vm1XF7O60X9DUwe4
	ATq6e2E6KccF0CLc6PsH8nQKlN7x7FTiboRRREzxvekLnjRDKi9r9KaP9nMLBYWPbUeCCk24dwk
	nzjox8SbCxcUQJmtZUM3Ka3+6XFvUSIuCh56wf0w1qcRlOKvfGynCIWTfpfdARQR5ZC82wEOmVa
	2rK4Z9xea+iTnLvLmhpN33NNsNa6W9EZOH9gTWNWg5ff7t1yN90dlVbwnraqw==
X-Google-Smtp-Source: AGHT+IEHrs850EG3XMez/7ngys4coZSDbG9AXxNVFTWtUr9iNSb9QVL8mjJjo5KQMcuY6Vt1JkM1o+A/H66y4AjU968=
X-Received: by 2002:a17:903:3d06:b0:274:1a09:9553 with SMTP id
 d9443c01a7336-29087a16a7fmr1160785ad.6.1760477597088; Tue, 14 Oct 2025
 14:33:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013235259.589015-1-kaleshsingh@google.com>
 <20251013235259.589015-2-kaleshsingh@google.com> <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
In-Reply-To: <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
From: Kalesh Singh <kaleshsingh@google.com>
Date: Tue, 14 Oct 2025 14:33:05 -0700
X-Gm-Features: AS18NWDEXIzf0W_8NyXmtodW3cUhtebQNJZvZW7z0zEtzur244eg_ScikaZgMeo
Message-ID: <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit checks
To: Hugh Dickins <hughd@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, lorenzo.stoakes@oracle.com, 
	david@redhat.com, Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
	kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org, 
	SeongJae Park <sj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, 
	Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 11:28=E2=80=AFPM Hugh Dickins <hughd@google.com> wr=
ote:
>
> On Mon, 13 Oct 2025, Kalesh Singh wrote:
>
> > The VMA count limit check in do_mmap() and do_brk_flags() uses a
> > strict inequality (>), which allows a process's VMA count to exceed
> > the configured sysctl_max_map_count limit by one.
> >
> > A process with mm->map_count =3D=3D sysctl_max_map_count will incorrect=
ly
> > pass this check and then exceed the limit upon allocation of a new VMA
> > when its map_count is incremented.
> >
> > Other VMA allocation paths, such as split_vma(), already use the
> > correct, inclusive (>=3D) comparison.
> >
> > Fix this bug by changing the comparison to be inclusive in do_mmap()
> > and do_brk_flags(), bringing them in line with the correct behavior
> > of other allocation paths.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: <stable@vger.kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > Acked-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes in v3:
> >  - Collect Reviewed-by and Acked-by tags.
> >
> > Changes in v2:
> >  - Fix mmap check, per Pedro
> >
> >  mm/mmap.c | 2 +-
> >  mm/vma.c  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 644f02071a41..da2cbdc0f87b 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned l=
ong addr,
> >               return -EOVERFLOW;
> >
> >       /* Too many mappings? */
> > -     if (mm->map_count > sysctl_max_map_count)
> > +     if (mm->map_count >=3D sysctl_max_map_count)
> >               return -ENOMEM;
> >
> >       /*
> > diff --git a/mm/vma.c b/mm/vma.c
> > index a2e1ae954662..fba68f13e628 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -2797,7 +2797,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct=
 vm_area_struct *vma,
> >       if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
> >               return -ENOMEM;
> >
> > -     if (mm->map_count > sysctl_max_map_count)
> > +     if (mm->map_count >=3D sysctl_max_map_count)
> >               return -ENOMEM;
> >
> >       if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> > --
> > 2.51.0.760.g7b8bcc2412-goog
>
> Sorry for letting you go so far before speaking up (I had to test what
> I believed to be true, and had hoped that meanwhile one of your many
> illustrious reviewers would say so first, but no): it's a NAK from me.
>
> These are not off-by-ones: at the point of these checks, it is not
> known whether an additional map/vma will have to be added, or the
> addition will be merged into an existing map/vma.  So the checks
> err on the lenient side, letting you get perhaps one more than the
> sysctl said, but not allowing any more than that.
>
> Which is all that matters, isn't it? Limiting unrestrained growth.
>
> In this patch you're proposing to change it from erring on the
> lenient side to erring on the strict side - prohibiting merges
> at the limit which have been allowed for many years.
>
> Whatever one thinks about the merits of erring on the lenient versus
> erring on the strict side, I see no reason to make this change now,
> and most certainly not with a Fixes Cc: stable. There is no danger
> in the current behaviour; there is danger in prohibiting what was
> allowed before.
>
> As to the remainder of your series: I have to commend you for doing
> a thorough and well-presented job, but I cannot myself see the point in
> changing 21 files for what almost amounts to a max_map_count subsystem.
> I call it misdirected effort, not at all to my taste, which prefers the
> straightforward checks already there; but accept that my taste may be
> out of fashion, so won't stand in the way if others think it worthwhile.

Hi Hugh,

Thanks for the detailed review and for taking the time to test the behavior=
.

You've raised a valid point. I wasn't aware of the history behind the
lenient check for merges. The lack of a comment, like the one that
exists for exceeding the limit in munmap(), led me to misinterpret
this as an off-by-one bug. The convention makes sense if we consider
potential merges.

If it was in-fact the intended behavior, then I agree we should keep
it lenient. It would mean though, that munmap() being able to free a
VMA if a split is required (by permitting exceeding the limit by 1)
would not work in the case where we have already exceeded the limit. I
find this to be inconsistent but this is also the current behavior ...

I will drop this patch and the patch that introduces the
vma_count_remaining() helper, as I see your point about it potentially
being unnecessary overhead.

Regarding your feedback on the rest of the series, I believe the 3
remaining patches are still valuable on their own.

 - The selftest adds a comprehensive tests for VMA operations at the
sysctl_max_map_count limit. This will self-document the exact behavior
expected, including the leniency for potential merges that you
highlighted, preventing the kind of misunderstanding that led to my
initial patch.

 - The rename of mm_struct->map_count to vma_count, is a
straightforward cleanup for code clarity that makes the purpose of the
field more explicit.

 - The tracepoint adds needed observability for telemetry, allowing us
to see when processes are failing in the field due to VMA count limit.

The  selftest, is what  makes up a large portion of the diff you
sited, and with vma_count_remaining() gone the series will not touch
nearly as many files.

Would this be an acceptable path forward?

Thanks,
Kalesh

>
> Hugh
