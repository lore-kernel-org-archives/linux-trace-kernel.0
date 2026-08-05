Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8EF3F1AAD
	for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Aug 2026 16:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785947819; cv=none; b=iJWjyTtAy3amroT6K91rkzpeUFZrtkFGPp6ox20eukok5LZpdXWFyDoz36acABBrPOiatxwbfqyzn13zthWcJd0JbiNDIWyYm9x62PxD1ycEQoGwaU+67vem0T3I+cCGeC6Qd44sEdeH+WCo38R55gw9RPqwQ/opPp68fM54FaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785947819; c=relaxed/simple;
	bh=NKXrbjm/zMNFvvXbQ+/jm42iOyhabs4DLjHwCiwQ1kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDXhm60wGHatQ85fbogIkxeWQNLN7HQn7xN18Vt/k0pZDxBPTqyMvsgOrRLYk+m2zaT9vwhCGezKPrTkYdljFz6RqWwd+govaRQl8perueSHYHU5W37bOERpIHWCh5NXbDyuLf9WIquqSATWtIpRLkZeEZSNNtEbJdT4HK2e+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wCLwgL12; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wCLwgL12"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4956242332dso9565025e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Aug 2026 09:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785947816; x=1786552616; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/axujK7LrHeb1d0FXfagnmvZblyReIfTbnI7OxB4cHo=;
        b=wCLwgL12wgmStfdWh1cGuXkAodlB3wrHjsguFKbKVCxmwyKGMbdnewc9o5clh8hcbP
         6oEGmfHC3KnZSQeDV0Lpy+vOtPTXLGowP0gv1DudgSlcqbyxR1HZ4UzgiT9cfyWLu9kX
         BaoUvEjRCbVIExapCwYXmEdEhQMUY1GSsdLgqcqhZVpL9yvj/QNKqHigfDfjBkpcq8/o
         eTUcRAl3b4pQVXJ6KKqu6PKIyflUblVKLZsYTacxDxn3EAWiErKnkT0jHwIEEyGo/BRr
         97uhZIGVjIQj0hw9MUso3UvBSK/++M26FxmtyZE7P1wmqmpkpgKdFrfUOESotMWGALeN
         j5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785947816; x=1786552616;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/axujK7LrHeb1d0FXfagnmvZblyReIfTbnI7OxB4cHo=;
        b=W/3ALg7zorQhzpbpLe7Sk+kMGMAYKAvCcoU9yPv7Sm/SGeSuqX71YxrPuls1PTl9t+
         N1EVnqbYNILgutK8WW/+fEZzTiA/XjIsIxNfTs/ZL+uexG3hEVIaytb9EUbKllyIjkzK
         swHxOfMlxjEkS/9IPBLJmDiZai9o/gXiwdwvQDjnBvDYB9dG/nlDzf5ZnLP81c+CQec1
         Y2MCq8Kl5bKm+ie52cgRMjPDFtf6IQW1iLwBDBPASx6WzgOBYr3PuSRyIBaxQcIXXbAp
         km5cikYQwrzeB5ZmuuTb+ULY5t89IntLoPgXmAp3t7vibXaWUcYQPHnjj1xob/rduYAA
         wO2g==
X-Forwarded-Encrypted: i=1; AHgh+RqUkZxP/G3SeEYHi9YYwVeEPohL95I/CbSyT9NtVfjgJQAJHqOol4CKKTyRydsmnNpLQf6EoLQLsIn6djjcExpgA+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUkiMe6qu4iteTQWtlQwOf5RBpnpzDH/VDD5j5N/rppZ20eoj
	b5nHy9lr/GRHTayMAoVjZHjFp72iaFiy7eytWbjiuyuETMRebuvU9tThn7Tikd+1OppMwYdfolO
	TB1RofQ==
X-Gm-Gg: AR+sD10v5Izc+OfiFyco+vyWcSriw92+2GVMNWA/9OqPcf/MbY1stDjikSZMnLDmSDZ
	4oEWdYCKmb72HXBB3Jon81YosCVUGkjMR6xOPOOIYu7MZCsruZSA7IkDqFvKazClSPF1anxXBDm
	dD6IUwGlUMan2IN2TjyfG6EidBMCXAFJMIknSBjCUEK5ByD5zi71/K7q4qENzwl5xti2UXpa0r7
	3lF6tMILYyfnUz7kSY5TdItfHiiSFx7k1rpiUAVC67Mko+9s5BLb54Tb8YJP20RkqhIoGMtwYwu
	/sCzOrMgiqTeryZrHcWjAxbWyofYrB6nWaYgKFvLoJmxtAZLlm7/Ss4V3dKhP1nlN3PkNctwbU0
	cdcLcf/cK37uqpAZhbwiu6pxs73jFBRaHwyx0CtmL0WD1dZ/DtjaNf4uBBDOp2zN07AwHv1ljYv
	+huwLpAc6VCYKw2kLKQOIxHF9LKpQrC2MXsX0Pr3JtBI+ZwTgJhrXnkRMR67CUxUtCXkbf+6URc
	KUij3GQjxSEvhPRqM64WlLp9GZwLMXH
X-Received: by 2002:a05:600d:8489:10b0:495:4749:16a7 with SMTP id 5b1f17b1804b1-4994e7c5e9bmr97339835e9.14.1785947815752;
        Wed, 05 Aug 2026 09:36:55 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e035900sm103071685e9.11.2026.08.05.09.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:36:55 -0700 (PDT)
Date: Wed, 5 Aug 2026 17:36:51 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com
Subject: Re: [PATCH] ring-buffer: Prevent subbuf order change when resizing
 is disabled
Message-ID: <anNmo6KLI697zYJP@google.com>
References: <20260805153225.2096152-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805153225.2096152-1-vdonnefort@google.com>

On Wed, Aug 05, 2026 at 04:32:24PM +0100, Vincent Donnefort wrote:
> Because ring_buffer_subbuf_order_set() frees buffer pages, we can't
> allow it when risizing is disabled. A non-consuming reader is at risk of
> use-after-free (rb_advance_iter()).
> 
> Return -EBUSY on resize_disabled, matching ring_buffer_resize()
> behaviour.
> 
> Fixes: f9b94daa542a ("ring-buffer: Set new size of the ring buffer sub page")
> Reported-by: syzbot+e0cc44465d6bae735679@syzkaller.appspotmail.com
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 8e2485bb3aa8..414bca2121a7 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -7358,7 +7358,7 @@ int ring_buffer_subbuf_order_set(struct trace_buffer *buffer, int order)
>  
>  		cpu_buffer = buffer->buffers[cpu];
>  
> -		if (cpu_buffer->mapped) {
> +		if (atomic_read(&cpu_buffer->resize_disabled)) {

Ha, my bad I forgot that mapped is not just "user-space mapped" but also
"range-mapped". 

However probably the best is just to record_disable range mapped buffers in
rb_allocate_cpu_buffer()... especially ring_buffer_resize() doesn't use
cpu_buffer->mapped

>  			err = -EBUSY;
>  			goto error;
>  		}
> 
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> -- 
> 2.55.0.571.g244d577d93-goog
> 

-- 
Vincent
