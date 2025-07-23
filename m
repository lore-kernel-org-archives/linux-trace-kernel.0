Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769C819342F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Jul 2025 01:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753235796; cv=none; b=C7eQGgIPV2ps1YT5tAWFwffEPd5CkgV30fUkDSOZV8NlqZg2tYY8AumuDC0S/knXipDWLODpk6q++ZvR7yqrMvfrXWDffc9+uv7Og3OyMNcQ4h9jykjD5wwCa7CQGlQePbo7z3Fb8dDkmbFH2WCx4K4W7HJr5QqJrTq9nIEOeW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753235796; c=relaxed/simple;
	bh=UsqLSZacBq45W96m+y3fml3UQ5BoewuHq43gE7MllPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=undJThMFmqBVxM8OJVbhEluCz9j7Cw7s4yL1ulkEs42k5EZfRMOeq4uAJyN65cYJellfse3iuk+uimn8h2/7/HGwqGWuiphC6HjtSxwJIEZXrWlUOM2HYNoyFNbEmlTjA+bXr4Iw9V7Na+8Z3cNJFCW9FHuwAG9t2SPgkLIrLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ainb3BsD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ainb3BsD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753235793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IWvY+EVRl1d4IEPEsV3Ro9T/i9D4GNDRhkSCFN4ly7M=;
	b=Ainb3BsDVGlGY4brn9nH0ABjnmyGK8q0yHL7SgXt2bcOzMvFGnfocJHrPAc9Q+QD6YKmTW
	xVyHrUTit9qEgCge54zrMIYqoF+ks6ctzPHCjOeK2GaRPBDHw7l+IDaDUVn97aUelmMfXs
	S7WHhtf7t29dOYg0B9/lplvtrptf8Vw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-9tgKk-VGO5ejbRrk-mHYnA-1; Tue, 22 Jul 2025 21:56:31 -0400
X-MC-Unique: 9tgKk-VGO5ejbRrk-mHYnA-1
X-Mimecast-MFC-AGG-ID: 9tgKk-VGO5ejbRrk-mHYnA_1753235791
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-710f05af33eso83140107b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:56:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753235791; x=1753840591;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IWvY+EVRl1d4IEPEsV3Ro9T/i9D4GNDRhkSCFN4ly7M=;
        b=QOopsm0f5LsGdc5BnRbsOKdZeiobUtm8RLkuSUIdI2DifsPhAMUaRgeSOjBNBfU23M
         p3ONgK6rpJP8a+3iUXIIUT6ZTX3RbqPHu4LZe37/DokdFloWmDJK96Vchd1IduEmyw8N
         ftd7HVY778D3bSyZRA6HKAimyy2NLpzWnl3pVv4uIwVuQun/1Q5eNu7oe+N+pusyfuUO
         cl+pbnesEeD5wM1xTV9O7XnamwAFmfEWLfSLyCxGArAO6koaMR1Ek/Bvvu2iAY4lZGGE
         8hXdRg0O8NJAJSQ5jZWyT1MYjdTEnR3i4MZq6bjpjznKYridIQ7seFY9IChOl6b2jBO7
         FiEA==
X-Forwarded-Encrypted: i=1; AJvYcCVUTg2qZ2nW7ea6If8o6mzyRAisbiZQAmaAMJhNqlB9n+19cY+FaApGAFuTxMQkUFC5Zgv8tyAXGd7PcygSWSQRUmE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDuTEGve5X93e2GUzCZscEFdqbw2oI/pWYJJgKvL+RbvDei2Pi
	lsN5rCvIDBkT8GmAHn1d1fQvttTYuqaP+nNbzoVb9gXE1NV0gStGRWrxzSb6UwSBdLnUiEwcYbd
	1J+vC58HKmrS4TXEGxcExuTYeKS/bc9cDsmO8qOFFW5S5ZldGt6IBQagy3+YjK51fTaQqTdccvm
	h9khsV5rlA2wdk2JEeEgbeTbYAnmlAaqYt0esFg9UO3P4nh8zv
X-Gm-Gg: ASbGncvAP3Ic5yBNLNYYmUN8v/aqWFewuNf0fDHAfp1sBljJWgeLLWMZuwTqe3uNc+r
	ri+yqSmeyPekauzyb2IU4kHOisXPYdnG32Q0toUtQ1L1Tsc1FVzrBaAUHsqbZG4v1kFD+lsqiX3
	Hvh+/dYXN9c3FwwYdpFDYgALg=
X-Received: by 2002:a05:690c:4c07:b0:719:a4af:9639 with SMTP id 00721157ae682-719b41e5d6bmr16296977b3.1.1753235791325;
        Tue, 22 Jul 2025 18:56:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX+meq5RdllZJEUDDChs2t+MqwYsVzxeUCToWQLKJOqrxv1moejmBeLFBifralajhOqWd7T8wS8R3/FMQe+x8=
X-Received: by 2002:a05:690c:4c07:b0:719:a4af:9639 with SMTP id
 00721157ae682-719b41e5d6bmr16296707b3.1.1753235790942; Tue, 22 Jul 2025
 18:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-3-npache@redhat.com>
 <d8474462-a90d-4b35-bfd2-dc1a641cc837@redhat.com>
In-Reply-To: <d8474462-a90d-4b35-bfd2-dc1a641cc837@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Tue, 22 Jul 2025 19:56:02 -0600
X-Gm-Features: Ac12FXzNvvEMEJLag32zFFcnAA1AC1qSrsNvmQqD4k4iA-iTmL3V73nObHmbLoY
Message-ID: <CAA1CXcANV_Y=ka74CYFP0pqPWVYH9S33VzjyDUQ6Nmq1na+QFA@mail.gmail.com>
Subject: Re: [PATCH v9 02/14] introduce collapse_single_pmd to unify
 khugepaged and madvise_collapse
To: David Hildenbrand <david@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qZdNsT2Q-JdVeipPUbdktubYTKwn1HeJieJ9l38LVtE_1753235791
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 9:54=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.07.25 02:31, Nico Pache wrote:
> > The khugepaged daemon and madvise_collapse have two different
> > implementations that do almost the same thing.
> >
> > Create collapse_single_pmd to increase code reuse and create an entry
> > point to these two users.
> >
> > Refactor madvise_collapse and collapse_scan_mm_slot to use the new
> > collapse_single_pmd function. This introduces a minor behavioral change
> > that is most likely an undiscovered bug. The current implementation of
> > khugepaged tests collapse_test_exit_or_disable before calling
> > collapse_pte_mapped_thp, but we weren't doing it in the madvise_collaps=
e
> > case. By unifying these two callers madvise_collapse now also performs
> > this check.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >   mm/khugepaged.c | 95 +++++++++++++++++++++++++-----------------------=
-
> >   1 file changed, 49 insertions(+), 46 deletions(-)
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index eb0babb51868..47a80638af97 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -2362,6 +2362,50 @@ static int collapse_scan_file(struct mm_struct *=
mm, unsigned long addr,
> >       return result;
> >   }
> >
> > +/*
> > + * Try to collapse a single PMD starting at a PMD aligned addr, and re=
turn
> > + * the results.
> > + */
> > +static int collapse_single_pmd(unsigned long addr,
> > +                                struct vm_area_struct *vma, bool *mmap=
_locked,
> > +                                struct collapse_control *cc)
>
> Nit: we tend to use two-tabs indent here.
Thanks I cleaned up these indentations!
>
> Nice cleanup!
>
> Acked-by: David Hildenbrand <david@redhat.com>
Much appreciated :)
>
> --
> Cheers,
>
> David / dhildenb
>

