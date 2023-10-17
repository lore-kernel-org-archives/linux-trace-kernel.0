Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98EF2E3ED
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 23:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IQy2FjOq"
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4110EC4
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:58:09 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-7a2874d2820so79734739f.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 16:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697587088; x=1698191888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NGLphkCkLVoPlaM3yYY7e9r9UrgJzzPS/ehaeQpvlz8=;
        b=IQy2FjOqphKVVpre0qbdkm4kKSjxGaM2TPPd+d8vhmCDJXjb4PU5vbhVDOFlTPxjrq
         4aS0IZ2s5UsXlrFfitsiClTRpNH+YETwKjtzd9o+32xYXzsU3zxEnFJ4nJCo9FxHyfFw
         Pf2Ss1iodtNRCeb7BLk9uloqfS8uNq1TVABkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697587088; x=1698191888;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGLphkCkLVoPlaM3yYY7e9r9UrgJzzPS/ehaeQpvlz8=;
        b=pqeFDw28CrHnlETVb4AEfqIcNpRXcdDRRzcg28vk6UrJcF+LlGS/w4Z8AAaUDcEbCJ
         xP6tZlqCnrdW+RrLkPwpr1VXEzcOUn0h0rfEb2gYffgpadLD8loTCUfi5Fuv0iRgO+/c
         3aSuaZk0MzR6tE4qLXYrMRp3jANlVdHi/g/x1iA1pd+2m9g7DNhqqGfBwIIMyxEjqD0N
         1KhpODQkDtVvY0C9Z/do7VooHwt86mnCyZr+47ZGIQoxlKJPf03AXt+35s0D6T0ORnbr
         4wmYwFttl6tlmVORS+Xh/GlvkpDpU3nt8XEJrTyu9J7VUsJFkWN+ai57XQpA/GS55S36
         FEuQ==
X-Gm-Message-State: AOJu0YyWrgMKlSA66yddNkIEmT0AXlqz9Y4MFX8wFGPw14vuL+tUwgQx
	waDV4/xc+xrN8ncizeTdMamdFh84mDWqTyLd6vM=
X-Google-Smtp-Source: AGHT+IE2DsA8rmShBFneYOxvDCthBK5HiGdwhOPrz/HvRyHd+Dxs5M3/szwsyLFI9nNV59VLtVVSBg==
X-Received: by 2002:a05:6602:1513:b0:79f:a8c2:290d with SMTP id g19-20020a056602151300b0079fa8c2290dmr4721360iow.0.1697587088596;
        Tue, 17 Oct 2023 16:58:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i15-20020a02cc4f000000b0045c154b7078sm804350jaq.116.2023.10.17.16.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 16:58:08 -0700 (PDT)
Message-ID: <7514ba8d-2a0f-4a28-96fa-7e292da67787@linuxfoundation.org>
Date: Tue, 17 Oct 2023 17:58:07 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next 0/2] add loongarch and riscv support for kprobe args
 test
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, Yu Liao <liaoyu15@huawei.com>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 shuah@kernel.org, liwei391@huawei.com, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20230815085912.701356-1-liaoyu15@huawei.com>
 <20231017133745.098244d1@gandalf.local.home>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231017133745.098244d1@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 11:37, Steven Rostedt wrote:
> On Tue, 15 Aug 2023 16:59:10 +0800
> Yu Liao <liaoyu15@huawei.com> wrote:
> 
>> Yu Liao (2):
>>    selftests/ftrace: add loongarch support for kprobe args char tests
>>    selftests/ftrace: Add riscv support for kprobe arg tests
>>
>>   .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc      | 6 ++++++
>>   .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc    | 3 +++
>>   .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc    | 4 ++++
>>   3 files changed, 13 insertions(+)
>>
> 
> I noticed that this never got picked up, but that's probably because it
> didn't also Cc linux-kselftest@vger.kernel.org (which I did here).
> 
> Shuah,
> 
> Can you add this? You can also add:
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 

I can't find these in any of my inboxes.
Yu Liao, Could you resend these (rebase might be needed) with
cc to linux-kselftest@vger.kernel.org and risc mailing list.

I will pull these in for Linux 6.7-rc1.

thanks,
-- Shuah




