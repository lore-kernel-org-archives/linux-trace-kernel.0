Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2D448CD4D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 13:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332591; cv=none; b=OfIflXOpJGxgrOnUBM21VX9PKiiSTRkCQHfuhjWrCpRLaZSvYFVR5vl4bY9Y36XL3rAwmQLWweHDYaKpDivS86OK4dstirBecUc7tHgKEV1A5x70hJ1yAbFDDW3XjnNM/uewkkN0ng5rkxvaMAC9xETxhI2gaAqdD/yG7vffuzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332591; c=relaxed/simple;
	bh=+gJK3BwSpyFhDDaNdPXswq/7YJxR+px+lu6uj+7KSQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HX594TYxtqkO8T433RttCKhAKcAysVPdrAEmCupj+oj9aK6dCkek4RGkZi+UmaFErTk40w3iGJhQ57AYkmptYPJLWf+xjcGUBPE1/tDSN854lGUC7Ey0Sx/4yfYzncCerlSdWUk8csdLvB27tkFrTCPAKr964IQdY3M3hlA0Vpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JnlM+cEh; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JnlM+cEh"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698a9f11776so1406419a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Jul 2026 06:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785332587; x=1785937387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SFiNpxZ+iZF1RlL3bEx9qW7UF6d/cY/lPK5ipIPyslA=;
        b=JnlM+cEh4DWUnZGDGUai24zRbhn6aFuSeY3fWHMjzoPzNtweS+UHlccrIe/YRbhQF8
         5X0EuyGk4fi6KKFBArj+nLMVzLMqf8urNwpRYAI88NEP9VHvbuCo1nQ7EOUmj0huHcy6
         alPCaj8rJ+oMOZtqdGqjhUaTliu0nQZ4QYhrNqVzl4T8p4Pq0MYPdQR1cQtRhgEASEnv
         0awGNqlDmEqokHXPVsHI2JZxcKkpE9Mwjiq/bTHUVixQVAlAAJXQu1tHLMnCgJg82pYO
         8R/rswWXuv/SNACKBvAXSTt5BcD3/v0yqaMPAfT61s9OXHYp/stcch0RjQ2zQAyS5rKc
         yQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785332587; x=1785937387;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SFiNpxZ+iZF1RlL3bEx9qW7UF6d/cY/lPK5ipIPyslA=;
        b=q/Pxk+RqrxHhn0jq2+LCVmb0FgAWTPvAuTuym6QSv3/ctgNWQHMhZ/HhusLm95UEB8
         EuX1G5x2XG8cdoY5Jnz6zBTHBjHiDykpDXBgtg1uhADvUd4cbxpbJJCkhhmQf6Py9/GS
         fnFz4VHMrNmAk9I4/R45Xwa2DEHnhOUiexoLJy6QICk6faTbFGdbF4ASDvAsswj2/JqE
         GehD8n17JxaPrpkmBJPFH5DEGINazLsNGEdjLpLCtwP//o/7lGT4XyAruA1eWhAaXOZJ
         PyRwYh7HhIKR/4Uyq/6e/Ixn/JHMrGPbrnuc6RfHFp8jLUwk/Iz/otLTZ4c6iHi4ukUx
         Fg6w==
X-Forwarded-Encrypted: i=1; AHgh+RrAPjhNJzVM6bkfq7LNw8rnGTihqkmgSyBQwsoOy58/Kzvp5xERkLS5cePLwyvwG3Pl7H4tSUXrZr0+8B9m6tIdFOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyexEg5RzDNfYh4J2tiKS+BAM6YQd/NGdLRTNyhKXdmhN9AtzXu
	RtABnGGcUiJvABAgdYxtoHQG2HFs7nxprmdGFD8M0HQKHmHCAxDcsZKkUBXslK7//g==
X-Gm-Gg: AR+sD114L8dwukxfmOCruYVDcMGPcI05/KVhZ0cjRjFG+Tor9V05hsd83n4t1KYRmrM
	WWeHo9QgO1FYeWxzkf97e2hev75rhwEo+IK500gkaA3DdNB+g+78SoOFLzt2E6ZicRgo/X8EXsX
	TC01wVXs1JrDGYwgX2tgk4s7u4ryMuACDUFXPeYWqWFsSgOzX3oC2v5IxChJAx93tm+OibIfj8i
	tHUBWCx1l7rWfO/MIKEAWvwws3KL4O2R6htVm237t2uGGps/qcLXchNPTOxEOWsj45hXIF62gxD
	3chJPJnJe5t7biDJ/DPQSiVmgWOiMps8ToZrkMehCr1qbC1qNfnVsxailiR9uyJQGrR3pjC80iS
	9qdOP5v0LVnItzIKqQgLvQW47dJGOu6RC7nkAdbdr0RKenVjf4eWIkKtxkwMWN6KZNLMI9qxmoY
	/JQ95L66j9rJ36QUb0JIU9uqCIjIYYJ8APsIzroA6OoymBAS0izJnhcKT2tcGjY8NGzXt4YzbGm
	64=
X-Received: by 2002:a05:6402:3216:b0:698:3e08:29f8 with SMTP id 4fb4d7f45d1cf-6a0349ec4f6mr4023154a12.11.1785332587000;
        Wed, 29 Jul 2026 06:43:07 -0700 (PDT)
Received: from google.com (14.26.78.34.bc.googleusercontent.com. [34.78.26.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a050c5cf21sm868268a12.21.2026.07.29.06.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 06:43:06 -0700 (PDT)
Date: Wed, 29 Jul 2026 13:43:03 +0000
From: Keir Fraser <keirf@google.com>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: rostedt@goodmis.org, mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
	kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: Fix reader page read offset for remote
 buffers
Message-ID: <amoDZyrT_Y8PGSO6@google.com>
References: <20260729133609.4022734-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729133609.4022734-1-vdonnefort@google.com>

On Wed, Jul 29, 2026 at 02:36:09PM +0100, Vincent Donnefort wrote:
> A page swapped in by __rb_get_reader_page_from_remote() retains its
> stale read offset, causing subsequent reads to skip events or read
> past valid data. Fix it.
> 
> Fixes: fbd1743ecba1 ("ring-buffer: Add non-consuming read for ring-buffer remotes")
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

Reviewed-by: Keir Fraser <keirf@google.com>
Tested-by: Keir Fraser <keirf@google.com>

> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 804ccae694d2..78d3875a47a5 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -5783,6 +5783,7 @@ __rb_get_reader_page_from_remote(struct ring_buffer_per_cpu *cpu_buffer)
>  
>  	cpu_buffer->head_page = new_head;
>  	cpu_buffer->reader_page = new_reader;
> +	cpu_buffer->reader_page->read = 0;
>  	cpu_buffer->pages = &new_head->list;
>  	cpu_buffer->read_stamp = new_reader->page->time_stamp;
>  	cpu_buffer->lost_events = cpu_buffer->meta_page->reader.lost_events;
> 
> base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
> -- 
> 2.55.0.487.gaf234c4eb3-goog
> 
