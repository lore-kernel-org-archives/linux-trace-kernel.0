Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C3921C184
	for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743457381; cv=none; b=Bo3eVGUz8yoFLgFLcm1on7o19p1DDgCYhO59uNx2G+HmK3J5sRpwBFd2EHxbPOc8KUPOUqbw5MApLAKki+bVgCjqtHPfnrrAlQjJb88bWrkDCwAJ45AjwJHcVID/JWn7411O2Z9eSdno4WYcC8yI64ndrwVep6yJU8SCr8HzVfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743457381; c=relaxed/simple;
	bh=Lm23pDBVwGuHLb5lixyGc1iJK3RuhTeNRxc+ez3eQY4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JF0tNzRZGPV59OF9ME0SJTaDWbAvCmwOTHi9Vd8Z9n1KB8TGIDt681SfNqLbqql6FnfcxzbaxKvHf9glkK2Wj5t0UQgVN/leTxJZnAQIvjFGvuFFHoEWw4ED5c6gpUgUjIv3OQvjAL3Szv9Ns+opKTf0CrwJRmMFWqkRXD3kb5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Tah7GTQX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Tah7GTQX"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so9680487a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 14:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743457377; x=1744062177; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MPuGyIJoDDjA0SSObIP3jFx1wV25IQcopdyUBR+aHdQ=;
        b=Tah7GTQX+lFoyKRrzi+6yl2dPRi39cxdosD/lBFo7V4dD5X/BByt9YsBEpbWc/Y0tE
         LQwr3jEz0cHc/fQqfZm7NXjOCn/pyr3XCEBs9sz84iFO7x75+UDz7G5l8CzagNfQA2kC
         6yQtL8SOTPp2PAIEp43lmPvVeq3qsr2IWpYCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743457377; x=1744062177;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MPuGyIJoDDjA0SSObIP3jFx1wV25IQcopdyUBR+aHdQ=;
        b=FY6fY8tPngk8vAhKVXEdgdanyI6ORDny1oK/7edESjICcetv1HRwa+aWA4xYdyFCAJ
         lCdG8JKpXEcwu0PxgsCsSREn4jVY7r/ac4XuyD7pUOG3obUDifgELbYzfYYgPjZmkriZ
         jCbxwJ0R1n+HxWZWSHKeop9hIMDDQVfhkbvSzoesRvzXl66barkv3IgGNg7JFl98GDPh
         pDR2XJqz8E+edvLhn49o4AwLbUg4S/Yl42vKZzTnWu34ICumS8rnvfK6qru+PF6mWhaW
         UDjmulpo/IB3h8UFXHhTswI8WFekSvG6KER5RLJsSCYHZE1OUEPQqGnk41Ou9EKOKouO
         Guwg==
X-Forwarded-Encrypted: i=1; AJvYcCWgcJPDyejPoUu940/2HrNBMSCEpmIOkjKGJM88UGTtYuWUlBH5bGX6haoSxF/YwFFpNycL2kp4RiXzoJtCemt9o+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWMPkQPxA+Hbxh5QRHWM83QCJ10ixMMEGlJrbvYJ+unKTw5EKM
	OLB+zH2BLHiJ4tQw9nGYGozYYfbwGKg+L6oMWJBAWiykj05zQV3HCIc3PD0xYIclh8Hdl18iTXZ
	xA6w=
X-Gm-Gg: ASbGncsMECo7trtNbqgct00CwaP/0HVu89ET/+GabuwxiX6ttPrzVrEHlVtvo6MgxMT
	M7iKID+6SVmUuB95q95AfTInC37H4e60llEV7WyJ1Y6hIFWto9J6kgF1Pc+G5XQLE4Vtjj7GboE
	H1CsKTJc7cmwtW65YSB6dAzLXGEOuWDw42Va/UXetEpil1UmvRh9QhcayPPJzApMl3yGiYw4m6Q
	2P/ZnNKQVcy/O2iO5+3tmb80U456/GP17D4d8i67HX3S5SWDsJ8AsrWK0SRdxYEnbeOpqWlre5o
	b8whrh2nd99LEMtskiAbmiDHxvorctL0Pnn6rX3iLZGZctFg0zJiWLSTPqw/DoRCf38TiZiTetX
	LoOrYxpgYQYx94OFpHno=
X-Google-Smtp-Source: AGHT+IFPVEHGPuumrpy4NzKxlH2zdTOdxNYkf7+zPrpRbhSsxZWg9UhQbcah1Zb0f/s8jX+SUUPeww==
X-Received: by 2002:a05:6402:51d2:b0:5e8:bf2a:7e8c with SMTP id 4fb4d7f45d1cf-5edfcc5685emr7932480a12.11.1743457377392;
        Mon, 31 Mar 2025 14:42:57 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc17b2034sm6126988a12.51.2025.03.31.14.42.55
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 14:42:55 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5e5cd420781so9680442a12.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 14:42:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUblnotUD1+nElLLUlFFWbDyMUz0v53u9uDO+EXpMhvCvh7o0nH95vwTCbiC/khEwAoAUinpTqiCKAmtXdlZ9Xj5FQ=@vger.kernel.org
X-Received: by 2002:a17:906:c113:b0:ac3:8988:deda with SMTP id
 a640c23a62f3a-ac738be3371mr773843566b.40.1743457375081; Mon, 31 Mar 2025
 14:42:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331143426.947281958@goodmis.org> <20250331143532.459810712@goodmis.org>
 <CAHk-=whUOfVucfJRt7E0AH+GV41ELmS4wJqxHDnui6Giddfkzw@mail.gmail.com>
 <20250331133906.48e115f5@gandalf.local.home> <CAHk-=wi5pLoe3szxLREQGGJuWU0w_POK9Sv6717UH3b7OvvfjQ@mail.gmail.com>
 <20250331165801.715aba48@gandalf.local.home>
In-Reply-To: <20250331165801.715aba48@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 14:42:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jr_8h8f6PhcZPJ4rHbzRksFJUiGmqKEAvAP7bvcH_lEJ4Zf6XawSyFboTU
Message-ID: <CAHk-=whRNxdkLC6Z91g-_RbrRsUo6K6+nvRWqccjsOycwUe_JQ@mail.gmail.com>
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

On Mon, 31 Mar 2025 at 13:57, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, this only works with RAM.

That's not the issue, actually.

The issue is whether there's a 'struct page'. And "being RAM" does not
mean that a struct page exists.

For example, using "mem=" on the kernel command line will literally
limit the amount of RAM the kernel will use, and in doing so will
limit the page allocations too.

IOW, all of these kernel command line things are *subtle*.

Don't mis-use them by then making assumptions about how they work
today (or how they will work tomorrow).

> I guess you mean E820.

Yes. Thankfully it's been years since I had to use the BIOS
interfaces, so I no longer remember the exact line noise numbers...

> Mike can correct me if I'm wrong, but the memory that was stolen was actual
> memory returned by the system (E820 in x86). It reserves the memory before
> the memory allocation reserves this memory. So what reserve_mem returns is
> valid memory that can be used by memory allocator, but is currently just
> "reserved" which means it wants to prevent the allocator from using it.

That may indeed be true of reserve_mem.

That doesn't make it any better to then use it for 'struct page' when
the MM layer has explicitly been told to ignore it.

Particularly since my first reaction wasn't from "that's wrong", but
from "that's stupid". Generating that temporary array of pages is just
bogus overhead.

> In fact, if you do pull my v2[*] pull request of the ring buffer code (that
> removes this user space mapping of the persistent ring buffer logic) it
> actually adds the ability to free the memory and add it back into the memory
> allocator.

.. and *after* you've given it back to the memory allocator, and it
gets allocated using the page allocators, at that point ahead and use
'struct page' as much as you want.

Before that, don't. Even if it might work. Because you didn't allocate
it as a struct page, and for all you know it might be treated as a
different hotplug memory zone or whatever when given back.

               Linus
