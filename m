Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D02EB64DD
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 12 Jul 2023 23:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232558AbjGLX0x (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232504AbjGLX0w (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:26:52 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D7931BDC
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:26:49 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b701e1ca63so122709161fa.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1689204407; x=1691796407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eX7ler/unybEEB87pkzJRfEIlGcdEpKXUpbLiHALcWs=;
        b=gK6dgVUVl9fXCQzQpwk0Vta2voZg2T1QCMWyXYVxed0R2wqtK0Zg32/nG/SF0Xf57B
         Xt/BYCWLVObpcwHdEIzl8RGpBzWgOneAqsqfh9sMfH6tH3LWWmEFf1icgvJ/tflGvk6y
         6+oxV/qHO0HPEXkMvxVw1xV8+ZgnMf8Ys62V4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689204407; x=1691796407;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eX7ler/unybEEB87pkzJRfEIlGcdEpKXUpbLiHALcWs=;
        b=MktUfJ7UtHe/F6s24NSZ5uNq+KPqFCM4KnVzU3Y9UxSGJXn1HsH67AQzkRWcTJvdhm
         Ylj+b0hhb3RAH5S4zNIhD9XmB/71cf754VzrFd473j4ubpMg+GIUURgCWA13oI1RCLsq
         OpD5ruVjxSA0WhziOtDFGwlLmy67vgJe7XsJZKYk848b/AtTIs3kJc1+H7T57sf2w8pn
         mvMacPwken0wq43INqo/MPxadozrTC+MQskx4D+F9TcyPQJkFHOwPKtRFVbndh5mdlfj
         CGtuAGhIQ5BOpHV72Q5SZ3WEd5jbl9AKZ0O4crGrUfmjHaUnzn9k0IcjQQCGg5+n1hAb
         y6Yw==
X-Gm-Message-State: ABy/qLZBOzdjmTyJg1a0j9T9M22SHRGoUWYwH3JwyoDPjqZuUVYVnD/v
        wGNj3MDG95RjXzTgCQ9ZSNtZz/vBFFeGrEAI7jxu6Wbp
X-Google-Smtp-Source: APBJJlGqFF2MtXvfen3W04ghdDJmJvVFd1jJnmZDwnsaD41WhlMIHIcXK/UaRhu4teasag6JLG46Zg==
X-Received: by 2002:a2e:380b:0:b0:2b6:ed80:15d1 with SMTP id f11-20020a2e380b000000b002b6ed8015d1mr16194119lja.24.1689204407084;
        Wed, 12 Jul 2023 16:26:47 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id w11-20020a2e958b000000b002b69febf515sm1192106ljh.125.2023.07.12.16.26.46
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 16:26:46 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2b6ff1ada5dso122792691fa.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jul 2023 16:26:46 -0700 (PDT)
X-Received: by 2002:a05:6512:3c89:b0:4f8:75ac:c4e8 with SMTP id
 h9-20020a0565123c8900b004f875acc4e8mr20148535lfv.43.1689204406009; Wed, 12
 Jul 2023 16:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230712223021.636335-1-mkhalfella@purestorage.com> <20230712190723.26ebadea@gandalf.local.home>
In-Reply-To: <20230712190723.26ebadea@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 12 Jul 2023 16:26:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgPB3kwZwJvk2jdmfw7jLKG5UAn8FMvySiJvELDZ-4_5Q@mail.gmail.com>
Message-ID: <CAHk-=wgPB3kwZwJvk2jdmfw7jLKG5UAn8FMvySiJvELDZ-4_5Q@mail.gmail.com>
Subject: Re: [PATCH] tracing/histograms: Add histograms to hist_vars if they
 have referenced variables
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Mohamed Khalfella <mkhalfella@purestorage.com>,
        stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
        "open list:TRACING" <linux-kernel@vger.kernel.org>,
        "open list:TRACING" <linux-trace-kernel@vger.kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 12 Jul 2023 at 16:07, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> I run this through my full test suite, and then send Linus another pull
> request.

Ok, I'll ignore the one I currently have in my inbox.

              Linus
