Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8290CC77B7C
	for <linux-trace-kernel@archiver.kernel.org>; Thu, 11 May 2023 16:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbjEKQph (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 11 May 2023 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238468AbjEKQpg (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 11 May 2023 12:45:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D21C5584;
        Thu, 11 May 2023 09:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B39764CF3;
        Thu, 11 May 2023 16:45:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEDFC433EF;
        Thu, 11 May 2023 16:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683823528;
        bh=CnMLGcosgyempn6L9jq7enOv8WDjsRpq9FhaqCiImVQ=;
        h=From:To:Cc:Subject:Date:From;
        b=MwwMhINmVTI0JpRbRHOmBY0KdTxuM8iI3knW+yqnBpQyKs913HS69faDNwlDM2Fma
         g0ucTN9tcQfeeRXEc8iSBtAKTuCfND/kDTk61cBv5UaYecw0nCKDA7sLGWX4OhYs2G
         ASicpquGNCaksCMx3IOd0XGianTAZRQhQczMq3TzFXPglZGQal2lCIw2+66yRiObYD
         WVl4rhlXBEWa7z1Nzo1oc6Cune91dL0nZBO7GyVnLbOP32DFJVdExdCMMVo4KQVCQL
         G/cfnS7tbYgJ8unDNyvgLb7afL6NVB8Orh/5nlNuLENriy3Qw+ZG4QTegBYOaWcfZR
         UBlFPZcz+KWeQ==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        William White <chwhite@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: 
Date:   Thu, 11 May 2023 18:45:18 +0200
Message-Id: <cover.1683823114.git.bristot@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Subject: [PATCH 0/2] osnoise improvements

These two patches are improvements for the osnoise/timerlat tracers,
mainly to support rtla. The first one is a dependency for the -C <cgroup>
command line option to be added to rtla. It is essential to allow
timerlat/osnoise to measure the latencies from the container/cgroup
point of view. The second improves rtla time for saving tracing after
a stop tracing condition on osnoise/hwnoise.

Daniel Bristot de Oliveira (2):
  tracing/osnoise: Switch from PF_NO_SETAFFINITY to migrate_disable
  tracing/osnoise: Skip running osnoise if all instances are off

 kernel/trace/trace_osnoise.c | 99 ++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 3 deletions(-)

-- 
2.38.1

