Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45AC5C001DF
	for <linux-trace-kernel@archiver.kernel.org>; Sat,  5 Aug 2023 03:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbjHEDi5 (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Fri, 4 Aug 2023 23:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjHEDi4 (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:38:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE31B4ED9;
        Fri,  4 Aug 2023 20:38:54 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RHpF61563zrS4w;
        Sat,  5 Aug 2023 11:37:46 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 5 Aug 2023 11:38:52 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <rostedt@goodmis.org>, <mhiramat@kernel.org>,
        <vnagarnaik@google.com>, <shuah@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v2 0/2] tracing: Fix cpu buffers unavailable problem and add its testcase
Date:   Sat, 5 Aug 2023 11:38:14 +0800
Message-ID: <20230805033816.3284594-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Hi,

This is the v2 to fix cpu buffers unavailable problem after some
operations on file 'tracing_cpumask' and 'snapshot', also upload
its testcase. Changes show as below.

v2:
  - Fix compile issue reported-by kernel test robot <lkp@intel.com> with
    suggestion from Steve:
    - Link: https://lore.kernel.org/all/202308050731.PQutr3r0-lkp@intel.com/
    - Link: https://lore.kernel.org/all/20230804125107.41d6cdb1@gandalf.local.home/

  - Add a step to set tracing_on in testcase (see patch 2) and add
    descriptions of each step.

v1:
  - Link: https://lore.kernel.org/all/20230804124549.2562977-1-zhengyejian1@huawei.com/

Zheng Yejian (2):
  tracing: Fix cpu buffers unavailable due to 'record_disabled' messed
  selftests/ftrace: Add a basic testcase for snapshot

 kernel/trace/trace.c                          |  6 ++++
 .../ftrace/test.d/00basic/snapshot1.tc        | 31 +++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/00basic/snapshot1.tc

-- 
2.25.1

