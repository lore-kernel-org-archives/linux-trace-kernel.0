Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27BE3FB7DC
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 17:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779988279; cv=none; b=hJEBWKPsnlakuuCUCz9m72w4nVDn3A4tSJyE+YLyfG+2oeyVydwydPq0Ta97BTCyurrX0tl4rUmVuuStsg150nSzaK4DUVJOm5OlUyxPlpXfaJKBY03/H8Jx+PbmI/dQeXKXAxp0S/LbZ1w01UO4sudIoGs1YMvSgPBrXZc3FZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779988279; c=relaxed/simple;
	bh=sz6XapUVmOA6zIuBmrCqm3oCvEoF6NkKyQu2hK/OPNs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XawDgmu7i01H0heQpQL8tAQoDTwEdmV23lNa5DzKKk6UCmgR6X2qBomAo4Ei4VDPP5iLmbdrIfN40oiqy7wHA4pKbgvyZok59SrFySVIphUpw/KqVWn5yS+kcPN1yIY2WRIffqy00+3453n0X9wgUY8oj84C25ys3zPqnHg9QMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTVPB714; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTVPB714"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779988276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0ihUpxCim2Hwyu43MMJlIX4H1ID4hW1kFB98h6S7dK8=;
	b=WTVPB714KWJDlupz1TscTgcLwiLDD7q5dHDxLbMyQBBkjfJYhcwBBqcxuQ8ZRMbwE1yajD
	ev6gbZpUyAkatsHsXNNxzIrX7QuRBLHMLcfrEqsnlAc5iZrLiDDmwR6+nScjTEQre10wNP
	C81kNeC2GgW1nA8o+NXkP/iqu/FKlgg=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-4SlJiORzMd21v7D5usgOvA-1; Thu, 28 May 2026 13:11:13 -0400
X-MC-Unique: 4SlJiORzMd21v7D5usgOvA-1
X-Mimecast-MFC-AGG-ID: 4SlJiORzMd21v7D5usgOvA_1779988273
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-65c7306e432so9008949d50.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 May 2026 10:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779988272; x=1780593072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ihUpxCim2Hwyu43MMJlIX4H1ID4hW1kFB98h6S7dK8=;
        b=JL2BXKv40dTnfzsIJDmmmQjw5UFAO71xgbGAFMREfPa2j4UCsqw8M3S0kCIVWF2YFC
         IoMvPgULm8Y8tSohDQl47hKh13cKu6rs/9R4Z9UuijQJYq6hEb67Zfz2k1qaiYgRvq3I
         /4V5TWrFpAahWgXsSP2AXvEdMFnsfa8toYuCzRdwSxvw8BvkPXZc6TKVSoTdl43COxBC
         XbpNAQhzo4UccAizoYiRjx1unwE998ICQLTzmuWR9ine4eFPRwexc8Zz7D21oTFs7Iv9
         w3dQ4XODuckY4KVOm0imUssPlUd5JhrzKkMcPBiW+ODKpnD8DGTbssaO+6stKzXKGq1S
         p3rw==
X-Forwarded-Encrypted: i=1; AFNElJ8q4GzW+wyDqyThjyaj6E5vJunuk9NPrlf7YoQZfCFlKr64gtHlbL0+Xuz2f0lD6UTmRtHkqlC9bcAqK6dEqnGzRSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD4yxnD+3EKmqhx4W59dXWeY2cPpdXBhKLy35MbbhtGP+AAMcC
	mMLEUgAnQcF2vOXJ56N/u5rJjSFjFJmGaAGjml8rVAnSSeGE5JuJCVDUzjZxb1SV0f6QRT18cMk
	HPA15pvJUiRHgNiA50ot5oAhYlMIpq0eCo/HSkM9FZZtD5zKoQYTsq4nJtYvf9Dmp96cuscoHV3
	5WVYQX19Y/NSLfFs70ZV7du8IIKEsfaISb9LfAlUCOq9Mvpu3R
X-Gm-Gg: Acq92OHu6zQ3FW1OaPln0/bFxUBCR+rKcT0rg2C4kfBG2oO9E8Jf99mdKnbXDfsykEX
	YI5NMrRmFPtUvxqCLkCQ7SO/agu+GXlIi+QDfbGaLrVKXKTUOAfkcpXbRuziF7Ge4BSCVT9uEos
	W1OXfw2eqpaCxzJzO0p/Wqwte4ONrNdonmlODIg8w35jhEApoeCzYEoy/yfsmD7rMjJv4+swTCd
	hRNsZZQVcdbBwCS
X-Received: by 2002:a05:690e:1544:10b0:65d:bf4b:f16b with SMTP id 956f58d0204a3-65ec96129d6mr21884166d50.3.1779988272445;
        Thu, 28 May 2026 10:11:12 -0700 (PDT)
X-Received: by 2002:a05:690e:1544:10b0:65d:bf4b:f16b with SMTP id
 956f58d0204a3-65ec96129d6mr21884113d50.3.1779988271977; Thu, 28 May 2026
 10:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522150009.121603-1-npache@redhat.com> <20260522150009.121603-12-npache@redhat.com>
 <2b2cda8c-358a-4a5c-989c-ae42593ef2ea@redhat.com> <20260525121041.2f2508a4f627c338cddd837a@linux-foundation.org>
 <20260526065708.oyyddmt2zgfwu2q7@master> <CAA1CXcDXyDhMyiVAb8XbusqMU10JXA8nOUw6b4_2i9H-kV2vwQ@mail.gmail.com>
 <20260528084211.wsdrvbvxvkddokb5@master>
In-Reply-To: <20260528084211.wsdrvbvxvkddokb5@master>
From: Nico Pache <npache@redhat.com>
Date: Thu, 28 May 2026 11:11:47 -0600
X-Gm-Features: AVHnY4Ix-JM5FCWg2fh8KtuGbuZClmx1qOAN3nLQNHVscERKje9jLsvBNl47yHQ
Message-ID: <CAA1CXcDSuD8D8S98=-zqh12CwrD8dATpzaV+usNvgF-RC-anvg@mail.gmail.com>
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
X-Mimecast-MFC-PROC-ID: fO-jCutauMcZPcn4q6QJR5pdKTm2h0gbJnvV9SY-aWY_1779988273
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 2:42=E2=80=AFAM Wei Yang <richard.weiyang@gmail.com=
> wrote:
>
> On Tue, May 26, 2026 at 06:07:38AM -0600, Nico Pache wrote:
> >On Tue, May 26, 2026 at 12:57=E2=80=AFAM Wei Yang <richard.weiyang@gmail=
.com> wrote:
> >>
> >> On Mon, May 25, 2026 at 12:10:41PM -0700, Andrew Morton wrote:
> >> >On Mon, 25 May 2026 08:15:53 -0600 Nico Pache <npache@redhat.com> wro=
te:
> >> >
> >> >> Can you please append the following fixup that reverts one of the
> >> >> changes requested in V17. The issue with the change is described
> >> >> below.
> >> >
> >> >OK.  fyi, what I received was badly mangled: wordwrapping, tabs messe=
d
> >> >up, etc.
> >> >
> >> >Here's my reconstruction:
> >> >
> >>
> >> Hi, Nico
> >>
> >> I tried to reply your mail, but found it has some encoding problem, so=
 reply
> >> here.
> >
> >Yeah sorry I didnt properly configure my email client after getting a
> >new laptop.
> >
> >>
> >> >
> >> >Author: Nico Pache <npache@redhat.com>
> >> >Subject: fix potential use-after-free of vma in mthp_collapse()
> >> >Date: Mon May 25 07:38:59 2026 -0600
> >> >
> >> >Between V17 and v18, one reviewer (Wei) brought up that we are not do=
ing
> >> >the uffd-armed check until deep in the collapse operation.  While not
> >> >functionally incorrect, it can lead to unnecessary work.
> >>
> >> So we decide to tolerate the behavioral change?
> >
> >Yes, I believe it is ok for now. Either way we needed to remove the
> >potential UAF. It only affects the behavior if mTHP is enabled, so the
> >legacy behavior is kept. And the uffd case is limited.
> >
> >My future work involves further optimizing and cleaning up khugepaged.
> >I'll make this part of the goal too. My first thought is to do the
> >revalidation at every order (between the locks dropping); but that
> >essentially pays the same penalty... I can't think of a clean solution
> >at the moment.
>
> One way come into my mind is add a @was_uffd_armed field in collapse_cont=
rol
> and updates it in hugepage_vma_revalidate() when latest vma is retrieved.
>
> Still not elegant enough.

So our issue is that userfaultfd_armed is at the VMA granularity.
Ideally we want PMD/PTE granularity, but we only have that for wp. I'm
just still investigating all the nuances of uffd and its interactions
with khugepaged (something I've been meaning to understand more of
anyway). But from what i understand so far we actually can use the
bitmap and the was_uffd_armed to optimize this further. It solves the
issue and has a rather small race window, which can just be handled by
the revalidation later on, probably eliminating most of the potential
cases.

IIUC, filling a region with previously empty/zero pages is only an
issue for MODE_MISSING and MODE_WP with WP_UNPOPULATED set as well. I
have a work in progress commit to improve all this uffd handling.

I think what i have is a good middle ground. It improves the current
functionality and closes this gap we have with the new mthp_collapse--
best of both worlds. If the race window is hit, we will pay the
penalty, but that should be greatly reduced. I will send out an RFC
for this targeting mm-new once I have everything verified and cleaned
up :)

Cheers,
-- Nico



>
> >
> >Does that sound ok?
> >
>
> Not sure. I can't imagine the impact it would have.
>
> >Cheers,
> >-- Nico
>
>
> --
> Wei Yang
> Help you, Help me
>

