Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C512CD37B0
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 18 Sep 2023 08:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbjIRIiH (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 18 Sep 2023 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbjIRIhr (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 04:37:47 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D49E7
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:37:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-503067bd530so321650e87.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Sep 2023 01:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695026251; x=1695631051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l+QC3uvRAP/qwqfmL2VbNl9H9w4JnwrITUvS9mJuYN4=;
        b=coQE0q1QXizI6/zxln70piCSkLCmAJJE7+aXzVoZtmc43KOeEcMmz4fEFKBJOm0eA/
         NHvwlVBZNf1YW67Kq0DotflHJLW7AYAWK19beTuDXN0+JFQmjVyRUXf5LGD8nUmZ2r6r
         rhGLsVXcAO8PV+86QEwlLjdXz42Umn5WIAtfSY/B/IElMQG8Qp+dX3yHZkoa57CnrksN
         qrOqkf1iQXSdJlBN8KO0MfRBgDqAEq0sYK1vc3zNy6ebyPmOrpyeWm5jYq9UMhhKmP6D
         gCgxFVmGcYA3uRlcFmwbS/h3orRN2Ezo1bo5njba/rrRucimQ3yG8UpoWv3VBizAd2FT
         lvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695026251; x=1695631051;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l+QC3uvRAP/qwqfmL2VbNl9H9w4JnwrITUvS9mJuYN4=;
        b=sV2HGmB6C9p4AO4ZGqMOplb7AXDaE4UXt7JHIRQSc/CfNtTvtjqinpKNxVPIc7D1pN
         Fz48CwXshXcU29eO9ohJTjeUyaH9nASSKE3ZHJT6zqgwb0tkuLoF8Aiu+QA45FggNVFM
         yFX9ZhTVjQw/QHy4ofoqykj/1FAz5QeKvajLcMMBf6qnNfZA0My0Av7btc1rnRqpktkP
         C5bObK0Eon/QIo02YoSkzWBwEdlKonZFxGAxVDeofP80kVSSd8zAE9zp5srYI2MCP2CO
         dENrBOmW5hF+n/l5kVtiBYbuF5LlEpzjNDcYIQ0E/LYiaf44F1IVG2eBCqmyh4q53/WJ
         dFxA==
X-Gm-Message-State: AOJu0YwqH6DDx1Q6ESYkueRCXAu4pepw726UPya29TYZw2JkiiLqIWU9
        6N0wd5IpfA3QwZ2dYCmKCT/h6DrbXRYPyz6kulYweQ==
X-Google-Smtp-Source: AGHT+IGqlyUHqGssPW9OItxaQq+8XrdPXTEEGva1/JuVqIRzAHPdyXcTigzqELXnHgp+vzlARJInWA==
X-Received: by 2002:a19:ca04:0:b0:503:46c:5577 with SMTP id a4-20020a19ca04000000b00503046c5577mr3420792lfg.3.1695026251229;
        Mon, 18 Sep 2023 01:37:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:999:a3a0:3e7c:f127:3270:503e? ([2a01:e0a:999:a3a0:3e7c:f127:3270:503e])
        by smtp.gmail.com with ESMTPSA id j3-20020a056000124300b0031fb91f23e9sm11992220wrx.43.2023.09.18.01.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 01:37:30 -0700 (PDT)
Message-ID: <086307ce-2d0d-4cf7-98c8-66a00ddec2aa@rivosinc.com>
Date:   Mon, 18 Sep 2023 10:37:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing/user_events: align uaddr on unsigned long
 alignment
Content-Language: en-US
To:     David Laight <David.Laight@ACULAB.COM>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-trace-kernel@vger.kernel.org" 
        <linux-trace-kernel@vger.kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>
References: <20230914131102.179100-1-cleger@rivosinc.com>
 <94183afa1fca44d18459da3d12a155d3@AcuMS.aculab.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>
In-Reply-To: <94183afa1fca44d18459da3d12a155d3@AcuMS.aculab.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org



On 17/09/2023 23:09, David Laight wrote:
> From: Clément Léger
>> Sent: 14 September 2023 14:11
>>
>> enabler->uaddr can be aligned on 32 or 64 bits. If aligned on 32 bits,
>> this will result in a misaligned access on 64 bits architectures since
>> set_bit()/clear_bit() are expecting an unsigned long (aligned) pointer.
>> On architecture that do not support misaligned access, this will crash
>> the kernel. Align uaddr on unsigned long size to avoid such behavior.
>> This bug was found while running kselftests on RISC-V.
> 
> You don't want to do it on x86-64 either.
> A locked accesses that crosses a cache line boundary is horrid.
> So horrid that recent cpu's can be made to fault.

Hi David,

Thanks for the additional information.

> 
> I'd also doubt that other cpu that can do misaligned transfers
> can even do locked ones.
> 
> For x86 (and LE) the long[] bitmap can be treated as char[]
> avoiding all the problems.
> 
> Perhaps there ought to be bit a bit-array based on char[]
> (not long[]) that would be endianness independent and
> use byte-sized atomics.

That would work for a few architectures but I don't think all of them
have byte "grain" atomics. So I guess Masami solution (long aligned
set/clear_bit()) remains the best out there.

Clément

> (IIRC that is still an issue on sparc32...)
> 
> 	David
> 
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
