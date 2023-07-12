Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83421EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 12 Jul 2023 23:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbjGLXo7 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:44:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233281AbjGLXo4 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:44:56 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43577213F
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:44:46 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-666eb03457cso112438b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689205485; x=1691797485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=e2x+ltqpxVqFqamIdgfkuygPfrt3KBuJFxkfy8ylBDE=;
        b=eWnFNe7SQNBtWjNYtEgRxZP1V7Dwz6vm7srAxhyEqqJg5ytAHwWaCWq8C9dsq0CR9B
         kZ40nSCLfac/qsKtXdaSt7YsfLPJ9Zyz66vVoyukagRMJwAfXiq0Fzz6FnPHjsyPItuE
         B1/N2dHSOwEw7xphHwoLAwAixm9PlGQm789PQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205485; x=1691797485;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2x+ltqpxVqFqamIdgfkuygPfrt3KBuJFxkfy8ylBDE=;
        b=XqYkyRehweMKOQxDYJq1Q+uYNFvgYlyMGWLmXbmU5jWZaTODocHFdkc0pC9BcnE0dZ
         dFd0XB2I0WWQ8EeIr712zDujjrdFvBY85xhil3syWVQi3Y2iGwbwvkv/gBaY53H1wAUp
         /+fuvgpzhEy9ry8HnJowv3TwoDCRyjdgXlPctqhIt/BAr2JuWq02QChlP86562qJXBvg
         LmUYcmGcvbk9RxkFdgtte1nP72Bmm464HpTr9hy61kygthrBJsjrwZfIpE0KOPhv2do2
         9C7QA4YK4uSs4WiM6ReutxPoQfenoBf0l1jnf7EezFImaAEdxZIM6ca/CBuobuKaDUE9
         hsRg==
X-Gm-Message-State: ABy/qLbqT8+VvYMYrC1agxa++Id6jA3OCUmoCBIJsWy1/oV4yJdP+JLm
        wmEbXorHlr1U9RkEBgXGLHu8qw==
X-Google-Smtp-Source: APBJJlHKXFXT+3vQO6u1MtO+fd+vDgoN5oWHpeMsy44Y47+W6SCldG9VCty9uD8GsegZWrC3T4Gi8w==
X-Received: by 2002:a05:6a21:6d9b:b0:12e:f6e6:882a with SMTP id wl27-20020a056a216d9b00b0012ef6e6882amr20160956pzb.32.1689205485375;
        Wed, 12 Jul 2023 16:44:45 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902e55000b001b89891bfc4sm4461515plf.199.2023.07.12.16.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:44:44 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:44:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/2] kyber, blk-wbt: Replace strlcpy with strscpy
Message-ID: <202307121644.75BD707@keescook>
References: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703172159.3668349-1-azeemshaikh38@gmail.com>
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 05:21:57PM +0000, Azeem Shaikh wrote:
> This patch series replaces strlcpy in the kyber and blk-wbt tracing subsystems wherever trivial
> replacement is possible, i.e return value from strlcpy is unused. The patches
> themselves are independent of each other and are applied to different subsystems. They are
> included as a series for ease of review.
> 
> Note to reviewers: MAINTAINERS file does not specify clear ownership of
> these files so I have addressed these to the latest committer for these
> files: Jens Axboe <axboe@kernel.dk>.
> 
> Azeem Shaikh (2):
>   kyber: Replace strlcpy with strscpy
>   blk-wbt: Replace strlcpy with strscpy
> 
>  include/trace/events/kyber.h | 8 ++++----
>  include/trace/events/wbt.h   | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

These looks correct to me. I can take them if no one else wants them.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
