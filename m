Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A94E28467B;
	Mon, 25 Aug 2025 07:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756105545; cv=none; b=JpmnIyKRUsmp24wi3Z0oNC+oHYpxGPpERioRErfrQDGq7x2uJLJ0MoSUBz8gs5pFtxlZbTyMnsKP2C6gOGZCqbaK/KxcPk7X7WSSy2g2Vd8FEW7O1gCTZS1LhFWiRzsnyurjqtEx8yuLzlwAj+MQgxdId2jzgC2fI9N1+koZUBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756105545; c=relaxed/simple;
	bh=tkm/6qEwjSu74bSBvtDiHWELYCjM3Dd7J6nPKeUYbOc=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=PGFxAupP3IBN4nPiA4XWM7l3w2dVgVCw9pNRWw/V6/o+eqAt+wEaY7d3UEKQ4jMEjsNLhqw9BzhViEIWhGKk/9MFwNfdd7+R94eMy76h5VBLpYqoKuwySgX6t4+VRtstvPnkpdYUX2l9JHLcdcpz55etdAuJY5TZQLupDuyP/hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DJRPdLCD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJRPdLCD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64551C4CEED;
	Mon, 25 Aug 2025 07:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756105545;
	bh=tkm/6qEwjSu74bSBvtDiHWELYCjM3Dd7J6nPKeUYbOc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DJRPdLCDOOTQ/kfrsxtD+HGkpD0mC2XSOSGvftvLNBQA8Z0TI42kuU5pfMRcCPk+5
	 4gKbQNLYMAys/qKiqB6kq+MMzO7NRKNlUZssXQH0lKFEXnvBhmZ7SvYUAe9dScMx13
	 ZUGWNwVfVg8n6XStM+ME7ZD3SsK6apvkPX/Kaa3qghd35nv2VmzlpezFPgPK4t6dVB
	 Leri1I9F47qyrjZf3bvfuaO3kjbUl/R8Y1/Zu1sw/OTXzlxDwudpjEskt5MZhehewM
	 tjJvy/qFvEMQAT0ZJn/Ycs9lVAj5Iw0XPEejfNfcXZKR+zradjkRJXOq0fbCTuwWAf
	 QxPrEX9sbkv4g==
Date: Mon, 25 Aug 2025 16:05:40 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probes: Replace strcpy() with memcpy() in
 __trace_probe_log_err()
Message-Id: <20250825160540.9a5272a8a93a789eb36a7098@kernel.org>
In-Reply-To: <20250820214717.778243-3-thorsten.blum@linux.dev>
References: <20250820214717.778243-3-thorsten.blum@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Aug 2025 23:47:18 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> strcpy() is deprecated; use memcpy() instead.
> 
> Link: https://github.com/KSPP/linux/issues/88
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>

OK, looks good to me.

Thanks,

> ---
>  kernel/trace/trace_probe.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 5cbdc423afeb..d3ba5869d32c 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -214,7 +214,7 @@ void __trace_probe_log_err(int offset, int err_type)
>  	p = command;
>  	for (i = 0; i < trace_probe_log.argc; i++) {
>  		len = strlen(trace_probe_log.argv[i]);
> -		strcpy(p, trace_probe_log.argv[i]);
> +		memcpy(p, trace_probe_log.argv[i], len);
>  		p[len] = ' ';
>  		p += len + 1;
>  	}
> -- 
> 2.50.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
