Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9543BEEDE
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Apr 2025 01:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743472565; cv=none; b=Q7cF1zGRHHlNZ7ZTcyFhiHM3x9ZRoiyeBpZCiQY943BcZLLgSMxeGfkrla9gOu3Xmt3bgJOaRUO+Tvjv8jaExhGZyC8L+VJlSJ+yKLtkeJktNyZDfr3UwMiiC1i4hDuE47Hv9Vp9q4Mx3AKDZMpnRFZ09BJqmAbKq1bZMa0LFDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743472565; c=relaxed/simple;
	bh=oYdy5TUOKD3/QmBchtEfluPYVm4jH9Npv+xFiaubOWk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPM6ge7Ln76c2s9cWZTG5uee+ugIvgJTwgoGntc2QBQZQKveRrwLwTL6olABCt3ntZHZW4crZx+0cXtGEoW1MMwWTBeak5iYAP7Ew+1QrjG8CgfIXDTM83HGmcS/TpR97A/UgLVdlcLaNivk60EvD1X6YNt/EDJHNfY6psAvbtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RJV8Ogkx; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RJV8Ogkx"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so8070454a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 18:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743472562; x=1744077362; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xTFYf6OdHdCoXwqeAxP2OyQHhkHeGJVwqSUrO9x7fRM=;
        b=RJV8OgkxVltvH7XZinLrmhiX7qtQhX0uJ6PsAb7KxEqaWz2CYD5c4w0kE0E9Du9hnb
         wIH0dx2p+mElABxkSDBrIBuPxBut1AyXsWFUoXruBsVTEEpY8DDZZIuQdOHxM3EgtGJv
         0dbqJx3ym3c4fxSChwZsec58yIZxKp6IgS7yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743472562; x=1744077362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTFYf6OdHdCoXwqeAxP2OyQHhkHeGJVwqSUrO9x7fRM=;
        b=HbFjpTZyiFsWAe9mL8hvFHFiSBEm/qXAdRNpftMqDGAcIPBEJpwEDUSXwB99t8VZzV
         IBAvIy2Edq+C/BWz1dYVJHUOQg+fXlcBhSgAsxxRawMBxEdEusFgl01XEVT+yYsIPgoO
         aqE3BBwawgfevImZLv6vRPdTjUL3zXaQY655hEdczIF5lmgUmUH3rPX9hIg3UaCcjt4D
         bfTj/1eskI520TCnjgXlaNMDUgLjWlG/whxFjeJ+AKy5WwH6ZVUsnMWnGGNb9asmfXLe
         xUZRX20Bi8VAmv5qdAKSQAJWFGzEBoSGV/BL7CSKn5tNMU+klvdtDmDOIH3KVszd6cpo
         f5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXeUL4TOLANn/JNdqeKp41PnqjXVSL0c9nDFomvnVo78IaVaQX2hsSGb9FqRc1joBtA5F2HqTidiU7B7o8KyBO7YaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwutHHQnjhMO39x8+jebpgUB/69KkD1XIojSPuFqFsn0I7lbYoa
	QDkeNu7H3HCI+kFcI+lJM3PiQFdRKzyvzmzm5trrbYZpdxveLwGRGFbqmS7YBg9pismUwrkTKii
	Zg1Y=
X-Gm-Gg: ASbGncsXWJ0qMJz5uZPY/aAhCRD3yIyClpAFr/Yf982iA+fse2ObF5NHMGl+B/06uMw
	46Ydh/3BZwC7tMmdiCWvc/UTmngYnCyU8n4ev/slmrTel7nuu5agf4RdmJBfHvfMevN5BxHD+lU
	7uTWrNxXfuHona4pdrxWzSgThNuMKaNk5kWPPJ4IniXD3wtAdQVr0OjrI4xBMhhPZZGX/tTfuq+
	WpXs+9fb5Lo8GJPRIfSvIiKC8p6/wcYP+T5H2Blsq12pnMKJg+nDqBhjpKOQnAWxCpY4w1RnctL
	OAqRemliWnogpth5G7HBRa3xUEVw3IsbW22I38eeCaQD9UnGQUyS9cBNRovZ3/t3P5VjONJDhEj
	Nrn4A6jzx8tssu78mEjM=
X-Google-Smtp-Source: AGHT+IGJ3lEjwVBs7dNYAj5ZzuMNKgC+cJ2CiR7EEsNrMD4Cl9+yKAbBLC35WjzaP1xeY+7G62Ncag==
X-Received: by 2002:a05:6402:2793:b0:5ec:939e:a60e with SMTP id 4fb4d7f45d1cf-5edfb36bf62mr8634021a12.0.1743472561691;
        Mon, 31 Mar 2025 18:56:01 -0700 (PDT)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com. [209.85.218.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edd5c52379sm5341370a12.8.2025.03.31.18.55.59
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Mar 2025 18:56:00 -0700 (PDT)
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-ac2963dc379so805249266b.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 31 Mar 2025 18:55:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiEJHKOyPAMivKQozkpevLEB/dZb7FONRZJHCY2a98jrvDs2Zb6W3sF4DuJ1hnkmOfPbcD2CrwlZrfdlHNAWwzQTc=@vger.kernel.org
X-Received: by 2002:a17:907:3f11:b0:ac7:31a4:d4e9 with SMTP id
 a640c23a62f3a-ac73892d538mr981403666b.4.1743472559324; Mon, 31 Mar 2025
 18:55:59 -0700 (PDT)
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
 <20250331210245.585fff23@gandalf.local.home> <CAHk-=wi=GNaLzNt5zjee6m9OHNvr=Sc1S-xsnS0cNMfdVp15hg@mail.gmail.com>
 <20250331214132.49622459@gandalf.local.home>
In-Reply-To: <20250331214132.49622459@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 31 Mar 2025 18:55:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjijTKpotANjhqoKrEFh=B=RLrfGWa7OFB2WJ9RU8jaaA@mail.gmail.com>
X-Gm-Features: AQ5f1Jo416MyRwMxGTnNWGGwQsK3CtyiS56wd70ogS4-q5i40HxlCHES0ZWgQ4M
Message-ID: <CAHk-=wjijTKpotANjhqoKrEFh=B=RLrfGWa7OFB2WJ9RU8jaaA@mail.gmail.com>
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

On Mon, 31 Mar 2025 at 18:40, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > I think 'pfn' was introduced as a name ong long ago because it was
> > what the alpha architecture used in the VM documentation. It probably
> > predates that too, but it's where I got it from, iirc.
> >
>
> It is old, as I remember using it when I first started Linux kernel
> development back in 1998.

So I did the alpha port in '95, but I meant that the 'page frame
number' as a name may well have roots that go much further back. I
only know it from the alpha architecture docs.

Google only seems to find the modern Linux use, but I wouldn't be
surprised if the alpha architects got it from some much older use (I
would suspect VMS).

> But my memory of it was it was also used as an
> index into a struct page array.

So typically, the pfn is what is used to translate different kinds of addresses.

And yes, one such translation is "turn virtual address into physical
address, then turn that into the pfn, and then use that to index the
array of 'struct page'.

Few places use the pfn itself as the primary thing, but one of those
few things is the low-level page table code. Because page table
entries are literally a combination of the pfn and various per-page
information (protection bits, cacheability, stuff like that).

So to the page table code, 'pfn' is kind of fundamental.

Example: the actual low-level "create a page table entry" is
"pfn_pte()" which takes a pfn and the protection bits.

That's the basis from which all the other page table entry functions
are based on, even if you often have wrapper helpers to hide the 'pfn'
part from users, and you might have seen mk_pte() which takes a
'struct page' and the protection bits. That one just turns the page
into a pfn and then used pfn_pte().

            Linus
