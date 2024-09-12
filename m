Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BE813CFB7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Sep 2024 21:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726175061; cv=none; b=hujMevm8djc/aly4Pm0A59FjPT/Ve2MP0YLjN4W5k+ktUMHLvD8Hn0QdtOH+nP67OWcTz7XexVNhksfdZccuLHFMzFZanPZQhB9Ii9ykIreFBoIU8Lce7lWPFQL28V+YePVO+2dKBBcq5QcH17wkP7v4seWtPPctr+p4aM2z2cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726175061; c=relaxed/simple;
	bh=vM4ejuzZFoGQ4IIqaqzuyaHUU/1X4Ko8fl7eEhkQ/UU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F+I+sqz8A8qn1FODQS4UPbEfiK0HhFA6VMVDnNhTxPyF/X/PaV9CBndvnQ/9l2zUZQCbPH4HIg7TprbpqLYoPVKPklarFJ0zFapwPXlfRNf1dYwL8D1uXTOgEDPlKA+ygZ5iTXoFEdzgCxOGNYSvvEN2wVun6BqGE6numLcOHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z0Q1MNMh; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z0Q1MNMh"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c24374d8b6so3296a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Sep 2024 14:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726175057; x=1726779857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z9VsB68MQof9g4wA1cKKKrr59DMnuyJ0zAwUPhXjwPI=;
        b=Z0Q1MNMhdGcLjS/s2eLQVEwqfCz+U/DXu4wqoIZ6xY22Bq0Kxcuyv3ASr2L/LKbWZi
         L0UV4Ul8yAd+T76vlyB7FZGpvNT+3KYe7t+xUT4BXfJanG5Y6O068hjTZrDfaCXNspQr
         OZxnV7Q/B262+8wcg5Wu9ODYjA4kqRBO/bvOh+KAjeTFz/4eQDD/A7MaHelg20Q73OJV
         Z6osNAPdyYPvzeGqG/QMBvYbOvRMud9HAjI+pyZ3LqYP+JlhE56zGnOsmklYHEMAIbjr
         TsNy+sYUAW6eKGEUu00E8+VWuTwoAnb8JCd7NRCmMk9Y5kXXAxTJlGun7CFk817q8+FI
         qLvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726175057; x=1726779857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z9VsB68MQof9g4wA1cKKKrr59DMnuyJ0zAwUPhXjwPI=;
        b=et4+OUQGR0CXbiTixL8/IW92mo1LPaCc8DnFlofMx+eA3NcZsaiJ71+DVZ+WPKaYNG
         Uzi/LEsa01UcknrTpfG4KSm6LManaWhARq9iOT6q77VDo3XXT+NoioHNkVmwetlsqJxd
         7TuX6Ct24ZcZNIF+xmJyOm+Djha+TmFWK90RI7jOkv/7mAUFJKpYzV/x9mAFF/D3eWSC
         WvwnxgqJzLMj697S3Lu4duTY+8zH+oz9Tbl+Wsu1JUOWHQ0KVwadzt4f/ktPv78zlFWN
         F0iGUiTDUwlYclN2OHmvNr/Nl4uLL38nRkxPRaqQNvz1tZdMi2amz1GHfXN07+dGE6JR
         cWmg==
X-Gm-Message-State: AOJu0Yz1IV4xWravkzXEDw0NIYde3YMSVcBNLmXBCujMy7QF+aBoG9sC
	cyxuAu+5x3X07GYdHA1yLO7j8T2xwmeNZB0ENiukH4ZqXUpHWlj3TrwZC3XXKmTycViSarnt2uL
	KBMhVzs10aN9AZwAxrURMaqDd0n5HWDl2QP9qcO6Ztbi6Vz5icg==
X-Google-Smtp-Source: AGHT+IFLf7AFcbkAtsWFWFjzpfStlqHufGs3sxLk2dIi+9wgBc3dInwrl75rUyYqCfZRJ/a24Knz1XzFxhyJ/z86Zyo=
X-Received: by 2002:a05:6402:27c7:b0:5c2:5641:af79 with SMTP id
 4fb4d7f45d1cf-5c414384e17mr488780a12.0.1726175055955; Thu, 12 Sep 2024
 14:04:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJuCfpFFqqUWYOob_WYG_aY=PurnKvZjxznnx7V0=ESbNzHr_w@mail.gmail.com>
 <20240912210222.186542-1-surenb@google.com>
In-Reply-To: <20240912210222.186542-1-surenb@google.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 12 Sep 2024 14:04:00 -0700
Message-ID: <CAJuCfpGgoSYmGSdcf+fZF1mUeNo-M=fzfk7G6ATs5-0TT+zkfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] mm: introduce mmap_lock_speculation_{start|end}
To: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com
Cc: rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, akpm@linux-foundation.org, linux-mm@kvack.org, 
	mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, andrii@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 2:02=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> Add helper functions to speculatively perform operations without
> read-locking mmap_lock, expecting that mmap_lock will not be
> write-locked and mm is not modified from under us.

Here you go. I hope I got the ordering right this time around, but I
would feel much better if Jann reviewed it before it's included in
your next patchset :)
Thanks,
Suren.

>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
> Changes since v1 [1]:
> - Made memory barriers in inc_mm_lock_seq and mmap_lock_speculation_end
> more strict, per Jann Horn
>
> [1] https://lore.kernel.org/all/20240906051205.530219-2-andrii@kernel.org=
/
>
>  include/linux/mm_types.h  |  3 ++
>  include/linux/mmap_lock.h | 74 ++++++++++++++++++++++++++++++++-------
>  kernel/fork.c             |  3 --
>  3 files changed, 65 insertions(+), 15 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 6e3bdf8e38bc..5d8cdebd42bc 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -887,6 +887,9 @@ struct mm_struct {
>                  * Roughly speaking, incrementing the sequence number is
>                  * equivalent to releasing locks on VMAs; reading the seq=
uence
>                  * number can be part of taking a read lock on a VMA.
> +                * Incremented every time mmap_lock is write-locked/unloc=
ked.
> +                * Initialized to 0, therefore odd values indicate mmap_l=
ock
> +                * is write-locked and even values that it's released.
>                  *
>                  * Can be modified under write mmap_lock using RELEASE
>                  * semantics.
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index de9dc20b01ba..a281519d0c12 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -71,39 +71,86 @@ static inline void mmap_assert_write_locked(const str=
uct mm_struct *mm)
>  }
>
>  #ifdef CONFIG_PER_VMA_LOCK
> +static inline void init_mm_lock_seq(struct mm_struct *mm)
> +{
> +       mm->mm_lock_seq =3D 0;
> +}
> +
>  /*
> - * Drop all currently-held per-VMA locks.
> - * This is called from the mmap_lock implementation directly before rele=
asing
> - * a write-locked mmap_lock (or downgrading it to read-locked).
> - * This should normally NOT be called manually from other places.
> - * If you want to call this manually anyway, keep in mind that this will=
 release
> - * *all* VMA write locks, including ones from further up the stack.
> + * Increment mm->mm_lock_seq when mmap_lock is write-locked (ACQUIRE sem=
antics)
> + * or write-unlocked (RELEASE semantics).
>   */
> -static inline void vma_end_write_all(struct mm_struct *mm)
> +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire)
>  {
>         mmap_assert_write_locked(mm);
>         /*
>          * Nobody can concurrently modify mm->mm_lock_seq due to exclusiv=
e
>          * mmap_lock being held.
> -        * We need RELEASE semantics here to ensure that preceding stores=
 into
> -        * the VMA take effect before we unlock it with this store.
> -        * Pairs with ACQUIRE semantics in vma_start_read().
>          */
> -       smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +
> +       if (acquire) {
> +               WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +               /*
> +                * For ACQUIRE semantics we should ensure no following st=
ores are
> +                * reordered to appear before the mm->mm_lock_seq modific=
ation.
> +                */
> +               smp_wmb();
> +       } else {
> +               /*
> +                * We need RELEASE semantics here to ensure that precedin=
g stores
> +                * into the VMA take effect before we unlock it with this=
 store.
> +                * Pairs with ACQUIRE semantics in vma_start_read().
> +                */
> +               smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +       }
> +}
> +
> +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int=
 *seq)
> +{
> +       /* Pairs with RELEASE semantics in inc_mm_lock_seq(). */
> +       *seq =3D smp_load_acquire(&mm->mm_lock_seq);
> +       /* Allow speculation if mmap_lock is not write-locked */
> +       return (*seq & 1) =3D=3D 0;
> +}
> +
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int s=
eq)
> +{
> +       /* Pairs with ACQUIRE semantics in inc_mm_lock_seq(). */
> +       smp_rmb();
> +       return seq =3D=3D READ_ONCE(mm->mm_lock_seq);
>  }
> +
>  #else
> -static inline void vma_end_write_all(struct mm_struct *mm) {}
> +static inline void init_mm_lock_seq(struct mm_struct *mm) {}
> +static inline void inc_mm_lock_seq(struct mm_struct *mm, bool acquire) {=
}
> +static inline bool mmap_lock_speculation_start(struct mm_struct *mm, int=
 *seq) { return false; }
> +static inline bool mmap_lock_speculation_end(struct mm_struct *mm, int s=
eq) { return false; }
>  #endif
>
> +/*
> + * Drop all currently-held per-VMA locks.
> + * This is called from the mmap_lock implementation directly before rele=
asing
> + * a write-locked mmap_lock (or downgrading it to read-locked).
> + * This should normally NOT be called manually from other places.
> + * If you want to call this manually anyway, keep in mind that this will=
 release
> + * *all* VMA write locks, including ones from further up the stack.
> + */
> +static inline void vma_end_write_all(struct mm_struct *mm)
> +{
> +       inc_mm_lock_seq(mm, false);
> +}
> +
>  static inline void mmap_init_lock(struct mm_struct *mm)
>  {
>         init_rwsem(&mm->mmap_lock);
> +       init_mm_lock_seq(mm);
>  }
>
>  static inline void mmap_write_lock(struct mm_struct *mm)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write(&mm->mmap_lock);
> +       inc_mm_lock_seq(mm, true);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
> @@ -111,6 +158,7 @@ static inline void mmap_write_lock_nested(struct mm_s=
truct *mm, int subclass)
>  {
>         __mmap_lock_trace_start_locking(mm, true);
>         down_write_nested(&mm->mmap_lock, subclass);
> +       inc_mm_lock_seq(mm, true);
>         __mmap_lock_trace_acquire_returned(mm, true, true);
>  }
>
> @@ -120,6 +168,8 @@ static inline int mmap_write_lock_killable(struct mm_=
struct *mm)
>
>         __mmap_lock_trace_start_locking(mm, true);
>         ret =3D down_write_killable(&mm->mmap_lock);
> +       if (!ret)
> +               inc_mm_lock_seq(mm, true);
>         __mmap_lock_trace_acquire_returned(mm, true, ret =3D=3D 0);
>         return ret;
>  }
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 61070248a7d3..c86e87ed172b 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1259,9 +1259,6 @@ static struct mm_struct *mm_init(struct mm_struct *=
mm, struct task_struct *p,
>         seqcount_init(&mm->write_protect_seq);
>         mmap_init_lock(mm);
>         INIT_LIST_HEAD(&mm->mmlist);
> -#ifdef CONFIG_PER_VMA_LOCK
> -       mm->mm_lock_seq =3D 0;
> -#endif
>         mm_pgtables_bytes_init(mm);
>         mm->map_count =3D 0;
>         mm->locked_vm =3D 0;
>
> base-commit: 015bdfcb183759674ba1bd732c3393014e35708b
> --
> 2.46.0.662.g92d0881bb0-goog
>
