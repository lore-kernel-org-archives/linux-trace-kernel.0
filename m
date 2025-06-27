Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37CD2EA755
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Jun 2025 16:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751041421; cv=none; b=eXLtAi6fqMhrazSWVO/1OcpdxCGuqK1yeXmcBti8MsSTVtzcbH+LtDCHe+353eXXHBfFLfh5vR/0xrWtmSAXjOfClyh16ztR4v/IKJmx13SWV+/gabujpbECRLmKbRz0/3Gntbq9i8nkR5IsCDkLfx42LIMbohyW1bWkvstrMwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751041421; c=relaxed/simple;
	bh=1Z5FIvgVxVgOK1v1qVEDoeCNDa+RgVIxtitLI+LQd5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nIe8Fdhqob9rQVQvTR/6RTPV9dSA6//4Nr27dzgee+hRUifMdHF0t4yrSYlZfEAJ2oEEu0D0jBRCL3AZAWC2quA9Gb8kOczK63EIrHs2Md6DS3u9UDleD05OAXoWKerRrjbdZZqGepDymYEoBvLqPA6xUayz37jHCnqeEUyFeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=BpdccJoS; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BpdccJoS"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-ae0de1c378fso261142666b.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Jun 2025 09:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751041414; x=1751646214; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XIBFa7vtiai1aZdrnHbI17B2HX5VyBn+7Wdc06Hzja4=;
        b=BpdccJoSfVTXxnRZuEtMgszt5iyr96sN1K1cZ2sawnRjZBm7MdUx3g1W45nA2aZTsl
         bgm3qdkMwTdjm77B8uD0T68pcBRHDFdTR/GAWlWQvU4zMubrwhaSA1f20p7cEkNq79q2
         KWviHfQMSwqPjXhnzxzLL8gyUACb/QR5VxS/0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751041414; x=1751646214;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XIBFa7vtiai1aZdrnHbI17B2HX5VyBn+7Wdc06Hzja4=;
        b=bME8KOMOEwsGz8ETBJdjrOClfhRWC457jEeKjj2RZ6K6PJwXMiGR2i5Sj0+6qQf+DQ
         FvCIFimIYWJMaIEo3PgtjaudPIapEvb6kqdixBhMalZefDJJ0XzSuebBD42wF+RT+HLq
         EqjgxHAl09PvmLJQGMdlS2HkHEh0J6TVQh4Ro7QjeY5qQ3beUcG3IjDOuUalEIbXq21y
         Z96b7h//WMYAPuZPU6fT0fpGHbexuVk3zVJrqza+47RkK7G71e0Mp+XeMqmWUXK5e1v1
         hHAKfCcQYiL5ePXPiPOhkQfcDi9leCd6nRlde9eV7Q4kyWrGJwlhvvjqCEgz4zohWB/d
         gyZg==
X-Forwarded-Encrypted: i=1; AJvYcCWtI/3YV1qYKjY5l5y2YgetoOqzTgNUQh2Rhi3dyUCYssb/DgKxfquJcdSYh+U5/7XtcIAU+KSZT+I93KBfZZOHjr0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfxgZThxeaZ2S8XeCS+tscpUzBMEAZNR6SxLZ1dmTyzu7CQ9de
	gyO2jJFTzQclCD9Z0bfhGCFAfyabY65MSFFB+m+CgGBxIF2034l311HMRVtlGxzhLlF3FDaM/uf
	O1b/OZ4s=
X-Gm-Gg: ASbGncuwiEkESlGCugWmfNFXS84lior8FGR2Mzk6dmv93lUa5d5yeTy3GtAJt91GaY7
	E7xIJn4YDlGaS/dxn6Yp3y69xuI22zow51gdJfTBKQgVR8Ox93LzsRGk82xDN8l3lLUGLNY4SdV
	IyDa7EtXwnU1e4OuNPGcpiX8tlWuylF4I0Zfc4YS7W+wIb1wOvsNW9zBV3bqXB0N8BPRdVF651a
	J2qrjCGOuu226DUbqtreGLbSU5+PWuopuvqc87h1wSO2tx9YmBQ8Mh5rI4K7VIVFcyEzgcyj9ws
	V9BH9BnbOsDqWk+4Z0C0TpnCoc7sFp9fAE+A7AfhfcuJXTy9YnAIhgwYfdyHR9EvM4JEUFg9U6b
	agNzgrz2+Zve/w8bWC7Eq2v8xYFzAmBb1uB4kD7aXzCvbmhw=
X-Google-Smtp-Source: AGHT+IHuzi41VFW2fKmF77e9yVaPL1YLKq5ySxS0iI4GQhtLng6F3ChhjjUdrIcVk2IdYSf4X3IzNA==
X-Received: by 2002:a17:907:fdca:b0:ae3:6744:3675 with SMTP id a640c23a62f3a-ae367443a67mr86532166b.48.1751041413815;
        Fri, 27 Jun 2025 09:23:33 -0700 (PDT)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828e1a96sm1682652a12.19.2025.06.27.09.23.31
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 09:23:32 -0700 (PDT)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-60c79bedc19so4784a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Jun 2025 09:23:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXi/RDgNfE0vdz9HsHXEp9mQXw3P91i/akpEW2O7X0tFKJAYstmYVS2e2pgYS0It5karknxX3b9GCMA6iqT8NUc7UU=@vger.kernel.org
X-Received: by 2002:a05:6402:34c6:b0:5ff:ef06:1c52 with SMTP id
 4fb4d7f45d1cf-60c88d65540mr3554120a12.3.1751041411199; Fri, 27 Jun 2025
 09:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625225600.555017347@goodmis.org> <20250625225717.187191105@goodmis.org>
 <aF0FwYq1ECJV5Fdi@gmail.com> <20250626081220.71ac3ab6@gandalf.local.home> <20250627100113.7f9ee77b@gandalf.local.home>
In-Reply-To: <20250627100113.7f9ee77b@gandalf.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Jun 2025 09:23:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiXsMA3OJ0tnSWFDwqH=H8OAsUwF2hqCuQ6uHaLmpQubg@mail.gmail.com>
X-Gm-Features: Ac12FXwXn1CGZ5TDseyf0yMPbEJKzZlOp6kLfp771zfoaf5rHgLNIhEIXduSSPA
Message-ID: <CAHk-=wiXsMA3OJ0tnSWFDwqH=H8OAsUwF2hqCuQ6uHaLmpQubg@mail.gmail.com>
Subject: Re: [PATCH v11 14/14] unwind_user/x86: Enable compat mode frame
 pointer unwinding on x86
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Jun 2025 at 07:01, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> That's not a function. It's just setting a macro named arch_unwind_user_next to
> be arch_unwind_user_next. I think adding "()" to the end of that will be
> confusing.

Yeah, we use the pattern

   #define abc abc

just to show "I have my own architecture-specific implementation for
this" without having to make up a *new* name for it.

[ We used to have things like "#define __arch_has_abc" instead, which
is just annoying particularly when people didn't even always agree on
the exact prefix. We still do, but we used to too. These days that
"this arch has" pattern is _mostly_ confined to config variables, I
think. ]

Adding parenthesis not only makes that much more complicated - now you
need to match argument numbers etc - but can actually end up causing
real issues where you now can't use that 'abc' as a function pointer
any more.

That said, parenthesis can also actually help catch mis-uses (ie maybe
you *cannot* use the function as a function pointer, exactly because
some architectures _only_ implement it as a macro), so it's not like
parentheses are necessarily always wrong, but in general, I think that

  #define abc abc

pattern is the simplest and best way for an architecture header file
to say "I have an implementation for this".

And obviously the reason we have to use macros for this is because C
doesn't have a way to test for symbols existing. Other languages do
have things like that (various levels of "reflection"), but in C
you're basically limited to the pre-processor.

             Linus
