Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA516C77B73
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  5 Jun 2023 19:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235544AbjFETcd (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 5 Jun 2023 15:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235737AbjFETcb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:32:31 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D24103
        for <linux-trace-kernel@vger.kernel.org>; Mon,  5 Jun 2023 12:32:27 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id e9e14a558f8ab-33bcc8f0d21so2424465ab.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 05 Jun 2023 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1685993547; x=1688585547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vhr2lAV911N9w6qOC4Bl8VDt3wGt4nmSLltxDhRWdPM=;
        b=ZV+nugYv6uGpnZqVmkYA7FKCRurQ5jAol+M6MWCUFCjQGidv5JPTur0hGB2/7mZ9lP
         2UoLnsvHenY916/PTUJ6qlEyMzoA1RbXPx5DHixWJr13J/0nD2JdkP4J/bgWM/dTdk3U
         uriedVLS9HD28WubInvxOdLH+bKP4L93iWe5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685993547; x=1688585547;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vhr2lAV911N9w6qOC4Bl8VDt3wGt4nmSLltxDhRWdPM=;
        b=iPngTqM+jRPhs1SdyNZ6ITS9k4Mr7CeUng58Q3HBvbgV81+rsjsselLR87S/+EpXte
         JevPy9kdrX40UzQiVHSQ08ksBDHWQ11yk6fBvvie/B3tY0YSJJyAN4hPW5+v7Uy08xYn
         yT2MHwyAOSuXnBuW9hVb8lj8GMHJanh6g9s5ToR4WHs6ZY48c9CZ7b2W29xOWlf8fWM2
         NLL+ChHlkwQ1u2B4NkHFp+KKHoJ2/9rHqTe/ag/N2toEBYj1o1bPNV93V+aiE9/ubPQk
         EuxUm2+9nyiTGg7QD63KYgVeQEeA1fc8kU3czIvdX2uTuqMOYVhIpp3Oh6raNC2/sezQ
         vo1w==
X-Gm-Message-State: AC+VfDwrAMz23uClruShpPKbONekhn5ZXihjcpvza5BEV2bVHPMspO2c
        T2gGBDOXacuGrMSUOBcP0O0QqQ==
X-Google-Smtp-Source: ACHHUZ6KHh1oVsrNW2D/ZW3X6D326obvjwPX9XVKIX4IeLt0y2mOCL7Bvt0P2Wf6po1/yAhWO20VFQ==
X-Received: by 2002:a05:6602:3999:b0:777:b6a9:64ba with SMTP id bw25-20020a056602399900b00777b6a964bamr118881iob.2.1685993547357;
        Mon, 05 Jun 2023 12:32:27 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z18-20020a029f12000000b0041a9c4e0f1csm2330096jal.109.2023.06.05.12.32.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 12:32:26 -0700 (PDT)
Message-ID: <9f726045-e9fa-5c8c-fd1c-ace5cf967617@linuxfoundation.org>
Date:   Mon, 5 Jun 2023 13:32:26 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tracing/selftests: Update synthetic event selftest to use
 common_stacktrace
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux trace kernel <linux-trace-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230523225402.55951f2f@rorschach.local.home>
 <20230525102408.4b2750621cb1deeb05e58980@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230525102408.4b2750621cb1deeb05e58980@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 5/24/23 20:24, Masami Hiramatsu (Google) wrote:
> On Tue, 23 May 2023 22:54:29 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>>
>> With the rename of the stacktrace field to common_stacktrace, update the
>> selftests to reflect this change. Copy the current selftest to test the
>> backward compatibility "stacktrace" keyword. Also the "requires" of that
>> test was incorrect, so it would never actually ran before. That is fixed
>> now.
>>
>> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> Looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Applied to linux-kselftest next for Linux 6.5-rc1

thanks,
-- Shuah

