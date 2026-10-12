Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9748181334;
	Mon, 12 Oct 2026 08:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792504; cv=none; b=fPt3Vep8UsVz7eR+KAzjYXrF8BvIE4grYLItL0qYHpSYDvFZro6cPBj5QS7QO1wFNdK6jVnoA+wAj5QtNPT9kmNJM+3sO05j8XhcW5WHbGKJY1NwVY55vOSmyJLlvRuhPovBrTz7XmaTKh2+x3N/G4idoBiHFjJztU27lLAOojg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792504; c=relaxed/simple;
	bh=VbuUVwRa3q6ixYB746kpqiYxA2CyHawQzNHWHac3nxM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T88cYGKA9t+NvSUE6giqsGFY4qO0yvMugr8YCDdZojYo+yg/54rCRT6E/YwKaX1U2mnG1J1Li3LJw3RJ962rpfhI5N3YLmV4tiJFUH0tmBN+I7Tn93Ly4AYsEA4vIrziZiENZi2D7A5Ia+ame+0ythtEHsaXYKs6UseCv3Rp3yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=GyxBNE8K; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="GyxBNE8K"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791792499; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=D6ifv6a4KKoIiKYJezBRkAhE1P/vLkjB6GL3KBtF0js=;
	b=GyxBNE8KhdanRPo3VkDWe7EFz/VNszpZhjCzradaIH8Q6Vddf1lROiuLQV+DAMSt2/SRXfe+jQ2zhTfA5RLb6SoNifykA1QEqie2YpfpnBoMyfCab0BCMgifVmH9DRVOTFBnl0riFqlwizkTMMLzHdyyDUUojf/m0/gQGU83zLo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XCd0ksa_1791792496;
Received: from 30.246.160.148(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XCd0ksa_1791792496 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Oct 2026 16:08:17 +0800
Message-ID: <882701c0-9016-4fe3-93d0-40853f34f19d@linux.alibaba.com>
Date: Mon, 12 Oct 2026 16:08:16 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] riscv: stacktrace: do not report the walker's own
 frame from arch_stack_walk()
To: Karl Mehltretter <kmehltretter@gmail.com>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>, Changbin Du <changbin.du@intel.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>,
 Rae Moar <raemoar63@gmail.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
References: <20261010132712.46931-1-kmehltretter@gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20261010132712.46931-1-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/26 9:27 PM, Karl Mehltretter wrote:
> stack_trace_save() uses skipnr + 1 because arch_stack_walk() is expected
> to first report the return into stack_trace_save(). With FRAME_POINTER,
> the RISC-V arch_stack_walk() calls walk_stackframe(), which starts from
> its own frame and first reports the return into arch_stack_walk().
> stack_trace_save() therefore starts one frame too early. For example,
> page_owner records begin at __set_page_owner() instead of the allocation
> site.
> 
> Move the walker into an always-inlined helper and call it directly from
> arch_stack_walk(). Keep walk_stackframe() as a wrapper for its existing
> callers.
> 
> return_address() skips level + 3 entries, while the arm64 implementation
> skips level + 2. After removing the extra frame, use level + 2 so
> ftrace_return_address() and CALLER_ADDR results do not shift by one caller.
> 
> Fixes: 6a00ef449370 ("riscv: eliminate unreliable __builtin_frame_address(1)")
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---

Hi, Karl,

> Tested with the KUnit suite from patch 2 on QEMU's virt machine, clang 22
> (LLVM=1), on af32da41b032:
> 
>    mainline                        stack_trace_save 0/3, return_address 2/2
>    stacktrace.c change alone       stack_trace_save 3/3, return_address 0/2
>    this patch                      stack_trace_save 3/3, return_address 2/2
> 
> A BeagleV Ahead (TH1520) booted with this patch passes all five cases.
> The stack_trace_save() result on mainline (0/3) was also reproduced with
> GCC 15.2 and QEMU 10.2.1.
> 
> Without CONFIG_FRAME_POINTER the walker scans the stack for anything that
> looks like a text address and its start frame is not exact before or
> after this patch. What return_address() returns there is unchanged: the
> walk loses one leading entry and the skip count goes down by one.


Hi Karl,

As promised in the other thread, here are test results for this series.

Short version: the fix is correct, the KUnit suite reproduces the bug
precisely, and the whole series passes here.

Testing
-------

Your numbers were collected with clang 22, plus the mainline
reproduction with GCC 15.2 you noted in the commit message, so I
re-ran the full matrix with gcc: riscv64 cross-gcc 16.2.0 for the
first three configurations below and a native gcc 14.3 for the last
one, all under QEMU (qemu-system-riscv64 11.1.1, -machine virt,
-cpu rv64) on top of your base af32da41b032.

A. base + 2/2 only (tests, no fix): pass:2 fail:3, i.e. exactly the
    "stack_trace_save 0/3, return_address 2/2" you reported for
    mainline.  The failures show the off-by-one shift nicely; with
    skip = 0 the first recorded symbol is the walker itself:

        # riscv_stacktrace_skip_zero: skip=0 first=stack_trace_save count=11
        #     symbol == "stack_trace_save"
        #     expected[skip] == "riscv_stacktrace_leaf"

    The two return_address() cases still pass on unpatched mainline,
    which is consistent with the analysis: the current "level + 3" is
    calibrated for the buggy frame layout, so ftrace_return_address()
    keeps working while stack_trace_save() - and everything built on
    top of it - records one bogus leading entry.

B. base + 1/2 + 2/2: pass:5 fail:0.

C. My v6 reliable stack unwinding series [1] + your 2/2, with the
    level constant in return_address.c adjusted to the same
    unconditional "level + 2" as in your 1/2: pass:5 fail:0, with
    per-case results identical to B (skip=0/1/2 first =
    leaf/middle/outer, count = 10/9/8).

D. Cross-toolchain check: I rebuilt the C tree with a native riscv64
    gcc 14.3 inside an Anolis OS 23.4 riscv64 guest - no cross
    toolchain involved at any step - using the same Kconfig options,
    and booted the resulting Image under the same QEMU: pass:5 fail:0
    again, identical output.  The result does not depend on one
    particular compiler's frame layout.

Please feel free to add

     Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
     Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks.
Shuai
