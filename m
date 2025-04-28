Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC58A279919
	for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745855082; cv=none; b=fgPSBbUmQXgXkPsFfC3HP4whHUXDQtPtJxfE8gBp3rK+INizS5eqwsuRuebrhDKalxXoEq+LvrACv81lHbsIc/Ik1Oql38HE9b6n0ItCgBvkrD4GNae8abYGJ4D8+GIb4VPpUVkwluS2s+/m69OAqhu8lwziMnbd4/x1oylAAEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745855082; c=relaxed/simple;
	bh=JRoFg1ifrt/ihL83AT1Ka7YY9StfO8fc3iHKwc1eEVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h4VTlesyzxAPYVWVrqJao3R8w3+lJQmdUoEwv4QkGHgjk9jcKXib5ZJ6+1JuYTZpuyOYfbU+/v/gU+6vwwWhh1l9ETRFaZ9fpIeD6xMP5AO6ms2nQHa9V5YO2UQh4YqD6Aqh59YW+cw5GKhB55QEbLP8zWWIgNHJw9vwzO1Uct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WOLHGwow; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WOLHGwow"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745855079;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxbbN4qJN6Ru59aJPa/Q4S65KBGqqKkgsmmSWCFTdOU=;
	b=WOLHGwowcqMXdcuJQfHa6JMxwja0nAVc88GID827CfsjXkm/XwRqqOeXykH1jagABCSgPn
	kYlzwcbNRVB8yjbABRUfHWhmGaohbVhLac9t+jpQ63Q29uyRgulKDAozRkyvZ637P42d5m
	Tyx4pn/rzNAyjQGMAYd9O4tdzTPZN7c=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-9QhcEqA9P3KHrg3oxvuPKw-1; Mon, 28 Apr 2025 11:44:37 -0400
X-MC-Unique: 9QhcEqA9P3KHrg3oxvuPKw-1
X-Mimecast-MFC-AGG-ID: 9QhcEqA9P3KHrg3oxvuPKw_1745855077
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-706b9f19d8bso53740937b3.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Apr 2025 08:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745855077; x=1746459877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxbbN4qJN6Ru59aJPa/Q4S65KBGqqKkgsmmSWCFTdOU=;
        b=VPzS89yg3yF/mbaL+HXfXUYrj8h4a/JpzE4Ju56pM7xA9Tl8YcCCvyxGiWBu6oOvqa
         7vGsdKsWB/OaYa6WwfbBMbC6Jt8chhdbs79jkPa6EyQm9w5RdqZo+czNBvR0eBupOvyL
         XL5KsQn9ugOjdDZUubA0qW89FBd8CGoq0p8kJUGwo2JUrORdHMU0zu60Gxh6/WW55QZd
         j37SRfu21sB4NxmcD372qjlyi8SQEy9MhlnLLc14edlgI7JoH5+QGxFsZnU1Zka+q7T0
         Z8pKjdq/1DpWd5UG57+U4X+XBaCr2l5fBMNqXGEJMK9d/MpPO/uOhVa49EUGRDI06hqk
         SA3A==
X-Forwarded-Encrypted: i=1; AJvYcCW0cDhlHETlzVIvAkjY9MDmn59f8mulr0KQEUQH9fe26Lz6qqoC50wRciDblaSepiCTr9lVObnIsLQB4Z0kd/S7BxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmLAZJhzhMoxLIuOffvYEZ54ZXhhiQ9VvyWp/K0BYcUwIO+Qgz
	Dhq8LjoZq7Bhbkxt6kj2Z5yolu95/pYGr4tZjbvO8ePWf2WbARixwpHse/XZRb+wteoFGVdVCH4
	uys9vdSd+LdEWhOpUE1YjQgomLrChIv9T4dqzEQ13t84HG4NufDEWkts/SHLspGEGxhiD7hZx5X
	FfR8E/wtQtOjgYOQntV8v4iEjkHxrHGcH9tX6+fn6Gn+Xw
X-Gm-Gg: ASbGncsnuhjHjZj41oEloBOVtcWJlg5nuEwmYFpy1Y9s+Ag5AUL8LHGzfV7dDQjXUMT
	Y4dL0U1fOqJKxx/AnsS9Gy+x9aW1NzdVpv4SE3SzwRoD0w8fEsrHjGaDJBV1c8NXLQkZtGChvxo
	nscx3OUn4=
X-Received: by 2002:a05:690c:6b87:b0:6ef:5c57:904 with SMTP id 00721157ae682-708540ce38amr156786467b3.7.1745855076643;
        Mon, 28 Apr 2025 08:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6qCK0RP1Osqb6P+Q+6TNekm7P5LWk3+X90KpMgq7ufBwRs3S0yE0ZPxUoRWXjGPRpcWW70ryslqWVN+3xc60=
X-Received: by 2002:a05:690c:6b87:b0:6ef:5c57:904 with SMTP id
 00721157ae682-708540ce38amr156785937b3.7.1745855076172; Mon, 28 Apr 2025
 08:44:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250417000238.74567-1-npache@redhat.com> <20250417000238.74567-9-npache@redhat.com>
 <fb932eac-86ce-4f7d-8eed-8dc44f5a40c1@linux.alibaba.com>
In-Reply-To: <fb932eac-86ce-4f7d-8eed-8dc44f5a40c1@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 28 Apr 2025 09:44:09 -0600
X-Gm-Features: ATxdqUE76Pjv3zn_HiGc1qM-i1cE-erjrnyMNKG7-H8ENZEIid857QeclmukKN8
Message-ID: <CAA1CXcCEsdW+k96DX3LZ6J4MmNEnugyxCXcHkneqxV4-nahmsg@mail.gmail.com>
Subject: Re: [PATCH v4 08/12] khugepaged: skip collapsing mTHP to smaller orders
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com, 
	baohua@kernel.org, ryan.roberts@arm.com, willy@infradead.org, 
	peterx@redhat.com, ziy@nvidia.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	dev.jain@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, 
	tiwai@suse.de, will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, 
	cl@gentwo.org, jglisse@google.com, surenb@google.com, zokeefe@google.com, 
	hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com, 
	rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CPAsTWGOjilwdS1dYiEJrhGhG5BbFmgRyIzZ2w0uP4o_1745855077
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 1:49=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/4/17 08:02, Nico Pache wrote:
> > khugepaged may try to collapse a mTHP to a smaller mTHP, resulting in
> > some pages being unmapped. Skip these cases until we have a way to chec=
k
> > if its ok to collapse to a smaller mTHP size (like in the case of a
> > partially mapped folio).
> >
> > This patch is inspired by Dev Jain's work on khugepaged mTHP support [1=
].
> >
> > [1] https://lore.kernel.org/lkml/20241216165105.56185-11-dev.jain@arm.c=
om/
> >
> > Co-developed-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 7 ++++++-
> >   1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index ece39fd71fe6..383aff12cd43 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -625,7 +625,12 @@ static int __collapse_huge_page_isolate(struct vm_=
area_struct *vma,
> >               folio =3D page_folio(page);
> >               VM_BUG_ON_FOLIO(!folio_test_anon(folio), folio);
> >
> > -             /* See hpage_collapse_scan_pmd(). */
> > +             if (order !=3D HPAGE_PMD_ORDER && folio_order(folio) >=3D=
 order) {
> > +                     result =3D SCAN_PTE_MAPPED_HUGEPAGE;
> > +                     goto out;
> > +             }
>
> Should we also add this check in hpage_collapse_scan_pmd() to abort the
> scan early?
No I dont think so, we can't abort there because we dont know the
attempted collapse order, and we dont want to miss potential mTHP
collapses (by bailing out early and not populating the bitmap).

-- Nico
>

