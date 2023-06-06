Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD88C7EE24
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  6 Jun 2023 15:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236817AbjFFPMm (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjFFPMl (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:12:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA729126;
        Tue,  6 Jun 2023 08:12:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50EA862D9C;
        Tue,  6 Jun 2023 15:12:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB420C433D2;
        Tue,  6 Jun 2023 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686064359;
        bh=ITuf4mrMNHj/t/cxTj6fqNqlNYg9SVIt6Wm6jYSUlvY=;
        h=From:To:Cc:Subject:Date:From;
        b=ObpVg2cHrEJfu6omjONOeu3GmzqDcQWkISh/Z7xEO+kplX5zfjlU172bAEYHtRj8x
         uS7vI/Pp8oG4NKG8Y5vthywp52oR0eMaR0jOfuQ1p0/1uHw6+Mc4AzqVCOjKNnFmQH
         lS3zAHqKD5Z3ajwEPfCiQLBtjdQDR+bXksk1ncCol+v+l3jrxgSglb8tz913F6OaGD
         s13WQ4N+S2qfWQ9uCpP+NPpE3kDaW5RwoHlJ9r4Y7MRf4tw/jNhlSmINRlWgkcdowU
         /vMeCELk9uRVfQyOh5wafCTYF5di9BVmm/wSdqk7aw1wXI7hZi3SWA8SWEbwtHJFh1
         Ked3W2xQgR5ig==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH V3 0/3] osnoise/timerlat improvements
Date:   Tue,  6 Jun 2023 17:12:24 +0200
Message-Id: <cover.1686063934.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

These three patches are improvements for the osnoise/timerlat tracers,
mainly to support rtla. The first one is a dependency for the -C <cgroup>
command line option to be added to rtla. It is essential to allow
timerlat/osnoise to measure the latencies from the container/cgroup
point of view. The second improves rtla time for saving tracing after
a stop tracing condition on osnoise/hwnoise.

The third patch adds the osnoise/per_cpu/cpu$id/timerlat_fd file
where timerlat expects a pinned user thread to open and read from it.
When the thread reads it, it actually activates timerlat latency
measurement mechanism, so timerlat can be activated from an user-space
thread. Timerlat is also expanded to report the return from user-space
latency when read is called after the first call, so adding another
metric to timerlat, that can either represent the kernel-to-user and
user-to-kernel overhead, or to measure the execution time of any
workload. Details are added to the kernel documentation.

Changes from V2:
  - Moved the migration check to a function hooked to the
    sched:sched_migration_task tracepoint
  - Fixed compilation errors with !CONFIG_TIMERLAT_TRACER (kernel test robot)
  - Made osnoise_create_cpu_timerlat_fd static (kernel test robot)
  - Link: https://lore.kernel.org/lkml/cover.1684860626.git.bristot@kernel.org/
Changes from V1:
  - Added the user-space interface patch
  - Link: https://lore.kernel.org/lkml/cover.1683823114.git.bristot@kernel.org/

Daniel Bristot de Oliveira (3):
  tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable
  tracing/osnoise: Skip running osnoise if all instances are off
  tracing/timerlat: Add user-space interface

 Documentation/trace/timerlat-tracer.rst |  78 ++++
 kernel/trace/trace_osnoise.c            | 477 +++++++++++++++++++++++-
 kernel/trace/trace_output.c             |   4 +-
 3 files changed, 551 insertions(+), 8 deletions(-)

-- 
2.38.1

