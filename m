Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B86026F28D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761881812; cv=none; b=DF5w+q3DIihzaVocssPGzdm/kMsZCi1vCfqtUyfNigGL/ZmKy52SzGtGjlXq5fjbM4DWn+m00ywbsoAM37wKoWDkfZ8RHOTj+oqQjOMst+qmeq4XytotxJyuNWMyJr7tCcpm8pr98ccgPjZmMhYVIDjK7FvOqy6Z+uxhjDb23G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761881812; c=relaxed/simple;
	bh=l3mm+lBFPHAks+LwRIC7KHR/F6NM7jW/PvnGW725S5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QLuCMDyLf7mXLkNtYgDn0UDJSKb7Nxhh77kr+/NFqkP5V9ISmkMnRmjgWN9xzObQvyu8djPTgSN5PRn8TJjELQSB0959c0X64TXJyYLx7IjuKlLpqfZFvHQqp9SBAgurTYEJLZ3e/eYjuH+QyKP83t+E7nDKAryuV9Q9fUjJBuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6oinO+d; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6oinO+d"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7864ab69f01so2779707b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Oct 2025 20:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761881809; x=1762486609; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I+gv0KDSDdRFFvN+HUcCWv1GSnQA5FAvdjB0Eum3nw4=;
        b=W6oinO+dev/uST9GryQXsNDZkQLWI+P1zPNa6uPlW/4Vro55I7i65zLbLnOcci4GNR
         ECTTBqmct0snFh5q2aFKWrmSybVASZuLJzdb+vXuz/PVpMeqrw1YVSzQikIOgcWLLWSu
         5Bik3dxYMaUiFYALKvG+CbuhYSftjGt2BRz9wYypB/FjZXau9v55ut+ZUcIDp7VILH7c
         1h5CLdS/Uy3TOQzUGeIaxvvCPwyZ9mhfaqr/otNE/ejcO20zknCXRxTnyxD419qHfSaV
         RGueWlhNjm5x5HwgBxNZDSPeo7VITJTNwxK57a1Uy8nEqQykNYq+Vy68wY1LUWfDWUzM
         AICQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761881809; x=1762486609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I+gv0KDSDdRFFvN+HUcCWv1GSnQA5FAvdjB0Eum3nw4=;
        b=oJsjumRyC9+pj7Iu3sA76o+fOCDIUBnb0GfhgMFBGzINtUZ7vhMIaNx/hbsaZLFTm8
         Y4YofUY3jMUs0ocrhgh02GuHAQc/4Ww/Lcim2ZuhaSDiPxvaNga1uT+PXAgo3lhpXmT3
         5pmP5Co6hZtir+W1tRpH2OMvdKkNOzi5XTuQ7jGuwJnqlPJbEoKfLdXeKoI85JSCzdhZ
         1d9m1DK6rgnz7wTFOGMIMzjX6/yaLJpmK4ctPdkWOsMFb9hINEpu89cihMTn5TQlTXog
         U1DMXR78dqTLVirQccKg9xcUav9BIvOzDu1rACxlUTQR76cby7XhxpVR5RnhFG23nEMj
         Efog==
X-Forwarded-Encrypted: i=1; AJvYcCUmGARnqmQCfrOiuu9BUz4+b4CYpMFu6lcMX+wCKCvtsV8zhfp/LAP3qtpAhtCXV9bXoq+KRBKbbCMa5OE4PSAUt5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ko0GC1xYLjFWY4rQrZVIeOrx52TTgiAZAqnLbfKao3NG9xI5
	qk+//u39Xd+ukPtpZ+6+Qe9wGskT2optx7mpBsOsWeOmzyHaqOG9vV5DLVcO3l2XAJy7V242e9v
	maxhJkaJnYb6jiMoJ6CSvkrVU34HmsWg=
X-Gm-Gg: ASbGncumTbphCRffnV8D0BkBMKWQBtDKcvDu3n2G929sNa3TOwjy87EEOEDOxk2Hvj6
	Emh1LQ1co8y/FSuJe2Bf0JVf9/vgbBRrv4mYdmekmSkJIJKNZ4uCnQHPUe5kg71Qajx54c2kVof
	9DQFXv8Lw3jUUpNWO6b4Yl5za5HJbBifPuIBnIxcY+XQ4buGtVKFbyZn4RvvakpEhs4QpKmkFJ1
	vZCaRtYhuiHoOkT6f7N0va8RjjVY0NTl19Bfj/ZLc+P0c3XxiKyHLDKWVWlJRTS
X-Google-Smtp-Source: AGHT+IHBmFr/f7KUXhuoC5VAA8WBA2v3pQ2OxS/qFztuZcGPw4PY9FleCBb81VjY5kGRmzystYJN7lAr1Uhl6zn6/9s=
X-Received: by 2002:a05:690c:6011:b0:785:cbf4:7534 with SMTP id
 00721157ae682-786484164f5mr18054737b3.29.1761881809184; Thu, 30 Oct 2025
 20:36:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251026030143.23807-1-dongml2@chinatelecom.cn>
 <20251026030143.23807-5-dongml2@chinatelecom.cn> <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
In-Reply-To: <CAADnVQLfxjOUqbbexFvvVJ4JTUQ2TKL0wvUn3iHv6vXvGfitoQ@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 31 Oct 2025 11:36:37 +0800
X-Gm-Features: AWmQ_bmKglPpjYeN8wPTAXBHJxvfdd8Q3ML6kp5pKVrlzSQxwPJihOrL8DGnJA4
Message-ID: <CADxym3Y4nc2Qaq00Pp7XwmCXJHn0SsEoOejK8ZxhydepcbB8kQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 4/7] bpf,x86: add tracing session supporting
 for x86_64
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Leon Hwang <leon.hwang@linux.dev>, jiang.biao@linux.dev, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2025 at 9:42=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Oct 25, 2025 at 8:02=E2=80=AFPM Menglong Dong <menglong8.dong@gma=
il.com> wrote:
> >
> > Add BPF_TRACE_SESSION supporting to x86_64. invoke_bpf_session_entry an=
d
> > invoke_bpf_session_exit is introduced for this purpose.
> >
> > In invoke_bpf_session_entry(), we will check if the return value of the
> > fentry is 0, and set the corresponding session flag if not. And in
> > invoke_bpf_session_exit(), we will check if the corresponding flag is
> > set. If set, the fexit will be skipped.
> >
> > As designed, the session flags and session cookie address is stored aft=
er
> > the return value, and the stack look like this:
> >
> >   cookie ptr    -> 8 bytes
> >   session flags -> 8 bytes
> >   return value  -> 8 bytes
> >   argN          -> 8 bytes
> >   ...
> >   arg1          -> 8 bytes
> >   nr_args       -> 8 bytes
> >   ...
> >   cookieN       -> 8 bytes
> >   cookie1       -> 8 bytes
> >
> > In the entry of the session, we will clear the return value, so the fen=
try
> > will always get 0 with ctx[nr_args] or bpf_get_func_ret().
> >
> > Before the execution of the BPF prog, the "cookie ptr" will be filled w=
ith
> > the corresponding cookie address, which is done in
> > invoke_bpf_session_entry() and invoke_bpf_session_exit().
>
> ...
>
> > +       if (session->nr_links) {
> > +               for (i =3D 0; i < session->nr_links; i++) {
> > +                       if (session->links[i]->link.prog->call_session_=
cookie)
> > +                               stack_size +=3D 8;
> > +               }
> > +       }
> > +       cookies_off =3D stack_size;
>
> This is not great. It's all root and such,
> but if somebody attaches 64 progs that use session cookies
> then the trampoline will consume 64*8 of stack space just for
> these cookies. Plus more for args, cookie, ptr, session_flag, etc.

The session cookie stuff does take a lot of stack memory.
For fprobe, it will store the cookie into its shadow stack, which
can free the stack.

How about we remove the session cookie stuff? Therefore,
only 8-bytes(session flags) are used on the stack. And if we reuse
the nr_regs slot, no stack will be consumed. However, it will make
thing complex, which I don't think we should do.

> Sigh.
> I understand that cookie from one session shouldn't interfere
> with another, but it's all getting quite complex
> especially when everything is in assembly.
> And this is just x86 JIT. Other JITs would need to copy
> this complex logic :(

Without the session cookie, it will be much easier to implement
in another arch. And with the hepler of AI(such as cursor), it can
be done easily ;)

> At this point I'm not sure that "symmetry with kprobe_multi_session"
> is justified as a reason to add all that.
> We don't have a kprobe_session for individual kprobes after all.

As for my case, the tracing session can make my code much
simpler, as I always use the fentry+fexit to hook a function. And
the fexit skipping according to the return value of fentry can also
achieve better performance.

AFAIT, the mast usage of session cookie in kprobe is passing the
function arguments to the exit. For tracing, we can get the args
in the fexit. So the session cookie in tracing is not as important as
in kprobe.

What do you think?

Thanks!
Menglong Dong

> I think we better spend the energy designing a mechanism to
> connect existing fentry prog with fexit prog without hacking
> it through a stack in the bpf trampoline.
>
> Sorry.
>
> pw-bot: cr
