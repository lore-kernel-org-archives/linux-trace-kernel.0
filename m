Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 975CB3DA7F2
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 09:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782466810; cv=none; b=NSVI2pRZchOS1iMqil/vcM6hLr0Ed7Qs/c9fCPS4MnhvpHd2Rds2CKV94kqW6TrLq2NuWamiJ5Xwtq5ov/uDMJWIuZkdSVMpJcVO46kkFeT+hLmmBqySVmsiA3kXm+y8MDZUhuy6GRM59lXtbG0+Yl1wuqpSKR8eFnfAeFj2rK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782466810; c=relaxed/simple;
	bh=l8xL8498nkpGzsqF3RDcPwj+lcf8tTvE9QMw1OS/d9U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=auan/NcGvobjCJ/9tOyboz0gutIzs4+B5xPAGpqO/vVadZDfJYADxI2qXRBIq63n9sBfCGeGjgvxGayZ5VY+gca/6Ly/INr4NL/9xl+bd0mxdShN14IhycFthpd1tSOwSTioZJh6ORO1IyC4zuiT5N3wsljrpYaGC3vADduKQBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kht3K9Rt; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kht3K9Rt"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2c7f3148705so6491305ad.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 02:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782466809; x=1783071609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OU7EDEnprCD/MPTnLuThgw4IEgCvhreE+q7skzKaR3c=;
        b=kht3K9RtZUEkfcn9Vge7eFhqBgT+zkNXPDq0wcFlhmz2cxw2TVV8QPZFo6EyrGygVx
         xWqIC9u50s4Q8ZIAv1N0sPszVjTqQ9fKgrqr/K6tM6EREzd3LtTDIVTad/lRfgODEPQP
         hTTd9hPHQQ4iisTBf44dCVyHmYyDbq6wkk6xHmm49GjoyDVvtiXCwbUShuirW1MtiYC0
         7+G3bo+Q/MWRV+4iv5l3Cs6oYIYcGpuzkw+8tUkXQnG2lIkdBmQwoQfjhpbnuJc1a2tO
         8AUq6DfEGIpupAekofSjJk5vBT1xc5XtzJipXGT+ED1JwlVrnhNmQJgg42PIUbDCOwlr
         5XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782466809; x=1783071609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OU7EDEnprCD/MPTnLuThgw4IEgCvhreE+q7skzKaR3c=;
        b=gFKBZrp5Wyv7FmVDFdrevJY4VNW2LVgVH7a5HfwEInbDC9pnk4ZmDVDheLGkyOqs1o
         Xfzdgpkvri5cv28bDq8GmhfEdiPAEw39V7MFyhLCsuQUUaJbMbkPzDDo0v1xb/T8GYT5
         bJrChBPNp+bjxbJGYntFMjQsYUOPe31xoqpWzQDVwLcvbSEkuCjuiS9Z/8tlKxd29C8G
         pHW8WS2fWCO+QieLqCcKDtcgHNLYdPHZGZ7gXsXXi5bb//qjwpWXXAwwlZkJKyNKVUw+
         uHzyR2IhdTRiRwsoDP+7Kj3ObgZTgpzRhUbsMINbpnwQr5tW1h/LsnxHh0x+7VFLUEyO
         xQPg==
X-Forwarded-Encrypted: i=1; AHgh+RoRkkL9Kc0EgaKldAARF1gI8Kwrxqdc8pW2yga+QOgE/BbADOc5ABuSEijcVMY6zpx0pOu4g6cW3041bUBwxMm824A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYWS29fOTfxgAt/4uMC+4lnPZfkCsYBAYB0kGTBJHzUOS6wAmC
	vkcIhULoz/ModZl8fxk9VW6oYIjQag8nhkvmWXV9m0J5DkOjzg7s+3n/
X-Gm-Gg: AfdE7ckPFOafhLfJPFBjiVoUVmrJBqGyh3KWwVN5ZqlKR0dxrOEq2UpmH1+xzURN+Sb
	+7/J5Kn63Cl17LqU2gV3Mmha5w+eW9UmcCM8atX9N472RAh62W4gL4VKtSIOVQtbUnbT+MtqK5p
	i0O8e+hXJywfQRU7x74CuIGaIFkOBQzC3FGThzmvFiWqKxUH1Bw3c72zGlalDZNv+SXgyysCnpJ
	BTCNeLDmaXNZmg6rY9LDEPR9Eh3JXcs8WMChI670b2G5yqO4hvxD0FxquR5DhOowtlwHD9LjUQw
	baQf2ys+4fzPCQz02UsYilmsVJ2PCFDx+mxY9Y3NyuSFDOwYHkvyuPjvVImR/FBsZKQKRDTQ50+
	JBGL4C09DGTprW02etb3lj0QZ8bS3Topru4XgWRi+zEmUy3fJgJw9OBi8hSNT9wkVMOCYJgVhdg
	vDxn1P8IlyHmtvjibgB74P1mj2qi13MAs=
X-Received: by 2002:a17:902:e744:b0:2c0:b35d:ed54 with SMTP id d9443c01a7336-2c7fcce0738mr61668045ad.35.1782466808869;
        Fri, 26 Jun 2026 02:40:08 -0700 (PDT)
Received: from [10.125.112.20] ([210.184.73.204])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7f5afcb18sm36565685ad.31.2026.06.26.02.40.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jun 2026 02:40:08 -0700 (PDT)
Message-ID: <47b53ee1-1077-4689-8be2-433c6db6fa81@gmail.com>
Date: Fri, 26 Jun 2026 17:39:59 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] mm/compaction: skip isolate mlocked folios when
 compact_unevictable_allowed=0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 akpm@linux-foundation.org, vbabka@kernel.org, surenb@google.com,
 mhocko@suse.com, jackmanb@google.com, hannes@cmpxchg.org, ziy@nvidia.com,
 rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 david@kernel.org, ljs@kernel.org, liam@infradead.org, rppt@kernel.org,
 clrkwllms@kernel.org, Alexander.Krabler@kuka.com
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
 <20260604023812.3700316-2-chenwandun1@gmail.com>
 <20260626092606.7BgipTin@linutronix.de>
Content-Language: en-US
From: Wandun <chenwandun1@gmail.com>
In-Reply-To: <20260626092606.7BgipTin@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/26/26 17:26, Sebastian Andrzej Siewior wrote:
> On 2026-06-04 10:38:10 [+0800], Wandun Chen wrote:
> …
>> Reported-by: Alexander Krabler <Alexander.Krabler@kuka.com>
>> Closes: https://lore.kernel.org/all/DU0PR01MB10385345F7153F334100981888259A@DU0PR01MB10385.eurprd01.prod.exchangelabs.com/
>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> Signed-off-by: Wandun Chen <chenwandun@lixiang.com>
>> Link: https://lore.kernel.org/all/33275585-f2db-4779-89f0-3ae24b455a67@suse.cz/ [1]
> 
> Is it possible to get a Fixes tag on the final fix so that it can be
> backported stable?

Got it.

Best regards,
Wandun

> 
> Sebastian

