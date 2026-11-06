Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793985930;
	b=SVHx6Qy9DWnutuBwaUQ2uBhI291ZT1tnqAficJB8wQUBMwYw1kNckNgDEtXYZV3LRrAk
	 Q+RQrT5EVAzDVEoFMOn5gyQNpAsJjFwyTedyiUlLNMvKq1oSyMHjCm1D5BnBhON+Xk7k+
	 KOmacn/iWcmQVT0CIxY8u0WDIocGTTAAYc9tV1sSclw0fsVw5xoFIauxaeozh10hu+C7U
	 oXUMb3BIxndQ1FqAMgazJxDo++peitM3dvqLwq8EoELYsBrkueP7DIqPhvhynY12bo2xu
	 Hl7Y6qgVVddrTxqcaqZO3YKdremScvNLca0Cr4m25knTmYWAj9Jhvuvus8aYmYUa4JQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985930;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
	b=EGG3smyElSg3iGB1VBO7iGSn0HMN7YWvLOHvVl2HdHcDikLArlRUT/0HNHtsDRP3sUD9
	 4a0rVii3C9+GwVnDfYNtIFP6e62wqN/RWI9+JMP8y5dIY7OKk2lcSZ8mOV/YTJemgGzxJ
	 j/hSdkCLjJhW8v6d7B8QYECFpgyE4y5PKMmPXBM+kdsFHrCpy4YUT53gMi5q+ykBaxDMC
	 6OUrpY69Y/QnYmF/Rr7Ra3dJE6aMCAcd7HrFWwyJke62STiV9uCXD3NmbVbpm4Kxzgq6U
	 y5mjRl7TmwWMZL/h7/rdOVtnnZPaLMO1VZ90qURhOpE/MFAuzOFLzMN4Qf1wh6MEjkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="ewlCk/lT";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3DE606A330
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 17:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C3DE606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=ewlCk/lT
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4b6266b5bc4so1245e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 09:25:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793985929; cv=none;
        d=google.com; s=arc-20260327;
        b=dbJePidWtLlApEMApD31Yi/dI5U3FG74ivDWda32xwk7y23wFieSTDvYRxGmM1sZFH
         YLvsgJAfQodayntWkR8dg+kEaPrrIE/ysF2lDHcCKbwfPpZi9hNnsb39wqWokWKcafAB
         qb0Z61j8E7ktm0V02sO7gAuUO+hAzCcFlR+2BUzoxW5IMZxjbpig22GYceh9qxchpvHk
         eR0OIfvtHMr7F8SRcyXZkKMZzn609NQEekUkwuyYITbp0FVuqRt8LipAKhjKzMupe/ag
         nzWqMcFAoec2ACdsPs9d1UVQhDnYAlIpo62GqJ4CLEoOIrmE+WkwllRqeGsOr3tNMB77
         Z1Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        fh=99AbH7kfSsqqee5ZUdOgQaoa4PANLuN5D32knYgecaM=;
        b=ddbe/n1gA28y0OLLGSNxBk+2n2Sxg2ClGAtzpI9XRs/e8RIIiKGGDsEWPxAAg4ktjh
         Jkzg499zWo9b3BnDsrDZTjtXXKZisxmiCx3JVO7bd6u9I/V0gkmx82FAG/EWsu//VdWb
         ERFiMhFy8MoxPaTbs5V7I3/HJJHGmvcgCfKkf/XWSIvcuRZFUK6XlpN/3HeuCINNfHCT
         lzgm6fmpesibYvdwBPI4sr6/y/ZuCJ2TJ6F3kgVc7IFvmaLRJgH82wAHxA4Zpss2S6o+
         g6rEF4qx8RP7SNs5qLKoj1+u0fwZ1RN1ZY8rIiUJIkOBSsGYG5hgN5lLVG55RPeuCjK/
         7vxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793985929; x=1794590729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        b=ewlCk/lTPeKUbMBQjEFxdvXeSJcIPNy2WZqd3RMZR0f4utguz18d1I/25cveVMzzFo
         RT7lseKNhSlQDjNcDMIS/DhwPwUeEMuf3p3QA2SuaR2YWynu3cJ86aMi1V+rohgW/ueU
         wdYBRPMGl9NpfqRBybmsYTfqpJAAsq2YUA3wBescnBCrmLOck2h5FL8JtaVfjtntUhMa
         atBGAqnYj6CPAyn1iWAem1TaZV6cbQ3Ry89bYsb3Y3ddSg87IS5+y0t3k5n/93i7MVsR
         kOjiJQAHUQ9kOMLGGhlfbBtqgDPKlex2gLuJNJ4aUDDAFXSR7PLhJYKjThP1OZfQlk1U
         nw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985929; x=1794590729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fUrJNblI2O1hZNjcXmW6nSh+tuR5hYmiGJK5WvnJCM8=;
        b=mIzqITPcZ5SEeZZUN0ESvSczBDUh9YUwGQ34Hzhv2JeV9Bt/7HzxWUxjJ4Nkas2UBS
         BvOBFMLK9CtwyyuC4jx+OU3VHQZa3NbB4/aJYQKKkfPIHunHu1YN0ua4PlUyBYTmnBYz
         1qgCS2ACq/4L3a2VwxV1h/Po8lPue2O6iXlAYF2Q6C5L5v1FiST8p0106CK9stxmnN0f
         iiEP1N5w0NIKHmZX+0vWmxkZ6Sj9OGsQvbZ03v3Ss2sVfT1/DJvWLG2bPK8wYfu6coZI
         n1oXjuHQuGMdjYW0ANrsvayS0d2PbW0xPP28gUk7y1wstK3NS/7yPUJ3AymySDxv2MFb
         cccA==
X-Forwarded-Encrypted: i=1; AKwUvBy5u77Hi/55pJJVw535SlPTGsmam0LO/innZ8QFs64OklDEh/q4mcyt4a/2J2V5FDpo0S4bhnvUNKVLhSbG6UMmPcA=@vger.kernel.org
X-Gm-Message-State: APuU4Z9sLVPyImy89jWRAc4DDO51azS+HpAWT4P9jhlUnpDnkL8PnMbF
	eUta5zCCE1gQbS5z3S1pJ8UanpMQHYkx7h6+AQ83dM2GzyU+YEs23C347JhYs/Z1XX0CpmSjvcI
	CwjZ02r9W6OaEA836bJSXmZNjDDgq5TA7ewGeZTE1
X-Gm-Gg: AYBFou1tnlzROANUrqAUgPfL0pvTNCiRRqr5Zf+jZGB9goJLTwAQE7Z/8duPcgACLjG
	KSdJaRY/HmXUHzN+/35QzQ++mzmlqbXxBe4TGj6zw2OdyX+2dSJmAqBBFa2BJTqycNg+UWQmEkZ
	zlGOq2g2hEiJ3p0B4G8mLHqqNgybGEvOhbCGpd4K84o+4D/YULcl1rrLxuk1HVOmpuPLhSb5lD/
	KuYX1Ms/42y7XK0dqlk6bCP7Ph1bIJrWzhDVzKXl2+gCBVxrQ/tfDS3tga8+IuAFbHBtaOuMuw9
	Kk33RuUUG+TLr1eyS9KhJdcAkcIzuLcYZLJt+gM97X+13+KviDW6kZssjzyfK4FOD8looFQizoR
	9FGaJvX1guzVNYpBH5cdKYJjoL2sE7hllQBie3b/qBElsX0iLzdz+nfvDyhXhB1Y0DepjY2l1+q
	suuFK7Y+lBja+4cL1DM/xLyWpMoM1UE9Vd+IRJ6QPqdCRm
X-Received: by 2002:a05:600d:644f:20b0:4a2:a8c:22ae with SMTP id
 5b1f17b1804b1-4b78a315689mr14125e9.12.1793985928307; Fri, 06 Nov 2026
 09:25:28 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106131829.3228926-1-cui.tao@linux.dev> <20261106131829.3228926-3-cui.tao@linux.dev>
 <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
In-Reply-To: <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Fri, 6 Nov 2026 09:25:16 -0800
X-Gm-Features: AclHuK_zmhBLd-fBLwMoqE-7QVB_DAT0nisVVyTe7VWHd67XlQDn1ECR61povKo
Message-ID: <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Tao Cui <cui.tao@linux.dev>, akpm@linux-foundation.org, dgilbert@interlog.com, 
	mkp@kernel.org, loberman@redhat.com, jmeneghi@redhat.com, kraxel@redhat.com, 
	vivek.kasireddy@intel.com, mst@redhat.com, jasowangio@gmail.com, 
	eperezma@redhat.com, stefanha@redhat.com, sgarzare@redhat.com, 
	rostedt@goodmis.org, vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca, 
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org, 
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org, 
	phasta@kernel.org, joro@8bytes.org, will@kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com, 
	mason@kernel.org, aesteve@redhat.com, harry@kernel.org, vbabka@suse.cz, 
	cuitao@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 5:23=E2=80=AFAM Christian K=C3=B6nig <christian.koen=
ig@amd.com> wrote:
>
> On 11/6/26 14:18, Tao Cui wrote:
> > From: Tao Cui <cuitao@kylinos.cn>
> >
> > udmabuf pins the pages of a memfd and hands them out as a dma-buf.  The
> > data pages keep the accounting of the memfd they were instantiated in,
> > but the bookkeeping around them does not: the page pointer array and
> > the pinned_folios array, both sized by the buffer page count, plus the
> > transient folios array sized by the memfd folio count, are plain
> > GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
> > memory, and size_limit_mb defaults to INT_MAX.
> >
> > Charge the three kvmalloc allocations so the creator pays for the
> > metadata it induces.  The system heap in the same subsystem already
> > accounts its buffer allocation;

Only if the mem_accounting param is set to true. We (Android)
currently depend on it being disabled because system heap buffers
don't have a single owner for their entire lifetime (ownership often
changes immediately after they are allocated), and the kernel doesn't
have the ability to switch who is charged for the buffer memory quite
yet. Albert is working hard on it at the moment.

Could you update the message to note the mem_accounting param pls?

> > the data pages here stay with the
> > memfd.

memfd / udmabuf is a little special because it uses shmem for the
backing store, which is already tracked by memcg under all conditions
(except hugetlb). We don't currently use udmabuf, so the lack of memcg
charge transfer for udmabuf is not an issue. But once we get charge
transfer working for the system heap it'd be good to follow up with
udmabuf.

> T.J. needs to take a look here, but I fear that this might break uAPI.

Thanks for looping me in Christian. The buffer allocations cost
gigabytes, but these metadata arrays are only 4MB per 1GB of buffer,
so I don't expect charging them to break anyone. Leaving them
uncharged is an accounting gap though, since someone could spam many
udmabufs from the same memfd and only pay for the memfd pages once. So
this change is ok with me.

> A lot of the DMA-buf resources are intentionally not charged against memc=
g.
>
> Regards,
> Christian.
>
> >
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>

With the commit message updated to mention the mem_accounting param:
Reviewed-by: T.J. Mercier <tjmercier@google.com>
