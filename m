Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62CCF2D7387
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 23:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764198997; cv=none; b=BDRIr5fevfcvbWob5iDPDJzmIx0YA8YyfMYU/kYA48i5Vzh4XLRG0iFNMwO15sW1yPAEzdZT6ZKXSm2j51Ah2mxmBfM7gPYCVntodDOTOucTufWzR7uQmN9u9Z770E6JGHlq0XVaCM1dRKFsZEwREqyYXQ/CDk7K5M7luYCDF6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764198997; c=relaxed/simple;
	bh=H0Aa2h6XyKbyigaxWp5B58o4xxbWYArAZRPDLoYqXs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYAu4F2br1pmQIqRk2Uj0w4SBoFhsRpfjqgczJuAK1aaeeKnchkTZYem6YO+D3P6JvJB/vn+TBOHeWH0zGKmCvtr+jpFOoiYQjFWOUZHOeYCYj6H3LQDVC5CfdHksq/1PWlKdZVAGHCy+otKRpS5YacD7ddeoBkrXOqqd4SpHyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UxUmBwc0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UxUmBwc0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764198994;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UMaoF3gqsWu97KKNF9bqDelTF6faCcdLQyjuhlYWXM0=;
	b=UxUmBwc0scgZ3JuV3PmX7wpR+XjfoJAmri6ZH4RFu6U3tnAHN0q9zID03pVS6NTedMu7ay
	E+kPFUh36J+O96+csKmKz/VHhIo8ICHb8wfetnHDbSw6TYjz4S49/2MpI3THC9EzifeQ1X
	eRuPfvZsrk2s2yE0JRhtiK/FTjEtV0k=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-H9BEznzXMjiRXHZbXJq0AA-1; Wed, 26 Nov 2025 18:16:32 -0500
X-MC-Unique: H9BEznzXMjiRXHZbXJq0AA-1
X-Mimecast-MFC-AGG-ID: H9BEznzXMjiRXHZbXJq0AA_1764198992
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-63f9be79c1fso347424d50.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 15:16:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764198992; x=1764803792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UMaoF3gqsWu97KKNF9bqDelTF6faCcdLQyjuhlYWXM0=;
        b=NsK3EwKBmVETC/isQAJ8salWo10VLT9r6bWsH5gFmHah4Vipj4Pbhidk1ImRUp+dKz
         Lbp3HvRenMIrHnuCYKpxZjc2fP9hXsnrZrn7wc1E5AkbLKYeNXqU35hb5Us9OD2+hTKJ
         QUUDRKwrnWUOtN922/40Hi3XMbsiPwadH45idHUrqMqUrhNOAPjebxxbEpZne6RVMOCd
         wX9cqCWoWrrrMejPevFGgU3+HpI2by2pMC5f0jJrodZ3rpcV5oSTPfEotm1lwYxtrvlw
         pEjVc96iQNvRSxGYt/IN5JNbSLIba3FqrnrqY1YnbT+r8AtC6nDAsVj4jQIneyatR8c8
         csSg==
X-Forwarded-Encrypted: i=1; AJvYcCWVymE5nTAxEcVKjM5KSQHSYYAKt2GYQIIyGekMs4WfNwwUEnAKbwSXiGBGQ7fhfYYdKEoRDY39OOLSu9tKpVpcjZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDv3I6AZ6LktNdZ20Bh/I7WgDqfdJKMuIVNKqdCg1/wF+EEx65
	XARSNlTzCN4TmzNhz7mjdksuQ66fVscQAdHLDRPszGbbC7feYZLDUBd0+/d50GjXqwmuJvgPW96
	0klRCqAMguGTt8QiBU89eJO7S0iDABFi8KH9J/7PL8A85tDtka+wrwiOrClE1jRzGXfbfiCiMVK
	Keh7USY0VslRtp13qRHdMh4wsQzjwk4YkbCeeTPwNWOqCtJStA
X-Gm-Gg: ASbGncvs5cv1hkITyV/A+UuX6/iXBue/LucLZBG2kMn2Ejb7aQ6wHtf7nX1ZL0hJw3o
	BOk/QjY+H3RUPl3Jzl13BppfhTDbwHBJYyBinNDCd7kGoo3QFI1ftXpHePCrBJCNNRfmh+3nG/X
	zzPkK5Be9of3bWLGLGgN9n28Tqtp6dU95RCWBMpBFMRrRmBkaSfbcKex7jHMErihnLtFaezrPMc
	QoWBEy5
X-Received: by 2002:a05:690e:155b:10b0:640:d3ef:3ff3 with SMTP id 956f58d0204a3-64302a8eefemr13305169d50.15.1764198992149;
        Wed, 26 Nov 2025 15:16:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+QNGPicU5RjAdYvjG9xbNevC686kTjk8osJQTtyywrSV48lnib9InZNM3p9uysXVeTAEWqukeejzM9ZXOnQI=
X-Received: by 2002:a05:690e:155b:10b0:640:d3ef:3ff3 with SMTP id
 956f58d0204a3-64302a8eefemr13305111d50.15.1764198991685; Wed, 26 Nov 2025
 15:16:31 -0800 (PST)
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
Date: Wed, 26 Nov 2025 16:16:05 -0700
X-Gm-Features: AWmQ_blxvg-ak975oHQTjlFuUq6n3qiQLej596rC0gzOd4D75sF38pXcfAMCpNA
Message-ID: <CAA1CXcAhj3UKqjGLVCOwGmUY=eDJSnvMZO+byF9b6GJUR9gRiQ@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: at8mcGlVfamsVgLXbJkgSTjoh9nLAppuaTpFINEde-Q_1764198992
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

Ah yeah so it should just be try other "regions" or in this case we
want something like "try to collapse another mTHP candidate in the
stack"

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

ack

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
>
> > +                     /* Cases were lower orders might still succeed */
> > +                     case SCAN_LACK_REFERENCED_PAGE:
> > +                     case SCAN_EXCEED_NONE_PTE:
>
> How can we, having checked the max_pte_none, still fail due to this?

There are two phases in the khugepaged code, scan and collapse. in
between them is an alloc which requires dropping the lock, and
reconfirming values (in the collapse phase) after relocking.

During this time, the state of the PMD range might have changed and
our thresholds may have been exceeded.

This was true for PMD collapse and holds true for mTHP collapse too.

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

Ok sounds good, quick question, do we spell out ALL the enums or just
the ones that are reachable from here?

>
> > +                     default:
> > +                             break;
> >                       }
> > +                     break;
>
> _Hate_ this double break. Just return collapsed please.

ack, yeah that's much better. Thanks!

-- Nico

>
> >               }
> >
> >  next_order:
> > --
> > 2.51.0
> >
>

