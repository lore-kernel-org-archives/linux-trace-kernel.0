Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454C1EB64DA
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  7 Jul 2023 17:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbjGGRXE (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 7 Jul 2023 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbjGGRXD (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 13:23:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CA01FE0
        for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Jul 2023 10:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688750537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=v7pyF21heKJh3mBhLokhUiDCcEZ8kjM9chhOnSIUlG0=;
        b=NrhEjHjeiLE4WgwWJM1OU8RJzv3VREijoIui0roLDEktR+tIxOvdi6Ve2+4NEA7NnCXTYg
        VuWqzTGBRZnvzpcuciCqqJ9FjnuSd4i7usUqBvY4+Txf4wJ+dnjvPsdBmOC2k1R8xO7U4X
        /sMkFzVi2DNT9ahC4kun7T8HbWaFMCU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-624-X8x1lUeyOoq5SatT4cDWqQ-1; Fri, 07 Jul 2023 13:22:14 -0400
X-MC-Unique: X8x1lUeyOoq5SatT4cDWqQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CD17B2815E37;
        Fri,  7 Jul 2023 17:22:13 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.164])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D0FB81454142;
        Fri,  7 Jul 2023 17:22:10 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo Bras <leobras@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH v2 0/9] tracing/filters: filtering event fields with a cpumask
Date:   Fri,  7 Jul 2023 18:21:46 +0100
Message-Id: <20230707172155.70873-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi folks,

In the context of CPU isolation / NOHZ_FULL interference investigation, we now
have the ipi_send_cpu and ipi_send_cpumask events. However, enabling these
events without any filtering can yield pretty massive traces with a lot of
uninteresting or irrelevant data (e.g. everything targeting housekeeping CPUs).

This series is about adding event filtering via a user-provided cpumask. This
enables filtering using cpumask fields (e.g. ipi_send_cpumask) and extends this
to scalar and the local CPU common fields.

With this, it becomes fairly easy to trace events both happening on and
targeting CPUs of interest, e.g.:

  trace-cmd record -e 'sched_switch' -f "CPU & CPUS{$ISOLATED_CPUS}"         \
		   -e 'sched_wakeup' -f "target_cpu & CPUS{$ISOLATED_CPUS}"  \
		   -e 'ipi_send_cpu' -f "cpu & CPUS{$ISOLATED_CPUS}"         \
		   -e 'ipi_send_cpumask' -f "cpumask & CPUS{$ISOLATED_CPUS}" \
		   hackbench

The CPUS{} thing is a bit crude but seems to work well enough without break^C
overhauling the predicate parsing logic.

Cheers,
Valentin

Revisions
=========

v1 -> v2
++++++++

Context for the changes:
https://lore.kernel.org/lkml/20230705181256.3539027-1-vschneid@redhat.com/

o Added check for NULL filter_pred in free_predicate()
o Changed filter_type and op checks to be switch cases.

o Swiched from strncpy() to strscpy() (Steven)
o Changed from "MASK{}" to "CPUS{}"

  This is slightly more explicit IMO, and leaves MASK{} available if/when we
  decide to add bitmask filtering for other events.

o Optimised cpumask vs scalar filtering

  Rather than doing full-fledged cpumask operations using cpumask_of(scalar), I'm
  using cpumask_nth(1, mask) as a way to check the mask's weight is one - the
  reasoning here is we don't need to compute the full weight of the mask, we 
  just need to know if there's more than one bit set.

o Added scalar vs scalar optimisation (Steven)

  In case the user-provided cpumask has a weight of one, Steven pointed out we
  could use cheaper scalar-based filter functions.

  I *may* have gone a bit overboard here, but given the mask is stable for the
  duration of the filter, it felt silly to check its weight every time we enter
  the filter function.

Valentin Schneider (9):
  tracing/filters: Dynamically allocate filter_pred.regex
  tracing/filters: Enable filtering a cpumask field by another cpumask
  tracing/filters: Enable filtering a scalar field by a cpumask
  tracing/filters: Enable filtering the CPU common field by a cpumask
  tracing/filters: Optimise cpumask vs cpumask filtering when user mask
    is a single CPU
  tracing/filters: Optimise scalar vs cpumask filtering when the user
    mask is a single CPU
  tracing/filters: Optimise CPU vs cpumask filtering when the user mask
    is a single CPU
  tracing/filters: Further optimise scalar vs cpumask comparison
  tracing/filters: Document cpumask filtering

 Documentation/trace/events.rst     |  14 ++
 include/linux/trace_events.h       |   1 +
 kernel/trace/trace_events_filter.c | 302 ++++++++++++++++++++++++++---
 3 files changed, 290 insertions(+), 27 deletions(-)

--
2.31.1

