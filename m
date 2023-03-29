Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8643C6FD18
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 29 Mar 2023 17:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbjC2RmW (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 29 Mar 2023 13:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjC2RmV (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 13:42:21 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E745254
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:42:09 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i5so66715645eda.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1680111728; x=1682703728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7pRW8ZygO7FUWeXFZhnZuyISfnteILKf1nQphP6NhE8=;
        b=JxeH8MNLqBhIqISEzofqnZ89GLUuBa5KWxu3wPlB+gO1hj/KKWxYjOwuGxw/KfHhAF
         mZ/Ox5Ah5DAZyf6EQvGuoRCSWYnZv5Bd0BjrA4yZ4WSDWb1YzZP5RYYK485ui1Q++6Dy
         cZCVy9M6aNjqvY7wSBgYQU2IKJ3MbZchS2wsM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680111728; x=1682703728;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7pRW8ZygO7FUWeXFZhnZuyISfnteILKf1nQphP6NhE8=;
        b=aYrvKJVu80bW4fWwCYMAgTUYkO3KEV4SNZafNjaBZzwyBJYQQDmpl0E/R0VBP9xzWH
         wH6aXQmjHSlfBZ9XOOvGJN8qWy5Aq1fZWiECAkgjDqfitFKe2XvgjQhRKs6pKAfUyvJm
         SHLx3HTjfU5UkfcvtZYF2ZvvyQ3uLBqyA03hxwhG3AUVcuHMGOWoOuLhOoihPiPmIlN7
         ts/65gDkfR8muNXoIfzZkZlCmMNLcHuJB2ys1LIGbnEik5YtgL94hHThhJfDWa7PmFxx
         8gLtqPbYke05lTOMOOkWvEpm5Rp2qhTTdazPrw+Cq1XTNoIq0hHIxnCIOEjzZdBuPoKK
         RHMg==
X-Gm-Message-State: AAQBX9drs9D2QEMpxzeJNi7Z1WXK4InRdjwCed9Kd6px0wGuc62MfqZj
        ag+G3pSx8M1FeXKBtIzMJVw+FS8IAWwSXmOBWWE84jms
X-Google-Smtp-Source: AKy350YLnommUtuApdpROxOOP/k+esk9d3cgceQAJnWzwvgJQjcqCp2DHkPh4PzVUyY9QAZpMlueqw==
X-Received: by 2002:a17:907:a808:b0:93f:fbe:c389 with SMTP id vo8-20020a170907a80800b0093f0fbec389mr17664232ejc.13.1680111727815;
        Wed, 29 Mar 2023 10:42:07 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709065f8a00b0092595899cfcsm16710451eju.53.2023.03.29.10.42.07
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 10:42:07 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id b20so66548889edd.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Mar 2023 10:42:07 -0700 (PDT)
X-Received: by 2002:a17:906:2456:b0:8e5:411d:4d09 with SMTP id
 a22-20020a170906245600b008e5411d4d09mr10331819ejb.15.1680111726812; Wed, 29
 Mar 2023 10:42:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230306122549.236561-1-douglas.raillard@arm.com>
 <167821082479.1693.18260840022075703789.git-patchwork-notify@kernel.org>
 <20230328190306.3337b7b0@gandalf.local.home> <ZCOH9pc3hBKU3G3Z@google.com>
In-Reply-To: <ZCOH9pc3hBKU3G3Z@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Mar 2023 10:41:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg=VDrd=kR7Q4DrvJ5yapinKfCmHiFSty3k5CTyawMmDg@mail.gmail.com>
Message-ID: <CAHk-=wg=VDrd=kR7Q4DrvJ5yapinKfCmHiFSty3k5CTyawMmDg@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix f2fs_truncate_partial_nodes ftrace event
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        patchwork-bot+f2fs@kernel.org,
        Douglas RAILLARD <douglas.raillard@arm.com>, chao@kernel.org,
        mhiramat@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 5:36=E2=80=AFPM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> Thanks for heads-up. I sent a pull request having the above patch to Linu=
s.

.. and it's merged now.

               Linus
