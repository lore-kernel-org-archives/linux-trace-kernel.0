Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05F2198A16;
	Tue, 13 Aug 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723546835; cv=none; b=Hm16uEx0BHSgwxHwpGtncwF65oF8ZBJV+7LcvrPQ6Wxykz3AZ17hNnRCj2e2PiWFbkTeTgtk0UovzY5kYEkLSYRRgm9ZNzFpwV32a07wJer5HGF8kLPCisq3o55rTu9pjrCDWkMyCUeDZCvsia+mtzonWw+C4QVf1IqQTY+eHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723546835; c=relaxed/simple;
	bh=B808EudKWrHxZfYg+a3UwZuglHevVcZNFkJtnW2kji4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HRRy814m5joWF3KyNIQNV/dU3n0v5zaqRuWmVj1wLWp3SUKxtY7HqyOubzMIbUXmA8K7VXvRGOIL7xi/yhc7WkVlTAZFoXj9Gmt4BBSDXnQ37L28J+iGCzHGRW//reqDwA6MY6mBpzu39O3XZL1FztNiZKVAhkBSx2HMTeNIWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tb+0FW+t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tb+0FW+t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D780BC4AF10;
	Tue, 13 Aug 2024 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723546835;
	bh=B808EudKWrHxZfYg+a3UwZuglHevVcZNFkJtnW2kji4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=tb+0FW+tZf+oPwB7sp1BP0xAvdBX0bocm7umTDDTc2QtHC4wg9unm2yzSoVx1Yjz3
	 0HpVeUz5XPlAjZsWbPNaCl3+gl3RbfWrkMJNRUi9oTMafXERRKlJtfdB0KgiKAXo86
	 FUOMRocHoHBhCewj4woksJz6ZX5CIfnW6DFsox5GUUxtV5f2utGyxad7d8JCYWL00n
	 uNGQl6ygAxKPZvZry8w9OqdCnJnj8iB0qUACpviY1MNS45N8En7CRBfTFaisBEBZxy
	 Q4HJT8usc4u+xLYAQIE7ApsQKjFAJSPDM9CsOlxct0GUW81MdbE2PF8G7/pkicL30R
	 V2pQ3jPuIJOhQ==
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
 llvm@lists.linux.dev, Evgenii Shatokhin <e.shatokhin@yadro.com>, Andy Chiu
 <andy.chiu@sifive.com>
Subject: Re: [PATCH v2 0/6] riscv: ftrace: atmoic patching and preempt
 improvements
In-Reply-To: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
References: <20240628-dev-andyc-dyn-ftrace-v4-v2-0-1e5f4cb1f049@sifive.com>
Date: Tue, 13 Aug 2024 13:00:31 +0200
Message-ID: <87cymcadrk.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andy,

Way over due; I'm back from my vacation, I've finally started to look at
the series. Thanks for working on it.

Andy Chiu <andy.chiu@sifive.com> writes:

> This series makes atmoic code patching possible in riscv ftrace. A
                    atomic

> direct benefit of this is that we can get rid of stop_machine() when
> patching function entries. This also makes it possible to run ftrace
> with full kernel preemption. Before this series, the kernel initializes
> patchable function entries to NOP4 + NOP4. To start tracing, it updates
> entries to AUIPC + JALR while holding other cores in stop_machine.
> stop_machine() is required because it is impossible to update 2
> instructions, and be seen atomically. And preemption must have to be
> prevented, as kernel preemption allows process to be scheduled out while
> executing on one of these instruction pairs.
>
> This series addresses the problem by initializing the first NOP4 to
> AUIPC. So, atmoic patching is possible because the kernel only has to
             atomic

> update one instruction. As long as the instruction is naturally aligned,
> then it is expected to be updated atomically.

This came up on the last weekly patchwork call; Given that RISC-V does
not yet (WIP!) has a formal specfication expressing cmodx behaviour, the
assumptions done in this series (what you're describing here pretty
much) should be properly documented in Documentation/riscv the next
revision.

From the earlier public discussions [1], this is "option A".

> However, the address range of the ftrace trampoline is limited to +-2K
> from ftrace_caller after appplying this series. This issue is expected
> to be solved by Puranjay's CALL_OPS, where it adds 8B naturally align
> data in front of pacthable functions and can  use it to direct execution
                   patchable

Is it really usable to enable with the limit 2K range? Makes me wonder
if we should bake in Puranjay CALL_OPS work directly in this series.
Thoughts?

> out to any custom trampolines.
>
> The series is composed by three parts. The first part cleans up the
> existing issues when the kernel is compiled with clang.The second part
> modifies the ftrace code patching mechanism (2-4) as mentioned above.
> Then prepare ftrace to be able to run with kernel preemption (5,6)
>
> This series is tested after applying the following ftrace/patching in
> the fixes branch:
>
> - commit 57a369b6f2ee ("riscv: patch: Flush the icache right after
>                         patching to avoid illegal insns")
> - commit a2bd3a5b4b63 ("riscv: stacktrace: convert arch_stack_walk() to
>                         noinstr")
>
> Changes in v2:
> - Drop patch 1 as it is merged through fixes.
> - Drop patch 2, which converts kernel_text_address into notrace. As
>   users can prevent tracing it by configuring the tracefs.
> - Use a more generic way in kconfig to align functions.
> - Link to v1: https://lore.kernel.org/r/20240613-dev-andyc-dyn-ftrace-v4-=
v1-0-1a538e12c01e@sifive.com

More input in subsequent patches.


Cheers,
Bj=C3=B6rn

[1] https://lore.kernel.org/linux-riscv/87zfv0onre.fsf@all.your.base.are.be=
long.to.us/
