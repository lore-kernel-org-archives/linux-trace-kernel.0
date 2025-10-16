Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B5D20ADF8
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Oct 2025 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760591137; cv=none; b=dM3PH910dFpjpZWLXrxcp3B9/UPhZ/2TuOQqlqp5/3K+ySibF2szEppAJnkr+RkWbrIWaQ7EZuArJef98ivXdcGam2W1WB4RH/+9i9QKodGC3Kq0jdVEZUhn/Pi+FeKLTglFOgiL1b7MJ49qUp5z4wlvcUuMFNQEnQlsxhpVmKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760591137; c=relaxed/simple;
	bh=v/niRFXGHLbuHdz9SVJ/KCn6aLK8QZaKQTmiLUVJvaw=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=GoWcpv8tLyOGKUFG/Rj6b42xbHu4/uhRXo4xMf3FsaNYiK0hMa5oNDeoORRs+EXXCZDDCSKZ22lAuK/zjDD2H6hPv4YOWaJHCXACokJXt/aG9Ze64pznB7M1FpjFp+8MDoq5jN6Wfb7ed5YO9clotVWWZJBvWkHiSlo0jtK+ADA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BPE3gqlm; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BPE3gqlm"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-781421f5bf5so3389027b3.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 22:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760591134; x=1761195934; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=SL78+SZbXELe5OjpiYZ40otsTW6VBbAoBUm1tT/or+E=;
        b=BPE3gqlmQf+4JlGxMT7EW2MW0GM5EFCnc6GDMGjXh/G5oRjtztsh9oMVU00h20CBqQ
         IyY1rF330o3VZzVb7qjj6NltbD9EvEYrxoqcF2fQDhMyFzsGcBmTE7WObD6P+viqa85U
         v5QBqzupTD4aoxHlK1kEsFk+D3AyHMYoP9S0yV5tiPXymD82uR4Fwh67Uj98fbrs4wsd
         xU5Ao4N24rPCeJVVnmbXKrX1wfHcsRRJdCEjbD6CGEDlY2KELLYAG/P0gp01BWBj5k/G
         31dAxzlFE6XmcxHpAYtcr1M+LHdyskdXQovGGS6rqX7n0/+Qj7NUDYEAuTJYrA2lbzVO
         ZasQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760591134; x=1761195934;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SL78+SZbXELe5OjpiYZ40otsTW6VBbAoBUm1tT/or+E=;
        b=RyxxATQsLWZ93bQhypXqEAg7sdLk3LJ3Viwxk8rvscCdbac8OWGQ5XXe9Pn/n3eoBt
         sSgZYZ7D2hR3cdhaS17VFfCnnX+9+lW63FOBeMBTocVuk7BJUkWqOgR3NiHj4OjHSMoH
         odEPq42AD+qBEur6yFk27TRkoZJR4REKW0RXLlkIa4A3utHKM4422plwUw8aaaTsi4yY
         n+bCt4Okq0WfYdz+6p1y/UpnNZMtzcWYq/9XkYTNBYhxG2QpeyiSZVpap7ZToQ3ECpXD
         1y89Y3pgy2cpo/cmDPcusGTJmVawDJ15RLutWNO40+pmLcHBo8CEiRPopaNqh9ny1Nfz
         RWsg==
X-Forwarded-Encrypted: i=1; AJvYcCUNJxWjHgVLzixBhCuqTaUtj6cEflWA3U1nLMVgaSnU0vn1vs5yJt0rab5ZDMnFZkXIHi4BeQ/39kHxmJAfpvzWlJE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0potDG5mRETRQN9Epb+c0Ca/xxLZiMmEyXkC0YZKSN6M8CEyz
	jz5tR/iYaw3iyWs8FqY6UvLImeMzzVFKs6Gdd1UFvum2gEGhEBSfo/DlaaFJvTLA6w==
X-Gm-Gg: ASbGncsjclsqOjOEtTcR6bPKOSyVH7QDDSWqrQMiYzTrWyDh+OaqacaJSGKwzZKOHnN
	/BTqumLR1xvRH9/0XXSBxoloUVdAialO9yhet/eKgRatpcFo0wmmjeQ+y1E/CVFYULWSf84rL3x
	CU+iziawjPNc4bn466mA92x6NOD0f0RYcX1UMVjIfczGnQ5zu67KLr/Q2CwLlnttYwUWUKvCuKM
	t1exhS7UtPtMNverbMTbYxO6LbP1zgH+NXP/gmLa1ALHYQeR4IwMIgHM9eQpAga+9nMDd0ClKVk
	/JKN1cCk2Gaoi+kMzvWySfNWQDCeRPUEaoNAnZFqCdxVWmDJ8oLqNe4e+y+v3rNdljdrfRyUrAu
	rQUiD+OayexqM/qpz1gj4vKCVsjkfZDlORNI3HvusXo8qiQveaG63slUWgp+3cpW+s60tNJTnTx
	frGAyyJxuqzBT0qVfKPqhNATGTgbbXYjJZ6kZvHyuHpdngNqC8v4ja6pCOtI4TEmM2sgTkkiF/L
	CCAQC8Egh8bwEY=
X-Google-Smtp-Source: AGHT+IGKHjTCfZs9WliaOHICesM+L1X3EuoBynLJInRo210xgEeIFS6mewEtS3BfqWgQnxUg9wNNRQ==
X-Received: by 2002:a05:690c:670b:b0:783:116b:fc5 with SMTP id 00721157ae682-783116b1024mr9954377b3.33.1760591134146;
        Wed, 15 Oct 2025 22:05:34 -0700 (PDT)
Received: from darker.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7828d7b9deesm4928007b3.26.2025.10.15.22.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 22:05:32 -0700 (PDT)
Date: Wed, 15 Oct 2025 22:05:20 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Kalesh Singh <kaleshsingh@google.com>
cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org, 
    minchan@kernel.org, lorenzo.stoakes@oracle.com, david@redhat.com, 
    Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de, 
    kernel-team@android.com, android-mm@google.com, stable@vger.kernel.org, 
    SeongJae Park <sj@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
    Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
    Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
    Masami Hiramatsu <mhiramat@kernel.org>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
    Juri Lelli <juri.lelli@redhat.com>, 
    Vincent Guittot <vincent.guittot@linaro.org>, 
    Dietmar Eggemann <dietmar.eggemann@arm.com>, 
    Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
    Valentin Schneider <vschneid@redhat.com>, Shuah Khan <shuah@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
    linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
    linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit
 checks
In-Reply-To: <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com>
Message-ID: <af0618c0-03c5-9133-bb14-db8ddb72b8de@google.com>
References: <20251013235259.589015-1-kaleshsingh@google.com> <20251013235259.589015-2-kaleshsingh@google.com> <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com> <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463770367-1513627236-1760591132=:18627"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463770367-1513627236-1760591132=:18627
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 14 Oct 2025, Kalesh Singh wrote:
> On Mon, Oct 13, 2025 at 11:28=E2=80=AFPM Hugh Dickins <hughd@google.com> =
wrote:
> >
> > Sorry for letting you go so far before speaking up (I had to test what
> > I believed to be true, and had hoped that meanwhile one of your many
> > illustrious reviewers would say so first, but no): it's a NAK from me.
> >
> > These are not off-by-ones: at the point of these checks, it is not
> > known whether an additional map/vma will have to be added, or the
> > addition will be merged into an existing map/vma.  So the checks
> > err on the lenient side, letting you get perhaps one more than the
> > sysctl said, but not allowing any more than that.
> >
> > Which is all that matters, isn't it? Limiting unrestrained growth.
> >
> > In this patch you're proposing to change it from erring on the
> > lenient side to erring on the strict side - prohibiting merges
> > at the limit which have been allowed for many years.
> >
> > Whatever one thinks about the merits of erring on the lenient versus
> > erring on the strict side, I see no reason to make this change now,
> > and most certainly not with a Fixes Cc: stable. There is no danger
> > in the current behaviour; there is danger in prohibiting what was
> > allowed before.
> >
> > As to the remainder of your series: I have to commend you for doing
> > a thorough and well-presented job, but I cannot myself see the point in
> > changing 21 files for what almost amounts to a max_map_count subsystem.
> > I call it misdirected effort, not at all to my taste, which prefers the
> > straightforward checks already there; but accept that my taste may be
> > out of fashion, so won't stand in the way if others think it worthwhile=
=2E
>=20
> Hi Hugh,
>=20
> Thanks for the detailed review and for taking the time to test the behavi=
or.
>=20
> You've raised a valid point. I wasn't aware of the history behind the
> lenient check for merges. The lack of a comment, like the one that
> exists for exceeding the limit in munmap(), led me to misinterpret
> this as an off-by-one bug. The convention makes sense if we consider
> potential merges.

Yes, a comment there would be helpful (and I doubt it's worth more
than adding a comment); but I did not understand at all, Liam's
suggestion for the comment "to state that the count may not change".

>=20
> If it was in-fact the intended behavior, then I agree we should keep
> it lenient. It would mean though, that munmap() being able to free a
> VMA if a split is required (by permitting exceeding the limit by 1)
> would not work in the case where we have already exceeded the limit. I
> find this to be inconsistent but this is also the current behavior ...

You're saying that once we go one over the limit, say with a new mmap,
an munmap check makes it impossible to munmap that or any other vma?

If that's so, I do agree with you, that's nasty, and I would hate any
new code to behave that way.  In code that's survived as long as this
without troubling anyone, I'm not so sure: but if it's easily fixed
(a more lenient check at the munmap end?) that would seem worthwhile.

Ah, but reading again, you say "if a split is required": I guess
munmapping the whole vma has no problem; and it's fine for a middle
munmap, splitting into three before munmapping the middle, to fail.
I suppose it would be nicer if munmaping start or end succeeeded,
but I don't think that matters very much in this case.

>=20
> I will drop this patch and the patch that introduces the
> vma_count_remaining() helper, as I see your point about it potentially
> being unnecessary overhead.
>=20
> Regarding your feedback on the rest of the series, I believe the 3
> remaining patches are still valuable on their own.
>=20
>  - The selftest adds a comprehensive tests for VMA operations at the
> sysctl_max_map_count limit. This will self-document the exact behavior
> expected, including the leniency for potential merges that you
> highlighted, preventing the kind of misunderstanding that led to my
> initial patch.
>=20
>  - The rename of mm_struct->map_count to vma_count, is a
> straightforward cleanup for code clarity that makes the purpose of the
> field more explicit.
>=20
>  - The tracepoint adds needed observability for telemetry, allowing us
> to see when processes are failing in the field due to VMA count limit.
>=20
> The  selftest, is what  makes up a large portion of the diff you
> sited, and with vma_count_remaining() gone the series will not touch
> nearly as many files.
>=20
> Would this be an acceptable path forward?

Possibly, if others like it: my concern was to end a misunderstanding
(I'm generally much too slow to get involved in cleanups).

Though given that the sysctl is named "max_map_count", I'm not very
keen on renaming everything else from map_count to vma_count
(and of course I'm not suggesting to rename the sysctl).

Hugh
---1463770367-1513627236-1760591132=:18627--
