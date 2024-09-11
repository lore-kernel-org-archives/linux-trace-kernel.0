Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D801A3054;
	Wed, 11 Sep 2024 14:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726065454; cv=none; b=fCnBH1f+6BIF7lOfGgn/4fAU9SNSIvNdI72ykL6dXu1EfIgZrrHWoC4czrNA0dlEFD8bBcBB5KQuibnGT227Maw8h4LwauEWCME+AqNTDcBOVZxlGQXHu7RJEh9MYexK0LW8QMdLfmJrlviTJpZMpaw4gkYVn8hTcvte1RYS9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726065454; c=relaxed/simple;
	bh=Yl+JX76hpRrzj5ZfxqmhMQe96P1O6Eq+el3AmOLT584=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hFstMMHlN/9aKDC0QKmFgbg4QKKiExMpxT3e0e7FJ1AyL9w3a0a4kdYXGVImrTQEDheEgVUEX2Wd0FF5J5HXzYRN0DKueJFMNMNhQLu6wkP5hS9DdsII55PPvLc/HdpLQnrvj8+JY2JHiidVx0Guo/HD0p/5lMz50BmSYkzsGPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zd4GAiyU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zd4GAiyU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3A2C4CEC0;
	Wed, 11 Sep 2024 14:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726065453;
	bh=Yl+JX76hpRrzj5ZfxqmhMQe96P1O6Eq+el3AmOLT584=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Zd4GAiyUDj5TFQBVWNHQHHHDyP/DTdGN/yrSfsB52qfSWgXUAhOtQfgEqMmklPaP+
	 moz2hv3cDfuzshyMSsy0spS1KrfBjP1q0gWs0UuH4hVbmOjxrfsmw41yZvoLweHLho
	 IpKt4gd69JmjIp0rfvJLVhNdJTqkWudgjkI8bCOVfdtpikR7nZuapNIkBqL9Pw7nDK
	 E92Fu6AKvYnR0awR2Kq0i6oYy8EKbsjQLQ96d4qvtYzAxIvG1aDbeie7puO1JLyly1
	 dvYl6Q0T/X6ehPzdALoq9rMMCxe4cjDu5lE05aU38uyVgtwqPaRKe8mFwK/djgCimb
	 FYIn1+VvFA8zg==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andybnac@gmail.com>
Cc: alexghiti@rivosinc.com, andy.chiu@sifive.com, aou@eecs.berkeley.edu,
 justinstitt@google.com, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-trace-kernel@vger.kernel.org,
 llvm@lists.linux.dev, mark.rutland@arm.com, mhiramat@kernel.org,
 morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
 palmer@dabbelt.com, palmer@rivosinc.com, paul.walmsley@sifive.com,
 puranjay@kernel.org, rostedt@goodmis.org, zong.li@sifive.com, Andy Chiu
 <andybnac@gmail.com>, yongxuan.wang@sifive.com
Subject: Re: [PATCH v2 3/6] riscv: ftrace: prepare ftrace for atomic code
 patching
In-Reply-To: <ZuFteQ3t8K4h2-kJ@Andys-MacBook-Air.local>
References: <87sev78dnz.fsf@all.your.base.are.belong.to.us>
 <ZuFteQ3t8K4h2-kJ@Andys-MacBook-Air.local>
Date: Wed, 11 Sep 2024 16:37:29 +0200
Message-ID: <87v7z2dzo6.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy Chiu <andybnac@gmail.com> writes:

> On Wed, Aug 14, 2024 at 02:57:52PM +0200, Bj=C3=B6rn T=C3=B6pel wrote:
>> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>>=20
>> > Andy Chiu <andy.chiu@sifive.com> writes:
>> >
>> >> We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
>> >> instruction fetch can break down to 4 byte at a time, it is impossible
>> >> to update two instructions without a race. In order to mitigate it, we
>> >> initialize the patchable entry to AUIPC + NOP4. Then, the run-time co=
de
>> >> patching can change NOP4 to JALR to eable/disable ftrcae from a
>> >                                       enable        ftrace
>> >
>> >> function. This limits the reach of each ftrace entry to +-2KB displac=
ing
>> >> from ftrace_caller.
>> >>
>> >> Starting from the trampoline, we add a level of indirection for it to
>> >> reach ftrace caller target. Now, it loads the target address from a
>> >> memory location, then perform the jump. This enable the kernel to upd=
ate
>> >> the target atomically.
>> >
>> > The +-2K limit is for direct calls, right?
>> >
>> > ...and this I would say breaks DIRECT_CALLS (which should be implement=
ed
>> > using call_ops later)?
>>=20
>> Thinking a bit more, and re-reading the series.
>>=20
>> This series is good work, and it's a big improvement for DYNAMIC_FTRACE,
>> but
>>=20
>> +int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
>> +{
>> +	unsigned long distance, orig_addr;
>> +
>> +	orig_addr =3D (unsigned long)&ftrace_caller;
>> +	distance =3D addr > orig_addr ? addr - orig_addr : orig_addr - addr;
>> +	if (distance > JALR_RANGE)
>> +		return -EINVAL;
>> +
>> +	return __ftrace_modify_call(rec->ip, addr, false);
>> +}
>> +
>>=20
>> breaks WITH_DIRECT_CALLS. The direct trampoline will *never* be within
>> the JALR_RANGE.
>
>
> Yes, it is hardly possible that a direct trampoline will be within the
> range.
>
> Recently I have been thinking some solutions to address the issue. One
> solution is replaying AUIPC at function entries. The idea has two sides.
> First, if we are returning back to the second instruction at trap return,
> then do sepc -=3D 4 so it executes the up-to-date AUIPC. The other side is
> to fire synchronous IPI that does remote fence.i at right timings to
> prevent concurrent executing on a mix of old and new instructions.
>=20=20
> Consider replacing instructions at a function's patchable entry with the
> following sequence:
>
> Initial state:
> --------------
> 0: AUIPC
> 4: JALR
>
> Step1:
> write(0, "J +8")
> fence w,w
> send sync local+remote fence.i
> ------------------------
> 0: J +8
> 4: JALR
>
> Step2:
> write(4, "JALR'")
> fence w,w
> send sync local+remote fence.i
> ------------------------
> 0: J +8
> 4: JALR'
>
> Step3:
> write(0, "AUIPC'")
> fence w,w
> send sync local+remote fence.i (to activate the call)
> -----------------------
> 0: AUIPC'
> 4: JALR'
>
> The following execution sequences are acceptable:
> - AUIPC, JALR
> - J +8, (skipping {JALR | JALR'})
> - AUIPC', JALR'
>
> And here are sequences that we want to prevent:
> - AUIPC', JALR
> - AUIPC, JALR'
>
> The local core should never execute the forbidden sequence.
>
> By listing all possible combinations of executing sequence on a remote
> core, we can find that the dangerous seqence is impossible to happen:
>
> let f be the fence.i at step 1, 2, 3. And let numbers be the location of
> code being executed. Mathematically, here are all combinations at a site
> happening on a remote core:
>
> fff04 -- updated seq
> ff0f4 -- impossible, would be ff0f04, updated seq
> ff04f -- impossible, would be ff08f, safe seq
> f0ff4 -- impossible, would be f0ff04, updated seq
> f0f4f -- impossible, would be f0f08f (safe), or f0f0f04 (updated)
> f04ff -- impossible, would be f08ff, safe seq
> 0fff4 -- impossible, would be 0fff04, updated seq
> 0ff4f -- impossible, would be 0ff08f (safe), or 0ff0f04 (updated)
> 0f4ff -- impossible, would be 0f08ff (safe), 0f0f08f (safe), 0f0f0f04 (up=
dated)
> 04fff -- old seq
>
> After the 1st 'fence.i', remote cores should observe (J +8, JALR) or (J +=
8, JALR')
> After the 2nd 'fence.i', remote cores should observe (J +8, JALR') or (AU=
IPC', JALR')
> After the 3rd 'fence.i', remote cores should observe (AUIPC', JALR')
>
> Remote cores should never execute (AUIPC',JALR) or (AUIPC,JALR')
>
> To correctly implement the solution, the trap return code must match JALR
> and adjust sepc only for patchable function entries. This is undocumently
> possible because we use t0 as source and destination registers for JALR
> at function entries. Compiler never generates JALR that uses the same
> register pattern.
>
> Another solution is inspired by zcmt, and perhaps we can optimize it if
> the hardware does support zcmt. First, we allocate a page and divide it
> into two halves. The first half of the page are 255 x 8B destination
> addresses. Then, starting from offset 2056, the second half of the page
> is composed by a series of 2 x 4 Byte instructions:
>
> 0:	ftrace_tramp_1
> 8:	ftrace_tramp_2
> ...
> 2040:	ftrace_tramp_255
> 2048:	ftrace_tramp_256 (not used when configured with 255 tramps)
> 2056:
> ld	t1, -2048(t1)
> jr	t1
> ld	t1, -2048(t1)
> jr	t1
> ...
> 4088:
> ld	t1, -2048(t1)
> jr	t1
> 4096:
>
> It is possible to expand to 511 trampolines by adding a page
> below, and making a load+jr sequence from +2040 offset.
>
> When the kernel boots, we direct AUIPCs at patchable entries to the page,
> and disable the call by setting the second instruction to NOP4. Then, we
> can effectively enable/disable/modify a call by setting only the
> instruction at JALR. It is possible to utilize most of the current patch
> set to achieve atomic patching. A missing part is to allocate and manage
> trampolines for ftrace users.

(I will need to digest above in detail!)

I don't think it's a good idea to try to handle direct calls w/o
call_ops. What I was trying to say is "add the call_ops patch to your
series, so that direct calls aren't broken". If direct calls depend on
call_ops -- sure, no worries. But don't try to get direct calls W/O
call_ops. That's a whole new bag of worms.

Some more high-level thoughts: ...all this to workaround where we don't
want the call_ops overhead? Is there really a use-case with a platform
that doesn't handle the text overhead of call_ops?

Maybe I'm missing context here... but I'd say, let's follow what arm64
did (but obviously w/o the BL direct call optimization, and always jump
to a trampoline -- since that's not possible with RISC-V branch length),
and just do the call_ops way.

Then, as a second step, and if there are platforms that care, think
about a variant w/o call_ops.

Or what I wrote in the first section:

1. Keep this patch set
2. ...but add call_ops to it, and require call_ops for direct calls.

Just my $.02.


Bj=C3=B6rn
