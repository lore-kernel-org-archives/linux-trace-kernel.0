Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794524367;
	b=497uwvegtnRFVOlypvuwSKCArJr4+J4rrdje8Na/0Ym0lH0LTXlJr6rzvPOBVKqFozYj
	 2dOba1maRPr4m8UXgHkdSoOLTzX4bu2ATo8C2C4qppklocN5OO5YzfFTXm1L8NdkWOBsM
	 nD93xwvAEz0oZf/w03raQ1aR3QlyEkDC3UpEAJc5poN1kGJEB/fJj63HzZzRsA3hpe7Ar
	 3T1NrussBm1sd7i+rn6bzjEOu7me8r90O4cmreq4o4ZWsYcqy3JH4fMWNTGq+OrSpthBQ
	 69vxKJSYQ5aAFlvL8H+rT6TyxDG7tSCjRx7iwAUUouOaQMnWrquI4A5ghF0pw5ic0YA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524367;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ZsSjLqJE2zg5KnRT+r/w8Y0ianrVtar664vxU/qkfmw=;
	b=BDZYkYFwgcoAFzjxXNjLk0yZb3xkPYw/XfKugHkX/mNRyUfhxCp+2ZNzlMSRfz8/BQic
	 OdlJJxzik15cS0I2CA33VIOW8Zggg6u8HHRbTsnCvzPuXOTFDyqMUXnkEyC1u+xU2iy2j
	 iAcpUmNC+8obLGJdt3FBoX8P3rZxvIIO+ZsaIsID2XbKcv7bGbT+wgkY0OwCkb3hVrar0
	 ZsSjxfZ20JjqTXofK1j06ksY+RFsvS8F37C1YV8Obd0+/8IYa2RbbcqoKfWur9jTD0FKk
	 h1bnONUE4bjYvGP2ADg44lLHiPuzO/BrrOgk6vz2420Mc+D3qW3rOta8FAQmIm2Ie+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NRwZn7LS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D27260A5BDA
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 22:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D27260A5BDA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NRwZn7LS
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-54492d8a988so14431cf.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:59:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794524366; cv=none;
        d=google.com; s=arc-20260327;
        b=N6sHv0JF2KyNGqGelP3Emak50M9iZlgTbl+PNOcQ7BvH/v+e6Vk4WKweTZ8Tpb1lSL
         u8G1uQ0janiqBm1HibpgwLIvtJiVtHDrmUDjB6YGnD/NfQAiOfPDLipWWggrMXMFpUil
         2gtU3vn919AdyE8cAqSccp1tAfp5FupORZ0IEmNB3LiMZN6/jwc2o/jSQcUihUrqRstP
         WJ2PmCFJlAGW8XY5HOLrd5m9Ud/ACVHlSN6lcvk2ta4HZUOJTlyy6URGx946b63Pj4BO
         bONDohWTvLl0uvSSrgFxUVRni3il8smfqXpH7qRa8ciruDofXzaWSb7dYngOdSSc4weO
         8C3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZsSjLqJE2zg5KnRT+r/w8Y0ianrVtar664vxU/qkfmw=;
        fh=0S017pvkerXOh7FLHM2Db2tQU0MPXIVFkp3HLGpxo+U=;
        b=HPj0uTvDuO6mvloPODgP6Rm6wWquK7KZull2keowOhszjuymF8m5e6lzDILZkXcEDb
         SL6tzimOWDzolt0Yt6cdc53NMuVzgaS4zAliEQajLhmVf6C96stEfVze+dSM/a+c4JQT
         RaqN7TpdvVLklgz5HqwGSe+7DI7aKZn701b+YbvgFkOhoCA3zbgs3N+QCPLXwU9gjbmu
         yssmQ/i7J0aLIcOvwMhG9aReqLcOYLfB6runkAzMk5mqiS2qDCvbMTqnkBq8KCxMTO5M
         iszm8Vbzx958TYM+W6EoFzp44jRH6DoPw7SdISwy1SNrZIXR5VDOb+dYQyv2ZdL9WRh/
         WLog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794524366; x=1795129166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZsSjLqJE2zg5KnRT+r/w8Y0ianrVtar664vxU/qkfmw=;
        b=NRwZn7LSFGPxX3NtvX3Y7sFS2xItJxs0r16isV8pawPhbKhy9B1louAe6i72I/3N2P
         UniuOLDEYa6TVxl3FcjF+9fSBbbE6bEf8pNLK7WB6YbLd65ecGFIrlmSNUlXyyjpJ8vf
         ohFZkafmiEpB/6QdOpX3lVI6mIhmWqe6T/e+zzki4c0Prg7mBZOQ6GWxsjlHiixSscXX
         A2EnFSV9dgOF5i1DaoquT+PzW0SfWsEl1uNHbNVAhiQrzGs9Og4DdpgCz+Yv7QqLqs4H
         +ukKqWpoNHIUUbHnQO7MzVkr7o1J4ZHyugW+l4ektn2xy8z/xNEMyuKzLtfe2JdeXdLm
         aMkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524366; x=1795129166;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZsSjLqJE2zg5KnRT+r/w8Y0ianrVtar664vxU/qkfmw=;
        b=eAK64I3HGRgIrPfCNrfLC6IifGLWP8RWUs2o8sM1kxtbeeXCEKyED57SS8VP2iI27q
         u71leHypB1kVb0KnsFvNXFJvvoWCgJFUjbw/9Bq905shCqDdsz3lsSRPe0A/VDFX/Dae
         nhTEbupH1pWFGPLewpaCFSo0VaFNmufl/vpmLk+9iwUc+Ksx3eqZFm1cy31Q2WC29RxW
         YskUOOe/dX59C1j3Xg3cVcu70DLv3hUnEguWZP8QZsDmPdZ7NCtPRmWntf80mX4cKlLu
         eyNJLSSIbO7f9UHq27S2edlGMkx85EqPVAJnVdcIJJt1JolbFoeFoURh7Ik+Qt/a+qfD
         WoZg==
X-Forwarded-Encrypted: i=1; AL+hErE1EI22FcdXgH9Zup42YwRjsG3/xGIfuXFmK3DkuNNWK9u5vXdyj/lx9mmmU17uvMsGDYklUOKdKEo2KaWI13uRCZw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/yoZrarP4b4j6enfNdZUAgPb9/xgSIlaq1chU75wth5a2m73eD
	515wPJ/SKRMBbBQ43U52kuWcIRNIP2Ezk+aBY0RZF6o1eQ35njnkGGerzzhPwBbKsySN+m7aSUH
	c56DqwZSZ0nYtq5ELWLrNj335zkiTvyE920CkRTFU
X-Gm-Gg: AYBFou2fqX+EaG8cC9wFCySdQv+XoQm1vf+rfTGuV/rNXLzYOyKFLpZBHu7QGgFy35b
	whNsl0kaeAZMNEdWfvRx8kxwjj9Mz5Tu6USM6hmB/eT/pt2RjNUD3l5/3zrE3DqRK/IBaimdHKo
	nRrg5LNFwOUpf2UwwYysClgkD6ydn2anSnlioVtIKii8PpkPjvIe7biFrGTkIp4bvI6ePMsWNnG
	Gi/71o3C3TJmXjorMNaPdh8U595w7xRo4wFqQiIVY2q/xgVwgGR9ALFp9TaBLXMS37FB3wkEJbZ
	IyksQE+2F7x5wKWhgXGP7KsBlSKNoLHszMnCwZt4roeKDt0sbKS4nyG0ODYyTtdEvYsY+K3EnVF
	SauR0zX5Y5MKcrs6/F2NI8bPoocw/AvZCuueEYH168yesWUWQlP8VxWZ5/RIjolVpe4Q=
X-Received: by 2002:a05:622a:98c:b0:532:eff9:ca08 with SMTP id
 d75a77b69052e-55afcbede04mr2871271cf.12.1794524364998; Thu, 12 Nov 2026
 14:59:24 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103223025.2482227-1-nhuhuan@google.com> <20261106085019.90487-1-lizhe.67@bytedance.com>
In-Reply-To: <20261106085019.90487-1-lizhe.67@bytedance.com>
From: Huan Nguyen <nhuhuan@google.com>
Date: Thu, 12 Nov 2026 14:58:48 -0800
X-Gm-Features: AclHuK_MjdqInx2d6Ru3Fw1h0wqnaU6otNi9RKFyMPSDK4f5OfZNd4Zh3wXDlV8
Message-ID: <CALwWd5tttbaNWoaXnPZjHFgYhG8yMyT67_9nhRKN336EHOVhqg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 0/3] mm: use non-temporal stores for demotion
To: Li Zhe <lizhe.67@bytedance.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, 
	alirad.malek@zptcorp.com, anna@kernel.org, apopple@nvidia.com, 
	bharata@amd.com, bp@alien8.de, byungchul@sk.com, dave.hansen@linux.intel.com, 
	dave@stgolabs.net, david@kernel.org, dimitrios.palyvos@zptcorp.com, 
	fvdl@google.com, gourry@gourry.net, hannes@cmpxchg.org, hpa@zytor.com, 
	jackmanb@google.com, jic23@kernel.org, joshua.hahnjy@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, ljs@kernel.org, 
	mathieu.desnoyers@efficios.com, matthew.brost@intel.com, mhiramat@kernel.org, 
	mhocko@suse.com, mingo@redhat.com, nifan.cxl@gmail.com, rakie.kim@sk.com, 
	rientjes@google.com, rkodsara@amd.com, rostedt@goodmis.org, rppt@kernel.org, 
	ryan.roberts@arm.com, shivankg@amd.com, sj@kernel.org, surenb@google.com, 
	tglx@kernel.org, trondmy@kernel.org, vbabka@kernel.org, weixugc@google.com, 
	x86@kernel.org, xuezhengchu@huawei.com, yiannis.nikolakop@gmail.com, 
	yiannis@zptcorp.com, ying.huang@linux.alibaba.com, ziy@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 12:51=E2=80=AFAM Li Zhe <lizhe.67@bytedance.com> wro=
te:
>
> On Tue, 3 Nov 2026 14:30:22 -0800, Huan Nguyen wrote:
>
> > Using non-temporal stores and prefetching on x86 bypasses CPU cache
> > allocation, protecting active workload working sets and improving
> > demotion throughput.
>
> Could you show some real workload numbers for this? I am wondering
> whether the reduced cache allocation and improved demotion throughput
> also translate into visible application-level benefits.

I do not have direct benchmark numbers for non-temporal demotion with
this implementation yet. As far as I know, Alirad and Yiannis (cc'd)
are currently evaluating its real-workload impact and may share
results once available.

>
> > - Memory ordering:
> >   Add a wmb() barrier at the end of folio_mc_copy_nt() to ensure weakly
> >   ordered non-temporal stores are drained before page tables are update=
d.
>
> I have not looked into all the details here, so I may be missing
> something. But before migration completes, there should eventually be a
> publication step that makes the new folio visible. In theory, that
> publication step should already provide the required ordering before
> userspace can observe the new folio. So I wonder whether the wmb() in
> folio_mc_copy_nt() is really needed here.

On weakly-ordered architectures like arm64, the publication step
indeed provides the required ordering, because smp_wmb() and
smp_store_release() emit real hardware barriers before the new folio
becomes visible.

On x86_64, however, those primitives compile down to a compiler
barrier() with no CPU instructions, since x86 assumes TSO. Because
movnti bypasses TSO, the standard publication barriers do not order
non-temporal writes on x86_64, which is why folio_mc_copy_nt() needs
an explicit wmb() at the end.

Right now __HAVE_ARCH_COPY_PAGE_NT is only defined on x86_64, so that
the wmb() is effectively x86-only today. If another architecture
implements __HAVE_ARCH_COPY_PAGE_NT in the future, we can move the
wmb() into an x86-specific scope in v4 so weakly-ordered architectures
do not pay for an unnecessary barrier.

>
> Thanks,
> Zhe
