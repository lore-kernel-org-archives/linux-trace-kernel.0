Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C76FC04A6A
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 15 Aug 2023 09:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235844AbjHOJEK (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 15 Aug 2023 05:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbjHOJDO (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:03:14 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454A91BCD
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:02:22 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQ4ts3S06ztRmK;
        Tue, 15 Aug 2023 16:58:45 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 17:02:20 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <shuah@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH -next 0/2] add loongarch and riscv support for kprobe args test
Date:   Tue, 15 Aug 2023 16:59:10 +0800
Message-ID: <20230815085912.701356-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-trace-kernel.vger.kernel.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org

Yu Liao (2):
  selftests/ftrace: add loongarch support for kprobe args char tests
  selftests/ftrace: Add riscv support for kprobe arg tests

 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc      | 6 ++++++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc    | 3 +++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc    | 4 ++++
 3 files changed, 13 insertions(+)

-- 
2.25.1

