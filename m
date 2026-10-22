Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792677821;
	b=oZQpNVUCkOB6Zm7u+eriwL7auksvHYY/cVG7wX9MOasOBM0OF3bmAdJvit88RVqskupV
	 uUthMmBryEHPTtEkDhRpviHxi8YU9+BvPjVxJNyVi70C8AC49gbR2ChYq+vtDcs0PAPRE
	 kHkG1onbGYX0TpOsY0ObXGMcChl99EUGCvpCM5XDfvWgt8ElhzF4qrXghXkJrgIRcKjG1
	 ZKsVPqqMH0pWKzstav8lZnRjkZVRK/bG9nuJswdApt7yhVhh59Thi1/8hObkn8/jhtMx7
	 fswKU5g5uOrRsq0tHNOyCp0SW/zLsXcAKxJH1GQNm+CchPNgV9SquaWI6gmPu1gEgDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792677821;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=cgfk+c7OYwibFXLmiMDJNx9MW+vVX9Yu6XpHbgWX6U0=;
	b=kruQjikIDFaOTKGv9dQXSys3crklv3+LX2zl1m7o/Pvo43tRGtHJGRS76/KHzxtWnomF
	 ysqux4azK6IwHdzZkF957+80nsBkCW85D+Etqn/5l8OuhOesh0yozeoz5x0apuk6+zTIX
	 3LimhJVAFrRl4AqINYHPJoB06pVV5DCWiXJ9ilRRBQEp502aVsh3WQp6NoQC8acjGvmsI
	 Vnf1JbVhmRbnvsjG/ccyFvO9XwxjloitCBICjrWTEfFk8dvFsJHPzZwBwKQPwF9KhV3Wz
	 j+20kuIVt9M8XLdlTAhW5MVX12CfCGh0yuQIjdfJEQ1huln8XVhTk4HMhyO4sD2xHyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0XVglUM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B8A1606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 14:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0XVglUM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C0511F000C1;
	Thu, 22 Oct 2026 14:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792677820;
	bh=cgfk+c7OYwibFXLmiMDJNx9MW+vVX9Yu6XpHbgWX6U0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j0XVglUMc9+VbJ4fN7x/YcuE94dqdsI4sqEsJPSUd+VpunYisaJl39WDmqoGbN37a
	 GL8Pj7EERR9IhTZVrdFKWYzw2O12QAvk1z/G+69WCF/7cQsDe6iz4mfTlCpKEYUAu2
	 n3DIK7siX903xbUCNh7k2/yHC3smgyCMb4Qb1oyPst0Uqx/UCvYQdj7OCqm+/kJeMY
	 er3QVPTUMWNFRuMgwTyUeNo1obv8n55PGLNlftScslI/pETevNSiN4oUKXtPEjNS6B
	 eA3fp2zsgafSdho9+JDijxvZ0Y6wlAyxf52Urlnrd1+3s9OctzOLJzKM4FNswR0Gsg
	 zb0TXrekeWQ5w==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: 3791971891 <3791971891@qq.com>
Cc: "linux-trace-kernel" <linux-trace-kernel@vger.kernel.org>, "chenhuacai" <chenhuacai@kernel.org>, "catalin.marinas" <catalin.marinas@arm.com>, "will" <will@kernel.org>, "paul.walmsley" <paul.walmsley@sifive.com>, "palmer" <palmer@dabbelt.com>
Subject: Re: [PATCH v1] rethook: Fix percpu base register corruption across CPU migration in trampoline
Date: Thu, 22 Oct 2026 23:03:37 +0900
Message-ID: <undine-1792677817434077051-0a900721b6323094@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <tencent_ECF9EB2561DF6C83A6A037AB5A4EF02B0107@qq.com>
References: <tencent_ECF9EB2561DF6C83A6A037AB5A4EF02B0107@qq.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Hi 3791971891,

At least, you must use your real name for sending a patch.
Please read Documentation/process/submitting-patches.rst.

On Thu, 22 Oct 2026 16:20:44 +0800, 3791971891 <3791971891@qq.com> wrote:
> The current rethook trampoline implementation across LoongArch, ARM64 and RISC-V
> manually saves and restores architecture-specific percpu base registers (r21 on
> LoongArch, x18 on ARM64, tp on RISC-V) around the call to rethook_trampoline_handler().

What kernel version are you working on? At least arch/arm64/kernel/rethook_trampoline.S
does not exist.

> This pattern is fundamentally unsafe. rethook_trampoline_handler() runs in a
> preemptible context where CPU migration is allowed. If a task migrates from CPU0
> to CPU1 during handler execution, the kernel context switch and exception return
> logic will have already updated the percpu base register to point to the new CPU's
> per-cpu data area. Restoring the stale value saved on the old CPU leaves the
> register pointing to the wrong per-cpu region, triggering:
> 1.  Remote CPU runqueue/RCU state corruption
> 2.  "Scheduling while atomic" warnings
> 3.  Unrecoverable RCU stalls and hard CPU lockups
> 4.  Silent per-cpu counter/lock data corruption

Your email client replaces ASCII whitespace with UTF-8. Please do not do that.

>
>
> The percpu base register is exclusively managed by kernel exception entry/exit and
> context switch paths. It must never be manually saved and restored by instrumented
> trampoline code — the kernel guarantees the correct value is present on return
> from any C function call across preemption events.
>
>
> This patch removes the dangerous and unnecessary save/restore instructions for
> percpu base registers in all three architecture rethook trampoline implementations,
> eliminating the cross-CPU migration race entirely.
>
>
> Fixes: 90a279c6c83a ("rethook: Add core infrastructure for return hook")
> Cc: <stable@vger.kernel.org> # 5.18+
> Signed-off-by: Your Name <your.email@example.com>

Also, this is wrong SOB tag.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
