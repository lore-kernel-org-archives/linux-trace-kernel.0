Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150B33B7B6E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 23:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406107; cv=pass; b=Qs+p5fsuAeYmw9jNisXUbQVW0a2dHDYJTvE7VDHD6FXVSalivNusuOoQKMvkZ5o1WUF7/Iy3YaCcO8nL6vcOnPwntXop2a020vaakqmFtxFRbcdtsdc+818M/u3IedZ3Ovq9IyKe4q7eHVLNqJDpcoL80iyeBTEyE+8pAySMDBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406107; c=relaxed/simple;
	bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pk9QIq6S64B5bugnyFOy2xELl4MiNUEMRf/hG8P0GpHtkCC2IpFyXGI3YoWszPKav/duWMvjiqG40g+pHtynlkrp17vw9cp3BSAD6Y+VyEPu5kwTOX7tcwPtbifOev4CumQCc/9vcO9Yx3JpvbbyD/aLZm2Lma5c67LaCT+ZyIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OjX7BtsK; arc=pass smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OjX7BtsK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4996e2575dbso28135e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Aug 2026 16:55:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786406104; cv=none;
        d=google.com; s=arc-20260327;
        b=jxLggRNlte/JwknyFfU5rvLbQb0rSaeNIawoKy//RcKmiCnyb4JezxqqTXgB9dHON+
         31vEI/MNlRNBChu+Kx8K0FqhjzwnkdUUFr2DJc0dmLr+aKgwbzV0vg9N6nF0DeDxh+Ei
         t1/4gQuhcoUiDyfFDs4uG2gn+KoOmMUldxgvO0y49Mi8o42Yni1w/iG2YR9kYGlaoy90
         Y02Kft0D3UxEYwWiiVbNv84WXSE64zhRAA0G9WZvlzomIVwQBoiud+6fHnCT21Eh/uBT
         /u8MShJyeJ5uledQjdMw6TUH21zisogbg68LqGmcWR615DoNMUBA4gcvgJxBh+0hzxMn
         o4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
        fh=QIXxbH8aYBAXQ4UEMuth55hPCb4aGSsWp19qv+i4ng8=;
        b=SeDPkD6z2TBGHkVp0AaHV3tX+Z4j272wBPn3HG5nQnKWm+zbWZi6CphlErqPcbG2Id
         YCl3+LCgJHQw4rF84eZ+M2eu+BRNZLk4FBMW+9acP+ReQyQBLoCH4yyH+jy82OAuj9Zu
         emnz3jeCJgDCpimOHyPu5qSWLCgawvK1jt+OTnSnD4C4mGmy1CAs23VPXo/jkcHRVOnp
         FfPvJLfYZqp4sn0Y7jQhZ77W/aoF7PiNgDg6CfGqYXErpl3lxDbF51HINXxx3MRsyQ4b
         J6cSw5TiqjJ7dTogcMHOXei4NfnjADPzMjU8T7tmrY+yhmHNIU61krfYq4b3lMmVqKwr
         nuig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786406104; x=1787010904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
        b=OjX7BtsKwY60pVyVrTrrHI0fU61YegsIQzJMRGtAP01JyYgK10M6TgPwvpwx8ZmZaV
         o5+SR6uCIrSKHTFsCz2CQFhd+NW7C+KHGFZ0cdG6hT0eSzV83VSuDNBckbZrnqPiC0AD
         +/lwRtqp0GugZQhCdn2wqatnbVJGqG48jaE4aRvjYu3ZobU6AlSzKuvxhG4mc7mhTH/X
         6n/Y0iE4FKNaxvPb9bLDX8zTDcpSRkg112Kt4eE1uCAtJdXBMUePj1pJ26vfzIAZxQ+r
         QN9ZelHXB07crWb69eZLO6ZV94Ahc5EAnloqCf2G1CUeLUDaA+8lRNRtO2Ed5L8wYaiF
         r9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786406104; x=1787010904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JHfanZgIA8mK03STIk1FeUn57Mhb7JG9av6AGKnMHws=;
        b=Gc8SsY24MvteJ41WuQ7mjzc0dYuVfEJ5sXKIKXhe9uWbK8CLgsSVYATeQaqVp5dNBf
         UtAgss0T5KQNXnLwBvEOEYWclEYRQDnp94LfFS3RivUg8cXl5LdEd1pyQN4CWJv624Ii
         JG6JpJ7p7iWyFUKUPaJrTSQ8MAsk0Ccj5uUC6PPWME8gnN7BG63NwduIUPucshBEhxaf
         OjE2aBLKYmeT2GCS+r8vqrDvfh8gv1UQaXB5yAKWEgSniDjQWOmum39WQYBoq3sg5k2g
         8BC4WBenNv5PNXhAn2nvAj/Qr6gLQrszcXo72KskuchjpduyTICkOxUSaW1eH1Rlyluq
         nfPg==
X-Forwarded-Encrypted: i=1; AHgh+RoPM4jFyyu/DijtXGzoJhxUZZNPOU4O2YI6Iw39QRsDZsAHJrxoYBwuql7uGkM7tbijr4ntcdk5dTBFoYSuGJdp+2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbxf7SdsLqik5GTXldKeCAiy0X0UfVwqa46H2acP4HH9A0vOvi
	4DRTZN4HcDILFxWrkNIrkZQNi1ezGx5bNCPgD0IzBwB4dQj230LG+hsBAyBcJuQI2Zwu/qt5Fiu
	h4MvMH/kU14xFSamaGberUSkfAez7/V9VbwafAlKW
X-Gm-Gg: AR+sD13ufAf+QdcmENdYCaXNIcMP3dainaYfECzfMHbhm2AHPBHgBf4TE6Spou+vH5O
	dLlkd9ggccjnxwO/3OVVxuG1O2iX2v9urwnUADJCzYVY2884rV8cxklKjIvQBwPxuDzdF8lowwf
	e6dmKWeL5aSAqXmc2+tLhj+/tDepoNmVtFB6NAg15KX5kv83gjtKYYN5W/m6JNRJt3cn+YGlwSi
	8wuNTMz3eRXjkFKpvRYFJu20WV6X3mPcLDTL6L3hUj/4SYuoPuvsiBHvYKWh+xaTtbjOfdx+aWm
	Ffx1Jc6OahCHRhfn27sR0gyrxD858KwWp2yIAdXAhCbvViGPRj3vgtsAKTTJglUBipdHDp7HlYM
	=
X-Received: by 2002:a05:600d:108:20b0:495:4593:616c with SMTP id
 5b1f17b1804b1-49975c21896mr314355e9.1.1786406103959; Mon, 10 Aug 2026
 16:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com> <CABdmKX2i_vxs3EgJgydEbXoTxqWe9g9pj=hqPKuwf0ge0SjZuQ@mail.gmail.com>
 <anSyU_-zArFch-an@orome>
In-Reply-To: <anSyU_-zArFch-an@orome>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 10 Aug 2026 16:54:51 -0700
X-Gm-Features: AUfX_mwf0uw3dVpzklPu-Nif3rg3tPQMirUP9IgK_6gn-zY2Jt3_SUQapkz0Yvg
Message-ID: <CABdmKX2Hn0cDw_aFW7Xr9v5mr=WvfhhTXgX7tpRaMMGstYp4=g@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Sowjanya Komatineni <skomatineni@nvidia.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Mikko Perttunen <mperttunen@nvidia.com>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	John Stultz <jstultz@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
	linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 9:21=E2=80=AFAM Thierry Reding <thierry.reding@kerne=
l.org> wrote:
>
> On Wed, Jul 08, 2026 at 04:49:31PM -0700, T.J. Mercier wrote:
> > On Wed, Jul 1, 2026 at 9:09=E2=80=AFAM Thierry Reding <thierry.reding@k=
ernel.org> wrote:
> > >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > There is no technical reason why there should be a limited number of =
CMA
> > > regions, so extract some code into helpers and use them to create ext=
ra
> > > functions (cma_create() and cma_free()) that allow creating and freei=
ng,
> > > respectively, CMA regions dynamically at runtime.
> > >
> > > The static array of CMA areas cannot be replaced by dynamically creat=
ed
> > > areas because for many of them, allocation must not fail and some cas=
es
> > > may need to initialize them before the slab allocator is even availab=
le.
> > > To account for this, keep these "early" areas in a separate list and
> > > track the dynamic areas in a separate list.
>
> Huh... going over this thread again I could've sworn that I had replied
> to this before, but I can't find any evidence of any reply.
>
> > Hi, It looks like you'll also need to update the CMA dma-buf heap's
> > add_cma_heaps init function so that it adds all the CMA areas, not
> > just the early ones.
>
> I would actually rather not do that. The case that we need this for is
> creating a special purpose dma-buf heap that's composed of multiple CMA
> areas. These areas must not be used by anyone else. Exposing these to
> the CMA dma-buf heap would allow anyone to allocate from individual
> chunks and throw off the accounting that we need to do in order to keep
> the protected memory from working correctly.
>
> Besides, given the dynamic nature of this means that the CMA dma-buf
> heap might already have probed when these dynamic CMA areas are added.
> So we would either need to have some way of notifying the CMA dma-buf
> heap of newly created areas or we might end up with an incomplete set
> of registered heaps.
>
> If you really insist, I could look into this, but I think it's actually
> a nice feature that the CMA dma-buf heap only registers these "early"
> areas and exposes them.
>
> Thierry

No problem, thanks for responding. I see there is now discussion about
subdividing a single CMA area for this, and that seems like it could
end up simpler in terms of the CMA code for this series. So I'm
supportive of that idea.
