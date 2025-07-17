Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DCE21A447
	for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736975; cv=none; b=U1mYwrp8Nl/ubw1M+8S9oKJ++6hV2o9qbQhmMUCfcU+t4wFdFbIHp8rN28+9zspQ5umvLjL0f0Yc6qfX53POa/cidMu/GT8b7mczsuzZ6AizcB0Q3D/bIiGPplOq9ZJAm19UBODXS3vKXkCViIDr9X2LoSnEdSmcuM2We1lybkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736975; c=relaxed/simple;
	bh=z9j/kRp2E8OBtyHpf3bE3Bgh0h7FB7kKCT1IIylTnNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DWAe9j7ZDaZnNmDgzYODfOUQ6CM1Hh//q7IMo0H9OPzjQMVOiQU+ruPKlfFBHZgakmN3wBMKRktFMFDlwTgqCQqMb1cgZElS9/ZtqNFWFK3gl4cgt0KLeG3U0WcZwmZygZyJiL21vkwcwbEwqCCYqFsblKhzIdVyvvhgpsscebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fNGXiXW2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fNGXiXW2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752736972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JFbE7+bxkztH8ht0A9j4wnG3HbzAi42oef01y44iq/o=;
	b=fNGXiXW2wGSrttvSWaAPoZiYG9SV1oKczlwOQPqnyBerpRGiG8VcdTPE3R6lvMoXt98Xzp
	DFEd1morXDUf+dyvk5RGmzjRB+rsjE5aA7UZunPIoL5OIb5G5suV1t5RpVJm+8OPaCEtWV
	Tp0MkHpOJaYLXQwcHWFvqnV2yvw8Eb0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-rBNb5ILBMSyVd0meZUh17A-1; Thu, 17 Jul 2025 03:22:51 -0400
X-MC-Unique: rBNb5ILBMSyVd0meZUh17A-1
X-Mimecast-MFC-AGG-ID: rBNb5ILBMSyVd0meZUh17A_1752736970
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7111ff9c057so9050687b3.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 17 Jul 2025 00:22:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752736970; x=1753341770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JFbE7+bxkztH8ht0A9j4wnG3HbzAi42oef01y44iq/o=;
        b=w00q2YCOtzSDBaYxM8449qZ2UJuOo3tLmp7aCt4j9wU1MAsrKzBA0VKt9RBHtVvwYf
         rYn0q9iVU+IeDw+EDTKrSCpQ+tkpOVCSbrpzxBcxLAqDiVR22UfMitLlcQim2Q/R0zLv
         Sd86u/1Nhs7Zlkg9izZdCXtfkiYaJ4RLKi7U9H6v1O4hBJ0U+u1GENGnSGyO88qZ/tXb
         8orHpfZwP03O8cKe6DT/wSSPC1UgMxLxl5FxQWT0odZH5neeydvy2g+WfKC1SHGFb2Dw
         fzAftUyviqsiFovw71+LdNP13I1Zn8r3mVvvwBxjupfmbptXYRXoEIqxTpKbi7DjYF+s
         WG/w==
X-Forwarded-Encrypted: i=1; AJvYcCXAGmpYI0BX20Ft+Hul22BS0/jWw4yFmprWXmYf/0FbmuG9OScLb6BlBS3wE05wq4RzToEI0/V3Y2sT6lVf3akYXS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+5AAFwXB66hRNGy5ZiEShmznMfGJ5x8qSk8ekF25PFemRTVUe
	tBLN/i6NYLHeG+6QkmJTdUN+rrKb4IDaDckQlOVLdp1U/JRt8cfc1Et+j6BxkxpgNWVFOmcDFRq
	9QcB7RqfwyqzLRYb4CiIgciPOpUxEvP/YK3pBs1i9g0kx8VEXYrE6CVtzj/ERbLPCc3+K/kKz5A
	1qn3yW7A0dJ1zquHL4cXhKiLxQ2c2qcbObGkIV3YS1cyDURA0E
X-Gm-Gg: ASbGncvpc4zi4hG/hW/eilrygeGsIFmzDWE9r9eDso4KJtfQ1R7Ase5JM/Ho0UkZm46
	omGyFqsM8WLqpMKeMQDdcquy9txHtZQw5KKHPXPIPVFcyL7mSEBUXoGrwc94qgF50TX3U+D10Xy
	Y29ehUIwBD7HIWMRkkBTvetxE=
X-Received: by 2002:a05:690c:350d:b0:718:2154:62df with SMTP id 00721157ae682-71837469c95mr83297757b3.35.1752736970283;
        Thu, 17 Jul 2025 00:22:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTEQOqXObebRqrlKJLemLbpJQWqKxX4FiFWdy7vlPZ029cLEq4+lOCKX4kkTmc9Zh7ynQj/lyoUlwrfL87Fyg=
X-Received: by 2002:a05:690c:350d:b0:718:2154:62df with SMTP id
 00721157ae682-71837469c95mr83295897b3.35.1752736967211; Thu, 17 Jul 2025
 00:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714003207.113275-1-npache@redhat.com> <20250714003207.113275-5-npache@redhat.com>
 <a337c251-c152-4f57-8ead-6e4419e49f0c@redhat.com>
In-Reply-To: <a337c251-c152-4f57-8ead-6e4419e49f0c@redhat.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 17 Jul 2025 01:22:21 -0600
X-Gm-Features: Ac12FXzL2cbWnmcpfj5Yy4cS_OOfF-n9brr7FXMARu3knPEuWSWCEGWa47WO3XM
Message-ID: <CAA1CXcDmoJqt7BAnQv=AcJatZ9cvSL-=zuEppLBpYJE_rMNDdQ@mail.gmail.com>
Subject: Re: [PATCH v9 04/14] khugepaged: generalize alloc_charge_folio()
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
X-Mimecast-MFC-PROC-ID: aQzVfaVrPsiI21UP7R8EEF_df2qr9yPSaoHTkXqg5dU_1752736970
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 7:46=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> On 14.07.25 02:31, Nico Pache wrote:
> > From: Dev Jain <dev.jain@arm.com>
> >
> > Pass order to alloc_charge_folio() and update mTHP statistics.
> >
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Co-developed-by: Nico Pache <npache@redhat.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > ---
> >   Documentation/admin-guide/mm/transhuge.rst |  8 ++++++++
> >   include/linux/huge_mm.h                    |  2 ++
> >   mm/huge_memory.c                           |  4 ++++
> >   mm/khugepaged.c                            | 17 +++++++++++------
> >   4 files changed, 25 insertions(+), 6 deletions(-)
> >
> > diff --git a/Documentation/admin-guide/mm/transhuge.rst b/Documentation=
/admin-guide/mm/transhuge.rst
> > index dff8d5985f0f..2c523dce6bc7 100644
> > --- a/Documentation/admin-guide/mm/transhuge.rst
> > +++ b/Documentation/admin-guide/mm/transhuge.rst
> > @@ -583,6 +583,14 @@ anon_fault_fallback_charge
> >       instead falls back to using huge pages with lower orders or
> >       small pages even though the allocation was successful.
> >
> > +collapse_alloc
> > +     is incremented every time a huge page is successfully allocated f=
or a
> > +     khugepaged collapse.
> > +
> > +collapse_alloc_failed
> > +     is incremented every time a huge page allocation fails during a
> > +     khugepaged collapse.
> > +
> >   zswpout
> >       is incremented every time a huge page is swapped out to zswap in =
one
> >       piece without splitting.
> > diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> > index 7748489fde1b..4042078e8cc9 100644
> > --- a/include/linux/huge_mm.h
> > +++ b/include/linux/huge_mm.h
> > @@ -125,6 +125,8 @@ enum mthp_stat_item {
> >       MTHP_STAT_ANON_FAULT_ALLOC,
> >       MTHP_STAT_ANON_FAULT_FALLBACK,
> >       MTHP_STAT_ANON_FAULT_FALLBACK_CHARGE,
> > +     MTHP_STAT_COLLAPSE_ALLOC,
> > +     MTHP_STAT_COLLAPSE_ALLOC_FAILED,
> >       MTHP_STAT_ZSWPOUT,
> >       MTHP_STAT_SWPIN,
> >       MTHP_STAT_SWPIN_FALLBACK,
> > diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> > index bd7a623d7ef8..e2ed9493df77 100644
> > --- a/mm/huge_memory.c
> > +++ b/mm/huge_memory.c
> > @@ -614,6 +614,8 @@ static struct kobj_attribute _name##_attr =3D __ATT=
R_RO(_name)
> >   DEFINE_MTHP_STAT_ATTR(anon_fault_alloc, MTHP_STAT_ANON_FAULT_ALLOC);
> >   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback, MTHP_STAT_ANON_FAULT_FALLB=
ACK);
> >   DEFINE_MTHP_STAT_ATTR(anon_fault_fallback_charge, MTHP_STAT_ANON_FAUL=
T_FALLBACK_CHARGE);
> > +DEFINE_MTHP_STAT_ATTR(collapse_alloc, MTHP_STAT_COLLAPSE_ALLOC);
> > +DEFINE_MTHP_STAT_ATTR(collapse_alloc_failed, MTHP_STAT_COLLAPSE_ALLOC_=
FAILED);
> >   DEFINE_MTHP_STAT_ATTR(zswpout, MTHP_STAT_ZSWPOUT);
> >   DEFINE_MTHP_STAT_ATTR(swpin, MTHP_STAT_SWPIN);
> >   DEFINE_MTHP_STAT_ATTR(swpin_fallback, MTHP_STAT_SWPIN_FALLBACK);
> > @@ -679,6 +681,8 @@ static struct attribute *any_stats_attrs[] =3D {
> >   #endif
> >       &split_attr.attr,
> >       &split_failed_attr.attr,
> > +     &collapse_alloc_attr.attr,
> > +     &collapse_alloc_failed_attr.attr,
> >       NULL,
> >   };
> >
> > diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> > index fa0642e66790..cc9a35185604 100644
> > --- a/mm/khugepaged.c
> > +++ b/mm/khugepaged.c
> > @@ -1068,21 +1068,26 @@ static int __collapse_huge_page_swapin(struct m=
m_struct *mm,
> >   }
> >
> >   static int alloc_charge_folio(struct folio **foliop, struct mm_struct=
 *mm,
> > -                           struct collapse_control *cc)
> > +                           struct collapse_control *cc, u8 order)
>
> u8, really? :)
At the time I knew I was going to use u8's at the bitmap level so I
thought I should have them here too. But you are right I went through
and cleaned up all the u8 usage with the exception of the actual
bitmap storage.
>
> Just use an "unsigned int" like folio_order() would or what
> __folio_alloc() consumes.
>
>
>
> Apart from that
>
> Acked-by: David Hildenbrand <david@redhat.com>
Thank you!

>
> --
> Cheers,
>
> David / dhildenb
>

