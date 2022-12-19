Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B250DC4167B
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 19 Dec 2022 22:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiLSWMq (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 19 Dec 2022 17:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiLSWMU (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:12:20 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1489D164A6
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:11:43 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id i25so5469709ila.8
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Dec 2022 14:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i+5fBxr0lCerXn/Yuwt3YA+eF3QHf4Pm/K1HNIdR4Yw=;
        b=WKqyAZIz5MUR5DDQkGcUJRFdyBbNq2tXpvuDOOH+hVMD3E+SxrOeOkx5+TlsJ/sUdT
         FXk/bdGSfJjW9Y1f1Tuxfw6uG8doVAVWWuCqAR+NzOzS7/dsaclGzGhUYJcCbg5lwmXb
         o7v99LwuQk5vgQkCJ1vuFxXZCmezv9I4nkb6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i+5fBxr0lCerXn/Yuwt3YA+eF3QHf4Pm/K1HNIdR4Yw=;
        b=pshMuGQ0/rOUSAF0byzSdjHyhK49x14GfGHTYFOTNOzq47F1V3jT/nc2D7Vhe2ctyl
         0TaCc8ZOhCia6NV+3o+vqCw0VcSCrvLgQRIFZQ1F+kyl1g0TqQnrVigXvDyHSemVz5aL
         1T8mitLMVod4EKnLSM/ykNJ//e/1I8V+/KsfcUrgoiakbxaoi3862EbpYSaSPdUzJ/Vo
         Ne339B8FeIP1RODXtnwwpMCRmZuJwaWJRwTRrgDHM2ofxVXmbyNV+QLi0qhQbrHAwpDH
         se7kLWwlJYLyXaiw5DDQgLFGcFbyHAUiupEYgVYE489g8GUbvO2D/7qJPKQBtf4S5m1b
         hymA==
X-Gm-Message-State: ANoB5pmm8+vjFRtMMnP5AO4HpoSx2iQqMwy9iOfTOEb02hjKY8lHovXP
        y8scA3+mXX5Eep31ESjshzqgdw==
X-Google-Smtp-Source: AA0mqf7zghrpxEOqa7lnFcSPA7YcI61pK9QzyHtXriaC03/iIxTUF+IEgYcbz1U9j1kWNEWsoJgg7A==
X-Received: by 2002:a05:6e02:892:b0:303:9c30:7eff with SMTP id z18-20020a056e02089200b003039c307effmr4662210ils.2.1671487902382;
        Mon, 19 Dec 2022 14:11:42 -0800 (PST)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id v8-20020a056e020f8800b002e939413e83sm3602774ilo.48.2022.12.19.14.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Dec 2022 14:11:40 -0800 (PST)
Message-ID: <5e3e9408-8ddd-3649-ef98-4bd611c528cc@linuxfoundation.org>
Date:   Mon, 19 Dec 2022 15:11:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/2] tracing/selftests: Add test for event filtering on
 function name
To:     Ross Zwisler <zwisler@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20221219183106.518341498@goodmis.org>
 <20221219183214.075559302@goodmis.org> <Y6DQTvOrHRZ8gjDz@google.com>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <Y6DQTvOrHRZ8gjDz@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 12/19/22 13:57, Ross Zwisler wrote:
> On Mon, Dec 19, 2022 at 01:31:08PM -0500, Steven Rostedt wrote:
>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>
>> With the new filter logic of passing in the name of a function to match an
>> instruction pointer (or the address of the function), add a test to make
>> sure that it is functional.
>>
>> This is also the first test to test plain filtering. The filtering has
>> been tested via the trigger logic, which uses the same code, but there was
>> nothing to test just the event filter, so this test is the first to add
>> such a case.
>>
>> Cc: Shuah Khan <shuah@kernel.org>
>> Cc: Shuah Khan <skhan@linuxfoundation.org>
>> Cc: linux-kselftest@vger.kernel.org
>> Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Reviewed-by: Ross Zwisler <zwisler@google.com>

Thank you both. I will apply this after rc1 comes out.

thanks,
-- Shuah
