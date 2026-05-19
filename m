Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D5836C598
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779218448; cv=none; b=eVXhhiut/BYjYWbIjOfjUb9QSjBScoF2SPXhV83GODzmUYVWkFlojke0Z5i5XZ6bnZPTKLs2AsyzFHipmYdrfYqUBR44jKfdQJFuAhQuli9JuKtERnT2Og60cx0Bd6vLOOIqzK2eldIWNUPx/8sJEsxph+ye8nOvLzTJ/l/j74g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779218448; c=relaxed/simple;
	bh=tkErD4tC8es5BnMN9FTsuW3IE9uCxoITNC1bgGReIS0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLUPEcVC6GIxG1X1hAdmzkwCkoTScytMsG6qn3ElYjLIJ7xpKYAzkrwAyCmKv34sdFsVoQMIzEK1imiUCygMp7XDLDPZh/9TFQ8EpM1DD5Ol3BHUbtN/F69aEiUnVQ+I6DhM/8yrVSsXUlefZ+02twn5P0wvC/L6O22t3RpRtOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XC1+uC9u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XC1+uC9u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779218444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n8tG2wswV07nIaXcZKUGCsw/G0T7Ho3Kv10KqQkUI+0=;
	b=XC1+uC9utA43tTmMzoh8l3oKYjdl81MS1LApfYbEGTy6acWufu2wrRUBVzr2hLzqty+fl3
	VsedO/5icY7d9mKKySvhe1VBjKmq/xjTT+b+6rBNUalwaKTWeHRlfODSQXDiCFX2wtG+RO
	XX/tdrtqd7V7alur/gCJ84EowKRFI1U=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-j0fDPY2dOfqjzx30ibPoRA-1; Tue, 19 May 2026 15:20:41 -0400
X-MC-Unique: j0fDPY2dOfqjzx30ibPoRA-1
X-Mimecast-MFC-AGG-ID: j0fDPY2dOfqjzx30ibPoRA_1779218441
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65dd6f53f56so6947120d50.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 May 2026 12:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779218441; x=1779823241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=n8tG2wswV07nIaXcZKUGCsw/G0T7Ho3Kv10KqQkUI+0=;
        b=PS0Dx0jqLNb5DCzuhR3U+RmAq0fH9v/Me9MH+Mr84YTfoIdnPmbH1SacKM5pt0qcxF
         suNmQ7xQxGjIFOPr0g23YPcz0XbnWRseUsPthdUaayXCJvwYlxZw+QrXLnEPm+GFKu3W
         HXl6McVZbUm1oSUYAEmVPBQq5f+slm6VNu5O1EEmL3qLsXjVELwrM1QvF1oOj5j7Ek6d
         nE5METVYFDEXeTFVZuEWwy8QOottrQHo+UGiBvYcThUpCVfNuroRUGFIYRKBAlNj7RSb
         j7tqNGp1B6YYwwEAkRl7tEnFg02aG1ymzDsXM8LBMD3A3eJTi5CvGt2Z88UKW9La+k02
         IZtA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ta7hWMdakXw7ysNRjz2prEoYTVKYjixJkdDfdtufn6W82NAHi9DUsq6k08yQmjhiirEAHnP/DdiXoN8kfs7BIwIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV0DLCD95WxjdrHFCDA5I9Ca/6FfsbuB+ZWzzhWmzCLn9Hqu8S
	rfDxXksi123PL472dKq76Yg8vi9DnuVFJHbfPJVKpgRR4rglkKsldQt0SZI8LWbO9dOzZJE0j9b
	o1Jt4JW6+s7covb7oa81IeCBj+x1f1f60x5Pytl6xOW2vkTBTckIQpMcdE92kbdZAYJl17FFBOz
	uWNdII49DY9fi8nqVC0Djmo/ePQdhQind5WRKt95CqKislA3jR
X-Gm-Gg: Acq92OGH4vmW9N0qTEUQQHRBWe6q3HvRsgSe1kpFe5yS+rxWFHV/yt+fP3hfP84U+Qv
	VIAmwPR6cYcNBea8ImO7BF+IKQjTDhu2YiOKL07eZHtQmPpbTP2Gu73mbJCPG9egJYuLnYydQGA
	xmROW0LMbhFIdC8xYwaLWkLLdmoBeK6lg16JT22h6UuCur+q42KSq/QaHmQEEcq+E4hGKJjKsFD
	Nr1eQ==
X-Received: by 2002:a05:690e:4417:20b0:651:c20e:a43 with SMTP id 956f58d0204a3-65e22674e39mr17209617d50.6.1779218440631;
        Tue, 19 May 2026 12:20:40 -0700 (PDT)
X-Received: by 2002:a05:690e:4417:20b0:651:c20e:a43 with SMTP id
 956f58d0204a3-65e22674e39mr17209557d50.6.1779218439923; Tue, 19 May 2026
 12:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511185817.686831-1-npache@redhat.com> <20260518125007.a4z3pw4r73uuwja4@master>
In-Reply-To: <20260518125007.a4z3pw4r73uuwja4@master>
From: Nico Pache <npache@redhat.com>
Date: Tue, 19 May 2026 13:20:45 -0600
X-Gm-Features: AVHnY4Jl_QW-vgdM5ZP8NC0nxmd5EfltpH7tsdSlcrq5iAp5kcmnKVwJ9jkpOtk
Message-ID: <CAA1CXcCnMddMbhXF9zkut6tD4kh1fXRecwA=LFAiBSRatL3Rtg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v17 00/14] khugepaged: mTHP support
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org, aarcange@redhat.com, 
	akpm@linux-foundation.org, anshuman.khandual@arm.com, apopple@nvidia.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, byungchul@sk.com, 
	catalin.marinas@arm.com, cl@gentwo.org, corbet@lwn.net, 
	dave.hansen@linux.intel.com, david@kernel.org, dev.jain@arm.com, 
	gourry@gourry.net, hannes@cmpxchg.org, hughd@google.com, jack@suse.cz, 
	jackmanb@google.com, jannh@google.com, jglisse@google.com, 
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
X-Mimecast-MFC-PROC-ID: nITyEf6g9WzVEUFEl8CS780JCdM9_PS3J6Xvrr0Eewo_1779218441
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 6:50=E2=80=AFAM Wei Yang <richard.weiyang@gmail.com=
> wrote:
>
> On Mon, May 11, 2026 at 12:58:00PM -0600, Nico Pache wrote:
> >The following series provides khugepaged with the capability to collapse
> >anonymous memory regions to mTHPs.
> >
> >To achieve this we generalize the khugepaged functions to no longer depe=
nd
> >on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individ=
ual
> >pages that are occupied (!none/zero). After the PMD scan is done, we use
> >the bitmap to find the optimal mTHP sizes for the PMD range. The
> >restriction on max_ptes_none is removed during the scan, to make sure we
> >account for the whole PMD range in the bitmap. When no mTHP size is
> >enabled, the legacy behavior of khugepaged is maintained.
> >
> >We currently only support max_ptes_none values of 0 or HPAGE_PMD_NR - 1
> >(ie 511). If any other value is specified, the kernel will emit a warnin=
g
> >and no mTHP collapse will be attempted. If a mTHP collapse is attempted,
> >but contains swapped out, or shared pages, we don't perform the collapse=
.
> >It is now also possible to collapse to mTHPs without requiring the PMD T=
HP
> >size to be enabled. These limitations are to prevent collapse "creep"
> >behavior. This prevents constantly promoting mTHPs to the next available
> >size, which would occur because a collapse introduces more non-zero page=
s
> >that would satisfy the promotion condition on subsequent scans.
> >
> >Patch 1-2:   Generalize hugepage_vma_revalidate and alloc_charge_folio
> >            for arbitrary orders.
> >Patch 3:     Rework max_ptes_* handling into helper functions
> >Patch 4:     Generalize __collapse_huge_page_* for mTHP support
> >Patch 5:     Require collapse_huge_page to enter/exit with the lock drop=
ped
> >Patch 6:     Generalize collapse_huge_page for mTHP collapse
> >Patch 7:     Skip collapsing mTHP to smaller orders
> >Patch 8-9:   Add per-order mTHP statistics and tracepoints
> >Patch 10:    Introduce collapse_allowable_orders helper function
> >Patch 11-13: Introduce bitmap and mTHP collapse support, fully enabled
> >Patch 14:    Documentation
> >
> >Testing:
> >- Built for x86_64, aarch64, ppc64le, and s390x
> >- ran all arches on test suites provided by the kernel-tests project
> >- internal testing suites: functional testing and performance testing
> >- selftests mm
> >- I created a test script that I used to push khugepaged to its limits
> >   while monitoring a number of stats and tracepoints. The code is
> >   available here[1] (Run in legacy mode for these changes and set mthp
> >   sizes to inherit)
> >   The summary from my testings was that there was no significant
> >   regression noticed through this test. In some cases my changes had
> >   better collapse latencies, and was able to scan more pages in the sam=
e
> >   amount of time/work, but for the most part the results were consisten=
t.
> >- redis testing. I did some testing with these changes along with my def=
er
> >  changes (see followup [2] post for more details). We've decided to get
> >  the mTHP changes merged first before attempting the defer series.
> >- some basic testing on 64k page size.
> >- lots of general use.
> >
>
> Two links are missing. I got them from previous version.
>
> [1] - https://gitlab.com/npache/khugepaged_mthp_test
> [2] - https://lore.kernel.org/lkml/20250515033857.132535-1-npache@redhat.=
com/

Oh whoops, ill make sure they are there in the followup

>
> And the test in [1] is a performance test. I am thinking whether we want =
a
> functional test in selftests.

It also works as a functional test in some regards. The reason i never
pursued self-tests is that I naively thought this was getting merged
6(?) months ago and at the time the selftests infrastructure didn't
support it well. Baolin included patches to clean that up in his shmem
mTHP support patches and added tests for both features. Let's repost
and re-merge this first; then, I will follow up in one or two weeks
regarding self-tests. I'm currently on PTO and only have time to
complete, test, and return the v18 changes to Andrew before they
create a huge merge headache and we miss yet another window.

>
> I did a quick try with following change and some hack.

Thanks Ill use that as a base!

>
> @@ -744,6 +765,51 @@ static void collapse_max_ptes_none(struct collapse_c=
ontext *c, struct mem_ops *o
>         ksft_test_result_report(exit_status, "%s\n", __func__);
>  }
>
> +static void collapse_mth_ptes(struct collapse_context *c, struct mem_ops=
 *ops)
> +{
> +       struct thp_settings settings =3D *thp_current_settings();
> +       void *p;
> +       int i;
> +
> +       /* Disable mthp on fault */
> +       for (i =3D 0; i < NR_ORDERS; i++) {
> +               settings.hugepages[i].enabled =3D THP_NEVER;
> +       }
> +       thp_push_settings(&settings);
> +
> +       p =3D ops->setup_area(1);
> +
> +       ops->fault(p, 0, hpage_pmd_size);
> +
> +       /* Expect all order-0 folio after fault */
> +       memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
> +       expected_orders[0] =3D hpage_pmd_nr;
> +       if (check_folio_orders(p, hpage_pmd_size, pagemap_fd,
> +                                          kpageflags_fd, expected_orders=
,
> +                                          (pmd_order + 1)))
> +               ksft_exit_fail_msg("Unexpected huge page at fault\n");
> +
> +       /* Enable mthp before collapse */
> +       thp_pop_settings();
> +       settings.hugepages[2].enabled =3D THP_ALWAYS;
> +       thp_push_settings(&settings);
> +
> +       c->collapse("Collapse fully populated PTE table with order 2", p,=
 1,
> +                   ops, true);
> +
> +       /* Expect all order-2 folio after collapse */
> +       memset(expected_orders, 0, sizeof(int) * (pmd_order + 1));
> +       expected_orders[2] =3D 1 << (pmd_order - 2);
> +       if (check_folio_orders(p, hpage_pmd_size, pagemap_fd,
> +                                          kpageflags_fd, expected_orders=
,
> +                                          (pmd_order + 1)))
> +               ksft_exit_fail_msg("Unexpected page order\n");
> +
> +       ops->cleanup_area(p, hpage_pmd_size);
> +       thp_pop_settings();
> +       ksft_test_result_report(exit_status, "%s\n", __func__);
> +}
> +
>  static void collapse_swapin_single_pte(struct collapse_context *c, struc=
t mem_ops *ops)
>  {
>         void *p;
>
> This leverage check_after_split_folio_orders() in split_huge_page_test.c =
to
> check folio order in PMD range.
>
> --
> Wei Yang
> Help you, Help me
>

