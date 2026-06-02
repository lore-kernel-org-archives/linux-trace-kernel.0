Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF9F3803F5
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Jun 2026 10:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780397891; cv=none; b=kcr1qcIq0nCmdGfTSF/K/uAmDrqX5/aki2mbTd+QN30NbIwsa7w+TNJS5KuTDDKOhHA9VReZcLNGXrxkTC7Oh0osUO8UfiVlle1Eajy2KvkoIBLpDrneDGGQifU5cfU4cFCLxmD58r0MpCZ4qNakAPsfA4887Y+4klsAHbqwUgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780397891; c=relaxed/simple;
	bh=IThGWOOZGbVGfuCaLgZyh1XcfzbaXpKlfr5NbCDa4KY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q5qH0AEa3VYhdmzvkWEmb3+Elf3+hCxPJlOeyArxJtrqv8581Pu7srbo1oJtCe1KmBvjdYU0KWqLX7TfdwgBsGau7OWJ4BT+JX86d/EB339nzr/qCloahbUCF0aaqWAbH4mFhqvhS6sPmI9GCFC69lu6AwB85k4xJdkBQDQ8mfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W+uq8hrC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W+uq8hrC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780397889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lzLj+P+CIxVIK1VlPvMvdq94QC/E8hMOQaV32XaaoGc=;
	b=W+uq8hrCIiZeSY5aG0+UkAh67C6CKkCXFSs1YTHS1MSMDQyrRbf9mecfXgveFI0f+AauAk
	/w+2wL8Gn9F8tLnToUTzqprr27JnLrEQp+DLI/0EUReqW8oK80Nngg0xh0b1C8JYDVd2Bw
	sLdjUEU+RmWPR1R8kSZfHbzB/WofkCE=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-N8CQbv-aMBOb5zAQcZndjA-1; Tue, 02 Jun 2026 06:58:07 -0400
X-MC-Unique: N8CQbv-aMBOb5zAQcZndjA-1
X-Mimecast-MFC-AGG-ID: N8CQbv-aMBOb5zAQcZndjA_1780397887
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-66034c1b31cso7192830d50.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 03:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780397887; x=1781002687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lzLj+P+CIxVIK1VlPvMvdq94QC/E8hMOQaV32XaaoGc=;
        b=Kyp0WGQDoDpaDjaPC2rSGDUDOeWQiR/unndhfWpaMk7IHI97HbOy+FcRb87eaSoZfc
         yvX7udaXxkIC/8PzBy7WlR4TiK0ZzH7QFSURP8NJSs8sEvUn9/PbKb5NNrpSL6C+FN7O
         g0UHSUp76LVXMyhUAEc2XXBWXLjJ/LRvcBv7vZIRiGRn0anxka4UoW+YXcA5E8FLXEsb
         WYkY3iyJ9SYa0e5otFNnIywZJJSq9apKlZxrO/AlaokDhPc9Nf6BZhnfYdLYh8UwO+zZ
         QWz8Vn23hUGOIkC0kyOTMeULWKIpupsnVElLnmvNxYXIoDJ6X4WFj5IxRdsvn2jHMkff
         mLMg==
X-Forwarded-Encrypted: i=1; AFNElJ/zyqf9kkpe6ugay3gBuxXBwN34PSer9rbYqEBZ8kD+sTxHdg/h5ysh2uwHtrtYYAui2IuTJsoJYLS2fSn4BDZ0EUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzF+JBHJLsKEZaYnBfqcFLD5JbAUlZ0cFTtpyrtZ3MHZFgMWLJ
	Ss/zG4ptHK83DQrX12vJAT8iW7FXLjz1K1BW/B8CRkZSo6bDWsFjj0dCFqhh+JUMbIwTjZGYAEr
	hM0WFSRqja2zRj3T/rBhepxpuJsLLdPGT/tFp5S4Hp1ytC6gjTC3y0G5BAfxke8kmL5BNdbfn5q
	XBPDp7YSrfYphUyDREQGU5J/+jEvM3peaKVP2lh0Tdbnm3sBGD
X-Gm-Gg: Acq92OHyD+DbZcMxKvpyuHgHYhMQ2w8SaXNruarV1ABsty7aGJC1DEXmkrZOONtPd9g
	Px8DfHP8frExKzDKTOROAF0858Dr/DFd6hHWuxFswOqGKvuw7pDyIhRclM6MIAoCiMXFDJ2B3Kh
	1GaqqpEwIFicb6jjC0SSqe15W+hb7E5ecf3OLF88ynYgt4LFJUaYBdGG7EydI4JkX1e9rpIipNn
	RParzK/FpaxulDTJg==
X-Received: by 2002:a05:690e:4084:b0:660:8253:b836 with SMTP id 956f58d0204a3-6608253ca8bmr7541733d50.5.1780397887240;
        Tue, 02 Jun 2026 03:58:07 -0700 (PDT)
X-Received: by 2002:a05:690e:4084:b0:660:8253:b836 with SMTP id
 956f58d0204a3-6608253ca8bmr7541686d50.5.1780397886838; Tue, 02 Jun 2026
 03:58:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-12-npache@redhat.com> <20260531071845.10875-1-lance.yang@linux.dev>
In-Reply-To: <20260531071845.10875-1-lance.yang@linux.dev>
From: Nico Pache <npache@redhat.com>
Date: Tue, 2 Jun 2026 04:58:46 -0600
X-Gm-Features: AVHnY4IqE8U3CJE9xIL2UnupWmTAd82eHE7h-QioX8Ctpe94C2G_M5ur14b-CTk
Message-ID: <CAA1CXcA+oZmp=cxiC2_EBDxqGX94gAd335d9eFPNv=j_0=og7Q@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v18 11/14] mm/khugepaged: Introduce mTHP
 collapse support
To: Lance Yang <lance.yang@linux.dev>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
	joshua.hahnjy@gmail.com, kas@kernel.org, liam@infradead.org, ljs@kernel.org, 
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
X-Mimecast-MFC-PROC-ID: yJy6F95ZrejZ0LaW92Bt5Vr8mGzg4n7x3WGAWbBG0GM_1780397887
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 1:19=E2=80=AFAM Lance Yang <lance.yang@linux.dev> w=
rote:
>
>
> On Fri, May 22, 2026 at 09:00:06AM -0600, Nico Pache wrote:
> [...]
> >@@ -1587,10 +1749,11 @@ static enum scan_result collapse_scan_pmd(struct=
 mm_struct *mm,
> >       if (result =3D=3D SCAN_SUCCEED) {
> >               /* collapse_huge_page expects the lock to be dropped befo=
re calling */
> >               mmap_read_unlock(mm);
> >-              result =3D collapse_huge_page(mm, start_addr, referenced,
> >-                                          unmapped, cc, HPAGE_PMD_ORDER=
);
> >-              /* collapse_huge_page will return with the mmap_lock rele=
ased */
> >+              nr_collapsed =3D mthp_collapse(mm, vma, start_addr, refer=
enced,
> >+                                           unmapped, cc, enabled_orders=
);
> >+              /* mmap_lock was released above, set lock_dropped */
> >               *lock_dropped =3D true;
> >+              result =3D nr_collapsed ? SCAN_SUCCEED : SCAN_FAIL;
>
> Hmm ... don't we lose the allocation-failure result here?
>
> Previously collapse_scan_pmd() propagated SCAN_ALLOC_HUGE_PAGE_FAIL from
> collapse_huge_page(), so khugepaged would call khugepaged_alloc_sleep()
> in khugepaged_do_scan().
>
> Now if allocation fails and nr_collapsed stays 0, we just return
> SCAN_FAIL. So we won't back off via khugepaged_alloc_sleep() anymore?

Ok I did the error propagation! I think I handled both of these cases
you brought up pretty easily.

However I don't know what to do in the following case: We successfully
collapsed some portion of the PMD, but during that process, we also
hit an allocation failure. Is it best to back off entirely? or can we
treat some forward progress as a sign we can continue trying collapses
without sleeping.

Basically, do we prioritize SCAN_ALLOC_HUGE_PAGE_FAIL or the
successful collapses as the returned value?

This is what I currently have:
done:
    if (collapsed)
        return SCAN_SUCCEED;
    if (alloc_failed)
        return SCAN_ALLOC_HUGE_PAGE_FAIL;

Thanks,
-- Nico

>
> Cheers, Lance
>

