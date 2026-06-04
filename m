Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED132B125
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Jun 2026 17:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780592640; cv=none; b=oyOaGxLNrfXqNn6TcYnyET1xHwlLEwAwhoYyrpTq6RzXVCMOOwGWk78LyQqWOhDSzg1T3xFHLK1TbNI1E+yIQ2dx20zXxgYUxboEid5Ks32wyXCNh5qyTFclPeVF2LNQjUaFjPEN0CWH1qaZPG6dmtre5DGOrVTvgLTvBuOUbbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780592640; c=relaxed/simple;
	bh=CS8LTr/ytbf5VzNbA+58AYmQySqtkVsv4R0NV1X3qU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qptRkgw08ltPGSRzEC4iRY9dYiCCbZD5J5nliFIlEDhLYCHRRXxsuUmB1Hxjmwm5rXR1X5zPT3CSmYR3k4rQDGuGnxZ0WpZBeC8KK5B0DsVEQBMmEIE7nM72giFj0lL7xWuONTo5CX8NTjEHg+G1PNTo/U0GIMwiK9XMaKN6FPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJo74AaG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJo74AaG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780592638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mFdbSvVLclwxYmscPcZ8kkZXJU9Ks9VowvahVknrrs4=;
	b=aJo74AaG0hhosVubQqfTX/O7KO32FNulTFA/yvf2OK324CfNqKsZvZlQVIa+fDCHSSWxhq
	lfVGw7SGvOdMpnL45RfkFDhLf9XR2uXaEwXuiwbr1c342EhC3BDJ+vktHTZZ/vG/qSsWmC
	LEVTPE21YziAZ0KXKsVjI2fTfJe7adM=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-xx5imM1pPF-z-Wnk3qyNUg-1; Thu, 04 Jun 2026 13:03:55 -0400
X-MC-Unique: xx5imM1pPF-z-Wnk3qyNUg-1
X-Mimecast-MFC-AGG-ID: xx5imM1pPF-z-Wnk3qyNUg_1780592635
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-66044a47d6fso1845737d50.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 04 Jun 2026 10:03:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780592635; x=1781197435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mFdbSvVLclwxYmscPcZ8kkZXJU9Ks9VowvahVknrrs4=;
        b=HC96dLw53wN5liFeMXQlRZAlvlYvMFWjyuuqvdA1V7IwVAAwpXMswxDJAw+J0DTCwx
         UZKzU9J4Khv7t3GGAHpTUNupyy571IHSX24Jg3uSS65fbkU24oqfOTWcCSd8Ewo04+0P
         cxCQNCdwKms6PI1p3FzwGYdQbWOZ+tqmeFjxeU5XKND3XjbZqJmR1c1cEzBZgGkqaxkp
         D0i/coi2qwChHoj+4oXZ8LUBDhv6eoq2Ijk4M5YMa4YItNCrG8a1iwImhk5AwO+/flct
         qbRA4nQIjM2LHeO2B9198WkgKXRdlpJjHNyT4V/l2uWUK2Xy0CDyxrYPfkkq1ukcmzCa
         OH8Q==
X-Forwarded-Encrypted: i=1; AFNElJ+VAiCMikZb54n8Ar6LSiOUfAYowuMMHX6bWD8gjutrEeg0EEp0Pf7cgBzZ9diPSVklBF70YglJ2UsClITNv9lcXmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyleladLW9k7pyVyfEqp72RkUegbvJF+mt7QgzNXuYv6nXluCAo
	UasRd7KZAFvbqWt5WFoN+P4vV6AS+NesFv30SUmIqZ1N6F5NQy8f+zJ+48Tzeee8dJ4LXynrQ3/
	Tc+8q1etWdGc14hEms7lFVALw1wu3DNWeC2Ji0qWSIIGbxWzKCo9jOBKealiOfFcwoIirFQeDvC
	cYOIYL3KpVKVYKiDkDEUBSv3QTe26i3omC6SXdYumiCELRk0bf
X-Gm-Gg: Acq92OGkCferGp3i8UgYzuiTSr3z2lwVwk0bJWUwe8Stjuy0zVXH5WB2ue7wd2L2v2U
	ghORWJQdcLGPklJ9xQo+MiMpiOpzMda3LJ0AMKkGRoa90XFYHJw6nE8vDYyd7wUWSr/8SLz+s5F
	0Wfvjvj5eQX0qEtHoU/71LXcbkjExbrJZUcWglmXSzgFaUCSnpGOEay4XDUKlnIkQHdfF44Xke3
	EPION/uOYUyhdk=
X-Received: by 2002:a53:d016:0:b0:660:689b:1539 with SMTP id 956f58d0204a3-660dc5af389mr7257840d50.58.1780592634564;
        Thu, 04 Jun 2026 10:03:54 -0700 (PDT)
X-Received: by 2002:a53:d016:0:b0:660:689b:1539 with SMTP id
 956f58d0204a3-660dc5af389mr7257769d50.58.1780592633890; Thu, 04 Jun 2026
 10:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2024af56-5e99-4799-a586-e9ba756cecb9@kernel.org>
 <20260601032804.96122-1-lance.yang@linux.dev> <f5d38f64-ab92-496d-afd3-29ccc17fec2b@kernel.org>
 <616de1a8-1cfd-40b8-b04f-7b324be40bfd@linux.dev> <6b11bf0a-769c-4ef2-ac6f-2af38200a6bc@kernel.org>
 <baa0a462-46e0-44ab-b583-c722ad253afe@linux.dev> <06d9b665-945f-4967-9ed9-b06514478996@kernel.org>
 <CAA1CXcAeEGOsqp-ywAQ7GMYQzXEeco-rUxUkk2hEF69HybC4=w@mail.gmail.com>
In-Reply-To: <CAA1CXcAeEGOsqp-ywAQ7GMYQzXEeco-rUxUkk2hEF69HybC4=w@mail.gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Thu, 4 Jun 2026 11:04:35 -0600
X-Gm-Features: AVHnY4I_L8TwfZPfpH2lQFz1V2RvpVRsRnPJ_VPp-rqHDi22wC_1Io6tlGI8brU
Message-ID: <CAA1CXcBSPVG4CJFCBDvbuodcJ_7eXoDQTpK0ZN0HEhkDPi-DEw@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 06/14] mm/khugepaged: generalize
 collapse_huge_page for mTHP collapse
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
	zokeefe@google.com, usama.arif@linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nuX0KfGOeLkDMABD7-PKI3cs30jQVgQAEn1xHGd5POU_1780592635
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 9:00=E2=80=AFAM Nico Pache <npache@redhat.com> wrote=
:
>
> On Mon, Jun 1, 2026 at 5:14=E2=80=AFAM David Hildenbrand (Arm) <david@ker=
nel.org> wrote:
> >
> > On 6/1/26 12:47, Lance Yang wrote:
> > >
> > >
> > > On 2026/6/1 18:23, David Hildenbrand (Arm) wrote:
> > >> On 6/1/26 11:08, Lance Yang wrote:
> > >>>
> > >>>
> > >>>
> > >>> One small thing, I think we should probably keep the smp_wmb(), and=
 just
> > >>> move it before the earlier pmd_populate().
> > >>>
> > >>> IIUC, the ordering we want is still:
> > >>>
> > >>>    clear old PTEs
> > >>>    smp_wmb()
> > >>>    pmd_populate()
> > >>>
> > >>> so another CPU cannot walk through the re-installed PMD and still o=
bserve
> > >>> the old PTEs, right?
> > >>
> > >> There is a smp_wmb() in __folio_mark_uptodate(), that should be suff=
icient?
> > >
> > > Ah, cool! __folio_mark_uptodate() already does the job :P
> > >
> > > So yeah, no extra smp_wmb() needed here!
> >
> > Yeah. BTW, I think we'd need a spin_lock_nested(), so @Nico, treat my c=
ode as a
> > draft.
>
> Okay, I read the above and did some investigating.
>
> I will try to implement and verify the changes you suggested :)

I've implemented something slightly different actually and I *think* its be=
tter!

} else {
       /* this is map_anon_folio_pte_nopf with no mmu update */
        __map_anon_folio_pte_nopf(folio, pte, vma, start_addr,
                      /*uffd_wp=3D*/ false);
       smp_wmb();
        pmd_populate(mm, pmd, pmd_pgtable(_pmd));
        /*
         * Some architectures (e.g. MIPS) walk the live page table in
         * their implementation. update_mmu_cache_range() must be called
         * with a valid page table hierarchy and the PTE lock held.
         * Acquire it nested inside pmd_ptl when they are distinct locks.
         */
        if (pte_ptl !=3D pmd_ptl)
            spin_lock_nested(pte_ptl, SINGLE_DEPTH_NESTING);
        update_mmu_cache_range(NULL, vma, start_addr, pte, nr_pages);
        if (pte_ptl !=3D pmd_ptl)
            spin_unlock(pte_ptl);
    }
spin_unlock(pmd_ptl);

The logic here is that when the PMD becomes visible, PTEs are already
populated (no possibility of spurious faults on local CPU)

the SMP_WMB makes sure of the above

And the pmd is installed with the pte and pmd lock both held through
the mmu_cache update.

This follows the conventions used in pmd_install() and clears the
potential for local CPU faults hitting cleared PTE entries.

I think both approaches are correct but this prevents any possibility
of my first point. although mmap_write_lock prevents this too.

Let me know what you think. I can revert to your implementation but
this is what I tested.

Cheers,
-- Nico

>
> Or an even crazier idea... what if we ensure MIPS checks for PMD_none
> before walking a PTE table?
>
> -- Nico
>
> >
> > --
> > Cheers,
> >
> > David
> >

