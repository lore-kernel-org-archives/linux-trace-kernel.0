Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32382C76195
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 27 Mar 2023 19:43:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjC0TnT (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 27 Mar 2023 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0TnS (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 15:43:18 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B2102D6D
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:43:17 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7585535bd79so5772339f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Mar 2023 12:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679946196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F4TnUKE6dIQQ87kL1s9DdezkHsj4NeJBgTDMt2DH/Y4=;
        b=I2GXA4sDA4ZYNG5d5aE57iXNnuqiTrlyQu61Mc2nQzVD/Rdne46yxY2K8snsrdNVx7
         8VB2psZxmX6yqEmcn3OY3YYj04APFccRQJVwnB9iNIKklwjQNEA/Vc33W0Sechke5bvQ
         wKkebiYFtesd7Cmur19Hyuh1DXB+05vzUdTb8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679946196;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4TnUKE6dIQQ87kL1s9DdezkHsj4NeJBgTDMt2DH/Y4=;
        b=R4ZyPJfSAF9Yj2R+NnBJ1ZW/apJJE6MmoOjGSu8Q16gMVJwMcptcILQwq2IZCibpRm
         CtEpMysNAH4kv+RHkmwFrnM1SmkP0Id/Q6pLny7kr4PQUHFe7Lu0SRBlwMPEgfC3W2WD
         o8pWh0xDWzBMdNh9cZWV0dyLx/zGJFzmmxVWzyHB1RTFL0qk9qxSxJ6MUspCztXQ7Gqp
         4gGmxdlCAut1PQ2pl7iD9ExW3px9x9A+AP0D3gXIa8OWHLat9/bkEnOOlF5EtP3AY0do
         vfqUVA79268O9mCY/M98+xpCrXxgEnPBiefFbP8dOI8w8kFgLpKfLHfcPnQ6q/M9SkbK
         EFww==
X-Gm-Message-State: AO0yUKWq+QI0i12Ndj7yb2srVDfRXe007QCE1zT9hbpu0isGbM2dYTtg
        VrXe6dfP5R5U+92xvmYzEv6nQw==
X-Google-Smtp-Source: AK7set811ugU67g7Ya8gmj9X8Ibt1JxrkN3OdPvUT4vnE3cXoI5M4xUDyLKZOicBwaiHovqJXae+LQ==
X-Received: by 2002:a05:6602:2c82:b0:740:7d21:d96f with SMTP id i2-20020a0566022c8200b007407d21d96fmr8089458iow.1.1679946196649;
        Mon, 27 Mar 2023 12:43:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id l12-20020a056638144c00b00406ae1bd4a9sm5802503jad.178.2023.03.27.12.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 12:43:16 -0700 (PDT)
Message-ID: <1e2b5a9e-9e92-6394-74fd-18dae2ed0712@linuxfoundation.org>
Date:   Mon, 27 Mar 2023 13:43:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] selftests/ftrace: Improve integration with kselftest
 runner
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Mark Brown <broonie@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230302-ftrace-kselftest-ktap-v1-1-a84a0765b7ad@kernel.org>
 <20230319232438.786c46feaf9bb7ddcb78a731@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230319232438.786c46feaf9bb7ddcb78a731@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 3/19/23 08:24, Masami Hiramatsu (Google) wrote:
> Hi Mark,
> 
> On Mon, 06 Mar 2023 15:35:10 +0000
> Mark Brown <broonie@kernel.org> wrote:
> 
>> The ftrace selftests do not currently produce KTAP output, they produce a
>> custom format much nicer for human consumption. This means that when run in
>> automated test systems we just get a single result for the suite as a whole
>> rather than recording results for individual test cases, making it harder
>> to look at the test data and masking things like inappropriate skips.
>>
>> Address this by adding support for KTAP output to the ftracetest script and
>> providing a trivial wrapper which will be invoked by the kselftest runner
>> to generate output in this format by default, users using ftracetest
>> directly will continue to get the existing output.
>>
>> This is not the most elegant solution but it is simple and effective. I
>> did consider implementing this by post processing the existing output
>> format but that felt more complex and likely to result in all output being
>> lost if something goes seriously wrong during the run which would not be
>> helpful. I did also consider just writing a separate runner script but
>> there's enough going on with things like the signal handling for that to
>> seem like it would be duplicating too much.
> 
> This looks great! and is what we need.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Thank you!
> 
>>

Steve,

Okay to pick this up for the Linux 6.4?

thanks,
-- Shuah

