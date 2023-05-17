Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42515C77B75
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 17 May 2023 19:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbjEQTPK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 17 May 2023 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbjEQTPG (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 17 May 2023 15:15:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976C0D87B
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 12:14:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1ab1b79d3a7so9553615ad.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 May 2023 12:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684350886; x=1686942886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I86GqiU0YgzZjcmQYbWuXd34tQJA/R6gUQrAR3Ef4Vo=;
        b=a9BUGVeBYF7ixWNiY98NX+YR8nMPaRDXPVrEzp1DMOAcTrHdtsQyseNqO7cCzSPHTq
         hkxCLO4A3OLziF1E5Do+xEwfS6rY3QOBEJhYNvKI/HR4Dcbr96g7F1da1HYOhN2+UEgp
         ebtEQun6/IpF4T2lpL5yftuLBzWRT4BZG8O2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684350886; x=1686942886;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I86GqiU0YgzZjcmQYbWuXd34tQJA/R6gUQrAR3Ef4Vo=;
        b=EIIUKB4Nmu8BY/yIijXgFGmNM3hIrzLxY940nEigFQeKbyV3RffCYWtXmF7y8cJcEW
         uE2Utlz7kGX3kF9rYEpM2eCC6T0x8yn1b3D44mMa0fC/yQKs8y1Yk2Js74jcZwPoNKCg
         QQRwUUqga+3q0N4pNotl0Bk7S9Y99nyBb99dSyp48XRRrTYL57/t7Bt7lSQ86RGY62uC
         2eUjW+d+Kj2kaoGa5iBQKb8DzM66Q+XXrdLhEjSdJgdJEBzXzI1WHb2mtdjmxY20V60i
         X9Xun+1J8Q6XevheTD8vBhXOXhj7g53piqvw88m2KtdPJVRv3plCAP8gnQHbLQNKYNpQ
         LK9g==
X-Gm-Message-State: AC+VfDz5X4jCFn5xOQLJkLPy7dAIXI3hOl0UkXjAW4buvJ5TJ/gr1LKk
        XxeZSdlu3Ng91FJO179FFbX38w==
X-Google-Smtp-Source: ACHHUZ5k47l/bNRLiG9PgNcNSBM86j3ELSgSLeMZf8fFyVeviUlMsarseItJaDwcgLfSkjvALPfISA==
X-Received: by 2002:a17:902:b594:b0:1ae:3dcd:30fc with SMTP id a20-20020a170902b59400b001ae3dcd30fcmr5365858pls.11.1684350885863;
        Wed, 17 May 2023 12:14:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j6-20020a170902c08600b001ab13f1fa82sm376964pld.85.2023.05.17.12.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 12:14:45 -0700 (PDT)
Date:   Wed, 17 May 2023 12:14:45 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] ftrace: Replace all non-returning strlcpy with strscpy
Message-ID: <202305171214.3D13652AC@keescook>
References: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, May 17, 2023 at 02:53:23PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
