Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D10A1C1AB5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Sep 2024 22:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726179906; cv=none; b=q5lR8211OqnHSnCIYfUBY0j4VlNOXM7dFAEzmMVKYj2OeYDXOQrcbQpxS3R+2L4sjaMvr8EeNd4hV5qrhlPmvmBsyPvn1IFw9NW/5D47LmyBLO4g2rdS9QGSHep0US2akwPQjESHrZptK+NNRvjSF511VYV3LrkPsoF/Q2RvMoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726179906; c=relaxed/simple;
	bh=k4RUb5K2Gl6RWzD0JV2UJUW93MljZZq1yD8YMdk19tQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hsxXHyBBtsCWt2kNaeXw7WwE8YzW3jJ3SEKV55NvzaObmNwKmpCaKJw6CgbmteUPesL2WBNrh1k+K6EddfQezyjUkrIgQvGYBkCmNePQekRPCuQCTrsbHmG06vZSm4ufxkIqgI2e2vkd4xmLLqea7q65BDDEDZd7F0ssdIIw3Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3FDrgOR4; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3FDrgOR4"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c24374d8b6so5360a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Sep 2024 15:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726179903; x=1726784703; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r08X9SW48hwdcFyWCetupv6po9aUVBR2VI/xglM7xt0=;
        b=3FDrgOR4sbK0dPP2q+GFL9DH422ABM/Xi14FjKP4IjG2Mw2Gzl2yVx0/UhCMVNMvrv
         oFg38BFnqEy0bkAb9Q0BCAPL6MwGFwMETLIOpBuiKdiBucO9clgLFAsgOQ8qWPaP7X6C
         GrT+XYsitd8hGa/kXiJkOJiY1ZMARgTZs6oGXMQ/AX/SMJNFuWo8kJr4prpKw3ay2oBi
         WgfLEWvmxPp+a75JOZps8/5Qm8Zr7t2N25RsUJQD1dPsnqdze4HIXWtqzHwDcWZE+Ydp
         LYgjALWOUkwtzmMc2yTcMcNWXwgbJPbevTkr6YfaYvobch7Tae0UFJhL0cWS9WV9t7M0
         rZCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726179903; x=1726784703;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r08X9SW48hwdcFyWCetupv6po9aUVBR2VI/xglM7xt0=;
        b=c7D4enISNIzpWyjDOfVxk6vpy8aPGKFTVivt78gcb6iultj7fN1PMhQmfdzTr838Mh
         8PW0zMGVTW9GT9up18pS/FLteC1YCl2iPtS/m7quc3Ot5VlfpQVL1Dm+x6GB8UVGSDsk
         fTIxBFekR1hq9eaC6PYS/Pr2maexT7keyEQkwzyE06Pnmd55xcYAf1cdYlf1w45psiMH
         M4+0RgmHUmivOLMTKQCGwoc6ilGYzC/szMD68TTQlqF40V63/+cPF6KJX6Z+ZoIeDDGC
         JnMIf1TU8RVz+HHZeiArZD9Dc+nADm20lxAl3v7IKDE/HFyJrbC4OfiKilgU4KY77MjS
         heOw==
X-Gm-Message-State: AOJu0Yz2UK9fRdseUdVQE7KL6jqkgXf36JvkTzOCJZlyJiVzAmyy8BEZ
	JbvSyZNJTkPPanWDUCpMNiNkW5bNfBUbt4ss995oS3+OTlnnV2nps/qK3nznecFeUY+kIRiADVp
	NvLWLNOtQIGW7FWWXQNV2w9rktS0fNiX8KsjB
X-Google-Smtp-Source: AGHT+IGbXWMb8f+8TB0Fh3tbR8FGyTaM8DKVaS1fc+Rx1XvEkBhuc+66BgyT2RB36WIwNd5YLWgX7TxErR5Lw/uLj4E=
X-Received: by 2002:a05:6402:2688:b0:5c2:5629:5fbb with SMTP id
 4fb4d7f45d1cf-5c415db646fmr471514a12.1.1726179902448; Thu, 12 Sep 2024
 15:25:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
 <20240912210222.186542-1-surenb@google.com> <CAJuCfpGgoSYmGSdcf+fZF1mUeNo-M=fzfk7G6ATs5-0TT+zkfQ@mail.gmail.com>
 <CAEf4BzZTaS3jeUvBiAdH8x6N71fkxJYT7ohPYPKqfSyJZ=NGog@mail.gmail.com>
In-Reply-To: <CAEf4BzZTaS3jeUvBiAdH8x6N71fkxJYT7ohPYPKqfSyJZ=NGog@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Sep 2024 15:24:50 -0700
Message-ID: <CAJuCfpE52UO=XCbMh_mE1oMUsnUzf3-uxHHjoWu=tTFzWQ=J4Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 3:20=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Thu, Sep 12, 2024 at 2:04=E2=80=AFPM Suren Baghdasaryan <surenb@google=
.com> wrote:
> >
> > On Thu, Sep 12, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb@goog=
le.com> wrote:
> > >
> > > Add helper functions to speculatively perform operations without
> > > read-locking mmap_lock, expecting that mmap_lock will not be
> > > write-locked and mm is not modified from under us.
> >
> > Here you go. I hope I got the ordering right this time around, but I
> > would feel much better if Jann reviewed it before it's included in
> > your next patchset :)
>
> Thanks a lot! And yes, I'll give it a bit of time for reviews before
> sending a new revision.
>
> Did you by any chance get any new ideas for possible benchmarks
> (beyond what I did with will-it-scale)?

Hmm. You could use Mel Gorman's mmtests suite I guess.

>
>
> > Thanks,
> > Suren.
> >
> > >
> > > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> > > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > > ---
> > > Changes since v1 [1]:
> > > - Made memory barriers in inc_mm_lock_seq and mmap_lock_speculation_e=
nd
> > > more strict, per Jann Horn
> > >
> > > [1] https://lore.kernel.org/all/20240906051205.530219-2-andrii@kernel=
.org/
> > >
> > >  include/linux/mm_types.h  |  3 ++
> > >  include/linux/mmap_lock.h | 74 ++++++++++++++++++++++++++++++++-----=
--
> > >  kernel/fork.c             |  3 --
> > >  3 files changed, 65 insertions(+), 15 deletions(-)
> > >
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 6e3bdf8e38bc..5d8cdebd42bc 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -887,6 +887,9 @@ struct mm_struct {
> > >                  * Roughly speaking, incrementing the sequence number=
 is
> > >                  * equivalent to releasing locks on VMAs; reading the=
 sequence
> > >                  * number can be part of taking a read lock on a VMA.
> > > +                * Incremented every time mmap_lock is write-locked/u=
nlocked.
> > > +                * Initialized to 0, therefore odd values indicate mm=
ap_lock
> > > +                * is write-locked and even values that it's released=
.
> > >                  *
> > >                  * Can be modified under write mmap_lock using RELEAS=
E
> > >                  * semantics.
> > > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > > index de9dc20b01ba..a281519d0c12 100644
> > > --- a/include/linux/mmap_lock.h
> > > +++ b/include/linux/mmap_lock.h
> > > @@ -71,39 +71,86 @@ static inline void mmap_assert_write_locked(const=
 struct mm_struct *mm)
> > >  }
> > >
> > >  #ifdef CONFIG_PER_VMA_LOCK
> > > +static inline void init_mm_lock_seq(struct mm_struct *mm)
> > > +{
> > > +       mm->mm_lock_seq =3D 0;
> > > +}
> > > +
> > >  /*
> > > - * Drop all currently-held per-VMA locks.
> > > - * This is called from the mmap_lock implementation directly before =
releasing
> > > - * a write-locked mmap_lock (or downgrading it to read-locked).
> > > - * This should normally NOT be called manually from other places.
> > > - * If you want to call this manually anyway, keep in mind that this =
will release
> > > - * *all* VMA write locks, including ones from further up the stack.
> > > + * Increment mm->mm_lock_seq when mmap_lock is write-locked (ACQUIRE=
 semantics)
> > > + * or write-unlocked (RELEASE semantics).
> > >   */
> > > -static inline void vma_end_write_all(struct mm_struct *mm)
> > > +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquir=
e)
> > >  {
> > >         mmap_assert_write_locked(mm);
> > >         /*
> > >          * Nobody can concurrently modify mm->mm_lock_seq due to excl=
usive
> > >          * mmap_lock being held.
> > > -        * We need RELEASE semantics here to ensure that preceding st=
ores into
> > > -        * the VMA take effect before we unlock it with this store.
> > > -        * Pairs with ACQUIRE semantics in vma_start_read().
> > >          */
> > > -       smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > > +
> > > +       if (acquire) {
> > > +               WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> > > +               /*
> > > +                * For ACQUIRE semantics we should ensure no followin=
g stores are
> > > +                * reordered to appear before the mm->mm_lock_seq mod=
ification.
> > > +                */
> > > +               smp_wmb();
> > > +       } else {
> > > +               /*
> > > +                * We need RELEASE semantics here to ensure that prec=
eding stores
> > > +                * into the VMA take effect before we unlock it with =
this store.
> > > +                * Pairs with ACQUIRE semantics in vma_start_read().
> > > +                */
> > > +               smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq +=
 1);
> > > +       }
> > > +}
> > > +
> > > +static inline bool mmap_lock_speculation_start(struct mm_struct *mm,=
 int *seq)
> > > +{
> > > +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> > > +       *seq =3D smp_load_acquire(&mm->mm_lock_seq);
> > > +       /* Allow speculation if mmap_lock is not write-locked */
> > > +       return (*seq & 1) =3D=3D 0;
> > > +}
> > > +
> > > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, i=
nt seq)
> > > +{
> > > +       /* Pairs with ACQUIRE semantics in inc_mm_lock_seq(). */
> > > +       smp_rmb();
> > > +       return seq =3D=3D READ_ONCE(mm->mm_lock_seq);
> > >  }
> > > +
> > >  #else
> > > -static inline void vma_end_write_all(struct mm_struct *mm) {}
> > > +static inline void init_mm_lock_seq(struct mm_struct *mm) {}
> > > +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquir=
e) {}
> > > +static inline bool mmap_lock_speculation_start(struct mm_struct *mm,=
 int *seq) { return false; }
> > > +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, i=
nt seq) { return false; }
> > >  #endif
> > >
> > > +/*
> > > + * Drop all currently-held per-VMA locks.
> > > + * This is called from the mmap_lock implementation directly before =
releasing
> > > + * a write-locked mmap_lock (or downgrading it to read-locked).
> > > + * This should normally NOT be called manually from other places.
> > > + * If you want to call this manually anyway, keep in mind that this =
will release
> > > + * *all* VMA write locks, including ones from further up the stack.
> > > + */
> > > +static inline void vma_end_write_all(struct mm_struct *mm)
> > > +{
> > > +       inc_mm_lock_seq(mm, false);
> > > +}
> > > +
> > >  static inline void mmap_init_lock(struct mm_struct *mm)
> > >  {
> > >         init_rwsem(&mm->mmap_lock);
> > > +       init_mm_lock_seq(mm);
> > >  }
> > >
> > >  static inline void mmap_write_lock(struct mm_struct *mm)
> > >  {
> > >         __mmap_lock_trace_start_locking(mm, true);
> > >         down_write(&mm->mmap_lock);
> > > +       inc_mm_lock_seq(mm, true);
> > >         __mmap_lock_trace_acquire_returned(mm, true, true);
> > >  }
> > >
> > > @@ -111,6 +158,7 @@ static inline void mmap_write_lock_nested(struct =
mm_struct *mm, int subclass)
> > >  {
> > >         __mmap_lock_trace_start_locking(mm, true);
> > >         down_write_nested(&mm->mmap_lock, subclass);
> > > +       inc_mm_lock_seq(mm, true);
> > >         __mmap_lock_trace_acquire_returned(mm, true, true);
> > >  }
> > >
> > > @@ -120,6 +168,8 @@ static inline int mmap_write_lock_killable(struct=
 mm_struct *mm)
> > >
> > >         __mmap_lock_trace_start_locking(mm, true);
> > >         ret =3D down_write_killable(&mm->mmap_lock);
> > > +       if (!ret)
> > > +               inc_mm_lock_seq(mm, true);
> > >         __mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
> > >         return ret;
> > >  }
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 61070248a7d3..c86e87ed172b 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -1259,9 +1259,6 @@ static struct mm_struct *mm_init(struct mm_stru=
ct *mm, struct task_struct *p,
> > >         seqcount_init(&mm->write_protect_seq);
> > >         mmap_init_lock(mm);
> > >         INIT_LIST_HEAD(&mm->mmlist);
> > > -#ifdef CONFIG_PER_VMA_LOCK
> > > -       mm->mm_lock_seq =3D 0;
> > > -#endif
> > >         mm_pgtables_bytes_init(mm);
> > >         mm->map_count =3D 0;
> > >         mm->locked_vm =3D 0;
> > >
> > > base-commit: 015bdfcb183759674ba1bd732c3393014e35708b
> > > --
> > > 2.46.0.662.g92d0881bb0-goog
> > >
