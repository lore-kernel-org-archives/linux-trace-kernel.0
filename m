Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDB1284884
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759957216; cv=none; b=GZQGOuuHmNQ171ZulPFw4DV5g7Sap3hfjpWiQaEfdINzVtXSPPIoVIEP4NZVPhYRv8zqYqHqAuls1C2CeiiLF+ImAPu5hgL9+BqOby6gJXf19SCIy+lyvMc7ft8DLkuNZntyq0oMmd0jXM1p1eT6rGF0L0dHUZQl18roMqa0OB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759957216; c=relaxed/simple;
	bh=GKC6oaRq+uiw7mdJich1LJGlGIA1fAyZCaa6CLeTtHU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5pgkpArGskFKtNcK9kTHw7ZNa3RFtybfgd4WG5loK1Nca11d80LlzNu4Tsr3rMF2FGddkvJW5N2jMNXCgKRvmozuNOCpdEVPjGd4Xwzny0AqNEs8Ho24lG9Pp0vLxqJu2qtTESrUgym9MRkVBYZ9j5SGCzn8cZayigbfTyMA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FowkcP+6; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FowkcP+6"
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-b00a9989633so86144366b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759957212; x=1760562012; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gjWje9iMvGX5rIAekMXgH40NgWMmwUHYwMVyzVQ9M2U=;
        b=FowkcP+6mNH19c2K4CZXs3n9WF3fiGnbcPHyRH9es9fs141pnKuwq/VQhncKSAihGo
         xruaeS/y3Wgoq++5H3LV1GHQpOXyDf+RuFefcx1vbxUP9cMAYEVt+QpExrwbE48QrRRx
         zXrWzvhgY2Wc5+lzQKCwRRDZZI4JCInFYumsC+8Hu7TrbwS/HkQNVfmdOVsc5irGQnUE
         bM9abaGMmI8MOVH6QDENeVPUpliPKoetzWqVg8Lq/bo9Bn1+9YbxOae1NqJ8o/vhXx9n
         VTIQ2pmoTG3WMuNqzsDYXywxz/utT4QzCwENkiCeVdKWVohHIIA4+Nv1vO2rpyORMSTn
         R9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759957212; x=1760562012;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gjWje9iMvGX5rIAekMXgH40NgWMmwUHYwMVyzVQ9M2U=;
        b=QlCLlzAesYvJHpHvFQrsz7FdswI8wnIUW+eQVrWgQLZBDCmu9V7cnURDwHqvsZPveC
         wkuus0IPpUO2LD6ZuaDxqslQxj7prgluq1jLhJIik1G3m5gzOZ64IRjNbS4IsW7xheYB
         P3RD3mpHmRs1XiuuNbcekPTcEP24zUv4O/28OKxcj0Fu7v+pqkRIo+jH+3YSlXGhChml
         +jXnm5EMZTHopWWUyYpV/XG7BEymOar0hNscf8rwNoi/OXZAHQwZ1SHuujeh/ggrlWxK
         WhBc9RVpdv6wT2ZHk6nvgpkvBIl6AshOufc5wNmu+4fIHsLJjaevmfo9QFBFzMOn6b3Z
         k4XQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHPt6ENsMVnW9MHk95PSJpbgpDYgs7UCW1mSKDHdql3h0XPI8CslfGDer8SobroMO7WoBmjLgjXycY8cUtnpkn8WE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqpcS0GZF5RgEFENx+erlJNZ10S6zbMlJuyZ5bv9nv95eCb+ad
	WV6dwSMOQlY1KU3SsQ3Hk9naQWMwLxDMpaqJyP3yxWORjbLjMJ/1oeGJjUOi48G9kzcDIbsXxUa
	/HDAL8ijodLQc7Tl8wbTQf1wU7dmfsXA=
X-Gm-Gg: ASbGnctamD6CEKsocnYVjJK+trNSEcrCdD4WGoutFpHH1dXA/AkiXZ8GaS9ffVA50js
	PPLbN3WRF5jV0TT+dyARdEhMR3CaV3z51GHaXo4t2+fAkO3jaw4uvpEGFrexQ96pF75TZ6EqLfI
	lAZagAIBSKAQ936+bJlcjDn6OMRo7hcv3FEwbtBdPd+MgpqUbQaeY8yYiB1gDSvtiHMpANWRN1s
	hloGW8OYlW5g/PXlJ3kmRvaDetbZwIRwcH0pbGn+p2q4zkkDYKQ7SoJaC2ke35wuKMpHLgTnxdu
	IKFgnmjWq6Rp+B9NbByY
X-Google-Smtp-Source: AGHT+IHjmmpMFRNDs6euqAb3iIYh0ALJqoacwPe+YJkt7+Se3sU7gW3RO0BPcw/5AzbPQrFFFyx0miU/mwSJGY2lnt4=
X-Received: by 2002:a17:907:d412:b0:b3b:478:515f with SMTP id
 a640c23a62f3a-b4f43105684mr894239866b.22.1759957212145; Wed, 08 Oct 2025
 14:00:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250927061210.194502-1-menglong.dong@linux.dev>
 <20250927061210.194502-2-menglong.dong@linux.dev> <CAADnVQJAdAxEOWT6avzwq6ZrXhEdovhx3yibgA6T8wnMEnnAjg@mail.gmail.com>
 <3571660.QJadu78ljV@7950hx> <7f28937c-121a-4ea8-b66a-9da3be8bccad@gmail.com>
 <CAADnVQLxpUmjbsHeNizRMDkY1a4_gLD0VBFWS8QMYHzpYBs4EQ@mail.gmail.com>
 <CAP01T75TegFO0DrZ=DvpNQBSnJqjn4HvM9OLsbJWFKJwzZeYXw@mail.gmail.com>
 <0adc5d8a299483004f4796a418420fe1c69f24bc.camel@gmail.com>
 <CAP01T77agpqQWY7zaPt9kb6+EmbUucGkgJ_wEwkPFpFNfxweBg@mail.gmail.com> <09bc63a92ba1c9042d57bf19258e28e3cd00be57.camel@gmail.com>
In-Reply-To: <09bc63a92ba1c9042d57bf19258e28e3cd00be57.camel@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Wed, 8 Oct 2025 22:59:35 +0200
X-Gm-Features: AS18NWDhFIkGMmqU2seG_4tWpW5wh6BoPDeAWpFQCUEp4vlG8Tha-zmBXl0Sza8
Message-ID: <CAP01T75DqdVHgfD5e4ZcizZLrh7+VOv4cmNyZ2YFbFJE3f0Ttw@mail.gmail.com>
Subject: Re: bpf_errno. Was: [PATCH RFC bpf-next 1/3] bpf: report probe fault
 to BPF stderr
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Leon Hwang <hffilwlqm@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Menglong Dong <menglong.dong@linux.dev>, 
	Menglong Dong <menglong8.dong@gmail.com>, Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, jiang.biao@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Wed, 8 Oct 2025 at 22:30, Eduard Zingerman <eddyz87@gmail.com> wrote:
>
> On Wed, 2025-10-08 at 22:08 +0200, Kumar Kartikeya Dwivedi wrote:
>
> [...]
>
> > Since we're piling on ideas, one of the other things that I think
> > could be useful in general (and maybe should be done orthogonally to
> > bpf_errno)
> > is making some empty nop function and making it not traceable reliably
>                                                   ^^^^^^^^^^^^^
>                                    You mean traceable, right?
>                    So that user attaches a bpf program to it,
>                   and debugs bpf programs using bpf programs?

Yeah, sorry, typo.

>
> > across arches and invoke it in the bpf exception handler.
> > Then if we expose prog_stream_dump_stack() as a kfunc (should be
> > trivial), the user can write anything to stderr that is relevant to
> > get more information on the fault.
> >
> > It is then up to the user to decide the rate of messages for such
> > faults etc. and get more information if needed.
