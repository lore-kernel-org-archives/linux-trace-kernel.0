Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE80C2EA48F
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jun 2026 09:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780997506; cv=none; b=gufNBCnZXJbSKMkwlVXiJEGTMC+x9P/iwIR9zAl7bSE771wLfsBY5zDY+8AdXyBOCoiD1h1/QPd+XbMnW2u9+bvezbs4gcHVgjcmER5Bler9PVVd9NhfS76T8HgcqfZccCfpJaGk4wC1KlduhDfWHKUs6/PY5/7jeDdXEc2YfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780997506; c=relaxed/simple;
	bh=Cwau/jZkcWGVugU2u/fXyZ9zAkf/THWESmE7T4IK7oM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u7frvJsLM7BuuGxwe5+Sqjhu+tnf0mhFiEXvKhAteXV0QaimsthO3XtIvHYNOMFPmLomP2RnoBLJgnzOb9JSAJ/HZGCUb1AushcCnicX835S0ZoTXv8jS8y5nJyBfLyoJobDJMbwvLFG2euoZUQ2VQokVsQmLcTufIp1a2BSJxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WkU1Vw/s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WkU1Vw/s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780997503;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2iTl0SUAAjGLBMgcBlGMkkP/SoLVtYGQlCb7tbJPhgM=;
	b=WkU1Vw/seRkfN+1OX8hVeQnP8U3BV67YLUIpmVD+4028bL5EdTReGZVnqsyBhkbX9zvODu
	UrC+Uevw4qFnoYG5x0iziOFoLNsL/OXYN5miy7XHRJRxWFfEQ8wOFwC0WjkDTmmUz4xZnx
	aKHPxbh3rA3QEP6oSNidI2g0NybTJF4=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-FWjycEBXMFSD0uD9iYdryA-1; Tue, 09 Jun 2026 05:31:41 -0400
X-MC-Unique: FWjycEBXMFSD0uD9iYdryA-1
X-Mimecast-MFC-AGG-ID: FWjycEBXMFSD0uD9iYdryA_1780997500
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7f11b0dd576so31166417b3.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jun 2026 02:31:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780997500; x=1781602300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2iTl0SUAAjGLBMgcBlGMkkP/SoLVtYGQlCb7tbJPhgM=;
        b=qBK9AMoFdH21fjqIJbdiW3jWt2xUjwDdptVvNxDs/xKsAFUEpdSo3rOXLsVk/eYU2E
         0bTIYn9CiRctUXk5fvsEumjd6hTg72rpvmbEw7hPJkxK8TCHUPc4eWI2BdVUDbv4lh2s
         KOlijsYU+ldroKIHTFYqCGcI4VgNdgDf3Szd6/wRxaRZLX7HJdKlcvK5LWm7Pyd+FwLK
         I9wub8WOCK2D2zq/+tr963nUgCi2bh3fJCCLiTu9bMX8VuRQi+7Tm3UgbATylqSjVUZU
         aKe/6O37MypjKSxX3QbV12oQGNQLXfy0QMiOFYagfsnMbum+ThIdbVyQtNdgrBU8ug+L
         33JA==
X-Forwarded-Encrypted: i=1; AFNElJ+oDugQ0Jj36iEUoRpG3kx0CLX/M9jNDBiZq2uMCuXRiqfWCTIwcaf5nq+BzIIeh+/NnkkgAk9fzkZzA2XK5vrhzNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaCQ17uw5zexuzZixJy7uPgpgGQE1V0libeJxf46wwcxrh+WL6
	wxN/LwX/ixRD1vpRj5JomSwjDcOYV3lU0oRRB3/iUZn9gsWpfJu0H8GqwuyOEbGv4qZtUsZprL+
	FCQHIKLo6BfJpTupxYqING3v8OcAeaevebFOuwmo8HAa4iaMZMYPuExqc6txPuOlugOoetQwHLa
	loUMuJLHu0v0ldo0nu1IV3mVb/w8DCB3wyEYBzRRuwfNB79Vw4YHXf95Mjfww=
X-Gm-Gg: Acq92OHDavoDAgRC4ibEmCLWAJxB4fOZLVw10pUFrWeNp/4QObEzWOqsaemRjSt0e72
	383CrKXuCFHkmIBR84mA6m31J7+nrV3SXxsVwde5QAwpbiVifDNlzKejHukX2vfBt1N4XtBKLd0
	Sn6h/fh4xV4dk0i0L0TnAFPAXds4SnTjzdgt7JPVwulHhl7yaqTMAfvmxyXU//JqtmN5ea2c0+j
	reQO13y5o1ddYDF
X-Received: by 2002:a05:690e:4395:b0:660:6f06:ae6e with SMTP id 956f58d0204a3-661070ce78amr11702543d50.64.1780997500245;
        Tue, 09 Jun 2026 02:31:40 -0700 (PDT)
X-Received: by 2002:a05:690e:4395:b0:660:6f06:ae6e with SMTP id
 956f58d0204a3-661070ce78amr11702475d50.64.1780997499604; Tue, 09 Jun 2026
 02:31:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605161422.213817-12-npache@redhat.com> <20260606102800.26940-1-lance.yang@linux.dev>
 <2553caae-9e0e-42a7-8b61-d1216f1e81fa@kernel.org> <CAA1CXcBY_2372eJru8VoCq90rUMxn7w23hHou68MmXRv48NRXg@mail.gmail.com>
 <b7fb4184-7a99-42c7-8ee2-4c7fa20827c4@kernel.org>
In-Reply-To: <b7fb4184-7a99-42c7-8ee2-4c7fa20827c4@kernel.org>
From: Nico Pache <npache@redhat.com>
Date: Tue, 9 Jun 2026 03:32:26 -0600
X-Gm-Features: AVVi8Cfncpxkxzck5Whc94MJ57VmWeE0wGEzvVhdZp86lxoGqXC5OmGR9iRBiTY
Message-ID: <CAA1CXcAhw8V+_dYcrqmtZ9ht4Pqz5PPB8EOcDrVCp4DA4y7pLg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v19 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, dev.jain@arm.com, gourry@gourry.net, 
	hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, jackmanb@google.com, 
	jannh@google.com, jglisse@google.com, joshua.hahnjy@gmail.com, kas@kernel.org, 
	liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oa6Tfb-p7JfldV52184SjAKJeXzGuOnOaG7TXXGReM8_1780997500
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 9, 2026 at 3:26=E2=80=AFAM David Hildenbrand (Arm) <david@kerne=
l.org> wrote:
>
> On 6/9/26 11:06, Nico Pache wrote:
> > On Mon, Jun 8, 2026 at 8:57=E2=80=AFAM David Hildenbrand (Arm) <david@k=
ernel.org> wrote:
> >>
> >> On 6/6/26 12:28, Lance Yang wrote:
> >>>
> >>>
> >>> Looks broken for swap PTEs in PMD collapse ...
> >>>
> >>> collapse_scan_pmd() allows them up to max_ptes_swap and record them i=
n
> >>> unmapped, but they don't get a bit in mthp_present_ptes. And then
> >>> mthp_collapse() does the check above:
> >>
> >> Right. I assumed this is implicitly handled by the optimization in col=
lapse_scan_pmd:
> >>
> >>         if (enabled_orders !=3D BIT(HPAGE_PMD_ORDER))
> >>                 max_ptes_none =3D KHUGEPAGED_MAX_PTES_LIMIT;
> >>
> >> But we perform the check a second time.
> >>
> >>>
> >>> nr_occupied_ptes >=3D nr_ptes - max_ptes_none
> >>>
> >>> So max_ptes_none=3D0 + 511 present PTEs + one allowed swap PTE won't =
even
> >>> call collapse_huge_page() for PMD order.
> >>>
> >>> Shouldn't we account for them in the PMD-order check? Something like:
> >>>
> >>> if (is_pmd_order(order))
> >>>       nr_occupied_ptes +=3D unmapped;
> >
> > This solution seems good for a temporary fixup. but longterm we may
> > want something else. I'm still not sure how we plan on supporting
> > swapin without causing creep. So I'd be ok with adding a fix for
> > legacy PMD behavior until we know how to handle mTHP creep correctly.
> >
> >> As an alternative, we could either 1) skip the check there for
> >> pmd order (as the check was already done); or 2) introduce+maintain
> >> a bitmap that tracks non-present PTEs.
> >>
> >> @@ -1475,7 +1477,9 @@ static enum scan_result mthp_collapse(struct mm_=
struct *mm,
> >>                 nr_occupied_ptes =3D bitmap_weight_from(cc->mthp_prese=
nt_ptes, offset,
> >>                                                       offset + nr_ptes=
);
> >>
> >> -               if (nr_occupied_ptes >=3D nr_ptes - max_ptes_none) {
> >> +               /* Check was already done in the caller. */
> >> +               if (is_pmd_order(order) ||
> >> +                   nr_occupied_ptes >=3D nr_ptes - max_ptes_none) {
> >>                         enum scan_result ret;
> >>
> >>                         collapse_address =3D address + offset * PAGE_S=
IZE;
> >>
> >> 2) would probably be cleanest long-term.
> >
> > That would be best for future swapin support in mTHP, but I still
> > don't think it solves the creep issue.
>
> It wouldn't, we'd simply maintain the state we collect + rely on in separ=
ate
> bitmaps. On swapin, we'd have to update/refresh bitmaps I guess.

Yeah, I'm saying for the future, it obviously solves this issue here
as well, but if we have positional tracking of the swapout, shared,
and none PTEs, I think we can use this to determine whether the
collapse would lead to creep. If we detect creep would happen it may
be best to automatically collapse to the N+1 (or greater) candidate.
Just thinking outloud here.

>
> > Perhaps we could combine the
> > two bitmaps to determine if it would make the future collapse eligible
> > again? Not sure but ill start thinking about it.
> >
> > Should I send a fixup for this using Lance's solution? Or does Lance
> > want to send a patch out with the fixes tag?
>
> If Lance could send a fixup, explaining the situation, that would be nice=
.

OK, I'd appreciate that :)

Cheers,
-- Nico

>
> --
> Cheers,
>
> David
>

