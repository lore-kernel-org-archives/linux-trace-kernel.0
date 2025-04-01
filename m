Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DD0136E
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Apr 2025 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743466328; cv=none; b=Cz9BLaLJ403o0TPSUCfWzCuUXyXT+T6MQMCBuPmBS0LSRf6OtxAqyKcd/gQRRgq9xOoHbTEFVuVddRJCNptrBYkrC8utzozXMKZC+AZNVrOmkLGV11k45OI+cn61bt67maOmBWuJnsWz9zPEYS0CAfgy90KsHhwpEpMBOBnZrJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743466328; c=relaxed/simple;
	bh=4OBqz7wDraSoW0l6yq+0GpIDBxLW46dFRm5AL8c+8kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sRfSBSYpFTEt7uE5QlmDOULaPDlrZJjTezBXRYGE/6NtY5B/fDQ6VWNp2S9nJEOXkLRgFS7U+4AIHP7vL5y2fqhjr1uK1Unbv+sFV3C3gwGW2mgJmE0go0C43mePuk8ISUfiVvYvJRU+QiUgRbulyVlSgW7tg73hpVO7W6hunOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZX2CJDmX; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZX2CJDmX"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac289147833so849288366b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743466324; x=1744071124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JePFNkfbv8aLxrEPQhMGBSSVCyqR/ZwFXTbEBhcrHt4=;
        b=ZX2CJDmXPsAWAqAOvCY33VsMwu7ayQ7MGXxnvbJAOPuMIoU9T5cDRRtgVHIyPsmAmb
         nXd0QiLuw8+jeI9azAq77kyus2HDHXm/xkn/hjSnlhjJV75bnAOAQhunpebZOoiqV42L
         bNF9jKIQNwSiEodTZ/72gxnh6w92Y+BCj0ldU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743466324; x=1744071124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JePFNkfbv8aLxrEPQhMGBSSVCyqR/ZwFXTbEBhcrHt4=;
        b=op9MUjVXkRE07FBbSDWYyYYJHu3xalHwmDEO+qYYWey0G9DMFznui6dPR18hNZV4Th
         UV+C7sL/yjGVDvk1DxxmgrbpZsUjpgph78XDyf0VymOcYVsOGCLaE01A6G/toXcduEqS
         g4u9KQtFQp/Ne6QkAHIWMJ5YyiytHUdluto1U0fnVbqlXXbhPmA+IRDkMfK4UPKdkn1v
         1wnOVDtRgTSi210YcxA2t0oCJq+cmnW8ifMCGaFlzrhVI3iOT5sDVvqvMKSXvCvp12hj
         2jGzNPf0IkJxA3iPC+/21wqFkWI7Jh4WUuxuxGDEnH3zS1JTiY17Pw7hij6MGUBRPqwF
         rCoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXeeHVE70TVu3isQNu5tHwk2vGjSbOzLgrzeNCcqX5G5nD/ODaMTj4e9UcCHwZz++7iw8MdwRaTN2NKctzV35O1Lo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7W4p0+/hsbEMNC7Q53Dl8V6SHXkHVjaYVMBQDnkFo51Saf2/F
	TdEAW+QijBMdtVJaxSH01gp76GBvhfaGx97aQedEeZU8TVQqZzAXyjOHWDVYOPBw9pKwyqwsKEV
	rtZQ=
X-Gm-Gg: ASbGnctXz8ZXtvb+prGBTmTcFwQJI3kiL4u2c0AjufhBWVEon+DxZh9Xhu208+1lG2Z
	wEgs/UyyEjJbyoZiF9Ti1SI+R9XjOTR9OLfsotGIDC3OmRPToYvdvDdkYIiU5xS6CNQ+7qjSyqG
	YbmStzNqgP4gDlMUQZ8wlbXgmT4VJmqg1o/l3/SI43CzFJvo8+RC/IhuB22LZiOzmc1IxqmdLib
	gbceRG6HDj6nOvDkktCD/3nB7/jbkHfoVJk7UZRDX9xul06x4PDO8nOQJgMbsdEErLwHHCzQ0fF
	8D9oBZTpzTxj021FgIh88IB8FMLCmy9XywSUqP+vtS+zanz4aiXul166UTsNzPgCMvz5RZzaNV/
	6ptU+UpX+yFYoywQtVd8=
X-Google-Smtp-Source: AGHT+IFwU8HuYTb9jd/AYa3ObAC+RYxH+tGhlKshlRQR5oBaO/z7Xanxezgu4LnEHBknSYhT4HroTQ==
X-Received: by 2002:a17:907:3d87:b0:ac1:dc6d:af30 with SMTP id a640c23a62f3a-ac738c1b732mr962821966b.39.1743466323890;
        Mon, 31 Mar 2025 17:12:03 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71967ff84sm685601266b.133.2025.03.31.17.12.03
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 17:12:03 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-abbb12bea54so1021085066b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 17:12:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWzuAi664+RN3MCTaGEvdGo4EhK8cxngueBZII3L2cSJ4lgMKmnb/jUsW+2HfUtWTE2EBs2ZasLMndZd8ass47sfM4=@vger.kernel.org
X-Received: by 2002:a17:907:2cc7:b0:ac3:b50c:c95b with SMTP id
 a640c23a62f3a-ac738c6f05amr961651866b.56.1743466322604; Mon, 31 Mar 2025
 17:12:02 -0700 (PDT)
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
 <20250331194251.02a4c238@gandalf.local.home>
In-Reply-To: <20250331194251.02a4c238@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 17:11:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
X-Gm-Features: AQ5f1JqK7DmBOcFeFBdcHQa56oLi7rko5ae58L-hQhqZ-SgnT-hvWfyBuLaYeuE
Message-ID: <CAHk-=wiDQpOeXi_GjKB7Mrh93Zbd__4k+FF_vJd+-prbaacEug@mail.gmail.com>
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

On Mon, 31 Mar 2025 at 16:41, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Hmm, so if we need to map this memory to user space memory, then I can't
> use the method from this patch series, if I have to avoid struct page.
>
> Should I then be using vm_iomap_memory() passing in the physical address?

I actually think that would be the best option in general - it works
*regardless* of the source of the pages (ie it works for pages that
don't have 'struct page' backing, but it works for regular RAM too).

So it avoids any question of how the page was allocated, and it also
avoids the page reference counting overhead.

I thought you did that already for the user mappings - don't use you
remap_pfn_range()?

That's basically the equivalent of vmap_page_range() - you're mapping
a whole range based on physical addresses, not mapping individual
pages.

But I didn't go look, this is from dim and possibly confused memories
from past patches.

> As for architectures that do not have user/kernel data cache coherency, how
> does one flush the page when there's an update on the kernel side so that
> the user side doesn't see stale data?

So if you don't treat this as some kind of 'page' or 'folio' thing,
then the proper function is actually flush_cache_range().

I actually suspect that if you treat things just as an arbitrary range
of memory, it might simplify things in general.

For example, the whole flush_cache_page() thing obviously just flushes
one page. So then you have to artificially iterate over pages rather
than just use the natural range.

HOWEVER.

At this point I have to also admit that you will likely find various
holes in various architecture implementations.

Why?

Because sane architectures don't care (there's basically no testing of
any of this on x86, because x86 is typically always cache coherent
outside of some GPU oddities that are handled by the DRM layer
explicitly, so all of these functions are just no-ops on x86).

And so almost none of this gets any testing in practice. A missed
cache flush doesn't matter on x86 or arm64, and very seldom elsewhere
too.

We do have "flush_cache_range()" calls in the generic MM code, and so
it *should* all work, but honestly, I'd expect there to be bugs in
this area.

Of course, I would expect the same to be true of the page/folio cases,
so I don't think using flush_cache_range() should be any worse, but I
*could* imagine that it's bad in a different way ;)

              Linus
