Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE92C64ED8
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 15 Feb 2023 22:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbjBOWeB (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 15 Feb 2023 17:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjBOWeA (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:34:00 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE7173252E
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:33:58 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id v6so158026ilc.10
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Feb 2023 14:33:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=onPboIVuwFQM+u11FAIAIUF6FsX292G7WEiPOTqQPg8=;
        b=N/nnLNCloXEfghvTNAXw+I6rZ21KJHDzNBWYN1//+agMoDmkc4p2uF5tGKWwVYGWnv
         wEqyDErcLL+IQCmktHXDkEEa9CFd3WXlYLeAnXmWRus0ztYASmQctA99YmsCYrsFabbC
         ViuxzH6SA3drPTIGVbzUJEMGqhtF+LCznfCg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=onPboIVuwFQM+u11FAIAIUF6FsX292G7WEiPOTqQPg8=;
        b=Cz3TjcQ/+8C7l0R+6oY6Dwgki6PlaDCD15SB8OTYxAorsEUs0dL0OGDlZurPpM5i/D
         VDSiu9iKpjRnJ7NTUdfrycVNGisVe8so1EXWR0STGayYZJlR9sJtM0TzaJKHPHKdZYUi
         AdwD3OmvCucX9K7lrxOqOaVzVOOUvSCgeNZSl0r7WcbMTVzGrfsi/ES1dT1kcMb0Nu+8
         tLxf/KZh7uPhNXgRJwSw1DPgW0JWqa1KL3KHI0fLE7PxARBUpFlHpwipGxYnbgjNvnKQ
         is/uvEXWVI67FbaYQzv6tjLZlr4YiasL1YQ3/bidvppbiLTsMx5+ZrIDvIos2JRjs6+6
         fo3g==
X-Gm-Message-State: AO0yUKXdENa7rODe2OlX7K0djCM4HVanTkokR+AmUGIVG9z+Lun5yORG
        8x1LK95ntQS2B+Ut8z2VrrNuwA==
X-Google-Smtp-Source: AK7set9iJvaog96LALhe884wzN0xuXErl0FzajFZhkV85AuS0ZFd+QdHTbYidcus7alXRIzwIWNnJw==
X-Received: by 2002:a05:6e02:1d17:b0:315:4f67:7055 with SMTP id i23-20020a056e021d1700b003154f677055mr4026600ila.1.1676500438087;
        Wed, 15 Feb 2023 14:33:58 -0800 (PST)
Received: from ravnica.bld.corp.google.com ([2620:15c:183:200:6299:179b:a6e4:be59])
        by smtp.gmail.com with ESMTPSA id b15-20020a92c14f000000b003141eddd283sm1131489ilh.22.2023.02.15.14.33.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Feb 2023 14:33:57 -0800 (PST)
From:   Ross Zwisler <zwisler@chromium.org>
X-Google-Original-From: Ross Zwisler <zwisler@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ross Zwisler <zwisler@google.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "Tobin C. Harding" <me@tobin.cc>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jason Wang <jasowang@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Tycho Andersen <tycho@tycho.pizza>, kvm@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH v2 0/6] use canonical ftrace path whenever possible
Date:   Wed, 15 Feb 2023 15:33:44 -0700
Message-Id: <20230215223350.2658616-1-zwisler@google.com>
X-Mailer: git-send-email 2.39.1.637.g21b0678d19-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Changes in v2:
 * Dropped patches which were pulled into maintainer trees.
 * Split BPF patches out into another series targeting bpf-next.
 * trace-agent now falls back to debugfs if tracefs isn't present.
 * Added Acked-by from mst@redhat.com to series.
 * Added a typo fixup for the virtio-trace README.

Steven, assuming there are no objections, would you feel comfortable
taking this series through your tree?

---
The canonical location for the tracefs filesystem is at /sys/kernel/tracing.

But, from Documentation/trace/ftrace.rst:

  Before 4.1, all ftrace tracing control files were within the debugfs
  file system, which is typically located at /sys/kernel/debug/tracing.
  For backward compatibility, when mounting the debugfs file system,
  the tracefs file system will be automatically mounted at:

  /sys/kernel/debug/tracing

There are many places where this older debugfs path is still used in
code comments, selftests, examples and tools, so let's update them to
avoid confusion.

I've broken up the series as best I could by maintainer or directory,
and I've only sent people the patches that I think they care about to
avoid spamming everyone.

Ross Zwisler (6):
  tracing: always use canonical ftrace path
  selftests: use canonical ftrace path
  leaking_addresses: also skip canonical ftrace path
  tools/kvm_stat: use canonical ftrace path
  tools/virtio: use canonical ftrace path
  tools/virtio: fix typo in README instructions

 include/linux/kernel.h                        |  2 +-
 include/linux/tracepoint.h                    |  4 ++--
 kernel/trace/Kconfig                          | 20 +++++++++----------
 kernel/trace/kprobe_event_gen_test.c          |  2 +-
 kernel/trace/ring_buffer.c                    |  2 +-
 kernel/trace/synth_event_gen_test.c           |  2 +-
 kernel/trace/trace.c                          |  2 +-
 samples/user_events/example.c                 |  4 ++--
 scripts/leaking_addresses.pl                  |  1 +
 scripts/tracing/draw_functrace.py             |  6 +++---
 tools/kvm/kvm_stat/kvm_stat                   |  2 +-
 tools/lib/api/fs/tracing_path.c               |  4 ++--
 .../testing/selftests/user_events/dyn_test.c  |  2 +-
 .../selftests/user_events/ftrace_test.c       | 10 +++++-----
 .../testing/selftests/user_events/perf_test.c |  8 ++++----
 tools/testing/selftests/vm/protection_keys.c  |  4 ++--
 tools/tracing/latency/latency-collector.c     |  2 +-
 tools/virtio/virtio-trace/README              |  4 ++--
 tools/virtio/virtio-trace/trace-agent.c       | 12 +++++++----
 19 files changed, 49 insertions(+), 44 deletions(-)

-- 
2.39.1.637.g21b0678d19-goog

