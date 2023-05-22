Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F8A8C7EE23
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 22 May 2023 19:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235112AbjEVTkK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 22 May 2023 15:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbjEVTkA (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 22 May 2023 15:40:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5CE9E
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:53 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-52cb78647ecso4516423a12.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 May 2023 12:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1684784392; x=1687376392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ceByCrhQgy1xUUUVzV543Wg3Hs/zTuoTP3ZtYqzShtI=;
        b=Y9+znyw3UTpuwo7EhaJN8to/oNZXF2OZjOrsPlDS8BAU5YcbHs6czktV2TGVEssfjY
         mFQyXda376uK9q3UwNbvE3p+f/rW5QwBVE9Nj0LwehQToBVVw2BoZy5sO523UTw/7b9d
         F+BJivvRm5xZ60d6loAyMOROFnPCWvlQp0JNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684784392; x=1687376392;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ceByCrhQgy1xUUUVzV543Wg3Hs/zTuoTP3ZtYqzShtI=;
        b=lIRsXyeKdPJV8kzl3Q1wi3Ef0+P7a7HYUUhqQwdyU/ZTaaokC4KzEkhHUb74VspC7/
         Tz2oBjS3XMKtt4aEf33cWZbJc685e4xctRekBkXYp94/+nTEx07eBqzCqElvEVQXS9gr
         3e+042KQPtdF6MYTKJvXIiSX/sZqSjB9WqwJI2n+06ttQur3SkFAwG2SRXypXhIRQVTC
         SU5CpxdcS+rSWWvWxQM3DWv0z8ly1ylDc3llZrBQH+PFNd0ZA4fXhIr84VU0PBqCieOC
         SyKtRSpoQsvzrc0gNKI1oCrQKkN3B3sp/tPrteOGoPoLg2di5phxfAc1f99cifDHJx09
         x3Tg==
X-Gm-Message-State: AC+VfDzP98NErxxqJC2jabPzAd99KrGin3gKK4UaHRikzpYbLK9zlW+J
        +vZzJ96Pxv9a4/nWVd9WUYEdVw==
X-Google-Smtp-Source: ACHHUZ4enFeof6uNQGr38VRobeFDvzOpVKl+AZWYMMe+2ttBbmcmP+tA64Za0AZigVUFPs8S+ijvwQ==
X-Received: by 2002:a17:902:bf06:b0:1ae:2e0f:1cf6 with SMTP id bi6-20020a170902bf0600b001ae2e0f1cf6mr11396208plb.36.1684784392569;
        Mon, 22 May 2023 12:39:52 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id ij25-20020a170902ab5900b001ab2592ed33sm5331973plb.171.2023.05.22.12.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 12:39:49 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     rostedt@goodmis.org, mhiramat@kernel.org, azeemshaikh38@gmail.com
Cc:     Kees Cook <keescook@chromium.org>,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] tracing: Replace all non-returning strlcpy with strscpy
Date:   Mon, 22 May 2023 12:39:42 -0700
Message-Id: <168478437626.244538.6559937483217152450.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
References: <20230516143956.1367827-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, 16 May 2023 14:39:56 +0000, Azeem Shaikh wrote:
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
> 
> [...]

Applied to for-next/hardening, thanks!

[1/1] tracing: Replace all non-returning strlcpy with strscpy
      https://git.kernel.org/kees/c/4cb4e5158b89

-- 
Kees Cook

