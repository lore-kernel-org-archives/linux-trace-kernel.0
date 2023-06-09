Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA8AC7EE2E
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  9 Jun 2023 15:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241773AbjFIPFA (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 9 Jun 2023 11:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241741AbjFIPEv (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 11:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A03E269A
        for <linux-trace-kernel@vger.kernel.org>; Fri,  9 Jun 2023 08:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686323050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+w+pZDopk4F8CHu/k4rB5TG5TqlSH5TY9yzQonWJ8Y4=;
        b=iQTKzrovBxg+pISTjnR4mXuN6FFojPJUgXc/GmhyRusLutyxIDpnXXNDnScTjNTfDQxc0n
        9Ty4gzzidPTtQSAcfXc/BcpCkE6DaVGwuER0QYcvOLuyjfMl3aQz7ajH4O9dqsczaZpei4
        7zNN6B9roOpiWdYL8eFExhnd5O3Imgs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-zq0WDYJOMYmSGdON1cGHBA-1; Fri, 09 Jun 2023 11:04:06 -0400
X-MC-Unique: zq0WDYJOMYmSGdON1cGHBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2EF23825BAB;
        Fri,  9 Jun 2023 15:04:05 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A2B034087C62;
        Fri,  9 Jun 2023 15:03:56 +0000 (UTC)
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
Subject: [RFC PATCH 0/5] tracing/filters: filtering event fields with a cpumask
Date:   Fri,  9 Jun 2023 16:03:19 +0100
Message-Id: <20230609150324.143538-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
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

  trace-cmd record -e 'sched_switch' -f "CPU & MASK{$ISOLATED_CPUS}"         \
		   -e 'sched_wakeup' -f "target_cpu & MASK{$ISOLATED_CPUS}"  \
		   -e 'ipi_send_cpu' -f "cpu & MASK{$ISOLATED_CPUS}"         \
		   -e 'ipi_send_cpumask' -f "cpumask & MASK{$ISOLATED_CPUS}" \
		   hackbench

The MASK{} thing is a bit crude but seems to work well enough without break^C
overhauling the predicate parsing logic.

Cheers,
Valentin

Valentin Schneider (5):
  tracing/filters: Dynamically allocate filter_pred.regex
  tracing/filters: Enable filtering a cpumask field by another cpumask
  tracing/filters: Enable filtering a scalar field by a cpumask
  tracing/filters: Enable filtering the CPU common field by a cpumask
  tracing/filters: Document cpumask filtering

 Documentation/trace/events.rst     |  14 ++
 include/linux/trace_events.h       |   1 +
 kernel/trace/trace_events_filter.c | 228 +++++++++++++++++++++++++----
 3 files changed, 216 insertions(+), 27 deletions(-)

--
2.31.1

