Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BEA232423
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 04:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736915518; cv=none; b=ky/H69hvkYMUn2UPTLSjdnyjzjH+a2NgPK2JOotCMQkvQK7jF6r8z8IeQKxsz8weQIBR8kOAoPwqpo1WvDVpAw5LmG/5Xxu7JCY+RydfZFdSCEJ9nrkW0HoTHTCWICodjHERx51BbDPi1fie32432a4O7aow6i2wPO/nUTgpU0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736915518; c=relaxed/simple;
	bh=dwKZBzdRyaEFgqRkgRDjt4p4kfJfQCufOr1koGXKKbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ssSihN4v4ACNey4f+1FHvGHes8qnfQbgbiUHrJzcBMdFksiWk0ml03VvEI6t+r6tMXUYNFgARkQYkWF/4vVGML8r6IJ5W5gtdDMuObCdyzC+4q/06zIlkZiSY4J88iFVwDtW6TMw/YwUBPOG6kQnzNI0/g06U5ke2TfMftxKy8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=M3PMW3fE; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M3PMW3fE"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-86112ab1ad4so1725593241.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jan 2025 20:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1736915515; x=1737520315; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhUEXTZfkgW4BgxI74qkWusw+s+m3LiFaZUA40ueT84=;
        b=M3PMW3fE81cIJZesyF8wisA3vUYhWGhXEVK1ghaxkhVSFuz5RQHXGQ9FkqjlZ0Bexr
         QNEcbHjTQLW0YBzkncQlk8xygOw/Cx06KIZpaiQsSZeGNnKxq/N/pGm9XJ9QgSar4+jO
         QklLkt8nXZ1TKwCnlag5Ur7p+XNnKfRuoH2MezQNoNqjDva8ThoKSFKrOZjIplBBr11A
         GVC7q85HOv+WC5UTKavtHOqT1Vrmgwzz4lZyPd3/v5nPq2dRqPAl7IySerICuqslmGjJ
         Z19iPcb0StwWjirHWXKHEs4Who5RRbExhQ4ZLMd1GF3RzliE12EyaOMtIzrhUFdoNU1i
         LIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736915515; x=1737520315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yhUEXTZfkgW4BgxI74qkWusw+s+m3LiFaZUA40ueT84=;
        b=UJORYTZP1Ivbh5oJ89pF8nPeb5ahor3QhJu/bkXhH6cVacE9lBUHFZQ3fq+u9vT/xI
         Nhkx8d+WWQuG64EAnwBpkWQtY96k5/ETZQ/vzWZTzW0m+yCbJ/bzzHqS8CWUIq8dco+E
         TPWR/WSdbiq5cq3ZAWsMEQ2mpGuien7zlSmc/1G3A5CVTWVVLBFitFRo2IinOTnBcASo
         TAw00S0lGMFWhugtwnf1PEXaybmrpbeSLRKbmfasPPXa/mHdrZK5PhMQq/qfMVj9uOpx
         EhbifMpzn7TYmGNwSa3jZyIWroplfBxEyzKb93vCLqcEjb7EeVj0i0gJB/kilpGYTZSo
         atlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVREvljzYH/FOcarMZJGZ3ixpyGY2/B8NXvAhBDtH955dWP6x7gl6i7LkpVo4jti5mk1nONFxe4wiut74VdgH7gx3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP3wUBeVE5XUOraXG6v78ZR1xGmy6F3awPV/0/0n+F1FiNI7bR
	irpEjS4i/9QZyTLLaUJguCm02tdN/Z/wS5j4BXamHJ8gRPJzDYtmmvvAxs9mooGXPrnXIfF1/bo
	3fPO6d/an7R2nCwF/BjHeg5RiuT8UvusemsKH
X-Gm-Gg: ASbGncus9xhMWDbeOdwkYzSOwDdmhVtarhWud8SFsWwLe5MOC8JFeOrk2CwanLIBYec
	bAEErggSBhFogEoBlLdC79qviMgLovO/krb1fQWvpL/AgJ1713OOaNolBnJyv09P2Mgp7fIM=
X-Google-Smtp-Source: AGHT+IGV1k0H8SbbBA6nThUP6nuirAkFi9y4HuJJgrNaw0QqQFx6vZtOqG1tcU9TKgxw9iHsMXhUfwv5G+xLWaNaSds=
X-Received: by 2002:a05:6102:151d:b0:4af:5f65:4fd3 with SMTP id
 ada2fe7eead31-4b3d0d84e76mr22672519137.6.1736915515480; Tue, 14 Jan 2025
 20:31:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250113093453.1932083-1-kirill.shutemov@linux.intel.com>
 <20250113093453.1932083-5-kirill.shutemov@linux.intel.com>
 <CAJD7tkYH8KO8NLJY564PRAmW-mtMfDCMTECGKyYyVAf+JtTcRA@mail.gmail.com>
 <sct6vvupd4cp6xt66nn6sfs7w3srpx6zcxxsn6rz5qo4tz3la6@btdqsbicmrto>
 <CAJD7tkZwgKRc2kbY9WutC8meOV+CpQSpxKSpkUorEneJJuX9og@mail.gmail.com> <CAOUHufYFKZ=agWpS3mFHyDjXs_Tq7VhM=qBayL0FtJis=W0+Tg@mail.gmail.com>
In-Reply-To: <CAOUHufYFKZ=agWpS3mFHyDjXs_Tq7VhM=qBayL0FtJis=W0+Tg@mail.gmail.com>
From: Yu Zhao <yuzhao@google.com>
Date: Tue, 14 Jan 2025 21:31:18 -0700
X-Gm-Features: AbW1kvbVhru_iw2y_QlJolSm6M0KiY7kXGkDkKwfJ4WtDVBCkcYcJVbv0C9gb3I
Message-ID: <CAOUHufYwQ=nr08pdiwckDkfL+YVU6JcSdND2fiq6CDt_qMOQHw@mail.gmail.com>
Subject: Re: [PATCH 4/8] mm/swap: Use PG_dropbehind instead of PG_reclaim
To: Yosry Ahmed <yosryahmed@google.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Jens Axboe <axboe@kernel.dk>, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Andi Shyti <andi.shyti@linux.intel.com>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Christian Brauner <brauner@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Dan Carpenter <dan.carpenter@linaro.org>, David Airlie <airlied@gmail.com>, 
	David Hildenbrand <david@redhat.com>, Hao Ge <gehao@kylinos.cn>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Josef Bacik <josef@toxicpanda.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miklos Szeredi <miklos@szeredi.hu>, Nhat Pham <nphamcs@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Ran Xiaokai <ran.xiaokai@zte.com.cn>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, Simona Vetter <simona@ffwll.ch>, 
	Steven Rostedt <rostedt@goodmis.org>, Tvrtko Ursulin <tursulin@ursulin.net>, 
	Vlastimil Babka <vbabka@suse.cz>, intel-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 9:28=E2=80=AFPM Yu Zhao <yuzhao@google.com> wrote:
>
> On Tue, Jan 14, 2025 at 11:03=E2=80=AFAM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
> >
> > On Tue, Jan 14, 2025 at 12:12=E2=80=AFAM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > On Mon, Jan 13, 2025 at 08:17:20AM -0800, Yosry Ahmed wrote:
> > > > On Mon, Jan 13, 2025 at 1:35=E2=80=AFAM Kirill A. Shutemov
> > > > <kirill.shutemov@linux.intel.com> wrote:
> > > > >
> > > > > The recently introduced PG_dropbehind allows for freeing folios
> > > > > immediately after writeback. Unlike PG_reclaim, it does not need =
vmscan
> > > > > to be involved to get the folio freed.
> > > > >
> > > > > Instead of using folio_set_reclaim(), use folio_set_dropbehind() =
in
> > > > > lru_deactivate_file().
> > > > >
> > > > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.co=
m>
> > > > > ---
> > > > >  mm/swap.c | 8 +-------
> > > > >  1 file changed, 1 insertion(+), 7 deletions(-)
> > > > >
> > > > > diff --git a/mm/swap.c b/mm/swap.c
> > > > > index fc8281ef4241..4eb33b4804a8 100644
> > > > > --- a/mm/swap.c
> > > > > +++ b/mm/swap.c
> > > > > @@ -562,14 +562,8 @@ static void lru_deactivate_file(struct lruve=
c *lruvec, struct folio *folio)
> > > > >         folio_clear_referenced(folio);
> > > > >
> > > > >         if (folio_test_writeback(folio) || folio_test_dirty(folio=
)) {
> > > > > -               /*
> > > > > -                * Setting the reclaim flag could race with
> > > > > -                * folio_end_writeback() and confuse readahead.  =
But the
> > > > > -                * race window is _really_ small and  it's not a =
critical
> > > > > -                * problem.
> > > > > -                */
> > > > >                 lruvec_add_folio(lruvec, folio);
> > > > > -               folio_set_reclaim(folio);
> > > > > +               folio_set_dropbehind(folio);
> > > > >         } else {
> > > > >                 /*
> > > > >                  * The folio's writeback ended while it was in th=
e batch.
> > > >
> > > > Now there's a difference in behavior here depending on whether or n=
ot
> > > > the folio is under writeback (or will be written back soon). If it =
is,
> > > > we set PG_dropbehind to get it freed right after, but if writeback =
has
> > > > already ended we put it on the tail of the LRU to be freed later.
> > > >
> > > > It's a bit counterintuitive to me that folios with pending writebac=
k
> > > > get freed faster than folios that completed their writeback already=
.
> > > > Am I missing something?
> > >
> > > Yeah, it is strange.
> > >
> > > I think we can drop the writeback/dirty check. Set PG_dropbehind and =
put
> > > the page on the tail of LRU unconditionally. The check was required t=
o
> > > avoid confusion with PG_readahead.
> > >
> > > Comment above the function is not valid anymore.
> >
> > My read is that we don't put dirty/writeback folios at the tail of the
> > LRU because they cannot be freed immediately and we want to give them
> > time to be written back before reclaim reaches them. So I don't think
> > we want to change that and always put the pages at the tail.
> >
> > >
> > > But the folio that is still dirty under writeback will be freed faste=
r as
> > > we get rid of the folio just after writeback is done while clean page=
 can
> > > dangle on LRU for a while.
> >
> > Yeah if we reuse PG_dropbehind then we cannot avoid
> > folio_end_writeback() freeing the folio faster than clean ones.
> >
> > >
> > > I don't think we have any convenient place to free clean dropbehind p=
age
> > > other than shrink_folio_list(). Or do we?
> >
> > Not sure tbh. FWIW I am not saying it's necessarily a bad thing to
> > free dirty/writeback folios before clean ones when deactivated, it's
> > just strange and a behavioral change from today that I wanted to point
> > out. Perhaps that's the best we can do for now.
> >
> > >
> > > Looking at shrink_folio_list(), I think we need to bypass page demoti=
on
> > > for PG_dropbehind pages.
>
> I agree with Yosry. I don't think lru_deactivate_file() is still
> needed -- it was needed only because when truncation fails to free a
> dirty/writeback folio, page reclaim can do that quickly. For other
> conditions that mapping_evict_folio() returns 0, there isn't much page
> reclaim can do, and those conditions are not deactivate_file_folio()
> and lru_deactivate_file()'s intentions. So the following should be
> enough, and it's a lot cleaner :
>
> diff --git a/mm/truncate.c b/mm/truncate.c
> index e2e115adfbc5..12d2aa608517 100644
> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -486,7 +486,7 @@ unsigned long mapping_try_invalidate(struct
> address_space *mapping,
>                          * of interest and try to speed up its reclaim.
>                          */
>                         if (!ret) {
> -                               deactivate_file_folio(folio);
> +                               folio_set_dropbehind(folio)
>                                 /* Likely in the lru cache of a remote CP=
U */
>                                 if (nr_failed)
>                                         (*nr_failed)++;
>
> Then we can drop deactivate_file_folio() and lru_deactivate_file().

And with the above and list_move_tail() removed, we can also remove
lruvec_add_folio_tail().
