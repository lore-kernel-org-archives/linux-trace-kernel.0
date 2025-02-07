Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE03149E13;
	Fri,  7 Feb 2025 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738893075; cv=none; b=qH3CQYz+TuDWXilRVaZyqmyFu/dRHBRO041qd8kVafzUGGScssd7T6wmoS+cZ/a6Vc/Af694kO1Mf26QjVRaOKTYG74JP6AOS5/Vr1yGt2+o8CX+vPuV1YVi+fHoECYVzBRSlzAGvx+5wPcbdYVBjcE1UueeqzYW6GXFYxiEMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738893075; c=relaxed/simple;
	bh=+xSqLf5FPzReA3wi9zmrKE/+PcuSUctW01f8cSqCoQE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RptfbQKjM9LM4hczgO563jw1oVYjHwhjXaThIb5CA4ks8Vqmr7+QptpowykuKYZtlFVv4zq7rk6UW2c1YvnwYqorBCU9QRUhDSIdDsAt/MA/YbAJgK0nc7gdtLXoyQRsAziuFDmQVBnpnGTiE6kV6b9zxslAEhbGU3SSguosOBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYsMGn8Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYsMGn8Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A42C4CEE3;
	Fri,  7 Feb 2025 01:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738893075;
	bh=+xSqLf5FPzReA3wi9zmrKE/+PcuSUctW01f8cSqCoQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gYsMGn8Z+9VlpRJI6eSQtl95yrk1+bx8Y0QucWBbLSHTatu3F60BJp7w7DC/U/e0a
	 2GoidCrmkFFXeQrK3Ren4kf0+/snQR1XWgcMgzwpyi3eg8Drvcl8F8Fq48o+uLrFk4
	 TShJFULBX38wkpOTVJFz/EEjLbf5WJkpR0ajpzW8s+FoR7Pe+HrCuLynTwTotHQ6I/
	 z0XcQc/L+vu4ffVusE1oDN+ZFacdAIZOkhpySnvjdJHvS8086Dl6YIrIFbFwxfmH70
	 oT+BPCCGn7Sd83evoLQGanXUMBbRqrqwtHnoOydKmw4ZdcQ6eirWQzCuvc+AXB5EyZ
	 Jn9tQZceBsSNQ==
Date: Fri, 7 Feb 2025 10:51:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH 7/8] tracing: Show module names and addresses of last
 boot
Message-Id: <20250207105111.1067fc1421bf682818e488c1@kernel.org>
In-Reply-To: <20250205225104.096389081@goodmis.org>
References: <20250205225031.799739376@goodmis.org>
	<20250205225104.096389081@goodmis.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 05 Feb 2025 17:50:38 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Add the last boot module's names and addresses to the last_boot_info file.
> This only shows the module information from a previous boot. If the buffer
> is started and is recording the current boot, this file still will only
> show "current".
> 
>   # cat instances/boot_mapped/last_boot_info
>   Offset: 10c00000
>   ffffffffc00ca000 usb_serial_simple
>   ffffffffc00ae000 usbserial
>   ffffffffc008b000 bfq

This is just a suggestion, what about using the same format for all
lines? For example,

# cat instances/boot_mapped/last_boot_info
10c00000         [kernel]
ffffffffc00ca000 usb_serial_simple
ffffffffc00ae000 usbserial
ffffffffc008b000 bfq

> 
>   # echo function > instances/boot_mapped/current_tracer
>   # cat instances/boot_mapped/last_boot_info
>   Offset: current

And this one is empty if it is already for the current.
(because last boot information is cleared)

Thank you,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 103 +++++++++++++++++++++++++++++++++++++------
>  1 file changed, 90 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index a8e5f7ac2193..7b4027804cd4 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -6005,6 +6005,8 @@ struct trace_scratch {
>  	struct trace_mod_entry	entries[];
>  };
>  
> +static DEFINE_MUTEX(scratch_mutex);
> +
>  static int save_mod(struct module *mod, void *data)
>  {
>  	struct trace_array *tr = data;
> @@ -6012,6 +6014,8 @@ static int save_mod(struct module *mod, void *data)
>  	struct trace_mod_entry *entry;
>  	unsigned int size;
>  
> +	guard(mutex)(&scratch_mutex);
> +
>  	tscratch = tr->scratch;
>  	if (!tscratch)
>  		return -1;
> @@ -6882,15 +6886,47 @@ tracing_total_entries_read(struct file *filp, char __user *ubuf,
>  	return simple_read_from_buffer(ubuf, cnt, ppos, buf, r);
>  }
>  
> -static ssize_t
> -tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
> +#define LAST_BOOT_HEADER ((void *)1)
> +
> +static void *l_next(struct seq_file *m, void *v, loff_t *pos)
>  {
> -	struct trace_array *tr = filp->private_data;
> +	struct trace_array *tr = m->private;
>  	struct trace_scratch *tscratch = tr->scratch;
> -	struct seq_buf seq;
> -	char buf[64];
> +	unsigned int index = *pos;
> +
> +	(*pos)++;
> +
> +	if (*pos == 1)
> +		return LAST_BOOT_HEADER;
> +
> +	/* Only show offsets of the last boot data */
> +	if (!tscratch || !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
> +		return NULL;
> +
> +	/* *pos 0 is for the header, 1 is for the first module */
> +	index--;
> +
> +	if (index >= tscratch->nr_entries)
> +		return NULL;
>  
> -	seq_buf_init(&seq, buf, 64);
> +	return &tscratch->entries[index];
> +}
> +
> +static void *l_start(struct seq_file *m, loff_t *pos)
> +{
> +	mutex_lock(&scratch_mutex);
> +
> +	return l_next(m, NULL, pos);
> +}
> +
> +static void l_stop(struct seq_file *m, void *p)
> +{
> +	mutex_unlock(&scratch_mutex);
> +}
> +
> +static void show_last_boot_header(struct seq_file *m, struct trace_array *tr)
> +{
> +	struct trace_scratch *tscratch = tr->scratch;
>  
>  	/*
>  	 * Do not leak KASLR address. This only shows the KASLR address of
> @@ -6900,11 +6936,52 @@ tracing_last_boot_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t
>  	 * should not be the same as the current boot.
>  	 */
>  	if (!tscratch || !(tr->flags & TRACE_ARRAY_FL_LAST_BOOT))
> -		seq_buf_puts(&seq, "Offset: current\n");
> +		seq_puts(m, "Offset: current\n");
>  	else
> -		seq_buf_printf(&seq, "Offset: %lx\n", tscratch->kaslr_addr);
> +		seq_printf(m, "Offset: %lx\n", tscratch->kaslr_addr);
> +}
>  
> -	return simple_read_from_buffer(ubuf, cnt, ppos, buf, seq_buf_used(&seq));
> +static int l_show(struct seq_file *m, void *v)
> +{
> +	struct trace_array *tr = m->private;
> +	struct trace_mod_entry *entry = v;
> +
> +	if (v == LAST_BOOT_HEADER) {
> +		show_last_boot_header(m, tr);
> +		return 0;
> +	}
> +
> +	seq_printf(m, "%lx %s\n", entry->mod_addr, entry->mod_name);
> +	return 0;
> +}
> +
> +static const struct seq_operations last_boot_seq_ops = {
> +	.start		= l_start,
> +	.next		= l_next,
> +	.stop		= l_stop,
> +	.show		= l_show,
> +};
> +
> +static int tracing_last_boot_open(struct inode *inode, struct file *file)
> +{
> +	struct trace_array *tr = inode->i_private;
> +	struct seq_file *m;
> +	int ret;
> +
> +	ret = tracing_check_open_get_tr(tr);
> +	if (ret)
> +		return ret;
> +
> +	ret = seq_open(file, &last_boot_seq_ops);
> +	if (ret) {
> +		trace_array_put(tr);
> +		return ret;
> +	}
> +
> +	m = file->private_data;
> +	m->private = tr;
> +
> +	return 0;
>  }
>  
>  static int tracing_buffer_meta_open(struct inode *inode, struct file *filp)
> @@ -7533,10 +7610,10 @@ static const struct file_operations trace_time_stamp_mode_fops = {
>  };
>  
>  static const struct file_operations last_boot_fops = {
> -	.open		= tracing_open_generic_tr,
> -	.read		= tracing_last_boot_read,
> -	.llseek		= generic_file_llseek,
> -	.release	= tracing_release_generic_tr,
> +	.open		= tracing_last_boot_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= tracing_seq_release,
>  };
>  
>  #ifdef CONFIG_TRACER_SNAPSHOT
> -- 
> 2.45.2
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
