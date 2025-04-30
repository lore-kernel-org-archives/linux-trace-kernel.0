Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EE2980AE
	for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Apr 2025 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046346; cv=none; b=UvruBvl8xcZE+p/CjnvfqlgpWqGcQwZuB0CJYrU6JjiHbAcNC9eo5q6nFhYYTo3WGZ+EXyVYHV9O1qop9f+oeU/s4etqsZ62oXtq2ktO5YX8yDP7mGazOnk0H4XNlHm4PMVZl4zqlQgfcr6hgRNiO53f/fP3onGL3CO+6MkKvIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046346; c=relaxed/simple;
	bh=wvJwBMeNEG6L7qXV18iRAqNdKebQ0TFLRjuHZzWsT1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vFapJsG8eCtyuSQDQLJIywbyeN+azTHTUD0BUhhNA032ec7WYznJ/3nSKpzOwR3XCJN7BBwsv6+tN9H0+XZndiqzFxw77cls0nRz6NbMl37W/ISwbL8N7guP9OQwVmK1sinPzp4jBzj/bas0cqOHEGnU1pYKHRXqHM+ALouChv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aBv5s+cw; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aBv5s+cw"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dbfc122b82so702a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 30 Apr 2025 13:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746046343; x=1746651143; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=23hiVYsmBQF9yQXvvKwFVuWz0LAimBGXKxbs767cKCA=;
        b=aBv5s+cw/XctSCZu6pwYFKwdU6d7P6yf6nVNz5g5QczjdtX69wvQHtF9mqbzFcyJtS
         sAJionMGrxXuGiZYhgLgqHF5dG8ueogcAz7LNbtLItJwLLUXAiwXpNEn0ZzL+rQqDgmm
         5ozMMKfuCGFxMeQxXOiLEEfdk/UvutTognVUiajVNO4khkskmuAN25svgnj/Zak6RXfx
         zOAHOJKdauZuDpUiS6XMaRux5HYUJ4xSsPJ58RzqNKJvonCadBg+xVXIimF51ptBqFYJ
         I+Xswz6xgLbfUZWHjBHBwcvwGaozX/Ncvw91qgm/4kY6PcwPlQiG6TmQJhZDk3A2Yq9U
         VOSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746046343; x=1746651143;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=23hiVYsmBQF9yQXvvKwFVuWz0LAimBGXKxbs767cKCA=;
        b=IjaXwkoNaY4JKMGl1SJqMunjWfHJUIqc9A8STf+Wy+MmB0q7gLuCgpPeeRRbkcoWQp
         l/AejuceMPw1O8UaPzmOJWnXtYM22bd0Lvkcygf82nyEUy35D6Q86E765/OhLx4FMa68
         GDMycAc4elORr9lsPNy+qT3jpfh4U82omJL4Vb6prthpC8Ju4q2z3vtMv8XodfSP9lXO
         7g2uz0CIr7Ku6kxAkTh0etrgETp7Vfk9i2vxFAX2A6xU14LVcmoYSxCjRebQWRaP6DF/
         qxNRmbc6N+ufTriNQ2Hrxy3DPbQz6Vfgxl8DQQxeboHDzVsLdr2doMMn+Tg5JHQ1LUoy
         9nIg==
X-Forwarded-Encrypted: i=1; AJvYcCVwWm2qVAgeV+V6sC67pknAwlxqS/qKv/RJc8NeXu7cg295lX44Z/oedVesnLEEsdJnyDg8iIy8sh2hVzsh8r13E58=@vger.kernel.org
X-Gm-Message-State: AOJu0YxynFY61+xG6cIED66vx5BumEpPB2LHc07GrW30VMMndRGPbN0t
	RRpVEW44DQUjumS/oB+Jzz3MEDKcBF2ZVWzZSn3NHTK1BxvGg8gE+TTAkqVCEGs33PVu+LWHI0s
	kDLzijfFrPB8OtpMWW7vDS89PAXRd9KvTery+
X-Gm-Gg: ASbGnctqEDIt+p6qHtSRlXXGfuQVBe30x9sQXgOXmgNHkTR8gOmnr3wQfOjibEOfNIP
	qhMNqO9U63pQOVXVUeZEeevzTv0XbN/dzpohc0pTaSoKIXRPaYDCk7hqd5ZmBViHHUbNKst1Rec
	3srVyUyHl1gnEn8vaSzx+uJam5ANs2jdH7k6icPfF8nbOCRcboUdg=
X-Google-Smtp-Source: AGHT+IE2B3xe/+DPD2M7lWdvwY8uHQG2L+pnPzy2O9bW24VKqvrt3dxQEMF9lvotWS4qoTaaP5jcihl9aeV++lrP6Is=
X-Received: by 2002:a50:d783:0:b0:5e0:eaa6:a2b0 with SMTP id
 4fb4d7f45d1cf-5f918c2b650mr1378a12.5.1746046342783; Wed, 30 Apr 2025 13:52:22
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250428181218.85925-1-npache@redhat.com> <20250428181218.85925-8-npache@redhat.com>
In-Reply-To: <20250428181218.85925-8-npache@redhat.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 30 Apr 2025 22:51:46 +0200
X-Gm-Features: ATxdqUHTpwiuUHFPjjOCSAtuFNVfWyscjbmOvS8EHiScAhewMiIQNRRDtNrYr8E
Message-ID: <CAG48ez2oge4xs1pSz_T9L46g=wQnFyC63kQKsXwbHGRWAxQ+aw@mail.gmail.com>
Subject: Re: [PATCH v5 07/12] khugepaged: add mTHP support
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, david@redhat.com, 
	baohua@kernel.org, baolin.wang@linux.alibaba.com, ryan.roberts@arm.com, 
	willy@infradead.org, peterx@redhat.com, ziy@nvidia.com, 
	wangkefeng.wang@huawei.com, usamaarif642@gmail.com, sunnanyong@huawei.com, 
	vishal.moola@gmail.com, thomas.hellstrom@linux.intel.com, 
	yang@os.amperecomputing.com, kirill.shutemov@linux.intel.com, 
	aarcange@redhat.com, raquini@redhat.com, dev.jain@arm.com, 
	anshuman.khandual@arm.com, catalin.marinas@arm.com, tiwai@suse.de, 
	will@kernel.org, dave.hansen@linux.intel.com, jack@suse.cz, cl@gentwo.org, 
	jglisse@google.com, surenb@google.com, zokeefe@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, mhocko@suse.com, rdunlap@infradead.org, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 28, 2025 at 8:12=E2=80=AFPM Nico Pache <npache@redhat.com> wrot=
e:
> Introduce the ability for khugepaged to collapse to different mTHP sizes.
> While scanning PMD ranges for potential collapse candidates, keep track
> of pages in KHUGEPAGED_MIN_MTHP_ORDER chunks via a bitmap. Each bit
> represents a utilized region of order KHUGEPAGED_MIN_MTHP_ORDER ptes. If
> mTHPs are enabled we remove the restriction of max_ptes_none during the
> scan phase so we dont bailout early and miss potential mTHP candidates.
>
> After the scan is complete we will perform binary recursion on the
> bitmap to determine which mTHP size would be most efficient to collapse
> to. max_ptes_none will be scaled by the attempted collapse order to
> determine how full a THP must be to be eligible.
>
> If a mTHP collapse is attempted, but contains swapped out, or shared
> pages, we dont perform the collapse.
[...]
> @@ -1208,11 +1211,12 @@ static int collapse_huge_page(struct mm_struct *m=
m, unsigned long address,
>         vma_start_write(vma);
>         anon_vma_lock_write(vma->anon_vma);
>
> -       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, address,
> -                               address + HPAGE_PMD_SIZE);
> +       mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, mm, _address=
,
> +                               _address + (PAGE_SIZE << order));
>         mmu_notifier_invalidate_range_start(&range);
>
>         pmd_ptl =3D pmd_lock(mm, pmd); /* probably unnecessary */
> +
>         /*
>          * This removes any huge TLB entry from the CPU so we won't allow
>          * huge and small TLB entries for the same virtual address to

It's not visible in this diff, but we're about to do a
pmdp_collapse_flush() here. pmdp_collapse_flush() tears down the
entire page table, meaning it tears down 2MiB of address space; and it
assumes that the entire page table exclusively corresponds to the
current VMA.

I think you'll need to ensure that the pmdp_collapse_flush() only
happens for full-size THP, and that mTHP only tears down individual
PTEs in the relevant range. (That code might get a bit messy, since
the existing THP code tears down PTEs in a detached page table, while
mTHP would have to do it in a still-attached page table.)
