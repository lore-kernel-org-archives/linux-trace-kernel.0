Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2CB35A3A6
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772186527; cv=none; b=dEMFNUpUxRhPNEnsMb0yC0TVV8pFoh2H7LIXIrIueu+Zxyg4tOrAnoNrkccVg+wlS8ReQAfkgbu/A9peJrQ8YM8VfjkrWYNyeZ6S1g0ZodbKsNLeNzYAnr6ye9d5PJuhppp9d3AcY2IhALBFC0mf+QeX9Cs5EAqyLCSdJGZ0WG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772186527; c=relaxed/simple;
	bh=2VaJOmkUSU/W/BZJeyRFO41YmjgBSZYWuJmiSwhM65c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KIgiM0FPSoCqfmFwjg0H01UHZICkYx9eLV00e5V1rLSdNdOfJJblj+MoOyvNtJiAKvLTVpLWztcuDmYnWSIRRfAxD1Upuq4CfDeCwkSbdOQJsaKNHp4dBy8pScLK9WF0C4Q8BSXDZUeK6PCLV+luhToqWFC4DPIQMBXfWkFsaf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yoi1yU94; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yoi1yU94"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48378136adcso10924085e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 02:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772186524; x=1772791324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qsndPfFBrY0DlP1r/HjD63Wwnr9fz/D+PLW9Y98RIro=;
        b=yoi1yU94VP9xTCrQZW2CS3lQkvTNBkNwdauTMaqPzNaaBMLnr16ASY4PwxbHctZDZ2
         ymYrWDBLf9Qh3n2TT2zQOjB3zQUUFQiFxYdBiaKkq8aAhSLvhvoF7qtjXEWz2zKpU+0y
         VsShLoLuYJOGqv6G5SOsoVTfWJyyZ8YE5jVfBm/glJ8QhiLLmWkL3RX2MFz4QbGac6xk
         rAiPdj7xHaOUlBkmczlYjXXp678CwNOTm9QzEE5rAs1ry8AJS6akW/jWMEJqUchK7c7c
         YEwMFVJK1986Z+GRmDMU2VwsQerqkyH0Yr8j35JQj2go0xWrFF5G9yCq6v68TZPpn1gs
         AVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772186524; x=1772791324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qsndPfFBrY0DlP1r/HjD63Wwnr9fz/D+PLW9Y98RIro=;
        b=L8CX/x/c3mqOXWXxvcEaiIh7SYSgJuszCveKSgRUNldLTk59phOv5wl78NWUPtMT9z
         7ylMV4/YyMa2WYnW60jU30jqpgj5Ka20eWjHLxp7FAu9KGsrSVf/ijP7JLylEmI91zq0
         BDsdch8SpDz78v8cMyd+ZFrlLVE9xk5gFR9gI8PdiRVL8G1DljGbDywNTOeowsJL7BG3
         LLkXfMYBtvBDpEd+n7ngZYLuhzQxSRe1nbDJtjTNzlgUkH7UwZMcUKeWiz/c/sa6dkVy
         vmhtLNaTjApT1qL1+39dU2ZRn2/K3nVXRWuKaH60UxMhZE6f4lZzM6r/Lky1DpesRnN3
         w1OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWV+Tq+GZWVFo1Z/RXOLjn8zRlSKH52G2NTGtzisjO6tjGeEo4HWsRQ9u7lV7NrmJvfsSIg4+jeaAJmIlwG9q2CW58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4BFlo9/fvjSPRijOx7Q9i/8B3AcSTTwY+d8HFdUE2rKC8HjUT
	5Yy78LePFZKmBnWybrPqB2XjFQiJGPo5ngc2VkHMlXIHGtB1pVW1Uuj6xq58IT+row==
X-Gm-Gg: ATEYQzx8IKAE5Wq6Z0C+MLPGsZiAyKntpsN4fLN3Hm/oavk/I3dTn+g8UIYU0k4d70t
	Ry0ZSsCaa9osbyGXDe0TQYwCsj881KggMt+6fWn+LpkS/suVtDpzOycm7sY8Xdcvrb3nWM5IZYd
	Z63BQEdWPUikwe+5vg1oKdRIQ3hgcPTXz8w3lc7WSAaALDuwa9zWhyFmWfTgTGZjCYgDERgID7e
	g62SyiKdf4xlr8MH7CNqNAS9+vsuBnXsT4AQqDKg98IyygGue4AyIQY7IqeaeNmPwbUuskfFv4H
	rnDgqxHwnE2FaUulSLNnVxmdulZka5z8tAGeom1WPQrIeipR8ZpY8NHkplv1xNICbCm+K8a30Y6
	iZVEit8q7rRBK0bgd+YvAdMcRTKzQJ5vbEgqlxp3fzU9UAQng4b311bptZLJaxKYD8HcKOu7uul
	hVHRtShqJg1KGXBihaJYGlJUNO+riTWUhuayhDZtA69dxZb1ImuGM2JhmuiuoTseNs6gg=
X-Received: by 2002:a05:600c:46c4:b0:483:7783:537b with SMTP id 5b1f17b1804b1-483c9c0f34cmr31377655e9.24.1772186523881;
        Fri, 27 Feb 2026 02:02:03 -0800 (PST)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd70e6c9sm171777575e9.8.2026.02.27.02.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 02:02:03 -0800 (PST)
Date: Fri, 27 Feb 2026 10:02:00 +0000
From: Vincent Donnefort <vdonnefort@google.com>
To: Qing Wang <wangqing7171@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
Subject: Re: [PATCH] tracing: Fix WARN_ON in tracing_buffers_mmap_close
Message-ID: <aaFrmHzIAkEe7ufy@google.com>
References: <20260227025842.1085206-1-wangqing7171@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227025842.1085206-1-wangqing7171@gmail.com>

On Fri, Feb 27, 2026 at 10:58:42AM +0800, Qing Wang wrote:
> When a process forks, the child process copies the parent's VMAs but the
> user_mapped reference count is not incremented. As a result, when both the
> parent and child processes exit, tracing_buffers_mmap_close() is called
> twice. On the second call, user_mapped is already 0, causing the function to
> return -ENODEV and triggering a WARN_ON.
> 
> Fix it by incrementing the user_mapped reference count without re-mapping
> the pages in the VMA's open callback.

Hum, not sure this is entirely correct. We do set VM_DONTCOPY when creating the
mapping (see __rb_map_vma). So AFAICT ->open() is not called in this situation (see
dup_mmap())

> 
> Fixes: cf9f0f7c4c5bb ("tracing: Allow user-space mapping of the ring-buffer")
> Reported-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3b5dd2030fe08afdf65d
> Tested-by: syzbot+3b5dd2030fe08afdf65d@syzkaller.appspotmail.com
> Signed-off-by: Qing Wang <wangqing7171@gmail.com>
> ---
>  include/linux/ring_buffer.h |  1 +
>  kernel/trace/ring_buffer.c  | 21 +++++++++++++++++++++
>  kernel/trace/trace.c        | 13 +++++++++++++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/include/linux/ring_buffer.h b/include/linux/ring_buffer.h
> index 876358cfe1b1..d862fa610270 100644
> --- a/include/linux/ring_buffer.h
> +++ b/include/linux/ring_buffer.h
> @@ -248,6 +248,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node);
>  
>  int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  		    struct vm_area_struct *vma);
> +void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu);
>  int ring_buffer_unmap(struct trace_buffer *buffer, int cpu);
>  int ring_buffer_map_get_reader(struct trace_buffer *buffer, int cpu);
>  #endif /* _LINUX_RING_BUFFER_H */
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index f16f053ef77d..17d0ea0cc3e6 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7310,6 +7310,27 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
>  	return err;
>  }
>  
> +/*
> + * This is called when a VMA is duplicated (e.g., on fork()) to increment
> + * the user_mapped counter without remapping pages.
> + */
> +void ring_buffer_map_dup(struct trace_buffer *buffer, int cpu)
> +{
> +	struct ring_buffer_per_cpu *cpu_buffer;
> +
> +	if (WARN_ON(!cpumask_test_cpu(cpu, buffer->cpumask)))
> +		return;
> +
> +	cpu_buffer = buffer->buffers[cpu];
> +
> +	guard(mutex)(&cpu_buffer->mapping_lock);
> +
> +	if (cpu_buffer->user_mapped)
> +		__rb_inc_dec_mapped(cpu_buffer, true);
> +	else
> +		WARN(1, "Unexpected buffer stat, it should be mapped");
> +}
> +
>  int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
>  {
>  	struct ring_buffer_per_cpu *cpu_buffer;
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 23de3719f495..1e7c032a72d2 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -8213,6 +8213,18 @@ static inline int get_snapshot_map(struct trace_array *tr) { return 0; }
>  static inline void put_snapshot_map(struct trace_array *tr) { }
>  #endif
>  
> +/*
> + * This is called when a VMA is duplicated (e.g., on fork()) to increment
> + * the user_mapped counter without remapping pages.
> + */
> +static void tracing_buffers_mmap_open(struct vm_area_struct *vma)
> +{
> +	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> +	struct trace_iterator *iter = &info->iter;
> +
> +	ring_buffer_map_dup(iter->array_buffer->buffer, iter->cpu_file);
> +}
> +
>  static void tracing_buffers_mmap_close(struct vm_area_struct *vma)
>  {
>  	struct ftrace_buffer_info *info = vma->vm_file->private_data;
> @@ -8232,6 +8244,7 @@ static int tracing_buffers_may_split(struct vm_area_struct *vma, unsigned long a
>  }
>  
>  static const struct vm_operations_struct tracing_buffers_vmops = {
> +	.open		= tracing_buffers_mmap_open,
>  	.close		= tracing_buffers_mmap_close,
>  	.may_split      = tracing_buffers_may_split,
>  };
> -- 
> 2.34.1
> 
