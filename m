Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970E23A9B3
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 22:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762814479; cv=none; b=mSaInMEbqudOECT7a4B0a6NmCmjNwpnaeyyE5BI6QW1PKy2PRXFkrBRzWmHVGDr9bf7nJE7Oxsjrlg9edw11ZR6RrGwB4XEmIIrmyN0C9kZGIC0ferWBUrDEaxJPSf3SAZfb9C06r0JKvHuyJln9qfl+b1+as10blIW6jHh6AYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762814479; c=relaxed/simple;
	bh=okNOORu/lmN5UNbsZPnsNSLoAA0dk4lTm7t688EICLU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tTOqOrwKt3AgX17smEdAXgIVkM31JC2K03XszyJmtnEwSSqRu3x2Eh280h0GQqmh/a0hUV5liNoTQ9Jn34LvpIHrymVvo7z3dKB2STzy9n3XMiTyR2uuR1YOAhbZkc0aqwSvs7wuAO4ZGL2jLqP1T2r78ijOfjI8Z28f7yUvCq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mI11pCJO; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mI11pCJO"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64088c6b309so5646224a12.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 14:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762814476; x=1763419276; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hy3DRtjQseWH8sSySHjHEiCHuYld/nXxCZdq01rPWwQ=;
        b=mI11pCJOXZWW2p/wPWf+tBiAF4qxoV3mNy4+tXHlw0upNIqm7KVCA0OmXZB2LUBkXm
         rzt6XTqtIjmSZe0ja1/JKOxYLdytUZDXeWigVvkaSU7+RFbx4RJsbOi0J3V9/h7L6r8V
         dKNZAukz28sOxzL4OcEowGt8BHk34dSEi2lXACTlRg4FOsjO+pbsLshyyfEfAGvp4gQt
         jzqAyZf74wxbTKTY+Hv2sbYg97Njubyh+GtCCSA8RyBW+x5/5Tv6u0mI5RXCiPQSlWfM
         n36g9oAjkL/eu0ju3/tnh69vSjKZFnJnJe3M2uc07IKbkj+Z59q1dL6rI93EuWjigF/y
         t0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762814476; x=1763419276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy3DRtjQseWH8sSySHjHEiCHuYld/nXxCZdq01rPWwQ=;
        b=lEMH4GOElDHztPMydX6udOyenLbjdPJvzwdkhvKnPod1GIBPo9LSHU8HPnR9Yfm5M5
         k+S56NLE3pa1kcvI4f6Qu88J6aOb/UEhep6FQmbcPKHf2dVdzGht8XSeNeVtuPP54LH6
         sk0aLbKqFlo/9l8E+uhLWMkpvknC40EtDiWWMv5xAbieTfZtBMtFH/QJ72nUxNFit3qF
         KP78wWqL3EA9qCWgf/KkiIkPDfuNRcRLwCZXGtHtBoTFQnxaG1AvAzX6Dp+s6fZjc8lX
         ItiBHXf53HUnCPRqMsfV50DQDN1Harq6PmAXmJSSnYCfPPapquI5WJu69PVzVV0ueZKF
         AWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7sgB2RckeX8P5/+dlMXawe/EW+GxYwEtsGgrftGKDp9EpYCk7koIHLYvjMZHF/VQG1hZQhijfJhbQVOwouZ62Sl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyy52PKC79+Wvo+ehgfXJlFSsnLC7ObSAiJg3NGC72PNS2hCOOO
	JZyIH+USmmEtfKU3UzAT96CNjqf4NRlZkeexokMcaC5gIQ4TKyVzjznC
X-Gm-Gg: ASbGncsmakBqwB/hO4fR/1xY8M1XQWvdf1DmGFBxCSwkP/OXPh1JdOHMsWE2chDTaKS
	4/5N7shgrTlBR+Cv3T9VlqtykowKQ5YHrramSdigM0tKaObuq+ozmGg14I6rvpgnhacPu3rUL2e
	hm9se8au7/AUS/6gvpSNwDrRRW7Gd9fDXU3mGcl7etYQQhQq9qD/eEjK6QYCDX3REI0VNvq+xmW
	6yLJHBzFQ8NjjrN9bdz24uXBN5mWcnk0FJAMlifjVtv3Oi0Mc1TinaiwAK+V1izmzz7ECK0T9k1
	y4QQujyUqdyCNu8V7Zqw8dOhjJA/RO6Ooybler4vDBfZ96TDiAuZJ0ZwiHK/UQyLM9PPzZBQHJ8
	H+VkKPo+Z6LkfDYcLdPUv4kyXISlBJctPBr3duz+Ia07X2QIpLikUhwUsfJ5iCc+0mzTzE3OZM3
	zt4WN+gZzI83D9
X-Google-Smtp-Source: AGHT+IEdCNnJArmT88Dy24wvZrQSZRRx6rM0pDkfV8nrA7AwoMe17Vp9sJfSj0pDcqFVKzMMqcvg5A==
X-Received: by 2002:a17:907:3e08:b0:b72:5a54:1720 with SMTP id a640c23a62f3a-b72e058f3acmr1065004666b.57.1762814475569;
        Mon, 10 Nov 2025 14:41:15 -0800 (PST)
Received: from krava (37-188-233-172.red.o2.cz. [37.188.233.172])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf9bd72bsm1199771366b.49.2025.11.10.14.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 14:41:15 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 10 Nov 2025 23:41:10 +0100
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: rostedt@goodmis.org, jolsa@redhat.com, mhiramat@kernel.org,
	mark.rutland@arm.com, mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH] ftrace: avoid redundant initialization in
 register_ftrace_direct
Message-ID: <aRJqBkYtMAhhO1yQ@krava>
References: <20251110121808.1559240-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110121808.1559240-1-dongml2@chinatelecom.cn>

On Mon, Nov 10, 2025 at 08:18:08PM +0800, Menglong Dong wrote:
> The FTRACE_OPS_FL_INITIALIZED flag is cleared in register_ftrace_direct,
> which can make it initialized by ftrace_ops_init() even if it is already
> initialized. It seems that there is no big deal here, but let's still fix
> it.

good catch

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> 
> Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
>  kernel/trace/ftrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 42bd2ba68a82..efb5ce32298f 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -6043,7 +6043,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
>  	new_hash = NULL;
>  
>  	ops->func = call_direct_funcs;
> -	ops->flags = MULTI_FLAGS;
> +	ops->flags |= MULTI_FLAGS;
>  	ops->trampoline = FTRACE_REGS_ADDR;
>  	ops->direct_call = addr;
>  
> -- 
> 2.51.2
> 
> 
