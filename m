Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47678C77B7F
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  8 May 2023 17:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233109AbjEHRSG (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 8 May 2023 13:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjEHRSF (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:18:05 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D7C49D1
        for <linux-trace-kernel@vger.kernel.org>; Mon,  8 May 2023 10:18:03 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-763970c9a9eso15931039f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 May 2023 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683566283; x=1686158283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w8qlp5XghttjEan5YOKeJGzJQmCiegmZ3khpFvV4ZPs=;
        b=AO1hRYtglviVhhGSoTuSJwmjPi3RErsHCMTxnnQap1CnXC6UFQWMjmYvvxAatKg9VR
         bkFSRlXrZOcFkVtIKyfLw+2PA6OKDphDtHeWdBqfxY1g+tGLMOkpkejSjKwV/sUJxi4X
         cT0YryWbViHXgSNQO+9ytmYt7C8F8yvEhDTD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683566283; x=1686158283;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8qlp5XghttjEan5YOKeJGzJQmCiegmZ3khpFvV4ZPs=;
        b=igaUOauBNjhaDSwlWNgBf0OYaaTTYVjNN6R3+E3Mp8EuifB31Q9Xl9Rmi8GNRm6zSo
         C7BN4qb1lkq5TG3havhGL4eYyaTYB8XROTIpfp7M2S32LHyfKKY18Lmym7dJQqnEtU0X
         vq7+H+Upoj0KdlpSZ9l4PLuFMfQ2vX7aQqyoKRFvgzasbdlmkDgzmQjLM1llAczKxVxa
         50dLWVTktFeT7uVVR4vrc76nyOP+t+QB0RzaTmQdWqAqtvFdqWq3srY8MSeKU1j3yt2H
         tBEWtpg0aWtFQtUdDBNhtS4SDdjzpxu5o2qL2Rba47Zp6bIxCSLRXjbS0MFPd5lmyCoy
         C+dg==
X-Gm-Message-State: AC+VfDzwQmBs6JSAVcTC+XXfw8CvwVbHwsHTnOSVGNYGnU1vS7XhdhTK
        XP34PUHjI4NG4F9zwtHs+GXGjA==
X-Google-Smtp-Source: ACHHUZ63FdKEvsQgOvOAIVrabDVRnQT5Xqa4b68JbCg4HQ9KHodRuCp9TmxxO1eWiLYMXUkpIl3nog==
X-Received: by 2002:a05:6e02:1d05:b0:331:1129:b8a9 with SMTP id i5-20020a056e021d0500b003311129b8a9mr5643487ila.1.1683566283068;
        Mon, 08 May 2023 10:18:03 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id a14-20020a92d34e000000b0032732e7c25esm2541449ilh.36.2023.05.08.10.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:18:02 -0700 (PDT)
Message-ID: <e886a835-f2d1-4fd0-8e02-82cc3a878870@linuxfoundation.org>
Date:   Mon, 8 May 2023 11:18:01 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] selftests/ftrace: Improve integration with kselftest
 runner
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230302-ftrace-kselftest-ktap-v2-1-ecc482212729@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230302-ftrace-kselftest-ktap-v2-1-ecc482212729@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 5/8/23 07:15, Mark Brown wrote:
> The ftrace selftests do not currently produce KTAP output, they produce a
> custom format much nicer for human consumption. This means that when run in
> automated test systems we just get a single result for the suite as a whole
> rather than recording results for individual test cases, making it harder
> to look at the test data and masking things like inappropriate skips.
> 
> Address this by adding support for KTAP output to the ftracetest script and
> providing a trivial wrapper which will be invoked by the kselftest runner
> to generate output in this format by default, users using ftracetest
> directly will continue to get the existing output.
> 
> This is not the most elegant solution but it is simple and effective. I
> did consider implementing this by post processing the existing output
> format but that felt more complex and likely to result in all output being
> lost if something goes seriously wrong during the run which would not be
> helpful. I did also consider just writing a separate runner script but
> there's enough going on with things like the signal handling for that to
> seem like it would be duplicating too much.
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Tested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Applied now to linux-kselftest fixes for Linux 6.4-rc2

thanks,
-- Shuah

