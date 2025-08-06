Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACAE728A417;
	Wed,  6 Aug 2025 10:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754475880; cv=none; b=Fs2E7yOOKqNO6w8FTDwnOrMjse1S00bpJdO1ZDdHgvXcEdlOxlcmZoQQp+vTQyo7F9H5HOYe3Aq3/uluIXOfzzRZLeBOkN59H4LIa0IpUJyoDOBEvR/xSUoqqgKPBtFcgjR+S0f0x8ibe7LFDh19KP8ElbGe0LsgS9n/seyaVKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754475880; c=relaxed/simple;
	bh=5yGYo6ZdZt+LHxya/chgqlmuAM6976MZ+YA5qh6OG4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHITF3v7xCHu4rUzKN1tWOHG7MfTOZGfr8rX3Z9NDlYWfmIVOV/c3F0vWfFnU+sdPQfXW6GJG6cygRIEvWb4G/Lk8Ms82SZrC6nZGZ8jRX7m6y9WAfrghBEediTA2ZyuEcc3GsebJ5/NqHkZXCXhJF0WjkD8MujL6ZwV7VW4pr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 82E011E8D;
	Wed,  6 Aug 2025 03:24:29 -0700 (PDT)
Received: from [192.168.1.127] (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B41793F738;
	Wed,  6 Aug 2025 03:24:34 -0700 (PDT)
Message-ID: <c4f1b8d4-774f-42c1-a828-42c79756503d@arm.com>
Date: Wed, 6 Aug 2025 11:24:33 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] tracing: Have syscall trace events show "0x" for
 values greater than 10
To: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Namhyung Kim <namhyung@kernel.org>,
 Takaya Saeki <takayas@google.com>, Tom Zanussi <zanussi@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ian Rogers <irogers@google.com>,
 aahringo@redhat.com
References: <20250805192646.328291790@kernel.org>
 <20250805193234.915257520@kernel.org>
Content-Language: en-US
From: Douglas Raillard <douglas.raillard@arm.com>
In-Reply-To: <20250805193234.915257520@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05-08-2025 20:26, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Currently the syscall trace events show each value as hexadecimal, but
> without adding "0x" it can be confusing:
> 
>     sys_write(fd: 4, buf: 0x55c4a1fa9270, count: 44)
> 
> Looks like the above write wrote 44 bytes, when in reality it wrote 68
> bytes.
> 
> Add a "0x" for all values greater or equal to 10 to remove the ambiguity.
> For values less than 10, leave off the "0x" as that just adds noise to the
> output.

I'm on the fence for the value-dependent format. This looks like
it could easily make life harder for quick&dirty scripts, but then both
awk's strtonum() and Python's int(x, base=16) seem to handle
the presence/absence of the 0x prefix so maybe it's a non-issue.

OTH, a hand-crafted regex designed after a small set of input may start
to randomly fail if one field unexpectedly goes beyond 10 ...

Just using explicit hex may be the best here, as the actual proper fix
(type-level display hints) is harder. It could probably be implemented
using btf_decl_tag() and __builtin_btf_type_id() to retrieve the BTF info.

> 
> Also change the iterator to check if "i" is nonzero and print the ", "
> delimiter at the start, then adding the logic to the trace_seq_printf() at
> the end.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>   kernel/trace/trace_syscalls.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> index 3a0b65f89130..0f932b22f9ec 100644
> --- a/kernel/trace/trace_syscalls.c
> +++ b/kernel/trace/trace_syscalls.c
> @@ -153,14 +153,20 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
>   		if (trace_seq_has_overflowed(s))
>   			goto end;
>   
> +		if (i)
> +			trace_seq_puts(s, ", ");
> +
>   		/* parameter types */
>   		if (tr && tr->trace_flags & TRACE_ITER_VERBOSE)
>   			trace_seq_printf(s, "%s ", entry->types[i]);
>   
>   		/* parameter values */
> -		trace_seq_printf(s, "%s: %lx%s", entry->args[i],
> -				 trace->args[i],
> -				 i == entry->nb_args - 1 ? "" : ", ");
> +		if (trace->args[i] < 10)
> +			trace_seq_printf(s, "%s: %lu", entry->args[i],
> +					 trace->args[i]);
> +		else
> +			trace_seq_printf(s, "%s: 0x%lx", entry->args[i],
> +					 trace->args[i]);
>   	}
>   
>   	trace_seq_putc(s, ')');

-- 
Douglas
