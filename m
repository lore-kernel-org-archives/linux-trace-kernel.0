Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB10A3DC4A2
	for <linux-trace-kernel@vger.kernel.org>; Mon,  1 Jun 2026 17:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780333494; cv=none; b=DgYSAuf898UnDMn3o5jT/KQ3mGnYZQ0x8CkwEZb1oyoPXyMov8FXt2a20qYSoDi61uAW2PtImPzcglkGRFvyiS8kXfG5t+Sf4pW5N1jpcGnBrSQekfgjdd1elWg1xR3y3AyVtkvMWQcwWNh7q51KtDRCOJFcriTAUm3pRCAJoEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780333494; c=relaxed/simple;
	bh=X9gPD9JmY4i9Kpjf8CO6+6uJrHV5AC92RCXu6Qx3uG4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eJ2EEkTRSVmVmV24lZPOXRCnyD1v69pHquUtZCq9kfwlw4lY+h+cCQTAm19QPgHh0fWdBiyB9y/+Lxl6aZfne/h5xjVRoxi/XpUEDnKXs8z7rk/VI02Q4XGQLCOeevnXrj7ZDqqDNVgGH9pCQokRzmyqgN1VIRfMZj+MHmjtiEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FTFmELyz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FTFmELyz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780333491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWY7+zLcstKVcaBHa6DF3oAjfO/xzJSbuw3Jcm1WeHw=;
	b=FTFmELyzHLKXbyeikT+6WohFaHvUjra0gdtm3kRAAuBTB+eOqtmF2QRv3aDEAuCeVMU42H
	XXw7bvtTLQ6OcUtWpHqEo8CvSAtLUHma1PfachYcBRbsvfXlATZetZDdSnkOR/t60OLITx
	Q3kR3rUT6ToiQMc51s5HBhEKPSm0oHQ=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-hcn62VNuPfW_iUGFlSdIHQ-1; Mon, 01 Jun 2026 13:04:47 -0400
X-MC-Unique: hcn62VNuPfW_iUGFlSdIHQ-1
X-Mimecast-MFC-AGG-ID: hcn62VNuPfW_iUGFlSdIHQ_1780333483
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-7e0533b7d8aso44780837b3.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Jun 2026 10:04:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780333483; x=1780938283;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pWY7+zLcstKVcaBHa6DF3oAjfO/xzJSbuw3Jcm1WeHw=;
        b=H2nW+LT+3Pwkvg4ThPboONPKG43hyE9IHXido4yxohc06XNp18JRQZJRQAtPC1HQve
         S1YEQO6WIbQvN9yFjs+VehHKRlxKBjyn0iXDI2Y8x202cNP48fKg7tXb0E98UMoZq1jp
         WH47pNjAKz40ImN8BhHg72IvuK79OCkZcTMZgItS9gIN3V6opbVl3+QDn37Ec5AaIaiE
         hMrCUdQEJprnTrQEFQfFE9sx2/+gfUfimONyRQUGwBn0WVQqOVN3ct6jpBdQeu1ZCrrW
         k4CCw4fAlq0Jfsa6D+O6nzw6su8I3AR5B5qyvahNw0DKLZWqW2ZaA3hUh1CGg2WaXa8W
         bOXg==
X-Forwarded-Encrypted: i=1; AFNElJ+YrMKVAIjjbPgNFM3QYl3fee0Bo6ErNV3gkuOYM0mfi96p4oBsJSs+ED+3GQk5fqRyZnk+MqIlmASlMzJlBoxaoPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0GaMKkR5zrN4iYcceaNRakreXDMSrfIjHJEUS/UpPEMGLCmlF
	XW1q/7a2NBdeEg0yLdgsioJvAZ3Mgqo3NzLnE2G1G5WELKcNVw+ITJc3H79zAGzjwrW5Xh7idcu
	LxlovZ4tNl6AEmPzY3igB5JM1miUVKMEcNKvM6kzL1b9ArYMVmsw0Lt5VQn/efNTEuz7Y7TWj1w
	GlReqx4Z86xPDE/SCham1wzFzOmd73ciAXdInBFTeMIOa0oiBR
X-Gm-Gg: Acq92OF04SSJsRx8DCCkwcFlKsffSyqpPe0HKFb4RPrNMLqlcITVAhfqvHhB+FgPsmu
	HMzYQocU9hWuqbHaOqoK47+uRzUxXHc4XhTcFo1I/iDEu0BNKqxfe8m5JzpOVJKsJA2u881uulu
	Y7/pelUBJhUsYeGIVH3v6+gevMjQhcMMhLKTZXB1dohaxAz1UHBOK4WMoAQl4hgwl0e9rP2XYEv
	NHQ2XseBBa0CEjJ8g==
X-Received: by 2002:a05:690c:c50f:b0:7d3:cf30:ef91 with SMTP id 00721157ae682-7e05a1907d0mr108660377b3.19.1780333482421;
        Mon, 01 Jun 2026 10:04:42 -0700 (PDT)
X-Received: by 2002:a05:690c:c50f:b0:7d3:cf30:ef91 with SMTP id
 00721157ae682-7e05a1907d0mr108658977b3.19.1780333481712; Mon, 01 Jun 2026
 10:04:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <20260522134724.f4f11941a85ef18b307d16ae@linux-foundation.org>
 <20260601155808.2755103A59-agordeev@linux.ibm.com>
In-Reply-To: <20260601155808.2755103A59-agordeev@linux.ibm.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 1 Jun 2026 11:05:20 -0600
X-Gm-Features: AVHnY4LWX34RPOrSLZQKCFADp8MRh-hRHO-69bPjowu85AkTudvs-SlZUCsWfOs
Message-ID: <CAA1CXcAd-uQD0LgUzWAAkFKt13eFfaP3TfG9KED2RzYGhHoqpg@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes-unstable v18 00/14] khugepaged: add mTHP
 collapse support
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-doc@vger.kernel.org, 
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
	rdunlap@infradead.org, richard.weiyang@gmail.com, rientjes@google.com, 
	rostedt@goodmis.org, rppt@kernel.org, ryan.roberts@arm.com, shivankg@amd.com, 
	sunnanyong@huawei.com, surenb@google.com, thomas.hellstrom@linux.intel.com, 
	tiwai@suse.de, usamaarif642@gmail.com, vbabka@suse.cz, vishal.moola@gmail.com, 
	wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org, 
	yang@os.amperecomputing.com, ying.huang@linux.alibaba.com, ziy@nvidia.com, 
	zokeefe@google.com, linux-s390@vger.kernel.org, linux-next@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jRFbKNcSVtvuNgtpYfHkyfJk99139sLSWXy-Z5COj-4_1780333483
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 1, 2026 at 9:58=E2=80=AFAM Alexander Gordeev <agordeev@linux.ib=
m.com> wrote:
>
> On Fri, May 22, 2026 at 01:47:24PM -0700, Andrew Morton wrote:
>
> Hi Andrew et al,
>
> > On Fri, 22 May 2026 08:59:55 -0600 Nico Pache <npache@redhat.com> wrote=
:
> >
> > > The following series provides khugepaged with the capability to colla=
pse
> > > anonymous memory regions to mTHPs.
> >
> > Thanks, I've update mm.git's mm-unstable branch to this version.
> >
> > It sounds like I might be dropping it soon, haven't started looking at
> > that yet.  But let's at least eyeball the latest version at this time.
> >
> > Sashiko was able to apply this, so the base-it-on-hotfixes thing worked
> > well, thanks.  The AI checking made a few allegations:
>
> This series appears to cause hangs on s390 in linux-next.
> The issue is not easily reproducible, so it is not yet confirmed.
> Any ideas for a reliable reproducer that exercises the code path below?

Hi,

Thanks for the report!

was this caught by syzbot? If so, can you provide a link?

Also can you provide whether any of the mTHP sysfs settings were enabled?

Based on the report, it looks like we are either dealing with more
lock contention (due to holding the write lock longer). We could
switch to a trylock but that might cause us to lose some collapse
attempts (which will be retried later, so probably fine). I'm ok with
that approach if it prevents these potential regressions.

Cheers,
-- Nico

>
>     [ 2749.385719] sysrq: Show Blocked State
>     [ 2749.385730] task:khugepaged      state:D stack:0     pid:209   tgi=
d:209   ppid:2      task_flags:0x200040 flags:0x00000000
>     [ 2749.385735] Call Trace:
>     [ 2749.385736]  [<0000017f63c8b226>] __schedule+0x316/0x890
>     [ 2749.385740]  [<0000017f63c8b7dc>] schedule+0x3c/0xc0
>     [ 2749.385743]  [<0000017f63c8b888>] schedule_preempt_disabled+0x28/0=
x40
>     [ 2749.385746]  [<0000017f63c902ea>] rwsem_down_write_slowpath+0x2fa/=
0x8b0
>     [ 2749.385749]  [<0000017f63c90910>] down_write+0x70/0x80
>     [ 2749.385752]  [<0000017f6313407a>] collapse_huge_page+0x2ea/0x9e0
>     [ 2749.385755]  [<0000017f6313491e>] mthp_collapse+0x1ae/0x1f0
>     [ 2749.385757]  [<0000017f63134fda>] collapse_scan_pmd+0x67a/0x8f0
>     [ 2749.385760]  [<0000017f6313751a>] collapse_single_pmd+0x15a/0x260
>     [ 2749.385762]  [<0000017f6313792c>] collapse_scan_mm_slot.constprop.=
0+0x30c/0x470
>     [ 2749.385765]  [<0000017f63137cb6>] khugepaged+0x226/0x240
>     [ 2749.385768]  [<0000017f62db3128>] kthread+0x148/0x170
>     [ 2749.385770]  [<0000017f62d2c238>] __ret_from_fork+0x48/0x220
>     [ 2749.385772]  [<0000017f63c95d0a>] ret_from_fork+0xa/0x30
>
> Thanks!
>

