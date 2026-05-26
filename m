Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326153D88EB
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779797230; cv=none; b=ZVLycsWuaYGtcwzkCqz/3BVw4+QhQaGgiaoLU9PWL3WwhjxniN/k7kPOtb8iZvk6TxxsHKezhOuLwYTBs6vkX8pYBDYvr+EDm0so/5JUnUvVYWqd0d9Fd7B9V2A89y41bY+QqReSTrVWTBRWn5G7DusWzISPoH8pH5pH5vqW8ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779797230; c=relaxed/simple;
	bh=gjn7irxVASWEua9zhhchtRuYD5Juo9ZV38SI3YWleII=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ma+IUUGO5AUGmCBeK8RN/tpu8x0eg0SbmGH0vLVB39oQQifbtbBRQhsWnSj7EcegDIEGjqPvLHRSFZrAuzI37ji9AG6PxYrSsBQ4ZTVH7hFY5yNpeqFDuwvMQeGKbncn0c89qI4rJsFpmzR3hr527XBYPI6NiudOuuSwEDR2hB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P6d6aPgJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P6d6aPgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779797228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eiAFrFRbjd4+RPbTvUUvKWoOw3SyaKiqWrxbSKz7lDc=;
	b=P6d6aPgJXk5W1VpFIWLv5EeTBvzfif34gjvBG/ucDFXvIerkdmPetq3FGIvS/e+nsAkYaM
	7xRdCIkbOC1rdFkzSx9WsXcrthiPl+d6wnOt6pUslhQ58Reuz2Yk/oJ3wpv7aZjiGDjRrP
	bYmWF6JVGs89cfTxL+yhwrFuHIOuzS8=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-380-mr3bIT1yPi64M0W40nPyRg-1; Tue, 26 May 2026 08:07:06 -0400
X-MC-Unique: mr3bIT1yPi64M0W40nPyRg-1
X-Mimecast-MFC-AGG-ID: mr3bIT1yPi64M0W40nPyRg_1779797226
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65d8d110fe4so19553436d50.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 05:07:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779797226; x=1780402026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eiAFrFRbjd4+RPbTvUUvKWoOw3SyaKiqWrxbSKz7lDc=;
        b=I5EU69L5KfS0R1qgf0Xxuo2GykCZ0XFbWx31dPpK/Ng0wc71uPbnjnGkOMCzdEwlbd
         pXB0MMrztpabxjwbowcPq+x+AF1bST4kudpGX2hgDS8HfvdcJ+ynAulDOgdAgprkcjMm
         SH84njZYp9Hl/Qe+yBSee5AoSum4YhBo3flhAe8RmJO/6nPtJx5qcXk+k1dqZuZ1a7Cp
         2HbnRznRDMxSqRnxAPxdizckrXJ+Ww3t7SmIQtpZ1r0tVtLJsIksKKDpJxGAjdVbY5uX
         r/L0bEhwUVZju23g0HmrkBkTDO9SBsstlH2HPuFEIAhi0jB7LFNpWypezaBmesX55l1z
         S9mg==
X-Forwarded-Encrypted: i=1; AFNElJ9VLYaWEbsBnmYp7TckVygm9vPuF6GoXvZu7UltwC2EwJfuGRmybHOGZO65joigYVODrtwCxNhBjWqcJRdIH++sjcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxihKU7+B9O4/Q51a3gAZ0lfh0FF8CQm4wKj2YR3MKvaRLega2
	xrFyUv/1SyuMaS228on8Aev0URwU01NH4GkirvKDXPcwmNpe4xxu1EEvOp22jNfxOWV+pceIq+a
	VjJCJvCJOm4wLkjT5fJPfeRfeHZ4y6EHWDXO1IBJJApk+YbaKVWVDIDY3Y6xAvGeZYfnrox1yu8
	7WMmmA2aleDrjpyr/d0fItzhKSXC2zjkvcE8XUeA/0Xemwaw2o
X-Gm-Gg: Acq92OES9s75pKx4rA/se94mioX2GYfDNU4FWjtusfycTvZ6iWg+Qr8vU1t0w0+2uah
	WxFiN7jG6rJXR6n5Koy32S6kTMd+dWb96IYj2Tz1di6aRtlOHsSYF0LFtmTSQ4XT2G0a9vATQcn
	I/eMzDRnVjtxq9iMjQWH7oZhSLTV5Sd+lUWB+BR8gcbmPNkk5CtbXW1MMBl3ooN4Y5twshTOicY
	gVlEtpSCflm7xPx
X-Received: by 2002:a53:ac94:0:b0:65c:4a37:3975 with SMTP id 956f58d0204a3-65eac8ffbe6mr17560450d50.0.1779797225567;
        Tue, 26 May 2026 05:07:05 -0700 (PDT)
X-Received: by 2002:a53:ac94:0:b0:65c:4a37:3975 with SMTP id
 956f58d0204a3-65eac8ffbe6mr17560402d50.0.1779797225094; Tue, 26 May 2026
 05:07:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <20260522150009.121603-12-npache@redhat.com>
 <2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redhat.com> <20260525121041.2f2508a4f627c338cddd837a@linux-foundation.org>
 <20260526065708.oyyddmt2zgfwu2q7@master>
In-Reply-To: <20260526065708.oyyddmt2zgfwu2q7@master>
From: Nico Pache <npache@redhat.com>
Date: Tue, 26 May 2026 06:07:38 -0600
X-Gm-Features: AVHnY4JcK8OmA0BDu7BZOR--WqtBBKWM2GWs1qml7WVs0MOjDwCnB55pWKWIb9o
Message-ID: <CAA1CXcDXyDhMyiVAb8XbusqMU10JXA8nOUw6b4_2i9H-kV2vwQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	anshuman.khandual@arm.com, apopple@nvidia.com, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, byungchul@sk.com, catalin.marinas@arm.com, 
	cl@gentwo.org, corbet@lwn.net, dave.hansen@linux.intel.com, david@kernel.org, 
	dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, 
	jack@suse.cz, jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, lance.yang@linux.dev, 
	liam@infradead.org, ljs@kernel.org, mathieu.desnoyers@efficios.com, 
	matthew.brost@intel.com, mhiramat@kernel.org, mhocko@suse.com, 
	peterx@redhat.com, pfalcato@suse.de, rakie.kim@sk.com, raquini@redhat.com, 
	rdunlap@infradead.org, rientjes@google.com, rostedt@goodmis.org, 
	rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vENAyFGCbPDWq7Ih4EfYCKpq0Kc5QA2xt4dxwnQa2sw_1779797226
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 12:57=E2=80=AFAM Wei Yang <richard.weiyang@gmail.co=
m> wrote:
>
> On Mon, May 25, 2026 at 12:10:41PM -0700, Andrew Morton wrote:
> >On Mon, 25 May 2026 08:15:53 -0600 Nico Pache <npache@redhat.com> wrote:
> >
> >> Can you please append the following fixup that reverts one of the
> >> changes requested in V17. The issue with the change is described
> >> below.
> >
> >OK.  fyi, what I received was badly mangled: wordwrapping, tabs messed
> >up, etc.
> >
> >Here's my reconstruction:
> >
>
> Hi, Nico
>
> I tried to reply your mail, but found it has some encoding problem, so re=
ply
> here.

Yeah sorry I didnt properly configure my email client after getting a
new laptop.

>
> >
> >Author: Nico Pache <npache@redhat.com>
> >Subject: fix potential use-after-free of vma in mthp_collapse()
> >Date: Mon May 25 07:38:59 2026 -0600
> >
> >Between V17 and v18, one reviewer (Wei) brought up that we are not doing
> >the uffd-armed check until deep in the collapse operation.  While not
> >functionally incorrect, it can lead to unnecessary work.
>
> So we decide to tolerate the behavioral change?

Yes, I believe it is ok for now. Either way we needed to remove the
potential UAF. It only affects the behavior if mTHP is enabled, so the
legacy behavior is kept. And the uffd case is limited.

My future work involves further optimizing and cleaning up khugepaged.
I'll make this part of the goal too. My first thought is to do the
revalidation at every order (between the locks dropping); but that
essentially pays the same penalty... I can't think of a clean solution
at the moment.

Does that sound ok?

Cheers,
-- Nico


-- Nico

>
> >
> >We optimized this by passing the vma variable to mthp_collapse() and usi=
ng
> >the collapse_max_ptes_none() function to check the state of uffd-armed
> >preventing the wasted work later in the collapse.
> >
> >mthp_collapse() is called after mmap_read_unlock(), so the vma pointer c=
an
> >become stale.  Remove the vma parameter and pass NULL to
> >collapse_max_ptes_none() instead.
> >
> >Link: https://lore.kernel.org/2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redha=
t.com
> >Signed-off-by: Nico Pache <npache@redhat.com>
> >...
> >
> > mm/khugepaged.c |   10 +++++-----
> > 1 file changed, 5 insertions(+), 5 deletions(-)
> >
> >--- a/mm/khugepaged.c~mm-khugepaged-introduce-mthp-collapse-support-fix
> >+++ a/mm/khugepaged.c
> >@@ -1502,9 +1502,9 @@ static unsigned int collapse_mthp_count_
> >  * If a collapse is permitted, we attempt to collapse the PTE range int=
o a
> >  * mTHP.
> >  */
> >-static int mthp_collapse(struct mm_struct *mm, struct vm_area_struct *v=
ma,
> >-              unsigned long address, int referenced, int unmapped,
> >-              struct collapse_control *cc, unsigned long enabled_orders=
)
> >+static int mthp_collapse(struct mm_struct *mm, unsigned long address,
> >+              int referenced, int unmapped, struct collapse_control *cc=
,
> >+              unsigned long enabled_orders)
> > {
> >       unsigned int nr_occupied_ptes, nr_ptes, max_ptes_none;
> >       int collapsed =3D 0, stack_size =3D 0;
> >@@ -1524,7 +1524,7 @@ static int mthp_collapse(struct mm_struc
> >               if (!test_bit(order, &enabled_orders))
> >                       goto next_order;
> >
> >-              max_ptes_none =3D collapse_max_ptes_none(cc, vma, order);
> >+              max_ptes_none =3D collapse_max_ptes_none(cc, NULL, order)=
;
> >
> >               nr_occupied_ptes =3D collapse_mthp_count_present(cc, offs=
et,
> >                                                              nr_ptes);
> >@@ -1749,7 +1749,7 @@ out_unmap:
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               /* collapse_huge_page expects the lock to be dropped befo=
re calling */
> >               mmap_read_unlock(mm);
> >-              nr_collapsed =3D mthp_collapse(mm, vma, start_addr, refer=
enced,
> >+              nr_collapsed =3D mthp_collapse(mm, start_addr, referenced=
,
> >                                            unmapped, cc, enabled_orders=
);
> >               /* mmap_lock was released above, set lock_dropped */
> >               *lock_dropped =3D true;
> >_
>
> --
> Wei Yang
> Help you, Help me
>

