Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14261E5705
	for <linux-trace-kernel@vger.kernel.org>; Tue,  8 Jul 2025 04:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751949460; cv=none; b=Ta5+PpbB09zE0L+t5L1r8rqmF1KLgij3ygnurGgYkFPyFJdMyUCCWq++geHkHCSMaPWUMQIw3787eofnlpIf0bcF5yFRKuH6tFbNxCLLLr7B2N7HlvKxcBCO/KfT5JDBHSFBRD5oo1YUa9608+QPZNsrX/n8Snr0I8qHGmFjoLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751949460; c=relaxed/simple;
	bh=b5vO5xEj60Grv2Tz4UL3AbMISKiZmYV9+f1qywuzGCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odUcaSdoYJR02d543AMY0l8MRiNxvfPkKONASoAZNWUW1IdHMg3g+S2RQzbk4O+xD92JLZjo+5u6ULgcI+nWe18d1pYBnaSL03A+EUo2rtklBXiADbso7rmaIoCPJDbQRhbSEPzv+JptxScckzaND4OvvAdDnYnr+ZURfafVGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M+sgru4z; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+sgru4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751949456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vcnyx0JysJh5mE8hUE/Z7n/Nl7TxrgUShK09fRyB/o0=;
	b=M+sgru4z0A6dRmZISjJHKXsbQb0boPosfi3ahIen4VHfKpq7s81rPDMENsCQYFPv8fOKx7
	Og6DKZK8ulYU0WFIu9GZzTCgiZ0nUg4JFTLy4Ux/HoGtbd0W7CyRe7viVYfI+WVuqbz2sW
	o5cV0WEjeeyKzJyAohCkZLLyAHDjDbA=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-RWp-7RKpMc6zef-xJANrYg-1; Tue, 08 Jul 2025 00:37:33 -0400
X-MC-Unique: RWp-7RKpMc6zef-xJANrYg-1
X-Mimecast-MFC-AGG-ID: RWp-7RKpMc6zef-xJANrYg_1751949453
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-70e4269de4fso51160107b3.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 07 Jul 2025 21:37:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751949453; x=1752554253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vcnyx0JysJh5mE8hUE/Z7n/Nl7TxrgUShK09fRyB/o0=;
        b=SHkxndYflskn8b5JXDPsY85c+iWgfSc91J7p6uwYvGQ036E3mGJA7SgXbPV5UYo56A
         qwBH/9evm5pKyrB75cEEMc7Z/hhIP2tWUA23Z4wQC/oKE0wfs2J2ZfQ/va8pN6Jwi+j5
         lWPSNs1G8UWDDkG4QN2kOuPDIqiyvnuPBbOUvqPp9Ww/TNQXoRMwHyEKJ7PhCzJcO4j+
         nXwh99yKcNMGVwvvBgc08nieABccYvhvMsqKFe7Mkqk9skKoAacunqIj7+6lUMTLWWhX
         LjdC0eex/yL2UQZD+RH2Z8Or1tibHccmVTEAAI1ScpSwGrQa34n4cMv4L+eLOf4HCD2s
         TCRw==
X-Forwarded-Encrypted: i=1; AJvYcCVt8CZ1IMgmps4ingsfbru4QLo193/2LoO7yjHUhIglHLUdzmTvCV14Y1Rx4YCbvWx4c9QxS2ajEn88twx+3RvMUwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YznmzBmDdpDBvN70pTKfSgTKr/EIEq5T4qdCClP1ZktJWIixOEC
	/jB+wCNcqXWxXge3nmhRSwLQAgtJYYiEfCvBrWYbwevX2OOMtJneEOJRVg+RFPyYKbm0XzThbCZ
	CwI7gHBOY3lJePVBJcdaRwZ2Iit0Kx5K7LqKW2+0XMUq8bD+/1LoVtEVKAGbvzMizdZYvFNmInL
	CcoBfo7PAEMYX8Wdbxzr2tmGPH7XCyhAPLv+AiriKdixM60q0e
X-Gm-Gg: ASbGncusvrwZhT0S9v6o6LDxG6piFhbfR7Tnew1LoLmjxT1+nDSGO9I4M3HDyjGCgrM
	UkfvUUHFiaOcVQ5cqFPkWwMBhCg9HFiFGV3x0eDWXg5QhgQwV9srrcxGjvZ4fH3/SXxfFbnyf75
	i019c82g==
X-Received: by 2002:a05:690c:6f83:b0:70f:751c:2d8a with SMTP id 00721157ae682-7179e37cd3fmr32458887b3.3.1751949452981;
        Mon, 07 Jul 2025 21:37:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbO6Izd1pPXIOqZntc0uu12GmXD8DRIghOcq4/FPxcWuJc0kOyYzeWaxrjFUAr/IBNtPUh2LiSWdlv1rQ3kY4=
X-Received: by 2002:a05:690c:6f83:b0:70f:751c:2d8a with SMTP id
 00721157ae682-7179e37cd3fmr32458287b3.3.1751949452399; Mon, 07 Jul 2025
 21:37:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250702055742.102808-1-npache@redhat.com> <20250702055742.102808-12-npache@redhat.com>
 <2f6d9541-8083-4d3c-a9c1-cba0d5bf98a0@linux.alibaba.com> <20250704141422.359c89146ad69512b9be4902@linux-foundation.org>
In-Reply-To: <20250704141422.359c89146ad69512b9be4902@linux-foundation.org>
From: Nico Pache <npache@redhat.com>
Date: Mon, 7 Jul 2025 22:37:06 -0600
X-Gm-Features: Ac12FXyt1IXC4VHFfBXrxUd6UW59TrJJWs8JdbZTinihEwjJ8-ZwuAsNadFXc9I
Message-ID: <CAA1CXcDkr8itrXiuVq+Tck1hkRwgq-byXCcM3oHqy1dXOhhTTg@mail.gmail.com>
Subject: Re: [PATCH v8 11/15] khugepaged: allow madvise_collapse to check all
 anonymous mTHP orders
To: Andrew Morton <akpm@linux-foundation.org>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	david@redhat.com, dev.jain@arm.com, Hugh Dickins <hughd@google.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	ziy@nvidia.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	ryan.roberts@arm.com, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, baohua@kernel.org, 
	willy@infradead.org, peterx@redhat.com, wangkefeng.wang@huawei.com, 
	usamaarif642@gmail.com, sunnanyong@huawei.com, vishal.moola@gmail.com, 
	thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com, 
	kirill.shutemov@linux.intel.com, aarcange@redhat.com, raquini@redhat.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Cn1lq8n8-SOjWmUijrqlk0RgUFfyDErpRmuXp_8yXf8_1751949453
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 4, 2025 at 3:14=E2=80=AFPM Andrew Morton <akpm@linux-foundation=
.org> wrote:
>
> On Fri, 4 Jul 2025 14:11:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.=
com> wrote:
>
> > On 2025/7/2 13:57, Nico Pache wrote:
> > > Allow madvise_collapse to scan/collapse all mTHP orders without the
> > > strict requirement of needing the PMD-order enabled.
> > >
> > > Signed-off-by: Nico Pache <npache@redhat.com>
> >
> > I am afraid we should drop this patch from the series, since Hugh
> > explicitly opposed my modification of the madvise_collapse control logi=
c
> > in this thread[1].
>
> Well it drops easily enough.  I don't know if it compiles yet.
>
> Nico, can you confirm that you're OK with the droppage and that the
> series is still good without this patch?
Yes that is fine, it shouldn't conflict at all. Although this isn't
the only patch that will need modification... Ill reply to Baolin
inline here.
>
> > Moreover, since we have not yet clarified how to handle the conflict
> > between the semantics of madvise_collapse and the THP interfaces, we
> > should keep the current logic[2] (means madvise_collapse still only
> > allows PMD collapse).
Hi Baolin,

Sorry I saw most of that discussion but missed that point by David.

We should come to an agreement on what the proper approach is, because
if not we'll ALWAYS have this problem and NEVER solve it (pun
intended).

Jokes aside, if we are leaving MADV_COLLAPSE untouched then I need to
make some slight modifications to this series so that MADV_COLLAPSE
never tries anything other than PMD collapse (should be a pretty small
change). Dropping this commit alone does not achieve that, but rather
just allows MADV_COLLAPSE to work if PMD is disabled, and one other
mTHP size is enabled. On second thought this isn't great either as
MADV_COLLAPSE ignores sysfs, so if you have any mTHP size enabled, it
will still continue to collapse to other PMD+mTHP sizes... wow this
really is a mess.
> >
> > If madvise_collapse is to support mTHP collapse, there will be more
> > semantic conflicts to discuss.
I guess a V9 is inevitable, I will drop mTHP support for
MADV_COLLAPSE, and drop this patch too. I'll let this series sit for a
week or so to gather reviews (and make sure nothing else is missing).

Thanks,
-- Nico
> >
> > [1]
> > https://lore.kernel.org/all/cover.1750815384.git.baolin.wang@linux.alib=
aba.com/
> > [2]
> > https://lore.kernel.org/all/23b8ad10-cd1f-45df-a25c-78d01c8af44f@redhat=
.com/
>

