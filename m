Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7560143891
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Apr 2024 14:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712933243; cv=none; b=VpZhXB9cYS+c5gOpjVWIAn/fo+GTAzJ/mqeR/Z2qkIt6aMwz8tf7p/xKafacNYhQc9Oqb9M2j5vqk/llksHfvzJ6uuwgafAU8ExPJ3obhHFCnuCLugC2jd91Ka+PcsB4z/97ncUw7P6BLbPTl7V3k8j/gfZXFb8y3Njo+KmJhS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712933243; c=relaxed/simple;
	bh=TcAKeIAD4FI6V9EJTyRm4kVDYMy0g1VhCv2E013IWgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjYru/Le9dqwiaiTXHVp8Dar1eB2kFqSiPsaKM5PdMglX15v8Doubr+3JxI6pyFMDd32yrTTmlHSXLpja08T7UHBzkuLr061I9B4Y7PgsjSgWYdLzJxMfo/o356tP9ymhl8fmigPupwpMo+7jVdrwqx3yLkeYJpknpLkLuXzE7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Tl8dbV8m; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Tl8dbV8m"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41650ee55ffso7053925e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712933239; x=1713538039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B9On/12QgOndZa7hunUmoB6GwxdTLfDtaIfjJMR0hWE=;
        b=Tl8dbV8mG32rYvbfD0kqBjWicI7wEJol/58oqI/VBzf5Cppk9GiC29xlj4pLZoXoQm
         tWTxLjLYvTOVEQyCy3zjnMYW6APmaqH9rF7esE81tR4lpj9OCykdI39lPFiuoN2PUEWJ
         M7TbJ00lw4msrlPMWS9n/IHVkoZm9KPrnf4f0JGg+sUqHsT0OlLIGkUb0H9KaiyOvtpP
         +SvFUSnATuYcoF/nmlY3pBltRvnC/43MfSfnCq/MKDh8aveGzy3fhKwHiG2oKq3GdPz0
         etfZAKicgoiDBpuCVDPCqvbMxw4uD6NKck5Gfvrnw23D/ee8vW13g9hD9GwzF6tLgRBN
         KkzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712933239; x=1713538039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B9On/12QgOndZa7hunUmoB6GwxdTLfDtaIfjJMR0hWE=;
        b=Ib/Qie7ZAgQAq0E16Mh1Pm0ArKTUYUfd6LGsoNboHVNzPU1iNiwLcn5W7e4OS2O62o
         z8I+QYoTYWpgfStlXdStNYjAAiOdWMfOseSRtW/sRmT1DmfS3ddfdW+C/ThxrvrmWPn7
         AV8woxs/XrcKAAvV1p8RDj7I1pZmXnnaFi/z7tQEa+BUMLJlxGjZIFSkTRsTYQovZRlD
         6lbSCBF1StasGpE6BjAfhb+r8i0Yo+D6BoLVBAUbe7O4gYVcg83phhl/t7k2Mf8js6Nt
         jhrb9bq9Y45SxF+5T2RPBilax+OAWZGvYpG7c7a69nTUJHvof6FnBhpSJS02qurtBJqm
         EmuA==
X-Forwarded-Encrypted: i=1; AJvYcCWNzgLR5lp1quCFsZR2MdOyBiGpm6J2YMQy6NuWIkaniU9B00afMaeTm5WZDgqHZ4wvwjoHc90K7NrM64YTKeWgCgPRcNC84qAV1VQM7GfoyW/z
X-Gm-Message-State: AOJu0YzHZKxN6asYCIZQp9p9gof9KV8EPqyD1Y85CyKGdTNvXqlfQlgB
	CrwuJMosPJo5pYRXwB1EOwOsOf5cIq38ESjNFXuVm9721wGM9m6qRjy1PCSIsg==
X-Google-Smtp-Source: AGHT+IFt27/j/DJEWe+JM8KZ20gBHWLTRe2a2NjdXivl0luS1r6aIkKVTKx7gFAfv4NXA5mox/v5eQ==
X-Received: by 2002:a05:600c:3b25:b0:416:2a95:6e8b with SMTP id m37-20020a05600c3b2500b004162a956e8bmr2072128wms.26.1712933238941;
        Fri, 12 Apr 2024 07:47:18 -0700 (PDT)
Received: from google.com (161.126.77.34.bc.googleusercontent.com. [34.77.126.161])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0041665d968f1sm5821885wmg.47.2024.04.12.07.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:47:18 -0700 (PDT)
Date: Fri, 12 Apr 2024 15:47:15 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, suleiman@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Youssef Esmat <youssefesmat@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v2 01/11] ring-buffer: Allow mapped field to be set
 without mapping
Message-ID: <ZhlJc6gni3rcOWW7@google.com>
References: <20240411012541.285904543@goodmis.org>
 <20240411012904.237435058@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411012904.237435058@goodmis.org>

On Wed, Apr 10, 2024 at 09:25:42PM -0400, Steven Rostedt wrote:
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> In preparation for having the ring buffer mapped to a dedicated location,
> which will have the same restrictions as user space memory mapped buffers,
> allow it to use the "mapped" field of the ring_buffer_per_cpu structure
> without having the user space meta page mapping.
> 
> When this starts using the mapped field, it will need to handle adding a
> user space mapping (and removing it) from a ring buffer that is using a
> dedicated memory range.
> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/ring_buffer.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 793ecc454039..44b1d5f1a99a 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5223,6 +5223,9 @@ static void rb_update_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
>  {
>  	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
>  
> +	if (!meta)
> +		return;
> +
>  	meta->reader.read = cpu_buffer->reader_page->read;
>  	meta->reader.id = cpu_buffer->reader_page->id;
>  	meta->reader.lost_events = cpu_buffer->lost_events;
> @@ -6167,7 +6170,7 @@ rb_get_mapped_buffer(struct trace_buffer *buffer, int cpu)
>  
>  	mutex_lock(&cpu_buffer->mapping_lock);
>  
> -	if (!cpu_buffer->mapped) {
> +	if (!cpu_buffer->mapped || !cpu_buffer->meta_page) {
>  		mutex_unlock(&cpu_buffer->mapping_lock);
>  		return ERR_PTR(-ENODEV);
>  	}
> @@ -6345,12 +6348,13 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,

IIUC, we still allow to map from user-space this buffer. So we now can have
mapped && !meta_page.

Then the "if (cpu_buffer->mapped) {" that skips the meta_page creation in
ring_buffer_map() should be replaced by if (cpu_buffer->meta_page).

>  	 */
>  	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
>  	rb_setup_ids_meta_page(cpu_buffer, subbuf_ids);
> +
>  	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  
>  	err = __rb_map_vma(cpu_buffer, vma);
>  	if (!err) {
>  		raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);
> -		cpu_buffer->mapped = 1;
> +		cpu_buffer->mapped++;
>  		raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  	} else {
>  		kfree(cpu_buffer->subbuf_ids);
> @@ -6388,7 +6392,7 @@ int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
>  	mutex_lock(&buffer->mutex);
>  	raw_spin_lock_irqsave(&cpu_buffer->reader_lock, flags);

In this function, there's also a check for cpu_buffer->mapped > 1. This avoids
killing the meta-page while someone is still in use.

It seems like a dedicated meta_page counter will be necessary. Otherwise, in the
event of a ring-buffer mapped at boot we, would setup the meta-page on the first
mmap() and never tear it down.

>  
> -	cpu_buffer->mapped = 0;
> +	cpu_buffer->mapped--;
>  
>  	raw_spin_unlock_irqrestore(&cpu_buffer->reader_lock, flags);
>  
> -- 
> 2.43.0
> 
> 
