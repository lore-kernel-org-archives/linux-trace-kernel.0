Return-Path: <linux-trace-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57EC0C38A2D
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 25 Oct 2022 01:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiJYBGb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Oct 2022 21:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbiJYBFz (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 21:05:55 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627D160200
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:11:32 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id w10so1299881qvr.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TkJXjWEEV4IPx8IB5aoBytjP/YQvDH4AuK2z6X+NI4g=;
        b=PDOoNQUxhYaFTlb6u47Ovelh94d5tKzEWMvkYLgZp3kE5bVAP+9wrE1k8muv0yLeCp
         ldNNLmOuZDtT+gtEWYBnwsZqbRcrxgeAd0Pt0omhk4686IiT7Bjdnw/yybYlDfN7gNwM
         6SM3AsIYRJklbOtAyNOMGoKsYSu1k6hLh2Q/A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TkJXjWEEV4IPx8IB5aoBytjP/YQvDH4AuK2z6X+NI4g=;
        b=X1fKglDvCU6t7rvc0y2eAVlJhj7lsSs0u8vm/Hbz1P4JuKA75fYk+sFji8AIkeGWxe
         8Xt6DYoKxfbMo4SM9CUoGBmjSswCVaOCwfKEgNsX/ZHCAXXlovB7aeQLjyhRYOZEMDXy
         Kx1sgL4sJ7UD6kdiWZdleG182GeqphNU3nsV0m5mfKa17B+Lif3Kjxdpycr7YlROYDow
         CV0xakbohnsP5yUCIbJ4pQGZb2FlGS6+OjWHiD6Nmcy9u2UhAfW25TRrhUg+Pn1HJ6Y9
         MUl3/nFWkhUrHJXTwihzQnHnwTyG2tLf9ADNiRScr5H1pwSsmC6BUjxLlIEXpDExtlLS
         TimA==
X-Gm-Message-State: ACrzQf1tKZytbbufj6DVNx2zlou7FxfUxAMMWo834whav4vWUq1WDXxD
        83Bj+CjVprbwxYbR0KxOnzdJwQGbSF7vkw==
X-Google-Smtp-Source: AMsMyM4lZeWiCWUwnTP0BZfT/iuzOVpfjIVCFwh+1uXjKtimN0jHf5ru1qRbigyPx4Wkj6mDZvdE1A==
X-Received: by 2002:ad4:5c85:0:b0:4b3:cac2:d5c1 with SMTP id o5-20020ad45c85000000b004b3cac2d5c1mr29793534qvh.116.1666656690957;
        Mon, 24 Oct 2022 17:11:30 -0700 (PDT)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id d13-20020ac8544d000000b0038d9555b580sm734507qtq.44.2022.10.24.17.11.29
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 17:11:30 -0700 (PDT)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-369c2f83697so92344167b3.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Oct 2022 17:11:29 -0700 (PDT)
X-Received: by 2002:a81:11d0:0:b0:35b:dd9f:5358 with SMTP id
 199-20020a8111d0000000b0035bdd9f5358mr31581502ywr.401.1666656689597; Mon, 24
 Oct 2022 17:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221024190311.65b89ecb@gandalf.local.home>
In-Reply-To: <20221024190311.65b89ecb@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 24 Oct 2022 17:11:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
Message-ID: <CAHk-=wji4q7rGUWDLonnEnxq0ykNCcYGpMrNnZg89rAwOgyRKg@mail.gmail.com>
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

On Mon, Oct 24, 2022 at 4:03 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> This required some updates to fork and the maple_tree code to allow it to
> be called with enabling interrupts in the time when interrupts must remain
> disabled.

Yeah, moving special cases from one place to another doesn't really
help. Particularly to something as core as dup_mm().

All of this comes from "poking_init()" being a steaming pile of bovine
excrement, doing random odd things, and having that special
"copy_init_mm()" helper that just makes things even worse. Nothing
else uses that, and it shouldn't have called "dup_mm()" in the first
place.

At this point, there is no actual user VM to even copy, so 99% of
everything that duip_mm() does is not just pointless, but actively
wrong, like the mmap_write_lock_nested() when we're in early boot.

I'm not even sure why "poking_mm" exists at all, and why it has
created a whole new copy of "init_mm", and why this code isn't just
using '&init_mm' like everything else that wants to just walk the
kernel page tables.

Yes, I see that commit 4fc19708b165 ("x86/alternatives: Initialize
temporary mm for patching"), and no, none of that makes any sense to
me. It seems just (mis-)designed to fail.

                 Linus
