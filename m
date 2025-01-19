Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698401DF74E
	for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Jan 2025 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737311807; cv=none; b=l0gJCb/6Y7hlxTIj0bezAaj1uVWfzs0epUj6IifVr1yWsKj2A2x2Krg6Mdg/1o9QOjUzzurBsOmTAR+9xIvuKlBn5U6UwEHRZib9IofCqcJicQRX6d8V5k3umFIYVPP1CVvEWdRfRGfBL15V4UuokCHA+5Kb62ERfFAxwuCRtGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737311807; c=relaxed/simple;
	bh=ktKEZA/m9Kckb1kexLNbvMJLiO5gVTsHXasZeG9BXMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUNXTgZVSajRhyRXVBU3x5GZxjk7xxzvdXuryM8YEbhx98tn5hGiTgGw/yCZ6UNmlmiMVPKsHEvI1K4rl0IVoHS4e0gZ3LwqbF+2bvORKfotmCYwoyX/F7pbvluKQlW9YmiIjLTBc3+y4fPe5D25kgVelsTPcGU/eyyL1KEB2R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=zZVQV/Yl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="zZVQV/Yl"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaec61d0f65so814046066b.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 19 Jan 2025 10:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1737311804; x=1737916604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3Zdmxu5MPiX9Zes0b7wDyPvwS0wm8oE6bxgPE9wOSU=;
        b=zZVQV/YltzZY4OUPKzLRV+4npSY46V275bNCuL7gtSGsauXn1x0WZp/y2s0vdU/5Qa
         xfsHS221eD27ieMPFX4/B5sQjYhP0HLoiuageH8k8anUZPolPYVbv6vc8DfUnvXE6q7H
         ZOAjMXUy7hrH+FgKsLlRXcLmiXxGsNo184z80i9UOlIG3CxjATu+sfL0699NFjyio0fk
         cBWPwRIfVNc1WC/hZw+mx+R1Av6b0CiLX4j0UxGbG38QhLHD/fLZTwVFBSqTaR502S9d
         Vbnf3TxnTX+um294VTo7+El0D2ARPb/R9olfG+5iKn6c19/FbXik+if3mNakQiak5ts1
         aeEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737311804; x=1737916604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w3Zdmxu5MPiX9Zes0b7wDyPvwS0wm8oE6bxgPE9wOSU=;
        b=ovEsI5QcdtxnGigbLZvVziXY62WJyhXONEynhnFwPOefLj24SQGRGN+rQRPNdrATbA
         ZcpaOWh4k6lq6BhudXFZWZRoixY/HaKkfR+HLrrD/xkkoclcRMyi0vngGVbRHQy+svou
         uK4aEIgNRyfC5oEW09urbG1nNUy8LJO9Tqo/ZeyeP+KT1tVRVaz7q41p4GFHQTgt4ii3
         S1Jdgb8gjJBnhtW7pLcZpzlNvRghBHFt8PmZlv6YrvSWfzTw+xz5GAG3X6TvJEIKnVKJ
         uxnEF37gMPTkeSLtyXSeEI4PwI/0H8WD5WgPr4Z5DGH9p98QrW8fPkA6cGMRvr66geqz
         cXiw==
X-Forwarded-Encrypted: i=1; AJvYcCWO+tsuO+7PwQZivCmQ3tHZ2QeQXxiRd2UsuaGkIgEMnHC+8DeN60oiCiAtliWVOCcT3QgZ8MQ58glO+ap3dJptIrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn3fx4HY9HI18DKOJPn9A6ksdy1iP9OcD9371LLaNzxLxoZIO6
	to0H3uAZNCnQLTSoP2Y9Jw5lt5i7JmwVdVGf4DbBjZMIHBw+BGs1nMExUUr3bw6aoMt7I8Yse9U
	BTUetZPrfmuEuNlidCZ+gS4CYCJyW4H8D1d/D
X-Gm-Gg: ASbGncvzGpqbolojgAFglxLx4XOMaNF+rM+lMFqtw5RsC3gdZRwNH4puhgtDz4tPgyW
	o+7JkRsW6U3bAuS7FS6GGaOAsXor9AFwOvmP7NUtpiie89M9UHg==
X-Google-Smtp-Source: AGHT+IGpC+/AvwptvqRydDb5Zj0eMi2xtddvB/zSoMfs5AVyLa0djFfoPKt73GzvJi014dMnq37C2/o8DW9oYr4Va0Q=
X-Received: by 2002:a17:907:1ca8:b0:aaf:ab71:bf79 with SMTP id
 a640c23a62f3a-ab38b11281cmr871028066b.19.1737311803527; Sun, 19 Jan 2025
 10:36:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250117005539.325887-1-eyal.birger@gmail.com>
 <202501181212.4C515DA02@keescook> <CAHsH6GuifA9nUzNR-eW5ZaXyhzebJOCjBSpfZCksoiyCuG=yYw@mail.gmail.com>
 <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
In-Reply-To: <8B2624AC-E739-4BBE-8725-010C2344F61C@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Sun, 19 Jan 2025 10:36:32 -0800
X-Gm-Features: AbW1kvYl9WJOKS89hZXPE8Kch1rIFhznB2Beo-6EHl-4XtuMMOKO1t6RXeDBLAM
Message-ID: <CALCETrV4vGS1brr9r=+GJu0n_WyAMxqT8x_wOJ2Gz7-yOfSzKA@mail.gmail.com>
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without filtering
To: Kees Cook <kees@kernel.org>
Cc: Eyal Birger <eyal.birger@gmail.com>, wad@chromium.org, oleg@redhat.com, ldv@strace.io, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 18, 2025 at 6:25=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
>
>
> On January 18, 2025 12:45:47 PM PST, Eyal Birger <eyal.birger@gmail.com> =
wrote:
> >I think the difference is that this syscall is not part of the process's
> >code - it is inserted there by another process tracing it.
>
> Well that's nothing like syscall_restart, and now I'm convinced seccomp m=
ust never ignore uretprobe -- a process might want to block uretprobe!
>

I've been contemplating this.  uretprobe is a very odd syscall: it's a
syscall that emulates a breakpoint.  So, before uretprobe-the-syscall
was added, the process would breakpoint via a non-syscall vector, and
the tracing code would do its thing, and seccomp would be none the
wiser.

There's a distinction between different types of operations that
seccomp is entirely unaware of right now: is the task trying to:

a) do something *to itself*

b) do something that doesn't have meaningful side effects on the rest
of the world, at least in a non-buggy kernel, but where the process is
actually trying to restrict its own actions

c) interacting with something outside the process, that has privilege
over the process, where the interaction in question should absolutely
be subject to security policy, but that security policy really ought
to apply to the outside process.

uretprobe is very much in category c, and it's kind of unique in this
sense *as a syscall*.  But there are plenty of other examples that
just happen to not be syscalls.  For example, ptrace breakpoints use
the #DB vector, which isn't a syscall.

Here are few factors that may be vaguely relevant:

 - uretprobe is conceptually a bit like sigreturn in the sense that
both of them are having the kernel help with something that process
can kind-of-sort-of do all by itself.

 - BUT: sigreturn is not supposed to have side effects reaching
outside the calling task.  uretprobe does, and that's the whole point.

 - uretprobe-the-syscall is, in a rather optimistic sense, obsolete.
Once FRED becomes common (if ever...), it won't really serve much
purpose any more.  FRED, for those not watching, at least in theory,
makes "event delivery" and "return" fast, for all (hah!) events.
Including breakpoints.  And returns to usermode where rcx !=3D rip, etc.


So I don't know what the right answer is.  There's a real argument to
be made that seccomp ought to decide that its policy permits whomever
installed the uretprobe to do so, and that this decision means that
the uretprobe machinery is therefore permissible.
