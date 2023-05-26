Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF03DC77B7A
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 26 May 2023 17:45:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237022AbjEZRp6 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 26 May 2023 13:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242349AbjEZRp5 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:45:57 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B998AC9
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 May 2023 10:45:53 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64d2e8a842cso964695b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 May 2023 10:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1685123153; x=1687715153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+5DzB4Uzd4xa8xYGjieJgku2UHj5urdPOoD2PaVWUPI=;
        b=VIyL8+8258eQJQQy0ppluvuHLZmENur68RXTIL9ksZLnAGLcJwxmysELDt/qFMwiBo
         Hfq3aDF7mzw/nh3/TFyD4LuumKzwkoZt2TL2+n/BTLPQ0uLkcmskMwo/p5zsI+n9jFqH
         7AxsX/KU7i7MKlloMwu6np8PmHzZOofUBstPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685123153; x=1687715153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+5DzB4Uzd4xa8xYGjieJgku2UHj5urdPOoD2PaVWUPI=;
        b=SfAwJ/m4Tg/PLZzFDBbBKSxm3d5eaqw7lH9zYt8BNE6SfpLfjmbQ21Jf+zpsaii7sE
         nyMV5E/Y1jyvfyUNET2lLQLuLrtBb7G3l5FMT/tqCte2nfJiwlBl77qQf+dR2CJPXYtL
         rq1xReyIRT9UySHTmCgFfOStv2bgNiyd2tvBVYVvGslSALt8Nj+p7oCymNvzbl/g+iXq
         9cknaFntIbw+00XDA6g/iI/Fayy/q+YH8hJU6PKV9+2nZGpVj/2tvOBOm5hp/VMPYXUm
         yfbo29ifLRwbw264K3C5xiCqhXNTaonTQ3fvNeUHiSxbTpd7vq8cifcLPxhB2pbO0WkP
         M0Vw==
X-Gm-Message-State: AC+VfDyFcbbN9PgDvqiRWhsjW17iE/vl4Cf24BzqoqI5wtifUYGsIlfi
        QRA2qRTMhJa7nb1CJgFYCtamsg==
X-Google-Smtp-Source: ACHHUZ6bTR68Ulp3H8mCx5n9ISJvVraQuZrPuB0WoFzw2xKwVW0k2ZrQQwLo/O/F1jxVhyQvxBu6bQ==
X-Received: by 2002:a05:6a20:3952:b0:100:6f8f:7793 with SMTP id r18-20020a056a20395200b001006f8f7793mr229404pzg.3.1685123153201;
        Fri, 26 May 2023 10:45:53 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a9-20020aa780c9000000b0064d45eea573sm2985689pfn.41.2023.05.26.10.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 May 2023 10:45:52 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     mhiramat@kernel.org, rostedt@goodmis.org, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com
Subject: Re: [PATCH] ftrace: Replace all non-returning strlcpy with strscpy
Date:   Fri, 26 May 2023 10:45:49 -0700
Message-Id: <168512314590.441353.7220379541429337017.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
References: <20230517145323.1522010-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 17 May 2023 14:53:23 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> No return values were used, so direct replacement is safe.
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] ftrace: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/bd35ef4f612f

-- 
Kees Cook

