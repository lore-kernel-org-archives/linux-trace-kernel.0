Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95D5443ABC
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949382; cv=none; b=mkFTzzKAj243XBfEEdYz/gyUdSIEVPb4pA0W/jJfxv8xL6u05qJQ1gW9dis4LcgWkNjCGL9zWtJgrl52R6rnVGALYQDrHFUNuTtODvFH0vZ18W/FLSec3v1Kp74RI24nUoUsUL2ZyuV2Vy6GOY+ZElX/dPVzCaqyByTAsdZJ5w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949382; c=relaxed/simple;
	bh=qTGDTcV1p5tJ6HcYmAwz71WaZ4eMKofozyVLBQsC9D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZq5lIfP4/L59SMkz2J8q7cc6mxZJktq7IeHaItifS+YIQhsDQkODR+qtnjGGQtQFeXLpmP98/Q17rL/Qn3cxLySzV1CI694Bb3ugLwVteTxeTeieEwH/7/0Wzc4BC01HJWgTOEJjL/jDP6ui1F6j+OLtTqRZOotn+dChncihc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBdC3zxy; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBdC3zxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751949378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTGDTcV1p5tJ6HcYmAwz71WaZ4eMKofozyVLBQsC9D0=;
	b=SBdC3zxycP/dX697v6+4rdWEGWkoxGc9cGXOXqyqULyCxiqwlnQKdC6iNVGIy4KIAr7vdm
	d0bA2Pn2hTlq6Ig0A3tjIgOXqT5Jpszw0dzXYCiFHx76IX+w5Z8PLNZakK6QRnjyWqTp9O
	88Q0radNrZVpJCfsmKWocOd1Uem7qXs=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-spaXCFppMUKsGbI2VOkuLA-1; Tue, 08 Jul 2025 00:36:15 -0400
X-MC-Unique: spaXCFppMUKsGbI2VOkuLA-1
X-Mimecast-MFC-AGG-ID: spaXCFppMUKsGbI2VOkuLA_1751949375
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-7111d608131so59367287b3.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Jul 2025 21:36:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751949375; x=1752554175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qTGDTcV1p5tJ6HcYmAwz71WaZ4eMKofozyVLBQsC9D0=;
        b=jfPtZ1UgLnkm3gSKbD2NlR+e0E3vfWTWOgKxsI2hCDNjdiUfMXUR37PxIl4ydfJ4/6
         NjcJpqY64A9M6ZhvKjG7fZoVACaCW9tV5okL/AYUKwoC46NLWFE1DDP3UvVgtK/hOFk/
         Hdx9kKjCVhl3Itkm5QyPo7oS1hPSayzvzLMGBTqFsFge7MT7xox792EznG2/991+nJY7
         N8m1V1+J5l1HkySOUYkUqbzigMNlqxcGprJD7mJuO6AmkiFph2sLdwitpeqnkHooy5tr
         wKZEaGY5OLV6QHbcH9O8PqGJ9R8RM7rfX+Hyqwr5oyLNzZXfV4hFsw9iLcMOm8AfPNF7
         mTaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7xCwaemDQ6XgVcH8SW5rOitJxi0RbRSGWRrM3YXmP2GVBNOyINcCca1GHepqTgby+mRs6gUFaAEAsSjJ6gKlgDoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBP1S7mpxTWhA0NhY/z7ECtf34wR6R54KPTlVv2chEXi9Qd+sg
	uIVVe6H8tjINs51EqK+M//CImyYXH2aludsRObNQVXxe6Xn1sDB1vB6VFjLTCCyq/FhwoitRLG6
	eQVoZ4KdlgWhkk/C+p8kfEfsyR/ujnufhci+WOd++2iAnpxR3fl3NISv/XKnreVhCOngOR2keeq
	qZy14yPXdSS3Nl+vymAArFStQoVE5WdEsr6Y0gtWH1D00H42QW
X-Gm-Gg: ASbGncvRw4xSa2KPHLNcZ+ubbR/+mFmzu0rK1bUF5rtfEOoxVCnbp3xNyoOXror6P2d
	LMQGzND///JxDyMlcLYysfdSm83vb3MjqaQKGsdKRzl2If/Hhpa5rfYUqUc2EpKQcLBsnDdjyj3
	rqp5pGfQ==
X-Received: by 2002:a05:690c:30d:b0:709:197d:5d3c with SMTP id 00721157ae682-7166b5f6bcfmr211917647b3.11.1751949374982;
        Mon, 07 Jul 2025 21:36:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEKjtH9W0tf3+AELmduA3IzT90z5Tmph6a1WdgnqS7MTd4DhLb5IlYzFbZ5iH11uL+3BnBYuaaRvKhebjyrKfY=
X-Received: by 2002:a05:690c:30d:b0:709:197d:5d3c with SMTP id
 00721157ae682-7166b5f6bcfmr211917397b3.11.1751949374622; Mon, 07 Jul 2025
 21:36:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702055742.102808-1-npache@redhat.com> <20250702055742.102808-2-npache@redhat.com>
 <9076b4be-8b1d-4434-a72f-d7a829a1a30a@arm.com>
In-Reply-To: <9076b4be-8b1d-4434-a72f-d7a829a1a30a@arm.com>
From: Nico Pache <npache@redhat.com>
Date: Mon, 7 Jul 2025 22:35:48 -0600
X-Gm-Features: Ac12FXyKLeWcmAZn58XkB9-ZGx40IFZEQjeJRnPXwLLAOKV8sSiI_4SNmYsKQgM
Message-ID: <CAA1CXcDuR60EajhvSgGiwbNwTNiVi9-Pv6usSnnQWRC4ND9Vww@mail.gmail.com>
Subject: Re: [PATCH v8 01/15] khugepaged: rename hpage_collapse_* to khugepaged_*
To: Dev Jain <dev.jain@arm.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
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
X-Mimecast-MFC-PROC-ID: 7dCBnLn7NIclpK4S2XV8ElSwtoO-lMvgYOQrH7zhnIQ_1751949375
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 3, 2025 at 11:14=E2=80=AFPM Dev Jain <dev.jain@arm.com> wrote:
>
>
> On 02/07/25 11:27 am, Nico Pache wrote:
> > functions in khugepaged.c use a mix of hpage_collapse and khugepaged
> > as the function prefix.
> >
> > rename all of them to khugepaged to keep things consistent and slightly
> > shorten the function names.
> >
> > Reviewed-by: Zi Yan <ziy@nvidia.com>
> > Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > ---
> >
>
> You are essentially reverting commit 7d8faaf15545 which adds the
> hpage_collapse_ prefix. Since in the next patch you also unify
> madvise and khugepaged, removing hpage_collapse prefix would
> make sense, but then I tend to agree with Liam that dropping
> the prefix altogether is better. Having all the functions in
> khugepaged.c prefixed with khugepaged_ seems unnecessary work.
Ah thanks for pointing that out, I didn't realize they were already
once named khugepaged.

Makes sense, since there is opposition, and a good reason to have them
as hpage_collapse (or collapse) I'll consider either dropping this
patch, or changing it to "collapse_". tbh I didn't realize that was
what Liam was suggesting, I thought he was suggesting dropping the
hpage_collapse entirely.
>
> @David, I forgot where you replied but I remember you saying
> that we should not introduce MADV_COLLAPSE mTHP support for
> now?
Yeah Baolin pointed me to that thread
(https://lore.kernel.org/all/23b8ad10-cd1f-45df-a25c-78d01c8af44f@redhat.co=
m/)
I read most of that discussion as it was happening but missed that
point. I'll add the small change I need to drop the MADV_COLLAPSE
support and send a V9 in a few days (to gather more review).

Adding MADV_COLLAPSE support should be easy once/if we come to a
consensus on what the proper approach is.

Thanks,
-- Nico
>

