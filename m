Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1434142651;
	Wed, 14 Aug 2024 12:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640277; cv=none; b=N5MILkjdErhtZ9CksMxTi6CM4PocvYYZh1zi7oWdp0MHfI5Ds68oWXn4Li8AtiE+bjlyABvRAyjTK8h+ZDODnoncBu1qlx0x0UzATxxYb6sHB15v4xzaGhUxefosPuUdfE9HL0pK/igor2RPYoZAisetQkhZsBAgYkViIVTUZjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640277; c=relaxed/simple;
	bh=62rmftprAKZAo0HKLAGpaiq0jqQ0eGkDk+lNEURWyY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GJC2MMsRLIhWDH/0391NnB7WUEXqmiZOpoz4+QM6XRUs3JvmyPAk/XrWUwThfpi5VcDcS7EPkWDJQztKFyRq4agROBRXnlUQPaJ1JHTra9QddX9JOnY9VMlmpyTGC+5y4bTXCcubn5jGGB8myKZEkjUW4oCNaGec0kimbNEDLik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZxuK9t1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZxuK9t1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E4EC4AF09;
	Wed, 14 Aug 2024 12:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723640276;
	bh=62rmftprAKZAo0HKLAGpaiq0jqQ0eGkDk+lNEURWyY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=DZxuK9t1AiQBhXl71gUtYTmcXow0xAl9+Rtwq2PwcSVrMolUPtYBeEoJv8pW5Kwbp
	 uB/5OqxAUlVK38MMgNwZBIv1CS1l03zP4UQBxaXc00xejgvL3fLz/ZdGuHdLwl1z32
	 zH4UdzD7lFCkUJU6+xUPXZik7DoXWyisqLSHF/2jhkmqqhhUyQ6TXEH+KFb6xZ2OMM
	 gxsnB1/JxsmZZX1tqmY+csHgi0PCKiiDDylJ7r7sAFbSpYa7cscLQli7dvO5QsdLrK
	 /jtrLd9jUgUw/5K5UWkgtCHEw7AGcH3ua1vKHMd/RedQKBENpeuNN4Vdnl8XJqYhXy
	 T+KP/xwhfzr3Q==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Andy Chiu <andy.chiu@sifive.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>, Zong Li
 <zong.li@sifive.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers
 <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, Justin Stitt
 <justinstitt@google.com>, Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 llvm@lists.linux.dev, Andy Chiu <andy.chiu@sifive.com>
Subject: Re: [PATCH v2 3/6] riscv: ftrace: prepare ftrace for atomic code
 patching
In-Reply-To: <87wmkk8toq.fsf@all.your.base.are.belong.to.us>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
 <20240628-dev-andyc-dyn-ftrace-v4-v2-3-1e5f4cb1f049@sifive.com>
 <87wmkk8toq.fsf@all.your.base.are.belong.to.us>
Date: Wed, 14 Aug 2024 14:57:52 +0200
Message-ID: <87sev78dnz.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:

> Andy Chiu <andy.chiu@sifive.com> writes:
>
>> We use an AUIPC+JALR pair to jump into a ftrace trampoline. Since
>> instruction fetch can break down to 4 byte at a time, it is impossible
>> to update two instructions without a race. In order to mitigate it, we
>> initialize the patchable entry to AUIPC + NOP4. Then, the run-time code
>> patching can change NOP4 to JALR to eable/disable ftrcae from a
>                                       enable        ftrace
>
>> function. This limits the reach of each ftrace entry to +-2KB displacing
>> from ftrace_caller.
>>
>> Starting from the trampoline, we add a level of indirection for it to
>> reach ftrace caller target. Now, it loads the target address from a
>> memory location, then perform the jump. This enable the kernel to update
>> the target atomically.
>
> The +-2K limit is for direct calls, right?
>
> ...and this I would say breaks DIRECT_CALLS (which should be implemented
> using call_ops later)?

Thinking a bit more, and re-reading the series.

This series is good work, and it's a big improvement for DYNAMIC_FTRACE,
but

+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long distance, orig_addr;
+
+	orig_addr =3D (unsigned long)&ftrace_caller;
+	distance =3D addr > orig_addr ? addr - orig_addr : orig_addr - addr;
+	if (distance > JALR_RANGE)
+		return -EINVAL;
+
+	return __ftrace_modify_call(rec->ip, addr, false);
+}
+

breaks WITH_DIRECT_CALLS. The direct trampoline will *never* be within
the JALR_RANGE.

Unless we're happy with a break (I'm not) -- I really think Puranjay's
CALL_OPS patch needs to be baked in in the series!


Bj=C3=B6rn
