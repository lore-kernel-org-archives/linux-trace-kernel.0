Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C521EA7C2;
	Thu,  6 Feb 2025 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738848420; cv=none; b=XxJ5S9GpYQUuSlO1ovrPsR+SVLU78Frwqic230B6sxo8j5bBCfcZInYq8mgHKzEDNK7GEdrRtLA0WmFNhCs/ev2CNfiymsQcPw3WwTqLK9YTUMln6AYtjoX2DsMlO8vgZxNbb2EtURi2u5YJ/mMx22Cxkkx+GHl3W5BYjLRyo/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738848420; c=relaxed/simple;
	bh=Xa2e6zZUE5Ypv/4gGdRlghgenoolHBoV4uJXpLNA0Ho=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g+vkSwPa4JciwKawbT5fTTrw0ecjwOx6x0vv+Ak5TgyP/OG4SUsdSnShs2ysDaJRkeSWFw+PeAk2Qp5254G6c8pGwWtsbnfpuQ3aT4LsB8YkYnMJIuEgVvJWRsebfC2ymKPMNl2gGkFPSNCSXJiz1EDzBl/YgvsYzm4r9QOvWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=DHBwf1PV; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="DHBwf1PV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=cK6k51s+cBjVEgWYzrHKvOcp/x8Wau2Xj95c58xdXn8=;
	b=DHBwf1PVLFgOtk7NSpBkgTPdRR9av3iy3CIn6Zj+IHZZ1A7DiWX9CjPUo3w5Lm
	i+gbJE8DqqvFsEXuByrb/Im+47pp4acYiEfSBSpeNL6hUjatpeP0TVtRB5BsqjLm
	wZ03TWW9+b4DENRy9fo6LP9F5e2Pnwqjn+JXLhrn1gg08=
Received: from [192.168.31.211] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgDHDzFSuKRnmF9+Bg--.16667S2;
	Thu, 06 Feb 2025 21:25:39 +0800 (CST)
Message-ID: <b4ef10d0-a1eb-4d9c-8ddc-d7815a2bb607@163.com>
Date: Thu, 6 Feb 2025 21:25:37 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ftrace: x86: Fix a compile error about
 get_kernel_nofault()
To: Peter Zijlstra <peterz@infradead.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Gabriel de Perthuis <g2p.code@gmail.com>,
 Sami Tolvanen <samitolvanen@google.com>, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <173881156244.211648.1242168038709680511.stgit@devnote2>
 <20250206081225.GI7145@noisy.programming.kicks-ass.net>
 <20250206205449.5f83a585945ae6eb0cc15483@kernel.org>
 <20250206121328.GN7145@noisy.programming.kicks-ass.net>
 <20250206123307.GO7145@noisy.programming.kicks-ass.net>
From: Haiyue Wang <haiyuewa@163.com>
In-Reply-To: <20250206123307.GO7145@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgDHDzFSuKRnmF9+Bg--.16667S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGry7Xry8GrW8Cr13CrW3KFg_yoW5Wr45pF
	y3Crn3GFs5XFyYkrZrur109r15Zw1kCr1Sg347Gr95ZF1qvFyUJr1I9w1vyasFvasaga4r
	tFW7ZFn09w1DZ3JanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UIZXrUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiShPra2ekp8XqkgAAsA



On 2025/2/6 20:33, Peter Zijlstra wrote:
> On Thu, Feb 06, 2025 at 01:13:28PM +0100, Peter Zijlstra wrote:
> 
>> No, it just cleans up this utter trainwreck. I also noticed this is a
>> second (new) copy of this garbage. Clearly I didn't yell loud enough
>> last time and people didn't think to vomit when doing the copy/paste :/
>>
>> Function will look something like:
>>
>> unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
>> {
>> 	if (is_endbr(fentry_ip - ENDBR_INSN_SIZE))
>> 		fentry_op -= ENDBR_INSN_SIZE;
>> 	return fentry_ip;
>> }
>>
>> Let me finish local build test before I push out.
> 
> Bah, still waiting for a LLVM build, but patch should be here:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/ibt
> 
> I was supposed to merge this last cycle, but then akpm shat all over
> arch/x86/kernel/alternative.c and we had to clean that up :/
> 
> Notably, this patch, not sure it applies out of order.
> 
> ---
> 
> Subject: x86/ibt: Clean up is_endbr()
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Mon Nov 27 09:58:06 CET 2023
> 
> Pretty much every caller of is_endbr() actually wants to test something at an
> address and ends up doing get_kernel_nofault(). Fold the lot into a more
> convenient helper.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Acked-by: Alexei Starovoitov <ast@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>   arch/x86/events/core.c         |    2 +-
>   arch/x86/include/asm/ftrace.h  |   17 +++--------------
>   arch/x86/include/asm/ibt.h     |    5 +++--
>   arch/x86/kernel/alternative.c  |   20 ++++++++++++++------
>   arch/x86/kernel/kprobes/core.c |   11 +----------
>   arch/x86/net/bpf_jit_comp.c    |    4 ++--
>   kernel/trace/bpf_trace.c       |   20 +++-----------------
>   7 files changed, 27 insertions(+), 52 deletions(-)
> 
> --- a/arch/x86/events/core.c
> +++ b/arch/x86/events/core.c
> @@ -2857,7 +2857,7 @@ static bool is_uprobe_at_func_entry(stru
>   		return true;
>   
>   	/* endbr64 (64-bit only) */
> -	if (user_64bit_mode(regs) && is_endbr(*(u32 *)auprobe->insn))
> +	if (user_64bit_mode(regs) && is_endbr((u32 *)auprobe->insn))
>   		return true;
>   
>   	return false;
> --- a/arch/x86/include/asm/ftrace.h
> +++ b/arch/x86/include/asm/ftrace.h
> @@ -2,6 +2,7 @@
>   #ifndef _ASM_X86_FTRACE_H
>   #define _ASM_X86_FTRACE_H
>   
> +#include "asm/ibt.h"

Then 
https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/tree/arch/x86/include/asm/ftrace.h?h=x86/ibt#n17

# include <asm/ibt.h> --> This line can be removed ?

>   #include <asm/ptrace.h>
>   
>   #ifdef CONFIG_FUNCTION_TRACER
> @@ -36,21 +37,9 @@ static inline unsigned long ftrace_call_
>   
>   static inline unsigned long arch_ftrace_get_symaddr(unsigned long fentry_ip)
>   {

