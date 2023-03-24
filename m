Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A77FC6FD20
	for <linux-trace-kernel@archiver.kernel.org>; Fri, 24 Mar 2023 17:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjCXRPn (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjCXRPa (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:15:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E193B47C
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:15:02 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso3614442wms.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Mar 2023 10:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1679678097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RegTj6ZIebUQPA8rcD0vl5uPS+26g2Sm5QVA1mqn3kI=;
        b=AsEFpNhIC31p7EY+r3N6BmQ0k/tTWIhol6uk5hJCrx+qN5EgWZx2jMqSPeYt3/KOZM
         rKXSmLCp4ikMxij1pQzXGiuBNjpcpSvMp54tsTBEXtiqeUmYUMfjjWn148rAVlmS/FlO
         hdWMzBIAiLcYSSKeFfP64Qq4eGQ0iOwiSLD+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RegTj6ZIebUQPA8rcD0vl5uPS+26g2Sm5QVA1mqn3kI=;
        b=VM2kcWVNPuq8m/JaCXc69B/w+4YkUisJ0ENUwcWsRGaheIO3j4EU+rN0E5ot6aPjDm
         NgD4BEhXPzMPTqroz0/eNTA+F2ytpMjimgiJP8tSUjxwg7pUYJVx3IybfPSdzPVZk279
         z+4C13c7MwIToITRQEJJqXOhcF42VAZ1A1zQOym8gYc1OtjomPM2+dwujW6Wy9ci35pR
         U03a6ZV+XRQNFRFzWC2Jgriy7AjxQx7W9YYuWNZ0Ou75BR1GpvdWs0NzAvUu/1rRg2Oq
         WjphnCilaVOZYP4Wpx1DxT3RFWE6hgxEU0K6m13bukmc8EiKTySx3cPr5l8simDothCo
         3kbQ==
X-Gm-Message-State: AO0yUKXSzljxBhYX2H1KuRMGRwgd5qdtoQV2fURitvJJhI0KVULXTNoV
        fqqR6tA4U1r8exjBJsk0hWevMw==
X-Google-Smtp-Source: AK7set+RzbeIy+ik1zAtmcE5ClYFAskZBrekDO+igxhK9XPkVFmRtsLXkpwpOngDkYj0K19uCjvm3A==
X-Received: by 2002:a05:600c:218d:b0:3ed:5a12:5641 with SMTP id e13-20020a05600c218d00b003ed5a125641mr3325142wme.36.1679678097171;
        Fri, 24 Mar 2023 10:14:57 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:ffb1:35ba:1031:ba71])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c231a00b003dc522dd25esm5385107wmo.30.2023.03.24.10.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:14:56 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v3 0/4] Add ftrace direct call for arm64
Date:   Fri, 24 Mar 2023 18:14:47 +0100
Message-Id: <20230324171451.2752302-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This series adds ftrace direct call support to arm64.
This makes BPF tracing programs (fentry/fexit/fmod_ret/lsm) work on arm64.

It is meant to be taken by the arm64 tree but it depends on the
trace-direct-v6.3-rc3 tag of the linux-trace tree:
  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
That tag was created by Steven Rostedt so the arm64 tree can pull the prior work
this depends on. [1]

Thanks to the ftrace refactoring under that tag, an ftrace_ops backing a ftrace
direct call will only ever point to *one* direct call. This means we can look up
the direct called trampoline address stored in the ops from the ftrace_caller
trampoline in the case when the destination would be out of reach of a BL
instruction at the ftrace callsite. This fixes limitations of previous attempts
such as [2].

This series has been tested on arm64 with:
1- CONFIG_FTRACE_SELFTEST
2- samples/ftrace/*.ko (cf: patch 3)
3- tools/testing/selftests/bpf/test_progs (cf: patch 4)

Changes since v2 [3]:
- Dropped the first 6 patches which got merged separately in the tracing tree
- Minor rebase changes when switching to v6.3-rc3
- Fixed a typo in a comment (trmapoline -> trampoline)

1: https://lore.kernel.org/all/ZB2Nl7fzpHoq5V20@FVFF77S0Q05N/
2: https://lore.kernel.org/all/20220913162732.163631-1-xukuohai@huaweicloud.com/
3: https://lore.kernel.org/all/20230207182135.2671106-1-revest@chromium.org/

Florent Revest (4):
  arm64: ftrace: Add direct call support
  arm64: ftrace: Simplify get_ftrace_plt
  arm64: ftrace: Add direct call trampoline samples support
  selftests/bpf: Update the tests deny list on aarch64

 arch/arm64/Kconfig                           |  6 ++
 arch/arm64/include/asm/ftrace.h              | 22 +++++
 arch/arm64/kernel/asm-offsets.c              |  6 ++
 arch/arm64/kernel/entry-ftrace.S             | 90 ++++++++++++++++----
 arch/arm64/kernel/ftrace.c                   | 46 +++++++---
 samples/ftrace/ftrace-direct-modify.c        | 32 +++++++
 samples/ftrace/ftrace-direct-multi-modify.c  | 36 ++++++++
 samples/ftrace/ftrace-direct-multi.c         | 22 +++++
 samples/ftrace/ftrace-direct-too.c           | 25 ++++++
 samples/ftrace/ftrace-direct.c               | 23 +++++
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 82 ++----------------
 11 files changed, 288 insertions(+), 102 deletions(-)

-- 
2.40.0.348.gf938b09366-goog

