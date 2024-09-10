Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FBC193097
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982319; cv=none; b=So4/HfaOziHDk3hDAzxPEbnZYDQWahQfmq6Yw1IGWJqgyFxPIhGlU4NiabUmCp1B3XeQaL2zxeXnn4TA1Poas/wnbcsl2ThOqXMIXbqeWmuf5j17CWXCjsXRNgWz217FDUYFaBPjNCAsUzUbE9T+F4xJISpP5vZFULcPXscogVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982319; c=relaxed/simple;
	bh=58vwLif2w0LcCxt3l9m+/yn4hsdJcrUKi4MUhjWQVNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JeEmZxQ6p7aFP3DdGeulNuIlyG1+yfxQan+b7eguRScpGc9xXLzR+sNqM9uwbkggbd3VsBvUI5hz0pj57Rcn2wkvMJYVsbAyNLkBzM4vfFy+jeHBk+PH/bqahjx7JnPuEqrUXSMps1Bo1ze9Zqe2dREerOcCvobE9LFZMvsMYAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rpLyggcg; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rpLyggcg"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53661d95508so25802e87.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725982315; x=1726587115; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11EJWGDdB3TRpoNJTX71d90zkEuZ3hMNes9yKkfvSyM=;
        b=rpLyggcglEoHYE2ZNtA8BzhU9mu6JmUzf3ioNcJLsNTuSenuz4522PpT2odQv9nRIV
         MTmgGT9K8KtuPBvXSH2CemZLOVyDXJubGPhnCgQ6M815DI3OtP1gxbZPUpC0uq4nL/pZ
         nA7b/iy68gmg+4FNPUCFH3j0n3B29zgCMoEgiovNLDIeeoyIbwseOvz5db0dUbUwBzKx
         Ca7IPMRhxyu2lrGcHFtufSJK0Uc6au11lcuP3DKMFfSd1v7AJZue5R0SWoTjNRKCT38J
         IHzfuGNHSUNgFO+uxuA173MPhY9vA0SVlRGP1bd463jE3DJ5Jk/ULHYWCYdfXNoTXRBN
         gdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725982315; x=1726587115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11EJWGDdB3TRpoNJTX71d90zkEuZ3hMNes9yKkfvSyM=;
        b=V/fIWRLlUkYx0V2VPXMRalvGfPWdznT3LY+jXFkJ29NjPSN1eWVRJfQZHTyfvLL3tj
         O6z3DMCYGkw7Qx5iH0fJCjyK0ets/6LJdsSbeGfrxejnZCRC+n2JJxydlJXSx8bbCxvf
         g+rKElOl7XJ1XGaUvt9gQcRGFzt+f/go0sVqZEUhc82dzgyvIXLVEqbKAI4RmopjiehJ
         uGGqF/UYgyYBdtLjZMfGvqHiwQHzxXJdGXxZbBpwC+sXtUAlFPgNT4EC8cIoPmENU+Sl
         MtSjV9/DzEwrgOdv3vwMxb2B2qR1FUy213Q5Fr9pbAdJ1WQeIt96UWYPsIvIZkhjxNTq
         uaUw==
X-Forwarded-Encrypted: i=1; AJvYcCWAW6CPEYseNXkWyg26zk5MRSMGDzI3qgqitycbjZw3RpCT5HtzZlnduo2Xf10oBCYRnh1TNceMhs3La+zKX4i8ycQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbkR7+dZQiGH7UzNvFBjmJ02Yo3q9zdJ9EV12AcXWBbx8ReyCA
	GLalCyOOyWvj4yNr9cie/kKVcQEYjLpP6xkNWUjjSepLo+RI/4feKCdaShmtf00jplBJnrxujMD
	aCHfcnrD55Ufw+WZQj4DCLHV0wJcaKPdkDdUa+ezjz/kTnEQg9ROg
X-Google-Smtp-Source: AGHT+IF7llpzPIrM5lV//xsMPBS037RtCLtLhRWp5fDTFuzae3HG0GApRNkf/Tgi/uVU1gb2WlLVcCtp5hQEeg5tgCQ=
X-Received: by 2002:a05:6512:1154:b0:52c:dd42:cf57 with SMTP id
 2adb3069b0e04-5366ca457ebmr607822e87.0.1725982315020; Tue, 10 Sep 2024
 08:31:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-2-andrii@kernel.org>
 <CAG48ez2hAQBj-VnimJBd3M-ioANVTk+ZQXYWD+j9G+ip2K_nfw@mail.gmail.com> <CAJuCfpFAvsMsBTBMaK5sHFkLQPrfE0nb401gEb2hmN2rbjza6g@mail.gmail.com>
In-Reply-To: <CAJuCfpFAvsMsBTBMaK5sHFkLQPrfE0nb401gEb2hmN2rbjza6g@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Sep 2024 17:31:16 +0200
Message-ID: <CAG48ez3MNkhCpwST1HH9tzZWusqk+YZaWHZ2v=sZnzMo1jk7Dw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: introduce mmap_lock_speculation_{start|end}
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	brauner@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:09=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
> On Mon, Sep 9, 2024 at 5:35=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > >  static inline void mmap_write_lock(struct mm_struct *mm)
> > >  {
> > >         __mmap_lock_trace_start_locking(mm, true);
> > >         down_write(&mm->mmap_lock);
> > > +       inc_mm_lock_seq(mm);
> > >         __mmap_lock_trace_acquire_returned(mm, true, true);
> > >  }
> >
> > Similarly, inc_mm_lock_seq(), which does a store-release, can only
> > provide "release lock" semantics, not "take lock" semantics, because
> > the CPU can reorder it with later stores; for example, this code:
> >
> > inc_mm_lock_seq()
> > [locked stuff goes here]
> > inc_mm_lock_seq()
> >
> > can be reordered into this:
> >
> > [locked stuff goes here]
> > inc_mm_lock_seq()
> > inc_mm_lock_seq()
> >
> > so the lock is broken.
>
> Ugh, yes. We do need smp_wmb() AFTER the inc_mm_lock_seq(). Whenever
> we use inc_mm_lock_seq() for "take lock" semantics, it's preceded by a
> down_write(&mm->mmap_lock) with implied ACQUIRE ordering. So I thought
> we can use it but I realize now that this reordering is still
> possible:
> CPU1                        CPU2
>                                  mmap_write_lock()
>                                        down_write(&mm->mmap_lock);
>                                        vma->vm_file =3D ...;
>
> mmap_lock_speculation_start() // seq =3D mm->mm_lock_seq
> <speculate>
> mmap_lock_speculation_end() // return (mm->mm_lock_seq =3D=3D seq)
>
>                                        inc_mm_lock_seq(mm);
>                                  mmap_write_unlock() // inc_mm_lock_seq(m=
m)
>
> Is that what you were describing?

Yeah, that's the scenario I was thinking of (though I did not spend
the time to look at the surroundings to see if there are other implied
barriers that happen to stop this).
