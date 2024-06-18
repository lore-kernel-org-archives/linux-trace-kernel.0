Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F72158DB6;
	Tue, 18 Jun 2024 09:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718704541; cv=none; b=Pj4nDRMv/iiCFuXEkn47h4KQSYaz+md0aVEvB2a6sjxTDDJ7KwBP2xGoej9+3EWuntIRsBr9QTKVdFgGfyHsF0z9cUZFZTGH4ZMUmKLle8DmjOOMhw1bxPjLITdfcQjKyq1TTTDBapgP7RlVY//8jjVxiNZDJGiXy6YOpo+iMoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718704541; c=relaxed/simple;
	bh=pinT4VVwLK4vA9SKS6sH2RKynQuz7BGsnlo0I4JNjTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbp87f23FQj97WnXi6L2inPQXOmQ2t6wOA/WQgnTQ5QXLL2dusx4kajAA9yA7q3GfdqqcIYjoHdLTgpuHUTpEAFp57vBiZ4g7LCrdSN8pQaiT3bwlyLpO/3WkaeG/+Sjncx2E36s6snyclAvgBzbtG1KBlTZZiYz/lcfqjG91qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BB7FBE0006;
	Tue, 18 Jun 2024 09:55:32 +0000 (UTC)
Message-ID: <cb71a5e9-aafe-48af-9f16-baae407d467b@ghiti.fr>
Date: Tue, 18 Jun 2024 11:55:32 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/8] riscv: stacktrace: convert arch_stack_walk() to
 noinstr
Content-Language: en-US
To: Andy Chiu <andy.chiu@sifive.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alexghiti@rivosinc.com>,
 Zong Li <zong.li@sifive.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Puranjay Mohan <puranjay@kernel.org>
Cc: Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <20240613-dev-andyc-dyn-ftrace-v4-v1-0-1a538e12c01e@sifive.com>
 <20240613-dev-andyc-dyn-ftrace-v4-v1-1-1a538e12c01e@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240613-dev-andyc-dyn-ftrace-v4-v1-1-1a538e12c01e@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Andy,

On 13/06/2024 09:11, Andy Chiu wrote:
> arch_stack_walk() is called intensively in function_graph when the
> kernel is compiled with CONFIG_TRACE_IRQFLAGS. As a result, the kernel
> logs a lot of arch_stack_walk and its sub-functions into the ftrace
> buffer. However, these functions should not appear on the trace log
> because they are part of the ftrace itself. This patch references what
> arm64 does for the smae function. So it further prevent the re-enter
> kprobe issue, which is also possible on riscv.
>
> Related-to: commit 0fbcd8abf337 ("arm64: Prohibit instrumentation on arch_stack_walk()")
> Fixes: 680341382da5 ("riscv: add CALLER_ADDRx support")
> Signed-off-by: Andy Chiu <andy.chiu@sifive.com>
> ---
>   arch/riscv/kernel/stacktrace.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index 528ec7cc9a62..0d3f00eb0bae 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -156,7 +156,7 @@ unsigned long __get_wchan(struct task_struct *task)
>   	return pc;
>   }
>   
> -noinline void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
> +noinline noinstr void arch_stack_walk(stack_trace_consume_fn consume_entry, void *cookie,
>   		     struct task_struct *task, struct pt_regs *regs)
>   {
>   	walk_stackframe(task, regs, consume_entry, cookie);
>

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

I'll try to make this go into -fixes, this is in my fixes branch at least.

Thanks,

Alex

