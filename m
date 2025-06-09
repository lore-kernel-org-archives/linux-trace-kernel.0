Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C22C148;
	Mon,  9 Jun 2025 13:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474578; cv=none; b=qUWsGC7NVdBhrJqq1IK3Gtfn3z9GFK59HW4AHNfqFreC+oJVauLk0Vsiwq0XqA2bQUdmmFVhwtVPv85ggq0RpDG4hM6/Mx/n0WfkIUFwSJ0lKuOz3d0Xm+u2Pu9zAmZznFOCLQ1nmIiwNu6arc6GdCFZDIW/kC5w0sXOMXCSq+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474578; c=relaxed/simple;
	bh=4+Ui+usxTxJK18Xq3BV53Smdklq7y5SfpjQZgrYAuoU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ORyjaSBEUtLu1Ty31QAJtov/TtC1ZdS/cE0yv1rc0fE9YHV23pNIwKnKB8YBBCwF1YRJaf+EjrjS1IPMwpr6GG6XydnvnBUUkhH6nceJfT32yObCaQODXIOh6xbCbmY45KdAa3Rm6Kt2YbE/DzkFp+a9LNN9SLXAcs6cOTRiIkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts5evttV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts5evttV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2EDC4CEEB;
	Mon,  9 Jun 2025 13:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749474577;
	bh=4+Ui+usxTxJK18Xq3BV53Smdklq7y5SfpjQZgrYAuoU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ts5evttVzrFEX7uzNIR7Z7nlPqZbIAUOHntxGulKHP/7cWs4nwmQMZlwPYpnaC5+y
	 tgK0D1rghkP87vJopGbpUJ7yBwXiNdWUaq1jKE6FS3cPY2VmPzImWh9VvnS4TzAI3t
	 6JamzwrRopy9LbVU2htJi+k1mmr5KRnhRFsgcslTOVGiS+dqT8l17MD4nlVaXHV/GR
	 dO2zreX0Cr2sgrgls3kgMK+lTpsTYxL3hSv/UbQy33HO0xhVi9Ag5A8ZJn2ElYb2FO
	 c0A/cv25DTlYt8UwTl/KS1INpHB1YE0Ch6LNThUewShpUpGcd2eYSyZ1aaalXadZVH
	 dNI0bg0hH8jAw==
Date: Mon, 9 Jun 2025 22:09:34 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, Stephen
 Rothwell <sfr@canb.auug.org.au>, Masami Hiramatsu <mhiramat@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
Message-Id: <20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
In-Reply-To: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 17:12:10 +0530
Naresh Kamboju <naresh.kamboju@linaro.org> wrote:

> Regressions found on qemu-x86_64 with compat mode (64-bit kernel
> running on 32-bit userspace) while running LTP tracing test suite
> on Linux next-20250605 tag kernel.
> 
> Regressions found on
>  - LTP tracing
> 
> Regression Analysis:
>  - New regression? Yes
>  - Reproducible? Intermittent
> 
> Test regression: qemu-x86_64-compat mode ltp tracing Oops int3 kernel panic
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ## Test log
> ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
> starting test ftrace-stress-test (ftrace_stress_test.sh 90)
> <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
> <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
> 6.15.0-next-20250605 #1 PREEMPT(voluntary)
> <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50

Interesting. This hits a stray int3 for ftrace on _raw_spin_lock.

Here is the compiled code of _raw_spin_lock.

ffffffff825daa00 <_raw_spin_lock>:
ffffffff825daa00:       f3 0f 1e fa             endbr64
ffffffff825daa04:       e8 47 a6 d5 fe          call   ffffffff81335050 <__fentry__>

Since int3 exception happens after decoded int3 (1 byte), the RIP
`_raw_spin_lock+0x05` is not an instruction boundary.

> <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> 0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> 12 e4 fe

And the call is already modified back to a 5-bytes nop when we
dump the code. Thus it may hit the intermediate int3 for transforming
code.

e8 47 a6 d5 fe
 (first step)
cc 47 a6 d5 fe
 (second step)
cc 1f 44 00 00 <- hit?
 (third step)
0f 1f 44 00 00 <- handle int3

It is very unlikely scenario (and I'm not sure qemu can correctly
emulate it.) But if a CPU hits the int3 (cc) on _raw_spin_lock()+0x4
before anoter CPU' runs third step in smp_text_poke_batch_finish(),
and before the CPU runs smp_text_poke_int3_handler(), the CPU' runs
the thrid step and sets text_poke_array_refs 0, 
the smp_text_poke_int3_handler() returns 0 and causes the same
problem. 

<CPU0>					<CPU1>
					Start smp_text_poke_batch_finish().
					Finish second step.
Hit int3 (*)
					Finish third step.
					Run smp_text_poke_sync_each_cpu().(**)
					Clear text_poke_array_refs[cpu0]
Start smp_text_poke_int3_handler()
Failed to get text_poke_array_refs[cpu0]
Oops: int3


But as I said it is very unlikely, because as far as I know;

(*) smp_text_poke_int3_handler() is called directly from exc_int3()
   which is a kind of NMI, so other interrupt should not run.
(**) In the third step, smp_text_poke_batch_finish() sends IPI for
   sync core after removing int3. Thus any int3 exception handling
   should be finished.

Is this bug reproducible easier recently?

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
