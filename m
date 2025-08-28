Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE4529AB03
	for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 20:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756413473; cv=none; b=Mafe9DErdMyHm/7Kr1NPG7D+Ju9ik5zoYH3E4CoCD2eg+ZgoEfCv3Xksclih56ZbLWNEwUPNvTy5pIwP1uROrv+C2on3hsw96lbl5Ltd0WFoaEvUDlbi8mWneGip7Q7rM6NtUe5Tpd03su/341//gtA0tylpNngYljO6itUqVJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756413473; c=relaxed/simple;
	bh=y4xkTZyyIp9xVQ83g6/iKJQ8eneIBd8o2R89VeAI4cU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I7EhFHa3F+YuTHDi/CQ6ky+pNo57ZdD3Me0pBP7BdUXxbuadeIzFwFU3vKrkF67hJjDnctJztE1O20+H9Yu0VzvNbf2Aez4Ku6UjKKIwbbf6vJhw5nD6AtqVPYcqub5Ox+3dcyrv+Z8cBEJHqizXKB/M4knL9e2dZv/4unH3vOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V5eb//7P; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V5eb//7P"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-61cc281171cso2402790a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756413470; x=1757018270; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BGpm2okOCdPx1/l3bBzBQf+T/Xu4e5L+15QkBeqqePM=;
        b=V5eb//7PUrcZRroXzosM3AaGn1TqNBoc5cxb9TDwJ8G4L/3gazZveGnpBJf6TWJ9TI
         nq9qUv90iJR6o0IVz1qEoyD9+BXuiLWzAGwnJbEhF3UZZ1TkRmfg+cLxoQTYG3MKN2x9
         i7HrF6LSeFcAv3hWZjH5lQt7eus+4lldL92MI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756413470; x=1757018270;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BGpm2okOCdPx1/l3bBzBQf+T/Xu4e5L+15QkBeqqePM=;
        b=IIBpJZK0PzvCj6ItW/MYz6PYmzptjO02zQ9UwBmNGjWrnPS+KSrLNLa0+lsKw4CqsF
         BG5IxIXXSo7h/fNI/3hAQ0SdQgdp/djqnv28i19AjJ+XeWcyxbSPAvDMLJ61IIgQmI5C
         tWJM0IVFCi0LPWURD3QzsrSDalJ8J02Fexyg3BVJn43wEdBAVLtBWBvMIUxPUOzpQMbX
         9kn6REfbjRl/fgqOt3JlsURfEc7RSHxSlp16yA/Hj6ikmwQ8XWPt0mF9G0WF3b7ud1mc
         /g8WFkd+ye6+gDP9ok2eLTwBHKN6cE+ZZ4X+HArja9Kd7ga1tqj74HGl9CKRgchoTJ2c
         PvqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP89gERkWWHLz7SurtNuhHuL9C9rpk3Qa2syN4cl/hjCeJMcn6CAyRRSwuxYJS6XyorxFEn2InaUNNnnQDuBYhsbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoU4y2yMe7+RgMmToVMdYll6qdQo4NF0tkLM8Hpn2zlvY6YPyG
	EXlANPw85DX7ZBjrWQAOPtU/BRNOi7XPWa87GEMw4Ap056kIBf0Z6rwLk5rCTX8a6ifhLJ6Pukz
	+LIesTbc=
X-Gm-Gg: ASbGncuoOD0EvbLZ+wGXQe7SJiT3wXivmFYKv4wdCA8/sc/l2GvxVlNPepbd4/v7mWN
	frWNvuqlFYlsxw+kSXB7r1Ywp1Sa73W3khSjPVAGJmC43nJLx/sdLExz4ngIyBTuCtePTOOfSg8
	Uw9YFs0SnNQ9g1yvqmge1o0pjFEeDJvP6VjHa3IVK78zKMayLm995M5QZhjFw5DgGZVBEQZloJF
	zpumiEWQOdBJO/nbQXZ9Mi9azBqWVbGnaZjLKJiliht4n16MIn7sKQYdosjn/4ngaRMXl0Gms95
	Umq1OVgH+TS4915tGwa1r8Fw6j5NbBuKdN7IpGIG1H0vZWh+xfvcsNX22lSuIItrxHd8mi24z/h
	tJ7bsoqGuLTJWRP6tyRKkynsIUgw72zgiGTi5QtM15ud4QzgKhDY0h4RyQIsxo+i2+Fp7rbon
X-Google-Smtp-Source: AGHT+IFHRm6NkFgiZbHrrbfunzjqEKiK0oe077rl/fprEUAMP4YZ0M7cqVau6aLQV4naPDQWtlgoWQ==
X-Received: by 2002:a05:6402:5c8:b0:615:957f:416b with SMTP id 4fb4d7f45d1cf-61c1b3b93e2mr21202225a12.6.1756413469757;
        Thu, 28 Aug 2025 13:37:49 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc1c7a10sm361991a12.5.2025.08.28.13.37.46
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 13:37:47 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-afcb78f5df4so241824566b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 28 Aug 2025 13:37:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZurUQhxyEsCat9fjsN4Yv3Y+5QYLI3WLtGvvxKsc9knncg4QcfbKtoklR4NoQBAsATrdng88p2IKJEpu7X47eEJA=@vger.kernel.org
X-Received: by 2002:a17:907:1c17:b0:af9:1184:68b3 with SMTP id
 a640c23a62f3a-afe296358ebmr2525636066b.55.1756413466215; Thu, 28 Aug 2025
 13:37:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <aLC2Vs06UifGU2HZ@x1>
In-Reply-To: <aLC2Vs06UifGU2HZ@x1>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Aug 2025 13:37:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiELUbwzPCKuA7xbN5SGyZSD12q6W6=eK4NfHDcMY58Zg@mail.gmail.com>
X-Gm-Features: Ac12FXwzzxmh7ZDt_iicZFn3gldj2XWLlsQdgYy8wB5yLOCnfQ4IOOdrcFwGY8M
Message-ID: <CAHk-=wiELUbwzPCKuA7xbN5SGyZSD12q6W6=eK4NfHDcMY58Zg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, Steven Rostedt <rostedt@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, x86@kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Florian Weimer <fweimer@redhat.com>, Sam James <sam@gentoo.org>, Kees Cook <kees@kernel.org>, 
	"Carlos O'Donell" <codonell@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 13:04, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> > That said, I think they are problematic too, in that I don't think
> > they are universally available, so if you want to trace some
> > executable without build ids - and there are good reasons to do that -
> > you might hate being limited that way.
>
> Right, but these days gdb (and other traditional tools) supports it and
> downloads it (perf should do it with a one-time sticky question too,
> does it already in some cases, unconditionally, that should be fixed as
> well), most distros have it:

So I'm literally thinking one very valid case is debugging some
third-party binary with tracing.

End result: the whole "most distros have it" is just not relevant to
that situation.

          Linus
