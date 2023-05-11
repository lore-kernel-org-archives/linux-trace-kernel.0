Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA65DC77B7C
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 11 May 2023 07:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237467AbjEKHWK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 11 May 2023 03:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237194AbjEKHVl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 11 May 2023 03:21:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC4A5CF;
        Thu, 11 May 2023 00:21:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7707E60E76;
        Thu, 11 May 2023 07:21:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B69C433D2;
        Thu, 11 May 2023 07:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683789660;
        bh=TX6KY0uZMK4hvOIfunTzmFoUHAawqMV/Ya0zNO9JdSM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=DkSbXjvrTS8n54V1AwT7+zmdRaokj0stn/kCaPEI1tNSaOI5Wv5geVxllqbXMwWiY
         lUDS9168PqnGOaNmWwov+EM3McMS/TCElNYWKm1UlBXbXALhCpzUJgUCKWaux5iHCu
         pz3y4RJv8xXHsx1Gvv5MAVC8++cGA+5DcWZdhiZQ8hiX9QVhfSAvLeZC1L2JVeKdQP
         iU4axmsjf89vEwsJycCt6/h3gbYvz7YUHvRv1aJrZL7HaGlfnoVUoxvECbipD1eS8o
         rvyVKvMVp8nEuMhMhbDhh7AebMV4TfVDluEzlcZvuRlPvm3VuZC8JKhNiJ/sjoSAsT
         P9YADGY1N2dSw==
From:   =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To:     Song Shuai <suagrfillet@gmail.com>, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, guoren@kernel.org,
        suagrfillet@gmail.com, jszhang@kernel.org, e.shatokhin@yadro.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH V9 4/4] samples: ftrace: Add riscv support for
 SAMPLE_FTRACE_DIRECT[_MULTI]
In-Reply-To: <20230510101857.2953955-5-suagrfillet@gmail.com>
References: <20230510101857.2953955-1-suagrfillet@gmail.com>
 <20230510101857.2953955-5-suagrfillet@gmail.com>
Date:   Thu, 11 May 2023 09:20:57 +0200
Message-ID: <87o7mrjpuu.fsf@all.your.base.are.belong.to.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Song Shuai <suagrfillet@gmail.com> writes:

> select HAVE_SAMPLE_FTRACE_DIRECT and HAVE_SAMPLE_FTRACE_DIRECT_MULTI
> for ARCH_RV64I in arch/riscv/Kconfig. And add riscv asm code for
> the ftrace-direct*.c files in samples/ftrace/.
>
> Link: https://lore.kernel.org/linux-riscv/c68bac83-5c88-80b1-bac9-e1fd4ea=
8f07e@yadro.com/T/#ma13012560331c66b051b580b3ab4a04ba44455ec
> Tested-by: Evgenii Shatokhin <e.shatokhin@yadro.com>
> Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> Tested-by: Guo Ren <guoren@kernel.org>
> Signed-off-by: Guo Ren <guoren@kernel.org>

My usual "please align op/operands" nit. ;-)

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
