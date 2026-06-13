Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64CF43112B2
	for <linux-trace-kernel@vger.kernel.org>; Sat, 13 Jun 2026 04:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781324340; cv=none; b=qf2iQT56P8B8WBpZiZj6JK3z8pUdVWMlxqx+2qCT3uj1gzp+fB9hYeS2xZsX8XhBYBwlFlQAL49/cAkydKQbbeSyfdoYiaDvpUNiUxaNRpBkIfuen04O1K7NcZHJE3C1TTvb67N23A7ipj8Z9SYc6Kae9yA4sCFY5LKP8kOa9Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781324340; c=relaxed/simple;
	bh=94pmSxxXwigo8rQnUo4y837fT0gsI4xXDFVI8LixR9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rH+XcCo6bHaFzEKFL+Xkx66eQ4lrNpRmxV4ysuDefKlnYDiNSHQrVnE50Q0Eh4MJMx/eBSx0xJFt5qW28ojzn2RxtyfUX6kuVjNxgIUnW47qT0jQSF1co2u50yJ9k3GD+OrCHhIU/NxyTEUGC+C9++PreJ27YAadZu4MS/kfJnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=maskray.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa68d9d56fso2121730e87.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 21:18:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781324338; x=1781929138;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QNBpFZSlT9IipEukCIMaVMW5t0ZIvjSC1UXquBgnP14=;
        b=kO/PYxsB8/Hkg5vfKRBaOCFWO1FHdCLkDE4hr0nf7OomA9sjkBDumogLaa85D0k0RD
         wu07B3tDgca2nLPOqpdtKrEQi5CbisX8p5w5id40Yy1YBrxLYwfCEQv+Pu0wbcRQM/rM
         Qn+iGpiq75SRd7syqEim7UgsucvNMV0klgCLnslzqA37m6eeuJdbveUV9Rl6tRZWQ/iw
         6V8JqDuqCQTIqKQ41+lXnXrSStY7vSIinbRX5FAn08HTmMLJl13Qw4rkIJCigNTF2tEf
         S7o9bV+6KPOtlHq8Oi8IfGxIe/RFk4w9wAYJK4sGwPi/+Eu32fui9UAwH/hixyGY63wi
         szPg==
X-Forwarded-Encrypted: i=1; AFNElJ/Dxi7LabNLursRgQfzlbw3vqcFL2mHQKzgrX7c3n4wnYRWBUQIjwNylo6zQxNT1GXlF+xNbdTogN17u5wmGZbABSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt+qQJiZEng9cvn0SWG7IpBzrlIk0ZeIdw2HKSP6rcBqAuDXGo
	IsNpWWiUCFEwgezQ/02DJFJREqp8mnSJganjbqlCTmK4oxlFiYQ2kELrlh3n15jh7AU=
X-Gm-Gg: Acq92OFFSzLhr1wnRh9C1PDwwRL5KWdZbk1StEMk6dS4L+L8MqxDiwVmk5UIV8RiG0Z
	g8t9Yckv5CKf+pgIPVrhjJR7I9A9JzkB2pp7sCI/2zQdydqBuzLDGN8i0AeSpX7yMIx2xHx1HiE
	ZcRTiy8hqa6E1NURNKIObLx6Bu831LAchb5GVYV3vciGm8H0tPJMSF4O8ROtsPCmyKB7nfSU1KU
	IaKV8/iAL1BvLLYpatEZJ5tcw0Hqi2JWsKmjCwgYUeMZa9SluXLcx/gxIjbWBxoJAhNQKc3pXkF
	eIYpNEyURsA6HxoXOy/F71nMTNYQbq4QO0NlywEawpQir0X3HOogKqJ0WLUmhh1NGR4cNsRWMfR
	URPmMDpGhI5oi+XvvB3/HECRJDDaLAqUhnADEtdgaHTMoKsHZhzEjABI/BjPBCymCADItLIA1so
	8TAhDOiTVz8DicrBFtRhDZRuVx0wRc42/MXOv7PIbS0FomOA0Rd6VwDrLEYqizQ4+75I+nE2vfm
	NNv42KrNA==
X-Received: by 2002:ac2:47f1:0:b0:5aa:780b:f341 with SMTP id 2adb3069b0e04-5ad2db77eb3mr1049585e87.35.1781324337462;
        Fri, 12 Jun 2026 21:18:57 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a729fsm992196e87.54.2026.06.12.21.18.56
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 21:18:56 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa7a70c0aaso1490787e87.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Jun 2026 21:18:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+/s5FeLVz5annZrN4XABLENwjhu1Wpl3QWFnA3FerRPDvS67+XSKPliI71b2M45Lf4nBTq47HzaFJ1TxfzilZbwI8=@vger.kernel.org
X-Received: by 2002:a05:6512:12c8:b0:5a3:6731:910a with SMTP id
 2adb3069b0e04-5ad2db379a4mr1715631e87.11.1781324336334; Fri, 12 Jun 2026
 21:18:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528151626.4573592d@gandalf.local.home> <aipWtXVRqNmZY4gr@archer>
 <20260611072249.2222fd9d@gandalf.local.home>
In-Reply-To: <20260611072249.2222fd9d@gandalf.local.home>
From: Fangrui Song <i@maskray.me>
Date: Fri, 12 Jun 2026 21:18:56 -0700
X-Gmail-Original-Message-ID: <CAN30aBFVDxeoXApn_g_Hw0Ayhi4V=m7CcX8UDO6ZDTi6xA-3Pg@mail.gmail.com>
X-Gm-Features: AVVi8CeA-wfXRKwpwFaX1TpuI1S98nIWVMn-l0DOzuzXaavbqA8lya5xLsRWjsk
Message-ID: <CAN30aBFVDxeoXApn_g_Hw0Ayhi4V=m7CcX8UDO6ZDTi6xA-3Pg@mail.gmail.com>
Subject: Re: [RESEND][PATCH v2] unwind: Add sframe_(un)register() system calls
To: Steven Rostedt <rostedt@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, bpf@vger.kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Jens Remus <jremus@linux.ibm.com>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, 
	Indu Bhagat <ibhagatgnu@gmail.com>, "Jose E. Marchesi" <jemarch@gnu.org>, 
	Beau Belgrave <beaub@linux.microsoft.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Florian Weimer <fweimer@redhat.com>, 
	Kees Cook <kees@kernel.org>, "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>, 
	Dylan Hatch <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko <mhocko@suse.com>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 4:23=E2=80=AFAM Steven Rostedt <rostedt@kernel.org>=
 wrote:
>
> On Thu, 11 Jun 2026 00:00:25 -0700
> Fangrui Song <i@maskray.me> wrote:
>
> > Hi Steven,
> >
> > This is not an objection to deferred userspace unwinding itself -- my
> > concern is narrower: these syscalls permanently encode the kernel's
> > commitment to the SFrame format family at exactly the moment the
> > format's size trajectory is heading the wrong way, and while arguably
> > superior formats exist.
> >
> > I raised related size concerns about SFrame's viability for userspace
> > stack walking earlier:
> > https://lore.kernel.org/all/3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5t=
ounihe4@3ftafgryadsr/
> > ("Concerns about SFrame viability for userspace stack walking")
> >
> > SFrame v3 is even larger than v2.
> >
> > For comparison: Microsoft is currently upstreaming its Windows x64
> > Unwind V3 implementation to LLVM, which will make a side-by-side readin=
g
> > of the two formats straightforward. Unwind V3 provides correct
> > exception-handling unwind -- full prologue replay, SEH handlers,
> > funclets -- and supports Intel APX. SFrame v3 provides stack tracing
> > only, no EH, yet comes out larger than .eh_frame. A format revision tha=
t
> > adds capability without adding bulk is demonstrably achievable; SFrame
> > v3 went the other way.
>
> My main concern is simplicity in implementation on the kernel side. One
> thing we would like to avoid is any interpreter that becomes basically
> executing user space code to perform the stack tracing (i.e. DWARF). I
> haven't looked at the Windows x64 but will do so.

I recognize interpreter complexity as a real and valid concern (though
I believe the concern can be alleviated with a good use of LLM
auditing).
But the SFrame family's size problem is more pressing than it's being
given credit for, because of a point that applies specifically to
x86-64: SFrame cannot *replace* .eh_frame there, only add to it (to
keep debugging and C++ exception handling working).

.eh_frame+.eh_frame_hdr almost takes 9%; adding .sframe adds another 9% on =
top.
I don't think the perceived benefit on x86-64 justifies near-doubling
the unwind metadata footprint.


x86-64 experiments with x64 Unwind V3 for ELF:

                    unwind B     VM B      % of VM
  sqlite3 -O0
    .eh_frame(+hdr)   42,120   446,735      9.43%
    Win64 v1          24,536   438,609      5.59%
    Win64 v3          33,296   450,889      7.38%
    SFrame v3         39,105   440,727      8.87%

  sqlite3 -O1
    .eh_frame(+hdr)   44,424   479,348      9.27%
    Win64 v1          15,496   450,724      3.44%
    Win64 v3          21,816   458,916      4.75%
    SFrame v3         44,756   477,776      9.37%

  CGExpr.cpp -O3
    .eh_frame(+hdr)   27,040   372,416      7.26%
    Win64 v1          10,720   356,080      3.01%
    Win64 v3          15,320   360,185      4.25%
    SFrame v3         27,628   370,912      7.45%

> >
> > I understand IBM is doubling down on SFrame for their s390x and ppc64,
>
> That's because this is currently the only way s390 can perform stack
> walking in user space.

Hmm, I think that DWARF .eh_frame already works on s390x, but I take
your word that .sframe might be appealing for some use cases.

Perhaps s390x and x86-64 shouldn't be decided by the same vote.

> > but I'm not convinced the size overhead of v3 will make it appealing on
> > x86-64. I have learned that the person driving their SFrame work at
> > Google had left and the SFrame at data center effort was being
> > reevaluated per a toolchain manager.

> I believe the person who left Google that was driving the SFrame work was
> me ;-)
>
> Thanks,
>
> -- Steve

Ha, I wasn't referring to you. I had a different toolchain engineer in mind=
.
But that was a secondhand aside and not the point I want to rest
anything on, so I'll set it aside and stick to the bytes.

-----

Separately, on maturity and sequencing:

On timing: the SFrame v3 binutils set was first posted 2025-12-09; the
2.46 branch was cut 2026-01-17 and released 2026-02-08 with v3
generation. That's a ~5-week window, and I'm not convinced there's
been time for rigorous review of the v3 design; if flaws surface we're
at a v4, and kernel adoption still wouldn't be a given.
