Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382E52C08B1
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 20:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769198790; cv=none; b=ZbezQyPrDFNNNYjIzt2YNI5ngn+hK4ej1cGNa+TN17eIUJCrNA6pFVqDzs6v7eugg1OpIdXdbRJ5A9/LfqqfS5liWaE+Wj6GpImiUfUdy3uQtvNI2Tue7zvqmdAt5S+F+P+kWKtPIe7gwzzoGv0UzAY6s91LmaOn4nHyARHD7gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769198790; c=relaxed/simple;
	bh=v1sXU4PdFUfhYag1oK10C//CQAN0sHDfsL1wvzXt6y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HEY6DCk+1sVYAlPjg2y/SAuuzyyQcEIyJbiAcjOuZ6tDE6EKoCOaiFZobBffIt3PyQkb83NnT8F+c4ztjPWO/2NHndHhbUO/TP+//65dMlmfJZ9Acx0znOtYEnIvr7xxTyWHxPpnJVMaom8k92MRmPy4nuGsC8YLhIhI21QsO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S1tcdEVu; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S1tcdEVu"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8217f2ad01eso2478890b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Jan 2026 12:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769198788; x=1769803588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mz/jgqDQ6Gq5gSxog3VT5ArFAGGJtxquZRf1ad8YXHk=;
        b=S1tcdEVuPrbbJ0zQRvSen5L/Gh3KLfQZElojDjGWZI99gmATzKzHSppLksH31bq/6G
         tWAkzjm2AtCe3Foj6ge2Kf1ezx29j8A6WqFEz5CvzVU1GY+z4dInJ3apAdkwU1YoZQKy
         a+C95/Bf3QB3rElWDK0hpnH/CkfflpEQYL6wX+ioxABiZdb13tWejv+cEbC+OQHla+Bq
         zplhmLIIe7uj45Pk9A7rGY+0jzH8uwPsBZ8COKf6WJafLgxVvld200Mmss89BmUy57Re
         hOIUlmzAZqPZZRpIxiq4zowhvDQczyD/z0NpbeYDhpjQpEpfFU1cFpOka5c5hDBJ/uol
         9aXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769198788; x=1769803588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mz/jgqDQ6Gq5gSxog3VT5ArFAGGJtxquZRf1ad8YXHk=;
        b=V0exlxhVIiWBtGqGfY9gKb64jCBrxSmE7WcTPs1C2IKKQMyxdgV/V9GI9EGzys9vKW
         zCQbfWoWLmPDs6QaQFfYQCXafq8fibQSRxpqXDuxeDB6UjeyqXSqvJjXtWp2p/es+zhs
         fzh6dfPWF9POCyqSNB5ZJlxI0GsuwjqvyOMyazRLEtGK3C9zgaSeOSDGzYHwqggwZLBC
         gQCDIYB+Tl+LnREMBeXA1UqksiPT52qIUjTrvTF3PldgFhNnlF9snjL+XdGAaqImS18P
         o84Eq0Esdo3vfGhZVcMYD/ZGkti+r6tk+rfShPGu8R9NAXbe1oZhCMBmQ2OJ5a7NZ6zh
         CbEw==
X-Forwarded-Encrypted: i=1; AJvYcCU6vPeiGo5HCSYyHgDwmgM1qwM2YgDzBYdpTG+3X/+sxyXbCv5+m6/438hGhDGErkGsJi+CZwPiVkExLZOtit50QMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdJCyXp/e8Ps8DS4ylpLbEI36/MO32fOfjvp5kauGPidqmxXPT
	7SblKP3bIXIDBbXonIesUScVgWBRjXP0IeERREtIv5Hjq1zK/FUBl0XX
X-Gm-Gg: AZuq6aJpuN6JOz/3aFvNchBqfDbSdDUEUx39LnpvKan99qYJFwhMhXq9hlgoiu1nGsw
	gi9XgeNTqEhssAKPB3bF/Wsw8oIoD3y7fUr1iEeER2+FPd4IP2XT4m+cXf4VkV1PfCxEjHlJNqt
	8RcrGeMC4+pG7RjgjaK/54hkBnn498llRE6OaYCQLIUAJldBqIezN6WKoLwNF6LE6ysDR6gGyOi
	EI/GlZykYXECvgGTxU7eQ/PiSRP7dEixLB9vpifgdl3q4Rzc0a4fT7nr69NUxEblnWpYDsicqyo
	QCZhCQ58rRhb286aITd4BvtgIN94SSfVso9YtwCuMefNXk7e5sS32y0EkwDj699HK/5QuKktnUI
	7NQclqURz9ux5C5wl7/NENruhiU1vvhXWSKxhF0cTER8CEtmQKd0hBvUv4KzmOQFKP/045I73pv
	nqkI+mdf0P0bIHHK4cRGU=
X-Received: by 2002:a05:6a20:9c92:b0:38b:e944:3e94 with SMTP id adf61e73a8af0-38e6f7dad49mr3505436637.39.1769198788579;
        Fri, 23 Jan 2026 12:06:28 -0800 (PST)
Received: from [192.168.7.12] ([103.182.158.109])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c635a142e71sm2770571a12.11.2026.01.23.12.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Jan 2026 12:06:28 -0800 (PST)
Message-ID: <c79d4fbd-e9a4-4d73-a650-b01f437a4c0b@gmail.com>
Date: Sat, 24 Jan 2026 01:36:23 +0530
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rv: Fix dead link to monitor_synthesis.rst
To: linux-kernel-mentees@lists.linuxfoundation.org
Cc: shuah@kernel.org, skhan@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 Gabriele Monaco <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org
References: <20251203202259.69116-1-sohammetha01@gmail.com>
Content-Language: en-US
From: Soham Metha <sohammetha01@gmail.com>
In-Reply-To: <20251203202259.69116-1-sohammetha01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04/12/25 01:52, Soham Metha wrote:
> The file 'da_monitor_synthesis.rst' was renamed to 'monitor_synthesis.rst' in
> commit f40a7c060207
> ("Documentation/rv: Prepare monitor synthesis document for LTL inclusion").
> 
> Update the reference to point to the new filename.
> 
> Signed-off-by: Soham Metha <sohammetha01@gmail.com>
> ---
> No functional changes.
> 
>  include/rv/da_monitor.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
> index 17fa4f6e5ea6..c2cea209f230 100644
> --- a/include/rv/da_monitor.h
> +++ b/include/rv/da_monitor.h
> @@ -8,7 +8,7 @@
>   * The dot2k tool is available at tools/verification/dot2k/
>   *
>   * For further information, see:
> - *   Documentation/trace/rv/da_monitor_synthesis.rst
> + *   Documentation/trace/rv/monitor_synthesis.rst
>   */
>  
>  #include <rv/automata.h>

Hi,

Just a gentle ping on this documentation patch in case it was missed.
Please let me know if any changes are needed.

Thanks,
Soham
