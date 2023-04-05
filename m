Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE4DC77B62
	for <linux-trace-kernel@archiver.kernel.org>; Wed,  5 Apr 2023 18:03:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbjDESDy (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 5 Apr 2023 14:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDESDv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 14:03:51 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030647285
        for <linux-trace-kernel@vger.kernel.org>; Wed,  5 Apr 2023 11:03:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id n9-20020a05600c4f8900b003f05f617f3cso3346887wmq.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Apr 2023 11:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680717774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7hqsBVLdt1RQMl9kEJsLC6YcZN3etO5DgEUxKtvbSwU=;
        b=j3Q8s0GCJ+n56KzJcYwFXN+d48HkCrg3fkCyfWHeMKrRtBKD2ueyFtvyEXsv+/qxE5
         jwiGzKfL/EazWk+HiTQxOUOxan/kzGsAwjav1OxkNnmDsJh3e+M1QSk61tXcFG4Xam3V
         C4gkRzN6vqghm0nPva4lnaOdGCFlnarpEev58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680717774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hqsBVLdt1RQMl9kEJsLC6YcZN3etO5DgEUxKtvbSwU=;
        b=hUMkxSfx48kFQWzVbfjPLtFUyB8QFANCjj1aSwIdM5quS1AxICeD4WQbB7rtoNPlVl
         xEIXkEsBM7zXfryPD2WBbMQNuSZT/4v7wqi2q1Yx4+BnvE6Q47iTiUpca1ADADN4HPx7
         riqfNJhw663li+i2mZR/u5W8Mz4NGnWHF3LvFkrd/RAhst5yuIds/oFiRvjT9Zonr6kO
         XGySF0wEfTg/2Nh4KIuNpsww0uhbsk7ddquKL2/bfbvoFnut1Vs5EuXKoLF9AuZRQJnh
         F65OSwUhw29aEOUQWPPFETkVfI4oAIHPYHXAvm/93CKfTIL4Yan9A2MmC4UuPJamGzia
         4Uqg==
X-Gm-Message-State: AAQBX9e6yYVzQXE3nRgGZ8dU6ibJMfgzpGN7SpK+ujyGg11VxawFC0/1
        2vDICuwQsAXOVGtHkiT4RsR5Iw==
X-Google-Smtp-Source: AKy350YH/mhjtDihEd5vUnb3kVxk6Inr0Er3ixvxTityy7XhCLfLoxSJyjKpbmEMRPwkZzBYSEA4Kg==
X-Received: by 2002:a05:600c:1d98:b0:3f0:5403:57ae with SMTP id p24-20020a05600c1d9800b003f0540357aemr2176475wms.20.1680717774540;
        Wed, 05 Apr 2023 11:02:54 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:cf6a:9ae6:15f1:4213])
        by smtp.gmail.com with ESMTPSA id bd5-20020a05600c1f0500b003f0472ffc7csm2913233wmb.11.2023.04.05.11.02.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 11:02:54 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mark.rutland@arm.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kpsingh@kernel.org,
        jolsa@kernel.org, xukuohai@huaweicloud.com, lihuafei1@huawei.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH v6 0/5] Add ftrace direct call for arm64
Date:   Wed,  5 Apr 2023 20:02:45 +0200
Message-Id: <20230405180250.2046566-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
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
2- samples/ftrace/*.ko (cf: patch 4)
3- tools/testing/selftests/bpf/test_progs (cf: patch 5)

Changes since v5 [3]:
- Fixed saving the fourth argument of handle_mm_fault in both the x86 (patch 3)
  and arm64 (as part of patch 4) "ftrace-direct-too" sample trampolines
- Fixed the address of the traced function logged by some direct call samples
  (ftrace-direct-multi and ftrace-direct-multi-modify) by moving lr into x0

1: https://lore.kernel.org/all/ZB2Nl7fzpHoq5V20@FVFF77S0Q05N/
2: https://lore.kernel.org/all/20220913162732.163631-1-xukuohai@huaweicloud.com/
3: https://lore.kernel.org/bpf/20230403113552.2857693-1-revest@chromium.org/

Florent Revest (5):
  arm64: ftrace: Add direct call support
  arm64: ftrace: Simplify get_ftrace_plt
  samples: ftrace: Save required argument registers in sample
    trampolines
  arm64: ftrace: Add direct call trampoline samples support
  selftests/bpf: Update the tests deny list on aarch64

 arch/arm64/Kconfig                           |  6 ++
 arch/arm64/include/asm/ftrace.h              | 22 +++++
 arch/arm64/kernel/asm-offsets.c              |  6 ++
 arch/arm64/kernel/entry-ftrace.S             | 90 ++++++++++++++++----
 arch/arm64/kernel/ftrace.c                   | 46 +++++++---
 samples/ftrace/ftrace-direct-modify.c        | 34 ++++++++
 samples/ftrace/ftrace-direct-multi-modify.c  | 40 +++++++++
 samples/ftrace/ftrace-direct-multi.c         | 24 ++++++
 samples/ftrace/ftrace-direct-too.c           | 40 +++++++--
 samples/ftrace/ftrace-direct.c               | 24 ++++++
 tools/testing/selftests/bpf/DENYLIST.aarch64 | 82 ++----------------
 11 files changed, 306 insertions(+), 108 deletions(-)

-- 
2.40.0.577.gac1e443424-goog

