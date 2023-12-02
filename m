Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D834BFC04
	for <linux-trace-kernel@vger.kernel.org>; Sat,  2 Dec 2023 09:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLbYEE/G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1F6C433C8
	for <linux-trace-kernel@vger.kernel.org>; Sat,  2 Dec 2023 09:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701509229;
	bh=YfoUk0rwbXkKt7a7go5TxbaxbQRDIswTymi2vdlhOYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TLbYEE/GEcFJqJY+ApSohb7otAt/OlJutem4iBFEaxwmF+43mxEcq/UZO7rUJ3IL1
	 eBsMUEdYT0SaB4EDPv6zuIBm0ABPZKgOuQ22jONwF6rotSoOe0ckPuq5RAVhBrGBtd
	 uPh1B/0VvZMcBKGFc1ZDtCZI7Hj+aCzzWIs7ZRi8t8o5f0YX/S/pRmogbIZqQKj9X2
	 JMAgP/5BYexm4gwinGEeBOSvxsilhnsvzpvvBdITdY3GIu/D/q7rd779Cde0XGtkal
	 5kbqRaDmjo3IrU8OjXccuyJL7GLNJY+LahOfmwBrrWvjyQCffO/wLI/a16gBukf4wy
	 N9x3ZTgXCzIzg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2c9c18e7990so38831321fa.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 02 Dec 2023 01:27:09 -0800 (PST)
X-Gm-Message-State: AOJu0YzybLLdCfxnb9N4jAihnAeN5z8vCdugQNnJ+aii/oiJ7wG7u0TX
	knOoDRoSoD4tWqmnLKfcWWiKYYY4UQmyFmGPwM8=
X-Google-Smtp-Source: AGHT+IH50vKoBeJxgiPew2Ap3weeq51LZwq4YLQEFlbWKhDAdqLJU1ByIdCXNoWpNjkXD2XeW7UfYuxz+S7Yv2NE1f0=
X-Received: by 2002:a05:6512:2345:b0:50b:d764:8029 with SMTP id
 p5-20020a056512234500b0050bd7648029mr1949142lfu.92.1701509227461; Sat, 02 Dec
 2023 01:27:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d870c149-4363-43de-b0ea-7125dec5608e@broadcom.com>
 <CAMj1kXGST7uH530hB0i-rzisNesNrUGsJ5a5eC9805Udi5msrQ@mail.gmail.com>
 <81af85b4-5274-4362-9413-890425c60524@broadcom.com> <20231201130702.2824115c@gandalf.local.home>
 <4597db06-dabc-4bb2-9f24-bd30e07ff86d@broadcom.com> <CAMj1kXFMy0=DP3-Ycsj+XCHWxvqNqddBkEm71Nrr-m9gVca21w@mail.gmail.com>
 <dc1dd584-1970-4460-b76c-3cd9300a23e4@broadcom.com>
In-Reply-To: <dc1dd584-1970-4460-b76c-3cd9300a23e4@broadcom.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 2 Dec 2023 10:26:54 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFRknpr+gASm-mMcWzLqVQnWXf3UK+SbD3ouMgdOtCAzA@mail.gmail.com>
Message-ID: <CAMj1kXFRknpr+gASm-mMcWzLqVQnWXf3UK+SbD3ouMgdOtCAzA@mail.gmail.com>
Subject: Re: ARM Ftrace Function Graph Fails With UNWINDER_FRAME_POINTER
To: Justin Chen <justin.chen@broadcom.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org, mark.rutland@arm.com, 
	linux@armlinux.org.uk, linux-trace-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger <doug.berger@broadcom.com>
Content-Type: text/plain; charset="UTF-8"

On Sat, 2 Dec 2023 at 09:49, Justin Chen <justin.chen@broadcom.com> wrote:
>
>
>
> On 12/1/23 10:53 PM, Ard Biesheuvel wrote:
> > On Fri, 1 Dec 2023 at 23:59, Justin Chen <justin.chen@broadcom.com> wrote:
> >>
> >>
> >>
> >> On 12/1/23 10:07 AM, Steven Rostedt wrote:
> >>> On Fri, 1 Dec 2023 09:25:59 -0800
> >>> Justin Chen <justin.chen@broadcom.com> wrote:
> >>>
> >>>>> It appears the sub instruction at 0x6dd0 correctly accounts for the
> >>>>> extra 8 bytes, so the frame pointer is valid. So it is our assumption
> >>>>> that there are no gaps between the stack frames is invalid.
> >>>>
> >>>> Thanks for the assistance. The gap between the stack frame depends on
> >>>> the function. Most do not have a gap. Some have 8 (as shown above), some
> >>>> have 12. A single assumption here is not going to work. I'm having a
> >>>> hard time finding out the reasoning for this gap. I tried disabling a
> >>>> bunch of gcc flags as well as -O2 and the gap still exists.
> >>>
> >>> That code was originally added because of some strange things that gcc did
> >>> with mcount (for example, it made a copy of the stack frame that it passed
> >>> to mcount, where the function graph tracer replaced the copy of the return
> >>> stack making the shadow stack go out of sync and crash). This was very hard
> >>> to debug and I added this code to detect it if it happened again.
> >>>
> >>> Well it's been over a decade since that happened (2009).
> >>>
> >>>     71e308a239c09 ("function-graph: add stack frame test")
> >>>
> >>> I'm happy assuming that the compiler folks are aware of our tricks with
> >>> hijacking return calls and I don't expect it to happen again. We can just
> >>> rip out those checks. That is, if it's only causing false positives, I
> >>> don't think it's worth keeping around.
> >>>
> >>> Has it detected any real issues on the Arm platforms?
> >>>
> >>> -- Steve
> >>
> >> I am not familiar enough to make a call. But from my limited testing
> >> with ARM, I didn't see any issues. If you would like me to, I can submit
> >> a patch to remove the check entirely. Or maybe only disable it for ARM?
> >>
> >
> > Please try the fix I proposed first.
>
> Just tested it. Seems to do the trick.

Thanks

> Either solution works for me.
>

Given that this discussion is taking place in the context of the
report of an issue identified by GRAPH_FP_TEST, I don't see how
removing that would be a reasonable conclusion.

> FWIW I also experimented with LLVM, looks like function_graph just
> crashes regardless of the issue being discussed. The disassemble of
> LLVM[1] does something completely different.
>


LLVM does not support CONFIG_UNWINDER_FRAME_POINTER so the fact that
the prologue looks different is expected.

In the case below, the FP {r11} is correctly made to point to a {r11,
lr} tuple on the stack, so the codegen is correct AFAICT. But IIRC we
rely on unwind information for ftrace in this case, not the frame
pointer.

Could you be more specific about the crash?


>
> [1]
> LLVM dump
> c0c6faa0 <sk_getsockopt>:
> c0c6faa0: f0 4f 2d e9   push    {r4, r5, r6, r7, r8, r9, r10, r11, lr}
> c0c6faa4: 1c b0 8d e2   add     r11, sp, #28
> c0c6faa8: ac d0 4d e2   sub     sp, sp, #172
> c0c6faac: 00 70 a0 e1   mov     r7, r0
> c0c6fab0: c8 0c 04 e3   movw    r0, #19656
> c0c6fab4: 80 02 4c e3   movt    r0, #49792
> c0c6fab8: 03 50 a0 e1   mov     r5, r3
> c0c6fabc: 00 00 90 e5   ldr     r0, [r0]
> c0c6fac0: 02 a0 a0 e1   mov     r10, r2
> c0c6fac4: 20 00 0b e5   str     r0, [r11, #-32]
> c0c6fac8: 00 40 2d e9   stmdb   sp!, {lr}
> c0c6facc: 4b 8b d6 eb   bl      0xc0212800 <__gnu_mcount_nc> @ imm =
> #-10867412
