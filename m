Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794621ABDB;
	Fri, 18 Jul 2025 21:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873893; cv=none; b=YSz1vBaUmR44utFjOFv7Erw8Plqa2eO3WXnacKyaasY8F3HyW2+7FsHR/Mohw8Vfqi9q4tEG226Aj3+czXx5+Avz3XWjMO0HqUdaYaryi/VEBqBTG64snzoo+4JtpS3/Tlxbhwd1AOPmrYR88lchkRJnXzLpYR7dLs6/2uVaNg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873893; c=relaxed/simple;
	bh=im0LTQLxPAOeG/77Xo+4Zf+M8+BWkj92FwbmNijiq08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IliCpP/RRBDRqmHy5bEzfLt+XHCXQjONU7XPQAhFlkGF5SKxEC9uCCqM2TNTLRM0Pa5rOpdYKzUC5PxqLPduKRtLGUOfpOl4wpnAmyJhEUNb5KraO0SeEnlKHwxD8tERznP4nopsLdwKYXruhrZK1VwGmXLFKyi7N5a/ONbiVkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XlSLolAD; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XlSLolAD"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4f379662cso1863132f8f.0;
        Fri, 18 Jul 2025 14:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752873890; x=1753478690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7hWuC5RvJazo5XlM0dlOAfjH8Jrh55sZo4UkN4XHdM=;
        b=XlSLolAD/CfbcXSIDd01xnSLNjupCjJUOaKh40sqFmQNm4ChOkgZuSrF1iq2a0qpMr
         vD778I1MzufPlWz9y8sZW7ZtM1G1ipYdQZQyRfus5rfVaC7pZCvVFxYgRB6g43+OgvTl
         ToS9GyFLknEFkmkPXKyXubNNiTfG5fVVLQ5BPxu3uEnXEu/nGMttmwflvZalCFwL2fYJ
         dP4dge3f2kIsC+F9G7SRmpB71PS82USUR1YwaavavhHO4GM1KK2EtYwo0bicJA3sYqmF
         x/hzxStKeW/0IqIF9GYTZyHFfda6FHHiJgVrzOMjOEWN6MwMzphbiFGigyVLRt7yo+tu
         tm6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873890; x=1753478690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t7hWuC5RvJazo5XlM0dlOAfjH8Jrh55sZo4UkN4XHdM=;
        b=eFkgUZzuXrILZdSrkYBS/ACxPOsajUacAVzF2EXLlpRAFx5BUNtL9lqCtsFuvOERWK
         b77dtI8mm+g/1IMrJCcZfj/NDYNLXDnr2D8GNJS4HZo0D+pDWZyJ3dcPArqa111M2ygc
         ogRXzeZ8M7sihFJV+zKNxQ02+URajqTX6MoKabERJs/rlSWHHKzhyqzuRf+P/jDIZB//
         NfF7yytiZohF9h41VSa70ZK5cYf4k/1EzpORVHMC8uFrppdg8Dw2Nk/+45Gp3KjyRNhv
         fPAh6dvUAXLN72uLKaNmmoI86xH3DUUD5ihoK+lHyEKH8+3zrptrEy/12S+AnMrepZEd
         HgoA==
X-Forwarded-Encrypted: i=1; AJvYcCUacKEdYLhFX709QVcdLyFD51AbnUxFIKByGfFlbsAOzwr1j5VJTy3p5Qyz0kEsuOaHGO6MQf6CEwwnIa5ROJM=@vger.kernel.org, AJvYcCWNbwC6HMldE5ozx+02HjgpZGICNXyRCVb6mJk7RdTLz3lekiKdopuA6exZX3I4rZUxHcpCggpHhJzEg9ZaI0QgsYwa@vger.kernel.org, AJvYcCWzScDZo3PM6x6KOFBNRSj6748qikWX7gnd4u9avhzL5v0XEfDzPdv7MfyShk5TwU4H5BjymscIdSqw+F2Q@vger.kernel.org
X-Gm-Message-State: AOJu0YxDZI0cgw8Qp6yZK1Z1bxgT7ze/6eq2maStGqRk10rVlwY2ScGK
	NBfpneIXddYWwDs35xR7K8nEAFi0+As8C3MEdQpjtYqVfpeLn3VnL2tL
X-Gm-Gg: ASbGncuYdHQbwKdTT/lWPF/z9kLrwbxdZzCMl1W5rsX4IhUClv6UOmoRoYZLKGVbMcX
	r+p/DKXswha3MBgeRlVjP2CJRp14cGNMBQ/208t83vOS7ygQSq4/lUi53JywmH/Ej82uipmCO+H
	AD+0traRGxoPREhtmJOmMpHXvWi6UyCwlLayOID2i+K//pAcchQ9JvVcrfSyNaXyJgXrDqCXxP9
	OvZOpqDK5CIcSH/fkdAdXBq9sB+mWmzhLKhzT0btWeFXr3jDq/FO7538B2RXUWQ/v3RUIu89EqZ
	cb2xgTzv/9y/wiy1YRBqbOkS46bPAq25ZH9sdLM/1YL5UfTuvGuPYW/1dcc0lmVpDjQBAx34qp0
	aoOXvA0ICdDWr6A0oLq1dgc9iSl7k1Z2AuCmtyAr+PY33zpP7mFDr9s158/a9
X-Google-Smtp-Source: AGHT+IEmq7tvpzQGV1xWuIhLQqWelIwDGHeGg+CQxLmril0favWmgaefoWQjbU1qA85RWMATzxD8Bg==
X-Received: by 2002:a05:6000:2285:b0:3a4:f7ae:77ca with SMTP id ffacd0b85a97d-3b60e4b8585mr10851424f8f.3.1752873889957;
        Fri, 18 Jul 2025 14:24:49 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca4d786sm2928732f8f.72.2025.07.18.14.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 14:24:49 -0700 (PDT)
Date: Fri, 18 Jul 2025 22:24:48 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Colin Ian King <colin.i.king@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ring-buffer: make the const read-only 'type' static
Message-ID: <20250718222448.13162080@pumpkin>
In-Reply-To: <20250714160858.1234719-1-colin.i.king@gmail.com>
References: <20250714160858.1234719-1-colin.i.king@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 14 Jul 2025 17:08:58 +0100
Colin Ian King <colin.i.king@gmail.com> wrote:

> Don't populate the read-only 'type' on the stack at run time,
> instead make it static.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  kernel/trace/ring_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
> index 00fc38d70e86..39aa1f50274f 100644
> --- a/kernel/trace/ring_buffer.c
> +++ b/kernel/trace/ring_buffer.c
> @@ -4118,7 +4118,7 @@ EXPORT_SYMBOL_GPL(ring_buffer_unlock_commit);
>  
>  static const char *show_irq_str(int bits)
>  {
> -	const char *type[] = {
> +	static const char * type[] = {

Better would be:
	static const char type[][4] = {

  David

>  		".",	// 0
>  		"s",	// 1
>  		"h",	// 2

