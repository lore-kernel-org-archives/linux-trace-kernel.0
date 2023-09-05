Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD8FEE49AD
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  5 Sep 2023 22:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242263AbjIEWnz (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 5 Sep 2023 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240329AbjIEWny (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 18:43:54 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2361197
        for <linux-trace-kernel@vger.kernel.org>; Tue,  5 Sep 2023 15:43:50 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-34e1757fe8fso2927145ab.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 05 Sep 2023 15:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1693953830; x=1694558630; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOTcI+9//H2lUESDf8fGU/u6Gg9kO1Rtidgzn+n90N4=;
        b=R4D83kFSz85SHYtdj1ECfwAvbwDEUXhEx90rxgxgZAMJHavtnFueJp0oBrGKxuNTPf
         pBFQzyQUmx3XhiPzQrgjA3LRUwM4NUzMMAg8Fw5I2FNU+B1E6z6srOZ4ekUSLag4GLiB
         ySqdr6Pb5A5i3BsRdCm7OAzuT9PPr58c59CS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693953830; x=1694558630;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOTcI+9//H2lUESDf8fGU/u6Gg9kO1Rtidgzn+n90N4=;
        b=AhWRiZFdqHt/C/s2qS5kqevtoJdm0djOeaxvTBoDSZOfhUO1fDS3veGZzGng//tZJO
         Mm2w8gWKScJqB9L2RjYfwBYA031Yzx0U5b/3StWIfrGPQcTzYgklOcSZnXrPGU/1E1mN
         yRq2rAu6aS4ZgPket+0DoiKx/gd63ogg/9DRc4q4Pat4EHVN0+G8/lAkOgMWN4wEVwAr
         GIGKrMK0ZAwAettewZDdGYDupvHUxzQX8y9hd6zyTkGAaGxtdeegno9U08YujC4yQLSo
         fG+4PNDVLG09Abb2zp4UiwOjKUI51+i6acWh1FVajDaH3O1ySEaGLvo9gYbwZeeNhIPT
         D3dQ==
X-Gm-Message-State: AOJu0Yy/KVfNTvR5vyksBphnHo1woo6jwb8UKcIIIbawXlSXd+OuCh7X
        EEZxkxF4bKW8TJdAJA/hG7hL9A==
X-Google-Smtp-Source: AGHT+IGV7huz8CTpzeedsJJ9k3WQc+9GgYXsqJm9TAT1KbJlKxeNY5RfhRa5UAm+a1XMJSTC+q+GAA==
X-Received: by 2002:a05:6602:1588:b0:792:9b50:3c3d with SMTP id e8-20020a056602158800b007929b503c3dmr16196656iow.1.1693953830046;
        Tue, 05 Sep 2023 15:43:50 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id y9-20020a02a389000000b0042b144abf71sm4390653jak.179.2023.09.05.15.43.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 15:43:49 -0700 (PDT)
Message-ID: <602d648b-a32b-fa97-a527-d924f74578cb@linuxfoundation.org>
Date:   Tue, 5 Sep 2023 16:43:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] selftests/ftrace: Correctly enable event in
 instance-event.tc
Content-Language: en-US
To:     Zheng Yejian <zhengyejian1@huawei.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Ajay Kaher <akaher@vmware.com>
Cc:     shuah@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Ye Weihua <yeweihua4@huawei.com>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230626001144.2635956-1-zhengyejian1@huawei.com>
 <20230626191114.8c5a66fbaa28af3c303923bd@kernel.org>
 <20230626191255.53baab4ed48d7111dcd44cad@kernel.org>
 <20230710183741.78f04c68@gandalf.local.home>
 <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <1cb3aee2-19af-c472-e265-05176fe9bd84@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 9/5/23 06:54, Zheng Yejian wrote:
> On 2023/7/11 06:37, Steven Rostedt wrote:
>>
>> Shuah, can you take this?
>>
> 
> Kindly ping and bug report :)
> 

I am sorry for the delay. Looks this one got buried deep
when I was away on vacation.

Applied now for my next Linux 6.6 update.

thanks,
-- Shuah

