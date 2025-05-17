Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72AEE14EC5B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 17 May 2025 06:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747464487; cv=none; b=lIajt+Z5q7/Pr/CbMrfzserbB5lulAuj0O43QWLVgd+XduAVHJiOLLhLMP0JoHY8QbhQiaooeM0I6IKgw1ANnzCs7sPe37LrwUH+bYZeA6hovunTrePgptJriDstGkoygIKnFGBzPVAnL9N/J104UfpQS5y+t4LY8gb3HuZJrQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747464487; c=relaxed/simple;
	bh=xoefSDHoQ2MJkgHc9vHEmIq4AuLZsAA319tBfQ3WAL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4AdRC40Z5nVIy+pHTGfIaFauj5+P+nrOyMuqIi4zbkABgDgOzNVkdQxAI+9iMRGIgi7gLOFURtTD/e3E+9rYif1zPG3UtYZQ8N1ZleXJpGhZtiGB6riQ3jXgPl+DCSInoO6FmxCfyKobur4QKqJzysEzQ2fanha/7b4+vX2kmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dl+WyXLt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dl+WyXLt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747464484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xoefSDHoQ2MJkgHc9vHEmIq4AuLZsAA319tBfQ3WAL0=;
	b=Dl+WyXLtxx32GZORrm5EDLTlkAXRq8u0OFl5v8sZOh1Ak6+sihX9ehrk6sZAsJ+5evMcX1
	+WGHxHPSwhOmT3tRkO0bzkn6RsxS28DSw8tSja8TjLxRVokX7JzbhLIDfRbTINagvnoJRx
	yST0Ar98MW41yLhuuWL5D2+UF0jPmlA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-103-fMHS4CrxMR6rCCsardyJrw-1; Sat, 17 May 2025 02:48:02 -0400
X-MC-Unique: fMHS4CrxMR6rCCsardyJrw-1
X-Mimecast-MFC-AGG-ID: fMHS4CrxMR6rCCsardyJrw_1747464482
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-70ad3a91ab2so40850417b3.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 16 May 2025 23:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747464482; x=1748069282;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xoefSDHoQ2MJkgHc9vHEmIq4AuLZsAA319tBfQ3WAL0=;
        b=qRDPX2k5H7Vyct8mzbzyRnWjLknx6I0o1ay0C6Cd1f2lsDtGx5ixe1QYP2CmcidkEa
         +estLVOT+XfiDp2OD3DqAtycQF+Z+268roKXEWGvuyw8e6C9IqqWLGRzN9uG3nnh/d/I
         2eG4s9F85skzE7pbo5jo+6S9jl2Ny/52XZ4Ufh/Zlw8Pu9ojUbBcqONHIqa/m7cMV8nx
         6Jyyds+1N+BiGGyL256G8h6MPMy7hsyK0exemOMApbs92ULpipLIu8hiwbHx1k/m4SsL
         GgzOPDyAposH5WsFC7PI/f5UKIivNMU7XR71UgCJIr6HkYxQAG6kPx9kKq92+5mEkglz
         jO5g==
X-Forwarded-Encrypted: i=1; AJvYcCWJZTWUSqOdYYWkYCIIhhZMPJ2EdSLr3RmZOZ4gPc8Y/1wgWeXs0tLaf1CmggvY9R0idIz6kSaTTkRnF0oJCtHKeuM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3JJ+x/mWXx3GD9oP3P5a/nsV7uc3FcaugHdNfravIKv7+8Zyn
	dMb9SNQZujzfCEm3I9Fb+O6WzNRH8qiikU5d7WvQOIx9yKi7wW5yZC/m6wzWLLFwn8gCWTupFuv
	GAqH0sMsgaBDQCO3lyF2Qd6BGLJqIZ33bO0x70h8yU11yj9gS3qboriZnBoJv84dpOwZdMHjiQN
	dsISWbKME6aoyGBPiSSNomNZAZUCRSZ8mqAr2dYFgTHg+e5HI/
X-Gm-Gg: ASbGnctGaj4wLLjkNt/X0wYpd8qmOFDgaMe8F7gutruzNSBFfbJtdBQQA6P6mU9Jd2f
	0eHTj3Efus3omtsRKkVbGVMcQYFcddd0lQzFTEyz4yGNqFHRVZNnfQJU4sjXgpWuWK8NzMfI=
X-Received: by 2002:a05:690c:3:b0:707:dba5:2e44 with SMTP id 00721157ae682-70ca7ba0d8emr93966687b3.30.1747464482214;
        Fri, 16 May 2025 23:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNMmgN96ppS4R9A56rSKNlS+EhkQE/xJYfY1RrmT+t29R40GTIUMkgVA9ErgvZMyurnYk8q2A+N4SmrSywNXI=
X-Received: by 2002:a05:690c:3:b0:707:dba5:2e44 with SMTP id
 00721157ae682-70ca7ba0d8emr93966347b3.30.1747464481896; Fri, 16 May 2025
 23:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515032226.128900-1-npache@redhat.com> <20250515032226.128900-7-npache@redhat.com>
 <9c54397f-3cbf-4fa2-bf69-ba89613d355f@linux.alibaba.com>
In-Reply-To: <9c54397f-3cbf-4fa2-bf69-ba89613d355f@linux.alibaba.com>
From: Nico Pache <npache@redhat.com>
Date: Sat, 17 May 2025 00:47:35 -0600
X-Gm-Features: AX0GCFs8Yc5oWY97Oxpxk79pJ4fpAxS1pc4Oj0m-wPhCk0WUp_t3490TgtutRYc
Message-ID: <CAA1CXcC9MB2Nw4MmGajESfH8DhAsh4QvTj4ABG3+Rg2iPi087w@mail.gmail.com>
Subject: Re: [PATCH v7 06/12] khugepaged: introduce khugepaged_scan_bitmap for
 mTHP support
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, lorenzo.stoakes@oracle.com, 
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
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NHkiy28ciIvVLcOwD7owVSbiy9irNSz1IMag1Kfw6h4_1747464482
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 15, 2025 at 9:20=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
>
>
> On 2025/5/15 11:22, Nico Pache wrote:
> > khugepaged scans anons PMD ranges for potential collapse to a hugepage.
> > To add mTHP support we use this scan to instead record chunks of utiliz=
ed
> > sections of the PMD.
> >
> > khugepaged_scan_bitmap uses a stack struct to recursively scan a bitmap
> > that represents chunks of utilized regions. We can then determine what
> > mTHP size fits best and in the following patch, we set this bitmap whil=
e
> > scanning the anon PMD. A minimum collapse order of 2 is used as this is
> > the lowest order supported by anon memory.
> >
> > max_ptes_none is used as a scale to determine how "full" an order must
> > be before being considered for collapse.
> >
> > When attempting to collapse an order that has its order set to "always"
> > lets always collapse to that order in a greedy manner without
> > considering the number of bits set.
> >
> > Signed-off-by: Nico Pache <npache@redhat.com>
>
> Sigh. You still haven't addressed or explained the issues I previously
> raised [1], so I don't know how to review this patch again...
Can you still reproduce this issue?
I can no longer reproduce this issue, that's why I posted... although
I should have followed up, and looked into what the original issue
was. Nothing really sticks out so perhaps something in mm-new was
broken and pulled out... not sure.

It should now follow the expected behavior, which is that no mTHP
collapse occurs because if the PMD size is disabled so is khugepaged
collapse.

Lmk if you are still experiencing this issue please.

Cheers,
-- Nico
>
> [1]
> https://lore.kernel.org/all/83a66442-b7c7-42e7-af4e-fd211d8ed6f8@linux.al=
ibaba.com/
>

