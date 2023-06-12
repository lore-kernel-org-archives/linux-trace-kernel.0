Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 578F7C7EE2E
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 12 Jun 2023 22:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235996AbjFLWmN (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 12 Jun 2023 18:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjFLWmM (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 18:42:12 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853AEF0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:42:09 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id e9e14a558f8ab-33d0c740498so3131005ab.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jun 2023 15:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1686609729; x=1689201729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n7YHPra9JUFwBLRAu6FagKmsw70SS+E9C1XBRBKRg5s=;
        b=ZUqqtdVYFiVDpHmcGqjiRcBr8CRxP0yNdKI+rwCkpts/Ne+uj04VCEb+FtYP3CTUYu
         QFD7IYLRjFuEaLd/2p7euIuxlRQuuCRnZo6WEDAecFUYQjNxSQkU44bJWUUHSSZEZ3h9
         K92Cv+uQz8Z91qJMd2hkvcjQRXkV3sKuy1fGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686609729; x=1689201729;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7YHPra9JUFwBLRAu6FagKmsw70SS+E9C1XBRBKRg5s=;
        b=azi548fZ9TzlL0CX1DTzBCVZsM719DmxtaA2KY37yqWthtLhDRpJDG0wyYXzYbwv+1
         dMlhoualE5J8cYZV0zDIYUgoGvTewS+ML5yEUaD7xOCJ9HFX9Thu4Kr6hsvobOoaxFb2
         rnYCJWe1+bvvNS3kLIg1nxqYRLQFiKPI6sXxy8ZKAgB+SNuTUI+Ahk0ZOU7Ufjk8RZaO
         J8V8Iwg58LK+cnE0NGbMUow78CjMZAaxoXXH4mSHjRwvG0lH9EmolumqBiSG3rrh3SYf
         q28mHJ1tZf9hvDEp+yx6r/NpB6GjiKmSXF245FQVO1JRfqs6V6HlLpwKlIGTcG9tDt0Y
         7yAw==
X-Gm-Message-State: AC+VfDzkcGXy4bRRNFe45sZucWvTWh3k/gtWEYc4fr1iqZzQzcsuAzcb
        KnviqBiOxS3b4vDGxFh2+2mQdQ==
X-Google-Smtp-Source: ACHHUZ4V8W3LPivr0RC5GMwG6+UDc2130wZaPnjzEmav46f5Z72XKLk6HVj3+kdmfVYC7Ur3rKgIMg==
X-Received: by 2002:a05:6602:1789:b0:777:b456:abbe with SMTP id y9-20020a056602178900b00777b456abbemr5545396iox.0.1686609728883;
        Mon, 12 Jun 2023 15:42:08 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id i12-20020a02ca0c000000b0041869299cb8sm3148692jak.15.2023.06.12.15.42.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 15:42:08 -0700 (PDT)
Message-ID: <9748dac0-efda-0208-26fc-1de948534689@linuxfoundation.org>
Date:   Mon, 12 Jun 2023 16:42:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] selftests/ftace: Fix KTAP output ordering
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20230609-ftrace-ktap-order-v1-1-0abf4d0d6922@kernel.org>
 <20230612143316.1851a0fd7a49971f1b2209bf@kernel.org>
 <20230612101036.2c20c86d@gandalf.local.home>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20230612101036.2c20c86d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 6/12/23 08:10, Steven Rostedt wrote:
> 
>> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>
>> Shuah, could you pick this?
> 
> Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> -- Steve

Applied to linux-kselftest next for Linux 6.5-rc1.

thanks,
-- Shuah
