Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CBA3C3DA7D
	for <linux-trace-kernel@archiver.kernel.org>; Tue,  3 Jan 2023 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbjACMtd (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 3 Jan 2023 07:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237632AbjACMtb (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:49:31 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 69867262A;
        Tue,  3 Jan 2023 04:49:29 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9C1A152B;
        Tue,  3 Jan 2023 04:50:10 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4C4893F587;
        Tue,  3 Jan 2023 04:49:28 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, mhiramat@kernel.org, revest@chromium.org,
        rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] ftrace: Maintain samples/ftrace
Date:   Tue,  3 Jan 2023 12:49:10 +0000
Message-Id: <20230103124912.2948963-2-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230103124912.2948963-1-mark.rutland@arm.com>
References: <20230103124912.2948963-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

There's no entry in MAINTAINERS for samples/ftrace. Add one so that the
FTRACE maintainers are kept in the loop.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 7f86d02cb427a..739006e245fbd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8571,6 +8571,7 @@ F:	kernel/trace/fgraph.c
 F:	arch/*/*/*/*ftrace*
 F:	arch/*/*/*ftrace*
 F:	include/*/ftrace.h
+F:	samples/ftrace
 
 FUNGIBLE ETHERNET DRIVERS
 M:	Dimitris Michailidis <dmichail@fungible.com>
-- 
2.30.2

