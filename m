Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880852EB5BE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041734; cv=none; b=Mwpkv1/mv5eL5w+Pyzkeg6T4HImfLZ1Lh/rOyioP09LPc/Gsrtk302iLw0PP3F1lXsZEQ/wJyakMu/adQ1v1HY9At8XOU888nRH0N1QWdNN2cxOhMtm5wTChKyIHrm4T+YoRYwNQoH1iWEkwt+2NHnRa+DjHStw39pTvucXhZeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041734; c=relaxed/simple;
	bh=ckwNK5l6kNEQi0dMFT1BhLSPph3IS47PHdxbRsKbg2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h8xnllTPiivBBg5bRWAz7d+aa84Lr/eSvhbLolt80GI+e7rviQXfCvrdAjvAhnuUzw1or8ssxiEW5w+Rzr6pSqdJCOx5kfQY8QZk/sNGPwEAqhZWWAO25uTNQRLoKZvr9KPYOT9vNVM8peLDdunhPMXYgXzLl+G0qWNVv2R/ddQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YBPSYhfY; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YBPSYhfY"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6fb1be9ba89so95676d6.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Jun 2025 09:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751041731; x=1751646531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pwe6yBI0hTTSV4QKO/x65G0lF6NWazoC/YzcyBgyfJc=;
        b=YBPSYhfYCSvcvlqkTTWKgBuoIRQJExKgNMxyXP8XSXfLKNKeWAiaMB3hwazPeve2l0
         At507yVCtoH0Av1+Xq52NBbz5F98TC6dsmne30HfzRWpovfg9W1pvJDhT1H51QmR2d0c
         Qb6YaY+VL6kXfjeqlBt3AmrhEt1cO+g7a86A0ZJ5ae+HQqdxZaPnt8a5jlPrcBxPB4YW
         CagJZHFOz9cQtMfCfBJ7putglkR/QChte4bzPWOHUFSfTwXV0plMUZdnb/ZfADtI5FFC
         aZtwU7E1KhdXW2kvEcRaC4o61dtFVW5Le/GIT4Vys8+U4t4ug3DQmlJ/EqMe2jBSiEy0
         nCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041731; x=1751646531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pwe6yBI0hTTSV4QKO/x65G0lF6NWazoC/YzcyBgyfJc=;
        b=vsTBV4rmMYC9R5du9wzbAIOPafk00gUtTOCNSf221rKao7TBg2uDlOcz5rJBmX1bPu
         T00klF5sZ4b4jb1zAV9gQfugTSvoCX4mFynIB2yHl1N6X540wIskML3k1rM8I10TOBMp
         XxB6iSjNa4vOUSXONgIX5q2I+40ZYmWU490lxW1lGGs0wHgCNNlQC/3foQ+XNKV+guBb
         ESEkRzOWd4Uz0H3W8v7fhOiyDrcIbEnJuBJIzAVjUooDw3S+YFyHy+D56mKdINvY/gD5
         LiYbR4PZTVTbmH0nVnVg7/4nmPakNZ2mM9pfP64gJ1upyi++nHg9dJKbFr6oGvDcM5bN
         NgZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZqhj2VOD4qRbX7hNUfGTi9Rfa2i9cwZmBCvQCy/gn2nXw80L1a0bqvHnwXyh1SJKctR8/RJHEyMQ6Ex07uXyoJt4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxxSCEVRiINV6Cc2dVFl5rxptKAtqCqa4/0iE6t5Zvi/qzXfV1
	Ch8ENOBiUK3YPBTcT0cL9WaSWRr1Kp9s1QIiXIdziAoJTq12JV8DoIiGkPWcCgau0SCIav21CPo
	X9MZ2nzmonqobLfGoEcGj8+s+acSW4bGFdRz8ZDHx
X-Gm-Gg: ASbGncvG51qPJoyVpWkkQ+5Ne4mRGOGisNiURjcbXtwmj5FhJYWxE7vcuhOyfRnq1jB
	4R7n8wS9FEy3EM6o72EYNFd0FHVTN6zeuxvdV9XFZdvBImbjA/lFsP11/WH/bxWyRYEiOvzu8dR
	rt7Ut+mmbNO1268aQ7D27UabOXGL/UmtsMrxNk40UMOb7oytZisGss/RQX8AxEsTe6J5jtlLCM/
	A==
X-Google-Smtp-Source: AGHT+IEaFjJbudXPZvs4+gz+Ul1aN+IO1A0S+wtT0rUBrPe4/pZbkYPC1YJ6B1u6KB5gj2C6Oj3GAR3BNtAmvLY3bsQ=
X-Received: by 2002:ad4:5c6b:0:b0:6fb:33f7:5f34 with SMTP id
 6a1803df08f44-70002ee7d52mr61421106d6.43.1751041731049; Fri, 27 Jun 2025
 09:28:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1750854543.git.leon@kernel.org> <cabe5b75fe1201baa6ecd209546c1f0913fc02ef.1750854543.git.leon@kernel.org>
 <CAG_fn=XWP-rpV-D2nV-a3wMbzqLn2T-43tyGnoS2AhVGU8oZMw@mail.gmail.com> <20250626184504.GK17401@unreal>
In-Reply-To: <20250626184504.GK17401@unreal>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 27 Jun 2025 18:28:14 +0200
X-Gm-Features: Ac12FXzk502TgF39Kdk9rDaSo7SztNg9o8ROEHR27kqxNaOw7yX3TSWKD6zOmLM
Message-ID: <CAG_fn=WeK8q2g0bRna+fFx+ks4HbfoG3Tnw8PpSdmfdH=3+S=A@mail.gmail.com>
Subject: Re: [PATCH 5/8] kmsan: convert kmsan_handle_dma to use physical addresses
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Christoph Hellwig <hch@lst.de>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Robin Murphy <robin.murphy@arm.com>, 
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	=?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	iommu@lists.linux.dev, virtualization@lists.linux.dev, 
	kasan-dev@googlegroups.com, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 8:45=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> On Thu, Jun 26, 2025 at 07:43:06PM +0200, Alexander Potapenko wrote:
> > On Wed, Jun 25, 2025 at 3:19=E2=80=AFPM Leon Romanovsky <leon@kernel.or=
g> wrote:
> > >
> > > From: Leon Romanovsky <leonro@nvidia.com>
Acked-by: Alexander Potapenko <glider@google.com>

> >
> > Hi Leon,
> >
> > >
> > > Convert the KMSAN DMA handling function from page-based to physical
> > > address-based interface.
> > >
> > > The refactoring renames kmsan_handle_dma() parameters from accepting
> > > (struct page *page, size_t offset, size_t size) to (phys_addr_t phys,
> > > size_t size).
> >
> > Could you please elaborate a bit why this is needed? Are you fixing
> > some particular issue?
>
> It is soft of the fix and improvement at the same time.
> Improvement:
> It allows direct call to kmsan_handle_dma() without need
> to convert from phys_addr_t to struct page for newly introduced
> dma_map_phys() routine.
>
> Fix:
> It prevents us from executing kmsan for addresses that don't have struct =
page
> (for example PCI_P2PDMA_MAP_THRU_HOST_BRIDGE pages), which we are doing
> with original code.
>
> dma_map_sg_attrs()
>  -> __dma_map_sg_attrs()
>   -> dma_direct_map_sg()
>    -> PCI_P2PDMA_MAP_THRU_HOST_BRIDGE and nents > 0
>     -> kmsan_handle_dma_sg();
>      -> kmsan_handle_dma(g_page(item) <---- this is "fake" page.
>
> We are trying to build DMA API that doesn't require struct pages.

Thanks for clarifying that!

> > KMSAN only works on 64-bit systems, do we actually have highmem on any =
of these?
>
> I don't know, but the original code had this check:
>   344         if (PageHighMem(page))
>   345                 return;
>
> Thanks

Ouch, I overlooked that, sorry!

I spent a while trying to understand where this code originated from,
and found the following discussion:
https://lore.kernel.org/all/20200327170647.GA22758@lst.de/

It's still unclear to me whether we actually need this check, because
with my config it doesn't produce any code.
But I think this shouldn't be blocking your patch, I'd rather make a
follow-up fix.
