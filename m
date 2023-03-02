Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BDDC7EE2F
	for <linux-trace-kernel@archiver.kernel.org>; Thu,  2 Mar 2023 17:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCBRSE (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Thu, 2 Mar 2023 12:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjCBRSC (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 12:18:02 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35055BBA1;
        Thu,  2 Mar 2023 09:18:00 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96A3E1FB;
        Thu,  2 Mar 2023 09:18:43 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 6AD713F67D;
        Thu,  2 Mar 2023 09:17:59 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-trace-kernel@vger.kernel.org, mark.rutland@arm.com,
        mhiramat@kernel.org, rostedt@goodmis.org, zanussi@kernel.org
Subject: [PATCH 0/2] tracing/hist: add a modulus operator
Date:   Thu,  2 Mar 2023 17:17:53 +0000
Message-Id: <20230302171755.1821653-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

I've been analysing some usercopy code, and wanted to cpature the spread
of sizes and alignment of copies for a workload. I found that histrogram
triggers were great for cpaturing the size, but there's not currently a
way to capture the alignment short of recording the entire base pointer
and post-processing the histogram, which is less than ideal.

These patches add a modulus operator to histogram expressions, so which
allows the alignment of pointers to be captured directly.

The first patch is a preparatory refactoring to the expression parsing
code, and the second actually adds the new operator.

Thanks,
Mark.

Mark Rutland (2):
  tracing/hist: simplify contains_operator()
  tracing/hist: add modulus operator

 Documentation/trace/histogram.rst |   4 +-
 kernel/trace/trace_events_hist.c  | 109 ++++++++++++++++--------------
 2 files changed, 62 insertions(+), 51 deletions(-)

-- 
2.30.2

