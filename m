Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601D636D51F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 13:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739193; cv=pass; b=VuS6gVrZCgOGFmvrB0wZTMbn/KHnXDQUBJCbo0rJMS9Sql6913mekNO0qG37sEtQ3K+WtXcu2ctUV3cvodUa5lSXtQ3WX+eRKaSv+XAAcfJUuyDACQT2cFrcxE2E8OZZx2brJbK9rrtGUtXvYyRo5gxPtPxLZClPecIpfOoWY9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739193; c=relaxed/simple;
	bh=hxkC8KIlEaT56UtUTbB70emjyEUY+aE3e7gX7vJtRy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ln8AhkPzyO96LMvF4X32DVAVyMVeUEkVXkkSvG0avIxvHKNUsvfTEv5IEldfbtN2iylU/tvTC+ggDzMrjM46904NKC1cQ9VahDods5dj+Xyid9dzAaWaERWl5zN+BkK74yHZfZ3DahRb32KdylNbiSOLJQYCtHCugnAod5dwwjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKDJZhrs; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKDJZhrs"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-697df404e32so6845555a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 06:19:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782739191; cv=none;
        d=google.com; s=arc-20260327;
        b=odbOShRvmQ2mNjn7HmxI7rSSesVikFMB5qgTF6rC6CQ5jRfCtKXAlT1kABPrqL6hi4
         /FoOTLr+DSuaBc/i+Ub8q2j8n2G08zUcSBriKyo2W446pZ2ttaqM0u5IMRsR8PVfbRXD
         5pog4I4hpqPttsWaXM+xzkQUm36MoD3IwPWR76W4YJcZ5tgb1i8Iz4at/RrmLOqt2u8c
         0WEfRWwVtGAIGTruZzGXLykFTcnFntRX4CsNMNj36508th538UU/3ae4SSwNn4BDgjxW
         8BoHc9weFn5/X4Rl8Adwlk46cg/g+ZP5dCuq+5V1Q0XFoi1j6ks9VPs8vcGq4dBVkftl
         teRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dJHc5P5+QXd+EJ+9kQea+isULXn2Dht38UwjjlHyyKw=;
        fh=3dxa791ER3yxZlu7v0w/vrl5D44/LZJlzfQgi3FYY5E=;
        b=CWC9dwBgMjrfEUySM7pIoanAk+akEc6UOzBagepIQ4mGtn5tb1GtJHWDpvfBO+uZAM
         PDqenCM2uRQMgZLX3+GIbQwPcBMpanVqLntAD6B5B0XGLcvL6LZd6Ef8QGtlQxDsX88v
         AgOoWAlUuqj5r29QUa79TGcgRE/Gsu+ObbViOLCOK66QvDaciiceKQkB4h0yTJwsb1NP
         r/m+6TRtHSKk5iDPrYdNIdxrTd1muqDnnU4TZkoB7nSA77ceTs6wFN6MC4hRDP4aNGIY
         cA2ZXQ2gZNrq6WSJDSKBUONgzrjAcR4hWHzmM9CTyFT0eKiBZiKnZWJD5IZR5YfWko/o
         Hghg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782739191; x=1783343991; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dJHc5P5+QXd+EJ+9kQea+isULXn2Dht38UwjjlHyyKw=;
        b=CKDJZhrsAaQ/2cVur7FBd2Us7z31bC0ySPVoXEJKUSMo8oTV6nQJ2cC/6YsKejMKjv
         FMVMTXNGKYrh8yXGEavElD1CAUpTUl/gMqIaWsumAErwxS/WlDKENWd5vDcSDmHzjho/
         MTiZO/Cfw7XE+MCckG3O01cQkCCIru2y12BjfAn3Dg0VuiVxpVT/c5ctuD9qP9e7ITFZ
         lP9sB5WDvzNQYgfQiR80B/1xPs4ATp6lHTYAxqkGGwtm1odlnyqnTDC1pULObRa7lqXR
         Lqt7pd9V+pCEiSdcQpM6vtO3ehzgfZNGfTGg1oIj36gN2Cbz2yEa0mBS9KFcxCMJv7Tl
         GdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739191; x=1783343991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dJHc5P5+QXd+EJ+9kQea+isULXn2Dht38UwjjlHyyKw=;
        b=NQeKrlWEbqC0+Gp60soKd57urD7NK0gVOquDF0f6p8S6dUr15jAmsOkh5K/oIDMgWt
         517WK/GhOe5DvmuWPkwiOJUGnBLgnohfKDW3g2rM+4whJx8rjeWesVB0vZx30ca8LZBM
         hpbF+pdINoGsphMvoGX8BZgBOO6G1t3QYTNY6lPgTyGW1iYhyMevVJT79FGjGKl/7kJU
         5DU/LKzGHr9fE+oQ2PGVLFHcT3CLTJmX/SX6Ed3Jfw13yXC1qJC030H+4zcIy6Qi/wDg
         NQ/CU/TSrOO299jB/EWBWrzSg/hbt/Psj5cMZarFKCrOghpYe7mp7J3eiFxzbmF2DERA
         XgTQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqn2J8sXxVpiq+xyJeGonHdlW82Yqd0tbF5jz41f6au9XvaZqs74BqMS0lWWRDw/f0lnccSnRoIRRduxvUr7wOEAis=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY+lXAnPJnf/k5do1UQMvcLNxalksumPoEOEjTzrcYdgGtMyef
	vF5CubfwEJL5Ha+UTavWjW0DlBekTklVxcWjSjeqdPUMAWi6/YX/9wCAx2wi5XUKpPHHR0RuNrs
	G12X3ndxXFqzrPKhFnogAJ7yqnY8dGHg=
X-Gm-Gg: AfdE7cmhqlwZDdBUBUhVMZZy1sSE8AapK+/dJecg92DrAakNOFyO7sPGVWIqQr7Emw+
	qefJSybYPFWR1h0oW2RC4Z9im1/stp9fh2dgnx4dqTeVuSfwKYuaBhCaET6UWbWOAfJbWsogpzt
	lKl/Lrl3DBBwhwxr4GHzHuALYRLkjLFdz8eUou1ZcVUApN7xQzEdFyKMTAkkUSyUhQKoYMuqEBK
	PW01zP+k/Tnd8DXmzFt1vy1LEJoAmyhKqCmKLgbQeDLMja7vC6VjcM8JcQ4lkpZfY6csFm0kw==
X-Received: by 2002:aa7:d30d:0:b0:698:3b7c:7e39 with SMTP id
 4fb4d7f45d1cf-6983b7c7f6cmr3492229a12.35.1782739190617; Mon, 29 Jun 2026
 06:19:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251215034153.2367756-1-dolinux.peng@gmail.com>
 <20251215034153.2367756-2-dolinux.peng@gmail.com> <20260513104229.2f39eb03@gandalf.local.home>
In-Reply-To: <20260513104229.2f39eb03@gandalf.local.home>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Mon, 29 Jun 2026 21:19:37 +0800
X-Gm-Features: AVVi8CcwXsWLmGI1EfghufBHUvXsCA3iL3jmwnaCxFFFF7XYRD1PwQR0Vk7rgC8
Message-ID: <CAErzpmvMd9Vixtue0pm5GJAFFvT4-8DcmopgShGNXxG5UyVsQw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] ftrace: Build trace_btf.c when CONFIG_DEBUG_INFO_BTF
 is enabled
To: Steven Rostedt <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 10:42=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
>
> Sorry for the late reply, I've been a bit busy on other things recently.
>
> On Mon, 15 Dec 2025 11:41:51 +0800
> Donglin Peng <dolinux.peng@gmail.com> wrote:
>
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > The trace_btf.c file provides BTF helper functions used by the ftrace
> > subsystem. This change makes its compilation solely dependent on
>
> Nit, change logs should never say "This change". Instead it should be
> worded as:
>
>   "Make the compilation of trace_btf.c soley depend on..."

Thanks, I will fix it.

>
> -- Steve
>
> > CONFIG_DEBUG_INFO_BTF, allowing features like funcgraph-retval to also
> > utilize these helpers.
> >
> > Additionally, the redundant dependency on CONFIG_PROBE_EVENTS_BTF_ARGS
> > is removed, as CONFIG_DEBUG_INFO_BTF already depends on
> > CONFIG_BPF_SYSCALL.
> >
> > Cc: Steven Rostedt (Google) <rostedt@goodmis.org>
> > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> > Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> > ---
> >  kernel/trace/Kconfig  | 2 +-
> >  kernel/trace/Makefile | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> > index e1214b9dc990..653c1fcefa4c 100644
> > --- a/kernel/trace/Kconfig
> > +++ b/kernel/trace/Kconfig
> > @@ -755,7 +755,7 @@ config FPROBE_EVENTS
> >  config PROBE_EVENTS_BTF_ARGS
> >       depends on HAVE_FUNCTION_ARG_ACCESS_API
> >       depends on FPROBE_EVENTS || KPROBE_EVENTS
> > -     depends on DEBUG_INFO_BTF && BPF_SYSCALL
> > +     depends on DEBUG_INFO_BTF
> >       bool "Support BTF function arguments for probe events"
> >       default y
> >       help
> > diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
> > index fc5dcc888e13..6c4bf5a6c4f3 100644
> > --- a/kernel/trace/Makefile
> > +++ b/kernel/trace/Makefile
> > @@ -116,7 +116,7 @@ obj-$(CONFIG_KGDB_KDB) +=3D trace_kdb.o
> >  endif
> >  obj-$(CONFIG_DYNAMIC_EVENTS) +=3D trace_dynevent.o
> >  obj-$(CONFIG_PROBE_EVENTS) +=3D trace_probe.o
> > -obj-$(CONFIG_PROBE_EVENTS_BTF_ARGS) +=3D trace_btf.o
> > +obj-$(CONFIG_DEBUG_INFO_BTF) +=3D trace_btf.o
> >  obj-$(CONFIG_UPROBE_EVENTS) +=3D trace_uprobe.o
> >  obj-$(CONFIG_BOOTTIME_TRACING) +=3D trace_boot.o
> >  obj-$(CONFIG_FTRACE_RECORD_RECURSION) +=3D trace_recursion_record.o
>
