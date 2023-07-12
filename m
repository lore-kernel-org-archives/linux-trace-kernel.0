Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF698EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 12 Jul 2023 18:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjGLS0O (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 12 Jul 2023 14:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232558AbjGLS0N (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:26:13 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A501FD6
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:26:10 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-668704a5b5bso6528812b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Jul 2023 11:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1689186370; x=1691778370;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swX/Btqe9SwlapTlO/DIwSPMFx8s3wfg5niuyYAHqCU=;
        b=t+rGeMqK4FQu3U7IWvo5hWBuuEiCmmtx6poL/uG/sChia7xNUk3OjXe/eY0quvdn3z
         J123/5f5oYO/dxIPHh21icK7IG4SZCsW7TDCaFEh6ePd5h+7zV6VrHLvNvZ6HjgB0Rfk
         pHOSJxec/EaLIYDDUUx2eomAS7CkrSFMGdSkIaQ/NARpCUrZ3kyuLxWk8C4gSvBGzf5e
         jdQbwdsup+JK10w1xzMP8CDroJIDpy439nDIwXhUfaTYVLJE2wO4xW8/mjUDID4cmm4+
         gSpw7xE+Mm/fQD0dLPdLrV1xLGdywWVEpYLaWqapHsrYVpGo2y6iBuQFoGOgRilvg6Q3
         WylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689186370; x=1691778370;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swX/Btqe9SwlapTlO/DIwSPMFx8s3wfg5niuyYAHqCU=;
        b=YMQ20VWJZd9j7RDZ2lWJn5tndiXDBPvgxkZYXIgX5uzSsp2MjeLFobpBuyPESBHLpD
         CLl0Ih95btZxEs53Jk9y6R1mp1ZjDE9SktKUaRJAJ8JhCv8ZrcxgGJLgB1dIL9oyPWGG
         0q1pQb33c8y+ss4RmjXv22NuC/3fKC4Wo3rjaOmqTewXlQ9dZfDa2WbKZ9X3jdVI1L72
         6fxnloa9/nQ0dJqRXHy1HZKjDeoXREhJRIcrcvdreZ3RcH6l+3DNVp3WaEVg/9/NUI0G
         UTehDDfH5I7767l/GLgm6dU9Fah7KSmNM1SRMUaQsX62hRggSd7DgZdGEQW0IdlQzBaH
         8hvw==
X-Gm-Message-State: ABy/qLYYzPxaUc1Cw1/SdWmQVP+MyXNMJcu3xxdcShBpL75OCjzI1a/T
        1aZgaaU2DxxduwdauR5Ab0XpDA==
X-Google-Smtp-Source: APBJJlHAxMXSUIbZXiuDm3AUa5MRO5PMewMy62zRT6aZ+RDrwQLncLwIngEG+ozHai+hqvZIUWsP4Q==
X-Received: by 2002:a17:902:ce81:b0:1b8:3e15:40e8 with SMTP id f1-20020a170902ce8100b001b83e1540e8mr5333784plg.56.1689186370368;
        Wed, 12 Jul 2023 11:26:10 -0700 (PDT)
Received: from localhost ([50.38.6.230])
        by smtp.gmail.com with ESMTPSA id q15-20020a170902b10f00b001b9da7ae98bsm4291752plr.122.2023.07.12.11.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 11:26:09 -0700 (PDT)
Date:   Wed, 12 Jul 2023 11:26:09 -0700 (PDT)
X-Google-Original-Date: Wed, 12 Jul 2023 11:25:23 PDT (-0700)
Subject:     Re: [PATCH V11 0/5] riscv: Optimize function trace
In-Reply-To: <87jzv5q9tv.fsf@all.your.base.are.belong.to.us>
CC:     suagrfillet@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mhiramat@kernel.org,
        Mark Rutland <mark.rutland@arm.com>, guoren@kernel.org,
        suagrfillet@gmail.com, Bjorn Topel <bjorn@rivosinc.com>,
        jszhang@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        pulehui@huawei.com, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        songshuaishuai@tinylab.org, bpf@vger.kernel.org
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:     bjorn@kernel.org
Message-ID: <mhng-a2c88f43-3cf7-4caa-8e4a-b0fc9d7e4628@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

On Wed, 12 Jul 2023 11:11:08 PDT (-0700), bjorn@kernel.org wrote:
> Song Shuai <suagrfillet@gmail.com> writes:
>
> [...]
>
>> Add WITH_DIRECT_CALLS support [3] (patch 3, 4)
>> ==============================================
>
> We've had some offlist discussions, so here's some input for a wider
> audience! Most importantly, this is for Palmer, so that this series is
> not merged until a proper BPF trampoline fix is in place.
>
> Note that what's currently usable from BPF trampoline *works*. It's
> when this series is added that it breaks.
>
> TL;DR This series adds DYNAMIC_FTRACE_WITH_DIRECT_CALLS, which enables
> fentry/fexit BPF trampoline support. Unfortunately the
> fexit/BPF_TRAMP_F_SKIP_FRAME parts of the RV BPF trampoline breaks
> with this addition, and need to be addressed *prior* merging this
> series. An easy way to reproduce, is just calling any of the kselftest
> tests that uses fexit patching.
>
> The issue is around the nop seld, and how a call is done; The nop sled
> (patchable-function-entry) size changed from 16B to 8B in commit
> 6724a76cff85 ("riscv: ftrace: Reduce the detour code size to half"), but
> BPF code still uses the old 16B. So it'll work for BPF programs, but not
> for regular kernel functions.
>
> An example:
>
>   | ffffffff80fa4150 <bpf_fentry_test1>:
>   | ffffffff80fa4150:       0001                    nop
>   | ffffffff80fa4152:       0001                    nop
>   | ffffffff80fa4154:       0001                    nop
>   | ffffffff80fa4156:       0001                    nop
>   | ffffffff80fa4158:       1141                    add     sp,sp,-16
>   | ffffffff80fa415a:       e422                    sd      s0,8(sp)
>   | ffffffff80fa415c:       0800                    add     s0,sp,16
>   | ffffffff80fa415e:       6422                    ld      s0,8(sp)
>   | ffffffff80fa4160:       2505                    addw    a0,a0,1
>   | ffffffff80fa4162:       0141                    add     sp,sp,16
>   | ffffffff80fa4164:       8082                    ret
>
> is patched to:
>
>   | ffffffff80fa4150:  f70c0297                     auipc   t0,-150208512
>   | ffffffff80fa4154:  eb0282e7                     jalr    t0,t0,-336
>
> The return address to bpf_fentry_test1 is stored in t0 at BPF
> trampoline entry. Return to the *parent* is in ra. The trampline has
> to deal with this.
>
> For BPF_TRAMP_F_SKIP_FRAME/CALL_ORIG, the BPF trampoline will skip too
> many bytes, and not correctly handle parent calls.
>
> Further; The BPF trampoline currently has a different way of patching
> the nops for BPF programs, than what ftrace does. That should be changed
> to match what ftrace does (auipc/jalr t0).
>
> To summarize:
>  * Align BPF nop sled with patchable-function-entry: 8B.
>  * Adapt BPF trampoline for 8B nop sleds.
>  * Adapt BPF trampoline t0 return, ra parent scheme.

Thanks for digging into this one, I agree we need to sort out the BPF 
breakages before we merge this.  Sounds like there's a rabbit hole here, 
but hopefully we can get it sorted out.

I've dropped this from patchwork and such, as we'll need at least 
another spin.

> Cheers,
> Björn
