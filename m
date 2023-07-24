Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458B2C001B0
	for <linux-trace-kernel@archiver.kernel.org>; Mon, 24 Jul 2023 14:09:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjGXOJF (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Mon, 24 Jul 2023 10:09:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231861AbjGXOIz (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:08:55 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7631729
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:08:39 -0700 (PDT)
Received: from kwepemi500012.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R8hnQ1gsmz1KCCn;
        Mon, 24 Jul 2023 22:07:38 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemi500012.china.huawei.com (7.221.188.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 22:08:28 +0800
From:   Gaosheng Cui <cuigaosheng1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <cuigaosheng1@huawei.com>
CC:     <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH 0/4] Fix kernel-doc warnings in kernel/trace
Date:   Mon, 24 Jul 2023 22:08:23 +0800
Message-ID: <20230724140827.1023266-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.244.148.83]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemi500012.china.huawei.com (7.221.188.12)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Fix kernel-doc warnings in kernel/trace, thanks very much!

Gaosheng Cui (4):
  ring-buffer: Fix kernel-doc warnings in ring_buffer.c
  tracing/synthetic: Fix kernel-doc warnings in trace_events_synth.c
  tracing: Fix kernel-doc warnings in trace_events_trigger.c
  tracing: Fix kernel-doc warnings in trace_seq.c

 kernel/trace/ring_buffer.c          | 3 +--
 kernel/trace/trace_events_synth.c   | 1 +
 kernel/trace/trace_events_trigger.c | 2 ++
 kernel/trace/trace_seq.c            | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

-- 
2.25.1

