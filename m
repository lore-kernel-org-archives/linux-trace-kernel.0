Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A452F4C86
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708480804; cv=none; b=D2QC3ruUB+bK2sKyGFxBh7++A63xglb0dxeG5sg6Q5JzYPqQSEzOqFi/HDlS/YfyTwn7hQWviWHylotfGa5SqNWQuYIWOEsdLFFZ0BiiBSRU+8KsE5GuggxzUVupBchqFgq7uIOBVknny+zlFr0erc+4m/BBEObhnjx8iR4jdQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708480804; c=relaxed/simple;
	bh=/j03kTBhHuYv5hD6MBKvEOxeLJn8lDs/sfflH1ChU6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=edKdxA+mX8fui2pJDBUnaTHpwiSgfcgeYbXy4g3WUzcUl/rYF+Srr8Yf6YU3+yvVv9WQ+hHcmOjQZePBNBxJbxOP2t9CdsPmIJd9Nsc/AzO52EG4WyAGk7I0j8kFiJur23/ZRo4bgvNPym4QtLlessMs3Xz876hp09OrE/WveEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=OTSfQgIG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OTSfQgIG"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33d6fe64a9bso971762f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708480801; x=1709085601; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B0Xfrtyc6Fe2TP/mvUkjSY1AXhIKwaD0TJ4vwwuvGxU=;
        b=OTSfQgIGlHX9tcFNUsWXNe4rSCwApq1CgniTDGp2dxiOYoGnaJX6miFKmwjsS9/4bQ
         sOtAR5+7SfyBJ4IPTjNhr1ciFet7fwQwq2URKUkR8ytSjtQyF+sQTu01yv+YWCkDlENM
         HtGor0vTfx2EmDAAcmqxoU70kPgex/LZlKLk3at80mLSIh1gq1x9PEBH0mkB1hY3Uw70
         +vUyD1+i2VRphTwYULFTi/llsIjgGZc4J9lUHPezzMtiy8hYYaQyTMcp4czEcQtWvVuS
         2H11p+ZWwSvuLwKQ5+WAxScCHIGr62Cm3dwZuApS1vhOkebIM4is464236mt2jhIfL8z
         acDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708480801; x=1709085601;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B0Xfrtyc6Fe2TP/mvUkjSY1AXhIKwaD0TJ4vwwuvGxU=;
        b=xO5PqM0G4JFfZX3sBCciiPdMXbX+6i7wR/9FAr270DPwDnAPK+m7AD0T8k9434JoIx
         yAyoH/R50783sB2DXJmbvuKiNo7Hoy2wZqx5c86NeRiBhr3jT/SXKaE0spH8lvwsAG/9
         VSVU/NRbskq6lvkM8THVF5LhGJwuexU46JC4wsMNnwQBn2jpTfYoErIMg/ztNGgFjuWt
         WuUQrdlhRk0CRwrcsYOsqczupSqymkUwaH4ZgQCpN16gyT1B342ax9oEBY9LQqZkOuAv
         vVPPZtmfy1nYpzUOgLJHZnU9Ov4+kY0OKMxLCiJU4jS4PgBtxGGoNCSSd2w2LSIJNufM
         jPvA==
X-Forwarded-Encrypted: i=1; AJvYcCXxefla/3lgpD0+5oDgdoSmScWvWqfONier8oBiYSU96YIK+MDoudKCQqvPSAcs9Yt6fq1g2CGQ5QXCAzyo8ouPKaOeCii7Nq33fscNqd41pHCF
X-Gm-Message-State: AOJu0YzHBQ6var7ZEVlAPode32ia+kuTlLe6+spTs0TsklkfjCq4iAID
	SpAyXVVBB1Dk0yVxQYFI7OBoKPYlG3yxnOk2CqTya2JE/jp242+bXPhW1EuJZA==
X-Google-Smtp-Source: AGHT+IHvBifN3KTXMY5XE5gInJfW2utknZtISjSR9rcpEniYiyxK6aT650VKdIao0/vIclIH/Pxydw==
X-Received: by 2002:a5d:64c8:0:b0:33d:545b:a74 with SMTP id f8-20020a5d64c8000000b0033d545b0a74mr7815004wri.33.1708480800941;
        Tue, 20 Feb 2024 18:00:00 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z11-20020a1c4c0b000000b0040fd3121c4asm16018618wmf.46.2024.02.20.17.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 18:00:00 -0800 (PST)
Message-ID: <1027d6bc-f4c7-4da5-bf46-3809b7c487d4@arista.com>
Date: Wed, 21 Feb 2024 01:59:53 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/ftrace: Correct wording on trace_options
 sharing
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
References: <20240220-ftrace-options-docs-v1-1-95448f535056@arista.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <20240220-ftrace-options-docs-v1-1-95448f535056@arista.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/20/24 21:00, Dmitry Safonov wrote:
[..]
> diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
> index 7e7b8ec17934..c79a6bcef3c9 100644
> --- a/Documentation/trace/ftrace.rst
> +++ b/Documentation/trace/ftrace.rst
> @@ -3603,9 +3603,9 @@ The files in the new directory work just like the files with the
>  same name in the tracing directory except the buffer that is used
>  is a separate and new buffer. The files affect that buffer but do not
>  affect the main buffer with the exception of trace_options. Currently,
> -the trace_options affect all instances and the top level buffer
> -the same, but this may change in future releases. That is, options
> -may become specific to the instance they reside in.
> +most of the options are specific to the instance they reside in, but
> +trace_printk, printk-msg-only and record-cmd are affecting all instances
> +and the top level buffer, but this may change in future releases.

Actually, it seems that at least on -next these 3 are not shared as
well? (if my tests aren't misbehaving)

So, just remove the part about trace_options exception?

Thanks,
             Dmitry

