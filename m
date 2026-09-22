Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D0E478859
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790070171; cv=none; b=jpkwEFe8wJAeov09KdEIN7xEHsDFLVWEbS0JuMkl8XG87ywIW7EjAGuIEOG9wz0UxJ6WruZqOka7jps+DCzko4SVAzORsqjQeuL+rjM2KItJqmoQ+jH/iOQYfMIEi2l14eBChSquGDXCHF8HnmDAKHh4w4Rt/KnRInYufywRBMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790070171; c=relaxed/simple;
	bh=a39y1L00I8aIeYf55Sn7jyd8GYre/QU0QKN9hRvsKzI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqfb9i23sXf2cubB1fmFp3VHnNkUcl2na/0hYC0F6QSbMSYHHSYR0l1o3iWzYEiZELIIDgJ05BPj794ktQTe4ozoB0PxAkNaSi5S/Xm0laHs0h3O8Fns6n1xpon6TngVHlaqz/a8lghdYPgTPNGZLCLAuZ5CAEObSj0hA1bzd8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pMPY2MF+; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pMPY2MF+"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-486e1a044c5so2769132f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 02:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790070167; x=1790674967; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=63jLM3p/yGHFLc3CNq4tuxz/dfqASMTYz4nLQopy+Yo=;
        b=pMPY2MF+oQWYDlqrQd3zbhZgL2p/SNbHMrEaNK2vxofJQIopgmpPeeiVbk6HZ9FV16
         Qi+A/Tb7lwDCVUXvXOYjVBQnP0bMXBh4zct6tb3W9pBN1tcTV/KMi/Ai5Fsdbz/3xERT
         CKJUkO473VpEz3ynpWZW/LigXxa1RoVnrA4O6juB4asliJK/ZN809Ci0KKVAHJkoqcll
         fAG+qRFhCFGz6pg9E2Zjt5PZwRgVCInzVeEuXf/fuwMpTA1No90pgqNxPb2OMW7RipET
         0zSNGCIu2R6KxJuQrGNw6fw6rAM8P4Mluy/K9ccI5dzLrZpM7XmDeICFU673F3gTpS+6
         LF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790070167; x=1790674967;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63jLM3p/yGHFLc3CNq4tuxz/dfqASMTYz4nLQopy+Yo=;
        b=pRGfGZbrcdwV42q2P2xyRvz4BaVJAvTx7/D+B46LB7rVcQLNfm8fIMUVFf9DTIrRbW
         LJoVpC/e4U26yNGrAzkoBuxUGJ6PgDlwVQjN+m4HahJ+yj2VqpCKlrsF3Oyqb4sVEBlb
         hplPrWr2DNVsYCyqETP8XHDkzuBXgGxeQ0hcTK6hKzUxd5loBBtv4z7Mo2ode0WBG+q9
         3lKeJIl8Qc+09sR5XznMaXPzzb45QxiKmJOP1/WUORuk6w00qWGfPFrpLZ50Ay5B6jOy
         dF5iLfnS+bHSunDkq5QiGMboxIL57q6EYAcUd8ZKNXxQSw+2kFT+rlc8DIXJPEQuU8fM
         KJ4A==
X-Forwarded-Encrypted: i=1; AKwUvBxJpj2MXbiNj8nCMJzq6k7NH9pKqA5F7SvzuzunCnlr8aAV4Y2hjZiA/pcByhk1UuaTF2XPxaITlPul3s2phrGubCg=@vger.kernel.org
X-Gm-Message-State: AFuF++mPuk95o6cKaZMXxG49heJizFDZ+JKjRdV8pWcuREb6m+cwjOo9
	mE+TABVSiK+kuWThNEmfWZNKPB8dtyGF1W3CRr8IDXZeCKFruXoTrybq5SNiRiFUKQ==
X-Gm-Gg: AYBFou3+wIB2/3FGnF+Ucvuxzv540MET/50nPXmIHwSh1b7lQPDOGrGB5Uv2cE1TTS6
	2gMlsJulAfH1DxO+4PMv49NOuwZb95yd4BlFhENIdxAZSWF2RnYwQe2cBA7ZBVbIluiZUE1pmX0
	K3kQ5z/FEnq0mtDJpogLs64YsXNz/EY071WNHoYrJ7Wl4UwDmh0oMParo3eTKBDhmrGTiSaMo4g
	4BcNFpd8Q0U1Rwc0/8AAS5ABesKXy1c2HbglCbH8QD1TDhwcoDEuYaRWhwAGySFsRIPv+pGBp6u
	aFuoHaFoBFzu5wVwyMtG9m0v0sIMk3NvMSaMpT1fAEyLMCOlm+/fN58N0pzMu+88sn9QdzVkvEi
	BK+eQqdRcxqReM8ZjBbd1nqD7NVrNEqZ3mJUmuge9aO3fpMmE35dFafQNOn2m5hMQNCZkto43wc
	ECOTekS4zvpA5dV2gCqMLrPsEn/yhpLb1uvG5rOLo+2sqwKRZhrHDzEwd+JvOfhu8xgQJdu4xlu
	8SRKO0XoIdwVSR637KEkb+ayPVO9t34KEHLeKXvqCAT
X-Received: by 2002:a05:6000:4809:b0:487:360:58d8 with SMTP id ffacd0b85a97d-4871e36fcf0mr19672027f8f.46.1790070167049;
        Tue, 22 Sep 2026 02:42:47 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862795215sm3484729f8f.37.2026.09.22.02.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:42:46 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:42:43 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>, gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, Xiang Gao <gaoxiang17@xiaomi.com>
Subject: Re: [PATCH v4 2/2] tracing: add per-CPU memory usage statistics in
 tracefs
Message-ID: <arJNk5-i9LPI24Q4@google.com>
References: <20260916063322.472172-1-gaoxiang17@xiaomi.com>
 <20260921113047.1152602-1-gaoxiang17@xiaomi.com>
 <20260921113047.1152602-3-gaoxiang17@xiaomi.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921113047.1152602-3-gaoxiang17@xiaomi.com>

On Mon, Sep 21, 2026 at 07:30:46PM +0800, Xiang Gao wrote:
> Provide a per-CPU view of the tracing ring-buffer memory usage under
> trace_stats/per_cpu/cpuN/memory_usage_kb, using the same format as the
> aggregate file. Each file reports only the buffers belonging to that CPU
> across the global trace array and all tracing instances.
> 
> Signed-off-by: Xiang Gao <gaoxiang17@xiaomi.com>
> ---
>  Documentation/trace/ftrace.rst |  3 ++
>  kernel/trace/trace.c           | 67 +++++++++++++++++++++++++++++++++-
>  2 files changed, 69 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 99ddfe26b7cd..e53cdd8d6702 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -230,6 +230,9 @@ of ftrace. Here is a list of some of the key files:
>  	    buffers: ...
>  	    snapshot_buffers: ...
>  
> +	The same file is provided under trace_stats/per_cpu/cpuN/, reporting
> +	only the buffers belonging to that CPU.
> +
>    buffer_subbuf_size_kb:

Could you split the documentation part into a different commit?

>  
>  	This sets or displays the sub buffer size. The ring buffer is broken up
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index d4a913ff8a69..4010f28f3ebf 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -5844,6 +5844,52 @@ static const struct file_operations trace_mem_fops = {
>  	.release	= single_release,
>  };
>  
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
>  #define LAST_BOOT_HEADER ((void *)1)
>  
>  static void *l_next(struct seq_file *m, void *v, loff_t *pos)
> @@ -9360,7 +9406,9 @@ static struct notifier_block trace_module_nb = {
>  
>  static __init void init_trace_stats_tracefs(void)
>  {
> -	struct dentry *stats_dir;
> +	struct dentry *stats_dir, *per_cpu_dir, *cpu_dir;
> +	char cpu_dir_name[30];
> +	int cpu;
>  
>  	/*
>  	 * tracer_alloc_buffers() frees tracing_buffer_mask and temp_buffer
> @@ -9376,6 +9424,23 @@ static __init void init_trace_stats_tracefs(void)
>  
>  	trace_create_file("memory_usage_kb", TRACE_MODE_READ, stats_dir,
>  			  NULL, &trace_mem_fops);
> +
> +	per_cpu_dir = tracefs_create_dir("per_cpu", stats_dir);
> +	if (!per_cpu_dir)
> +		return;
> +
> +	for_each_tracing_cpu(cpu) {
> +		snprintf(cpu_dir_name, 30, "cpu%d", cpu);
> +		cpu_dir = tracefs_create_dir(cpu_dir_name, per_cpu_dir);
> +		if (!cpu_dir) {
> +			pr_warn("Could not create tracefs '%s' entry\n",
> +				cpu_dir_name);
> +			continue;
> +		}
> +
> +		trace_create_file("memory_usage_kb", TRACE_MODE_READ, cpu_dir,
> +				  (void *)(long)cpu, &trace_mem_per_cpu_fops);
> +	}
>  }
>  
>  static __init void tracer_init_tracefs_work_func(struct work_struct *work)
> -- 
> 2.34.1
> 

-- 
Vincent
