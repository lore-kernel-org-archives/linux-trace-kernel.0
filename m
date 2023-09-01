Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFB70CA0FE5
	for <linux-trace-kernel@archiver.kernel.org>; Fri,  1 Sep 2023 15:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237546AbjIAPLw (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 1 Sep 2023 11:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbjIAPLw (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 11:11:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EF7E65
        for <linux-trace-kernel@vger.kernel.org>; Fri,  1 Sep 2023 08:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693581062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PjPKhI43vIfzzZd2VhUjYTOy+VZHsBkuOPPi/NbdW0w=;
        b=G0l86/fB9CnKCHQXlqLe/X26x1sOg1iddgL2iBCdzdWvtwHJsbr5CLRr+r9nWP5BEQaG+J
        K3rd5IokmrVJavKakeqY0QpQduwizAbBDe/2uw45ukVsbVkucd/Mj7Bpcedj5RwlZM7gjF
        +8Yc4TfJprB8o9+62Jj7te21ebhnPgs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-374-u4ehhMJuNSqMc1yKj6PK3g-1; Fri, 01 Sep 2023 11:11:00 -0400
X-MC-Unique: u4ehhMJuNSqMc1yKj6PK3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4A14429AA382;
        Fri,  1 Sep 2023 15:11:00 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.39.193.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 23C652012F37;
        Fri,  1 Sep 2023 15:10:58 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 0/4] Minor v6.6 trace_events_filter fixes
Date:   Fri,  1 Sep 2023 17:10:35 +0200
Message-Id: <20230901151039.125186-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi,

These are small fixes incorporating feedback on the trace filters part of [1].

Based on top of trace-v6.6.

Cheers,
Valentin

[1]: https://lore.kernel.org/all/20230720163056.2564824-1-vschneid@redhat.com/

Valentin Schneider (4):
  tracing/filters: Fix error-handling of cpulist parsing buffer
  tracing/filters: Fix double-free of struct filter_pred.mask
  tracing/filters: Change parse_pred() cpulist ternary into an if block
  tracing/filters: Fix coding style issues

 kernel/trace/trace_events_filter.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

--
2.31.1

