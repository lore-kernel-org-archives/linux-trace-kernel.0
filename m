Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD623ABBD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 13:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761659682; cv=none; b=iJdJX0ZoTzwuHCwrFLAOYcJ4OvGM2gaiJlPv74h9xszpqq2sa9I+CdOftZ/H4j6aouXT+O6UPes0DWVzu0yDweAGryBOfYBcVmwbcUcmaONvPvCFmyGMnK31B+Wnjn5XaoYu687hAVigEluVwySgC6ZVdP7XjxC08g4K3T4wCsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761659682; c=relaxed/simple;
	bh=jSd4hcS7xop9ZuK0NsOQ84M/HWN04CoJ1NRFNJlY0hM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L4H5k98MctlyM1DaTDP0gLWY+z3VA9ulT9sNODMrxMR9OEtAqLQWbxQclfJNAm5/zk5WXr7hD3ALmYbxRQQyB7bLr1z0VmOfh98UgixgY+wqVNb3BVNiHxR1lgDOtzhABYAYdRx6+aLwky6gJlhoXYSPUV6Y+yxAuA+R7VkJg/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=3cBvKpa9; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="3cBvKpa9"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-430d7638d27so59812975ab.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 28 Oct 2025 06:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1761659679; x=1762264479; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vr99gX2aBwJu7kf6ztY22NIa238ykp6XTngN2e+Qruc=;
        b=3cBvKpa9JmgeLjstIEf+J/VUZ+v0sbh9Er8gI1w4+8Q95yZzgczN8xaEoY1ncvyGsK
         XUjrLualq1Dm5pPztchhu5EkbdRzfjp8QxMUOKAj38j1SO1efb/KJIEPYWErTMCQFKfA
         cinidTqquiqSeFnJaL6ktSVgHHGqFKMc/Zk385jllWtLi/z4vNJSFhTCcfosOyx3vlb/
         6U132VumGnwSDsj9jWKHsjBl7s+JmPoQkhXzJ2tshpMQ8YRPqKzM1lJzN8A7gy2jXaVI
         BA27vVLbCS8rnZ8CFbL7mWhwlojx5XOu/ufsOfv+kETNR9zNKOQr4PhVYUK9N3H4x1+A
         PRdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761659679; x=1762264479;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vr99gX2aBwJu7kf6ztY22NIa238ykp6XTngN2e+Qruc=;
        b=tYZWxmu+8Mvbqum1p9Jo8GKy79YIrDH4ApYL8x0WWV1gDcxPxMXS3+6HLwA56HEj4r
         18OFpXWbaMD1x+E7fg7ArJcq6UxSrBnhPUuor6QtqLna5GWhFqVBpnpTtXbRm/p0lx0O
         RSLfkp18tYELSwFCG18YsKHhz7BzZeb/s+LBsCjYSzeaMXsOTwy7T8MQfzadSW4EO3vf
         JLSabxspJmTvAYXR9Q5t0y8lp/EzlhooFU1yBVri6l7VDsxc5kMei6gnhrq+OMOlq1nH
         4fP8GG5IkPm9kG4/ftGbizfsv7dZPKTZoKUqcEGKh4RWaiyC5VCF/hkDDd28Tok3wp6r
         frng==
X-Forwarded-Encrypted: i=1; AJvYcCWcfsG6Qkv1x0AXiVN6Qn61rAwNwj41wFrhQnMdQrMK0xHRiyTS2LMi9e3bRQifhLFU/YeyJDBMu+6pRUNxpDTB2bU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMqJ/2C6IM+pUMkfXHaAA20GsvKXoLLOm0i9HKhEXUkhNhTzTV
	pzsCaOBl8LmYsLjB08ttGlOCUjaTl/vz73fLL+UnB4exgubGZ9HZkY2quvtHLtaNP6HE/AjIfFf
	+M0jJq70=
X-Gm-Gg: ASbGncsJXrXgZtJHTu3tU+542JQIG6ROH22RVEb0HnTwKLgjim6rYwCSzL+ys+z+qQY
	+yq+0jflIMPfJeezGbjOjwcZjvobwvHp7PBj8+816U0SugGT2owUBKPJYqtBRy9uBpGnrNBUZn0
	eJx0LkvBvNPuT6zaY/M3cJMMzP9xaRuBZL0/0XPX8rU+g49ZmTIe68xovfqUFnd0XRpw17Tg72R
	KkXgfubZSWF1I5HwoNpoH7GkkuSW+MkIzX3SNuuJCcjZBYDd++1qjSkksSpcJQC4ahw8sKch7oE
	C6ZO9jz6/b8XDSp2Y/4Y57F5D1dF2rlYFotBd03kT2GrBSW2T0CNT+jeULFrDvAp/xK1sD7OoRV
	bY+gSqAQsf5BF7fajLnW7UsSSwa0F4A22SUWyPTgJmJMTOpKhslvBvk7hEbGnos8HGx3A2mcW
X-Google-Smtp-Source: AGHT+IGCC24xLu0YPxPJqjvvOdQHxuwTrOmVY7UuZn98v9qWq2D9d2x55e3Zpz42GT5EFXIAara3Iw==
X-Received: by 2002:a05:6e02:330d:b0:430:a538:25e7 with SMTP id e9e14a558f8ab-4320f7af6cdmr54831985ab.29.1761659679547;
        Tue, 28 Oct 2025 06:54:39 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea995d420sm4405918173.43.2025.10.28.06.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 06:54:38 -0700 (PDT)
Message-ID: <ce30aa10-4138-4c25-857f-f1a2ea1c91f4@kernel.dk>
Date: Tue, 28 Oct 2025 07:54:38 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blktrace: log dropped REQ_OP_ZONE_XXX events ver1
To: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>, Johannes.Thumshirn@wdc.com
Cc: linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 martin.petersen@oracle.com, dlemoal@kernel.org,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, rostedt@goodmis.org
References: <20251028043248.2873-1-ckulkarnilinux@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251028043248.2873-1-ckulkarnilinux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 10:32 PM, Chaitanya Kulkarni wrote:
> Add informational messages during blktrace setup when version 1 tools
> are used on kernels with CONFIG_BLK_DEV_ZONED enabled. This alerts users
> that REQ_OP_ZONE_* events will be dropped and suggests upgrading to
> blktrace tools version 2 or later.
> 
> The warning is printed once during trace setup to inform users about
> the limitation without spamming the logs during tracing operations.
> Version 2 blktrace tools properly handle zone management operations
> (zone reset, zone open, zone close, zone finish, zone append) that
> were added for zoned block devices.
> 
> Example output:
> blktests (master) # ./check blktrace
> blktrace/001 (blktrace zone management command tracing)      [passed]
>     runtime  3.882s  ...  3.866s
> blktests (master) # dmesg -c
> [   95.874361] blktrace: nullb0:blktrace events for REQ_OP_ZONE_XXX will be dropped
> [   95.874372] blktrace: use blktrace tools version >= 2 to track REQ_OP_ZONE_XXX
> blktests (master) # 
> 
> This helps users understand why zone operation traces may be missing
> when using older blktrace tool versions with modern kernels that
> support REQ_OP_ZONE_XXX in blktrace.
> 
> Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
> ---
>  kernel/trace/blktrace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 776ae4190f36..200d0deb6c90 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -690,6 +690,12 @@ static void blk_trace_setup_finalize(struct request_queue *q,
>  	 */
>  	strreplace(buts->name, '/', '_');
>  
> +	if (version == 1 && (IS_ENABLED(CONFIG_BLK_DEV_ZONED))) {

Redundant parens around IS_ENABLED() here.

> +		pr_info("%s:blktrace events for REQ_OP_ZONE_XXX will be dropped\n",
> +				name);

%s: blktrace events [...]? Seems weird not to have a space there.

-- 
Jens Axboe

