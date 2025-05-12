Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03E72BCF5;
	Mon, 12 May 2025 14:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060331; cv=none; b=O9A/XmtBVFep5P1QveSgUrG25TeGJLx/9SjbNuXixt7N4aDRz8rkpTF/sEC7ZUEvgX9XJzdmhzhLzhLpjM+WKPWCC921nQ0SeEI2lRy8jTN11A9DYFwgX/iIE35jKjx8pBnSXSIJhnmQCQ6wiMxRVB1T/DTdzZHP/PccyPgfCSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060331; c=relaxed/simple;
	bh=0TGOmwPUvCuLoM8Ba1KnsrOm/ms6+VXrMl5GWomKjGI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IkAGZJdFIhL28Oxxf5h6OalOplWAw8aIBdgol+Yt5aVNeBGha+/GjJ3HDDKszeCxvCqLKg8os9M4aaQEAshjkuWFPXQulexyKggCYDbXYHhPbej7PfC4MHzMPnn8yZ941MyZQtGDuHydAOIN7Qgm2lgzmS0d5EsGb0J26ddjtEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0j2Z+2Q; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0j2Z+2Q"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5fbf0324faaso9430518a12.1;
        Mon, 12 May 2025 07:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747060328; x=1747665128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/o+QnE1H2pLNv7S6QQ5Xteejy5s9NdYnzkKkX1og0ek=;
        b=F0j2Z+2QZjN9rA3jGmiJ89iLoi6/C66z+eONut50zGazh5cRjk7Dz4Hhri0KqCoQUP
         sr7CpTsZfx9vWzHOkH2yZtM+63bpebyyJoUGpfJuwzB3G8GzfVh2nEQ+wPpzsBmm3Crd
         y9m0UxV8kl7UMpEMa45dN9I/HrOnD5q+UeyT1ds+joW4FixxJfzuQkHxrx8BGxGu9mVy
         v9wa1XybfX7SGDZaNKD6r2r1IcZIPvupCrd5NrHQUfTQGVSrZH/4VPp7dieWEkpDJnwt
         pA4fQEybkyTeiXI6shSO/OEXNq7u/R5gl7HAj4lJ/3znovt9Glp+bNMyB02n+hIxok1Z
         um5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747060328; x=1747665128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/o+QnE1H2pLNv7S6QQ5Xteejy5s9NdYnzkKkX1og0ek=;
        b=sAcN9RqGWzFT84qKKbsh4gxIRM0ChxR52mdto4AWghu8nhQdMpsNOq4OjgLFlelfM9
         EvbTgWMhDqPfNHIPR4Uuez7NvxRrQ/lmlWN2N0K7yB8AzJayyG5+mFELAF5fUuCm9Q6y
         TzMHLoGDYN61m42pZEfVrDxRmvQw+/ZiAi5pkbB7uUQw/IPOmObsIN5kwFSPqPiBayVf
         UqPrznuqQkJvKrTk85x1U+WDoGH3l5p7/uzNA/lhalJjBARF7iGkKuXU9VY8qGvpAjv2
         rwQw7YzsZbAI14sJeLSov7Eue2/vnPW5SSntM9TTm9F8CfKmg1b6oAlpH2jK47GWl5tq
         zRKg==
X-Forwarded-Encrypted: i=1; AJvYcCVzUSrI9HmB1qrAexZt2pMpNAIVqdNU54pB0pqwM/0O7sWgN/flf9q87dT9ajSGFlLECwhPqULOxmwsl//9aTa9VAG+@vger.kernel.org, AJvYcCWxF3Wk4klIzRiAdVo/cnCbzg+2CCNLGAmNmga031mfQVOck/XOUALW7byJv20YCFpA+TGjsQcedNY5RaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdNURbxY2xc/cIuW5N2QaRmgGdVMezUghAi3MBLiEqteNJlKbz
	olvNIR/BBJxa/AADYn1VqlL3B8/IFxa9bMQcnnXEhJGDUSgPjsof38Kdw59aPdxgKkYPzFNpjfk
	hunB7wwrSZ80PxaQc4nGDsq6njKs=
X-Gm-Gg: ASbGncsNp/blSK95Pc+2UVkLctCTrY0jnUl2sLf7PSk4lYDNG0GYGuIV7H7Ycw+BfOr
	Ys91a7CigYIBtgadZjfOUAy8G3AcpVH3Rtn0aFH2QplSoSfoR0EALTle0R1BOJ5Z5EM/CfWsURt
	NaQHZ1o6unpaXgmYXI5lHjTAQ9G87QFEtFHg==
X-Google-Smtp-Source: AGHT+IEvQMmXlg5joXkYhftYwVICAuYsfqMaT4UwpRyqQ51fQfivA8+syCLfw+SslSLLULkO+mmmMY+Avs68ylvAQn8=
X-Received: by 2002:a17:907:2d14:b0:ad2:4fa0:88cf with SMTP id
 a640c23a62f3a-ad24fa08a98mr546511766b.6.1747060326835; Mon, 12 May 2025
 07:32:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250512094246.1167956-1-dolinux.peng@gmail.com> <20250512101608.3eb16e43@gandalf.local.home>
In-Reply-To: <20250512101608.3eb16e43@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 12 May 2025 22:31:55 +0800
X-Gm-Features: AX0GCFse7z9WKOQUTdN2rsFIgBsXD43pxxsjxu_ci-DGigbKiKXwDeK2f9csbks
Message-ID: <CAErzpmtQkOjLT=tS=vUewM9fFjo75u-y14-uX3avdbXPBP2xWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ftrace: Fix preemption acounting for stacktrace
 trigger command
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, dolinux.peng@gmai.com, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 10:15=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Mon, 12 May 2025 17:42:45 +0800
> pengdonglin <dolinux.peng@gmail.com> wrote:
>
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > While using the stacktrace trigger command to trace syscalls/sys_enter_=
read,
> > I noticed that the preemption count was consistently reported as 1, whi=
ch seemed
> > incorrect:
>
> FYI, the change log should always be in "imperative mood". The above is
> fine for cover letters, but for the change log that will live forever in
> the git history, it should not reference "I" nor "This patch". That is, i=
t
> should state:
>
>    When using the stacktrace trigger command to trace syscalls, the
>    preemption count was consistently reported as 1 when the system call
>    event itself had 0 (".").
>
>    For example:
>
Thanks.

> >
> > root@ubuntu22-vm:/sys/kernel/tracing/events/syscalls/sys_enter_read
> > $ echo stacktrace > trigger
> > $ echo 1 > enable
> >
> >     sshd-416     [002] .....   232.864910: sys_read(fd: a, buf: 556b1f3=
221d0, count: 8000)
> >     sshd-416     [002] ...1.   232.864913: <stack trace>
> >  =3D> ftrace_syscall_enter
> >  =3D> syscall_trace_enter
> >  =3D> do_syscall_64
> >  =3D> entry_SYSCALL_64_after_hwframe
> >
> > The root cause is that the trace framework disables preemption in __DO_=
TRACE before
> > invoking the trigger callback.
> >
> > This patch uses tracing_gen_ctx_dec() to obtain the correct preemption
> > count within the callback, resulting in accurate reporting:
>
> Instead of "This patch ..."
>
>    Use the tracing_gen_ctx_dec() that will accommodate for the increase o=
f
>    the preemption count in __DO_TRACE when calling the callback. The resu=
lt
>    is the accurate reporting of:
>
> This is FYI for when you send new patches. You don't need to resend. I'll
> update the change logs and take these patches (unless of course I find
> something else wrong with them).
>
> -- Steve
>
Okay, thanks.

> >
> >     sshd-410     [004] .....   210.117660: sys_read(fd: 4, buf: 559b725=
ba130, count: 40000)
> >     sshd-410     [004] .....   210.117662: <stack trace>
> >  =3D> ftrace_syscall_enter
> >  =3D> syscall_trace_enter
> >  =3D> do_syscall_64
> >  =3D> entry_SYSCALL_64_after_hwframe
> >
> > Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
> > ---
> >  kernel/trace/trace_events_trigger.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_e=
vents_trigger.c
> > index b66b6d235d91..6e87ae2a1a66 100644
> > --- a/kernel/trace/trace_events_trigger.c
> > +++ b/kernel/trace/trace_events_trigger.c
> > @@ -1560,7 +1560,7 @@ stacktrace_trigger(struct event_trigger_data *dat=
a,
> >       struct trace_event_file *file =3D data->private_data;
> >
> >       if (file)
> > -             __trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
> > +             __trace_stack(file->tr, tracing_gen_ctx_dec(), STACK_SKIP=
);
> >       else
> >               trace_dump_stack(STACK_SKIP);
> >  }
>
>
