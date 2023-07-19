Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8664AC001DC
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 19 Jul 2023 04:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjGSEbb (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Wed, 19 Jul 2023 00:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjGSEba (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 00:31:30 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2501B1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Jul 2023 21:31:28 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5MWR5j3PzCTrCL
        for <linux-trace-kernel@vger.kernel.org>; Wed, 19 Jul 2023 11:58:59 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689739139; x=1692331140; bh=g+gKctoELFDP+ddd+DRaRwJpB4a
        9mxa7pY0/WAvW5us=; b=aUBMEBcYPHKDRBO0LIZawumcmzQR87E0/5i9/Cxg2Ji
        MTMqZdqEn28geSd88SqT+b6G06bR9bhiKYjZRcBvW7mWcDKbHRcmIjQ4F097d7rz
        gzPnLCdNin9k4m1lkfJ7KhG1XD2MrwIthVBZPBO8v2ZfDv9ctYJSgdybCGxP+SvL
        Y5GwM1TS6l3fVbbVauyo+tkJ6FsCI7G8Nh3AdNrpKgH/qWidAHSM/5wAfbcgIltc
        LTQcs2r4C9pPti8SJm5JIVmOhPavP5X8N6X8CEaUkGiI603gAT51Ye6OEH6Z4kFM
        uHq9aqh3+PC8Ub00oppIcUEZDMbezcjHDuZFPugRB0g==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id j7yMlpFhwoSO for <linux-trace-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 11:58:59 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5Lgg5ttGzCDHsB;
        Wed, 19 Jul 2023 11:21:03 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 11:21:03 +0800
From:   sunran001@208suo.com
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] include: events: remove spaces after '(' and before ')'
In-Reply-To: <20230719030939.18448-1-xujianghui@cdjrlc.com>
References: <20230719030939.18448-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7d6b48368594b2f815dff7c5375be638@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Fix four occurrences of the checkpatch error:

ERROR: space prohibited after that open parenthesis '('
ERROR: space prohibited before that close parenthesis ')'

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  include/trace/events/nmi.h | 6 +++---
  1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/trace/events/nmi.h b/include/trace/events/nmi.h
index 18e0411398ba..99abd0bc8ebd 100644
--- a/include/trace/events/nmi.h
+++ b/include/trace/events/nmi.h
@@ -15,9 +15,9 @@ TRACE_EVENT(nmi_handler,
  	TP_ARGS(handler, delta_ns, handled),

  	TP_STRUCT__entry(
-		__field(	void *,		handler	)
-		__field(	s64,		delta_ns)
-		__field(	int,		handled	)
+		__field(void *,	handler)
+		__field(s64, delta_ns)
+		__field(int, handled)
  	),

  	TP_fast_assign(
