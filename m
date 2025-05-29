Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB610785
	for <linux-trace-kernel@vger.kernel.org>; Thu, 29 May 2025 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748491379; cv=none; b=dzhJ54su9QI0+qECdoe8tOv+B7Hoc7im16Z0vJ+baxRV32ELTL2ub2LfmI8793EnTebZ3O4EOe5G9t6dIJK0Ozd/gH0B9QZ+KDz/9RoeuShBmU0NeqiqxddRXWw5bZWJkRP168d6WzpUf/8kmCvY6ETZGlMo3+dkN8AQor6HHIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748491379; c=relaxed/simple;
	bh=zhm2iJuKj8i0RfMXE3b2NN5iB3OT/qdLHRZamrHUNLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X0LKyYfzyxgZ+oeiUJn4x1NR9YaLFN8YNLEGGgh9JZvGL47ggHbztJIEMkTG2mXTCTlDBRevB37AsDPQltkVmyL1JL4iJ2ZPoqlFBzC1T77DCADN5KPailSCctZa92CxRNA/jS/3DU6L7lGGtBQs+bP7xWMn3Q7CHLev41KO8JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i6kCMFtt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6kCMFtt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748491376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zhm2iJuKj8i0RfMXE3b2NN5iB3OT/qdLHRZamrHUNLk=;
	b=i6kCMFtt/CTgmexa4r1atwX6FBS+Fx8SQoHl6JLfpKk+6tVEEcdpJ+Nv206BepiP6OAZQK
	F4A2xxsyBcqvyWy2pJ1jKGrJX3ok3FKrFxZaPKTPEsRq0n7R8AYpYyHbjzKhaI7VeFWTfL
	OEHkm3VybT/8ywOISIM+sGJTedpAUpM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-Hw7vm_48PaiihRIBczZCAQ-1; Thu, 29 May 2025 00:02:52 -0400
X-MC-Unique: Hw7vm_48PaiihRIBczZCAQ-1
X-Mimecast-MFC-AGG-ID: Hw7vm_48PaiihRIBczZCAQ_1748491372
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70e2d495194so7774487b3.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 May 2025 21:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748491372; x=1749096172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zhm2iJuKj8i0RfMXE3b2NN5iB3OT/qdLHRZamrHUNLk=;
        b=wtCiVK5T8X9NjAt/99HGn9KE25I8tBUL/+onGfWVKdRQ0HmHn+VtnRe1PEFgmsAQUK
         qoFzIlqgTrRm0cdW0/XMAdZY25v/rvDck5Xi5PEkJEMquDUk8eWqswAhkYie/eisQQaP
         HKzZkurtq+Rvx4v94+tyuhduwVg7io+rOe76bOYpPs4Bsp6k20r6xvhJtdjG+0aV5CMP
         Xa5bBMJAiXFEy3vvC6dhbXEiFW3MBvqnuOmillf6iSJ4kg551nxGwEsnQbRwR37aOv4m
         Ro7P6RP6l9EXvGO9Nucr5S1qFfL9V6Iiv+Mvn2R29ue3qQveG+ztAVw+GPMZl1DuwFj8
         W4JA==
X-Forwarded-Encrypted: i=1; AJvYcCUtDDOdaLo36RW7JXTjv0Zm4zUq3v2wCoD2sVCgRVLUpUc/7TOg1IObZCT14YWaonon79A9fdyarGqFwX5f2fsuXeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy11RZWxo21exBIVlJToxFUJiKv76i1ie1BvhI80ZiLRVmG6SpQ
	RnTLXZ8ripZsuFxEXuWrTc6daQrZKk0MNowHAXg7FHvKlMe77IGZHUjOGifR/QSkrmRc4u48QRW
	1iHhe0sXsescCnXIpm9EKzZGJdugBLpCtPeNUO5ymsK9V7YlnQcM45Synn2sSsL82lblASqc/6h
	Dc4yO/28tyKjRlSkyrzpL7nXU3sonhUnEfvwhm5u6/QJzeCj/2
X-Gm-Gg: ASbGncsJzZV68Hhq07J662KhywYLhaBk/e8gxTIfRooInXeOml90BIBgrJn9MgM8xSp
	SQy+KOzyqLfSFRveOi/4WgQcEl1NIIun2++ftvVyL++KtQ1LH2UbIFG89eIVAq6tZqOBzDZc=
X-Received: by 2002:a05:690c:6e0a:b0:70c:b534:86b0 with SMTP id 00721157ae682-70f8b50bbabmr12814787b3.13.1748491372148;
        Wed, 28 May 2025 21:02:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwGJlK5MRnqhABRt1qihn9KAqIhm+LuBFcmX9h1Q1HwUofuAQIUVYJZCzpdmN/TvwDMjnTcYLYCFc1ZuD3UH8=
X-Received: by 2002:a05:690c:6e0a:b0:70c:b534:86b0 with SMTP id
 00721157ae682-70f8b50bbabmr12814387b3.13.1748491371794; Wed, 28 May 2025
 21:02:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515032226.128900-1-npache@redhat.com> <20250515032226.128900-7-npache@redhat.com>
 <9c54397f-3cbf-4fa2-bf69-ba89613d355f@linux.alibaba.com> <CAA1CXcC9MB2Nw4MmGajESfH8DhAsh4QvTj4ABG3+Rg2iPi087w@mail.gmail.com>
 <ed1d1281-ece3-4d2c-8e58-aaeb436d3927@linux.alibaba.com> <CAA1CXcAWcahkxzsvK_bcWei6or_gKBjt+97dqhuSem8N7cBAQw@mail.gmail.com>
 <1f00fdc3-a3a3-464b-8565-4c1b23d34f8d@linux.alibaba.com> <cf33ff99-ac97-4a33-9df0-01a59d5b8424@redhat.com>
 <e800189d-ad3d-409d-bfba-2c32a6ac66c0@linux.alibaba.com>
In-Reply-To: <e800189d-ad3d-409d-bfba-2c32a6ac66c0@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 28 May 2025 22:02:25 -0600
X-Gm-Features: AX0GCFumAmWLWAjszDpXEY6ePKI2IHSQqMTz5Qce_OEN6FILJEIdGvUcXeg58kI
Message-ID: <CAA1CXcAAbPXTHvBoSW5uxo5uH4NnQompMSsE-xG+VHGJhhiCew@mail.gmail.com>
Subject: Re: [PATCH v7 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: David Hildenbrand <david@redhat.com>, David Rientjes <rientjes@google.com>, zokeefe@google.com, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, corbet@lwn.net, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, akpm@linux-foundation.org, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, hannes@cmpxchg.org, mhocko@suse.com, 
	rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6GTWVtt2gn3pQJCcBMe8qLUvgVVwwUMucQzbsMgS5E4_1748491372
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 8:04=E2=80=AFAM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/5/28 17:26, David Hildenbrand wrote:
> > On 22.05.25 11:39, Baolin Wang wrote:
> >>
> >>
> >> On 2025/5/21 18:23, Nico Pache wrote:
> >>> On Tue, May 20, 2025 at 4:09=E2=80=AFAM Baolin Wang
> >>> <baolin.wang@linux.alibaba.com> wrote:
> >>>>
> >>>> Sorry for late reply.
> >>>>
> >>>> On 2025/5/17 14:47, Nico Pache wrote:
> >>>>> On Thu, May 15, 2025 at 9:20=E2=80=AFPM Baolin Wang
> >>>>> <baolin.wang@linux.alibaba.com> wrote:
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> On 2025/5/15 11:22, Nico Pache wrote:
> >>>>>>> khugepaged scans anons PMD ranges for potential collapse to a
> >>>>>>> hugepage.
> >>>>>>> To add mTHP support we use this scan to instead record chunks of
> >>>>>>> utilized
> >>>>>>> sections of the PMD.
> >>>>>>>
> >>>>>>> khugepaged_scan_bitmap uses a stack struct to recursively scan a
> >>>>>>> bitmap
> >>>>>>> that represents chunks of utilized regions. We can then determine
> >>>>>>> what
> >>>>>>> mTHP size fits best and in the following patch, we set this
> >>>>>>> bitmap while
> >>>>>>> scanning the anon PMD. A minimum collapse order of 2 is used as
> >>>>>>> this is
> >>>>>>> the lowest order supported by anon memory.
> >>>>>>>
> >>>>>>> max_ptes_none is used as a scale to determine how "full" an order
> >>>>>>> must
> >>>>>>> be before being considered for collapse.
> >>>>>>>
> >>>>>>> When attempting to collapse an order that has its order set to
> >>>>>>> "always"
> >>>>>>> lets always collapse to that order in a greedy manner without
> >>>>>>> considering the number of bits set.
> >>>>>>>
> >>>>>>> Signed-off-by: Nico Pache <npache@redhat.com>
> >>>>>>
> >>>>>> Sigh. You still haven't addressed or explained the issues I
> >>>>>> previously
> >>>>>> raised [1], so I don't know how to review this patch again...
> >>>>> Can you still reproduce this issue?
> >>>>
> >>>> Yes, I can still reproduce this issue with today's (5/20) mm-new
> >>>> branch.
> >>>>
> >>>> I've disabled PMD-sized THP in my system:
> >>>> [root]# cat /sys/kernel/mm/transparent_hugepage/enabled
> >>>> always madvise [never]
> >>>> [root]# cat
> >>>> /sys/kernel/mm/transparent_hugepage/hugepages-2048kB/enabled
> >>>> always inherit madvise [never]
> >>>>
> >>>> And I tried calling madvise() with MADV_COLLAPSE for anonymous memor=
y,
> >>>> and I can still see it collapsing to a PMD-sized THP.
> >>> Hi Baolin ! Thank you for your reply and willingness to test again :)
> >>>
> >>> I didn't realize we were talking about madvise collapse-- this makes
> >>> sense now. I also figured out why I could "reproduce" it before. My
> >>> script was always enabling the THP settings in two places, and I only
> >>> commented out one to test this. But this time I was doing more manual
> >>> testing.
> >>>
> >>> The original design of madvise_collapse ignores the sysfs and
> >>> collapses even if you have an order disabled. I believe this behavior
> >>> is wrong, but by design. I spent some time playing around with madvis=
e
> >>> collapses with and w/o my changes. This is not a new thing, I
> >>> reproduced the issue in 6.11 (Fedora 41), and I think its been
> >>> possible since the inception of madvise collapse 3 years ago. I
> >>> noticed a similar behavior on one of my RFC since it was "breaking"
> >>> selftests, and the fix was to reincorporate this broken sysfs
> >>> behavior.
> >>
> >> OK. Thanks for the explanation.
> >>
> >>> 7d8faaf15545 ("mm/madvise: introduce MADV_COLLAPSE sync hugepage
> >>> collapse")
> >>> "This call is independent of the system-wide THP sysfs settings, but
> >>> will fail for memory marked VM_NOHUGEPAGE."
> >>>
> >>> The second condition holds true (and fails for VM_NOHUGEPAGE), but I
> >>> dont know if we actually want madvise_collapse to be independent of
> >>> the system-wide.
> >>
> >> This design principle surprised me a bit, and I failed to find the
> >> reason in the commit log. I agree that "never should mean never," and =
we
> >> should respect the THP/mTHP sysfs setting. Additionally, for the
> >> 'shmem_enabled' sysfs interface controlled for shmem/tmpfs, THP collap=
se
> >> can still be prohibited through the 'deny' configuration. The rules he=
re
> >> are somewhat confusing.
> >
> > I recall that we decided to overwrite "VM_NOHUGEPAGE", because the
> > assumption is that the same app that triggered MADV_NOHUGEPAGE triggers
> > the collapse. So the app decides on its own behavior.
> >
> > Similarly, allowing for collapsing in a VM without VM_HUGEPAGE in the
> > "madvise" mode would be fine.
> >
> > But in the "never" case, we should just "never" collapse.
>
> OK. Let's fix the "never" case first. Thanks.
Great, I will update that in the next version!
>

