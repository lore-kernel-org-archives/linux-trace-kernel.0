Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793669871;
	b=FgphZWy9+6+8m7p6iXxgZtaRKwNyeJtTOBsAH9qVk2BnuXwwhOwSvRO22jKy+5vm55tZ
	 FOOJ1Ek4wTufnnVYctHB2iNwcBxbZis3dkL9J7V6wR0Tddiu7a5X30Q1KV1zvF8GkRK6T
	 PsTki/imaM2s0BTRS4p2UZEwCWqxXJv5DKxo32abzy0x1EyWjE6maR6tUz35GCY1rlu8i
	 X1iHKfeYK008vgOTEpUTSujssw2forkJB0C/b93OHUhwIVV6udsZVZNYUgOCtOkUVfMlW
	 eyoX0d/VhJx/fHYTDhnMplhl3vCcM6GM0dxzNAz0PbSMXmSARd1C8mwtIp4vANtxUTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793669871;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=NkKLoQiT3QLn1o0kL1YKYPKps4dql8DQmXqMzeu4JqA=;
	b=qjnFNXqFvRnBgHVD6z2yWAb6hxHtzOq18T8Gib8X1KUVAfsQPB+ciX5wUHRfyOaez8c8
	 ePNS8tqiXOKUmEVcJZrMYpNcVoZYiHRVgQyijaySzNYuxUgcCFv2YNvLNNDgtfbK0TmUQ
	 qnmU2DdaUUbo99evSoSU0smgklenU/G3m2Ck2o1c6A0ksLuZbJta5ymKBA1Hysi4tbYR4
	 2RIJ2WOp5dcCLjiGs6kGABeHRXMjyAOupEeji7VfDd2ZSiBn9HwGaEVLkacjRQIDBDq3o
	 O28TjZhJjNB7lBPnh+Mtpuxl4Tt69R0SHjVbXD/z3/Mx5qWk/79WtKZ6I4lk2WEitcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=khEmIFfW;
	arc=none smtp.remote-ip=115.124.30.133
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D1606A324;
	Tue,  3 Nov 2026 01:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3A2D1606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=khEmIFfW
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793669867; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=NkKLoQiT3QLn1o0kL1YKYPKps4dql8DQmXqMzeu4JqA=;
	b=khEmIFfW61Vx04EDurerN1Hds3zuwk5P+dNfJ624RCcQ4Xguvzh6gNR71Xwx/uHHR1itaVJ9rkjCqk+q9eunETbbIn51Se7G8/mDIISDgu8AAqDdA03Cro1L90LW1ljzwThY5GyaAO9TlRymR2RyNZljqEw+7fNZ4LHpfQ8Hok0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XE0PTwb_1793669863;
Received: from 30.247.169.117(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XE0PTwb_1793669863 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Nov 2026 09:37:45 +0800
Message-ID: <70e15aaa-44c9-478a-8e61-1dfc19dc50a0@linux.alibaba.com>
Date: Tue, 3 Nov 2026 09:37:43 +0800
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
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
> 
> The reliable unwinder series [1] rewrites this walker and has the correct
> start frame for stack_trace_save() as a side effect, but leaves
> return_address() at level + 3. This patch conflicts with 5/7 of that
> series; if that goes in first, only the return_address.c hunk is needed.
> 
> [1] https://lore.kernel.org/r/20260914092648.51254-1-xueshuai@linux.alibaba.com
Hi Karl,

Now that 7.4-rc1 is out and neither your two patches nor the reliable
unwinder series made this merge window, I'm preparing v7 of the series
for the next one.

Are you OK with folding your patches into the livepatch series rather
than keeping two conflicting walkers in flight?

Thanks.
Shuai



