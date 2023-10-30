Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816F7EE
	for <linux-trace-kernel@vger.kernel.org>; Mon, 30 Oct 2023 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="D28F8iOi"
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE45FBF
	for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Oct 2023 18:57:22 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-28001f8079cso2405662a91.2
        for <linux-trace-kernel@vger.kernel.org>; Sun, 29 Oct 2023 18:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698631042; x=1699235842; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xif9jDPurtABn3HmPh5sIxcHhWec17MHw8DajCplY0A=;
        b=D28F8iOiKRffHEkDGxvc967AMbxu8gWhW9phwcrmsJ4/v4C8d3r26nhr4+dzqCFLpY
         C38uOE1gC4kwWerQWwNw+taL2+MYBOOJgtNcm329w+3bvYLjfx1YETIJusi9e49OBVjF
         n0PuS5nXcU1gnqyF0urja3HeMZ6QHGZb6fSsqLkRKTdBDh4KIzfwlkXhg/2dLh3TGQBa
         YTAlwb0lKOrCBrSpkrSSjZ4mDykAeJXA1TZs4o475iUcosUdebl7KhvuRjyWDwHAsble
         LsMRX0cO1olrWMa+wsuZDWpVi30dVMBTwMrVTQRSz/US9BjAMhuzijLS7HI/cEQj5lCv
         BCmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698631042; x=1699235842;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xif9jDPurtABn3HmPh5sIxcHhWec17MHw8DajCplY0A=;
        b=GAiEp0RSQs8r97HeGUFgSck9OL2k/PwSrjrlQAbvKPuK6LB3ifoPYC0LSChfcubv7S
         VlZczLUeUZNybsEv9kgYGZctkwHcAZQ8xN5PkVDjDuu3RHeSYkoPaMjK5scfAjefzErw
         LUO59BXv2/nrSIXDbfGQx9Ab7JauYAlPXepah4aAcQrRuvYC9/MVKeqMFVSp1ZFjQOPS
         ugXenrOCHUC5g7+NUjiQ5WJatQn8pXzD4N19alcN5B0zmLTI3LD90XUGfT1J5LcwhMcr
         +kL28pdcC32J1yMbZ24wy+kS7Qh5v0bQMFPpL5TAbkpOEQ9wojCxXIziwiHvBlIf/Iz2
         bg3A==
X-Gm-Message-State: AOJu0YyKx7/odgHjhTj+XguLjbCz6CyUXX9AnwGDIZdsQj8MN9uucUiF
	W/xFLfcJIjR0cu18dMU1GQ1pK1t7ieieo1YqLAk=
X-Google-Smtp-Source: AGHT+IFDRz4WnbsPgSxMMAXHuMvgLNb0gqV8+5oze1PDalgoZIBtZswTC95vR83MTlruakctGmi/tg==
X-Received: by 2002:a17:90a:b004:b0:280:4f82:68ac with SMTP id x4-20020a17090ab00400b002804f8268acmr794061pjq.24.1698631042181;
        Sun, 29 Oct 2023 18:57:22 -0700 (PDT)
Received: from [192.168.3.101] ([104.28.213.202])
        by smtp.gmail.com with ESMTPSA id 10-20020a17090a1a0a00b0027909a8994fsm7169127pjk.13.2023.10.29.18.57.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Oct 2023 18:57:21 -0700 (PDT)
Message-ID: <59bf8835-6d07-4336-aa95-d39928dd43ab@bytedance.com>
Date: Mon, 30 Oct 2023 09:57:03 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] lib,kprobes: using try_cmpxchg_local in objpool_push
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 davem@davemloft.net, anil.s.keshavamurthy@intel.com,
 naveen.n.rao@linux.ibm.com, rostedt@goodmis.org, peterz@infradead.org,
 akpm@linux-foundation.org, sander@svanheule.net, ebiggers@google.com,
 dan.j.williams@intel.com, jpoimboe@kernel.org, linux-kernel@vger.kernel.org,
 lkp@intel.com, mattwu@163.com
References: <20231023112452.6290-1-wuqiang.matt@bytedance.com>
 <b579d68f-f2ec-42ef-8366-6878c9930e0c@roeck-us.net>
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <b579d68f-f2ec-42ef-8366-6878c9930e0c@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/30 01:05, Guenter Roeck wrote:
> On Mon, Oct 23, 2023 at 07:24:52PM +0800, wuqiang.matt wrote:
>> The objpool_push can only happen on local cpu node, so only the local
>> cpu can touch slot->tail and slot->last, which ensures the correctness
>> of using cmpxchg without lock prefix (using try_cmpxchg_local instead
>> of try_cmpxchg_acquire).
>>
>> Testing with IACA found the lock version of pop/push pair costs 16.46
>> cycles and local-push version costs 15.63 cycles. Kretprobe throughput
>> is improved to 1.019 times of the lock version for x86_64 systems.
>>
>> OS: Debian 10 X86_64, Linux 6.6rc6 with freelist
>> HW: XEON 8336C x 2, 64 cores/128 threads, DDR4 3200MT/s
>>
>>                   1T         2T         4T         8T        16T
>>    lock:    29909085   59865637  119692073  239750369  478005250
>>    local:   30297523   60532376  121147338  242598499  484620355
>>                  32T        48T        64T        96T       128T
>>    lock:   957553042 1435814086 1680872925 2043126796 2165424198
>>    local:  968526317 1454991286 1861053557 2059530343 2171732306
>>
>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> 
> This patch results in
> 
> lib/objpool.c:169:12: error: implicit declaration of function 'arch_cmpxchg_local' is invalid in C99
> 
> or
> 
> lib/objpool.c: In function 'objpool_try_add_slot':
> include/linux/atomic/atomic-arch-fallback.h:384:27: error: implicit declaration of function 'arch_cmpxchg_local'


This patch was already reverted from probes/for-next by Masami Hiramatsu.
Then we will rework it after the arch_cmpxchg_local issue is resolved.

> for various architectures (I have seen it with arc, hexagon, and openrisc
> so far).
> 
> As usual, my apologies for the noise if this has already been reported
> and/or fixed.

We are working on it and the fix is in discussion.

> Guenter

Regards,
wuqiang
