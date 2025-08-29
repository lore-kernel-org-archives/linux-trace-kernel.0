Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91312D321D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756486591; cv=none; b=t4gBQ/xM+sJsmfogHTBlnzfs08+irwpj0yNR27LbZndmBk0vgze5DdAWiukOImyz2BNa54PfhL4rheKfc0SAlt/q4OEkgrndujlLpDJ0a7uTr62QDPjbrDMkGVZye7RGa4R6MfocS9Rx8wFu5gxMe3IF+YcOYO9BBkF5p0akjjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756486591; c=relaxed/simple;
	bh=h7kL/4uMpyKF5NccHp4ZNI0Wmfvu40JouRjLRpItj7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iO70XjOkS5ud1vzmddeD6zomIBfkWNJbXMtHSCfFpJKA1hSe1RJek4eo4odoJGBIgIARYEJRnSV2F+8dKvvWaJ0wbufSs6VFvMqcBKRTT2khG7K2+jFJgt13jyqNiCSd2uSBkxQj5c+KtIvvnSa6GxIyEXWVPjooI+YyW8PWO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=fobIJ0JL; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="fobIJ0JL"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so3243286a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756486588; x=1757091388; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YuhPIWx0Vj7KfkidRYFQ7OP6ebYW22eg0BlKIYspAk=;
        b=fobIJ0JLMkXtP4XvymDBSyKgKaiMNSIxbpqUTJ5/aLoNt6BT4oZ3X+ZkqzOjtYymZP
         EpeRz7LKaRPFqmHPMBiEKx8Gd516Iv5QjJlNKwPmI8SreRFuum449kxs+yDbcuaxPJT7
         46nLX0SUVmSCbGEZSkFTTTlrt109GdJaLXCnc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756486588; x=1757091388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YuhPIWx0Vj7KfkidRYFQ7OP6ebYW22eg0BlKIYspAk=;
        b=akbZAOTuzVKFPTyIlRIin/aVbyQz3ca0faXQM8tRrQLg1O7XBH01gsOOc5197wJ4/h
         nDExpuGP1e1iuYQF7IEvULfxduE3RZG/xx3lZeQNHpDVR00CPUjcZAIXFsY7fR3+6kFd
         Z6YbjxDrl9MYI46+4xr3mm0GJgrKX55uLgtFUW/iVlRE/NNOFi8tAEPqEHiN1+IMPVyW
         WEMYVgXHsN1UsK5k52sudwxYS1Gaw38E3Qgaff4HjJZ/EpUKzb1jBcqYXri0r29pK3Hk
         GUEt/ce4Kb+HT6QjbKeiDI6an/+c+VRnbFoHW7xYdkyDOO6RmNxloP+3WdP2ng/jcqTm
         5Osg==
X-Forwarded-Encrypted: i=1; AJvYcCW4NWFbyLTk5l3DtrP2si8gk7F/rAfHfUTaARmaFimVQFVxe44I//lj+3V7WUuSyxUdACjkzb7s6BluAC3+c3SiFf4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV6BuvDVQ/6RKtV5rWz2uUFp0bMC2H7L5fgko1GOdXMTAAcPRN
	oW9PvbTk9xa5WKxHarF8WocjD3R92WbRlhZkXj0cvMAKEvxsjUk9Vl4Aj4BT3uG/cAeGyLjAtBp
	iE530vUvOTw==
X-Gm-Gg: ASbGnctQXYG/TknrgLztfaYvMIgt3EFw9VcVJST4mxzyLRWermFv+vjDjHvsIl+taoK
	M5/K8M1OHNwjLZ7k4k/Mixt0OatV81SuVPovmeaCON1mMTALYLoUmIaHuk/487eKfmwnXWn0hsB
	6ITmop0bb/2n/XKlPHx34nqaqy0bhmv42/ldUw/NnTtQs5St6OWD7G5sKz5v9HftqhWw0K8g9G4
	v9ihGABovFXL/67mpLubpldlXqP+tdsuUYNTpDRI/HQ68NJ+iBxTI3q4MY5ItSnVB1wSZ6kYWrp
	C1aEAOOyjuWPSI3oH78i2hpus+UT0APrqlrWzqDDy3ZLOjbzxQIGCGWHlJd0iHW9cdmHk/PyUhq
	6OXZIQhJI+eIgAQWFKOoDvaENKUxwSYXiHQMYBhr+0oJST2sO211FGjphwU8NoODBq9+FoVukdz
	fJR48I45YFcB+lSvx1GA==
X-Google-Smtp-Source: AGHT+IEC5TZBZm/JZ5Na1OYEEdySsahOKf0h0pUFeleQHcmYyFd+V6FGxNBqgigxYxIVI8P7CArtRA==
X-Received: by 2002:a05:6402:1d4b:b0:61b:f9a5:c115 with SMTP id 4fb4d7f45d1cf-61c1b90d4d1mr24776736a12.27.1756486587691;
        Fri, 29 Aug 2025 09:56:27 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61cfc214ec8sm2007789a12.17.2025.08.29.09.56.27
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 09:56:27 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-afcb72d5409so399375066b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 09:56:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWvXNRRi+6SsjzvpYsw1qiDPlwrlC9j+Qi+ZHrcTzq2dJyvtfcPHuVhacb9WPE/st1c1PjEL1ly/+Dik4cOl9qAEKY=@vger.kernel.org
X-Received: by 2002:a17:907:d10:b0:afc:bcfc:b3b7 with SMTP id
 a640c23a62f3a-afe2958afa7mr2671499166b.38.1756486228847; Fri, 29 Aug 2025
 09:50:28 -0700 (PDT)
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
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
In-Reply-To: <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 09:50:12 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
X-Gm-Features: Ac12FXwTdaKGwKQQrcvfZIpWu9JvQChz-8oubMdWokhEh6BbzzxHD6kJcwqyw4w
Message-ID: <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
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

On Fri, 29 Aug 2025 at 09:42, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Just use the hash. Don't do anything to it. Don't mess with it.

In fact, at actual stack trace time, don't even do the hashing. Just
save the raw pointer value (but as a *value*, not as a pointer: we
absolutely do *not* want people to think that the random value can be
used as a 'struct file' *: it needs to be a plain unsigned long, not
some kernel pointer).

Then the hashing can happen when you expose those entries to user
space (in the "print" stage). At that point you can do that

       hash = siphash_1u64(value, secret);

thing.

That will likely help I$ and D$ too, since you won't be accessing the
secret hashing data randomly, but do it only at trace output time
(presumably in a fairly tight loop at that point).

           Linus
