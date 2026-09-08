Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8609A274FDF;
	Tue,  8 Sep 2026 01:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830512; cv=none; b=GjZ7jUEvcT9F/pOuozhI14wkA3FNHDB0kX/kBFUKwtDIudocqj/Ni0BVNb2CW6v2hzYFgm63iQiu3CwBL2kU96h4IrCxlqnBYoDrN14knLm6GrtDKTaSUJm8n7XPvNz4UvToxYigUuCKz7LO9wVJVJNKEO/ka5SkusZ093Eq4S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830512; c=relaxed/simple;
	bh=YAiSjk+6REMd5kt4d2wa73VQ6KYny//uDrfQknPLt2A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dM94SBQfYc9Hs3Fp0XOnJbQcwCEELXijDl1uUlFTWeWYmb1RTd885Lyg/VwDGN+wRsC+KZUlPB1ZEolwXZ+wkE0C9Hd38ZQ26KTVf82sCyGhNX9GiVn3Pth7IADVlt2EDJF/1VH5ZpR6tcp/q/NyPzTW1G7dIxxl6ZdJI/YuMXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g4fo4nx5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g4fo4nx5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A17A1F00A3A;
	Tue,  8 Sep 2026 01:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788830506;
	bh=eN25iy9GQSstUWyrX7CCqIq95xPSPYavzJyfENoDndo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=g4fo4nx5OGHIpCHJb0VTtSorxEXV84VagW2Qw3SnvLt3pZQi/phBToCj7yBGU9pji
	 aTL+QIPU3D+U8QszP//lv0EJL+c1QjmQQLd+FtAMEucoE5gfghJmhU38PjfPpReVOL
	 C5gJcDOsyJqmySqL0v2fy9GxNubWMg8f+ZNYOJ8dEZ96BT7AdK3eeTB9fZghoHbW3R
	 jWaRig7Eazyl4hFcglY0HAoU4G1Gi3bKfi3fW93utMMM21nvGSrAPzEsK3+y/6rGfI
	 jlqm05Yc6ql26BL4qF4qaG4F9Ya3F/hLTit+16DrpczDNiCZJ17K1Ny76zSPQucfiJ
	 XySJFXEVUYFCg==
Date: Tue, 8 Sep 2026 10:21:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Pengfei Li <ljdlns1987@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 kernel test robot <lkp@intel.com>, Bo Zhang <zhangbo56@xiaomi.com>, Pengfei
 Li <lipengfei28@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v6 1/3] trace: add lock-free stackmap for stack
 trace deduplication
Message-Id: <20260908102140.2ed161f1c851d94e1365520d@kernel.org>
In-Reply-To: <20260903132409.270195-2-lipengfei28@xiaomi.com>
References: <20260903132409.270195-1-lipengfei28@xiaomi.com>
	<20260903132409.270195-2-lipengfei28@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 21:24:07 +0800
Pengfei Li <ljdlns1987@gmail.com> wrote:

> Add a lock-free hash map (ftrace_stackmap) that deduplicates kernel
> stack traces for the ftrace ring buffer. Instead of storing full
> stack traces (80-160 bytes each) in the ring buffer for every event,
> ftrace can store a 4-byte stack_id when the stackmap option is enabled.

Thanks, I have some comments below.

[...]
> 
> Kernel command line parameter:
> - ftrace_stackmap.bits=N: set map capacity (2^N unique stacks,
>   range 10-18, default 14)

Ah, this kernel cmdline parameter is also be a separated patch,
because this is not fundamentary needed.

> 
> Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>

It is OK to use an official address for SoB, but to make sure this
address work, please at least Cc to this address.

> ---
>  kernel/trace/Kconfig          |  22 +
>  kernel/trace/Makefile         |   1 +
>  kernel/trace/trace_stackmap.c | 871 ++++++++++++++++++++++++++++++++++
>  kernel/trace/trace_stackmap.h |  55 +++
>  4 files changed, 949 insertions(+)
>  create mode 100644 kernel/trace/trace_stackmap.c
>  create mode 100644 kernel/trace/trace_stackmap.h

[...]

> +/* --- Stats --- */
> +
> +static int stackmap_stat_show(struct seq_file *m, void *v)
> +{
> +	struct ftrace_stackmap *smap = m->private;
> +	u64 successes = 0, drops = 0;
> +	u32 entries;
> +	int cpu;
> +
> +	if (!smap) {
> +		seq_puts(m, "stackmap not initialized\n");
> +		return 0;
> +	}
> +

You also need down_read(&smap->reader_sem) here for serializing.

> +	entries = atomic_read(&smap->next_elt);
> +	for_each_possible_cpu(cpu) {
> +		successes += local_read(per_cpu_ptr(smap->successes, cpu));
> +		drops += local_read(per_cpu_ptr(smap->drops, cpu));
> +	}
> +
> +	seq_printf(m, "entries:      %u / %u\n", entries, smap->max_elts);
> +	seq_printf(m, "table_size:   %u\n", smap->map_size);
> +	seq_printf(m, "successes:    %llu\n", successes);
> +	seq_printf(m, "drops:        %llu\n", drops);
> +	if (successes + drops > 0) {
> +		/*
> +		 * mul_u64_u64_div_u64() uses a 128-bit intermediate, so
> +		 * (successes * 100) cannot overflow even when successes
> +		 * approaches U64_MAX on a very long trace.
> +		 */
> +		successes = mul_u64_u64_div_u64(successes, 100, successes + drops);
> +	} else {
> +		successes = 0;
> +	}
> +	seq_printf(m, "success_rate: %llu%%\n", successes);

and up_read(&smap->reader_sem) too.

> +	return 0;
> +}
> +
> +static int stackmap_stat_open(struct inode *inode, struct file *file)
> +{
> +	return single_open(file, stackmap_stat_show, inode->i_private);
> +}
> +
> +const struct file_operations ftrace_stackmap_stat_fops = {
> +	.open		= stackmap_stat_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +
> +/* --- Binary export --- */
> +
> +struct stackmap_bin_snapshot {
> +	/*
> +	 * Use u64 (not size_t) so data[] is 8-byte aligned on both
> +	 * 32-bit and 64-bit architectures. The IP array within data[]
> +	 * is accessed as u64*, which would alignment-fault on strict
> +	 * architectures (e.g. older ARM, SPARC) if data[] started at
> +	 * a 4-byte boundary.
> +	 */
> +	u64	size;
> +	char	data[];
> +};
> +
> +static int stackmap_bin_open(struct inode *inode, struct file *file)
> +{
> +	struct ftrace_stackmap *smap = inode->i_private;
> +	struct stackmap_bin_snapshot *snap;
> +	struct ftrace_stackmap_bin_header *hdr;
> +	struct ftrace_stackmap_bin_entry *e;
> +	size_t alloc_size, off;
> +	u32 nr_entries, i, nr_stacks;
> +
> +	if (!smap)
> +		return -ENODEV;
> +
> +	/*
> +	 * Serialize opens: only one snapshot may be pinned at a time
> +	 * (see @bin_open). Released in stackmap_bin_release().
> +	 */
> +	if (atomic_cmpxchg(&smap->bin_open, 0, 1) != 0)
> +		return -EBUSY;
> +
> +	/*
> +	 * Worst-case allocation size: every populated entry uses a
> +	 * full-depth stack. The (+1) gives one slack slot in case a
> +	 * concurrent insert lands between this snapshot and iteration.
> +	 * The loop below performs an explicit bounds check anyway.
> +	 *
> +	 * At bits=18 this caps at ~135 MB. The file is mode 0440
> +	 * (TRACE_MODE_READ), so only privileged users can open it.

Hmm, this is too huge to make a copy inside the kernel.
If the stackmap is only increasing, and can avoid resetting by
reader_sem, what about rewriting this as a raw-output mode of
seq_file?
You can use seq_write() to seq_file buffer.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
