Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE538C77B75
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 20 May 2023 02:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbjETCQG (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 19 May 2023 22:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjETCQF (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 19 May 2023 22:16:05 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFCF1A1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 May 2023 19:16:00 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51190fd46c3so1800868a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 May 2023 19:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1684548958; x=1687140958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0gJN167bDqfq0Xjot6aQ2NfScujfQQVtYPukcrFzaM=;
        b=gCSDK8cxZ9bkLI/QiQPMUEmPNgn5oEb479hkhy5ffaI/6s6YhtuXwe+yMkcp02iyln
         irxil6mKEl7LOWXBcMbyc+HXjsFCAhVfvg7ZP2qmqKcJGJXk6G2s0dBx22carNJ3rxc0
         c13zrYZITxayNNiURHT8C6V+i7Z56StqeJAmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684548958; x=1687140958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0gJN167bDqfq0Xjot6aQ2NfScujfQQVtYPukcrFzaM=;
        b=fKaWyDUkif007dZ22zfzq1Lel2Us7TxdqjqMvEtnbUpluSSakrMVSN2pJpU9TvE7H9
         48C0iU6+MrFFdZXF2ImrzBLIuMsHEidrHjX/jU/Cd7UwceDnhkJ3GNhIrGaOFsBzvYIJ
         C/7y1kSXDG8g+kLsTXYzbueKfEDAreYrxCdFEsps+/Yxdm2vImoeGKdn+ehRbriHixAI
         ORAiyRmUqitxlijGwzOF5Og3v+YHBKS8ztQiC+w6WZL9P8n2+RTz8I+lj1YKYlXMovu5
         HPCMN6OHZQd3Xu6RsNkD6Jc6AanyNdugjtRFWKRDqwlpPJRFcex716A2RO08oOF6D9yC
         bOUA==
X-Gm-Message-State: AC+VfDwrk5pHSd3KA1VyNpr8+/hbGswdptZJEnN7q3Mm2xfTg1JzD0Io
        y1uhIeKk2RMJxzCthIiaqwPaB8ZExAy0l7TKzeE7aHdX
X-Google-Smtp-Source: ACHHUZ7cdIJVbGfiUYeh+Xeu71rJ7Nk6vq5PL1GdwsLJekJiASGnl8QbZRz8FQLUikdplnM/aO3x+A==
X-Received: by 2002:a17:907:3da1:b0:94f:956:b3f7 with SMTP id he33-20020a1709073da100b0094f0956b3f7mr3554891ejc.2.1684548958740;
        Fri, 19 May 2023 19:15:58 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id kg17-20020a17090776f100b0096a6bf89259sm260638ejc.167.2023.05.19.19.15.57
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 19:15:57 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-965ab8ed1c0so618157666b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 19 May 2023 19:15:57 -0700 (PDT)
X-Received: by 2002:a17:906:c155:b0:94f:432f:243e with SMTP id
 dp21-20020a170906c15500b0094f432f243emr3325059ejc.14.1684548957398; Fri, 19
 May 2023 19:15:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230519230741.669-1-beaub@linux.microsoft.com>
In-Reply-To: <20230519230741.669-1-beaub@linux.microsoft.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 19 May 2023 19:15:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgi1Cbe0RV0M2Fm1j1LFgC+tFMPEQhUBC1Mtk+3w944uw@mail.gmail.com>
Message-ID: <CAHk-=wgi1Cbe0RV0M2Fm1j1LFgC+tFMPEQhUBC1Mtk+3w944uw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] tracing/user_events: Use non-RCU context for
 enabler writes
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     rostedt@goodmis.org, mhiramat@kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        ast@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Fri, May 19, 2023 at 4:08=E2=80=AFPM Beau Belgrave <beaub@linux.microsof=
t.com> wrote:
>
> There was also feedback given that some of the code was confusing and
> needed further comments and field renames, especially for links. I think
> having this feedback will help others contribute to this code easier, so
> I am grouping this into a single series to address this together.

Thanks, added comments and renaming look sane to me,

                 Linus
