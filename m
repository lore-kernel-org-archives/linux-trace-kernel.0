Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596163B7B6B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147084; cv=none; b=IjQ9OgZMBIfuFL92ef+77EUUeW123kfWX9C6ODMh5TLUAUY0Hue4z+gTK31M7a9qQlbT0S4w+NkqHLp3jbdaOeH/IkwiYLwk7QMzME6yXS5jRzHG4yOa2TWtXHLCcPF20Sxr9wjwsETPRU4cRSILTP16t+Fl16LkWskZuupgtA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147084; c=relaxed/simple;
	bh=AJSOjXZDHj/o/pVbZRp+OIJYhd2zvwmKYCPjs4w80fY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MqrguN6kxQIQGYiy/+bzDqfHAqLuicrJRGWtwCm8NQ1i/ZteqfNqNcJ1cLW7zO7mDdpq3uS9dorWuAicgpYFrFBpE466rZrjKfHKr5I4L/iR1b90/oDgvHN3+yvMU/5jefseWYPhuyR913wMo3EhiSJ6tpEeYOygXiop2JkIsMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xn3NYHoX; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xn3NYHoX"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd6185db7so729345e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Sep 2026 10:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789147080; x=1789751880; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2FmsgEl6y3i0C3oGLtZ2cN9LSp12HsdgI4FBDotuE0c=;
        b=Xn3NYHoXQeeU0HLIaQ8aTPzf63Ot1zY7sVC2S88icAnmuI4PWQ6UUMrgzEcpJilBQ/
         IbfUH57eI0bRKEnIDJYgcILEVXiGz14fJaVggqCKYbJr+DLJZVh721DxqxV0GaZxd3oA
         Z4tIkKnVQk0XOIif5PmYaqlKLDsYfEd6zLVJsoprV9HGLJep/Wg4gMA+NVIauZz3UWlL
         WpRR65pGSZbkaG/YhykqUGtkxl8CKp1reWaz33T4XswSovLqcTZb1cGxVicf7/ZPBukb
         HmTcGNQnc1NMU2NCuPUOxOqdOCfMMAayJKQPoFcurd9t+UND0hmwlrisc4vLkRqQJdwf
         lKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789147080; x=1789751880;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2FmsgEl6y3i0C3oGLtZ2cN9LSp12HsdgI4FBDotuE0c=;
        b=X38Te/sPmZjV1EOPo5mE2FvPyUQ4/BvQzkkNr/5LzpVTlTo4aO4lXO8jDN5kvX4bpt
         XymG0O53oszpYCAFT9nUc+hBQnpeFQCBveipYYRzSUipLx2Ce5inJPCK01O2wYxXMGhk
         XLfcHN2xf/HdTgn0uto1aAmbt7M5nCzgoXCI3ueXFp+XdCO+lzXzwAU3CabC+Xy7aF2R
         TPMJo3dB48mvnMnbzaJgfyn+nzDQlSeHQacwhHwMfx2uBdpgJWNFS2FozU3tbx9JXrzX
         qdPjZ/mlu/Ogxifh6Ft5w8z1D2oz6x1Ipj9rC7RkeSbTVoIymIg8fMRm3COzhME447Xv
         5zyg==
X-Gm-Message-State: AFuF++n71j7TCeziTdkcg08/baBlXyutjLmUlYFtWmLYmHm+ZCfXzViw
	8mqf+Et4oIPO9kDbn+PQKkakQtqymE169+H5Lax+m0GIYSu6kWw/fDvPYOOwwuYo9XjfCyDL1yT
	L9jU7jw==
X-Gm-Gg: AYBFou3c44LPdcvmfKscSTgHCMiuNUrdxFUWGRhegYsbBHx6e0TrWnYb/EqWgVGvhed
	wJnZz5jbnbQlkUkTQeeFSVcKakjNv77ESQM63FNIdgULZsgvF3HNyPWfLOXYOZlB003DTaegNHl
	SN9linRK+vWTTVQdKKu8g4cXlIDAEiwpFctXIP1glB2QbXpuuWT+pfWfrxikjm53+aG7hHiuG1A
	DJ0e6DxZZcC2YtruWDm9xLozfH+2jQ7xBT3t1voj7LSFkq1uAclmcj/gDqAYQn6Iug0ev/Yo473
	iy6uWJ25fS8vfFufhmPGAJH/zTNZ6d07Tlpm39hkdN0zsWKaYFL91hIK6Ii5lLcA1sUfC+Vro/X
	Nya41Xr+eo6wiXakA2o5E6Uilx2cYAe+NDTnvlwlbn6CMOCzqRkQiHMfqYOyp5UELSWVkGscL1v
	V1ntMmn43BjMlhpxuSn2Ut0UciE3udijcrpKGgRdSrZjLlaV2uZIbUybflbbhyUP3z66yGY+VbS
	Dq0l3rQ2kGPFBaA1IJinV/tmaD/1N8UGpSjjcKbGrY=
X-Received: by 2002:a05:600c:4683:b0:49d:1916:2133 with SMTP id 5b1f17b1804b1-49e6106d393mr64742525e9.8.1789147079818;
        Fri, 11 Sep 2026 10:17:59 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e69f02c92sm20593625e9.2.2026.09.11.10.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 10:17:59 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:17:56 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Clark Williams <clrkwllms@kernel.org>
Subject: Re: [PATCH] ring-buffer: Acquire the lock with irqsave in
 rb_wake_up_waiters()
Message-ID: <aqQ3xIlG9a1LlXbg@google.com>
References: <20260911102152.YEtwkBj9@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260911102152.YEtwkBj9@linutronix.de>

On Fri, Sep 11, 2026 at 12:21:52PM +0200, Sebastian Andrzej Siewior wrote:
> rb_wake_up_waiters() is a irq_work callback which is initialized with
> init_irq_work(). As such it will be invoked in thread context on
> PREEMPT_RT. Invoking the callback in IRQ context on PREEMPT_RT is not an
> option due its usage of wake_up_all().
> Since this callback may run in thread context, it needs to acqurie

nit: typo "acquire" 

> ring_buffer_per_cpu::reader_lock with disabling interrupts and may not
> assume that they are disabled.
> 
> Use raw_spinlock_irqsave() to acquire ring_buffer_per_cpu::reader_lock.
> 
> Fixes: 68282dd930ea3 ("ring-buffer: Fix resetting of shortest_full")
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/trace/ring_buffer.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 9c03a555a6ba2..681f9daf6fabb 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -904,14 +904,13 @@ static void rb_wake_up_waiters(struct irq_work *work)
>  		struct ring_buffer_per_cpu *cpu_buffer =
>  			container_of(rbwork, struct ring_buffer_per_cpu, irq_work);
>  
> -		/* Called from interrupt context */
> -		raw_spin_lock(&cpu_buffer->reader_lock);
> -		rbwork->wakeup_full = false;
> -		rbwork->full_waiters_pending = false;
> +		scoped_guard(raw_spinlock_irqsave, &cpu_buffer->reader_lock) {
> +			rbwork->wakeup_full = false;
> +			rbwork->full_waiters_pending = false;
>  
> -		/* Waking up all waiters, they will reset the shortest full */
> -		cpu_buffer->shortest_full = 0;
> -		raw_spin_unlock(&cpu_buffer->reader_lock);
> +			/* Waking up all waiters, they will reset the shortest full */
> +			cpu_buffer->shortest_full = 0;
> +		}
>  
>  		wake_up_all(&rbwork->full_waiters);
>  	}
> -- 
> 2.55.0
> 
> 

Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
