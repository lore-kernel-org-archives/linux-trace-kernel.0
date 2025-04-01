Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E601A2AF14
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Apr 2025 00:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467286; cv=none; b=Ib9w6c+3e2slGB5VFvHvoyO+ahdEXYoy9614I0/dKCTXgEMBjP3atipedsepPGaFzsVpJr03oanL+PpbsvoTntWpokcDP8t+bMZ/pjW+XaBnHIfQOuujXpSkLTvC3jqLGupDrD+7wvBtiMljjAU0sExdVp0IPP4rUVm/C9d+2Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467286; c=relaxed/simple;
	bh=26+GYqb2X3NwLsu1qFcx4SuY1JzDD5ReS/TzARaJw1E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVOl7rurzuKz54mHx585OQB40sKI2gb72cB6PoOTn/O5LKhMl5dx5GTszOYEDn3TDohG47f8o+m5nHJo1qU1jB591Gf9eaLLCgA6Q/wTo0+N5GgPYg2bYDvoEz0gO3escKIaWqHAlTi7f/n7lmelCdlz/gPlBMWPr+3dBX7KFh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=VT3uZltj; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="VT3uZltj"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaee2c5ee6eso752391366b.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743467283; x=1744072083; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qGbH0NonJSxr19KvUYelWs1NH940om4VboO0W8M328o=;
        b=VT3uZltj/o/eArEVW5xiHCiDXWXToFfODxPHE+7KypN9l6rwH/yihBYNhgnmEs0MX6
         fD1R/z/7k9w2q1FcKGS0ZGFHIzDcI22lcNsbATJh/0nKx1Eweetlqe8g6gsH7ITSr6wS
         mV63Pulm7vKczsGr4hviGu8Byy4zQoB4tBbNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743467283; x=1744072083;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qGbH0NonJSxr19KvUYelWs1NH940om4VboO0W8M328o=;
        b=AkKC3/VFXJBk0pEhwrbeMiwlXFhO6IIKaIrUESVU29ff6G+siICI1qOKr7YYSULd43
         cnopSiGLAaWBUi2pCy3dlKzsK9mcV60XnQ7cmL301+ZyV54FaU6eSjH0zDunH5zfgUsG
         lULCB2R8DAcseqy+GNDJ0O8ZGiSB7MCGq9hEWoPtUMLS4r547LoI9Chmxaaira7PRiP9
         GsyOhcFABqCF2Xxonjzn6PCYX6ewbOrbMcASKnqBjjwVrg2qCoCwAoUyEDjxRlecohM9
         0uSDdwqqcwj7iB1QzHZbuaVNwVZkSCcX2WfP9d6pxR6WhYkf9mqnsntC+twV8wMYItQj
         9GDA==
X-Forwarded-Encrypted: i=1; AJvYcCV5pk7R63RiFWtDTnj38lAwLi7htlWIbuuGLqHczA6oDHxdFFc3NNcvqdaRtQJFDqOXT9RFGqixAfJX5GP2mVWKB5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7e7V9gi4L7F2OyYzd6VWRgItPVVFyBQYjIN0xBq/OrhCMkkGd
	tvXjNSi4GW8OzoTJH1YyYb598vqGrfLQXT0YM61pqU6BZvejULbeH68mik4oRIsNz1G/iIhfix4
	A++g=
X-Gm-Gg: ASbGncuJUnjf/eh66YUykqkvWctG9x2okdLSJ+jm6b9M9fl3DgeuTG0OHgSln0O7z1n
	9U3+qGs3GKOtiAkDoeT0irubYWFpyUdlh8t3RKvpNGAjRV5bTuCtVjVXkAt4Yrv84EQHnoWXGg8
	Dmtl31fAUrNfXsrwQFd2XjnCI6G9CZRW9YBMEiNqygbz2eF0abHuf5DJ+Fbre0xUkKZYtahUy8F
	32+u1hb2WV166ObqVybOm3rSEdungR9CCVdK992tpm/VY8DwH3McGgW0yfUKVs9kUihJC47Gnki
	xWiqZ8pE4SBCvBYSyv0h8TuxyT7Kju2QE5ustz140X5FbKgEMV/gfPXrYinetSrjGswrsdKm1kR
	6OK+2mPDuVYJmKVm7Qwg=
X-Google-Smtp-Source: AGHT+IHxosm1WB5bN3s3yGdhOtehOz+waoSBq16NipSDDCIhOM7TVHcdZbDzQb9cyqsQKR1xEJXq2Q==
X-Received: by 2002:a17:906:f85b:b0:ac7:3912:5ea5 with SMTP id a640c23a62f3a-ac739125f39mr863174466b.58.1743467282964;
        Mon, 31 Mar 2025 17:28:02 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196e8191sm695280366b.170.2025.03.31.17.28.00
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:28:01 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so8049102a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:28:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX/Ayn9btWLYBucqgero1KqANfxeDhTpJ0M0l5Q9PVrT95ar43w3iGEf6COnDhPLeYQFfhQSrZMTMpmxfXO94uDayE=@vger.kernel.org
X-Received: by 2002:a17:907:7eaa:b0:ac3:45c6:a1ec with SMTP id
 a640c23a62f3a-ac738a841a3mr1257375966b.25.1743467280043; Mon, 31 Mar 2025
 17:28:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home> <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
 <20250331194251.02a4c238@gandalf.local.home> <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
In-Reply-To: <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 17:27:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjQ=ZY5K+tSF1xui3aoL2Vkzsvp8W1mQ9iVeTQ9Cnbc7Q@mail.gmail.com>
X-Gm-Features: AQ5f1Joik-SCEnqhzDRblUTUj3BDSsq66RHEyMLggTfPfjoeXEo8UparowVcV48
Message-ID: <CAHk-=wjQ=ZY5K+tSF1xui3aoL2Vkzsvp8W1mQ9iVeTQ9Cnbc7Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 17:11, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I thought you did that already for the user mappings - don't use you
> remap_pfn_range()?
>
> That's basically the equivalent of vmap_page_range() - you're mapping
> a whole range based on physical addresses, not mapping individual
> pages.

Btw, if you are wondering why this isn't consistent: for user space
mapping 'remap_pfn_range()' takes a starting physical 'pfn' and a
size, while for kernel space 'vmap_page_range()' takes a 'phys_addr_t'
and a size, then I have no answers for you.

Except just "random historical accidents".

There are a lot more "map into user space" cases, and it's the much
more common case, and it's the one that a lot of drivers have used for
a long time.

The 'vmap' code in contrast really started out as just "vmalloc()"
which allocated the pages while mapping and "ioremap()" which mapped
in IO areas into kernel virtual memory.

And then the interface has very occasionally gotten updated over the
years and we *have* had some unification, but it's been driven not by
"let's make this a kernel version of user mappings", but by "random
odd use cases".

You can see this just in the statistics: remap_pfn_range() has hundreds of uses.

In contrast, vmap_page_range() has something like five uses - when you
grep for it, half of the hits for it are in the mm/vmalloc.c
implementation and the header file declaration).

So I do think vmap_page_range() is the right thing to do here, but it
is *so* rare that maybe it has issues. There simply generally isn't
any reason to map contiguous pages into kernel space.

The *typical* use for kernel virtual mappings is either

 (a) turn physically discontiguous allocations into a contiguous
virtual mapping (ie "vmalloc" like things, sometimes with
pre-allocated arrays of pages)

or

 (b) map device pages into kernel space (ie "ioremap()" kinds of things)

so vmap_page_range() is kind of an odd and unusual duck, which is why
people may not be all that aware of it.

And being an odd and unusual duck might mean it has bugs, but the good
news is that "vmap_page_range()" is actually the underlying
implementation of "ioremap()", so it *does* actually get tested that
way.

           Linus
