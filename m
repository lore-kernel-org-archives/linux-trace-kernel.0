Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA32AE96;
	Sat, 19 Apr 2025 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745057936; cv=none; b=ooJm2+iwmSBTgN/7xi+TVCxIE4vOjCHVZDmd56Lo9hXfsaNEV9l//6ygqcjhUWeiyTXBb3X5mbo4jaiPB/RTlPoxDUO1ueM636GjAjiJ++kwn5Ry0gruSz6Tiwq+u4RkR9FP6IEQbzHqGPpL+86qg4ZwyPDjP4M1jze5dQBG4Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745057936; c=relaxed/simple;
	bh=jAcmSoS3GtzgVfgKeZM4QEikFmRzlkijiCGw0g5VRhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=u6BgHxkvR5jJmNqAcyiU+exts4Gnt0QpicCXD8IyoPPqgI1u6bxPHpUUbMmFVe5wW7I0PJ7hqN9uVf8GcUmyr/tV0NF9T9pj1iqCSQeve9LtzRTdbLLKFOQ62x3+9lWl8bPbym1lsFvP8T/Jf388Ya5wsuLxCSB8KoJOvUaFEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d2txBxSt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d2txBxSt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7226BC4CEE7;
	Sat, 19 Apr 2025 10:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745057935;
	bh=jAcmSoS3GtzgVfgKeZM4QEikFmRzlkijiCGw0g5VRhk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=d2txBxSt3JpSGV8a+0y4n+83rtV/oUrj63dD9V9AZDsKWdEy3brZ4Qkk1tWWCOmIl
	 B5noMhBIn1LPeXZfVooW6XrkjUOsENGTQdO2kbgPsmXGBJQsJZYjkuP+N2jwf54gk0
	 7/arCRwEuMvjwSik8iOslOGofJuq0EJVFewBEIi3ysk2KHhpBCKDYGEvC/GnQX3iKR
	 KMxi1SktQn7nNY1e4lFh/5r1WT65S4QuhoLcomU6xnkGWRF7CsJUBpz4cfDa9LnB47
	 0yh+TP0xgGyYwDNg13ix8IceO7TxJazZQtXG6MjCad/RNseAy7TUIf9+xl6F9t5+DV
	 yIwXnD3b6UQsA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Alexandre
 Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, Guo Ren
 <guoren@kernel.org>
Cc: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra
 <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH fixes] riscv: uprobes: Add missing fence.i after
 building the XOL buffer
In-Reply-To: <b864fc90-1297-4e1d-8487-61049e23e405@sifive.com>
References: <20250417074952.1315641-1-bjorn@kernel.org>
 <b864fc90-1297-4e1d-8487-61049e23e405@sifive.com>
Date: Sat, 19 Apr 2025 12:18:51 +0200
Message-ID: <87ikn0tpx0.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Samuel Holland <samuel.holland@sifive.com> writes:

> Hi Bj=C3=B6rn,
>
> On 2025-04-17 2:49 AM, Bj=C3=B6rn T=C3=B6pel wrote:
>> From: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>>=20
>> The XOL (execute out-of-line) buffer is used to single-step the
>> replaced instruction(s) for uprobes. The RISC-V port was missing a
>> proper fence.i (i$ flushing) after constructing the XOL buffer, which
>> can result in incorrect execution of stale/broken instructions.
>>=20
>> This was found running the BPF selftests "test_progs:
>> uprobe_autoattach, attach_probe" on the Spacemit K1/X60, where the
>> uprobes tests randomly blew up.
>>=20
>> Fixes: 74784081aac8 ("riscv: Add uprobes supported")
>> Signed-off-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
>> ---
>>  arch/riscv/kernel/probes/uprobes.c | 9 +--------
>>  1 file changed, 1 insertion(+), 8 deletions(-)
>>=20
>> diff --git a/arch/riscv/kernel/probes/uprobes.c b/arch/riscv/kernel/prob=
es/uprobes.c
>> index 4b3dc8beaf77..4faef92dd771 100644
>> --- a/arch/riscv/kernel/probes/uprobes.c
>> +++ b/arch/riscv/kernel/probes/uprobes.c
>> @@ -176,13 +176,6 @@ void arch_uprobe_copy_ixol(struct page *page, unsig=
ned long vaddr,
>>  		*(uprobe_opcode_t *)dst =3D __BUG_INSN_32;
>>  	}
>>=20=20
>> +	flush_icache_range((unsigned long)dst, (unsigned long)dst + len);
>
> This works because flush_icache_range currently ignores the range, but
> semantically is not quite right, because of the line just above the conte=
xt that
> increments dst. If the range was respected, this would only flush the ebr=
eak,
> not the preceding single-stepped instruction.

Indeed! That was sloppy! I'll spin a v2!

Thank you!
Bj=C3=B6rn
