Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B56CC0015E
	for <linux-trace-kernel@archiver.kernel.org>; Sat, 29 Jul 2023 15:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjG2POo (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Sat, 29 Jul 2023 11:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjG2POn (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 11:14:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16DF1BE5;
        Sat, 29 Jul 2023 08:14:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E4AF60C6D;
        Sat, 29 Jul 2023 15:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6B6C433C8;
        Sat, 29 Jul 2023 15:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690643681;
        bh=Ap6ei0a4Hf1ttKLS0HQpx4Ur7UI38Fn6v9BKc3A7fBE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lBVI1FzlcfWuS0k612zckmJ4F9m2gNFN1XKY/138WO7pnn+Ibdu+OghG3YNSlgv9c
         /hI/eqHC+nuIjsdxZlQer5XZvRuT9pdA1PBtpgG/tGR8Iejs8mQTbERrFbI0Zr10zh
         lLYIAHjihvBf6ropzggyUFp7txQdPD4C93OWDmm0SpFMe3yYhHqqG7mbBBeeH54Z2i
         Do8KP6qcfbW6Uwnxkhj1ngDBikEAhFjMBgYOX5n1LWj56Ql2PxEnankKz8+hOz4YC8
         7qQ0P37Ef+NIaghCsgaNqZICTNqX77K8H8h9WpMmAThy1SlPiwQ5MPZD+PQBIMMwGT
         pGeCxjFBeoIbQ==
Date:   Sun, 30 Jul 2023 00:14:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, peterz@infradead.org,
        samitolvanen@google.com, x86@kernel.org,
        linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] x86/retpoline,kprobes: Fix the
 [__indirect_thunk_start, ..end] range
Message-Id: <20230730001435.ed2b12649d5c98d42981daf6@kernel.org>
In-Reply-To: <20230711091952.27944-1-petr.pavlu@suse.com>
References: <20230711091952.27944-1-petr.pavlu@suse.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi Peter,

Can you pick this series to tip tree?
I think, these affect to x86 arch code.

Thank you,

On Tue, 11 Jul 2023 11:19:50 +0200
Petr Pavlu <petr.pavlu@suse.com> wrote:

> Fix problems with an output position of thunk sections and the
> associated definition of range [__indirect_thunk_start,
> __indirect_thunk_end] which affects the kprobes optimization.
> 
> Initial v1 of the series kept the mentioned range but it turns out the
> logic which uses it is not necessary so it is removed altogether.
> 
> Changes since v1 [1]:
> - Drop the patch which moved the return thunk out of
>   [__indirect_thunk_start, ..end] and instead replace it with a removal
>   of the kprobes optimization check which looked for calls to indirect
>   thunks.
> - Slightly adjust the commit message for the first patch, to better
>   match the new second patch.
> 
> [1] https://lore.kernel.org/lkml/20230705081547.25130-1-petr.pavlu@suse.com/
> 
> Petr Pavlu (2):
>   x86/retpoline,kprobes: Fix position of thunk sections with
>     CONFIG_LTO_CLANG
>   x86/retpoline,kprobes: Skip optprobe check for indirect jumps with
>     retpolines and IBT
> 
>  arch/x86/include/asm/nospec-branch.h |  3 ---
>  arch/x86/kernel/kprobes/opt.c        | 40 +++++++++++-----------------
>  arch/x86/kernel/vmlinux.lds.S        |  4 +--
>  arch/x86/lib/retpoline.S             |  4 +--
>  tools/perf/util/thread-stack.c       |  4 +--
>  5 files changed, 20 insertions(+), 35 deletions(-)
> 
> -- 
> 2.35.3
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
