Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F030DEB5
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764199805; cv=none; b=fI6cAd6OvOYLRhcMjiZUp0YluQMXMFD2T2y9mv+Hy7Xf+L3usmqinXa6e/qIeQ5m+SdoMtc3vc/C/PQ/Oj5p0qhNOUDBf1lc3Ai6VOpBspnRjJckRxb+2Cx/phrA/4d2m0wEKR3dKEFZlclVrXNdGcJHTExOEpfDqzpr9gPtFC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764199805; c=relaxed/simple;
	bh=P5gc2t+MgdEjghBHlnXnRBNuOMb4GXnkVbz+H2DnAO0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHEYlVQtRVIKd3nZ+L3rjHWGTw2WRM/QKqA6sx39AB5AvY/4YapxYnZTDvLDHM/ibsqYcSDOm5wnv5R+9OZf4aWntkUp4TF7FbwvA2h1zluheqluCOTmAtA7VLPC9pCAmwo1b7s89GKc74c7IT9hXdNnXYdcRCIpyTV8yHj/GaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E51+Mp1M; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E51+Mp1M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764199801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WaAYG5VDFXsv/Iixri0H6uBMNMIoUe5mbi2ivxpfSFc=;
	b=E51+Mp1MvNc1A4a9Hij+SOhMBvkJQ/RBkGCqH+CUhDV9u+J06dGyzedtqpTRgjwTr2TZqk
	d9AhU94UbLukoPrPWK8UQMA58mv2qVO663XE6CvQrs594rKkynYuQ0DkncgiaWBwSaRSWF
	IFHl+lgZuJhNdPgqC9mizsBWnWzKi6s=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-bS2PWpFhNraW7pUhCJd-8A-1; Wed, 26 Nov 2025 18:29:59 -0500
X-MC-Unique: bS2PWpFhNraW7pUhCJd-8A-1
X-Mimecast-MFC-AGG-ID: bS2PWpFhNraW7pUhCJd-8A_1764199799
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-785fe1db378so4666747b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 15:29:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764199799; x=1764804599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WaAYG5VDFXsv/Iixri0H6uBMNMIoUe5mbi2ivxpfSFc=;
        b=lS9y+u/SpxXSf6hMPgsNUPzb6D+HRCthcbG9wn2SE9MAwhWA9FdDQanKnILg8d00dP
         Xh3taOytGmwo9MExLNgglMHoOBm0Km40OV2bGKDEOsr/sZwffNva1FEIKmIi/tPx1shz
         c6MlTaOUg9kTXrTpZMpgp464pdJuIbbO8HxktLEyJd1RrUjwM5I+2w+LnlcKh2UgaJV/
         OsI9AWbdkZhTrRFbzz6VCAl+0sHeU2usVucWvBIQbc9JqPJSYU9ByE2zYGKYhyA0kRCS
         g+NZoxf+2GEMjPF7sCFcl0fP1sy3x2oW+0/CkgD/n4Y+a2KNsUReiZWrJSYoQ7WHAesK
         0d+A==
X-Forwarded-Encrypted: i=1; AJvYcCVEwYQgkih2AszPEPY6XlQzka4uMp/nZlPkS0MGQAklACfpqdnK35sIGHgxoaswyPgLjyl2rg9JAaF/8bZqIvLMXzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznAeHZ0QyJ3UKfnkm6ft+BT25x/TbPFRQyDguJtfwHFhrL0hZC
	Dv32W6u2vlHzJwtA+xOA9Tpnhqb2pJvzB3ZpnW/tMsp6xl5WTgugYpWGse2HbWBMkGikcZWKGoJ
	7EHNXiURD71l97XvTd1MysO7ZDWy14B51oUkmCE1u7Iufd5nhir2kAGaDEeU4u/WPDpS+OWLdTH
	QiuKhMa19KdHg3/OHvMO3G2Np8kPHdi4I/+ZqORv5lTgrmLnew
X-Gm-Gg: ASbGncswBJ3/cjS5zIK3RVI76Un36aV7tdfK6PLuWAYJzpONPXptG+2HV9F86oBlU1c
	alVoFZXNJ2RBH+8vKvhSv3P9m+cfMl5bqvLJnc8Wf40PvZ53V0RJdQdE+Kz07o/su+jf4F3v0vc
	M0zXM5OJICUzJ6aNMfT/z/EHw5VBJs7d0spTu15qkFuZwTibYd+xxwruie7d4+IeyvLY+FQtkms
	HxGDJ+8
X-Received: by 2002:a05:690c:6d11:b0:786:7017:9506 with SMTP id 00721157ae682-78a8b50d225mr179507887b3.43.1764199799262;
        Wed, 26 Nov 2025 15:29:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEM04nXlhLyHhOF4P67Ng8vhtTcvmR+j3q1fjlImcKmWBZ7ursgcIGrQVIExNz7VgFRd9eGD2XP0bTyZR5NgLY=
X-Received: by 2002:a05:690c:6d11:b0:786:7017:9506 with SMTP id
 00721157ae682-78a8b50d225mr179507437b3.43.1764199798871; Wed, 26 Nov 2025
 15:29:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022183717.70829-1-npache@redhat.com> <20251022183717.70829-14-npache@redhat.com>
 <541a75fe-3635-49ab-b61f-d86afc96df98@lucifer.local>
In-Reply-To: <541a75fe-3635-49ab-b61f-d86afc96df98@lucifer.local>
From: Nico Pache <npache@redhat.com>
Date: Wed, 26 Nov 2025 16:29:32 -0700
X-Gm-Features: AWmQ_bmAlUVjee7DwzVRQDWabQ2jDP4iBXrMJ-Yz-HT4KcafaonxgE42edAAM08
Message-ID: <CAA1CXcBMWc04Z+7mdDAZHkSj5WGDAMc+-4p7JiTme3xCqtNXFg@mail.gmail.com>
Subject: Re: [PATCH v12 mm-new 13/15] khugepaged: avoid unnecessary mTHP
 collapse attempts
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
X-Mimecast-MFC-PROC-ID: YoTe4zMjvvPvyuhDZXZOtMZjym1wIMk98Y4oJ_7brhg_1764199799
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 5:06=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Wed, Oct 22, 2025 at 12:37:15PM -0600, Nico Pache wrote:
> > There are cases where, if an attempted collapse fails, all subsequent
> > orders are guaranteed to also fail. Avoid these collapse attempts by
> > bailing out early.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 31 ++++++++++++++++++++++++++++++-
> >  1 file changed, 30 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index e2319bfd0065..54f5c7888e46 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1431,10 +1431,39 @@ static int collapse_scan_bitmap(struct mm_struc=
t *mm, unsigned long address,
> >                       ret =3D collapse_huge_page(mm, address, reference=
d,
> >                                                unmapped, cc, mmap_locke=
d,
> >                                                order, offset);
> > -                     if (ret =3D=3D SCAN_SUCCEED) {
> > +
> > +                     /*
> > +                      * Analyze failure reason to determine next actio=
n:
> > +                      * - goto next_order: try smaller orders in same =
region
> > +                      * - continue: try other regions at same order
>
> The stack is a DFS, so this isn't correct, you may have pushed a bunch of=
 higher
> order candidate mTHPs (I don't like plain 'region') which you will also t=
rue.
>
> > +                      * - break: stop all attempts (system-wide failur=
e)
> > +                      */
>
> This comment isn't hugely helpful, just put the relevant comments next to=
 each
> of the goto, continue, break (soon to be return re: review below) stateme=
nts
> please.
>
> > +                     switch (ret) {
> > +                     /* Cases were we should continue to the next regi=
on */
> > +                     case SCAN_SUCCEED:
> >                               collapsed +=3D 1UL << order;
> > +                             fallthrough;
> > +                     case SCAN_PTE_MAPPED_HUGEPAGE:
> >                               continue;
>
> Would we not run into trouble potentially in the previous patch's impleme=
ntation
> of this examing candidate mTHPs that are part of an already existing huge=
 page,
> or would a folio check in the collapse just make this wasted work?

whoops almost missed this comment.

There is a folio check in the __collapse_huge_page_isolate function
that handles this. I think Dev has some plans to try and add
partially-mapped support as the todo comment suggests (I think he
already has some patches from earlier mTHP work).

/*
* TODO: In some cases of partially-mapped folios, we'd actually
* want to collapse.
*/

>
> > +                     /* Cases were lower orders might still succeed */
> > +                     case SCAN_LACK_REFERENCED_PAGE:
> > +                     case SCAN_EXCEED_NONE_PTE:
>
> How can we, having checked the max_pte_none, still fail due to this?
>
> > +                     case SCAN_EXCEED_SWAP_PTE:
> > +                     case SCAN_EXCEED_SHARED_PTE:
> > +                     case SCAN_PAGE_LOCK:
> > +                     case SCAN_PAGE_COUNT:
> > +                     case SCAN_PAGE_LRU:
> > +                     case SCAN_PAGE_NULL:
> > +                     case SCAN_DEL_PAGE_LRU:
> > +                     case SCAN_PTE_NON_PRESENT:
> > +                     case SCAN_PTE_UFFD_WP:
> > +                     case SCAN_ALLOC_HUGE_PAGE_FAIL:
> > +                             goto next_order;
> > +                     /* All other cases should stop collapse attempts =
*/
>
> I don't love us having a catch-all, plase spell out all cases.
>
> > +                     default:
> > +                             break;
> >                       }
> > +                     break;
>
> _Hate_ this double break. Just return collapsed please.
>
> >               }
> >
> >  next_order:
> > --
> > 2.51.0
> >
>

