Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37A8101DE
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756484943; cv=none; b=iNMVd7TgZCoeEyuh2CpGOReIKSjiRddznSTA11tikeAUUmigxVgesG8bY4KBDXJuKE6gtGBTJ4IArRFU7DFAsuMMqZRagx32xnW2y0Y4e2hFn7m23DZUZUf+Toep/94byM478yl1KQKJaOcHQGqfRmcr2+JDKFlhSMxr0PMHjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756484943; c=relaxed/simple;
	bh=JAYlCBf5lvQf2RAI2BCV6usuwiQQx3hpU17cVIVxX3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmAAuH/YWEvLawUP8+aT4ZoWGAgWUTnzavSnLlGMayX+Dg1YadzMx8SEnW4dO+WG0WmJN1NerHRygJMPWn8LlJJy4UT3GlNZFTGwNWCZtDd4rNF/ski+vegZ/2NKQGqieCIycPFpa8GQufVtNE4G21BYX2PzUWpEs+qILQ0HIcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AhpQWR63; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AhpQWR63"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afede1b3d05so403579166b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756484939; x=1757089739; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ayhtkB5kKKP+MCd/lsnF5BgjvtsGJ8UuOa5gag5oWTg=;
        b=AhpQWR63yX6QlnDCVzNemeg1aUhg+sk84+aLyn2Cw33yghbV+HYDAV8pTHmUmkNe5z
         ISvF5uEx7Mss53N1JiT1LmpbdPAxQbWZieI4FTKDYpUispwEHXN8kghS+OeLuagrky3J
         bYBwupT9wc1MWRbgFhjR0i0UY5BacIL+3bFrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756484939; x=1757089739;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ayhtkB5kKKP+MCd/lsnF5BgjvtsGJ8UuOa5gag5oWTg=;
        b=PG9jUbNRzXc5pmvXsHIJpt5hWYexAJEuq9E7rPEXR2HhE8hjGH7p5Lg8mS2AxeyrFL
         9zyN6X6JmkBG17tmLK9xhZMR8NNxBiwjqQ4ZmWLD5xPLy/Vu2YEf7FdM0+DZuzOz1zNf
         GUvdjZdLrUL+WXCIg7vkLOJYnKUfOTSyZdJnlGbG3mcAFFI3si0PDJX7PCYY2aLpgRhB
         0bGMcSlIiqGpQD7+bIk3KUBtmRuPnkbJ9HXoCJk2sliCDTFxhHy5RTjRyscWN/J/WLaf
         8qd0T1B6dfQiWkD4YG4hP1LWMHpdIEMHYA6/eUiZs3V8NPplXyOymQdBTuy9fzO7QNeA
         zU9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWSasBi6ZqkVsMVNys1kmtsYBbzTF31Mpjj6FaWGrwhgtt9hfGrL6xhqpgNVnTJzFuAPT03jSmjTgM42wANlHENi/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqMv4udraGYXGbijLlkpcWh2ral1nMUpTXRrWHJHIHsYpe7F4O
	iosOPBBh4gbVEE8EY+Bo0gQXxS7iqPTEebQ2Tjb8p9efntYldgfSXD590WNH9mjmTFVPt/c+Ifs
	EDpTIqIHx+w==
X-Gm-Gg: ASbGncuxSu9HARI3eFE/25s0wPzMoPP+qC24KO3Kfjy4tnJ1FomzDnJdHGbFyp+nMtW
	nkaaxBjK3cHbw4KER9p01GaffHOyyvNU8dafRfnVzaQz1DqfNSxBNiZRDsIvz1BgwC7UXSGoreM
	p2jjXTxV0SDuTCF3juZ+TNpRd9jxqXZuN9+bUZCrsiv0lLnaXZQHdcnCgow5cNoKi3tZjGXHw7K
	PObkIcjHI44hltvayetPrsluwygJONz24D+8emnY0gVAOGwBa6LZUY+0Zs80y8KYmt8igdheWyc
	qnp73BBP0PHEc9uruzcnIXxa5QnW3lt2YR+aZUmepBXCguqTeS6XuLPsGL72zR753jd4iMqHhiR
	eTDVPv3Ia3xrcbQAHoDzLpNSPBxMqVE9tdcnAEYAy08Q/ey7KQZyKyv28imzltPCg6yhPLDl5
X-Google-Smtp-Source: AGHT+IGc1bzNLIsg+sSl5arwb7c40NtIjVNjNaFmaeYo+Mskr7ijOzpZp/jBTWZpvVJKhQ6rvkY8kg==
X-Received: by 2002:a17:907:7eaa:b0:afe:ca13:a1e1 with SMTP id a640c23a62f3a-afeca13a8abmr937161766b.0.1756484939025;
        Fri, 29 Aug 2025 09:28:59 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefca0a5fasm228633266b.30.2025.08.29.09.28.58
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:28:58 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afeec747e60so281154366b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:28:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU2sqG5G/EzPn7AheDn+RfW2HRgIKmsqJSxgkUL9dz6zSYrt/TGWpiIL1903gOe6xeHY+AgHyFgeHTbTWOKh/yG6KQ=@vger.kernel.org
X-Received: by 2002:a17:906:c116:b0:af9:a1e4:a35b with SMTP id
 a640c23a62f3a-afe28f864bamr2310935766b.7.1756484937731; Fri, 29 Aug 2025
 09:28:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <20250828180357.223298134@kernel.org>
 <CAHk-=wi0EnrBacWYJoUesS0LXUprbLmSDY3ywDfGW94fuBDVJw@mail.gmail.com>
 <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com> <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <20250829121900.0e79673c@gandalf.local.home>
In-Reply-To: <20250829121900.0e79673c@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:28:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
X-Gm-Features: Ac12FXzKsn5qgiNoTPpUW92vL8XQH-QBVsXDCKCPAfj3-whVMqZU-D3ENWgGNVI
Message-ID: <CAHk-=wj6+8vXfBQKoU4=8CSvgSEe1A++1KuQhXRZBHVvgFzzJg@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Steven Rostedt <rostedt@kernel.org>, Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>, 
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

On Fri, 29 Aug 2025 at 09:18, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Basically what I need is that every time I add a file/hash mapping to the
> hashtable, I really need a callback to know when that file goes away. And
> then I can remove it from the hash table, so that the next time that hash is
> added, it will trigger another "print the file associated with this hash".

That works, but why would you care?

Why don't you just register the hash value and NOT CARE.

Leave it all to later when the trace gets analyzed.

Leave it be. The normal situation is presumably going to be that
millions of stack traces will be generated, and nobody will even look
at them.

> My question now is, is there a callback that can be registered by the
> file_cache to know when the vma or the file change?

No. And what's the point? I just told you that unmap doesn't matter.
All that matters is mmap.

Don't try to "reuse" hashes. Just treat them as opaque numbers.

             Linus
