Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C722EAE1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D7ivu6dq"
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7555BA
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:10:49 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7a29359c80bso46615339f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Oct 2023 14:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1697577049; x=1698181849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N1DjHreh3ynrrfDphSYg/yMleGlXGDFE7si/WhmBSes=;
        b=D7ivu6dqMLmslBIBlJvku2OFyuD5tA2NqYVGPn/68RpXC5JH6mGNEq8UPr91wA6sfN
         rMNFMmnMMOv0dsMCiAgzQzQ8kd03AVHsUNFgnC1hLwlhOkc6STbEm6GHq/xL97jaFP/z
         C6gUtwlNAjGx19u1vNdTrHKdfypF+MKaY+7fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577049; x=1698181849;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N1DjHreh3ynrrfDphSYg/yMleGlXGDFE7si/WhmBSes=;
        b=vTmND8GGIvAv+PT1Est5slbkkwdJbPPiELs5SDd4xvmZMGg9AbOB5iBj9gNk6l1/E1
         o3VWz9trKdyL1XCirG+fdQvC3wX5jQmWMkgUQ7VFg5uo+2G5e02/PcAvdUqvfgu3IyCA
         0X+EXLZVWwf+cfXePRG22lOS8168iQhe/z4TP2SC/zqTxqf30L8HpEgAyBtBcLCG4yhe
         S7JRgGFoMWXNo9g7uzzMjvnMppHCobroHVzCUOLduXDiDuU/WOwvDz4qjZ+5pdhkm2YD
         9EzrhIm7Kb6r+XtIltzOs3Q5/nBsuVwN1a4VelKC8vOUaSY3KtoX6IaJwNVKowdF9PBD
         gxTw==
X-Gm-Message-State: AOJu0YwIMTIax6+hoPy7sUD6uuAohXMVd6z58MXw2sMKxMmurHp5/Y+B
	PGmgzTu6RCfWWHDqOB2yTGPnUPrF4271gK6QncQ=
X-Google-Smtp-Source: AGHT+IHeEwrd7Db/Mr+M6q+By4nmWyhfP9IKXTZ1FdHxoTJc+F2J67jNmA49QPzNcVwmDXJUgNf9zA==
X-Received: by 2002:a05:6602:340a:b0:7a5:cd6b:7581 with SMTP id n10-20020a056602340a00b007a5cd6b7581mr4398745ioz.2.1697577049051;
        Tue, 17 Oct 2023 14:10:49 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y15-20020a056602214f00b007836c7e8dccsm631822ioy.17.2023.10.17.14.10.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Oct 2023 14:10:48 -0700 (PDT)
Message-ID: <38a36f4c-c62a-44f0-a818-3ea7dc49654b@linuxfoundation.org>
Date: Tue, 17 Oct 2023 15:10:48 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/user_events: Fix abi_test for BE archs
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>,
 Beau Belgrave <beaub@linux.microsoft.com>
Cc: shuah@kernel.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20231005215712.17942-1-beaub@linux.microsoft.com>
 <20231017163844.55d828bf@gandalf.local.home>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231017163844.55d828bf@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/17/23 14:38, Steven Rostedt wrote:
> On Thu,  5 Oct 2023 21:57:12 +0000
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
>> The abi_test currently uses a long sized test value for enablement
>> checks. On LE this works fine, however, on BE this results in inaccurate
>> assert checks due to a bit being used and assuming it's value is the
>> same on both LE and BE.
>>
>> Use int type for 32-bit values and long type for 64-bit values to ensure
>> appropriate behavior on both LE and BE.
>>
>> Fixes: 60b1af8de8c1 ("tracing/user_events: Add ABI self-test")
>> Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
>> ---
>> V3 Changes:
>> Fix missing cast in clone_check().
>>
>> V2 Changes:
>> Rebase to linux-kselftest/fixes.
> 
> Shuah,
> 
> Can you take this patch?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 

Thank you both. Applied to linux-kselftest fixes for Linux 6.6-rc7

thanks,
-- Shuah


