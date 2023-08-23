Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFDCEE49A5
	for <linux-trace-kernel@archiver.kernel.org>; Wed, 23 Aug 2023 02:04:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjHWCET (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 22 Aug 2023 22:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232156AbjHWCES (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 22:04:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25738E5D;
        Tue, 22 Aug 2023 19:04:13 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RVqDj0QkYzNmxH;
        Wed, 23 Aug 2023 10:00:37 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 23 Aug
 2023 10:04:11 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <bristot@kernel.org>, <rostedt@goodmis.org>
CC:     <liaoyu15@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <liwei391@huawei.com>
Subject: [PATCH -next v2] rv/include: set variable 'da_mon_##name' to static
Date:   Wed, 23 Aug 2023 10:00:51 +0800
Message-ID: <20230823020051.3184953-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

gcc with W=1 reports
kernel/trace/rv/monitors/wip/wip.c:20:1: sparse: sparse: symbol 'da_mon_wip' was not declared. Should it be static?

The per-cpu variable 'da_mon_##name' is only used in its defining file, so
it should be static.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307280030.7EjUG9gR-lkp@intel.com/
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
v1 -> v2: fix the backslash 
---
 include/rv/da_monitor.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index 9eb75683e012..9705b2a98e49 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -262,7 +262,7 @@ static inline void da_monitor_destroy_##name(void)						\
 /*												\
  * per-cpu monitor variables									\
  */												\
-DEFINE_PER_CPU(struct da_monitor, da_mon_##name);						\
+static DEFINE_PER_CPU(struct da_monitor, da_mon_##name);					\
 												\
 /*												\
  * da_get_monitor_##name - return current CPU monitor address					\
-- 
2.25.1

