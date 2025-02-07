Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B971DA10C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Feb 2025 15:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738942069; cv=none; b=fnOxEcvdxku89Cko1Kam5PP2Lpl+cu00HboNFV2Atkfwt/Jxhb59TxLL3UF4Qb4F9+zsc7m1lnsi6pMGlkzfX1mGe5EHTepnrjpNBjK+Tuc2xV0n103vz+o45ECLGQlMmHgXQX6fe+5xjeflUi7CwCNCm/XkSoP59a5PfQugRfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738942069; c=relaxed/simple;
	bh=F4j0KkSbpmD5d1hZhFwZpCkYNFkzmXINbPi2uJ87EwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AJW2nL6gP8PnDZ1g67And30h298ITbpYGGK7XbqMxJUmXOOgzCaE0ReBfLboLjJ2uruYID+7u9NWH9NanNLxYJvQxz1Bl8HNcl6z81PdLKw/HP5qC7SMqbgYlSKq+lRsCM9Ou4JcMy4TFkNlwLF2of5JLy1qnGo3dhoXzDb1S04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K+WEOEPZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K+WEOEPZ"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5dcd33d9d9dso10545a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Feb 2025 07:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738942066; x=1739546866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4j0KkSbpmD5d1hZhFwZpCkYNFkzmXINbPi2uJ87EwA=;
        b=K+WEOEPZBusFmWVzafxm9BwPE7etbs6sP+Rs/FzkdIWODkl/x0h+JCpWWm55UWCPWk
         Fs+7gTcFfMYGWdVras1s5wFKE7tQ9rmiEXrjDRzjLOwQ7NJ9WwLY8SKGTgn3UvfZOT/j
         b5vIWlMMnmf963hyzk36SgSqBdfQ8mI6eZFJShMIP5l76ApgTOgSUZK2nHs7l8clojb7
         IbcU9mopg6LrSrfGeNe6fGbTa4+YzE6qj0bQ859e3xbHJt+IuSBkfFxvlOlbYldo8hjS
         Zj/jSPHfqbOtN0lm2SafdXddR2WBSJAZjEEBK16U/o17Jp6omUomgRBBKK3kko9uzL8b
         6WVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738942066; x=1739546866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4j0KkSbpmD5d1hZhFwZpCkYNFkzmXINbPi2uJ87EwA=;
        b=kcZzMIja+bGaodaybFk8JC7Kqy/s3USLOA6onL6eTaqTOsS6pu7ttm01iShwp8nLy0
         RIoTQDH05wgYLM5D3F8to7MYkmYKbu57Uphw26+G1lHlJFI2iQmoMXx9BuE/tdTlBB6k
         XpfTG3KYHMWff72oKASq4gBwKc3PWW+eVOJEgG1rCBit7+vLYQUSSNHtArA8wkeqws5s
         iAUogVYLTyqHH+5vg4WdGRtCdkwUckRxWvR29+p/jk0KpURERNXbr7Ybwxsjr01HEDPZ
         uizRkWUeWPovurRB6MYKLbRpv1CPRRAvK0t7RYXHQoQNhbmLFzkXAjHUYEt6Yst/Hwuc
         GPOw==
X-Forwarded-Encrypted: i=1; AJvYcCXbQzlYsicjF1XtAPbbsftSMqbvgcVIxYonbFOs454LgbZkhppzgUHD1r1Oyuqv8kxV35/SNySn69X3YCnN6wA64DY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+GUD9OscIpUErOHPzpLIWV4VUIk/jKDefO60lcZhyD4iTswUe
	ZAYMMrUORIcJ0MTzFHJrli5ruG7MoH06CuEZpSZir+LjPTHPI/IExB6BWlJBlqh1NYcs+lXxQNn
	Qx4zztPmO+9W7ueJ5/S1OAxhJJziwEQRNQmkp
X-Gm-Gg: ASbGnctJudlNdknwZ9dwmRv+PVFeZFdtftExM0NMqjpTGkF8k7ADmvR7uIcf1hZhsk9
	4r2zeGp23hjN9OWlDFjJNJzxrNdSHSZn8O+bgvTC8Cq3PJ5wDX1btYgpyHqX4lxwUCe3sLzCrwK
	C3P4j8fBK78zCS/Im9j5VpVZ4=
X-Google-Smtp-Source: AGHT+IEABdgK9eHRB4H0WezxqoVghBHcRPYWNAOuQN7T+MNlzRlH684F1NSJpUngreTS9WPWXZN59E97viGK5BDWvz8=
X-Received: by 2002:a05:6402:517c:b0:5dc:d08e:e128 with SMTP id
 4fb4d7f45d1cf-5de47da7d23mr74223a12.5.1738942065552; Fri, 07 Feb 2025
 07:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250202162921.335813-1-eyal.birger@gmail.com>
In-Reply-To: <20250202162921.335813-1-eyal.birger@gmail.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 7 Feb 2025 16:27:09 +0100
X-Gm-Features: AWEUYZnrwNzsLd1SX3TTXp9my4IROz2Zr8KCBuJa7WZQ86FVBE2pL8vu6wsQ824
Message-ID: <CAG48ez1Pj6MT=RV-sogtNbw7WLLmCrC-3TkNfRjpcCif8iNGkA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] seccomp: pass uretprobe system call through seccomp
To: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, oleg@redhat.com, 
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org, 
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com, 
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com, 
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de, daniel@iogearbox.net, 
	ast@kernel.org, andrii.nakryiko@gmail.com, rostedt@goodmis.org, rafi@rbk.io, 
	shmulik.ladkani@gmail.com, bpf@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 5:29=E2=80=AFPM Eyal Birger <eyal.birger@gmail.com> =
wrote:
> uretprobe(2) is an performance enhancement system call added to improve
> uretprobes on x86_64.
>
> Confinement environments such as Docker are not aware of this new system
> call and kill confined processes when uretprobes are attached to them.

FYI, you might have similar issues with Syscall User Dispatch
(https://docs.kernel.org/admin-guide/syscall-user-dispatch.html) and
potentially also with ptrace-based sandboxes, depending on what kinda
processes you inject uprobes into. For Syscall User Dispatch, there is
already precedent for a bypass based on instruction pointer (see
syscall_user_dispatch()).

> Since uretprobe is a "kernel implementation detail" system call which is
> not used by userspace application code directly, pass this system call
> through seccomp without forcing existing userspace confinement environmen=
ts
> to be changed.

This makes me feel kinda uncomfortable. The purpose of seccomp() is
that you can create a process that is as locked down as you want; you
can use it for some light limits on what a process can do (like in
Docker), or you can use it to make a process that has access to
essentially nothing except read(), write() and exit_group(). Even
stuff like restart_syscall() and rt_sigreturn() is not currently
excepted from that.

I guess your usecase is a little special in that you were already
calling from userspace into the kernel with SWBP before, which is also
not subject to seccomp; and the syscall is essentially an
arch-specific hack to make the SWBP a little faster.

If we do this, we should at least ensure that there is absolutely no
way for anything to happen in sys_uretprobe when no uretprobes are
configured for the process - the first check in the syscall
implementation almost does that, but the implementation could be a bit
stricter. It checks for "regs->ip !=3D trampoline_check_ip()", but if no
uprobe region exists for the process, trampoline_check_ip() returns
`-1 + (uretprobe_syscall_check - uretprobe_trampoline_entry)`. So
there is a userspace instruction pointer near the bottom of the
address space that is allowed to call into the syscall if uretprobes
are not set up. Though the mmap minimum address restrictions will
typically prevent creating mappings there, and
uprobe_handle_trampoline() will SIGILL us if we get that far without a
valid uretprobe.
