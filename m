Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9602AD21
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Apr 2025 01:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743471057; cv=none; b=lNYgMyS7jNhnjQxe95iF/aN1ewwB0R4FGh9R0TGpxXZez+2sbPfYpx9upM8Of+LV9W3XVC41NcarqWpGlZtvwBeoZ5ey3uFkyXiGzcPfvkMeplY6QHXvutvmhBjhGyrJ91mpKlYYll+VA9S+ZUxrZ3X4ZLngUXKlkdAW1NOtN4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743471057; c=relaxed/simple;
	bh=ZrZnWSEQfOVCXfCXId9BoQTQz62E8du+T3QQHmnRCcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRiX7+YOct7vobYEc/0MBDT/TObE3m/gpENPCDB8Hx+c2xbNoJCLnQCq+o5IsVici5y9ihzj4v5/BO5kYQCVs0KZV0KEP3+nkTTjbLTDaj7b5UM6xkjEU3A8KFkYvFmTyNnJz/vCii5QeQVUlAqFvLarydbwPvLiJbyXYnKAFBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ENRriU99; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ENRriU99"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5b6f3025dso7929483a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 18:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743471053; x=1744075853; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hobhqw8HB8gJ+OpvQWZBbfhBUu6vl3N3/WGeelA1Yck=;
        b=ENRriU99VtSrBlAypHPMkdwsoepkd8sja/HhtntVr/O3B2bdXa+Se48/nkZnzPaHTO
         lKrBt3LIw1tV3DbUK1YX4CQpHr5O5u865/k2TMrEUCR2eWaCcKAQt6RWg0h00DBVzwot
         29zYZmQ5vLbDKEkthdwItgVLjUxE8MYrqP+5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743471053; x=1744075853;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hobhqw8HB8gJ+OpvQWZBbfhBUu6vl3N3/WGeelA1Yck=;
        b=Fe/CZChg+UYcOGDDeUDeyuuDOQDn0/u/XbhRlMJ9r+dnEkjpZnXNAHhGbVlPa+LpnD
         Ynorxad8/wCm0hqifoFkGOLYeqAoDr1nAIZqULBG6gxWD6yywoiEVAfjw1gHDUYD2hyu
         wLnrH5JDC5Xt9zpW5E5ZCde+wO20LbyPhUm2cFJ5aMn9qKD6bwfyVwX3VPB3hcE3/Rp7
         s+0WRC6IWnQFObr1t1CAjlh0LrimZzNgdq5mF2fvmGThgSqD3sASBx89CHeFM1k6S39A
         2miBydu5OmwDsLGSgbZXcFg2ZOAmwdBevw3qgCfab07aMC2HlYL+PVoycmcfD8iruwG5
         +8Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUOC4FdtDaaB2G/TCnl0Omr7XIJWjQkWQ7Gc0hnZBwcSCRCjgbLrjaC+P/sMG5nx67oqvr95dDY3xswfx6tsVRbLzw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgUzEyJdQC4yibzvH3gqrBiOy4z1UmbFcR9upYqM9mRVAyLwe5
	XSMJE+7ke/Cko0CxuA45vCg8oBg0QsGiO+FZUMuEMIgi5ltUsn5Tq041FnGWmLYEP0CJm0X4lxo
	z5b4=
X-Gm-Gg: ASbGncv9TT565pdhTYEyaph8dvdTej8WS8NkzsrrEQIZXj4039rSTWRB3EOJsO3//ci
	CvWMH8YqPX7oZVJzINyqQ8mRkALFd25ZHhVuPIcbqLF24WZFCB488HM6m0iDR0qjq1innQ8oOXX
	Yp/7PjBhinnXznTOCW5Fn+76TF46gE5/fbjZ1gkgOkp6wu6RTT9qZKU/t+jUbWMvjqJg4SshOI2
	vYtjv8pdBdPOfppNSOSgXoBACUQzDvzSEuwCzdTyRLnSZKtHuejRjr/O0ZmaFw0TQ7M73oEuKbD
	jmWE6IRyhoSgrvtEz2ey90SFN8v67u8vVCMAbTytjA/BJzfjI0PUlLIboStYKyNUXxlbmPxGhsm
	JhMVq9jTmRSy4MlCrXZo=
X-Google-Smtp-Source: AGHT+IEiskk0xO8azkLdr00tmwHWyQtQGgMclhEDalV9xMVqBDxADYuDF+R6dyKmn+AJcopT806M9g==
X-Received: by 2002:a17:907:96a5:b0:ac3:f494:c0a2 with SMTP id a640c23a62f3a-ac7389e3c03mr822873066b.13.1743471053046;
        Mon, 31 Mar 2025 18:30:53 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7196dd20fsm689877666b.165.2025.03.31.18.30.50
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 18:30:51 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac345bd8e13so853043166b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 18:30:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU3p8zpjVa+ue3LBxaXuvpNlp89yxMWMgSqkfuZ2mS33nu1iB1mZ0kRZtPpxbMVjcdIXMdcsFp5n2qx2rMpoYBhi2k=@vger.kernel.org
X-Received: by 2002:a17:906:94e:b0:ac7:7e2c:68e9 with SMTP id
 a640c23a62f3a-ac77e2c72ecmr169045266b.25.1743471050531; Mon, 31 Mar 2025
 18:30:50 -0700 (PDT)
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
 <20250331194251.02a4c238@gandalf.local.home> <CAG48ez3w0my4Rwttbc5tEbNsme6tc0mrSN95thjXUFaJ3aQ6SA@mail.gmail.com>
 <20250331210245.585fff23@gandalf.local.home>
In-Reply-To: <20250331210245.585fff23@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 18:30:33 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=GNaLzNt5zjee6m9OHNvr=Sc1S-xsnS0cNMfdVp15hg@mail.gmail.com>
X-Gm-Features: AQ5f1JqTHDgiJbxdZ1rnfePfFiTU7-9XsI1CRh3n0IspxIqnhuyKNGYHhQ9hJTY
Message-ID: <CAHk-=wi=GNaLzNt5zjee6m9OHNvr=Sc1S-xsnS0cNMfdVp15hg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tracing: ring-buffer: Have the ring buffer code do
 the vmap of physical memory
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, 
	Tony Luck <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
	linux-hardening@vger.kernel.org, Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 31 Mar 2025 at 18:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Note, I believe that Linus brought up the issue that because this physical
> memory is not currently part of the memory allocator (it's not aware of it
> yet), that the getting struct page or a "pfn" for it may not be reliable.

'pfn' is always reliable.

The pfn ('page frame number') is literally just the physical address
expressed in 'page units', ie just shifted down by the page shift.

So pfn and phys_addr_t are interchangeable when it comes to mapping
pages. The pfn is in fact often the preferred form, because on 32-bit
architectures a pfn is 32-bit, but a phys_addr_t is often 64-bit and
generates extra code.

I think 'pfn' was introduced as a name ong long ago because it was
what the alpha architecture used in the VM documentation. It probably
predates that too, but it's where I got it from, iirc.

              Linus
