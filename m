Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794231876;
	b=Lpg5mNUGalG39F0teXwtPy2i3C0Io8PJEVjTyOMVU8yYgEv3KGf65iHpPqjiGWbcj9cn
	 PQtFar+PGOKh4Ab2ouXnVdTJrhksjcdD068HHLOck7+ws09l7sPl+KWEOU6w8R/wU3VPB
	 tecT4nt5RTEmIxDNFRG8q36LEFHIKVbQKUbiyvzBMPUJhjnvkWEH8kKLESQOq/VWCgN6D
	 geKK8WXmFJN0npndWjfuWRdRWKD0/oV33sjln1nmETrdL9NS6SUoqLavR7nMxip22LF5t
	 g5AIa3Z5jYS6m2TNc85xUEFfMCH4jE1MidC24ddmrGAtLs1TLd2Q2jmtSE0Hh0oabBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794231876;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
	 Content-Transfer-Encoding;
	bh=bghOY7pp4PqTwolmTpdD1zvT8+4Tek4EN2nSOV+gjQQ=;
	b=aExQed4g+4RO6q9EQGb+WSZHOnJY0U+3AJFmVG7Flblq4M8DOPx8EVyt/2PnDQSA8uLM
	 LoDCCLE61m2YslmlwMq/pNPFx4TNt3e/3/P9TUE8KASYfCBZDluUZVQnDb3GVDqNSVAcM
	 csxUoCW4PCXoVW0pq0vYFPEAkjrQkl4t8mIzJChCqYaMeO/SlGVgUS50PPcXTUMQTlDal
	 I9viOGEN/wDJhAYnSOoJRGNk31tdyfwbw98MqeLAol1ZKS3pHkI6yMmNqLw4RugO3+q9a
	 qYBJeYM8nPTNNnNhndWSV5W7elH79fKfQpyxTkIFDNN4+0HoIzxp1hrPjl/P4RLMJEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SZPy24aW;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F38E606EE84
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 13:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F38E606EE84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SZPy24aW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794231875;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bghOY7pp4PqTwolmTpdD1zvT8+4Tek4EN2nSOV+gjQQ=;
	b=SZPy24aWpqc1WlWDYt+38IRFmZ8EuSUYMVEBBz9eluIIE6RM9eMQyntpE7nG5/jxi6MVEI
	3mPKpGxRMf6RLOo0Wm7XqSQ0+Xvp5lPWjvVSGL8cw5TEajzn1AyWI6nsRQ8S8efftPgakC
	R9vy8to6Svdl3YAp+2mKdzSJwTG22Y8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-c06SYxg1Mrymwl3j0QfSWQ-1; Mon, 09 Nov 2026 08:44:31 -0500
X-MC-Unique: c06SYxg1Mrymwl3j0QfSWQ-1
X-Mimecast-MFC-AGG-ID: c06SYxg1Mrymwl3j0QfSWQ_1794231871
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-843cf077bf7so1159368a34.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 09 Nov 2026 05:44:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794231871; x=1794836671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bghOY7pp4PqTwolmTpdD1zvT8+4Tek4EN2nSOV+gjQQ=;
        b=uzc544T7Jyw9PMzLKZwxAOmnxNM68RnH1eKDTzO6nM9pkRueVAMvyxNcxr/ZRNWUmr
         NRGMNKSwgqFHsDMMHfgVMs9GPNBgjFBIIqfcswI3B84d+uHiCBP0MKFkphVq716Ji7n1
         YuMEZ5ti4PODbNscz90xpGWmSYGrKK+61hhLwGxpkFISgj0o9R96JhTK9a44AHDb2xgN
         nQmxLlbcPudirjF2nPsymA4X1uKUezlbaJ3/wGybc2Ub/RnDwxqqIEPmPlBypAWDvf+Z
         eqnrejvJhw9oE9KH5QKLydvW/M5Y/us8T/DHYZz0Np/odSiDCOYX9NJSJuHbU5C+KljV
         0Beg==
X-Forwarded-Encrypted: i=1; AL+hErH+wp9v7d52hG2T5fwH1su/b6v+R0zQ83IQnp0mequA/jr7t1glaNZCMxQHpNAu2G3I8QdfpZtjnCoFStZZOFuNy8Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7UYB/5DmNZ1AjIHVnlbXTxsXG83EuZfaGg1YXI5ZVDFZlzH1B
	x+396o2liQ+oFLaIfVLSNyf6LiqZzqwOJJEYSQ1UdD7+gIlfBLqXrbsWX6Sn4tVsqKt0zPaMtah
	Se6bJtctHp62H8KLpLrxExRgQtcKoWq/6b2JlIbWJtXIzumdV3Shn9rEGqNKaVxEglt3oI8ReNJ
	YNawCBVQEaTE6HzmM/E0WjWFrjTmfxBg5Zw4lVCiNTIoNY8w9O
X-Gm-Gg: AYBFou2ujJ5pbg40TFzfdqsAW8KaF9vau8S03SZejYPgSc1L99jbzAMS75odmI5v/YK
	MUzvtjuNWSc2vez7Hk1aSlTnFny3ahqTpIRJUvbnTxSKFfoTk6UFrUnKZe9Oh4cTeQwc4y4z2dm
	MRtqWrADzQMsyvAO7c+E1MWRzY0qV4+4fvOq8SzTFZvXPpEjgDZpLJE4gc
X-Received: by 2002:a05:6808:4fe9:b0:4d7:17d5:6c9b with SMTP id 5614622812f47-56814022659mr2709801b6e.9.1794231870762;
        Mon, 09 Nov 2026 05:44:30 -0800 (PST)
X-Received: by 2002:a05:6808:4fe9:b0:4d7:17d5:6c9b with SMTP id
 5614622812f47-56814022659mr2709756b6e.9.1794231870169; Mon, 09 Nov 2026
 05:44:30 -0800 (PST)
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
 <1e18fcfd-785d-43cc-afd6-d181bf8305eb@amd.com> <CABdmKX0nCB2hT+iMh=BB-nC=fUBPof8YvjvO-gtEw+zcHZgvZA@mail.gmail.com>
 <b0f530ef-bbfd-4112-aa51-82fdad6c4ba2@amd.com>
In-Reply-To: <b0f530ef-bbfd-4112-aa51-82fdad6c4ba2@amd.com>
From: Albert Esteve <aesteve@redhat.com>
Date: Mon, 9 Nov 2026 14:44:17 +0100
X-Gm-Features: AclHuK-kxgj3T37bjFOZ7HtSClpdxsaDMPyjW53dccz7zE1_ZSRFcURRmSZwzSI
Message-ID: <CADSE00L3AfcnfcboK1TdPQiW7ZW1KpxG70b1oyWFqpLciOG6ng@mail.gmail.com>
Subject: Re: [PATCH 2/7] dma-buf/udmabuf: account the page array metadata to memcg
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: "T.J. Mercier" <tjmercier@google.com>, Tao Cui <cui.tao@linux.dev>, akpm@linux-foundation.org, 
	dgilbert@interlog.com, mkp@kernel.org, loberman@redhat.com, 
	jmeneghi@redhat.com, kraxel@redhat.com, vivek.kasireddy@intel.com, 
	mst@redhat.com, jasowangio@gmail.com, eperezma@redhat.com, 
	stefanha@redhat.com, sgarzare@redhat.com, rostedt@goodmis.org, 
	vdonnefort@google.com, mhiramat@kernel.org, jgg@ziepe.ca, 
	kevin.tian@intel.com, axboe@kernel.dk, linux-mm@kvack.org, 
	James.Bottomley@hansenpartnership.com, sumit.semwal@linaro.org, 
	phasta@kernel.org, joro@8bytes.org, will@kernel.org, 
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org, 
	kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bobbyeshleman@meta.com, mathieu.desnoyers@efficios.com, robin.murphy@arm.com, 
	mason@kernel.org, harry@kernel.org, vbabka@suse.cz, cuitao@kylinos.cn
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: y5YawY8wN58LP-uy3xZ5KfLK0wPOxfjYhON1Ilj2kp8_1794231871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 11:56=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> On 11/6/26 18:25, T.J. Mercier wrote:
> > On Fri, Nov 6, 2026 at 5:23=E2=80=AFAM Christian K=C3=B6nig <christian.=
koenig@amd.com> wrote:
> >>
> >> On 11/6/26 14:18, Tao Cui wrote:
> >>> From: Tao Cui <cuitao@kylinos.cn>
> >>>
> >>> udmabuf pins the pages of a memfd and hands them out as a dma-buf.  T=
he
> >>> data pages keep the accounting of the memfd they were instantiated in=
,
> >>> but the bookkeeping around them does not: the page pointer array and
> >>> the pinned_folios array, both sized by the buffer page count, plus th=
e
> >>> transient folios array sized by the memfd folio count, are plain
> >>> GFP_KERNEL.  A 1GB buffer costs about 4MB of uncharged SUnreclaim
> >>> memory, and size_limit_mb defaults to INT_MAX.
> >>>
> >>> Charge the three kvmalloc allocations so the creator pays for the
> >>> metadata it induces.  The system heap in the same subsystem already
> >>> accounts its buffer allocation;
> >
> > Only if the mem_accounting param is set to true. We (Android)
> > currently depend on it being disabled because system heap buffers
> > don't have a single owner for their entire lifetime (ownership often
> > changes immediately after they are allocated), and the kernel doesn't
> > have the ability to switch who is charged for the buffer memory quite
> > yet. Albert is working hard on it at the moment.
>
> Good point, making sure that Albert is on CC as well.
>
> So basically we not only need to charge the backing store of a DMA-buf to=
 somebody else, but also the housekeeping overhead.

For system heaps the housekeeping size is fixed at creation so it
kindof fits the reservation model nicely. We'd only need it to account
for the overhead (as part of the MEMCG_DMABUF stat probably).

>
> Mhm, this here also complicates the charge transfer Albert is working on.

The transfer would just move the charge as a single unit. But yeah,
the complexity will come from lazy exporters or any other exporter
where the bookkeeping grows or changes.

>
> @Albert not something we need to take care about now, but please keep tha=
t in mind while working on that stuff.

Noted. The issue already exists so my series does not make it worse. I
will note this for a follow up series.

Thanks for tagging me!

BR,
Albert

>
> Regards,
> Christian.
>
> >
> > Could you update the message to note the mem_accounting param pls?
> >
> >>> the data pages here stay with the
> >>> memfd.
> >
> > memfd / udmabuf is a little special because it uses shmem for the
> > backing store, which is already tracked by memcg under all conditions
> > (except hugetlb). We don't currently use udmabuf, so the lack of memcg
> > charge transfer for udmabuf is not an issue. But once we get charge
> > transfer working for the system heap it'd be good to follow up with
> > udmabuf.
> >
> >> T.J. needs to take a look here, but I fear that this might break uAPI.
> >
> > Thanks for looping me in Christian. The buffer allocations cost
> > gigabytes, but these metadata arrays are only 4MB per 1GB of buffer,
> > so I don't expect charging them to break anyone. Leaving them
> > uncharged is an accounting gap though, since someone could spam many
> > udmabufs from the same memfd and only pay for the memfd pages once. So
> > this change is ok with me.
> >
> >> A lot of the DMA-buf resources are intentionally not charged against m=
emcg.
> >>
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> >
> > With the commit message updated to mention the mem_accounting param:
> > Reviewed-by: T.J. Mercier <tjmercier@google.com>
>

