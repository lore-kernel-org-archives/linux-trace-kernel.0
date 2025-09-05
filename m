Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27891D416E;
	Fri,  5 Sep 2025 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757114346; cv=none; b=pNJ3zLuo17FTsvHsiHRYq44c2JxAkUaLkvgu0XlyhjeJZQz2Bdqp2Pn43c911kbDwPd2Joalz9vwkBM9aOsuoQW/OnqbTWM8AwwTqRNCims6EuCQnfVpsnzFVJa68Sgp1WV3mK+M43v4ORSPBcrgU10pgL/NrLUx5PhDsOJDnBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757114346; c=relaxed/simple;
	bh=X4LWfw7XzGycXhNmKo5/oVoaXxnUZl7fO9KijW5BlEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6MlLAoo9qajd35sRvPBRgu6BWvIy5be492yA6IVSqym5VMx1n0ffRWqaG1+LLvRlPTcxPY36A+qM3eAU5AloMEVzL0+4KlqfIzRY45iFd5Li5MuJRIrEIHzJIfwG1fddpJ+Va7vo5235xYg8BG+4rcZSCW/gU0JFipQTKJMBvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwhbVKKW; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwhbVKKW"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b475dfb4f42so1559655a12.0;
        Fri, 05 Sep 2025 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757114344; x=1757719144; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eEMr+Cyrtz+r7sJA3C93LzdGGUEefqmRC6fYCHMz4Kw=;
        b=iwhbVKKWXp+q6zP9EswIzaGc/DJuHiZ3HBSOFEFzwz39v6d8rI/TzxTzYzcGG21ftA
         mLaCu2HvvbDU2D3Tqp4uanfAtZr+2wWt1OZGgf9SdSSSUCAEhcXI1m58EBRl8fyzQ/SA
         Iuyj8lO0Yi6MUcmvgLL+Ry3iTLu6GG2wADYpETtWpkJxhOD6oEoI00/O+USCANxxkbfx
         rJC8ua/OBc66xOQMVsckBRffoP9CnbHZJ9wgXU0u/XVz6is0byzVXmcehvMdDgC/VQKq
         XlUrP+Nyvt9lAcsLANtOiKNxpowt8ufDlqT7KedBNBB7NwsmN1v4vIzFTw90pGjPFbFB
         Wn6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757114344; x=1757719144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eEMr+Cyrtz+r7sJA3C93LzdGGUEefqmRC6fYCHMz4Kw=;
        b=lbN3mv0MAleYZjp79ICx8RiWTuzH/MecnkzS2HuTOTVJ/qQ6/7W12bzl5cF3wukmTT
         GTf+8Sr2GHP2Vm56gMfRaBjO1e+yzNlFrR6ErvEfXZn6eZY0AgWe9T6KXahnJonzfQS9
         h7oBV2eUHo7EzU8oZqfTF5VwjcyRhFS4gk/we8rjQFqfTBsP0lBqqZOk5bLt44nZ3Hud
         4jOJ8fvcCww5Hl7QlmeJCEtAoLhMnFscQUh/wfykR8jeF3QGupPLqQDXRnzrfR6eGfUD
         cLLy8pdFrmjp8F/ajMeDWJFXdu7FCmCtpd6/1067sNm2wET47Rs/KQzeptebDWeQakVK
         xy1g==
X-Forwarded-Encrypted: i=1; AJvYcCXPsU0jeRpM4vWoZZLca1r1GcoN68TGy7v5F2x6mgcYy4Y8pEM3UVZ0CUpBOKLDFNoIm/7xrbgLhLfyWRA=@vger.kernel.org, AJvYcCXdkvTHZaEQFYAVDRYIW/pjnfM5n7lvlityRa+bgfr9cdbYPcdO2QzmVVM1Zqdy2siWACl149+5j4qpRrVKVZEwbO8z@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtauppzu2GT9tyzTZ5lcm1vt8DH7H0kVjGN7d0ZQvqF1M/1nFV
	7wD2M5984gTrxT7r88BhDNr9evdFb18pCCHryxw1tf+dWj8Y1yKWPs1I/k4+xYT0
X-Gm-Gg: ASbGncv1DwcukXrie2PAWuv8eVHbUybHZVN6kPKeY09gQwkRYpjCZexNccag6OO7p7F
	toUEmNSszKq97paayFaNwsFFUvT+3hlbWTM2p83fqC7+Eb/t68UNI2nksc7w705PzFadoBy/qDb
	vKaMScpjYQ6tFil5295r18SQkQCQjBCsNQAr9/f8riGdTcHHOiw5/0++DvX6B3+TwbbMX9GGN0S
	cLusQfl0J1Tvi5KS18cpdhRy3/sU9U/MkrOdgMBq0zYZ9Ivi1o915O6n4NaTp5vnzXbpNlwvBsK
	tnFHCwKG2ZXCvsoWd7yThRFerrA4lbcxTjG3zxkeTpdXvV8wmfCIGWysWhflgrJuTXKympwdf88
	rxsbOsrpJZ1AViHc0YXhQlmtveH9ijz7Fyd+aVkEiBtzvZA==
X-Google-Smtp-Source: AGHT+IEZunIdMChKjW5FSHSQZiCMwnCx8dI9dYrX6AmOs+tl+Q4iKJiQQ5ngXBecvWeccL+lEm2Ciw==
X-Received: by 2002:a17:903:288:b0:246:cb10:6e2f with SMTP id d9443c01a7336-2516ec6f1c3mr5870655ad.26.1757114343999;
        Fri, 05 Sep 2025 16:19:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4b99fasm23306657b3a.57.2025.09.05.16.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 16:19:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 5 Sep 2025 16:19:02 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ye Weihua <yeweihua4@huawei.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] trace/fgraph: Fix the warning caused by missing
 unregister notifier
Message-ID: <9d6ee97b-5b0a-48a7-850d-de18d3107bce@roeck-us.net>
References: <20250818073332.3890629-1-yeweihua4@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818073332.3890629-1-yeweihua4@huawei.com>

Hi,

On Mon, Aug 18, 2025 at 07:33:32AM +0000, Ye Weihua wrote:
> This warning was triggered during testing on v6.16:
> 
> notifier callback ftrace_suspend_notifier_call already registered
> WARNING: CPU: 2 PID: 86 at kernel/notifier.c:23 notifier_chain_register+0x44/0xb0
> ...
> Call Trace:
>  <TASK>
>  blocking_notifier_chain_register+0x34/0x60
>  register_ftrace_graph+0x330/0x410
>  ftrace_profile_write+0x1e9/0x340
>  vfs_write+0xf8/0x420
>  ? filp_flush+0x8a/0xa0
>  ? filp_close+0x1f/0x30
>  ? do_dup2+0xaf/0x160
>  ksys_write+0x65/0xe0
>  do_syscall_64+0xa4/0x260
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> When writing to the function_profile_enabled interface, the notifier was
> not unregistered after start_graph_tracing failed, causing a warning the
> next time function_profile_enabled was written.
> 
> Fixed by adding unregister_pm_notifier in the exception path.
> 
> Fixes: 4a2b8dda3f870 ("tracing/function-graph-tracer: fix a regression while suspend to disk")
> Signed-off-by: Ye Weihua <yeweihua4@huawei.com>
> ---
>  kernel/trace/fgraph.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index c5b207992fb4..dac2d58f3949 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -1391,10 +1391,11 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  error:
>  	if (ret) {
>  		ftrace_graph_active--;
>  		gops->saved_func = NULL;
>  		fgraph_lru_release_index(i);
> +		unregister_pm_notifier(&ftrace_suspend_notifier);

Is this really correct ? The pm notifier is only registered if
ftrace_graph_active==1, but not if it is larger than that.
The above code unregisters it unconditionally, even if
ftrace_graph_active > 1. I can see that the resulting double
unregistration in unregister_ftrace_graph() doesn't really
matter since the error return will be ignored, but is it really
irrelevant for the successful registered graphs no longer get the
benefit of the pm notifier callback ?

Guenter
