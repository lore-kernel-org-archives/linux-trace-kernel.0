Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F93032E720
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772138895; cv=none; b=CLMhAkTmBe9cwrad7heneJYit4JNsBXQfOA6Gt/tTG7RvPhDDtnA9ce5v9q2bhP/IjqftEa493VIlg5wVrEmHkGCciRdlLbpJAatVzCTiMYTA/pc+k+faLWFOq5trZlSLgoXMrnHkfCD6GTcFoDSpWlkF9z3dmZdtBQRmIRVnTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772138895; c=relaxed/simple;
	bh=pGelGEWoARZEbYWVtNHAIN0oEiqW0sUUQSCnGat00B4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D9NwcQeJI6uk6B56UQVhjmLjKO5pxjyTyCvYuef43B2kR9apAdgfb7vxXlWfnh6XldCbxcXaGghCdkTzEJh65SU/GV0hjYa9w8UxS7822tG0L4oRF2+jmxMxzhsQYdPS3HELQLJNPXYetSBtyA41F03rjNqC0TXwN1Zn7cvhRMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FAPpkHye; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FAPpkHye"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772138893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DBGoyglCoH58OEzLS/UrEve2JlXeuQURn1O9kwrT3LQ=;
	b=FAPpkHyeOTu03lXk8Qcc931Rj8bvst9PsLdU1FpUGgWBqiTTfL6i1a8aL77m+cAdLIBk7X
	tO/+gBWl2F8XenYIdO4Vpm3HKZQtfHptSNU5eBvKwJK8eXiA6A3JzpXw9OamFjvoDc5L3P
	g7uLQ0S8FZCvnhOBJEO9B9pt43SIq4Y=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-547-sKeCfbjBN76pKU69b51BXg-1; Thu, 26 Feb 2026 15:48:12 -0500
X-MC-Unique: sKeCfbjBN76pKU69b51BXg-1
X-Mimecast-MFC-AGG-ID: sKeCfbjBN76pKU69b51BXg_1772138892
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-64c9d15b682so1933994d50.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 12:48:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772138892; x=1772743692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DBGoyglCoH58OEzLS/UrEve2JlXeuQURn1O9kwrT3LQ=;
        b=Bej23DC9cbSBje6bCH1/P2OBK2J4bFQH54CuVJgk/Zr7yVuxWPs0Bq2KcBvd8oKzIT
         Gmydw5QQjOND770J+QI1MRlQg1MjRdfqmpz3qlpZtxyvUymSJWnhydUJTvbWjNn8Zy7J
         Q+nXmQyoGowU3aL3sw42WiIajOvGBt1UiQhk5V15NcG7PgDV2n2vzdC7h2/KVdmba7Q3
         8PeyI6gYtIdefEC0Qx545S1bpN5c0WxHiNZRF9DV6RW/Z2vCvZECNH2XEns8O2Yogc/P
         oF7jjhc0Dlzu5SUDIFFnNVfdE7l+QNV7W83qjysv4xfKghOHr8atY7zsM9GW2RMzBAR6
         2xeA==
X-Forwarded-Encrypted: i=1; AJvYcCW4o8U1AtI1o8fIdnn0pTnXj+h5g7SDzst1F9GzEeuxq8GmmhmQrMuicsGqDgo0fX3DDh3ylfs8rHZFZ6iyW2KWOGA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxtZAYqSFro+PJGoTuLtqHOfppr/rZt1/ZqAVPul2YTIc8275E
	PtpOo+tCnwUVBZjC5EItChN9rxqgm2YKzTn6LEUJKQc2cItKXfs/FZ7ru0b0a7TYGGOy5hUI1Y2
	YD2+DwgTZ7OUnmsAZNRKSB1G/Ft+Fr7czlZ/hDsChtqhf5+3jHPzFJIGqL5W9JYZxjspDjBwm/I
	X7+5iop4U2MzZGJDVWiHkFVmjN6Q1/SqtNRPuI6V9V0H0xXdg5
X-Gm-Gg: ATEYQzxjOMzs3pCj5z1bLHC+JEw0FPKL3Hp1H3mJ7lizBzSi6YzqB9d+glveSWeqI5x
	nh6XkvGXfSLs1ICGEu/w30LNzDiv78fNsPwFugLFf+BIpz0aK7hUPZevhItnVUoZTdzzjJ5NWIz
	4SXhxmk99oYnxKHrSFW2/04pleUONhNeCzOVQ1xDehOMd9IgXFB5ipELa3aJx3cOfwXtrxRYH90
	oAh
X-Received: by 2002:a53:b3cd:0:b0:64c:21c4:d017 with SMTP id 956f58d0204a3-64cc23040bdmr466104d50.78.1772138891640;
        Thu, 26 Feb 2026 12:48:11 -0800 (PST)
X-Received: by 2002:a53:b3cd:0:b0:64c:21c4:d017 with SMTP id
 956f58d0204a3-64cc23040bdmr466079d50.78.1772138891111; Thu, 26 Feb 2026
 12:48:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260226032631.234234-1-npache@redhat.com> <20260226162653.3802758-1-usama.arif@linux.dev>
In-Reply-To: <20260226162653.3802758-1-usama.arif@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Thu, 26 Feb 2026 13:47:45 -0700
X-Gm-Features: AaiRm52157O9qaaRKfnMN5AsfoDvaP_wlb8rkPZ8cTI77RXDfAxJaKiPZ96ZOHw
Message-ID: <CAA1CXcCwXAn8uSidF52o=PBUUY-JwT14U70yxtMuUX=iQqRaPw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v15 11/13] mm/khugepaged: avoid unnecessary
 mTHP collapse attempts
To: Usama Arif <usama.arif@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, 
	raquini@redhat.com, rdunlap@infradead.org, richard.weiyang@gmail.com, 
	rientjes@google.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sunnanyong@huawei.com, 
	surenb@google.com, thomas.hellstrom@linux.intel.com, tiwai@suse.de, 
	usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y7RT6oedm8en74kHe9So5NdRHhw4WnQ2UDpHc4l7KAU_1772138892
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 9:27=E2=80=AFAM Usama Arif <usama.arif@linux.dev> w=
rote:
>
> On Wed, 25 Feb 2026 20:26:31 -0700 Nico Pache <npache@redhat.com> wrote:
>
> > There are cases where, if an attempted collapse fails, all subsequent
> > orders are guaranteed to also fail. Avoid these collapse attempts by
> > bailing out early.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >  mm/khugepaged.c | 35 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 34 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index 1c3711ed4513..388d3f2537e2 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1492,9 +1492,42 @@ static int mthp_collapse(struct mm_struct *mm, u=
nsigned long address,
> >                       ret =3D collapse_huge_page(mm, collapse_address, =
referenced,
> >                                                unmapped, cc, mmap_locke=
d,
> >                                                order);
> > -                     if (ret =3D=3D SCAN_SUCCEED) {
> > +
> > +                     switch (ret) {
> > +                     /* Cases were we continue to next collapse candid=
ate */
> > +                     case SCAN_SUCCEED:
> >                               collapsed +=3D nr_pte_entries;
> > +                             fallthrough;
> > +                     case SCAN_PTE_MAPPED_HUGEPAGE:
> >                               continue;
> > +                     /* Cases were lower orders might still succeed */
> > +                     case SCAN_LACK_REFERENCED_PAGE:
> > +                     case SCAN_EXCEED_NONE_PTE:
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
> > +                     /* Cases were no further collapse is possible */
> > +                     case SCAN_CGROUP_CHARGE_FAIL:
>
> The only one that stands out to me is SCAN_CGROUP_CHARGE_FAIL. memcg char=
ging
> of higher order folio might fail, but a lower order folio might pass?
> That said, if the cgroup is that tight, continuing collapse work may not
> be productive.
>
> Acked-by: Usama Arif <usama.arif@linux.dev>

Thanks! IIRC, David and I discussed all of these off chain to confirm
their placement. I had this in the 'next_order' case at some point and
David recommended it to "fail" for the same reason you state here:
collapsing or charging large order pages in such a tight cgroup is
likely unproductive and not worth the effort.

In contrast, SCAN_ALLOC_HUGE_PAGE_FAIL does not necessarily indicate a
resource constraint, but it could. We might fail to allocate an N-page
size due to fragmentation, but we could easily find an (N-1) size. We
could also have a scenario where a lack of memory causes the failure,
iterating all the way down, which would be unproductive. However, at
that point the OOM reaper should be active and the system will already
be cornered in multiple ways, so it should be ok.

Hopefully that gives some insight into the decisions made here :)

Cheers,
-- Nico

>
> > +                     case SCAN_COPY_MC:
> > +                     case SCAN_ADDRESS_RANGE:
> > +                     case SCAN_NO_PTE_TABLE:
> > +                     case SCAN_ANY_PROCESS:
> > +                     case SCAN_VMA_NULL:
> > +                     case SCAN_VMA_CHECK:
> > +                     case SCAN_SCAN_ABORT:
> > +                     case SCAN_PAGE_ANON:
> > +                     case SCAN_PMD_MAPPED:
> > +                     case SCAN_FAIL:
> > +                     default:
> > +                             return collapsed;
> >                       }
> >               }
> >
> > --
> > 2.53.0
> >
> >
>

