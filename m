Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA644C54EAA
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 27 Jan 2023 08:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbjA0Ifm (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 27 Jan 2023 03:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232250AbjA0Ifl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:35:41 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C3027D4D
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:35:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id h16so4222482wrz.12
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E1MXSY3rxyZv7oYRMbdKewaRZvNjQ1La+QB0aVR9VI0=;
        b=qZ38EvBg8VptNiykWvMC1NbBDCBX9WyCSEFOzQAY+ivi/UGuMHCwxHziwMNyWRoqcN
         I0pmEdko6WdIMiq/1euNkB1XtVr3IpzVoQJDyKFlLXz3zo5f4ILHWShDLe7OhV7KKLUU
         AfmEHvybUrHuURy+ijAZuWfr3y1y7mzKsrxqJOC+fq8cV96TPstx8mTN8WOuUOFLMD/L
         gCN3JP4aMfjnLGUg6mO+WldxooZc60hX3V181kbox5KMOctnpT8yQ0TzUGs7UrGlmCXF
         /thfkpy67egEt5xNZHmyVQW886BoHqQP1sHvTvb9+8rszdS9xa+p0A77P2Iq8G86q8Fr
         QkqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E1MXSY3rxyZv7oYRMbdKewaRZvNjQ1La+QB0aVR9VI0=;
        b=R0C2OutCd30zuQzmptKZfBkebXxjBtFnpa/Vr/EkiO9QmQI0MqeBIB+GLoNtgP+XYT
         BMLp+jHjd27ZllQVuEr3TSeym2xyR0cNXM+AFlX4Ui3H8tUT2opIWh8FQule+0XOQugi
         AMMydCAPQ75GYR9LY1UDx/4YoGcHIGe/MgJAJeBK+Yl4etweJi8PgJB3+7wmGNjaJzpD
         vabxmRltsYQjfDxSPhbjpgRI/q104duvZYVS83OFGgjmsFXclsVbf1LBxnJ8kAZppgC8
         Hwl300MK8xbm6+K6zxOf1WSibW6tRzZG5dBWEyElP/dsMGVdNGAnJ+0DtzDHB/RmRmsv
         JzWA==
X-Gm-Message-State: AO0yUKWiR0g/nQ5rI9zxoujjYXmkbEKq58r+a4TmpAXxNCKl5hatzdbK
        s2qqiY+yDz9jkgJoi8z5QGHfOw==
X-Google-Smtp-Source: AK7set8UJconY9qQeUcYAj0kv3Je4yBu9+zs5tJNmqzZ5c/NiYihoCwdZ1htlgeVPjVVQG7skh6hCA==
X-Received: by 2002:adf:ce02:0:b0:2bf:cff4:1d68 with SMTP id p2-20020adfce02000000b002bfcff41d68mr2176069wrn.0.1674808536878;
        Fri, 27 Jan 2023 00:35:36 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id u6-20020a5d4346000000b002bc84c55758sm3927558wrr.63.2023.01.27.00.35.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 00:35:36 -0800 (PST)
Message-ID: <6393b234-b3b7-6de1-ffff-2c8f1cec4fef@linaro.org>
Date:   Fri, 27 Jan 2023 09:35:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 1/2] dt-bindings: fsi: Document the IBM I2C Responder
 virtual FSI master
Content-Language: en-US
To:     Eddie James <eajames@linux.ibm.com>, linux-fsi@lists.ozlabs.org
Cc:     linux-trace-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhiramat@kernel.org,
        rostedt@goodmis.org, alistair@popple.id.au, joel@jms.id.au,
        jk@ozlabs.org, andrew@aj.id.au, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20230126213123.884125-1-eajames@linux.ibm.com>
 <20230126213123.884125-2-eajames@linux.ibm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126213123.884125-2-eajames@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 26/01/2023 22:31, Eddie James wrote:
> The I2C Responder translates I2C commands to CFAM or SCOM operations,
> effectively implementing an FSI master.
> 
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  .../bindings/fsi/ibm,i2cr-fsi-master.yaml     | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fsi/ibm,i2cr-fsi-master.yaml
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

