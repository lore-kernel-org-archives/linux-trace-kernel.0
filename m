Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA4186347
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 19:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743448350; cv=none; b=bkTPjJ1q/QbR6+UCxqemswzKHvchkub4wU7wuE0u8bOzmIDmZaqjEqewxk03VZWuJCsmbwAN0HcVuzqVhr2qQrkws3JldfDedvfI0ePNQ3qjHNNONcMfX0gAfB/mC7spaJ+/kFSZal+mV8zBr1tkrXBWaBAg7YKkNF8nSwnIXOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743448350; c=relaxed/simple;
	bh=PV4ZWuWia5BRoS43j+c6MY1tfA+wTbXjkY0S7EwOtLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ot1y4mQbrnnF8d6LtFihbtch0AbfuQFhvLjBBdLaDvfVXAWnctK1by31OehxGZ3mBg9HMDotbY6XQLu4EHY9bXv3vlAmJIm1kQ/v3YqBZMpAlLyQxzE/L4WN97H4JgmvSPivrcHDQIA5OShsVAOBG6WIl5LJ6/MCfk6l/SXyuZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XKPDXeOB; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XKPDXeOB"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso965538766b.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 12:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743448347; x=1744053147; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CAyEvyF8shhlI0zeiTAETM+fQKaZCzqYYXdl5MvqdzQ=;
        b=XKPDXeOBFA/d+PsWHXYk+mDmBVw91oBq0Oozb9nS176VLTwhL/9UBwETf/+8PU8Ow/
         EDZMbzYWvBDghf8ea9HpY3jhVh7XMHRYkySeB44V3D94qQjmTPwiYlq50f2UVefM3p6g
         F5wYqxUZvgvehBJKiNjUcKQ1Kkx7GQB3T+iYU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743448347; x=1744053147;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAyEvyF8shhlI0zeiTAETM+fQKaZCzqYYXdl5MvqdzQ=;
        b=TftMV3HtNSLMxXEC+J6oJnECwR60wrJKSf2fiNrcm/iy2TT2MXF16YE/4M4i59hb3H
         B3qKHAIZWm1aLwZTKVWVCeiRvuEEGe7rROoAJIkE5bJWUcWOsRifHBwrNcIZOGFdKsrL
         JHLTfWMhtjSiXAgTQKQ2SdbeXS4EuVp29xY62qyGKdFOYBh3tHESodseebMympwMr445
         D5bHpWZl3pGHSQBa2KOSf/ZRWbuwrN01gdWRpT+KOJBO4jwPCT+BVSB/dyJTzIYQKtFs
         JISIcTByjZdXQzQtuxFUPnHgthNLBsFnJLt6vSU3jzo86mUWmTNH6RbBR7IYH0L8n7Rb
         Kx8g==
X-Forwarded-Encrypted: i=1; AJvYcCXYXrdCRfewXKZVpeDwM65unz1vZpCKnHCaxHVRFWhQoU/1RYJAFdUvsyWPnjO2tam3niTAVQztQiy6MmkoyY1bJyg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOSpDZGCoUdrgi6RcM7xOpUGdPZGTfIzq41rCpw8EnaIKTUB05
	QEl4WKRoCMAb/v9XX2wvi5N3dNg7EpXDw/ZNp0C8MbG3h7ht0kszpYyXNpK5ieiEvLEHp3KiC82
	2cX0=
X-Gm-Gg: ASbGncsDE6F2xc09DlZDCuwikeEccUV2x1lPdoeufBchvAdymjKvzja9bfAoMn5xz8P
	1Qw0Mv1z/9jyqmrWAcCg3IO6hsemlUMWOgXyAsn/RcuxVV5KAlNsU0FvvHZycmsic/J8fMOGePn
	qPHgV6JkKQBsePUR2Ehp8zXygoAjnjIj58A/rVEp/a7MuAyEROI6Ua1GqijdDw5gl2VD7GtyyXl
	ddd4vDfU2XVNtDZEQ3z2LUR1yfWcHFvwSQ1EYTcLaIDNnnsIWUnGSzuCnlkTsBscf0GHbIOproY
	JWcDD6C5mB/8O6E8cH8Uw2yLOjT+beCtsfvQkwoAeSvsGFQA51TkheRaNeTYOLEzo4vQNRxI49N
	VDBLwM77+lhZai6d9/Q4=
X-Google-Smtp-Source: AGHT+IFGZCKtWWzXrIXXAJtu0E1AEFACIUJldLYfEK46G7RYz8EzHhhVO5QU++TG2mf5avkc74mNgA==
X-Received: by 2002:a17:906:c108:b0:ac3:bd68:24f0 with SMTP id a640c23a62f3a-ac782af62cfmr33675566b.7.1743448346557;
        Mon, 31 Mar 2025 12:12:26 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71967fd28sm660600866b.126.2025.03.31.12.12.25
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 12:12:25 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e6ff035e9aso4482411a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 12:12:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVsH566hMCVNjlP8r+D33pCDF6NAA94y3/iqG799zvQRE3L75dMxoLOkrE/x3FkVQrCwHWIwPN1JZF0fvkC8lOePVw=@vger.kernel.org
X-Received: by 2002:a17:907:2cc5:b0:abf:73ba:fd60 with SMTP id
 a640c23a62f3a-ac782be130dmr33191366b.29.1743448345444; Mon, 31 Mar 2025
 12:12:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com> <20250331133906.48e115f5@gandalf.local.home>
In-Reply-To: <20250331133906.48e115f5@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 12:12:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
X-Gm-Features: AQ5f1JpTB-4kVjtmNv0aborYt6qti1nP5IpkPDDowc_-kPaTaqaDeELjzSuvoaw
Message-ID: <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Kees Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 10:38, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I just did this to be robust in case what was passed in was not aligned. In
> all my use cases, it is.

I really think that ALIGN() is absolutely the opposite of robust.

It silently just makes incorrect values generate incorrect code.

Robust is dealing correctly with incorrect values, not making it
incorrect data just create even more incorrect data.

> OK, so I did copy this from fs/pstore/ram_core.c as this does basically the
> same thing as pstore. And it looks like pstore should be updated too.

Please just stop copying code from random drivers or filesystems.

Christ.

I've said this before: core kernel code has higher quality
requirements than random drivers (or even random filesystems).

You can't copy crazy incorrect snippets from random sources and put it
in core kernel code.

> This is due to what the "reserve_mem" kernel command line feature gives
> back. It reserves physical memory that is not part of the kernel memory
> allocator (it also works with memmap ie. memmap=12M$0x284500000, which also
> requires physical memory addresses that are not part of the memory
> allocator).

Yeah, so in that case turning those into "struct page *" is
horrendously wrong, because you've literally taken it away from the
memory management.

If it's not part of the kernel memory allocator, it does not
necessarily have a "struct page *" associated with it. Using a pointer
to 'struct page' and passing it off is just fundamentally more than a
bug: it's seriously and deeply broken.

It's probably much more obviously broken if the physical addresses
came from a PCI device, and this all just happens to work because it's
actually real RAM and we ended up having a 'struct page []' for it for
some random reason.

But the generral rule is that if all you have physical RAM addresses,
you can use them as phys_addr_t (or turn them into pfn's, which is
just the page index of the physical address).

I think that *completely* bogus code worked only entirely due to luck
- the 'struct page *' was never actually dereferenced, and it got
turned back into a pfn and then a page table entry by the vmap code
using purely address arithmetic (page_to_phys() and page_to_pfn()).

So it probably only ever used pointer calculations, although some of
those actually can end up depending on dereferencing 'struct page' (to
find the base zone of the page, to find the mapping).

Add even with just pointer games, that should actually have triggered
a warning in vmap_pages_pte_range() from this:

                if (WARN_ON(!pfn_valid(page_to_pfn(page))))

which I suspect means that we actually *do* end up having 'struct
page' backing for those..

Looking closer...

I think what happened is that reserve_mem() actually does end up
giving you pages that have the 'struct page' backing store even if
they aren't mapped. Which makes the 'struct page' pointer stuff work,
and those pages end up working as 'reserved pages'.

And I suspect that happens exactly because we had users that mis-used
these 'struct page *' things, so it might even be intentional.

Or it might just be because that memory *has* been in the E280 memory
map before it was reserved, and the 'strict page' arrays may have been
sized for the original E280 information, not the "after stealing"
information.

I didn't go look into that early memory reservation code, but I would
not be surprised if there have been fixups to work around bugs like
this. I haven't had to look at it in ages, but maybe the bootmem code
knows that bootmem allocations then might be given back to the VM and
need to have those 'struct page' backing store things

Or - and this is also entirely possible - maybe you were just very
lucky indeed because the code to allocate the 'struct page' regions
ends up intentionally over-allocating and rounding things up.

Because of how the buddy allocator works, each 'struct page' array
needs to be rounded up to the maximum page allocation, so I think we
always allocate the page arrays of a memory zone up to at least
PAGE_SIZE << NR_PAGE_ORDERS boundaries (so 8MB-aligned, I think). So
there's fundamnetally some slop in there.

Anyway, if you allocated them as physical addresses outside of the
regular MM code, you should not use 'struct page' in *any* form.  You
really can't just turn any random physical address into a page, unless
it came from the page allocator.

And yes, I'm not at all surprised that we'd have other mis-users of
this. We have some very historical code that depends on reserved pages
going back all the way to linux-0.01 I suspect, because things like
the original VGA code knew that the physical addresses were in the
BIOS hole region that was backed by 'struct page'.

                Linus
