Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AA3AFB1C;
	Mon, 12 Oct 2026 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791797929; cv=none; b=g9dry4NycBJL4m0q3oc194xxoVhwisTyufKUeUXVTr73VMxYmcQiAKP7bRpShE+mfhfQq7VGA1+D1c8YrEuqkVzA3zax6A/EIJ0wSaa92IwIVGKk7V4x3SdRuNlwTEEvuQwa1Nxa5MPs4ijtWsJv/rsvZ4EKxjz7fW8dSssBXgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791797929; c=relaxed/simple;
	bh=DbuTBuVkKNFouLNj68uLFa8EEELulV8fyV/Bbs15ZIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UO6GnZY6WvntcgUzu+qNUwJKEz/HUtLcG+aHVJ86f9zlwMp0Np83J4tMxITDWrqhTTChDW8YcdGDTgiyk/PqqHlgoxYrWxeJuonw5glAVj+ys9Kt8ITMwXwRawAI7CKIrpHXbbffn38HFWYJmblhzqqkrhsuL5RGQ85NH5ee+Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H/N4EUbo; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H/N4EUbo"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791797924; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Pa5vpAlcxeupL5DUUG37a0rrinaOhdw9S6NlqCfn1cY=;
	b=H/N4EUbomPTH/Zfogrq8Q9X6baKsl77Vyok1gsximT4LUn9mljrntDgthiUsu/qnCuGdYQOfJfkcyQjNZwP/V1/UiUxPJ7yB/RTbuUvrGK1pR3LRjoRgA9WE0ZYjqd74cskaciSBNyDGXBdK3hqKz2aRQHrU8zkyJps4jDsZ4gU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0XCeALDl_1791797921;
Received: from 30.246.160.148(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0XCeALDl_1791797921 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 12 Oct 2026 17:38:42 +0800
Message-ID: <dd5c9bd0-df80-4524-aedf-49c5b94fdd12@linux.alibaba.com>
Date: Mon, 12 Oct 2026 17:38:41 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] riscv: Add KUnit test for stack trace start frames
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
 <20261010132712.46931-2-kmehltretter@gmail.com>
From: Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20261010132712.46931-2-kmehltretter@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/26 9:27 PM, Karl Mehltretter wrote:
> stack_trace_save() and return_address() depend on the first frame reported
> by arch_stack_walk(), but no test checks their frame numbering.
> 
> Add a test that calls both through a chain of three noinline functions
> and compares the symbol of the result with the function expected for
> each skip count or level.
> 
> Require FRAME_POINTER because the stack-scanning walker cannot provide an
> exact start frame.
> 
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
> ---
>   arch/riscv/kernel/tests/Kconfig.debug     |  12 ++
>   arch/riscv/kernel/tests/Makefile          |   1 +
>   arch/riscv/kernel/tests/stacktrace_test.c | 142 ++++++++++++++++++++++
>   3 files changed, 155 insertions(+)
> 
> diff --git a/arch/riscv/kernel/tests/Kconfig.debug b/arch/riscv/kernel/tests/Kconfig.debug
> index 40f8dafffa0a..eb79df5b2c5a 100644
> --- a/arch/riscv/kernel/tests/Kconfig.debug
> +++ b/arch/riscv/kernel/tests/Kconfig.debug
> @@ -42,6 +42,18 @@ config RISCV_KPROBES_KUNIT
>   
>            If unsure, say N.
>   
> +config RISCV_STACKTRACE_KUNIT_TEST
> +	bool "KUnit tests for RISC-V stack trace start frames"
> +	depends on KUNIT && STACKTRACE && FRAME_POINTER && KALLSYMS

Hi, Karl

One small nit: the new RISCV_STACKTRACE_KUNIT_TEST entry does
not follow the KUNIT_ALL_TESTS pattern of the two existing entries
right next to it (RISCV_KPROBES_KUNIT, RISCV_MODULE_LINKING_KUNIT):

     config RISCV_STACKTRACE_KUNIT_TEST
             bool "KUnit tests for RISC-V stack trace start frames" if !KUNIT_ALL_TESTS
             default KUNIT_ALL_TESTS

Without "default KUNIT_ALL_TESTS" the suite is never enabled by
kunit.all_tests, and without the "if !KUNIT_ALL_TESTS" prompt guard
it shows up as a redundant prompt when KUNIT_ALL_TESTS is already
set.  This is not a blocker in any way, just a nice tweak for a
potential v2.

Please feel free to add

     Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>

to both patches, and additionally on 1/2

     Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>

Thanks!
Shuai
