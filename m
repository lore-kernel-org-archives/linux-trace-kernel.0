Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8352A3242BD;
	Thu, 24 Sep 2026 01:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213788; cv=none; b=cLYL11X0SmP5D5iITT5uHnqK8Blcct6SN9XErWGhfC01BxQcvlAqkMQL3QEy1GI6uNIP4GsLJwjXBSm078DqcYmd1wdv4NEh9m46KL7JDDEAA/6GxX6numoR/GwQFswLmOvlJ4TVUIOJy6E5WVfcO2CXIF7cnpf4x9tmghYDlLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213788; c=relaxed/simple;
	bh=g/SrVZ4KDF/1t7bm/m02RIKAUCgp+/oVsy4yigLKA2Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rXotDU2J92/m5h12ZLskVmk8rpbwlLXEHyQPXCm0x9SVRyelAlSxyrrushmSBGZ2VH6Rc7GO9TFW4aZT89SsgGJ4jCTNC0GQKzRPQwVq6P4+GI/aoaosu1LqOlKuff4HVRu/YZBji/m097lTVgYnGKTGkHWhzCFE4GScvPhNxk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlDc+2vg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlDc+2vg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9C81F000FF;
	Thu, 24 Sep 2026 01:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790213787;
	bh=XBdH0Cl5GPC2w5S+VLFijagtvFGHuXlSXqgvc3FDuwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UlDc+2vgg/V7QJw7TtCaJZFNhExAuOtut+CJW2CJI6bsbQYNV/+Apjt3en6e95aIH
	 PmsaZmlGIAI1KTy+w64SoKaAvDSwKbZS27RnUiQ3tynHLlYEXO6bt8p0VKLlWzKG9q
	 a2bXb7x3J/NRt/uXq8gsrEGB6oK+scEVmBkXMVGdOkrzp9JVRTgdC1aoyaOoA8mPJU
	 N75mPjKMEPoLaLWU8fk3IhKudVbvlm3rfkSzkXncSQtkHmOm4uefXRsfcLIodpx202
	 qaykVihU7Yt37qxJ33fPEcjUVA8CdB++hF4tolIANNdGk7VE1GfKMzVrHUD7lNLoIt
	 hGzqTIjhbFRfQ==
Date: Thu, 24 Sep 2026 10:36:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Vincent Donnefort
 <vdonnefort@google.com>, Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Lorenzo Stoakes <ljs@kernel.org>, gao xu
 <gaoxu2@honor.com>, yinchuang1@xiaomi.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Xiang Gao
 <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v4 2/2] tracing: add per-CPU memory usage statistics in
 tracefs
Message-Id: <20260924103621.734c895420a97a2d6f36332e@kernel.org>
In-Reply-To: <20260921113047.1152602-3-gaoxiang17@xiaomi.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-1-gaoxiang17@xiaomi.com>
	<20260921113047.1152602-3-gaoxiang17@xiaomi.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 19:30:46 +0800
Xiang Gao <gxxa03070307@gmail.com> wrote:

> +static struct trace_mem_stats trace_buffers_memory_cpu(int cpu)
> +{
> +	struct trace_mem_stats stats = {};
> +	struct trace_array *tr;
> +
> +	guard(mutex)(&trace_types_lock);
> +
> +	list_for_each_entry(tr, &ftrace_trace_arrays, list)
> +		trace_array_buffer_memory(tr, cpu, &stats.buffers,
> +					  &stats.snapshot);
> +
> +	/* Account for the bootstrapping temp_buffer as well. */
> +	if (temp_buffer)
> +		stats.buffers += ring_buffer_memory_size(temp_buffer, cpu);
> +
> +	return stats;
> +}
> +
> +static int trace_mem_per_cpu_show(struct seq_file *m, void *v)
> +{
> +	struct trace_mem_stats stats = trace_buffers_memory_cpu((long)m->private);
> +
> +	seq_printf(m, "buffers: %lu\n", stats.buffers >> 10);
> +	seq_printf(m, "snapshot_buffers: %lu\n", stats.snapshot >> 10);
> +
> +	return 0;
> +}
> +
> +static int trace_mem_per_cpu_open(struct inode *inode, struct file *file)
> +{
> +	int ret;
> +
> +	ret = tracing_check_open_get_tr(NULL);
> +	if (ret)
> +		return ret;
> +
> +	return single_open(file, trace_mem_per_cpu_show, inode->i_private);
> +}
> +
> +static const struct file_operations trace_mem_per_cpu_fops = {
> +	.open		= trace_mem_per_cpu_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= single_release,
> +};
> +

These functions seems like a dead copy of non-per-cpu version. Can you
reuse the same code?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
