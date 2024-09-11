Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BA55FB8D;
	Wed, 11 Sep 2024 17:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726075009; cv=none; b=msGCjIHVZeoQwoslAQGin13tbeIvnNk3aKZAJjZXSd1hwTk/0egt/LIOK4RYNqNkh+/areof14TQKOkodE/N+tbrqf5Ww3yJ93X1wWyFoCp8NUnS5Uv9l4p+iliMvr4mZmGmW6q7eC+ITkdoLwfNrlS/c5NeWt4poiavKw/WkRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726075009; c=relaxed/simple;
	bh=gk0D7dk5m/BqadUrmqslhatWswvf3Qbg/fuZ/ZCamp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QRlNRl6NUJ8kE11CZ/gMG/cgL1gIAItdnVP01/bTgBQ5G1Ta2fll9ZNdlWjcXkiPIhdF49cq1pcBR0zNGVQnc7ym1lXtAAJCai8USluGRaEUswagI7aKYJS15EpfKdRsF9MeXx08ObRafhEYSFV7d49hT6wty5dcOigUhHeXFPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q5h/f8eP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q5h/f8eP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E72AC4CEC0;
	Wed, 11 Sep 2024 17:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726075009;
	bh=gk0D7dk5m/BqadUrmqslhatWswvf3Qbg/fuZ/ZCamp4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q5h/f8ePlcZq4YataaiDmY/JwIgU8pNEogVkh08iVQsVbCcRKOBPSsUZVzacShRe+
	 tx4nknFwAtamNixru3tZO6RZByE+ilXcczMCe1UVlieRro1JtFLDvAw2RlkPGHSkef
	 kfb9ScC3CEO+XHHmjqxTFvDMChz2s/0nF+C2lkZdl+wW6FNIoSEC4fb/KaG2ZzyWcw
	 fwC4SQXg69TLdPAgH4tTzPqwHXRFQgMGuV+wL310qR35Ygt5rDIoRdxYNSJ97HH78Q
	 GGPVqx1opDEWVPeFg9GyeTd7Pt7G5y2rXP1N2lhSc1N+wPXd5MJwrNN7qAr7l1kOTh
	 7tg/ywg2yVsIw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Tao Chiu <andybnac@gmail.com>
Cc: alexghiti@rivosinc.com, andy.chiu@sifive.com, aou@eecs.berkeley.edu,
 justinstitt@google.com, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 llvm@lists.linux.dev, mark.rutland@arm.com, mhiramat@kernel.org,
 morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
 palmer@dabbelt.com, palmer@rivosinc.com, paul.walmsley@sifive.com,
 puranjay@kernel.org, rostedt@goodmis.org, zong.li@sifive.com,
 yongxuan.wang@sifive.com
Subject: Re: [PATCH v2 3/6] riscv: ftrace: prepare ftrace for atomic code
 patching
In-Reply-To: <CAFTtA3PYsdSio0EqkUKQpyLiMuY9iynOdWQAkebAPjL6THEaMQ@mail.gmail.com>
References: <87sev78dnz.fsf@all.your.base.are.belong.to.us>
 <ZuFteQ3t8K4h2-kJ@Andys-MacBook-Air.local>
 <87v7z2dzo6.fsf@all.your.base.are.belong.to.us>
 <CAFTtA3PYsdSio0EqkUKQpyLiMuY9iynOdWQAkebAPjL6THEaMQ@mail.gmail.com>
Date: Wed, 11 Sep 2024 19:16:45 +0200
Message-ID: <87r09qdsaq.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Tao Chiu <andybnac@gmail.com> writes:

> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> =E6=96=BC 2024=E5=B9=B49=E6=9C=
=8811=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8810:37=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
>>
>> Andy Chiu <andybnac@gmail.com> writes:
>>
>> > On Wed, Aug 14, 2024 at 02:57:52PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> >> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>> >>
>> >> > Andy Chiu <andy.chiu@sifive.com> writes:
>> >> >
>> >> >> We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
>> >> >> instruction fetch can break down to 4 byte at a time, it is imposs=
ible
>> >> >> to update two instructions without a race. In order to mitigate it=
, we
>> >> >> initialize the patchable entry to AUIPC + NOP4. Then, the run-time=
 code
>> >> >> patching can change NOP4 to JALR to eable/disable ftrcae from a
>> >> >                                       enable        ftrace
>> >> >
>> >> >> function. This limits the reach of each ftrace entry to +-2KB disp=
lacing
>> >> >> from ftrace_caller.
>> >> >>
>> >> >> Starting from the trampoline, we add a level of indirection for it=
 to
>> >> >> reach ftrace caller target. Now, it loads the target address from a
>> >> >> memory location, then perform the jump. This enable the kernel to =
update
>> >> >> the target atomically.
>> >> >
>> >> > The +-2K limit is for direct calls, right?
>> >> >
>> >> > ...and this I would say breaks DIRECT_CALLS (which should be implem=
ented
>> >> > using call_ops later)?
>> >>
>> >> Thinking a bit more, and re-reading the series.
>> >>
>> >> This series is good work, and it's a big improvement for DYNAMIC_FTRA=
CE,
>> >> but
>> >>
>> >> +int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>> >> +{
>> >> +    unsigned long distance, orig_addr;
>> >> +
>> >> +    orig_addr =3D (unsigned long)&ftrace_caller;
>> >> +    distance =3D addr > orig_addr ? addr - orig_addr : orig_addr - a=
ddr;
>> >> +    if (distance > JALR_RANGE)
>> >> +            return -EINVAL;
>> >> +
>> >> +    return __ftrace_modify_call(rec->ip, addr, false);
>> >> +}
>> >> +
>> >>
>> >> breaks WITH_DIRECT_CALLS. The direct trampoline will *never* be within
>> >> the JALR_RANGE.
>> >
>> >
>> > Yes, it is hardly possible that a direct trampoline will be within the
>> > range.
>> >
>> > Recently I have been thinking some solutions to address the issue. One
>> > solution is replaying AUIPC at function entries. The idea has two side=
s.
>> > First, if we are returning back to the second instruction at trap retu=
rn,
>> > then do sepc -=3D 4 so it executes the up-to-date AUIPC. The other sid=
e is
>> > to fire synchronous IPI that does remote fence.i at right timings to
>> > prevent concurrent executing on a mix of old and new instructions.
>> >
>> > Consider replacing instructions at a function's patchable entry with t=
he
>> > following sequence:
>> >
>> > Initial state:
>> > --------------
>> > 0: AUIPC
>> > 4: JALR
>> >
>> > Step1:
>> > write(0, "J +8")
>> > fence w,w
>> > send sync local+remote fence.i
>> > ------------------------
>> > 0: J +8
>> > 4: JALR
>> >
>> > Step2:
>> > write(4, "JALR'")
>> > fence w,w
>> > send sync local+remote fence.i
>> > ------------------------
>> > 0: J +8
>> > 4: JALR'
>> >
>> > Step3:
>> > write(0, "AUIPC'")
>> > fence w,w
>> > send sync local+remote fence.i (to activate the call)
>> > -----------------------
>> > 0: AUIPC'
>> > 4: JALR'
>> >
>> > The following execution sequences are acceptable:
>> > - AUIPC, JALR
>> > - J +8, (skipping {JALR | JALR'})
>> > - AUIPC', JALR'
>> >
>> > And here are sequences that we want to prevent:
>> > - AUIPC', JALR
>> > - AUIPC, JALR'
>> >
>> > The local core should never execute the forbidden sequence.
>> >
>> > By listing all possible combinations of executing sequence on a remote
>> > core, we can find that the dangerous seqence is impossible to happen:
>> >
>> > let f be the fence.i at step 1, 2, 3. And let numbers be the location =
of
>> > code being executed. Mathematically, here are all combinations at a si=
te
>> > happening on a remote core:
>> >
>> > fff04 -- updated seq
>> > ff0f4 -- impossible, would be ff0f04, updated seq
>> > ff04f -- impossible, would be ff08f, safe seq
>> > f0ff4 -- impossible, would be f0ff04, updated seq
>> > f0f4f -- impossible, would be f0f08f (safe), or f0f0f04 (updated)
>> > f04ff -- impossible, would be f08ff, safe seq
>> > 0fff4 -- impossible, would be 0fff04, updated seq
>> > 0ff4f -- impossible, would be 0ff08f (safe), or 0ff0f04 (updated)
>> > 0f4ff -- impossible, would be 0f08ff (safe), 0f0f08f (safe), 0f0f0f04 =
(updated)
>> > 04fff -- old seq
>> >
>> > After the 1st 'fence.i', remote cores should observe (J +8, JALR) or (=
J +8, JALR')
>> > After the 2nd 'fence.i', remote cores should observe (J +8, JALR') or =
(AUIPC', JALR')
>> > After the 3rd 'fence.i', remote cores should observe (AUIPC', JALR')
>> >
>> > Remote cores should never execute (AUIPC',JALR) or (AUIPC,JALR')
>> >
>> > To correctly implement the solution, the trap return code must match J=
ALR
>> > and adjust sepc only for patchable function entries. This is undocumen=
tly
>> > possible because we use t0 as source and destination registers for JALR
>> > at function entries. Compiler never generates JALR that uses the same
>> > register pattern.
>> >
>> > Another solution is inspired by zcmt, and perhaps we can optimize it if
>> > the hardware does support zcmt. First, we allocate a page and divide it
>> > into two halves. The first half of the page are 255 x 8B destination
>> > addresses. Then, starting from offset 2056, the second half of the page
>> > is composed by a series of 2 x 4 Byte instructions:
>> >
>> > 0:    ftrace_tramp_1
>> > 8:    ftrace_tramp_2
>> > ...
>> > 2040: ftrace_tramp_255
>> > 2048: ftrace_tramp_256 (not used when configured with 255 tramps)
>> > 2056:
>> > ld    t1, -2048(t1)
>> > jr    t1
>> > ld    t1, -2048(t1)
>> > jr    t1
>> > ...
>> > 4088:
>> > ld    t1, -2048(t1)
>> > jr    t1
>> > 4096:
>> >
>> > It is possible to expand to 511 trampolines by adding a page
>> > below, and making a load+jr sequence from +2040 offset.
>> >
>> > When the kernel boots, we direct AUIPCs at patchable entries to the pa=
ge,
>> > and disable the call by setting the second instruction to NOP4. Then, =
we
>> > can effectively enable/disable/modify a call by setting only the
>> > instruction at JALR. It is possible to utilize most of the current pat=
ch
>> > set to achieve atomic patching. A missing part is to allocate and mana=
ge
>> > trampolines for ftrace users.
>>
>> (I will need to digest above in detail!)
>>
>> I don't think it's a good idea to try to handle direct calls w/o
>> call_ops. What I was trying to say is "add the call_ops patch to your
>> series, so that direct calls aren't broken". If direct calls depend on
>> call_ops -- sure, no worries. But don't try to get direct calls W/O
>> call_ops. That's a whole new bag of worms.
>>
>> Some more high-level thoughts: ...all this to workaround where we don't
>> want the call_ops overhead? Is there really a use-case with a platform
>> that doesn't handle the text overhead of call_ops?
>
> Sorry for making any confusions. I have no strong personal preference
> on what we should do. Just want to have a technical discussion on what
> is possible if we want to optimize code size.

Understood! I'm -- as you know -- really eager to have a text patching
mechanism that is not horrible. ;-) I'd rather wait with the text size
optimizations.

TL;DR -- your series is fine from my POV, but it's missing call_ops, so
that it doesn't break direct calls.

I will take your patch series, and Puranjay's call_ops series see how
they play together.

We can discuss it at LPC next week!


Cheers,
Bj=C3=B6rn
