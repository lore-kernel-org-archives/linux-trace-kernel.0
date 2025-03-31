Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC60155725
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743440151; cv=none; b=L1v3vs765nZbsAZn/dM15GFV1mn36ieNKqLSJ9D2z9ldJ8RIeEtTvWOXYJytMDYA/frN3j5LhIO0rI71ReahAa0W+qoVbaUp018Qe4EF9qpyajbk4H2uKEzWjmgLst9dEOb77UYf+7tmTOwIqj311YVKIah4SSh6CK4GlFbJl1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743440151; c=relaxed/simple;
	bh=nbbZ8G/enUVJMoOd8aC7hUU9KCHgeQrNZ7sTOkRuFAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QRyJ26oQQN8cyj+yDW6yaTM2NdTBDweCoQihMGVOkwELfHzX6+MrN5YgYR8BXPlghYDcC4H+/MFNgHTOEsQWMM37x7IY2R9ZHjLbKRoxDS0TteQvRv6cA436UMkPqzlCQOPb0cvf17BsEGaqRzCqNzimUOX1Ip95s+gaRXo229g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DdZdVDF1; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DdZdVDF1"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso818999666b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 09:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743440147; x=1744044947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nYwZCdqgU/HYxLtCJzRvtoajX2kMqfp4JL+kcV4obEM=;
        b=DdZdVDF1jPWiD7H5ZSdo0RDFTTHutLPtJ5/IA9Q59siEoyZbyvKcKge7J/dfjJPuwu
         o3/bv94xgPJs20mf/uV+Ehk1DDmrvJV3H2aXnCMdZqpjgdN8pYBisGXOYQfatYeA2RPM
         GIUPqbOJS3/uukdsaQvs/9AmiIYmQAh9Jr+5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743440147; x=1744044947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nYwZCdqgU/HYxLtCJzRvtoajX2kMqfp4JL+kcV4obEM=;
        b=wxUnXhNfxzeieAEvzJXGIGbiiEabHrP0t/DA8vU8utYFQ9CwagbxWzNswaCEhwTu9Z
         Kam7hSsK4fscybBM3/LBVvsptWSeVS7bbLH710ZYKO0nhD1kposZtpvmzLbeLXqDNkRo
         /oejIFw6Mq4+MHJlkF6iKanGZLoBsMGVjrvhcxbn/NSweMmR/C2QihXBxLKS7tvW+IEQ
         hXnLpTAuP1V72Ez6sq10ys8ITdrbvW2OdADAlPZDac9BF7uzWF4KiKyRCbHLxmsY1uox
         vss8vGl0rY6FCeaKaXKnfqhP3eKVN7AAR0NyMWHbbKSQEB0/DJptjiUBqVVBX+jx26KC
         v8/w==
X-Forwarded-Encrypted: i=1; AJvYcCVU6LWrzhnhgISJq/cb4B86+w+rVJb4MQim97OWluHFCglstETOepU5Qo8XYfUSyTYFXFHHaGaohNyrQNtJydkiuc8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK21I/Rdw/zfrewpsksyIH3ID/TZ+Yj1fHfaCSc8q/uGtZM40C
	E8PVqDPnz4vhatIiX6VWpV7CjRiUCkOAYPlATbqNaDK2ttBl+chjqmKnaKlfGKBHcTFIHc/LKoj
	HbDg=
X-Gm-Gg: ASbGncu+9VRRtMr+RflZvyhM5ggpicGCzhNtdtOK2rW/RUosf9EtMFCNZE8z5B63znt
	gjBWxqiQ6wgpiVNr12dU62HqGnQU0RYyKYXvTFLjlJ3OX+GTY4YQGMd8BPj+rI+xUfoAWQQkdNj
	yru0BAEDq2pEL0UZRtGwBvY2WaxFR3tlhxLV9g65Dn7+PM5VIla8EWyjBzex07Yxa33jdGoft+v
	LTJKIEDJn8wQaOZEPhssxAllS6ZAfYP6MkBExHyKtQHmG0rxOaUVnDPSyCsOTVbmGOwl54CDnxM
	MoVo6sOAHYfetcnRPMEZE//Fp8gzUhs7DGnJLTsXOfX0B8XkdH2A3EGiDOnVJe8O5QvA3tLxzLJ
	jxcgjo6GTK3i3wYsIGAc=
X-Google-Smtp-Source: AGHT+IFdLi66X4vPVrxyFmGeqX5cz6l/w5jxy7FFXSt8O/Qj5wBlaCfDyVYAlDGvBG9xJBtPi+jt0w==
X-Received: by 2002:a17:907:60cf:b0:abf:52e1:2615 with SMTP id a640c23a62f3a-ac738992fd8mr993391866b.7.1743440147119;
        Mon, 31 Mar 2025 09:55:47 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71961f6besm652842566b.93.2025.03.31.09.55.46
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 09:55:46 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5e8be1c6ff8so8773539a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 09:55:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW5cR778Ytrk/8pmFBzhv2pv6DHrYzxv4jlJdihyiC89Fq82eE0hqhtyWbP2gDGMiCev56BeKOoBmXG7Vw+q2qFjbA=@vger.kernel.org
X-Received: by 2002:a17:907:3f26:b0:ac4:3d4:50b with SMTP id
 a640c23a62f3a-ac738a95899mr973600566b.32.1743440145725; Mon, 31 Mar 2025
 09:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
In-Reply-To: <20250331143532.459810712@goodmis.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 09:55:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
X-Gm-Features: AQ5f1JofnGlZZIBzRL8nqNouUuwr3wJtpcwy6ycYi9xaYeiAa4GGLQMcoE3H27Y
Message-ID: <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 07:34, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Instead, rename ring_buffer_alloc_range() to ring_buffer_alloc_physical()
> where contiguous physical memory is passed to the ring buffer code,

The concept looks like an improvement, but:

> +static unsigned long map_pages(unsigned long *start, unsigned long *end)
> +{
> +       struct page **pages;
> +       phys_addr_t page_start;
> +       unsigned long size;
> +       unsigned long page_count;
> +       unsigned long i;
> +       void *vaddr;
> +
> +       /* Make sure the mappings are page aligned */
> +       *start = ALIGN(*start, PAGE_SIZE);

The above is *completely* unacceptable.

There is no way in hell that ALIGN() can ever be right.

You don't even fix up the low bits of the returned virtual address, so
you literally return the virtual address of something that doesn't
match what was passed in.

So if you pass it a starting area that isn't page-aligned, it now
randomly gives you complete crap back, and includes some random
unrelated part in the mapping.

So no. That needs to be a

        if (*start & PAGE_MASK)
                return NULL;

or whatever. Because just randomly corrupting the base address by
ignoring the low bits is not ok.

> +       /* The size must fit full pages */
> +       page_count = size >> PAGE_SHIFT;

This part works, simply because truncating the size is fine. It won't
all get mapped, but that's the caller's problem, at least the code
isn't returning random crap that has random other data in it.

That said, I don't see the point. If you want to virtually map
physical pages, they need to be full pages, otherwise the end result
gets randomly truncated. So I think that while this is much better
than the "return random crap that doesn't make any sense", it should
be the same rule: just don't allow mapping partial pages.

So make it be

        if (size & PAGE_MASK)
                return NULL;

instead, and just enforce the fact that allocations have to be sanely
aligned for vmap.

Anyway, that takes care of the horrific interface. However, there's
another issue:

> +       pages = kmalloc_array(page_count, sizeof(struct page *), GFP_KERNEL);

you create this pointless array of pages. Why? It's a physically
contiguous area.

You do that just because you want to use vmap() to map that contiguous
area one page at a time.

But this is NOT a new thing. It's exactly what every single PCI device
with a random physical memory region BAR needs to do. And no, they
don't create arrays of 'struct page *', because they use memory that
doesn't even have page backing.

So we actually have interfaces to do linear virtual mappings of
physical pages that *predate* vmap(), and do the right thing without
any of these games.

Yes, the legacy versions of interfaces are all for IO memory, but we
do have things like vmap_page_range() which should JustWork(tm).

Yeah, you'll need to do something like

        unsigned long vmap_start, vmap_end;

        area = get_vm_area(size, VM_IOREMAP);
        if (!area)
                return NULL;

        vmap_start = (unsigned long) area->addr;
        vmap_end = vmap_start + size;

        ret = vmap_page_range(vmap_start, vmap_end,
                *start, prot_nx(PAGE_KERNEL));

        if (ret < 0) {
                free_vm_area(area);
                return NULL;
        }

and the above is *entirely* untested and maybe there's something wrong
there, but the concept should work, and when you don't do it a page at
a time, you not only don't need the kmalloc_array(), it should even do
things like be able to use large page mappings if the alignment and
size work out.

That said, the old code is *really* broken to begin with. I don't
understand why you want to vmap() a contiguous physical range. Either
it's real pages to begin with, and you can just use "page_address()"
to get a virtual address, it's *not* real pages, and doing
"pfn_to_page()" is actively wrong, because it creates a fake 'struct
page *' pointer that isn't valid.

Is this all just for some disgusting HIGHMEM use (in which case you
need the virtual mapping because of HIGHMEM)? Is there any reason to
support HIGHMEM in this area at all?

So I'm not sure why this code does all this horror in the first place.
Either it's all just confused code that just didn't know what it was
doing and just happened to work (very possible..) or there is
something odd going on.

          Linus
