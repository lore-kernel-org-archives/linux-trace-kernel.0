Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D331E1A17;
	Wed, 30 Oct 2024 08:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730278222; cv=none; b=s3BOOJEmdY7TV0RC8Z3/k7UJIiZ09QnboBHd3tfXuxztTnRf3JbpKecB5M1U7Fj+gts9oRFiW8UG16WwF5TnbZ9Pr6QKUIP8BOJE0VXenwG7M0baP3XsHbAMmgocvxAJyDux8iRwbYy7/rJmlqY0Sp6QafarITB1gUrOhsdOfTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730278222; c=relaxed/simple;
	bh=RcSrn/tbrJx4Rd3dEoRfrRtLPNP+EYx9/XN8N1o4j2w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoqHKptKAoVqaEIczA5uloMwpKWEjQEdJIZLTxcVdjiYSjizd0yru+atos2yU3uGn1y0y9jNpCAnAcumnqIcyexwTA1pCdhsSsRBqALNUQ6v7c5CYvxf+t66OlV+7JM084wozW0nksGymIi+JMg35Dtwczaf3rtf/DaJ1eYL8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0FAF4169E;
	Wed, 30 Oct 2024 01:50:49 -0700 (PDT)
Received: from [10.57.89.111] (unknown [10.57.89.111])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60DC13F66E;
	Wed, 30 Oct 2024 01:50:18 -0700 (PDT)
Message-ID: <42f825a2-ceb6-488a-8c63-fcc879cce096@arm.com>
Date: Wed, 30 Oct 2024 08:50:16 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tracing: Make percpu stack trace buffer invariant to
 PAGE_SIZE
Content-Language: en-GB
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
References: <20241021141832.3668264-1-ryan.roberts@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20241021141832.3668264-1-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/10/2024 15:18, Ryan Roberts wrote:
> Previously the size of "struct ftrace_stacks" depended upon PAGE_SIZE.
> For the common 4K page size, on a 64-bit system, sizeof(struct
> ftrace_stacks) was 32K. But for a 64K page size, sizeof(struct
> ftrace_stacks) was 512K.
> 
> But ftrace stack usage requirements should be invariant to page size. So
> let's redefine FTRACE_KSTACK_ENTRIES so that "struct ftrace_stacks" is
> always sized at 32K for 64-bit and 16K for 32-bit.
> 
> As a side effect, it removes the PAGE_SIZE compile-time constant
> assumption from this code, which is required to reach the goal of
> boot-time page size selection.

Just a polite bump on this... Does anyone have any comments?

Thanks,
Ryan

> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>  kernel/trace/trace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 1c69ca1f1088..d4654943b580 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -2914,7 +2914,7 @@ trace_function(struct trace_array *tr, unsigned long ip, unsigned long
>  /* Allow 4 levels of nesting: normal, softirq, irq, NMI */
>  #define FTRACE_KSTACK_NESTING	4
> 
> -#define FTRACE_KSTACK_ENTRIES	(PAGE_SIZE / FTRACE_KSTACK_NESTING)
> +#define FTRACE_KSTACK_ENTRIES	(SZ_4K / FTRACE_KSTACK_NESTING)
> 
>  struct ftrace_stack {
>  	unsigned long		calls[FTRACE_KSTACK_ENTRIES];
> --
> 2.43.0
> 

