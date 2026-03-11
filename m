Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6ED3BAD85;
	Wed, 11 Mar 2026 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773219808; cv=none; b=eQFnDRvtS7RGYtV/QmDKcGV9xIh59mURVbx22+ipFRCK/R0L9dkvQS32XIZVgQWOzmf7sXN+VWR+Rxn26qxsBZikz1nEHbfn5hV6yWlrvWppsXSzHhCYY4Cy3r0Kr8ZHa3qfukY76JZN29iVvvy5QXkWLUHNqRdyZCx2DdE/RMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773219808; c=relaxed/simple;
	bh=+RKyKdTuHwRKQyTIDmzrXH46TV8cXn+0KYBzxfKPSb8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=KimcNp0FHfdqqXRKhj00P64ssGIMKR/71KWpbKYr7xjiclr451C41fqBc6ZhQjXzPnzWEJq+GGf7ap3+uXRGB/sUIubZ90PigXk4TKAX45dZ86qzNcu+q82gGmnmNsRIgB+/LpCLcSgmWfIjNXtfrMNuPNbrmGy9aOmYfxB6j+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGXQKqmk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGXQKqmk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FE6C4CEF7;
	Wed, 11 Mar 2026 09:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773219808;
	bh=+RKyKdTuHwRKQyTIDmzrXH46TV8cXn+0KYBzxfKPSb8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DGXQKqmkaxAA7WwCzJxCe0KxNeNIMp3Og8bBfQwNDX2UYMjXXFJHkmjxAvt6MKnV5
	 ntTRZzqx0Qc5Y2ekCEAFm1ZXEauXOtBoieGTk8d8gfpFmZFAj1ych4nAUkfiI5v8EI
	 6nW6FvxMSzaISot/kMf97jSuDgkZiAqUEGjo1H74LAIedl9yT8EwkH8coDx6HYL8zi
	 gdNSqfjX4yU7PVYlzwnU7dtwL63n+SrM6hKWq/C4nnohJaQT+4gDK9hpimV7A55BFI
	 R3USMRyyWrymo91BrKqQY+0+EL3CITfhHXXu1EOticmFLQXNppdjaZ3lGpTf6WwU+H
	 nlhOXnL9EiGkA==
Date: Wed, 11 Mar 2026 18:03:25 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Brian Geffon <bgeffon@google.com>, John
 Stultz <jstultz@google.com>, Ian Rogers <irogers@google.com>, Suleiman
 Souhlal <suleiman@google.com>
Subject: Re: [PATCH v2 1/3] tracing: Have futex syscall trace event show
 specific user data
Message-Id: <20260311180325.488f724d97204d1a3c66f071@kernel.org>
In-Reply-To: <20260310201036.542627924@kernel.org>
References: <20260310200954.285663884@kernel.org>
	<20260310201036.542627924@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 16:09:55 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> +#ifdef CONFIG_FTRACE_SYSCALLS
> +static const char * __futex_cmds[] =
> +{
> +	"FUTEX_WAIT", "FUTEX_WAKE", "FUTEX_FD", "FUTEX_REQUEUE",
> +	"FUTEX_CMP_REQUEUE", "FUTEX_WAKE_OP", "FUTEX_LOCK_PI",
> +	"FUTEX_UNLOCK_PI", "FUTEX_TRYLOCK_PI", "FUTEX_WAIT_BITSET",
> +	"FUTEX_WAKE_BITSET", "FUTEX_WAIT_REQUEUE_PI", "FUTEX_CMP_REQUEUE_PI",
> +	"FUTEX_LOCK_PI2",
> +};
> +
[...]
> @@ -437,6 +464,69 @@ sys_enter_openat_print_fmt(struct syscall_metadata *entry, char *buf, int len)
>  	return pos;
>  }
>  
> +static int __init
> +sys_enter_futex_print_fmt(struct syscall_metadata *entry, char *buf, int len)
> +{
> +	int pos = 0;
> +
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"\"uaddr: 0x%%lx (0x%%lx) cmd=%%s%%s%%s");
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"  val: 0x%%x timeout/val2: 0x%%llx");
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			" uaddr2: 0x%%lx val3: 0x%%x\", ");
> +
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			" REC->uaddr,");
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			" REC->__value,");
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"  __print_symbolic(REC->op & 0x%x, ", FUTEX_CMD_MASK);
> +
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_WAIT\"}, ", FUTEX_WAIT);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_WAKE\"}, ", FUTEX_WAKE);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_FD\"}, ", FUTEX_FD);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_REQUEUE\"}, ", FUTEX_REQUEUE);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_CMP_REQUEUE\"}, ", FUTEX_CMP_REQUEUE);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_WAKE_OP\"}, ", FUTEX_WAKE_OP);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_LOCK_PI\"}, ", FUTEX_LOCK_PI);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_UNLOCK_PI\"}, ", FUTEX_UNLOCK_PI);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_TRYLOCK_PI\"}, ", FUTEX_TRYLOCK_PI);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_WAIT_BITSET\"}, ", FUTEX_WAIT_BITSET);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_WAKE_BITSET\"}, ", FUTEX_WAKE_BITSET);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_WAIT_REQUEUE_PI\"}, ", FUTEX_WAIT_REQUEUE_PI);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_CMP_REQUEUE_PI\"}, ", FUTEX_CMP_REQUEUE_PI);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			"{%d, \"FUTEX_LOCK_PI2\"}),", FUTEX_LOCK_PI2);

Hmm can we share __futex_cmds[] with kernel/futex/syscalls.c?
Then these could be

for (i = 0; i <= FUTEX_LOCK_PI2; i++)
	pos += snprintf(buf + pos, LEN_OR_ZERO,
			"{%d, \"%s\"}%s", i, __futex_cmds[i],
			i == FUTEX_LOCK_PI2 ? ")," : ", ");


> +
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			" (REC->op & %d) ? \"|FUTEX_PRIVATE_FLAG\" : \"\",",
> +			FUTEX_PRIVATE_FLAG);
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			" (REC->op & %d) ? \"|FUTEX_CLOCK_REALTIME\" : \"\",",
> +			FUTEX_CLOCK_REALTIME);
> +
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			" REC->val, REC->utime,");
> +
> +	pos += snprintf(buf + pos, LEN_OR_ZERO,
> +			" REC->uaddr, REC->val3");
> +	return pos;
> +}
> +
>  static int __init
>  __set_enter_print_fmt(struct syscall_metadata *entry, char *buf, int len)
>  {
[...]
> @@ -689,6 +799,48 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
>  	return 0;
>  }
>  
> +static int
> +syscall_get_futex(unsigned long *args, char **buffer, int *size, int buf_size)
> +{
> +	struct syscall_user_buffer *sbuf;
> +	const char __user *ptr;
> +	char *buf;
> +
> +	/* buf_size of zero means user doesn't want user space read */
> +	if (!buf_size)
> +		return -1;
> +
> +	/* If the syscall_buffer is NULL, tracing is being shutdown */
> +	sbuf = READ_ONCE(syscall_buffer);
> +	if (!sbuf)
> +		return -1;
> +
> +	ptr = (char __user *)args[0];
> +
> +	*buffer = trace_user_fault_read(&sbuf->buf, ptr, 4, NULL, NULL);
> +	if (!*buffer)
> +		return -1;
> +
> +	/* Add room for the value */
> +	*size += 4;
> +
> +	buf = *buffer;

As kernel test bot says, this does nothing. (*buffer is already assigned)

> +
> +	return 0;
> +}

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
