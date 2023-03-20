Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD01AC7618D
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 20 Mar 2023 12:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCTM54 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 20 Mar 2023 08:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbjCTM5g (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:57:36 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94867EB45
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:56:45 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id o12so5346103iow.6
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Mar 2023 05:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1679317005; x=1681909005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4PBK1F4xmuxkhj1Bp/pC5zsVsfYN8MHoztwMr1Mlxt0=;
        b=hmCo894tBO47HrZGMgQ0TU1uLXbzv1E1p+aiRQ5KELmPk0Wz7DxvH5p81Xz4CL9ARs
         C+rqH33TiKjBLRwEeokcvbtUJM2/xZe1J4sUcbbjU10Y+d1eot4HzrNF4Cc9cs0QK7oK
         fWIUKt2zol35q3fEky3giQvmj8RBkOOgmHUyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679317005; x=1681909005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4PBK1F4xmuxkhj1Bp/pC5zsVsfYN8MHoztwMr1Mlxt0=;
        b=2lBGwvUtfNHkqQeLM1gREmrK7SgyZ9sPvP1uvwG93z6ZZ2KZ0Lke9sMg0ZODqI16jJ
         p2U3zuVuC0eI+WGAnqRxWbTfpPgmp1/fMDyZRtqNbQrgXz1FR0iunLBs8CtxGJ2okmy0
         oHkafm4/6hHvY6iIEaHJpi9Yhcl4yQ8pab0wIAdQK4jxIbJFtBJyBktBL6BpFnL3G1Sq
         GDsVAl93KDS5SsVyvo8PU/FqvHrkj/H6KsmEkQueP7aRlLtHD15qltGi+gzc+Xb1CP5z
         MnbDs5sMg3vju3Ik35B+90Zs6xKhdIOjL/y+VpcD2HT3zSJPdJwsAkpoWf9NhBzT7o5S
         djqQ==
X-Gm-Message-State: AO0yUKXuKBQryU5eFwTj8h60dMbayz6rdFo02O1/G0cLiuqA/hi3JpKz
        pvdMR86RGPv1I1C+0NKOZB1iHg==
X-Google-Smtp-Source: AK7set+VbE6SOQTu7hY7IZOXpYFjyei0/tZDLmAEfqaPb+DBYjzbVCs+QSOKQiFlDt45F6XUxaO0+Q==
X-Received: by 2002:a5e:a50d:0:b0:74c:9cc4:647 with SMTP id 13-20020a5ea50d000000b0074c9cc40647mr8922048iog.1.1679317004868;
        Mon, 20 Mar 2023 05:56:44 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id h24-20020a056602009800b00743fe29dd56sm2872679iob.4.2023.03.20.05.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Mar 2023 05:56:44 -0700 (PDT)
Message-ID: <8579dfaf-11bf-cefa-c3ed-eb9b2d9d1a22@linuxfoundation.org>
Date:   Mon, 20 Mar 2023 06:56:43 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] tracing/selftests: Ignore __pfx_ symbols in kprobe test
To:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230207135147.5ce618d6@gandalf.local.home>
 <20230213204643.39f86987@rorschach.local.home>
 <20230318144202.486c43d1@rorschach.local.home>
Content-Language: en-US
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230318144202.486c43d1@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 3/18/23 12:42, Steven Rostedt wrote:
> On Mon, 13 Feb 2023 20:46:43 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> Shuah,
>>
>> Can you pick this patch up?
> 
> ping?
> 
> -- Steve

l I will queue this up. Sorry for the delay.

thanks,
-- Shuah
