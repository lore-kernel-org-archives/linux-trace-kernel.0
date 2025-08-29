Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6162BEC20
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 22:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756507580; cv=none; b=BAf7Xr0EQcZ1qchNHJpBJYQdoG9gY8HB/pDZNp6yQwzKaL30cAW25eLi6vquuLPTAgAXacD2Uf3E8GzdCH5P3/VhW1+zoTSoUWqZ6VWSpfUvsF5byMJ+VwS+x0azghtfBvSUlYTLKcdzqJiXtfNGbn/ACAFu8sScxwElVy3/Lkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756507580; c=relaxed/simple;
	bh=CtY2mpOi2NxxfnHcuhpi2dhAC8q+hcvmMeWqGSAe4aI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fiWGH0tLlKSR2hqQJiNLVd8gQURx5TIV9t38IdfH5kfycQWGHOFap4EyN06nUzZHoT2nwBKLN1cR3b80Xrf4oZoXj3YGe0zIcwy7PoEVC4hA8Tj/OtYv535lAaCc4488alOYYNrxj9eQRrPc6xe/Os/zhEGNDTJlHCbKiOUa33s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fED7f+9V; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fED7f+9V"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-55f68d7a98aso1152826e87.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756507575; x=1757112375; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=80fI9uxCwh0sulZ4xikoEydehsTfM/BZBcIbW551mMY=;
        b=fED7f+9VkdCKSWI94vPWAMWCOwJgzWxjlT2E1iTThdz7OdbCqbVF03cswuNfeBmJ8P
         euwA304CVFx0E/z7mSvxfMf2wrcXHUdGico+y1dZk8kdlMYfa+gz7zFGO5LutcipNh8H
         42B36YneQVDSFWi+HdL42T9rhvDorJvxPg2GQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756507575; x=1757112375;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=80fI9uxCwh0sulZ4xikoEydehsTfM/BZBcIbW551mMY=;
        b=c5F3l/bMRFFt5vNf2rhvUzAIBrrIlyrNZ44e/sp+V6dgBKk016Xf8fGCjBLCzfXtuh
         dsacbY6HuFuTf5f/GACoaivtJeWNWRb0mfFg4Dji9IjQniLD+akIN0/WeUobw0weXdLV
         BiJ/svwHtb6LW2l568+cCPuiLfGl0HVQNshS4c43sA8sAbrfzljqYbgkExCFUXcHA2Tq
         Vbn31yGOdRpeHLEIgVS60FSNmTzr77g7r5jxoA9xwoa2JeOaSvlbPYVUNnkPldIxtwbH
         9qq2pqNeg26A7JxQKojp2I1HZTYTO2Fo22AyliwsIKjvCM/+z8g41tPQSOdEwlAAUbVn
         1KRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKn12s7Esad6bbLUAiBxGmt8jBSAnnnQhUSKA+VhDj4haRyfXj/uA5pV0Qx3Cuq/5pkzm+IrLFBuJoEUouwImzRWY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyh6Q6LdmczJlMw53ssokTbnm18U1VZAuKiZ2A4NQ9Uq1h2q6Jg
	EcbWxsWywZ8N5FVO2uYId8KG2392VIZ/oQxAY7E+hOBaA4MRlJf3tFH9Qh6aWNBUNsA6K77XGvh
	DGeOPClF0og==
X-Gm-Gg: ASbGncv2oLR3Bcfb1qEDjbrv2zNkWgW3lBFuX0RrE/ivOoAxO3oUpn0nKFq9k85rOoP
	I/ynURm2YHrCGs3AMRTIr4oIWIxDKJMafs7FfkrJXNHUOJzRk1wt0iGnBC23oRutmNc1I7xJuo7
	tcSJ6jWmRLzEPyxxNAQ/bmeXl7lNCShwRvoSAhmJT9pB/v2P28SZY9aC+jv8yNJs9KPmubn7I0e
	0h3448zeezONfMiipQ6mG9BhX7hiEORBxxUTQoj94Jn1RHBnqUMQnE638EUNKzEGGmOy565f+8F
	S9o5dw/ySQ9BxlC6J0IumkF8KmUzOpMGGfROx6yWq0VfArw9DbTWTcqEyafmWwn0931OQOP/NuC
	9dKtbltG16X4V0YeoHgGd9ZwXskTC38oEGqmVjkvurOQ+Uexf9pq9rPtqmwMF9b92t+tzpORvmg
	+TBuSzM+Y=
X-Google-Smtp-Source: AGHT+IHaUBrSI94b/IQYPnXDdtS1I3e/olkVCqwle6TSNj42zWA/IT+eTUI8JEWZeHf9DWbAMWHVPw==
X-Received: by 2002:a05:6512:2513:b0:55f:4cbc:8522 with SMTP id 2adb3069b0e04-55f709060f9mr66345e87.30.1756507575138;
        Fri, 29 Aug 2025 15:46:15 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f67a41910sm934072e87.130.2025.08.29.15.46.14
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 15:46:14 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-55f68d7a98aso1152818e87.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 15:46:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlpMPmtVevzHhcfaC7BLpDXS50u/fKvMNd9D29rqyr29/AgACa+EzQ7MNXPHBymRrvInufqZ0mCUsjotL6BUQCmMM=@vger.kernel.org
X-Received: by 2002:a17:907:c27:b0:afe:63ec:6938 with SMTP id
 a640c23a62f3a-b01d8a308b8mr19318766b.7.1756507224565; Fri, 29 Aug 2025
 15:40:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828161718.77cb6e61@batman.local.home>
 <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home> <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
 <20250829124922.6826cfe6@gandalf.local.home> <CAHk-=wid_71e2FQ-kZ-=aGTkBxDjLwtWqcsuNSxrarnU4ewFCg@mail.gmail.com>
 <6B146FF6-B84E-40A2-A4FA-ABD5576BF463@gmail.com> <CAHk-=wjgdKtBAAu10W04VTktRcgEMZu+92sf1PW-TV-cfZO3OQ@mail.gmail.com>
 <20250829141142.3ffc8111@gandalf.local.home> <CAHk-=wh8QVL4rb_17+6NfxW=AF-HS0WarMmq-nYm42akG0-Gbg@mail.gmail.com>
 <20250829171855.64f2cbfc@gandalf.local.home>
In-Reply-To: <20250829171855.64f2cbfc@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 15:40:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
X-Gm-Features: Ac12FXyqIi5ZrrVYAf6L3CbDdFJBIuaHmGG9fnmZTA9Sh2oSS7jS6S2QKEpzFcY
Message-ID: <CAHk-=wj7rL47QetC+e70y7pgyH4v7Q2vcSZatRsCk+Z6urA3hw@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 29 Aug 2025 at 14:18, Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > Just do the parsing at parse time. End of story.
>
> What does "parsing at parse time" mean?

In user space. When parsing the trace events.

Not in kernel space, when generating the events.

Arnaldo already said it was workable.

> When I get a user space stack trace, I get the virtual addresses of each of
> the user space functions. This is saved into an user stack trace event in
> the ring buffer that usually gets mapped right to a file for post
> processing.
>
> I still do the:
>
>  user_stack_trace() {
>    foreach addr each stack frame
>       vma = vma_lookup(mm, addr);
>       callchain[i++] = (addr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
>
> Are you saying that this shouldn't be done either?

I'm saying that's ALL that should be done. And then that *ONE* single thing:

     callchain_filehash[i++] = hash(vma->vm_file);

BUT NOTHING ELSE.

None of that trace_file_map() garbage.

None of that add_into_hash() garbage.

NOTHING like that. You don't look at the hash. You don't "register"
it. You don't touch it in any way. You literally just use it as a
value, and user space will figure it out later. At event parsing time.

At most, you could have some trivial optimization to avoid hashing the
same pointer twice, ie have some single-entry cache of "it's still the
same file pointer, I'll just use the same hash I calculated last
time".

And I mean *single*-level, because siphash is fast enough that doing
anything *more* than that is going to be slower than just
re-calculating the hash.

In fact, you should probably do that optimization at the whole
vma_lookup() level, and try to not look up the same vma multiple times
when a common situation is probably that you'll have multiple stack
frames all with entries pointing to the same executable (or library)
mapping. Because "vma_lookup()" is likely about as expensive as the
hashing is.

           Linus
