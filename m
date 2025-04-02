Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A568433993
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Apr 2025 17:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743614482; cv=none; b=jl8S+TK0xbcQM9zCmy607UiJh1deH4wlmvHdft+OW6N5jmN6RjdTsQkzNBtRooyywKEUegiyroPOOO13ruVUU+0py4p4OSS9+xaSm7CkzKXJSClhDH8bjFZ1pB63oskr4eoOoBuG7KGL0IS/uPzE9n1iojhtEGiWKJx/kyWeVn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743614482; c=relaxed/simple;
	bh=k5xDm6mGlZ8vuRoeZQT0VetoI+YvlRo0/tJyonyRNUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfJ33yz/1ErPy4uFc0Ptc1ctVslYPNwbj2JgK3FUIVTighotFLEj/Szo8fxf/SyN0DVn6AHDX9IORkxCyMrA8BuZyrSx8+6ikNcogLFmSIkh9uRN8HmN/upbsczWUwC9taKd56rMF3fbUlO4vuqmQq0nzBQeoorTqWCTXa8hQC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Qxt8PzW9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Qxt8PzW9"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so98197a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Apr 2025 10:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743614477; x=1744219277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=O+oYmiVP18Gxif9XyRPLTYtLtyscgQVNHwN3UpMY9Ws=;
        b=Qxt8PzW97E5kdXePzweNKKwjpoZsmI2C4PyfFojTrngTNco73CjQWcHIAd+J0jTeAQ
         ZLjIHeaFuAEqNWAVd85Bn5Cv8BnNxy2f8UJT4Y7wglall7607QtBBSFTzZKu/pkXCoRJ
         WYaOWzvotq5ok96wnx4Og7QYp+C07FTX26T8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743614477; x=1744219277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O+oYmiVP18Gxif9XyRPLTYtLtyscgQVNHwN3UpMY9Ws=;
        b=iWK0PtpmrI6yoCx16346bcBj43bPjCfnJVFTtY91Wj8xubROzPfVIrITL3/97tWc+A
         YJUMGUo2zj9+WtVUoOXok+XrpGc+VHEgfechV0NqOs+zmHrbBqpPJrGddUAxrTnjEGRA
         l59Qj8ajriWl3Hcc+sN7T/hRzug/FEKoRZwynJPJz99kUf8+gA38DXzFxGCS0JndpcWi
         GTPJBSEZ4Wp57sTRvK9FB6uT3ElNR9BTuhjlT4zPJKKEbgJe5kDzjLfvKhWEHpQDcYHk
         E6izzhLnKNMsbTKZdakqlWa2gCZotOzCwhNJfQg4JObDJW4yW+3okMIUxlikjUG5xmhW
         m8XA==
X-Forwarded-Encrypted: i=1; AJvYcCV1QB2ZFMrEhh/mszBlvqrwQ6/m2jzmvT/rbsoUHCKMhVuoFmjjTyfeXLZSWiXa0WSAtusaLU9Qd1CIip1ilqi15bU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy91fxouH9APvRSkNF07gqZwxQ35LV1oOTS/pxtMJ85vqSAZrCw
	gLJ0IDSXUFTB9pgMme/XPskk2zsCbNCoEskQnYKN74i99oJipUmYvt8/wgGhrtaFK0rBqH4a57a
	lJrE=
X-Gm-Gg: ASbGncvMEKUWWRXg4c7wJfymaCR5OHpOcsso7PVq8HorBKzdFJQQhGB2/wb51UrWoZe
	Hb/D6axsP9Ok1GEz6EqW90tgMZbyqj6uUEXpaytlJoqoVGvtmtVfvPdfcwZ3GxVBCk3Kwpj7t6T
	GMcnC17S7waq4MIDI2t2nLGHFS4FItVp8A0/wHAI0qMZ6RlnVU8Kt2VJknSoip3XBbh7OPbzMZg
	7cxiK0Apnacw+jpEdiX3NJOMh1MOseABNGxKeTX3TviSXfM9Kplspr6YdqGcMZ2ZldclXlT0VsH
	vHiPlByUvH1XrEeWg0uHQcCcuKx6Lhqoxcz1DVsi53h+7vMeZxdbDMIsLg1u75u7Ylwk1RKdMpq
	2Vq5XhBn70yUNjaJs5qA=
X-Google-Smtp-Source: AGHT+IHaff2H+8ysZbrPrLLm/D64h6UENXPO3MeAHtwd26+q69rSZNTeI57x7IThQg0uxm25XKsMbw==
X-Received: by 2002:a05:6402:4310:b0:5e8:c0a7:4244 with SMTP id 4fb4d7f45d1cf-5edfce78954mr14593307a12.9.1743614477583;
        Wed, 02 Apr 2025 10:21:17 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16d5f15sm8666402a12.31.2025.04.02.10.21.16
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 10:21:16 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac298c8fa50so1085966b.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Apr 2025 10:21:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXBpkBzCS5r9MNHuqUKPtGnUtXvU8eoJVkdHXf01sd4ctO8eZmLSGaelnJ8W0PMD7uCaxL2zxrS7evaHKbBqm2z0SA=@vger.kernel.org
X-Received: by 2002:a17:907:60d0:b0:ac2:88d5:770b with SMTP id
 a640c23a62f3a-ac738a15161mr1476492366b.25.1743614476524; Wed, 02 Apr 2025
 10:21:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250401225811.008143218@goodmis.org> <20250401225842.597899085@goodmis.org>
 <CAHk-=wifCDa6FfRKzeioYuEqJFTeXnYQ1DpeuYsmmn59NWuakQ@mail.gmail.com>
 <20250402125548.02cc57d0@gandalf.local.home> <20250402130337.5de5a8cf@gandalf.local.home>
 <20250402131431.218d3458@gandalf.local.home>
In-Reply-To: <20250402131431.218d3458@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Apr 2025 10:20:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh8=QAC0jjcjDRnmsmd2xDf97j8h25=aSFGeh9x+1X8UA@mail.gmail.com>
X-Gm-Features: AQ5f1Jrj_v-ToJ_59gXDObEDMdyMiGgQHzUwM5XVrTzGa6wjo_Apt9gesD2z3sg
Message-ID: <CAHk-=wh8=QAC0jjcjDRnmsmd2xDf97j8h25=aSFGeh9x+1X8UA@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] tracing: Use vmap_page_range() to map memmap ring buffer
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vincent Donnefort <vdonnefort@google.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, 
	Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Apr 2025 at 10:13, Steven Rostedt <rostedt@goodmis.org> wrote:
>
>         /* If the buffer is not part of the normal memory, do not allow mapping */
>         if (!virt_addr_valid(cpu_buffer->reader_page->page))
>                 return -ENODEV;

Honestly, virt_addr_valid() is pretty much random.

It's not really a valid function outside of random debugging code. It
has no real semantics. The comment saying that it validates some kind
of 'virt_to_page()' thing is pure garbage.

> As the buffer can come from anywhere, but we only allow a memory mapping to
> user space if the buffer is from the normal memory allocator.

You should damn well keep track of where the memory comes from.

You can't just say "I'll take random shit, and then I'll ask the VM what it is".

Stop it.

If the address came from something you consider trustworthy, then just
trust it. If some admin person gave you garbage, it's better to just
get a random oops than to have random bogus code.

                 Linus
