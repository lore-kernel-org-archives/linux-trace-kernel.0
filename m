Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCA6C77B75
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 16 May 2023 20:11:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjEPULT (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 16 May 2023 16:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEPULS (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 16 May 2023 16:11:18 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB28A59E5
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 13:11:17 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ae3ed1b0d6so547845ad.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 May 2023 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684267877; x=1686859877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nLgrvnIbTez+ozLofGFvlDwgzYOgc3jwqI2qiIMZDlc=;
        b=fwxxiq7jxyRdl/2cy/Sv+GQ5mQiGF2Lstfp3s18yImRvFgABuVehmXn56JwCzbRdhQ
         KKufXmevtlLM+BTCz8VLc/cV+T/YAzLqsHnyHdPBjeUiw9eAvpKfIulQlnKV0CKwMsFA
         jKjaL6cYIgkSXEiU+Ok8enWf1b1VtTDsVqZng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684267877; x=1686859877;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nLgrvnIbTez+ozLofGFvlDwgzYOgc3jwqI2qiIMZDlc=;
        b=Jt0xFtBE2aVGI2IEH2aVTmnjfdm5hIdIOvrpvsWstdMUYX5WNA6Bp75q7IPVy85jyw
         bcx6ivJVV5M8cqxliC1SHPHnH5nKJx/LiUyuBrwV8n0v0jxZCv7kqZ4VMf9UZW6D3cYp
         fcKQpbn0g3y0vKMBVSU9LiEkqLZSD/nb1HfcKfKjpc+tewZEOR0JY9xPYbtTZ22NOaL8
         7wvNQ1aw8G3A/6ajBVV9tKlcx2GE6nHMIRCJMu81mdDiVs/sOTMbkYLFXq2XyG1vsvh9
         u6uxczIzYnoXDHiEMXlg0pUwaArruqzZPNp5VhSiLBebUIr6KMptPswQg8hlHz2EXSJ0
         Fsqw==
X-Gm-Message-State: AC+VfDxfO/d5iG8J+O/pESbgUZFPb99qDgYesDY5fdnJTtmpxXI0yqqb
        6JiRgHvmiSSksMcgVHuKb/xnWzayx6NQ5T+sw04=
X-Google-Smtp-Source: ACHHUZ77IQniMgR4Y8NUBFcCMRu/KSrWXIuCgUNNDXjyikpYHkbmnL7WvFx0Bd2z/BIHgQdZGCLeMQ==
X-Received: by 2002:a17:902:8c98:b0:1ad:be4d:5dfe with SMTP id t24-20020a1709028c9800b001adbe4d5dfemr21153767plo.27.1684267877266;
        Tue, 16 May 2023 13:11:17 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p15-20020a1709027ecf00b001a1a07d04e6sm16019154plb.77.2023.05.16.13.11.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 13:11:15 -0700 (PDT)
Date:   Tue, 16 May 2023 13:11:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Replace all non-returning strlcpy with
 strscpy
Message-ID: <202305161311.0A9B37E131@keescook>
References: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, May 16, 2023 at 02:39:56PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement with strlcpy is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
