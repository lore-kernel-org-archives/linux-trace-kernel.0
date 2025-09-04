Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BF1134A8
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Sep 2025 02:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756954512; cv=none; b=MMwx0XDXA+OQADMksArn9e8wkVjTqoHWAml6BiVRLMV8lhCQuXIOcX4gFR2CR5DHWYyjs8T5t54xDnnLULb46s00K3kWqrwuCn76WC9Qxz4hF7yVzT2LYOzKVKv6jJRisTpbLAG6stcBhsC9/vF1vylHms6Kwp2QvsisLbNZDj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756954512; c=relaxed/simple;
	bh=5V8+/iKwtE1SllUjDf6n6GzwfOQoBg1OAcIqkoOZ71A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jo8dv3bgN7CSNlbqgzuZ3+0jvknTc/ijIDwxyyZ3Ev9VPbB8d9O4ckJinIOXNlN59met7aSFl/XuAB8px3S6G6IUeV2AwL/bcnIDy6NTkWJDjGdpfIpjfVsXVoYQDKJMnUfqEZ5hPRAEnOeqB5bNUBBb7//w5ZFahmnJOpC8gSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JmjFlbDE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmjFlbDE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756954509;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BFGsvyfGlZeRUoo142qkd9fYdJJZqaobhSbYex4lato=;
	b=JmjFlbDEySnDZF9YYVFoOFsbAnywXyUrwr9ftux3re5h2DGbfn6MZgidrMB9J5mEkuH3a5
	IS0imKgGH5sQSOUPgoI/Aab6FSjeOYQO40zVe6YuCdo3BXn/IMRyRMPqWlNg9RxkACmkBj
	OBjkbsLqBUyUar1PFOCdGvGA+m/B/l0=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-34-4_CKnbvXMZ2GTofbWfns8g-1; Wed, 03 Sep 2025 22:55:07 -0400
X-MC-Unique: 4_CKnbvXMZ2GTofbWfns8g-1
X-Mimecast-MFC-AGG-ID: 4_CKnbvXMZ2GTofbWfns8g_1756954507
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-71d605205a0so8645857b3.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Sep 2025 19:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756954507; x=1757559307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFGsvyfGlZeRUoo142qkd9fYdJJZqaobhSbYex4lato=;
        b=hcVAlbi3zJppuVBlO2VHGRkcBi7dAyw1m4KYVmmW5ekp1NDt4Zo2vw3+5JSnYKgTkI
         kL2tnf1loBJgDgqQGudPW/BNSftsppwWSZk4HaR32IgT22BRHai05haJsGwlNFgc7RwK
         mIvTnrKXZgwp5Eu8SIv3FOzZe81r8+n4flJVz73xhQ1UMH6dIrcXlBlxqksn9jqxkh4M
         FyNBQDBJVkkCUFKcMkGz3SErmgDz0CpsLgFHyPFNW5RSwxyfHli6B+3i720xqS0vx0Ii
         bP5YCpqTsxayjA34wFgBWs7uNyn16JnkbwX3VAQmbP5Xtzh02cLvxMspWawvFzjvIp4g
         UQRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWv4+4EfuoUvX01LT34gcuxN+NbwJBnZxUh4GQ8KDuf/LdPH9vAlANe3TjdnubL1BkFTNlW179qt2LE7Mjbmx1i7fA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7Aa6oNTjUBmwCs5FVn6t0ou3Bhgw811V2wAbv2h+0l917xNS6
	9GPA/7HL/IMLU0W6zDSTENr3n5tIaeI++dPiKH1slk9j0spLXD9Vfg/0Myz8DOaqxXAZx/oWDDL
	I8jBFbOolMGx3b+RdMUZgQyI+UqG6wHTodvb/zLB4kzVhmWbC6UiNC+srxOYgQKGNceUGEYp97J
	QRpbJAOM6LrlfUgXKbYFqQV8wWPci65nLX8oCVEbxFxEFI/RZW
X-Gm-Gg: ASbGncvMhauyf8aIZpsQK20pyFfNfUSoXe/xRyHxpzffQMb2AjjnFuFLKAdBHp/Mr23
	sMmo1AE+Lr2lendalYsjuDJdiSQtIUji/W6BbvQO0M8ip1PuHPfJF6RhUw4OvqOs6gIp1ge1zaI
	WQghqyj4tQ5YOnEuVYpXlyYCI9uOfYwuo+fdE=
X-Received: by 2002:a05:690e:2483:b0:5fc:aef:28c9 with SMTP id 956f58d0204a3-601782d5d5dmr1244600d50.29.1756954506638;
        Wed, 03 Sep 2025 19:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDp5KBBiAm/A14c1UZ2x88hWB4XMoRs9mNoQ299w19LQV6LRXEBDT8MMPS9G/48qZ5qMyz3tFyTQ/kB1gAxKA=
X-Received: by 2002:a05:690e:2483:b0:5fc:aef:28c9 with SMTP id
 956f58d0204a3-601782d5d5dmr1244576d50.29.1756954506194; Wed, 03 Sep 2025
 19:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250819134205.622806-1-npache@redhat.com> <0d9c6088-536b-4d7a-8f75-9be5f0faa86f@lucifer.local>
 <CAA1CXcCqhFoGBvFK-ox2sJw7QHaFt+-Lw09BDYsAGKg4qc8nSw@mail.gmail.com>
 <CAA1CXcAXTL811VJxqyL18CUw8FNek6ibPr6pKJ_7rfGn-ZU-1A@mail.gmail.com>
 <5bea5efa-2efc-4c01-8aa1-a8711482153c@lucifer.local> <CAA1CXcBDq9PucQdfQRh1iqJLPB6Jn6mNy28v_AuHWb9kz1gpqQ@mail.gmail.com>
 <d110a84a-a827-48b4-91c5-67cec3e92874@lucifer.local> <95012dfc-d82d-4ae2-b4cd-1e8dcf15e44b@redhat.com>
 <bdbb5168-7657-4f11-a42d-b75cce7e0bca@lucifer.local> <e34e1ffe-c377-4c9a-b28b-ca873f3620ac@redhat.com>
 <db2320ee-6bd4-49c1-8fce-0468f48e1842@linux.alibaba.com> <c8c5e818-536a-4d72-b8dc-36aeb1b61800@arm.com>
 <2a141eef-46e2-46e1-9b0f-066ec537600d@linux.alibaba.com> <f34b5fcb-6a97-4d97-86a8-906083b53be6@redhat.com>
 <eb02c281-6d41-44af-8eaf-8ffc29153a3a@linux.alibaba.com> <286e2cb3-6beb-4d21-b28a-2f99bb2f759b@redhat.com>
 <17075d6a-a209-4636-ae42-2f8944aea745@gmail.com> <287f3b64-bc34-48d9-9778-c519260c3dba@redhat.com>
 <ad6ed55e-2471-46be-b123-5272f3052e01@gmail.com>
In-Reply-To: <ad6ed55e-2471-46be-b123-5272f3052e01@gmail.com>
From: Nico Pache <npache@redhat.com>
Date: Wed, 3 Sep 2025 20:54:39 -0600
X-Gm-Features: Ac12FXyZ7Om70-q7zqgNTiGl13FCHecHMQ3x9cRnHFwQsUK8x6vVkC5jouQ4XXQ
Message-ID: <CAA1CXcCMPFqiiTi7hfVhhEvHs4Mddiktvpmb7dMe4coLDF0bgg@mail.gmail.com>
Subject: Re: [PATCH v10 00/13] khugepaged: mTHP support
To: Usama Arif <usamaarif642@gmail.com>
Cc: David Hildenbrand <david@redhat.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Dev Jain <dev.jain@arm.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ziy@nvidia.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	akpm@linux-foundation.org, baohua@kernel.org, willy@infradead.org, 
	peterx@redhat.com, wangkefeng.wang@huawei.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
	yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com, 
	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com, 
	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org, 
	dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, jglisse@google.com, 
	surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, hughd@google.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1YZkkG5XsqMhlrcNyKjNRWEryunNQK3mepReBvaC_bY_1756954507
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 2, 2025 at 2:23=E2=80=AFPM Usama Arif <usamaarif642@gmail.com> =
wrote:
>
>
>
> On 02/09/2025 12:03, David Hildenbrand wrote:
> > On 02.09.25 12:34, Usama Arif wrote:
> >>
> >>
> >> On 02/09/2025 10:03, David Hildenbrand wrote:
> >>> On 02.09.25 04:28, Baolin Wang wrote:
> >>>>
> >>>>
> >>>> On 2025/9/2 00:46, David Hildenbrand wrote:
> >>>>> On 29.08.25 03:55, Baolin Wang wrote:
> >>>>>>
> >>>>>>
> >>>>>> On 2025/8/28 18:48, Dev Jain wrote:
> >>>>>>>
> >>>>>>> On 28/08/25 3:16 pm, Baolin Wang wrote:
> >>>>>>>> (Sorry for chiming in late)
> >>>>>>>>
> >>>>>>>> On 2025/8/22 22:10, David Hildenbrand wrote:
> >>>>>>>>>>> Once could also easily support the value 255 (HPAGE_PMD_NR / =
2- 1),
> >>>>>>>>>>> but not sure
> >>>>>>>>>>> if we have to add that for now.
> >>>>>>>>>>
> >>>>>>>>>> Yeah not so sure about this, this is a 'just have to know' too=
, and
> >>>>>>>>>> yes you
> >>>>>>>>>> might add it to the docs, but people are going to be mightily
> >>>>>>>>>> confused, esp if
> >>>>>>>>>> it's a calculated value.
> >>>>>>>>>>
> >>>>>>>>>> I don't see any other way around having a separate tunable if =
we
> >>>>>>>>>> don't just have
> >>>>>>>>>> something VERY simple like on/off.
> >>>>>>>>>
> >>>>>>>>> Yeah, not advocating that we add support for other values than =
0/511,
> >>>>>>>>> really.
> >>>>>>>>>
> >>>>>>>>>>
> >>>>>>>>>> Also the mentioned issue sounds like something that needs to b=
e
> >>>>>>>>>> fixed elsewhere
> >>>>>>>>>> honestly in the algorithm used to figure out mTHP ranges (I ma=
y be
> >>>>>>>>>> wrong - and
> >>>>>>>>>> happy to stand corrected if this is somehow inherent, but real=
lly
> >>>>>>>>>> feels that
> >>>>>>>>>> way).
> >>>>>>>>>
> >>>>>>>>> I think the creep is unavoidable for certain values.
> >>>>>>>>>
> >>>>>>>>> If you have the first two pages of a PMD area populated, and yo=
u
> >>>>>>>>> allow for at least half of the #PTEs to be non/zero, you'd coll=
apse
> >>>>>>>>> first a
> >>>>>>>>> order-2 folio, then and order-3 ... until you reached PMD order=
.
> >>>>>>>>>
> >>>>>>>>> So for now we really should just support 0 / 511 to say "don't
> >>>>>>>>> collapse if there are holes" vs. "always collapse if there is a=
t
> >>>>>>>>> least one pte used".
> >>>>>>>>
> >>>>>>>> If we only allow setting 0 or 511, as Nico mentioned before, "At=
 511,
> >>>>>>>> no mTHP collapses would ever occur anyway, unless you have 2MB
> >>>>>>>> disabled and other mTHP sizes enabled. Technically, at 511, only=
 the
> >>>>>>>> highest enabled order would ever be collapsed."
> >>>>>>> I didn't understand this statement. At 511, mTHP collapses will o=
ccur if
> >>>>>>> khugepaged cannot get a PMD folio. Our goal is to collapse to the
> >>>>>>> highest order folio.
> >>>>>>
> >>>>>> Yes, I=E2=80=99m not saying that it=E2=80=99s incorrect behavior w=
hen set to 511. What I
> >>>>>> mean is, as in the example I gave below, users may only want to al=
low a
> >>>>>> large order collapse when the number of present PTEs reaches half =
of the
> >>>>>> large folio, in order to avoid RSS bloat.
> >>>>>
> >>>>> How do these users control allocation at fault time where this para=
meter
> >>>>> is completely ignored?
> >>>>
> >>>> Sorry, I did not get your point. Why does the 'max_pte_none' need to
> >>>> control allocation at fault time? Could you be more specific? Thanks=
.
> >>>
> >>> The comment over khugepaged_max_ptes_none gives a hint:
> >>>
> >>> /*
> >>>   * default collapse hugepages if there is at least one pte mapped li=
ke
> >>>   * it would have happened if the vma was large enough during page
> >>>   * fault.
> >>>   *
> >>>   * Note that these are only respected if collapse was initiated by k=
hugepaged.
> >>>   */
> >>>
> >>> In the common case (for anything that really cares about RSS bloat) y=
ou will just a
> >>> get a THP during page fault and consequently RSS bloat.
> >>>
> >>> As raised in my other reply, the only documented reason to set max_pt=
es_none=3D0 seems
> >>> to be when an application later (after once possibly getting a THP al=
ready during
> >>> page faults) did some MADV_DONTNEED and wants to control the usage of=
 THPs itself using
> >>> MADV_COLLAPSE.
> >>>
> >>> It's a questionable use case, that already got more problematic with =
mTHP and page
> >>> table reclaim.
> >>>
> >>> Let me explain:
> >>>
> >>> Before mTHP, if someone would MADV_DONTNEED (resulting in
> >>> a page table with at least one pte_none entry), there would have been=
 no way we would
> >>> get memory over-allocated afterwards with max_ptes_none=3D0.
> >>>
> >>> (1) Page faults would spot "there is a page table" and just fallback =
to order-0 pages.
> >>> (2) khugepaged was told to not collapse through max_ptes_none=3D0.
> >>>
> >>> But now:
> >>>
> >>> (A) With mTHP during page-faults, we can just end up over-allocating =
memory in such
> >>>      an area again: page faults will simply spot a bunch of pte_nones=
 around the fault area
> >>>      and install an mTHP.
> >>>
> >>> (B) With page table reclaim (when zapping all PTEs in a table at once=
), we will reclaim the
> >>>      page table. The next page fault will just try installing a PMD T=
HP again, because there is
> >>>      no PTE table anymore.
> >>>
> >>> So I question the utility of max_ptes_none. If you can't tame page fa=
ults, then there is only
> >>> limited sense in taming khugepaged. I think there is vale in setting =
max_ptes_none=3D0 for some
> >>> corner cases, but I am yet to learn why max_ptes_none=3D123 would mak=
e any sense.
> >>>
> >>>
> >>
> >> For PMD mapped THPs with THP shrinker, this has changed. You can basic=
ally tame pagefaults, as when you encounter
> >> memory pressure, the shrinker kicks in if the value is less than HPAGE=
_PMD_NR -1 (i.e. 511 for x86), and
> >> will break down those hugepages and free up zero-filled memory.
> >
> > You are not really taming page faults, though, you are undoing what pag=
e faults might have messed up :)
> >
> > I have seen in our prod workloads where
> >> the memory usage and THP usage can spike (usually when the workload st=
arts), but with memory pressure,
> >> the memory usage is lower compared to with max_ptes_none =3D 511, whil=
e still still keeping the benefits
> >> of THPs like lower TLB misses.
> >
> > Thanks for raising that: I think the current behavior is in place such =
that you don't bounce back-and-forth between khugepaged collapse and shrink=
er-split.
> >
>
> Yes, both collapse and shrinker split hinge on max_ptes_none to prevent o=
ne of these things thrashing the effect of the other.
I believe with mTHP support in khugepaged, the max_ptes_none value in
the shrinker must also leverage the 'order' scaling to properly
prevent thrashing.
I've been testing a patch for this that I might include in the V11.
>
> > There are likely other ways to achieve that, when we have in mind that =
the thp shrinker will install zero pages and max_ptes_none includes
> > zero pages.
> >
> >>
> >> I do agree that the value of max_ptes_none is magical and different wo=
rkloads can react very differently
> >> to it. The relationship is definitely not linear. i.e. if I use max_pt=
es_none =3D 256, it does not mean
> >> that the memory regression of using THP=3Dalways vs THP=3Dmadvise is h=
alved.
> >
> > To which value would you set it? Just 510? 0?
> >
>
> There are some very large workloads in the meta fleet that I experimented=
 with and found that having
> a small value works out. I experimented with 0, 51 (10%) and 256 (50%). 5=
1 was found to be an optimal
> comprimise in terms of application metrics improving, having an acceptabl=
e amount of memory regression and
> improved system level metrics (lower TLB misses, lower page faults). I am=
 sure there was a better value out
> there for these workloads, but not possible to experiment with every valu=
e.
>
> In terms of wider rollout across the fleet, we are going to target 0 (or =
a very very small value)
> when moving from THP=3Dmadvise to always. Mainly because it is the least =
likely to cause a memory regression as
> THP shrinker will deal with page faults faulting in mostly zero-filled pa=
ges and khugepaged wont collapse
> pages that are dominated by 4K zero-filled chunks.
>

