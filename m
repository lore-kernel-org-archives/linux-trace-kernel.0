Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1208619D09F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 15:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982799; cv=none; b=ArOXZVdLElxav6LB031BJK4HxanNDyMKcRfsxuUgSGMIV727DvoVvQap46LTy4YbHMXFWleVUtyEWeQX6SrTfrxHFdfTq6J0PMZlUGDskn+gwpmqptw/uWPI9VZVzCJAi8v6bdzU0cNefWOKx5OQaMOBcxA5QObLf8Wx2vTtLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982799; c=relaxed/simple;
	bh=Ns74kTojtvJ3PU+5k7XOrtvLmnYWyxeZra3a7dDi8iE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D32p+ka9KdAMR0EeTYF1X8EFCk0fbxtNZ20SWvSz5StmQ3ytV4wL7/HsrbV+PI5NW+sgNLbpa792WI1QCIe3WRTit8b+5yA/hdaI7kmo/P9Kq9Ol+62rZp0iFG+DemwtH0aD0LSegjq/E2B6+vgjLxnT7wNu4lIzQqf/FDynEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KkxX579T; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KkxX579T"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5c2460e885dso22188a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Sep 2024 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725982796; x=1726587596; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9XmuAJaJABZEw22g1YelxW3d7dMoKbStEXHVKcdE10Q=;
        b=KkxX579TxaUCdpv3p/X3uPjIhH+CxHKAgcQIGs9HnpX0OOrMynUY8OtofIpDB5eUf0
         azEtEdzkTPYOxdFxS7om6lDUN2d5fa8UnQE62D8Qzwmyo7XeeLEWNL7OsDNMpov/si5P
         GcLFlkaBy143E0ZadbhJ4PNwx9TBRLldISeOvgYzeFozDNhctNN5X0HEPA7VzqRgNYft
         x3OBlWBbC4rP1JqdYu7wfcEXGI+G0lWPhDIUnClihkR2dDHKx9Ut8a+DHw493XzcnZly
         FlEPJbn5X66cJSevugWXVwdxr4s6g4bdcYd9iXP6PpzIq57wsGgyv8rv8YvlTtWkW9xa
         ekpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725982796; x=1726587596;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9XmuAJaJABZEw22g1YelxW3d7dMoKbStEXHVKcdE10Q=;
        b=C/2LAwAUwwIJ84A4tJFGmGLLQsP7VgL0IUX+uyWolTQYPWqtrRi5KjwuxzGFac03ff
         bqqsgbE50YKm5uWz6DNoLOHefgXivp3w8Ci/F6svkYapglvWcHAkpSACMuQe7RuqaUDZ
         XUgugsIPp/GpJK2OKknY1VRok2LgeHH555CWd2lmeC6w6TQ++1wbsb2u53L3TUnRicGq
         2/6wxx+kCQSCd/DHwsVB5qauSj3EDVkxUGmZafy1/mnTrJaLpaLWakKhUvZcPDHc//13
         iMfXXhu4xZcFrPvF8FcUqvTb/3S+3QSt0urA10IRLX93NjZ8gbJHBUliVTcevcbIbn9u
         lnYw==
X-Forwarded-Encrypted: i=1; AJvYcCVYOBsTCyznbQpFTisNORf0fR8qRogZX0TbY6WWmnzGhXhiXdQkSSbREEF2U3HSULFB6+y6Vcg+XhI+AnYCzx6qsRU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvtMUoG1UZwijYDJsOrwALUGWa/h0tyap932J+b7XsgyGG1SU/
	tb1SfNfDyn/O0MchiZDwcKlD4vU6/2nyE7Wf1Q6emggXpbT+zsPP5r4F1GXHGMvpFSOffRiIoDy
	dxowfIIzRjGKmmc8S3QHJ3ODGUYdRfDF01cR2
X-Google-Smtp-Source: AGHT+IHa5P3FNcyxK3dfRD8l0hNbFtul+gz/5r6bBqUtFkIT1a2ttnvtee4Q932fZkZ5xf7hLJPLJm4n3vKcBRhcD4g=
X-Received: by 2002:a05:6402:35d4:b0:5c3:c2fc:8de6 with SMTP id
 4fb4d7f45d1cf-5c4040d4f38mr311527a12.3.1725982795248; Tue, 10 Sep 2024
 08:39:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906051205.530219-1-andrii@kernel.org> <20240906051205.530219-3-andrii@kernel.org>
 <CAG48ez2G1Pf_RRRT0av=6r_4HcLZu6QMgveepk-ENo=PkaZC1w@mail.gmail.com> <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
In-Reply-To: <CAEf4Bzb+ShZqcj9EKQB8U9tyaJ1LoOpRxd24v76FuPJP-=dkNg@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Tue, 10 Sep 2024 17:39:19 +0200
Message-ID: <CAG48ez1d9tU7-QeRSjRuxovG-jjNAwJ8B_G2jd43_etYMUPV6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless VMA-to-inode-to-uprobe
 resolution
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: surenb@google.com, Liam Howlett <liam.howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, brauner@kernel.org, linux-trace-kernel@vger.kernel.org, 
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 9, 2024 at 11:29=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Mon, Sep 9, 2024 at 6:13=E2=80=AFAM Jann Horn <jannh@google.com> wrote=
:
> > On Fri, Sep 6, 2024 at 7:12=E2=80=AFAM Andrii Nakryiko <andrii@kernel.o=
rg> wrote:
> > > +static struct uprobe *find_active_uprobe_speculative(unsigned long b=
p_vaddr)
> > > +{
> > > +       const vm_flags_t flags =3D VM_HUGETLB | VM_MAYEXEC | VM_MAYSH=
ARE;
> > > +       struct mm_struct *mm =3D current->mm;
> > > +       struct uprobe *uprobe;
> > > +       struct vm_area_struct *vma;
> > > +       struct file *vm_file;
> > > +       struct inode *vm_inode;
> > > +       unsigned long vm_pgoff, vm_start;
> > > +       int seq;
> > > +       loff_t offset;
> > > +
> > > +       if (!mmap_lock_speculation_start(mm, &seq))
> > > +               return NULL;
> > > +
> > > +       rcu_read_lock();
> > > +
> > > +       vma =3D vma_lookup(mm, bp_vaddr);
> > > +       if (!vma)
> > > +               goto bail;
> > > +
> > > +       vm_file =3D data_race(vma->vm_file);
> >
> > A plain "data_race()" says "I'm fine with this load tearing", but
> > you're relying on this load not tearing (since you access the vm_file
> > pointer below).
> > You're also relying on the "struct file" that vma->vm_file points to
> > being populated at this point, which means you need CONSUME semantics
> > here, which READ_ONCE() will give you, and something like RELEASE
> > semantics on any pairing store that populates vma->vm_file, which
> > means they'd all have to become something like smp_store_release()).
>
> vma->vm_file should be set in VMA before it is installed and is never
> modified afterwards, isn't that the case? So maybe no extra barrier
> are needed and READ_ONCE() would be enough.

Ah, right, I'm not sure what I was thinking there.

I... guess you only _really_ need the READ_ONCE() if something can
actually ever change the ->vm_file pointer, otherwise just a plain
load with no annotation whatsoever would be good enough? I'm fairly
sure nothing can ever change the ->vm_file pointer of a live VMA, and
I think _currently_ it looks like nothing will NULL out the ->vm_file
pointer on free either... though that last part is probably not
something you should rely on...
