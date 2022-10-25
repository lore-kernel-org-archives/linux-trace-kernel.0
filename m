Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6487DC38A2D
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 25 Oct 2022 01:27:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbiJYB1V (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbiJYB1C (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:27:02 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4872C7C300
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:02:52 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id w3so6688722qtv.9
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6x4NyeHIOb8xnnvnRIlkAggzAkRP4Y6+NCcjWrSgBrw=;
        b=IQ2h5W/VdXcKcCHqZdhxMIgDZ36eLpFiMnCu+wiKIn/Tp7DodYCzwFOutjpjlySJZR
         vpE2tn82bO7UEbAXqNq6PQPZyK500l+Je3siM1BUgKglFvjBTx/thHbAYntOfut4L/lf
         HmkKJ00EAIxPj9lNiSx5HYNgBpcftcBuKvnjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6x4NyeHIOb8xnnvnRIlkAggzAkRP4Y6+NCcjWrSgBrw=;
        b=AT3SqzUxn9SqdCj7xBqhiPIFciQV95wN+5owlN1h3lLxGbAzJVVbbIw/6N1FJ4olMK
         2UwxfLbX/n9kCBXZCUcTIqeBytdUbL8qiWBnDZu5B4R7F5xiE1BSLsITvAv9DxoKgWVE
         LQKKHRVUXKTAetG+/WIkUeYh2FJkP+qpIJdKuya30lRttoX2eid8WLbqzEWyljmCWxnf
         w93aezwx4S+YN3zU4y2pkUW3qs6GQw/bomNJ3RyZoUBIakPZqeLjfmu28jU8PbyoKz62
         8at7e/gjTamokEY4Z/QB7NbCi6vBkfUPWptHfrzj3/beT93JlFu/0k/o5WbjwLAZDvCR
         yNXw==
X-Gm-Message-State: ACrzQf3SxFOJMNhLH8aK/Wd+JYFgxHzz+sBosPovHWkgmxFwXSx9PoZg
        PjswYyHNuK8AWwcslSE5yeXw0JZ7xuYygg==
X-Google-Smtp-Source: AMsMyM7a5I99xB0wlGjkfrYDoR89b0tQXqmvnOnO6SgU/g9eiVP9CiewcvmRhxeuX/ENexD3sA2NHw==
X-Received: by 2002:a05:622a:589:b0:39d:a2f:b92a with SMTP id c9-20020a05622a058900b0039d0a2fb92amr21858427qtb.664.1666659770551;
        Mon, 24 Oct 2022 18:02:50 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id v17-20020a05622a015100b0035cf0f50d7csm837404qtw.52.2022.10.24.18.02.48
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 18:02:48 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id y72so12839137yby.13
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Oct 2022 18:02:48 -0700 (PDT)
X-Received: by 2002:a05:6902:124f:b0:66e:e3da:487e with SMTP id
 t15-20020a056902124f00b0066ee3da487emr33367907ybu.310.1666659768246; Mon, 24
 Oct 2022 18:02:48 -0700 (PDT)
MIME-Version: 1.0
References: <20221024190311.65b89ecb@gandalf.local.home> <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
 <20221024202133.38e0913e@gandalf.local.home>
In-Reply-To: <20221024202133.38e0913e@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 18:02:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
Message-ID: <CAHk-=wj_jxetFqMB8VWcJdtOt+CU0r_isyGV4AhEYFxA7YsU7Q@mail.gmail.com>
Subject: Re: [RFC PATCH] text_poke/ftrace/x86: Allow text_poke() to be called
 in early boot
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 5:21 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> It's all about updating read only pages that are executable with a shadow mm.

Right. And it doesn't actually need the mm at all, all it wants is the
kernel page tables. Which is why all the "dup_mmap()" stuff seems so
wrong.

I suspect mm_alloc() does everything that VM actually needs.

IOW, it shouldn't have used the fork() helper, it should have used the
execve() helper that actually starts out from a clean slate. Because a
clean slate is exactly what that code wants.

No?

           Linus
