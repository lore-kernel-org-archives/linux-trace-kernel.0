Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B60DC83F37
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 31 Aug 2023 21:08:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbjHaVIg (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 31 Aug 2023 17:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244408AbjHaVIf (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 17:08:35 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD641107
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:08:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-68a3b66f350so1091634b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693516109; x=1694120909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vdS6aEw25mYoGsnnq+Zex8meOo2Y1HUCQC1ip4dfp1s=;
        b=kwVIlVcTfzt+KWLG+1QxfliQ0vfeuWKZs+EVHZi04zykGTKKvMn0FdK2p+8CO13npp
         zqXju9sqeWMu24HuE1+TisbyGNK4tfwHmW4kcoBDytClrdh8Zk0AZ3WfwCYWmmjmVZ7A
         Qo45c4AxUImEljx0m1GQCU2d10Om+PQmPUBG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693516109; x=1694120909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vdS6aEw25mYoGsnnq+Zex8meOo2Y1HUCQC1ip4dfp1s=;
        b=EZW7MFYSEQzp3F3LNA4wTLfg8043d5kLBs09WWfrfzd2ovQV88rQaqyuFNSrzdR2Ku
         wb8ta0WJY/amPfXjboE8deyy0BfaRzIj2uPYp4JIxCdijd81qvvS+VLuUYIX5KNstfkB
         KV6lJEa8F37mjOlXMMyO4ecqSDXzGsJ4wVEXPVT2UXx91lMQTo/v7/3w66d0k5V/0AR1
         5YSyvkvW/KvT+cVevqSFGD+jOg7hSkNWijZvgaiINa71W9BG1it0LEKHsrr4WxqcJx08
         1CLmtyX/SltooCHKrs+5Sag5Hjwt/Lr0Ap09G3OCu+X2R86Vt2+rLdm4YBqcIVAzar3N
         7YEA==
X-Gm-Message-State: AOJu0Yx+78wBjVk4sYQL/1Q8wIv0tBKYRAx5/PNORPoIL38N6Q+i/47L
        LK1fY1jBxrm7Nv25A7OHRl04AA==
X-Google-Smtp-Source: AGHT+IG3xkW1wQZbnGgPAEUzCt2GSCDdKOHcgxWVXIAe2RZ1/F3iEGAIqwPDUkiNDC9TTJhgLxQd/w==
X-Received: by 2002:a05:6a20:978b:b0:131:c760:2a0b with SMTP id hx11-20020a056a20978b00b00131c7602a0bmr835978pzc.52.1693516109106;
        Thu, 31 Aug 2023 14:08:29 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id j22-20020aa78016000000b00682868714fdsm1746918pfi.95.2023.08.31.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 14:08:28 -0700 (PDT)
Date:   Thu, 31 Aug 2023 14:08:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH] trace/events/task.h: Replace strlcpy with strscpy
Message-ID: <202308311408.A73103C41@keescook>
References: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831194212.1529941-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 07:42:12PM +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> No return values were used, so direct replacement is safe.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy
> [2] https://github.com/KSPP/linux/issues/89
> 
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
