Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5DB77111
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Sep 2025 00:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758068231; cv=none; b=UIQYwfFxPsMvzXGOI4eY7e7OyB4krxBrbF8sYNjwAG01IKAJrD4Ve5zzGnP4mTuE6Dzv4ueeIimYRh0oMlxmiS08a0b3uTnvH9Z6nCk/z/kcGBQQe8F7t67pt14pvkQSm4aolTpANpghpUKSkpM+pKAXm1Duoyg4V7O27ebgvqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758068231; c=relaxed/simple;
	bh=8bMaW+s8iABakKwgqc6w26p8Hw7d/FhUe28p51azdRg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8I6Ijvc6QArZIF7hCH3UNx2M1EvicAbqPFIjKg4pRPk7CXtUHDC+oRrTu7xiyrCFP9d2rqOhvfxOQmu0Q+jyT56ET3NjFv3eyAnAqqQi64/osEsofSq04HZJJ3EKib7O2VWGxHgD5wkOPbSYkTopYF6M7RUR1cWbsRizr0e674=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R3lswAoh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R3lswAoh"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6228de280a4so3677467a12.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 17:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758068227; x=1758673027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXSGAh8chrKBAWdQa4v/8pOW/Kzc0QCjuDzlGtOmWtE=;
        b=R3lswAohNyOMwWKwXZqGgP77g3sVJvV3/mg9TzComvE2dQRdy7tW7chcmxkZgXm5Pt
         y8ShAYeveHS9l1YTNw5O33im160bqMNxYklewVHTmq3rbd0RGrrrEKQnTEBMbeGaXYw5
         /9t/BxIp5x6YFECxH3FclY7u5KY4PbtZH6zaLOai03vO0gev+pPSHEaElrdTFmXcaWyc
         QTS8iwW92mgHxfbuc18vaFp/5XWSypNuiQ0ebTp7bC+sVmNC7ZUfCgnRAIoiqtmsAEnR
         1eJNoGEYG0GVdU7ROWlTd39kVc0mCpHRMJo29uGRqv8NNLmdOuXjSY3rWz0QCMxuy7U4
         9MKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758068227; x=1758673027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXSGAh8chrKBAWdQa4v/8pOW/Kzc0QCjuDzlGtOmWtE=;
        b=dG2cp80j8LtXkms9EiUx4hJ4u7iN5HlSUffBPnZ+oK7HbZm8cM4N3iwtyA1n9WDmPY
         Dt764WtzDfXLpZROpC7EQ9j8ExvVlyJk2kfeyi/uFz+CwoRLlhQzphsG2T8sKLeGTBQj
         DBxxY0hsSutoRluchrBuipD+gV3+XZh2vnYYNr0GJaZuf7EWi5KN4fDMVhxmixHqmVKI
         aGE2r6TlgMToQ32YZcuEyMU2JdNZ50T28zzTlJcS8Q8QvJYI39WcKbkaDDyGCXd2Eo1/
         OR5CrxG/BP5C1fghsXqx/L4eumyo5EXDxzuHkENRejtSggmZooco0kIHv5w3zbfW3Ovd
         l/dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbutuegUvHM28b+m6yimujcNKh17g2kygFmT2hQGwVxBT+T6vdE1NM08vgI8Rb19RUfNtKwXLElwFGMpkuqFG6NTY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yycz2rTABBFjxir8B1Co3u6n8ORebmuhyO0gAxNzHTs74KJcpqG
	CJWWab3wxX/UcKQYq9QxFYyVtDtYbtb3gtngYvBVw5MddrjK1Gko4j/MTHs1Wtx13vf3T6bD03x
	tl6AGsyBqZaYB8BwYQYuxnjsg1I23O20=
X-Gm-Gg: ASbGnct6ypf3uRRi96k9UU1WAKCNiFXyXwob2zJE+uVikLN+QCRy6qELzCom5jPvi0p
	M6oSbNYO8Rh9OmGp8nIvoQjS4QQDbIbFKYjHqmYTbz+1bDar1Wae18RvKlWGpSXKTqNE/lSWwxx
	Sz7K68IU16pcKRm6joBtoIVCQk4xsxOJ0Se0ajzUvnq43i4hVNVvtS07H2hXqMUwWvSmQx92eXo
	7v6Ne8YPrtP4p/PnaPAGEZQp7BgJxOr9NDD85Y=
X-Google-Smtp-Source: AGHT+IHkWc8z+1xTqfr6RJDMY4BcUWdUqKw6o2ECW5HvusjoalWjKeML6JPCAbs/M1LUcK6l6vjMuNB824YFNjkP4LM=
X-Received: by 2002:a05:6402:26c3:b0:62f:2afa:60e6 with SMTP id
 4fb4d7f45d1cf-62f83c3f396mr486555a12.7.1758068227086; Tue, 16 Sep 2025
 17:17:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
 <20250916194915.1395712-1-clm@meta.com>
In-Reply-To: <20250916194915.1395712-1-clm@meta.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 17 Sep 2025 02:16:54 +0200
X-Gm-Features: AS18NWCoF9toVvfO2cO2nt5EYzoV_mx2NXf7z13bcCNBsYM4N3TAXw98oK0bZL0
Message-ID: <CAGudoHE1GfgM-fX9pE-McqXH3dowPRoSPU9yHiGi+a3mk1hwnw@mail.gmail.com>
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
To: Chris Mason <clm@meta.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	"H . Peter Anvin" <hpa@zytor.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, 
	David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Kan Liang <kan.liang@linux.intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
	Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Matthew Wilcox <willy@infradead.org>, linux-s390@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 1:57=E2=80=AFAM Chris Mason <clm@meta.com> wrote:
>
> On Tue, 12 Aug 2025 16:44:11 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracl=
e.com> wrote:
>
> > As part of the effort to move to mm->flags becoming a bitmap field, con=
vert
> > existing users to making use of the mm_flags_*() accessors which will, =
when
> > the conversion is complete, be the only means of accessing mm_struct fl=
ags.
> >
> > This will result in the debug output being that of a bitmap output, whi=
ch
> > will result in a minor change here, but since this is for debug only, t=
his
> > should have no bearing.
> >
> > Otherwise, no functional changes intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> [ ... ]
>
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 25923cfec9c6..17650f0b516e 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
>
> [ ... ]
>
> > @@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, pidfd, uns=
igned int, flags)
> >        * Check MMF_OOM_SKIP again under mmap_read_lock protection to en=
sure
> >        * possible change in exit_mmap is seen
> >        */
> > -     if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm=
))
> > +     if (mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
> >               ret =3D -EAGAIN;
> >       mmap_read_unlock(mm);
> >
>
> Hi Lorzeno, I think we lost a ! here.
>
> claude found enough inverted logic in moved code that I did a new run wit=
h
> a more explicit prompt for it, but this was the only new hit.
>

I presume conversion was done mostly manually?

The way(tm) is to use coccinelle.

I whipped out the following real quick and results look good:

@@
expression mm, bit;
@@

- test_bit(bit, &mm->flags)
+ mm_flags_test(bit, mm)

$ spatch --sp-file mmbit.cocci mm/oom_kill.c
[snip]
@@ -892,7 +892,7 @@ static bool task_will_free_mem(struct ta
         * This task has already been drained by the oom reaper so there ar=
e
         * only small chances it will free some more
         */
-       if (test_bit(MMF_OOM_SKIP, &mm->flags))
+       if (mm_flags_test(MMF_OOM_SKIP, mm))
                return false;

        if (atomic_read(&mm->mm_users) <=3D 1)
@@ -1235,7 +1235,7 @@ SYSCALL_DEFINE2(process_mrelease, int, p
                reap =3D true;
        else {
                /* Error only if the work has not been done already */
-               if (!test_bit(MMF_OOM_SKIP, &mm->flags))
+               if (!mm_flags_test(MMF_OOM_SKIP, mm))
                        ret =3D -EINVAL;
        }
        task_unlock(p);
@@ -1251,7 +1251,7 @@ SYSCALL_DEFINE2(process_mrelease, int, p
         * Check MMF_OOM_SKIP again under mmap_read_lock protection to ensu=
re
         * possible change in exit_mmap is seen
         */
-       if (!test_bit(MMF_OOM_SKIP, &mm->flags) && !__oom_reap_task_mm(mm))
+       if (!mm_flags_test(MMF_OOM_SKIP, mm) && !__oom_reap_task_mm(mm))
                ret =3D -EAGAIN;
        mmap_read_unlock(mm);
