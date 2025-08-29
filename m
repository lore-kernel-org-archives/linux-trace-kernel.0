Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F390242D7C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 20:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756500731; cv=none; b=DuZJNsfK3bPsgNsi7jaQsCHEMIR01gJuL03n8Lk60hiGHWYPhs7Tte0LsZGzwAwj6CKxX+Jd/W25vMPwBshWoK17sRPVFCIRbBGkHuTz4e0Ic9P/fdSuvF3H6Fnclg78cxO+LLP9S84Muv0AjPwvDhVUKzHM0RInI7d8lvx2N2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756500731; c=relaxed/simple;
	bh=ohMVoYLKqK85A8YWDL5s4gkFfq9CRDj3CUysT+XmebM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qyEoXUZ3iy6/tU2WpgCm3Ev2NDSWKuDUEHKtb7FPXyAoaWgbgw6cLnUWbwd8XwfOLDrvMcFdIKv4boRRlnt8L8e7AVLve72/+WQ9YYkXN4dY+fBEUrOomLpJ/PnhbkjW20FbRZpNtoHfXawW1hHeu/JlQxu/oq9CHv5oA4rB0QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=S/EUYBlt; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="S/EUYBlt"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb6856dfbso454371766b.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1756500726; x=1757105526; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YJnIXD44JoqcrcREChaKXOoLztkoHAV/cNICzLJGB4U=;
        b=S/EUYBltCP1ZBgFu5FDNsd5DCvA4Ppgs1eLMOuo3OVd5yunUI02rl3qAjrnmVhyLJj
         0oJJUJgIbfTWcAGw0vDrekP6wj5pld8r8dZ1YYcfOY7mIpKRTQb3tWZp3eNr2rwIP2W1
         skfWcljNNdaJY1rHp5ZQIUXfRk24zz3WTk0HE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756500726; x=1757105526;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YJnIXD44JoqcrcREChaKXOoLztkoHAV/cNICzLJGB4U=;
        b=jKpC5NG1eZKfzTeliwKJIw9xPs+eQrz47BU5kXzvjAyJswxL6qxspcpCRfS+BYT3BT
         7B2kx9RAIb+ocVvi3u8QbuRuPvigL5sfvk5a+7RFusk2KhVJgIOi8SDcx/ttnExquyvX
         LxhgQvuPHfM1zKohPw9B6stvM42wcirof4Clbm0YxbfEqNjTQNCSji9pVRXRhWh7VbHY
         6sTkxnLf6mdZn5ItuhtD1jYBETWXpPW+Wp/UuICeXxwTEuKjRtLmaEl/QjCt1NjMmw+k
         a/nF5I+1i3G9a+JHAu2qm6oHg6rJQAMYE7VKdEKt+tXh+/dcEmXAbfYC7uvR8zq0dbdK
         cVjw==
X-Forwarded-Encrypted: i=1; AJvYcCU/UHCWcvnLsGzeDiVwtZdJ7Xdh2hGuxfbN9HZ7z4tWybUGNINRxZnZoKUnx4ZzON2ZElpyGVcEbfL6ZRvsf9lPnPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPwkSWJIkBJsDpWe/5QttGQxky/SLekj7Biwhj3z3b5u6Hwn62
	j7Ivr18gFa4AWdGJxi40f2jR+0Zk9KWyRwqP2bD31EAn+BOtHGtsrf39qlii/UzTLm68hxbAgI1
	rQ6iBtyH+8A==
X-Gm-Gg: ASbGncuu53U3DdBLQuKQ3TukwuieW5PC9lj5lz22VIxA3BvCUuWqwWL6JXNkiITeGzr
	mclT50BDv0Ll+fhRfGzS7cJQi4DkwUdTIXfFKwgucnJxPJgyY/Qb61ANTBLsTJ+qP9Yrqm/lH1a
	+0AX7+kc6bWMITSYAY3Eqv+ZmahzfQ6RJvCH3fuNhkP4PTfemSA+3ZdlNKiRj+vmDC6fPA/SVPL
	+lvLfbrCLAZdA8DbVECOF26PYWx2Fh20jGJGtDIVRiK/aKJ2kyv5mlae7NL1bf8UjX47qdqZ7XZ
	FNYt1yYIl/T/lvYu7DJ2zzCd71Ab7D/si5xnW+sdj0PMITyBs8aPsRcrduvcgWxx8QY5X5Tbaly
	2/EpDVeIpK1X+lpWpwCn/XuIovRtptD067zOcf6LXy+7GdbCLyODP4LyxDoqVJbyg3CLSwo9YwU
	p/CADLAZA=
X-Google-Smtp-Source: AGHT+IGLpc4zkZmqrZQGRHAz+VRxGH6fYG6moyYKwNsWgj+t+1nQ31YN0suToLPyapC5lZvAYF1DtA==
X-Received: by 2002:a17:907:a48:b0:afe:8420:1152 with SMTP id a640c23a62f3a-b01082ae8c3mr42303166b.18.1756500725610;
        Fri, 29 Aug 2025 13:52:05 -0700 (PDT)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcbd86ccsm265514066b.58.2025.08.29.13.52.04
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 13:52:04 -0700 (PDT)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so6558118a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Aug 2025 13:52:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWfrqcsXCpMr4U2xcRJgn0sMCpdcd/+SfcSMVRM1+2x5cHRsnF+UgXpKJObPUJkyq3wIeALhZWpCAxPLJZAMzt3fXg=@vger.kernel.org
X-Received: by 2002:a17:907:3e02:b0:afe:84ed:6152 with SMTP id
 a640c23a62f3a-afeafecb9a7mr1571449466b.12.1756500723697; Fri, 29 Aug 2025
 13:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250828180300.591225320@kernel.org> <D7C36F69-23D6-4AD5-AED1-028119EAEE3F@gmail.com>
 <CAHk-=wiBUdyV9UdNYEeEP-1Nx3VUHxUb0FQUYSfxN1LZTuGVyg@mail.gmail.com>
 <20250828161718.77cb6e61@batman.local.home> <CAHk-=wiujYBqcZGyBgLOT+OWdY3cz7EhbZE0GidhJmLNd9VPOQ@mail.gmail.com>
 <20250828164819.51e300ec@batman.local.home> <CAHk-=wjRC0sRZio4TkqP8_S+Fr8LUypVucPDnmERrHVjWOABXw@mail.gmail.com>
 <20250828171748.07681a63@batman.local.home> <CAHk-=wh0LjoJmRPHF41eQ1ZRf085urz+rvQQ-rwp8dLQCdqohw@mail.gmail.com>
 <20250829110639.1cfc5dcc@gandalf.local.home> <CAHk-=wjeT3RKCTMDCcZzXznuvG2qf0fpKbHKCZuoPzxFYxVcQw@mail.gmail.com>
 <CAHk-=wjCOWCzXG7Z=wkbLYOOcqFbuZTXSdX2yqCCWWOvanugUg@mail.gmail.com>
 <20250829123321.63c9f525@gandalf.local.home> <CAHk-=wgv11k-3e8Ee-Vk_KHJMB0S9J1PwHqFUv2X-Z8eFWq8mg@mail.gmail.com>
 <CAHk-=whbHyKvJ5VSvObfmGSSEukYhv5DZVhR3_-smu_1_b54mg@mail.gmail.com>
 <20250829130239.61e25379@gandalf.local.home> <CAHk-=wi3muqW7XAEawu+xvvqADMmoqyvmDPYUC_64aCnqz-WLg@mail.gmail.com>
 <24E50A07-EC58-4864-9DB3-E5DB869AD030@gmail.com>
In-Reply-To: <24E50A07-EC58-4864-9DB3-E5DB869AD030@gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 29 Aug 2025 13:51:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxMx4Bew7naxecrivtrdt0mzABSTt==vO-tO9Th083kQ@mail.gmail.com>
X-Gm-Features: Ac12FXyW0nAdh202diR-dvFjPy8CyZHx9x_gTjrEDXtExTrmFznxHPLMFXgTReA
Message-ID: <CAHk-=wjxMx4Bew7naxecrivtrdt0mzABSTt==vO-tO9Th083kQ@mail.gmail.com>
Subject: Re: [PATCH v6 5/6] tracing: Show inode and device major:minor in
 deferred user space stacktrace
To: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Steven Rostedt <rostedt@kernel.org>, 
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

On Fri, 29 Aug 2025 at 10:58, Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Can't we continue with that idea by using some VMA sequential number that don't expose anything critical to user space but allows us to match stack entries to mmap records?

No such record exists.

I guess we could add an atomic ID to do_mmap() and have a 64-bit value
that would be unique and would follow vma splitting and movement
around.

But it would actually be worse than just using the 'struct file'
pointer, and the only advantage would be avoiding the hashing. And the
disadvantages would be many. In particular, it would be much better if
it was per-file, but we are *definitely* not adding some globally
unique value to each file, because we already have seen performance
issues with open/close loads just from the atomic sequence counters we
used to give to anonymous inodes.

(I say "used to give" - see get_next_ino() for what we do now, with
per-cpu counter sequences. We'd have to do similar tricks for some
kind of 'file ID', and I really don't want to do that with no reason).

And if the only reason is "hashing takes a hundred cycles" when
generating traces, that's just not a reason good enough to bloat core
kernel data structures like 'struct file' and make core ops like
open() more expensive.

          Linus
