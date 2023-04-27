Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF91C77B73
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 27 Apr 2023 14:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243730AbjD0OHY (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 27 Apr 2023 10:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243218AbjD0OHX (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 10:07:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E764698
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:07:15 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f1e2555b5aso38455075e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 27 Apr 2023 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1682604434; x=1685196434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g++Jpz8si5Cxxyn4mP4hOUSvklGO5An+E7k8VLQcOJE=;
        b=NL4snAwmCqzvp7UbxQjE675qWSOTHU+8K7kahlPvCSIyKhWKDiAruAwrfHGtQF7OAj
         zOE1mqPdXxgtl/0wydUAQAL4kTY08XKoXm5d91rwqEyFD/UIMSrpQT2IfabHVaF64B7a
         WJS/JMfB6MwhARgLxWac9TCMREXWZGzVtMKtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682604434; x=1685196434;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g++Jpz8si5Cxxyn4mP4hOUSvklGO5An+E7k8VLQcOJE=;
        b=Vi/skLekBcWkw+53VmQ0izm/h0xAR6dwqSwTV0U7j3/JneITIbhTZqA01C/2vWxKq7
         OO8+DST54ewKpqzBUXAQM19ls+tv6o/ifgtEcvGPlXDjQjHhr6SPun6AibJr0msYfVrg
         bs8wyvDBG6m0VcrMhQ3vvGtIJuGriml5FIkxInd8Y0KjW2/ReCVbOvtS6uK2HCGu2P7e
         dPLtbggZt/ftpYFQm/RWFVEH4BzLN+ieI9UwN3VS33MnL8/CkGefmTU2H036/EiE7F8F
         Xk8DqfwdqHbP13hF0EgwIylpJjnmVyLC/km7Ni3GLgVnNtvZfj8I5/ikq6pcSwwjRHEN
         W6Fw==
X-Gm-Message-State: AC+VfDzT64I3CBJQcuLqhLLMUV3JbDj0kxy5Oa8kQ5v2BIH72XCrKeDX
        vnmhvOjTP5O3LWZesx37bNvZww==
X-Google-Smtp-Source: ACHHUZ5a/MAV7sj8ArZSXjSnbLQCCNHNJ29kn4QMtWeG1FmmD5w1ebkcBDl9+2wjdEm2+9Khgj7Ixw==
X-Received: by 2002:a5d:6901:0:b0:2ce:aa2d:c625 with SMTP id t1-20020a5d6901000000b002ceaa2dc625mr1497792wru.22.1682604433815;
        Thu, 27 Apr 2023 07:07:13 -0700 (PDT)
Received: from revest.zrh.corp.google.com ([2a00:79e0:9d:6:a66d:4f2c:7ce5:e8ea])
        by smtp.gmail.com with ESMTPSA id c21-20020a7bc855000000b003f17300c7dcsm21285075wml.48.2023.04.27.07.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 07:07:13 -0700 (PDT)
From:   Florent Revest <revest@chromium.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Cc:     rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
        kpsingh@kernel.org, xukuohai@huaweicloud.com,
        Florent Revest <revest@chromium.org>
Subject: [PATCH 0/2] Ftrace direct call samples improvements
Date:   Thu, 27 Apr 2023 16:06:58 +0200
Message-ID: <20230427140700.625241-1-revest@chromium.org>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

This series is a subset of [1] that didn't go through the arm64 tree.

- The first patch fixes a small bug when a direct call sample is loaded on x86
- The second patch adds arm64 support to all direct calls samples

They are sent together because the second one depends on the first one.

This series applies cleanly on Linus's master branch. It needs the first two
patches of [1] which, at the time of writing, don't seem to have made it to the
trace/linux-trace tree but I suppose they could be pulled from Linus's master

1: https://lore.kernel.org/bpf/20230405180250.2046566-1-revest@chromium.org/

Florent Revest (2):
  samples: ftrace: Save required argument registers in sample
    trampolines
  arm64: ftrace: Add direct call trampoline samples support

 arch/arm64/Kconfig                          |  2 ++
 samples/ftrace/ftrace-direct-modify.c       | 34 ++++++++++++++++++
 samples/ftrace/ftrace-direct-multi-modify.c | 40 +++++++++++++++++++++
 samples/ftrace/ftrace-direct-multi.c        | 24 +++++++++++++
 samples/ftrace/ftrace-direct-too.c          | 40 +++++++++++++++++----
 samples/ftrace/ftrace-direct.c              | 24 +++++++++++++
 6 files changed, 158 insertions(+), 6 deletions(-)

-- 
2.40.1.495.gc816e09b53d-goog

