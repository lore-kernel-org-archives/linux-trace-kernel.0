Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D25EB64D9
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  6 Jul 2023 11:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232308AbjGFLbF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 6 Jul 2023 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGFLbE (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 07:31:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B2F199C
        for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Jul 2023 04:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688643018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IUyIouoC8ahxmdxehnDEnuXDxYXuSzzBD+vRAySsvH8=;
        b=JppxA5gkv0z2zSIqNak0EcK/+02w/7t3NqeBBD4PaFhbFHZVleG6qiY+PlGOOO0jD8NtY0
        VyFH20fYF7RggygsLhZ4FS8nGgQHvvZbQigZbyGNZxW2BtYLn5VOqcgnYGlkppFuxcn1VD
        aOGOEB1hOa0/nHPrFxso/QgRscFZ9C4=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-yYKz6FsGOuixRfckPH2-_w-1; Thu, 06 Jul 2023 07:30:17 -0400
X-MC-Unique: yYKz6FsGOuixRfckPH2-_w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-635e3871cf9so6547376d6.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Jul 2023 04:30:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688643017; x=1691235017;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IUyIouoC8ahxmdxehnDEnuXDxYXuSzzBD+vRAySsvH8=;
        b=DJLQjeJPoq7Hk5bjiFwJmE2R3srxMTXbGHmyfLrU+pWNCEHkgVH7cEOiDki3I98Usi
         tcdfglLxAySrbUJ1fJnmP5gb9XwgNvecqa7hD3hoKK3+una3pA31qCil/jz+5+Wzg1vo
         wmLxV/Ip6zThMQWs0fG4hewQ9HxuvLRmfhjCdlVjwVnNnV8l4ZPya1WBwyYFgffAjnDq
         xvPSA7d2qJjjD7iJRT01kaB0FT8wM/GWZ/QBQ4GTvVn9GrHlbZxEhxP2BhR62f2meIr9
         oXIBOFbRJ2fj3LJYr1R891J82vQtvuZnIAgB23UYJ9kKSlnC3AOstWv12WnWEIzp6/vx
         RQFA==
X-Gm-Message-State: ABy/qLbUmQZGFxIn1JwmmIf5FfivLyIrwVK+ZYpVqt+vTMJo0rBc8LYI
        HUFfUs2814PSLIUFFJHjnLxv6ZdZqOar4hoYIxnSY3jYOQWB5eQ47dAVO/HqeXZ200IAHX3QN2+
        nqglV7d0ShuCP7C5BF9G7nkJJ9R75E1mb
X-Received: by 2002:a0c:db08:0:b0:625:aa49:19f1 with SMTP id d8-20020a0cdb08000000b00625aa4919f1mr1114232qvk.62.1688643017312;
        Thu, 06 Jul 2023 04:30:17 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGGMC/kBtgH7sbrX8rD2ZgNOVsGU4yA48iFb2GJxy2p3hgBQJP/oIfvimw2fu1jmJDlCZa08A==
X-Received: by 2002:a0c:db08:0:b0:625:aa49:19f1 with SMTP id d8-20020a0cdb08000000b00625aa4919f1mr1114196qvk.62.1688643017072;
        Thu, 06 Jul 2023 04:30:17 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id y12-20020a0c8ecc000000b006360778f314sm751558qvb.105.2023.07.06.04.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 04:30:16 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Nadav Amit <namit@vmware.com>,
        Dan Carpenter <error27@gmail.com>,
        Chuang Wang <nashuiliang@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Petr Mladek <pmladek@suse.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: Re: [RFC PATCH 00/14] context_tracking,x86: Defer some IPIs until a
 user->kernel transition
In-Reply-To: <20230705150328.16791f25@gandalf.local.home>
References: <20230705181256.3539027-1-vschneid@redhat.com>
 <20230705150328.16791f25@gandalf.local.home>
Date:   Thu, 06 Jul 2023 12:30:10 +0100
Message-ID: <xhsmhv8exuvjx.mognet@vschneid.remote.csb>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On 05/07/23 15:03, Steven Rostedt wrote:
> On Wed,  5 Jul 2023 19:12:42 +0100
> Valentin Schneider <vschneid@redhat.com> wrote:
>
>> o Patches 1-5 have been submitted previously and are included for the sake of
>>   testing
>
> I should have commented on the previous set, but I did my review on this set ;-)
>

Thanks for having a look!

> Anyway, I'm all for the patches. Care to send a new version covering my input?
>

Sure thing, I'll send a v2 of these patches soonish.

> Thanks,
>
> -- Steve

