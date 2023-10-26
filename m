Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4501A13FEB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 11:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="C+oohoSd"
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B7E19D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:05:59 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ca816f868fso5586935ad.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Oct 2023 04:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1698318359; x=1698923159; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=x93MQWkfMYQ6TuK/NbHLY7+kEM3Cccucuq3SrmtmqQ4=;
        b=C+oohoSdRcvVKKLIt9DJd3NoKKo/s8clO/Sca0FqNptwNcAw2vwSDmohA/N17PjMoY
         ndAmMs4yOCExWuNzcvwkfxJapjrWa/f8l7CGzZh/v3Ttkq/OoG+1cjfOdSkQ+EJlLDA7
         MPeoQkvA1DDAwQfkOHnf5BQhUu/PBTL6DDdDYclpwu8TsdwwWYcK9yRLp/1/im4JSqvT
         IV9V2LJXw/boJcwtnw/i5L8gWKTkyChZ6CklGPnnOcvKegfdRzGb9bHwVz2lZPiUg4z8
         sYamjxcNltY42O2euGXjMFDQy/ykBvJqlpmfc8dSdj3U43IMIFVZFo4GbRhTq3bcEmu3
         9rfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698318359; x=1698923159;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x93MQWkfMYQ6TuK/NbHLY7+kEM3Cccucuq3SrmtmqQ4=;
        b=PJOstOF7RM/K+an19thSBkh/lkUOfLgQsOb2RQO+YKJc9IiB2+rM2kFyYF9PlRczUY
         /N2HYO8tXq6/JEg09VM+lf8BIVm8YkYd8yEv1+jkldgOp4xomywNZowJTCn1AySBxVNG
         ePs67vQn1/LBEcqxvH0RZXMnf9s47WoNI199hWx5SX4I2OOlRB8quzZkUQpveXRvWyTW
         herfphZ6X4yJzKX3ZgXll+t7kVrBdOabonG7Cp8AUHPWRuSfAHYxxn/BeIVbothwOyTx
         ZCO4AXX2HMj3QiP0eYevu2WELw0aX/fcsA430JnnVWw2VCKF8hJFWduEboQcH3tLem/n
         n/hg==
X-Gm-Message-State: AOJu0Yym87/KXeS9cG/HozEgNGJQqq0K7ly6uUVMZmeHkf7gPX+/+Lce
	N+E/N2jp4ydLWerjZ0hH2FB9QQ==
X-Google-Smtp-Source: AGHT+IH9wTpR7bR6yZ4zW939EJeROmWtKntuMjj452VlIz/DhK9dVuXE8G7lit70lUaogdpRlYHvcw==
X-Received: by 2002:a17:902:eccb:b0:1c9:ba18:785c with SMTP id a11-20020a170902eccb00b001c9ba18785cmr19270581plh.25.1698318358777;
        Thu, 26 Oct 2023 04:05:58 -0700 (PDT)
Received: from [192.168.6.6] ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id b10-20020a170902d50a00b001c5b8087fe5sm10812843plg.94.2023.10.26.04.05.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Oct 2023 04:05:58 -0700 (PDT)
Message-ID: <66f5645c-f9f5-4c53-9503-a1f8470a9bee@bytedance.com>
Date: Thu, 26 Oct 2023 19:05:51 +0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] locking/atomic: openrisc: use
 generic_cmpxchg[64]_local for arch_cmpxchg[64]_local
To: Arnd Bergmann <arnd@arndb.de>, Jonas Bonn <jonas@southpole.se>,
 Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Andi Shyti <andi.shyti@linux.intel.com>, Palmer Dabbelt
 <palmer@rivosinc.com>, Andrzej Hajda <andrzej.hajda@intel.com>
Cc: linux-trace-kernel@vger.kernel.org, Masami Hiramatsu
 <mhiramat@kernel.org>, mattwu@163.com
References: <20231026073932.702197-1-wuqiang.matt@bytedance.com>
 <1e3aba7d-89ac-4b62-840e-992527115a70@app.fastmail.com>
Content-Language: en-US
From: "wuqiang.matt" <wuqiang.matt@bytedance.com>
Autocrypt: addr=wuqiang.matt@bytedance.com; keydata=
 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
 4mCJUdEkdwCS
In-Reply-To: <1e3aba7d-89ac-4b62-840e-992527115a70@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023/10/26 16:46, Arnd Bergmann wrote:
> On Thu, Oct 26, 2023, at 09:39, wuqiang.matt wrote:
>> arch_cmpxchg[64]_local() are not defined for openrisc. So implement
>> them with generci_cmpxchg[64]_local, advised by Masami Hiramatsu.
>>
>> Closes:
>> https://lore.kernel.org/linux-trace-kernel/169824660459.24340.14614817132696360531.stgit@devnote2
>> Closes:
>> https://lore.kernel.org/oe-kbuild-all/202310241310.Ir5uukOG-lkp@intel.com
>>
>> Signed-off-by: wuqiang.matt <wuqiang.matt@bytedance.com>
> 
> I think on architectures that have actual atomics, you
> generally want to define this to be the same as arch_cmpxchg()
> rather than the generic version.
> 
> It depends on the relative cost of doing one atomic compared
> to an irq-disable/enable pair, but everyone else went with
> the former if they could. The exceptions are armv4/armv5,
> sparc32 and parisc, which don't have a generic cmpxchg()
> or similar operation.

Sure, better native than the generic. I'll try to collect more
insights before next move.

> You could do the thing that sparc64 and xtensa do, which
> use the native cmpxchg for supported word sizes but the
> generic version for 1- and 2-byte swaps, but that has its
> own set of problems if you end up doing operations on both
> the entire word and a sub-unit of the same thing.

Thank you for pointing out this. I'll do some research on these
implementations.

>      Arnd

Regards,
wuqiang

