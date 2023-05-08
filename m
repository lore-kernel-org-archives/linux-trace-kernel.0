Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 212C3C77B7F
	for <linux-trace-kernel@archiver.kernel.org>; Mon,  8 May 2023 17:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233885AbjEHRgc (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 8 May 2023 13:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232429AbjEHRgb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 8 May 2023 13:36:31 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0685FC3
        for <linux-trace-kernel@vger.kernel.org>; Mon,  8 May 2023 10:36:30 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id ca18e2360f4ac-763970c9a9eso16101539f.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 08 May 2023 10:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1683567390; x=1686159390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M+HbhBQwCu+27FV94o7jvHpLrgJzn9eQjRRmd9ezh2M=;
        b=Ab9DrIEiUjSSy6JC7owMD4p64Az3cadSaunZHQMPx2vDDfo6mLwi96gsUsir68jSt0
         9Uu0al1HMU+wgHRUZ2v7pDWUltMcnX5x526VInhYTtHKiGbGzWr747e0M1Wus+Wwkres
         xr4+8fnHXQXCMv78mM3vNp882saMAbkUb4GRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683567390; x=1686159390;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+HbhBQwCu+27FV94o7jvHpLrgJzn9eQjRRmd9ezh2M=;
        b=fVHdnPo8VateXT3yVp93STuVEYYzVkZS81nEYA0JxZleoPTOG0jt6H5jxRO4ypAOBf
         1IRNgYawFtT4IxO1V2UVjULMnfJ/wVw7mJ8uKzJJLyslVnzYxD4Mzo2FIjBDm6LMtdXh
         KhXAigD61K6wk+MBfIb998wWUn3TEM3zXRmqmfbq4nNz1yVA/7qd0pWivYAafyTpRjIA
         dNfzdN9oiu7YQ5lJzcwXhx3h9eYkzmzpLl+ZBdDCMULC0P3dAhhAaFpF/wPsvihg0WHI
         77PSBPDEwkPfePYx38QSzDRA9RGGs6JrBAixuyNZ3l4SHopXxT9DA7PhuC/R0J1YXcIu
         CEJw==
X-Gm-Message-State: AC+VfDykx1BGLWKqTxQGzlrEJUVDlOGRIo3efLQCTqE6nD3Shg330hFL
        Pcit+9vJQpFD6WAoInTtWUDr6g==
X-Google-Smtp-Source: ACHHUZ5sL7TFB+N6wjGVWmy6uictNrM1Houg/vRzKod82AQJoveBkuCKIPoJFw8/TwhzOSnMAssAQg==
X-Received: by 2002:a05:6602:1642:b0:763:542a:f26e with SMTP id y2-20020a056602164200b00763542af26emr8204539iow.1.1683567389868;
        Mon, 08 May 2023 10:36:29 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id cs11-20020a056638470b00b0040bd3646d0dsm2109487jab.157.2023.05.08.10.36.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 10:36:29 -0700 (PDT)
Message-ID: <54bec864-5e4f-8432-a331-e4ea5fc2ba31@linuxfoundation.org>
Date:   Mon, 8 May 2023 11:36:28 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/2] selftests/ftrace: Add new test case which checks
 for optimized probes
Content-Language: en-US
To:     "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Akanksha J N <akanksha@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        rostedt@goodmis.org, shuah@kernel.org, naveen.n.rao@linux.ibm.com,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230428163842.95118-1-akanksha@linux.ibm.com>
 <20230428163842.95118-3-akanksha@linux.ibm.com>
 <20230430105231.2e7f5bd8a3f879d2330485d2@kernel.org>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230430105231.2e7f5bd8a3f879d2330485d2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 4/29/23 19:52, Masami Hiramatsu (Google) wrote:
> On Fri, 28 Apr 2023 22:08:42 +0530
> Akanksha J N <akanksha@linux.ibm.com> wrote:
> 
>> Add new test case kprobe_opt_types.tc which enables and checks
>> if each probe has been optimized in order to test potential issues with
>> optimized probes.
>> The '|| continue' is added with the echo statement to ignore errors that
>> are caused by trying to add kprobes to non probeable lines and continue
>> with the test.
>>
>> Signed-off-by: Akanksha J N <akanksha@linux.ibm.com>
> 
> Thanks! This looks good to me.
> 
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 

Would you like this patch to go through kselftest tree?
If not here is my Ack:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
