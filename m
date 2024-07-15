Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881A217BB4;
	Mon, 15 Jul 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063472; cv=none; b=oXzUF/DWNIB8wVHB3KUi5zR2vOqUouHubFOqjZDs3kt+5+inV/Nou6ZngIigQshWG7+MC945y6DKB/veV+5zbiuCzDZtIk1vthree7JFaeWhs7j3odga/R6aIMB7hvHRmliTq/9420V4Z0U2MIywy6pCxqGLNXTJW1G/Qpq2VQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063472; c=relaxed/simple;
	bh=sE2l+AJ+jOkXSJEM7XiFmIWXkjkGToqX6Q5unCwbdcw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XB9nX5X/9npEKtZXbyvgEOpQuyzhk9YBNoXacMnhf4R59qXCPoUe5lezO/bdjA6UkX68yzSSeDlRiSN6faMHlG/rc+fWIgeHzIQbOulBhDP8bh2lGuuf5qby9cjQEM3kJreN706GXmdqu4DCCOM8a3ba/8X6X4Ik0NqVDiWiu8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvEIRw3y; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvEIRw3y"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-70b12572bd8so3083058b3a.2;
        Mon, 15 Jul 2024 10:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721063470; x=1721668270; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Juvk9Mh9FVF1mZV8matVXreUlpeXpyTK/r3nCThib2I=;
        b=gvEIRw3yILbjp7pnstBSmJzXmFg0X3tGi3H9+HhgOCl96i1IpURSH4191wGZrdcSIr
         luGAZufWULlwWh0N/TMW5X/ccRN41ktWnAYb92IEt//lHQud7UaFxyGCmZNIVr++FRUb
         prp379ihnpGoPxPjLAs+LSmWOSqSJOXMmB8mqch9t+l1wzZZcWiBCkGZ4qfu9pOzjtgw
         Gm0+6yJFun17KoahVqcJDGqd7+XW1REl3EsSyBb0IxqWvOdEIx/wvtq8ORIyMC0G2DZf
         Jpv/9EX6TgFNYQeNAjmNTTHABLiSyEpK2n2ExsW/zdKCs1KFm18In9A2CWQCcq6adyX/
         nyyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063470; x=1721668270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Juvk9Mh9FVF1mZV8matVXreUlpeXpyTK/r3nCThib2I=;
        b=l1ga8FjkWSilzKkY2USqoxFiJqVpjfwdtVpnDm5VuexSQie3KE6BGEH7Om8iD/BonC
         G9+gweYmgKlmr2Xtoagoh4fuanfOOhHFYZ/JfrVlbBYqfM11WtLAOqDl4J/s/Y+1D2LU
         GNDoxX/RnUHP92h910ZTh9Mpd1VvA/1mQQ3FnadW8qSx41eF4UyysT3DAzK94i6V4Cur
         LuuLFJZwC5g6zOzHqzp5hAUsPQupYsCkW2EVHZm5TbgcZSMZtpKGx8CGZP34nOAS4qCM
         7IsY0bTOE0GN0ePzP12GwZ294NpIoW2qIMzKhJWQbx9spd9dEaF7Efz9Djrq2zb/W0cC
         19CQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdYS7FrwDkxM6M5F19M6tXbOVrVj/HLYZZzIEMIeKFoFlnK6Gye1x5T2ys5tKGup8mLY+Db5tY8u5iJ1LLhHKtMxmjcGvbzacyfaBc6SLd+lUujqsVhe/e6OkCjGJ1sosrGEBFBy55tcKndDhxX8VH
X-Gm-Message-State: AOJu0YzOT+IfrIKUUsyfWqSCxG2GsiYwaUxwC3rWfLqKDkn5VA8SdoL9
	8cIrtfxl+16Qf+pftCTfOR5x7YEz4SMWFBl1gdBVYo5GsQJ0FY21/elKDpLDGmsOcmg+ebWx33I
	Pfb/DGOrS7W/rIz3GrfrbQ37CzK4=
X-Google-Smtp-Source: AGHT+IHDMbDPUkUH66xtlh2FLSelH0/gS7ZfUGbaXVnMbpZhuTsxonLkX6SB67lKTohe16DcY4BsPNHxZRQa336TGgM=
X-Received: by 2002:a05:6a21:150d:b0:1c3:cfc2:2b1f with SMTP id
 adf61e73a8af0-1c3ee6572e7mr568762637.37.1721063469690; Mon, 15 Jul 2024
 10:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org> <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>
 <20240715144536.GI14400@noisy.programming.kicks-ass.net>
In-Reply-To: <20240715144536.GI14400@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 15 Jul 2024 10:10:57 -0700
Message-ID: <CAEf4BzZuR883FEuKAXp3DY1iJcL+ST8eNq5ioq8oRpDyg0w8Kw@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: oleg@redhat.com, mingo@kernel.org, andrii@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, jolsa@kernel.org, clm@meta.com, 
	paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:45=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Thu, Jul 11, 2024 at 09:57:44PM -0700, Andrii Nakryiko wrote:
>
> > But then I also ran it on Linux built from perf/uprobes branch (these
> > patches), and after a few seconds I see that there is no more
> > attachment/detachment happening. Eventually I got splats, which you
> > can see in [1]. I used `sudo ./uprobe-stress -a10 -t5 -m5 -f3` command
> > to run it inside my QEMU image.
>
> So them git voodoo incantations did work and I got it built. I'm running
> that exact same line above (minus the sudo, because test box only has a
> root account I think) on real hardware.
>
> I'm now ~100 periods in and wondering what 'eventually' means...

So I was running in a qemu set up with 16 cores on top of bare metal's
80 core CPU (Intel(R) Xeon(R) Gold 6138 CPU @ 2.00GHz). I just tried
it again, and I can reproduce it within first few periods:

WORKING HARD!..

PERIOD #1 STATS:
FUNC CALLS               919632
UPROBE HITS              706351
URETPROBE HITS           641679
ATTACHED LINKS              951
ATTACHED UPROBES           2421
ATTACHED URETPROBES        2343
MMAP CALLS                33533
FORKS CALLS                 241

PERIOD #2 STATS:
FUNC CALLS                11444
UPROBE HITS               14320
URETPROBE HITS             9896
ATTACHED LINKS               26
ATTACHED UPROBES             75
ATTACHED URETPROBES          61
MMAP CALLS                39093
FORKS CALLS                  14

PERIOD #3 STATS:
FUNC CALLS                  230
UPROBE HITS                 152
URETPROBE HITS              145
ATTACHED LINKS                2
ATTACHED UPROBES              2
ATTACHED URETPROBES           2
MMAP CALLS                39121
FORKS CALLS                   0

PERIOD #4 STATS:
FUNC CALLS                    0
UPROBE HITS                   0
URETPROBE HITS                0
ATTACHED LINKS                0
ATTACHED UPROBES              0
ATTACHED URETPROBES           0
MMAP CALLS                39010
FORKS CALLS                   0

You can see in the second period all the numbers drop and by period #4
(which is about 20 seconds in) anything but mmap()ing stops. When I
said "eventually" I meant about a minute tops, however long it takes
to do soft lockup detection, 23 seconds this time.

So it should be very fast.

Note that I'm running with debug kernel configuration (see [0] for
full kernel config), here are debug-related settings, in case that
makes a difference:

$ cat ~/linux-build/default/.config | rg -i debug | rg -v '^#'
CONFIG_X86_DEBUGCTLMSR=3Dy
CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
CONFIG_BLK_DEBUG_FS=3Dy
CONFIG_PNP_DEBUG_MESSAGES=3Dy
CONFIG_AIC7XXX_DEBUG_MASK=3D0
CONFIG_AIC79XX_DEBUG_MASK=3D0
CONFIG_SCSI_MVSAS_DEBUG=3Dy
CONFIG_DM_DEBUG=3Dy
CONFIG_MLX4_DEBUG=3Dy
CONFIG_USB_SERIAL_DEBUG=3Dm
CONFIG_INFINIBAND_MTHCA_DEBUG=3Dy
CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=3Dy
CONFIG_CIFS_DEBUG=3Dy
CONFIG_DLM_DEBUG=3Dy
CONFIG_DEBUG_BUGVERBOSE=3Dy
CONFIG_DEBUG_KERNEL=3Dy
CONFIG_DEBUG_INFO=3Dy
CONFIG_DEBUG_INFO_DWARF4=3Dy
CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
CONFIG_DEBUG_INFO_BTF=3Dy
CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
CONFIG_DEBUG_FS=3Dy
CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
CONFIG_ARCH_HAS_DEBUG_WX=3Dy
CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
CONFIG_SCHED_DEBUG=3Dy
CONFIG_DEBUG_PREEMPT=3Dy
CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
CONFIG_DEBUG_RT_MUTEXES=3Dy
CONFIG_DEBUG_SPINLOCK=3Dy
CONFIG_DEBUG_MUTEXES=3Dy
CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
CONFIG_DEBUG_RWSEMS=3Dy
CONFIG_DEBUG_LOCK_ALLOC=3Dy
CONFIG_DEBUG_LOCKDEP=3Dy
CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
CONFIG_DEBUG_IRQFLAGS=3Dy
CONFIG_X86_DEBUG_FPU=3Dy
CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy

  [0] https://gist.github.com/anakryiko/97a023a95b30fb0fe607ff743433e64b

>
> Also, this is a 2 socket, 10 core per socket, 2 threads per core
> ivybridge thing, are those parameters sufficient?

Should be, I guess? It might be VM vs bare metal differences, though.
I'll try to run this on bare metal with more production-like kernel
configuration to see if I can still trigger this. Will let you know
the results when I get them.
