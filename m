Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C29E2EFD86
	for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 22:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763677968; cv=none; b=aoumXtv5+YMzqiuT2K0EHLyh1Wu/G8cy44pe50PAZE2En4QCDXJWuDyT/vHCF/e7IDnQafshyGSOUHLa5rVc8hkwVFBPrO3Ntuphhen1nwVkmca+8v7YqezrayH4JOK3YtGpwA+XmQlJceGXOKvXspRt+FkWMAfBcFVvFWLQlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763677968; c=relaxed/simple;
	bh=5So1S18bUC/50sEqzaS+t4mepwtsB0Mggm0lyQfJzgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hc8DFCTYDCKKtnlTNRTw1zLS2VbDR8nOSRSp5aj1idrQN9zvIqN0L+O8gLrO+5eX+pLSHhq5tw00uahrU8zgVuntpyXn2YLY88aSkvq5Ou2b1tJGXyqXCi0Z6lHpZMgrg7HSxOpE9N+RQFRi2I0t3BLT3TqDL5d1DQ07eOAQfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RN4DK+oi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RN4DK+oi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763677964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeA/zAKZ/1z66T0o4lpHibqrnYkMZvfbiOk8G9lfRrE=;
	b=RN4DK+oivCurF1BYbTPzxXTwA0JJ9+7gerKANUsbpITBDObjG5dDOD4RMp9/SqV6+eT6EE
	KsR0YqYJzO7lU0FyVlBlyBXdJUAyTX+9sI1lGwe3vcmfODqeIFZ9kK45H7Aw9+tdMx/8Tt
	MO0Z0EsDJ31GY/FOIYlnrQcxNjbJTAI=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-1dD7YyVSPHqou8fVBLsu2Q-1; Thu, 20 Nov 2025 17:32:42 -0500
X-MC-Unique: 1dD7YyVSPHqou8fVBLsu2Q-1
X-Mimecast-MFC-AGG-ID: 1dD7YyVSPHqou8fVBLsu2Q_1763677962
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-63e3421b8f3so1762558d50.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Nov 2025 14:32:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763677962; x=1764282762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GeA/zAKZ/1z66T0o4lpHibqrnYkMZvfbiOk8G9lfRrE=;
        b=hu6PI17RYxqf0cNDMK0XD0huVJ8j4FeV/ux5+GknVrqAkNHRxeKggySLBAJfitLJ6e
         8tKFs1lrqyy6FzqQwui8rFYhG3DslROg+0ZXLEx5eCby7U0dMZ6mSGnauRKq4kIZHaTX
         /1NwPpNXoVt1x9Um6WmMyRhe0tluGlaO/sa/dBKzIToNzrmd1DrllnYLp6MiH42bCPQ6
         +xDKMCMVHOEL5cU7a8ewiz6AUfAJgEe+i06zdevIUu41Ma1+pF0N/ebwWlGRCAFLnuKh
         CTIZXp3t6NnhAej+EZemKeWXo+mJuTlv/ZoQmXE5JwkK1XkQ+aNGMXJQBotnMv//7QkV
         N+og==
X-Forwarded-Encrypted: i=1; AJvYcCWRD1OzrsRxFRWgxRIsNZmOTKA0FZ+RIo6x1oaQQHp0vi3XgdYG6xTBRhK9eXwm005Ml1fwnZ1KINZKQ+/Dy/veihI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFTc0l+LgNWm5wzJEX2W1ERQfewINxOS0BXO+sqYOfhRdYNQu1
	tuj6hDjg5RhGdVxSNdFKy5XPu8tSLLzurpX9IRB+5SRpT1XzylVcotnxYNSPtBRsnmzawbZDIC6
	f8OD2tqG67y6tgiM7Iy+T6ZWhJIte9Z6NKNeO0HHcsGOLBlm17idNN8BNJlOGfrIGJ0J8OQ3Fua
	cmtrNGiLtm4QYeeknYcD70NhXExWag7a/h5P9pXiCH0ByagVcZ
X-Gm-Gg: ASbGnctrj7favlOU+QEEFNhucxKX6bsbndLkw2CPtrSgkVAf/cJiz1F6p73e9ESL3lz
	odwpl+ytjElJP/rxBaa9OPSKbEXljIZxjH3iIu+cJnrSfRRGN4QSxvnONWKZEe8lKSvILIYo1uq
	IHfVKQM/IT9N2RdrMyeaPvJx385jF0+6sH1Q3IKuVXXjSQDcAQomJkeHj+Tes1tSQjdUnCEBRGd
	cedrvsr
X-Received: by 2002:a05:690e:428a:20b0:636:149a:f54e with SMTP id 956f58d0204a3-64302a6b00amr27303d50.37.1763677961683;
        Thu, 20 Nov 2025 14:32:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGirU2vbNWZe8D1FkpfaBXgFAc9rqZ1VzDtWHWoob6EGF4pkntwkJUmbNanDvopt+AwZoljIUFVqOWeT6YOO7g=
X-Received: by 2002:a05:690e:428a:20b0:636:149a:f54e with SMTP id
 956f58d0204a3-64302a6b00amr27257d50.37.1763677960916; Thu, 20 Nov 2025
 14:32:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-13-npache@redhat.com>
 <d03e079f-35c0-4fc1-8856-44fe33fabb2f@lucifer.local>
In-Reply-To: <d03e079f-35c0-4fc1-8856-44fe33fabb2f@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Thu, 20 Nov 2025 15:32:15 -0700
X-Gm-Features: AWmQ_bm8_9BuQ9L1d7aaqKoV23XDwXpJRMRJV4QkRX9MTV-OHhlvE930nuvVkqk
Message-ID: <CAA1CXcCJ+MS4U_ycT9hg4cK31cQrjFs2SoL8isf_mKfVbN5tJg@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 12/15] khugepaged: Introduce mTHP collapse support
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, david@redhat.com, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, usamaarif642@gmail.com, 
	sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, kas@kernel.org, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com, 
	richard.weiyang@gmail.com, lance.yang@linux.dev, vbabka@suse.cz, 
	rppt@kernel.org, jannh@google.com, pfalcato@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eaeBV92BaGkBYfbfXYI-zwUTgOV3Pa2qlNP-_MPbItw_1763677962
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:56=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 22, 2025 at 12:37:14PM -0600, Nico Pache wrote:
> > During PMD range scanning, track occupied pages in a bitmap. If mTHPs a=
re
> > enabled we remove the restriction of max_ptes_none during the scan phas=
e
> > to avoid missing potential mTHP candidates.
>
> It's a bit odd to open the commit message with a very specific
> implementation detail, I think we should instead open with a broad
> description of what we intend here, e.g. to permit mTHP collapse, before:
>
> - Discussing the algorithm used (in more detail than below!)
> - How and under what circumstances this algorithm is invoked
> - (Mention MADV_COLLAPSE not supporting mTHP as of yet)
> - THEN super-specific details like this
>
> >
> > Implement collapse_scan_bitmap() to perform binary recursion on the bit=
map
> > and determine the best eligible order for the collapse. A stack struct =
is
> > used instead of traditional recursion. The algorithm splits the bitmap
> > into smaller chunks to find the best fit mTHP.  max_ptes_none is scaled=
 by
> > the attempted collapse order to determine how "full" an order must be
> > before being considered for collapse.
>
> I feel this is a _very_ brief description of a complicated algorithm. I
> think we should go into a lot more detail here. 'Binary recursion' is pre=
tty
> hand-wavey, and you go from hand waving that to being super-specific abou=
t
> max_ptes_none before handwaving about 'fullness' of an order.
>
> All in all I find it super confusing - so I think you need to take a step
> back and 'explain it to me like I'm 5' here :)

Sounds good, I'll rework the commit message with your feedback in mind! Tha=
nks!

>
> >
> > Once we determine what mTHP sizes fits best in that PMD range a collaps=
e
> > is attempted. A minimum collapse order of 2 is used as this is the lowe=
st
> > order supported by anon memory.
>
> I don't know what 'lowest order supported by anon memory' means?
>
> I guess really this is the minimum order contptes support for arm64 right=
?

Anonymous memory supports mTHP sizes of order 2 or greater.

>
> >
> > mTHP collapses reject regions containing swapped out or shared pages.
> > This is because adding new entries can lead to new none pages, and thes=
e
> > may lead to constant promotion into a higher order (m)THP. A similar
> > issue can occur with "max_ptes_none > HPAGE_PMD_NR/2" due to a collapse
> > introducing at least 2x the number of pages, and on a future scan will
> > satisfy the promotion condition once again. This issue is prevented via
> > the collapse_allowable_orders() function.
>
> Obviously this has been discussed to death, but you should update this to
> reflect the decided upon course (0, 511 + warning, etc.).

Yeah I wasnt sure whether to reference collapse_allowable_orders()
which should now dictate this limitation, or directly reference the
limitations here. Ill do both.

>
> >
> > Currently madv_collapse is not supported and will only attempt PMD
> > collapse.
>
> Good to highlight this.
>
> >
> > We can also remove the check for is_khugepaged inside the PMD scan as
> > the collapse_max_ptes_none() function handles this logic now.
>
> Again we're kind of leaping from mega handwaving to super-specific detail=
s
> :) let's make it all a lot more specific + clear, and then put the really
> niche details like this at the end of the commit msg (I mean this one is
> fine where it is ofc as a result :)
>
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  include/linux/khugepaged.h |   2 +
> >  mm/khugepaged.c            | 128 ++++++++++++++++++++++++++++++++++---
> >  2 files changed, 122 insertions(+), 8 deletions(-)
> >
> > diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> > index eb1946a70cff..179ce716e769 100644
> > --- a/include/linux/khugepaged.h
> > +++ b/include/linux/khugepaged.h
> > @@ -1,6 +1,8 @@
> >  /* SPDX-License-Identifier: GPL-2.0 */
> >  #ifndef _LINUX_KHUGEPAGED_H
> >  #define _LINUX_KHUGEPAGED_H
> > +#define KHUGEPAGED_MIN_MTHP_ORDER    2
> > +#define MAX_MTHP_BITMAP_STACK        (1UL << (ilog2(MAX_PTRS_PER_PTE) =
- KHUGEPAGED_MIN_MTHP_ORDER))
>
> This is an internal implementation detail, I don't think we need this in =
a
> header do we? I think this define should be in khugepaged.c.

sounds good!

>
> Also this is a really fiddly and confusing value, I don't think it's a go=
od idea
> to just put this here without explanation.

This is sadly an outcome of ppc64. HPAGE_PMD_ORDER cannot be used due
to ppc defining this at runtime, so instead we use
lg(MAX_PTRS_PER_PTE).

>
> It's not even clear what it is. I'd probably rename it to MTHP_STACK_SIZE=
?

Yeah MTHP_STACK_SIZE is better!

>
> We need a comment that explains how you're deriving this, something like:
>
> /*
>  * In order to determine mTHP order, we consider every possible mTHP size
>  * starting with MAX_PTRS_PER_PTE PTE entries and stopping at
>  * 2^KHUGEPAGED_MIN_THP_ORDER.
>  *
>  * We store (offset, order) pairs on the stack to do so, each describing =
a
>  * candidate mTHP collapse.
>  *
>  * For each (offset, order) candidate mTHP range that we consider, we mus=
t
>  * also consider candiate mTHPs at (offset, order - 1), and (offset + (1 =
<<
>  * order), order - 1).
>  *
>  *
>  * This is because each order can be split into two (an order expresses t=
he
>  * power-of-two size), so we examine each half of the next lower order
>  * mTHP:
>  *
>  *                offset   mid_offset
>  *                  .          |
>  *                  .          v
>  *  |---------------.-------------------|
>  *  |           PTE page table          |
>  *  |---------------.-------------------|
>  *                   <--------><-------->
>  *                     order-1   order-1
>  *
>  * Given we must consider the range of KHUGEPAGED_MIN_MTHP_ORDER to
>  * MAX_PTRS_PER_PTE number of PTE entries, this is the same as saying we
>  * must consider KHUGEPAGED_MIN_MTHP_ORDER to lg2(MAX_PTRS_PER_PTE) mTHP
>  * orders.
>  *
>  * As we must consider 2 possible mTHP ranges for each order, this requir=
es
>  * our stack to be 2^n, where n is the number of orders we must consider.
>  *
>  * And thus MTHP_STACK_SIZE is 2^(lg2(MAX_PTRS_PER_PTE) -
>  * KHUGEPAGED_MIN_MTHP_ORDER).
>  */
>
> This may seem (very) long-winded, but this is all really non-obvious.
>
> You can additionally rephrase this and utilise it in the commit message,
> description of the iterative recursion function and possibly elsewhere to
> describe the algorithm more clearly.
>
> In fact, since this should really be declared in khugepaged.c, and since
> you can place it just before the mthp collapse function, you could expand
> this to describe the algorithm as a whole and simply put the define and t=
he
> function immediately next to each other after the comment?

Sounds good ill break this down in more detail and try to group the
functions/comments into one section. It may not be fully possible to
keep the code together as some things are needed early in the code (ie
MAX_STACK_SIZE would be needed at scan_control definition)

>
> >
> >  #include <linux/mm.h>
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 89a105124790..e2319bfd0065 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -93,6 +93,11 @@ static DEFINE_READ_MOSTLY_HASHTABLE(mm_slots_hash, M=
M_SLOTS_HASH_BITS);
> >
> >  static struct kmem_cache *mm_slot_cache __ro_after_init;
> >
> > +struct scan_bit_state {
>
> Scan bit state is a bit of a weird name. Scanning what? What bit? State i=
s
> kind of implied?
>
> struct order_offset_pair?
>
> struct mthp_range?

mthp_range sounds good to me!

>
> > +     u8 order;
> > +     u16 offset;
>
> Real mega nit, but feels more natural to put offset first here. As
> (position, size) seems more naturally the way to view this than (size,
> position).

ack!

>
> > +};
> > +
>
> Also needs comments...? Order of what? Offset in what?
>
> >  struct collapse_control {
> >       bool is_khugepaged;
> >
> > @@ -101,6 +106,13 @@ struct collapse_control {
> >
> >       /* nodemask for allocation fallback */
> >       nodemask_t alloc_nmask;
> > +
> > +     /*
> > +      * bitmap used to collapse mTHP sizes.
> > +      */
>
> Nit but this should be on one line /* Bitmap used to collapse mTHP sizes =
*/.

ACK, already handled this one!

>
> But we're not storing sizes though are we? And we're declaring two bitmap=
s?
>
> > +      DECLARE_BITMAP(mthp_bitmap, HPAGE_PMD_NR);
>
> Really this is more of a PTE table bitmap but probably fine to call it th=
is.
>
> > +      DECLARE_BITMAP(mthp_bitmap_mask, HPAGE_PMD_NR);
>
> You've added random whitespace after the tab twice here? [tab][space]DECL=
ARE_...
>
> > +     struct scan_bit_state mthp_bitmap_stack[MAX_MTHP_BITMAP_STACK];
> >  };
> >
> >  /**
> > @@ -1357,6 +1369,85 @@ static int collapse_huge_page(struct mm_struct *=
mm, unsigned long pmd_address,
> >       return result;
> >  }
> >
> > +static void push_mthp_bitmap_stack(struct collapse_control *cc, int *t=
op,
> > +                                u8 order, u16 offset)
>
> Not sure we need to say mthp_bitmap_stack everywhere. This is a local
> static function we can be a little more succinct.
>
> mthp_stack_push()?

looks good!

>
> > +{
> > +     cc->mthp_bitmap_stack[++*top] =3D (struct scan_bit_state)
> > +             { order, offset };
>
> This feels rather difficult to read, cc->mthp_bitmap_stack[++*top] in
> particular is rather too succinct.
>
> This would be better more broken out, e.g.:
>
> static void mthp_stack_push(struct collapse_control *cc, int *sizep,
>             u8 order, u16 offset)
> {
>         const int size =3D *sizep;
>         struct scan_bit_state *stack =3D &cc->mthp_bitmap_stack[size];
>
>         VM_WARN_ON_ONCE(idx >=3D MAX_MTHP_BITMAP_STACK);
>         stack->order =3D order;
>         stack->offset =3D offset;
>         *sizep++;
> }
>
> (Note this requires the change I suggest below re: not defaulting top to =
-1
> but instead renaming it to stack_size and starting at 0, see below).
>
> Re: below comment having pop as a helper too, that can be:
>
> static struct scan_bit_state mthp_stack_pop(struct collapse_control *cc,
>                 int *sizep)
> {
>         const int size =3D *sizep;
>
>         VM_WARN_ON_ONCE(size <=3D 0);
>         *sizep--;
>         return cc->mthp_bitmap_stack[size - 1];
> }

ack sounds good. I implemented these more verbosely!

>
> > +}
> > +
> > +/*
> > + * collapse_scan_bitmap() consumes the bitmap that is generated during
> > + * collapse_scan_pmd() to determine what regions and mTHP orders fit b=
est.
> > + *
> > + * Each bit in the bitmap represents a single occupied (!none/zero) pa=
ge.
>
> In which bitmap? There are 2 that are declared. Be specific - cc->mthp_bi=
tmap.
>
> > + * A stack structure cc->mthp_bitmap_stack is used to check different =
regions
>
> > + * of the bitmap for collapse eligibility. We start at the PMD order a=
nd
> > + * check if it is eligible for collapse; if not, we add two entries to=
 the
>
> I questioned this since you start at HPAGE_PMD_ORDER -
> KHUGEPAGED_MIN_MTHP_ORDER, but then realised you're intentionally
> offsetting like that.
>
> See comments below about changing this.
>
> > + * stack at a lower order to represent the left and right halves of th=
e region.
> > + *
> > + * For each region, we calculate the number of set bits and compare it
> > + * against a threshold derived from collapse_max_ptes_none(). A region=
 is
> > + * eligible if the number of set bits exceeds this threshold.
> > + */
>
> I think we could be clearer here. Something like:
>
> ...
>  * stack at a lower order to represent the left and right halves of the
>  * portion of the PTE page table we are examining.
>  *
>
>  * For each of these, we determine how many PTE entries are occupied in t=
he
>  * range of PTE entries we propose to collapse, then compare this to the
>  * number of PTE entries which would need to be set for a collapse to be
>  * permitted at that order (accounting for max_ptes_none).
>  *
>  * If a collapse is permissible, we attempt to perform one. We do so for
>  * every possible mTHP in the PTE page table.
>  */
>
> > +static int collapse_scan_bitmap(struct mm_struct *mm, unsigned long ad=
dress,
>
> Really inconsistent naming going on here, we're collapsing and scanning a=
nd
> what's the bitmap?
>
> How about mthp_collapse()?

ok sounds good

>
> > +             int referenced, int unmapped, struct collapse_control *cc=
,
> > +             bool *mmap_locked, unsigned long enabled_orders)
> > +{
> > +     u8 order, next_order;
> > +     u16 offset, mid_offset;
> > +     int num_chunks;
> > +     int bits_set, threshold_bits;
> > +     int top =3D -1;
>
> This seems unnecessary and confusing. Just start at 0 and treat this as t=
he
> exclusive end of the stack.
>
> You can rename this stack_size to make that clear. Have commented above
> about adjustments to push function and introducing pop helper.
>
>
> > +     int collapsed =3D 0;
> > +     int ret;
> > +     struct scan_bit_state state;
> > +     unsigned int max_none_ptes;
>
> Everywhere else we say max_ptes_none, let's maintain that convention here
> please.

ack, didn't realize it was different. Must have been tired eyes.

>
> > +
> > +     push_mthp_bitmap_stack(cc, &top, HPAGE_PMD_ORDER - KHUGEPAGED_MIN=
_MTHP_ORDER, 0);
>
> See below re: order here, we should change this.
>
> > +
> > +     while (top >=3D 0) {
> > +             state =3D cc->mthp_bitmap_stack[top--];
>
> I hate that we have a push helper but then do pop manually. See above.
>
> > +             order =3D state.order + KHUGEPAGED_MIN_MTHP_ORDER;
>
> OK so now the order isn't state.order but is instead state.order +
> KHUGEPAGED_MIN_MTHP_ORDER? :/ this is extremely confusing.
>
> We shouldn't call this field order if you're doing a hack where state.ord=
er
> isn't the order but instead is order - KHUGEPAGED_MIN_MTHP_ORDER.
>
> Just have state.order be the actual order? And change the below condition
> as mentioned there.

Sounds good, Wei already suggested something similar. This made more
sense when we were compressing the bitmap into 128 bits. Already
changed :)

>
> > +             offset =3D state.offset;
> > +             num_chunks =3D 1UL << order;
>
> What's a chunk? You do need to clarify these things. This is a new term n=
ot
> used elsewhere in THP code as far as I can tell?
>
> This is the number of pte entries no?
>
> nr_entries? nr_pte_entries?

Yeah that looks much cleaner. Some remnants from my RFC.

>
> > +
> > +             /* Skip mTHP orders that are not enabled */
>
> Note we're also considering PMD here :) Probably we can just delete this
> comment, the code below makes it clear what you're doing.
>
> > +             if (!test_bit(order, &enabled_orders))
> > +                     goto next_order;
> > +
> > +             max_none_ptes =3D collapse_max_ptes_none(order, !cc->is_k=
hugepaged);
>
> OK so this is going to be scaled to order.
>
> > +
> > +             /* Calculate weight of the range */
>
> What's the weight of a range? This isn't a very helpful comment. You're
> counting the Hamming weight or much more clearly - the number of set bits=
.
>
> So it seems you're simply counting the number of bits you have accumulate=
d
> so far in cc->mthp_bitmap, adding in the latest offset.
>
> So I'd say add a comment saying something like:
>
> /*
>  * Determine how many PTE entries are populated in the range in which we
>  * propose to collapse this mTHP.
>  */
>
> > +             bitmap_zero(cc->mthp_bitmap_mask, HPAGE_PMD_NR);
> > +             bitmap_set(cc->mthp_bitmap_mask, offset, num_chunks);
> > +             bits_set =3D bitmap_weight_and(cc->mthp_bitmap,
>
> I think this variable name is pretty horrible, we don't care that it's th=
e
> number of bits set, we care about what it _means_ - that is the number of
> PTE occupied entries.
>
> So nr_occupied_pte_entries? Or nr_occupied_ptes?

ack, looks better!

>
> > +                                          cc->mthp_bitmap_mask, HPAGE_=
PMD_NR);
>
> Frustrating there isn't a bitmap_weight_offset() or something, as you cou=
ld
> do that in one go then...

Yeah it's a shame, my previous implementation was much worse. I found
a better solution (this one) a few versions ago.

>
> I think this could be made clearer by separating out the gnarly bitmap
> stuff into a helper function:
>
> static int mthp_nr_occupied_pte_entries(struct collapse_control *cc,
>                 struct scan_bit_state state)
> {
>         const int nr_pte_entries =3D 1 << state.order;
>
>         /* Setup cc->mthp_bitmap_mask to contain mask for candidate mTHP.=
 */
>         bitmap_zero(cc->mthp_bitmap_mask, HPAGE_PMD_NR);
>         bitmap_set(cc->mthp_bitmap_mask, state.offset, nr_pte_entries);
>         /* Mask against actually occupied PTE entries in PTE table. */
>         return bitmap_weight_and(cc->mthp_bitmap,
>                                  cc->mthp_bitmap_mask, HPAGE_PMD_NR);
> }

Done, this fits well with all the other helpers!

>
> > +
> > +             threshold_bits =3D (1UL << order) - max_none_ptes - 1;
>
> We defined num_chunks to 1UL << order then don't use here? :)

Cleaned these up! thanks :)

>
> I'm not sure we need this to be a separate value, and I don't think we ne=
ed
> the -1 either, which only confuses matter more.
>
> How about just changing the below conditional to (assuming we've renamed
> num_chunks to something sensible like nr_pte_entries and bits_set to
> nr_occupied_pte_entries):
>
> if (nr_occupied_pte_entries >=3D nr_pte_entries - max_none_ptes) {
>         ...
> }
>
> > +
> > +             /* Check if the region is eligible based on the threshold=
 */
>
> Probalby don't need this comment with the change above.

ack, that does look cleaner. Although iirc there was some weird corner
case that required the -1. This was back when we were compressing the
bitmap. I reviewed the logic, I think we can go with this solution
now. Ill make sure to test the corner cases I have.

>
> > +             if (bits_set > threshold_bits) {
> > +                     ret =3D collapse_huge_page(mm, address, reference=
d,
> > +                                              unmapped, cc, mmap_locke=
d,
> > +                                              order, offset);
>
> We declare ret at the top of the function scope, then only use it
> here. That's confusing and unnecessary, just declare it in block scope
> here.
>
> > +                     if (ret =3D=3D SCAN_SUCCEED) {
> > +                             collapsed +=3D 1UL << order;
>
> Again we have defined num_chunks or rather nr_pte_entries but then
> open-code 1UL << order, let's just use the value we declared here.
>
> > +                             continue;
>
> This is kinda subtle, we don't bother considering lower orders any longer
> *in this range*, but do continue to consider mTHP collapse in other
> portions of the PTE page table.
>
> This shouldn't just be a 'continue' :) we need a comment here to explain
> that.

sounds good i'll separate and add more to the comments to help explain
the flow. (more applicable to patch 13)
>
> E.g.:
>
>         /*
>          * We have collapsed an mTHP in this range at the maximum order w=
e
>          * could, so we do not push lower orders on to the stack.
>          */
>          continue;
>
>
> > +                     }
> > +             }
> > +
> > +next_order:
> > +             if (state.order > 0) {
>
> This is a great example of how this is confusing by making state.order no=
t
> actually be the order but the order - KHUGEPAGED_MIN_MTHP_ORDER.
>
> Just make the order correct and change this to > KHUGEPAGED_MIN_MTHP_ORDE=
R.
>
> > +                     next_order =3D state.order - 1;
>
> Not sure we should have a label and a variable be the same thing.
>
> Also why are we decl'ing next_order at the top of the function but only u=
sing here?

ack.

>
> Just declare this here, like:
>
>         if (state.order > KHUGEPAGED_MIN_MTHP_ORDER) {
>                 const u16 new_order =3D state.order - 1;
>
>                 ...
>         }
>
> > +                     mid_offset =3D offset + (num_chunks / 2);
> > +                     push_mthp_bitmap_stack(cc, &top, next_order, mid_=
offset);
> > +                     push_mthp_bitmap_stack(cc, &top, next_order, offs=
et);
>
> I guess one subtlety that wouldn't be obvious at first glance is that
> num_chunks (oh so badly needs a rename :) is a power-of-2 so we never get
> weird 'what if num_chunks is odd' scenarios to worry about.
>
> Probably doesn't really need a comment though. But this _does_ badly need=
s
> an ASCII diagram :):
>
>         /*
>          * The next lowest mTHP order possesses half the number of PTE
>          * entries of the current one. We therefore must consider both
>          * halves of the current mTHP:
>          *
>          *                offset   mid_offset
>          *                  .          |
>          *                  .          v
>          *  |---------------.-------------------|
>          *  |           PTE page table          |
>          *  |---------------.-------------------|
>          *                   <--------><-------->
>          *                     order-1   order-1
>          */
>

yeah a diagram would help a lot!

> Since writing this I copied this above in another suggestion :P so you
> could always say 'see comment above for details' or something.
>
> > +             }
> > +     }
> > +     return collapsed;
> > +}
>
> I've commented this function to death here, but a few more things to note=
.
>
> (BTW - I'm sorry I personally _hate_ repeated iterations of review when
> there's stuff you could have commented in prior iterations BUT I think I
> may end up having to once we respin due to the subtleties here.)
>
> - I wonder if we could just use a helper struct to make this all a little
>   easier. Perhaps as it's realtively short code not so necesary, but a bi=
t
>   horrid to pass around all these paramters all the time. Maybe something
>   for later THP rework.
>
> - Could we exit early if it's obvious that we won't be able to collapse d=
ue
>   to max_ptes_none? I mean for one, we could at least check if the next
>   lowest order is empty. If max_ptes_none was 511, then we would have
>   already collapsed so can surely throw that out?
>
>   I was thinking we could go 'upwards', starting with the lowest order an=
d
>   increasing order (essentially reverse things) then not collapsing until
>   we can't collapse at a given order (so collapse at next lowest). That
>   might be less efficient though.
>
> - Given that we're going to be only permitting max_ptes_none of 0 and 511
>   for mTHP to start with, maybe things can be simplified - either all bit=
s
>   have to 1 or we don't care what they are we attempt colalpse anyway?
>
>   But then again, maybe it's worth having the generic algorithm in place
>   for future flexibility? Thoughts?

I'd prefer to leave the generic algorithm for future work. ie
eagerness, and Baolins shmem mthp collapse support.

>
> - How much have you tested this? This is pretty subtle stuff... it _seems=
_
>   correct to me logically, but this is crying out for some userland testi=
ng
>   that exhaustively throws every possible permutation of state at this
>   function and asserts it's all correct.

Lots! check out https://gitlab.com/npache/khugepaged_mthp_test I use
this to test a number of edge cases, gather statistics, etc.

We've also run a number of our internal CI on this including
performance testing.

>
> - Are we not missing a bunch of stat counts? Didn't we add a bunch but no=
w
>   are actually setting them? E.g. if we reject mTHP candidates due to
>   pte_max_none?

They should already be added in the generalization patches.

>
> > +
> >  static int collapse_scan_pmd(struct mm_struct *mm,
> >                            struct vm_area_struct *vma,
> >                            unsigned long start_addr, bool *mmap_locked,
> > @@ -1364,11 +1455,15 @@ static int collapse_scan_pmd(struct mm_struct *=
mm,
> >  {
> >       pmd_t *pmd;
> >       pte_t *pte, *_pte;
> > +     int i;
> >       int result =3D SCAN_FAIL, referenced =3D 0;
> > -     int none_or_zero =3D 0, shared =3D 0;
> > +     int none_or_zero =3D 0, shared =3D 0, nr_collapsed =3D 0;
> >       struct page *page =3D NULL;
> > +     unsigned int max_ptes_none;
>
> Correct spelling of this :)
>
> >       struct folio *folio =3D NULL;
> >       unsigned long addr;
> > +     unsigned long enabled_orders;
> > +     bool full_scan =3D true;
> >       spinlock_t *ptl;
> >       int node =3D NUMA_NO_NODE, unmapped =3D 0;
> >
> > @@ -1378,16 +1473,29 @@ static int collapse_scan_pmd(struct mm_struct *=
mm,
> >       if (result !=3D SCAN_SUCCEED)
> >               goto out;
> >
> > +     bitmap_zero(cc->mthp_bitmap, HPAGE_PMD_NR);
> >       memset(cc->node_load, 0, sizeof(cc->node_load));
> >       nodes_clear(cc->alloc_nmask);
> > +
> > +     enabled_orders =3D collapse_allowable_orders(vma, vma->vm_flags, =
cc->is_khugepaged);
> > +
> > +     /*
> > +      * If PMD is the only enabled order, enforce max_ptes_none, other=
wise
> > +      * scan all pages to populate the bitmap for mTHP collapse.
> > +      */
>
> Ugh this is quite ugly. I don't really love that we've converted this fro=
m
> doing the actual work to _mostly_ just populating the bitmap for the mthp
> logic.
>
> Then again it's only a couple places where this is checked, but it's pret=
ty
> horrible that what once was _the logic that determines what is being
> considered for THP collapse' is now turned into 'the logic that populates=
 a
> bitmap'.
>
> > +     if (cc->is_khugepaged && enabled_orders =3D=3D _BITUL(HPAGE_PMD_O=
RDER))
>
> I think this should be BIT(HPAGE_PMD_ORDER), I realise I reviewed the
> opposite before (or think I did) but as per David we prefer BIT() :)
>
> > +             full_scan =3D false;
> > +     max_ptes_none =3D collapse_max_ptes_none(HPAGE_PMD_ORDER, full_sc=
an);
>
> Again really quite nasty, this may as well be:
>
>         if (cc->is_khugepaged && enabled_orders =3D=3D BIT(HPAGE_PMD_ORDE=
R))
>                 max_ptes_none =3D khugepaged_max_ptes_none;
>         else
>                 max_ptes_none =3D HPAGE_PMD_NR - 1;
>
> It makes this hack a lot more obvious.

The point of collapse_max_ptes_none was to centralize all this logic
into a helper function.

This check/toggle is mostly to preserve the original khugepaged
behavior (aborting during scan phase), if only PMD is enabled. ie)
full scan vs abort early.

>
> But also, what if !cc->is_khugepaged? We're going to scan everything even
> if we only have PMD? I thought we only considered PMD size for MADV_COLLA=
PSE?

MADV_COLLAPSE also ignores sysfs tunables. So if !khugepaged we still
do the full scan.

>
> > +
> >       pte =3D pte_offset_map_lock(mm, pmd, start_addr, &ptl);
> >       if (!pte) {
> >               result =3D SCAN_PMD_NULL;
> >               goto out;
> >       }
> >
> > -     for (addr =3D start_addr, _pte =3D pte; _pte < pte + HPAGE_PMD_NR=
;
> > -          _pte++, addr +=3D PAGE_SIZE) {
> > +     for (i =3D 0; i < HPAGE_PMD_NR; i++) {
> > +             _pte =3D pte + i;
> > +             addr =3D start_addr + i * PAGE_SIZE;
>
> That's nicer. I still hate _pte...
>
> >               pte_t pteval =3D ptep_get(_pte);
> >               if (is_swap_pte(pteval)) {
> >                       ++unmapped;
> > @@ -1412,8 +1520,7 @@ static int collapse_scan_pmd(struct mm_struct *mm=
,
> >               if (pte_none_or_zero(pteval)) {
> >                       ++none_or_zero;
> >                       if (!userfaultfd_armed(vma) &&
> > -                         (!cc->is_khugepaged ||
> > -                          none_or_zero <=3D khugepaged_max_ptes_none))=
 {
> > +                         none_or_zero <=3D max_ptes_none) {
>
> Why are we dropping !cc->is_khugepaged?

One of the nice things about using the collapse_max_ptes_none helper
is we simplify the logic here. if !cc->is_khugepaged (ie
madv_collapse) we ignore the max_ptes_none value. But the helper
already does this by returning HPAGE_PMD_NR in the case of
madv_collapse.

>
> >                               continue;
> >                       } else {
> >                               result =3D SCAN_EXCEED_NONE_PTE;
> > @@ -1461,6 +1568,8 @@ static int collapse_scan_pmd(struct mm_struct *mm=
,
> >                       }
> >               }
> >
> > +             /* Set bit for occupied pages */
> > +             bitmap_set(cc->mthp_bitmap, i, 1);
>
> Maybe worth highlighting this is now _the entire point_ of the loop.
>
> I wonder if we shouldn't just separate this logic out and name it
> apppropriately? As we're into realms of real confusion here.

That is the clean up that conflicts with my series. We decided to wait
until after as with my changes the helper that was suggested needs to
be reworked.

>
> >               /*
> >                * Record which node the original page is from and save t=
his
> >                * information to cc->node_load[].
> > @@ -1517,9 +1626,12 @@ static int collapse_scan_pmd(struct mm_struct *m=
m,
> >  out_unmap:
> >       pte_unmap_unlock(pte, ptl);
> >       if (result =3D=3D SCAN_SUCCEED) {
> > -             result =3D collapse_huge_page(mm, start_addr, referenced,
> > -                                         unmapped, cc, mmap_locked,
> > -                                         HPAGE_PMD_ORDER, 0);
>
> Hmm... what's actually enforcing that MADV_COLLAPSE isn't using this?
> You've not done any cc->khugepaged checks afaict?

The collapse_allowable_orders helper function handles this.

>
> It seems that you _are_ enabling this for MADV_COLLAPSE unless I've misse=
d
> something?
>
> > +             nr_collapsed =3D collapse_scan_bitmap(mm, start_addr, ref=
erenced, unmapped,
> > +                                           cc, mmap_locked, enabled_or=
ders);
> > +             if (nr_collapsed > 0)
> > +                     result =3D SCAN_SUCCEED;
> > +             else
> > +                     result =3D SCAN_FAIL;
> >       }
> >  out:
> >       trace_mm_khugepaged_scan_pmd(mm, folio, referenced,
> > --
> > 2.51.0
> >
>
> Thanks, Lorenzo

Thanks for the very thorough review! Hopefully I didn't miss any of
your points. I'll get these changes in place before my next version :)

Cheers,
-- Nico

>

