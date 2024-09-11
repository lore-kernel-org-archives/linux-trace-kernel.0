Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA27185B4A;
	Wed, 11 Sep 2024 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726052328; cv=none; b=XbBKNHw4pnuiKYJfverV6rE4FQ2qRLpgc/kQnvxa9TVk256Dm/9mWwuiw9nQw6atuGbKJs+K8RfpZ/cSLe5hKZZZKFqOPtzOFaokMmpuFG8z9ji3JweF3N8lPl1YwC23iK77crnbYiya/OjgoFIEMFhYsa4rzHJeLh5oEnKJWco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726052328; c=relaxed/simple;
	bh=Pw98yjqyvgV0j0EI3KPYWSSdOG7a3DjJHciP2zL4naI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KjRNFL5be4auCtY1jxcMaT7DLEq3XdD3672bzZlm1uz5Jwae0jXxFc5C+lMbSzv7QxLOkZNpODQ8/SmEcVB+PJJq1MYobiYZALblS606FTAD1P6R9rcuzG+AhBEPQwVw1mr0Sp2OT/pFMj09bJ4HbS+kZFxKFL/03R7HfSQp+L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/vzH32w; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/vzH32w"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e1ce7e84so3403619b3a.1;
        Wed, 11 Sep 2024 03:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726052326; x=1726657126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7Wq0ojhg4OlKZWObqNyEMqFiHsGaFxKZnwTSD+aecE=;
        b=G/vzH32wl0y46zndg9qNbdlW+JzPrsHrvjHu5OQrgzs9OnA0Qk0/jUVmYkEvQDBtAh
         bFTu+CafoXsCqGuwWTh3up0Z1ODWFUNVxkaaIRYjzFuHwB8vD3fApkf2bX4GgPWR66l5
         XGUzv+anQBH6Neqg3pBmErFY4hJToGoc9KyuGa8uFY3RySUONYbcn2DiMBtFAMUSde+f
         pPPV1Y+c5l0peS7fUiiywVLlxSIq/OdLMamABf4W12SNANA4DT8Ho9B9eAjG++fUSBZe
         UxjtSFe0Y65jEK7Eg9rDHqOz+JxCOrUQM46ZjVkej/+H5j0c4z4nrMvp/SUAC0NIDlDY
         vVrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726052326; x=1726657126;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7Wq0ojhg4OlKZWObqNyEMqFiHsGaFxKZnwTSD+aecE=;
        b=e7H0/HqLQJ/N22Z+tYv8SgasUAX2lHdqH7kanBCNdlZmyATqmK+jwrx5VdllG9PIRI
         lrh01NgQJToxMRo77Wv59L4nMgclOQf6wCH/z0dYzHCsDMyt4hp/3Sl4UBJQ8WTMfx1a
         LAedtPd7KD0osRJmbnC/Cyd6BA/f1UIyoKIUTLUfSOLhVx7iVAnjlAODV8nbJ6VQkGJt
         NFYWdJCH68CxfqRHgGoN+TXGbYrtQumJ/wt4DdJ47u/NkL46Iq06u3HS7AtW6DpsveNy
         s3l8IOvL4l1jARG4lfBy3bHlE7Hjl2y2pl9A6jldzfB+gMtthQqlsI2tVI/HoxmCNmjw
         /ePA==
X-Forwarded-Encrypted: i=1; AJvYcCUV6ObIAuRw7cNPWYUvIEF4JtJzdmBu3DzjJyTODqFRJSKTdi+Do1HVsXDGC46a9v4iVjpGbtKrszC4Y+09v/MVkLTv@vger.kernel.org, AJvYcCVz8STzYUbv1J59SRLygykQKqLCiATjmVa5ALaA6LFJCyLLMVB74wmJcjMJyhJgYPl/wGs7gqKYZ2B05QU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx45i5GspFPjHq5D09GZskab+eElR5nvhW00OSrxccrGhn4/KKm
	ZC+btI4Ks2ACKozBmP7viteCnCX9KaIQoRMXC8UCV1c8vimolPaj
X-Google-Smtp-Source: AGHT+IFXRIkDYXeweCuIJfGLn2HYm5191miDB4YjHLUhLcLcNRniPgRSA5iz617KUqpt/gEh00OviQ==
X-Received: by 2002:a05:6a00:181e:b0:717:9154:b5d6 with SMTP id d2e1a72fcca58-718d5ee032emr20084562b3a.22.1726052326133;
        Wed, 11 Sep 2024 03:58:46 -0700 (PDT)
Received: from localhost.localdomain (1-171-31-75.dynamic-ip.hinet.net. [1.171.31.75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8242b3d13sm7158307a12.52.2024.09.11.03.58.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Sep 2024 03:58:45 -0700 (PDT)
From: Andy Chiu <andybnac@gmail.com>
To: bjorn@kernel.org
Cc: alexghiti@rivosinc.com,
	andy.chiu@sifive.com,
	aou@eecs.berkeley.edu,
	justinstitt@google.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	mark.rutland@arm.com,
	mhiramat@kernel.org,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	palmer@dabbelt.com,
	palmer@rivosinc.com,
	paul.walmsley@sifive.com,
	puranjay@kernel.org,
	rostedt@goodmis.org,
	zong.li@sifive.com,
	Andy Chiu <andybnac@gmail.com>,
	yongxuan.wang@sifive.com
Subject: Re: [PATCH v2 3/6] riscv: ftrace: prepare ftrace for atomic code patching
Date: Wed, 11 Sep 2024 18:57:17 +0800
Message-Id: <ZuFteQ3t8K4h2-kJ@Andys-MacBook-Air.local>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <87sev78dnz.fsf@all.your.base.are.belong.to.us>
References: <87sev78dnz.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, Aug 14, 2024 at 02:57:52PM +0200, Björn Töpel wrote:
> Björn Töpel <bjorn@kernel.org> writes:
> 
> > Andy Chiu <andy.chiu@sifive.com> writes:
> >
> >> We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
> >> instruction fetch can break down to 4 byte at a time, it is impossible
> >> to update two instructions without a race. In order to mitigate it, we
> >> initialize the patchable entry to AUIPC + NOP4. Then, the run-time code
> >> patching can change NOP4 to JALR to eable/disable ftrcae from a
> >                                       enable        ftrace
> >
> >> function. This limits the reach of each ftrace entry to +-2KB displacing
> >> from ftrace_caller.
> >>
> >> Starting from the trampoline, we add a level of indirection for it to
> >> reach ftrace caller target. Now, it loads the target address from a
> >> memory location, then perform the jump. This enable the kernel to update
> >> the target atomically.
> >
> > The +-2K limit is for direct calls, right?
> >
> > ...and this I would say breaks DIRECT_CALLS (which should be implemented
> > using call_ops later)?
> 
> Thinking a bit more, and re-reading the series.
> 
> This series is good work, and it's a big improvement for DYNAMIC_FTRACE,
> but
> 
> +int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
> +{
> +	unsigned long distance, orig_addr;
> +
> +	orig_addr = (unsigned long)&ftrace_caller;
> +	distance = addr > orig_addr ? addr - orig_addr : orig_addr - addr;
> +	if (distance > JALR_RANGE)
> +		return -EINVAL;
> +
> +	return __ftrace_modify_call(rec->ip, addr, false);
> +}
> +
> 
> breaks WITH_DIRECT_CALLS. The direct trampoline will *never* be within
> the JALR_RANGE.


Yes, it is hardly possible that a direct trampoline will be within the
range.

Recently I have been thinking some solutions to address the issue. One
solution is replaying AUIPC at function entries. The idea has two sides.
First, if we are returning back to the second instruction at trap return,
then do sepc -= 4 so it executes the up-to-date AUIPC. The other side is
to fire synchronous IPI that does remote fence.i at right timings to
prevent concurrent executing on a mix of old and new instructions.
 
Consider replacing instructions at a function's patchable entry with the
following sequence:

Initial state:
--------------
0: AUIPC
4: JALR

Step1:
write(0, "J +8")
fence w,w
send sync local+remote fence.i
------------------------
0: J +8
4: JALR

Step2:
write(4, "JALR'")
fence w,w
send sync local+remote fence.i
------------------------
0: J +8
4: JALR'

Step3:
write(0, "AUIPC'")
fence w,w
send sync local+remote fence.i (to activate the call)
-----------------------
0: AUIPC'
4: JALR'

The following execution sequences are acceptable:
- AUIPC, JALR
- J +8, (skipping {JALR | JALR'})
- AUIPC', JALR'

And here are sequences that we want to prevent:
- AUIPC', JALR
- AUIPC, JALR'

The local core should never execute the forbidden sequence.

By listing all possible combinations of executing sequence on a remote
core, we can find that the dangerous seqence is impossible to happen:

let f be the fence.i at step 1, 2, 3. And let numbers be the location of
code being executed. Mathematically, here are all combinations at a site
happening on a remote core:

fff04 -- updated seq
ff0f4 -- impossible, would be ff0f04, updated seq
ff04f -- impossible, would be ff08f, safe seq
f0ff4 -- impossible, would be f0ff04, updated seq
f0f4f -- impossible, would be f0f08f (safe), or f0f0f04 (updated)
f04ff -- impossible, would be f08ff, safe seq
0fff4 -- impossible, would be 0fff04, updated seq
0ff4f -- impossible, would be 0ff08f (safe), or 0ff0f04 (updated)
0f4ff -- impossible, would be 0f08ff (safe), 0f0f08f (safe), 0f0f0f04 (updated)
04fff -- old seq

After the 1st 'fence.i', remote cores should observe (J +8, JALR) or (J +8, JALR')
After the 2nd 'fence.i', remote cores should observe (J +8, JALR') or (AUIPC', JALR')
After the 3rd 'fence.i', remote cores should observe (AUIPC', JALR')

Remote cores should never execute (AUIPC',JALR) or (AUIPC,JALR')

To correctly implement the solution, the trap return code must match JALR
and adjust sepc only for patchable function entries. This is undocumently
possible because we use t0 as source and destination registers for JALR
at function entries. Compiler never generates JALR that uses the same
register pattern.

Another solution is inspired by zcmt, and perhaps we can optimize it if
the hardware does support zcmt. First, we allocate a page and divide it
into two halves. The first half of the page are 255 x 8B destination
addresses. Then, starting from offset 2056, the second half of the page
is composed by a series of 2 x 4 Byte instructions:

0:	ftrace_tramp_1
8:	ftrace_tramp_2
...
2040:	ftrace_tramp_255
2048:	ftrace_tramp_256 (not used when configured with 255 tramps)
2056:
ld	t1, -2048(t1)
jr	t1
ld	t1, -2048(t1)
jr	t1
...
4088:
ld	t1, -2048(t1)
jr	t1
4096:

It is possible to expand to 511 trampolines by adding a page
below, and making a load+jr sequence from +2040 offset.

When the kernel boots, we direct AUIPCs at patchable entries to the page,
and disable the call by setting the second instruction to NOP4. Then, we
can effectively enable/disable/modify a call by setting only the
instruction at JALR. It is possible to utilize most of the current patch
set to achieve atomic patching. A missing part is to allocate and manage
trampolines for ftrace users.

Thanks,
Andy
