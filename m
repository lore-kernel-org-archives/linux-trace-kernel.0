Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C75D156883
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 16:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732206750; cv=none; b=bIYi5skpjIe0Y28FHa8tfGFTF/oFuWA2+kucKAXbiae7TlmjuGQ9z0lvxRa580zUeSxNkKTwJfDEVnznhcLrk93g0hxXDXIPzPI7n7cKaVLllDG3mCTpZZ2qq538s5BkeNeIpTrejoIB2oylQ11AVHPn5xB8l4G1SOnmcHepY6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732206750; c=relaxed/simple;
	bh=0071SProcnj54azKnrgs9O4CTcBQWiKx7fiDtH0v6QI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DNB53skL7xVpZ7zRA+Tmxib8gVdSsRTrqz087JDv/o0981PyTQUtm9X6BqDqBP/7SwglTD0zi1YOeS8RK53ark5p42NkQGioQp8YsgXVVcl+pE/VYbRY6n8MFz7xnN5xYArxCrwd+X5Y6dWtxrWLQ4FZTZSwk+jE40pSsIkiMN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UyoFesxE; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyoFesxE"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-460969c49f2so331591cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 08:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732206748; x=1732811548; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KinxbNGywfMnxHwtq/MrCSYbQ52bStWS5PDW/rvFKDU=;
        b=UyoFesxE9cDB7mn3kizkXDUJUgVZl4iK/Ehl0kua6JRvLUfsVTibYxJKpa+KEjKRme
         b6OKsHSb2We7Ewtih4a5V5KHHX3gzuIlDEPPwdPYe29lfcJHR1MGijV+DSuMWqLeXQTt
         VfN38AyAOUdsidX08ezXwa+UV1FnQAqtyuw1QjBo5XalOg9NpB7CjkFD4fZL/N/bzztm
         KJ5k0toPx5p7VBnCvysRqeUgdAaW+uO3jUgCaDj9fDcGbNOYvMh1IoNKK0FKVYFQOdJB
         yw33w9TyTOtwVQfy5hv3xuMs0KtGHunY1PeIgJ1Cs5El4uNcAuzMh9FLbbBG105VONPI
         gvSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732206748; x=1732811548;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KinxbNGywfMnxHwtq/MrCSYbQ52bStWS5PDW/rvFKDU=;
        b=SQ80l8iSmwO+8edGEC1zxVfaE0m2XA/4LBSHOc9t/tNHWPqRnOpAMr4mlzcoFcW7do
         oMfwQskeu0TEbWF4BTXJadZFGAQi64XuXeUBkdAv3QITKST4c/EZ+SlEatn8tnLmHqJl
         og1JdmEelczAWNqeZJdhXqkKdRK2is/rZ28ya9FeFp5+hZLg/I+FZUr6XdGS+14kIfaA
         f5a+8LtGIWXqqwmpG/xRfNnOvIGnEQGnO7cKY7i92S9A/8nI+O/oZSHK/xJHj6GND3hq
         XLr8Q73vIosMH4NEzKsl9SCzlaJn0y52vbPB17mXpjIJ4664TmrsTebs+372+JngVCj5
         hgLA==
X-Forwarded-Encrypted: i=1; AJvYcCVf1vTto85pvJ3PNHYfkPilUTJFY4wufBUlIUMma/3VRR8n3FDqV9Diq3XtsCWB0O4j82IjlbjfoZrmCFHlHas9SbA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMRGy233jLB23zhOKVzMwpsbyXN0Qv6qOFo1kbtnKnep/JZBZm
	mBNN3vvveKzI75TD4KE8MAD+xQwVRSK7lhB+D5sMYI5Or+QbR5zTefnvO17KV01htbE5fuP51Ti
	XgiR+ha/tj4/mKSxeta9fGfUAU81RuHpsQeB/
X-Gm-Gg: ASbGncsy6r0NtzCRIDeJVQHVxHiAFp2SX2ESW7kyW+LHyQBrgkzGBPJkFZGRJiwlGGI
	ifsxyDo+d9zUK8Qtv/LW9IWFa0Q6vQkx91k+I8DlCeVR5U4A3SG+RsqsQSPMh
X-Google-Smtp-Source: AGHT+IEAnK3ZNayNZX1MZKPWNaHHSfD9Gcs0HsfhavIX8PgOJ4JyzfKBkGAXcCXM+vNSiBpmS2gA+HMqANSVxnOf0r0=
X-Received: by 2002:a05:622a:1aaa:b0:465:31d8:6f1a with SMTP id
 d75a77b69052e-4653bd85a6emr194851cf.23.1732206747600; Thu, 21 Nov 2024
 08:32:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241028010818.2487581-1-andrii@kernel.org> <20241028010818.2487581-3-andrii@kernel.org>
 <20241121144442.GL24774@noisy.programming.kicks-ass.net> <20241121152257.GN38972@noisy.programming.kicks-ass.net>
 <CAJuCfpE04MtnmRR+JYpYqC07-u9yXRUF0FB2mSaQatzwSkNNdw@mail.gmail.com>
In-Reply-To: <CAJuCfpE04MtnmRR+JYpYqC07-u9yXRUF0FB2mSaQatzwSkNNdw@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 21 Nov 2024 08:32:16 -0800
Message-ID: <CAJuCfpHpDtis0+KwcUCb5oAbjNmgCtJB=K18Jr=MMRRE=Mkaig@mail.gmail.com>
Subject: Re: [PATCH v4 tip/perf/core 2/4] mm: Introduce mmap_lock_speculation_{begin|end}
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, oleg@redhat.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, 
	willy@infradead.org, mjguzik@gmail.com, brauner@kernel.org, jannh@google.com, 
	mhocko@kernel.org, vbabka@suse.cz, shakeel.butt@linux.dev, hannes@cmpxchg.org, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, david@redhat.com, 
	arnd@arndb.de, richard.weiyang@gmail.com, zhangpeng.00@bytedance.com, 
	linmiaohe@huawei.com, viro@zeniv.linux.org.uk, hca@linux.ibm.com, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 21, 2024 at 7:36=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Thu, Nov 21, 2024 at 7:23=E2=80=AFAM Peter Zijlstra <peterz@infradead.=
org> wrote:
> >
> > On Thu, Nov 21, 2024 at 03:44:42PM +0100, Peter Zijlstra wrote:
> >
> > > But perhaps it makes even more sense to add this functionality to
> > > seqcount itself. The same argument can be made for seqcount_mutex and
> > > seqcount_rwlock users.
> >
> > Something like so I suppose.
>
> Ok, let me put this all together. Thanks!

I posted the new version at
https://lore.kernel.org/all/20241121162826.987947-1-surenb@google.com/
The changes are minimal, only those requested by Peter, so hopefully
they can be accepted quickly.

>
> >
> > ---
> > diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> > index 5298765d6ca4..102afdf8c7db 100644
> > --- a/include/linux/seqlock.h
> > +++ b/include/linux/seqlock.h
> > @@ -318,6 +318,28 @@ SEQCOUNT_LOCKNAME(mutex,        struct mutex,    t=
rue,     mutex)
> >         __seq;                                                         =
 \
> >  })
> >
> > +/**
> > + * raw_seqcount_try_begin() - begin a seqcount_t read critical section
> > + *                            w/o lockdep and w/o counter stabilizatio=
n
> > + * @s: Pointer to seqcount_t or any of the seqcount_LOCKNAME_t variant=
s
> > + *
> > + * Very like raw_seqcount_begin(), except it enables eliding the criti=
cal
> > + * section entirely if odd, instead of doing the speculation knowing i=
t will
> > + * fail.
> > + *
> > + * Useful when counter stabilization is more or less equivalent to tak=
ing
> > + * the lock and there is a slowpath that does that.
> > + *
> > + * If true, start will be set to the (even) sequence count read.
> > + *
> > + * Return: true when a read critical section is started.
> > + */
> > +#define raw_seqcount_try_begin(s, start)                              =
 \
> > +({                                                                    =
 \
> > +       start =3D raw_read_seqcount(s);                                =
   \
> > +       !(start & 1);                                                  =
 \
> > +})
> > +
> >  /**
> >   * raw_seqcount_begin() - begin a seqcount_t read critical section w/o
> >   *                        lockdep and w/o counter stabilization
