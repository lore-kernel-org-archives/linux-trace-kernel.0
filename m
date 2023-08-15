Return-Path: <linux-trace-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A10FC001DE
	for <linux-trace-kernel@archiver.kernel.org>; Tue, 15 Aug 2023 09:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjHOJEL (ORCPT
        <rfc822;linux-trace-kernel@archiver.kernel.org>);
        Tue, 15 Aug 2023 05:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235884AbjHOJDQ (ORCPT
        <rfc822;linux-trace-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 05:03:16 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE091BD4
        for <linux-trace-kernel@vger.kernel.org>; Tue, 15 Aug 2023 02:02:23 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQ4vd3Z4NzFqdF;
        Tue, 15 Aug 2023 16:59:25 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 17:02:21 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
        <rostedt@goodmis.org>, <shuah@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH -next 2/2] selftests/ftrace: Add riscv support for kprobe arg tests
Date:   Tue, 15 Aug 2023 16:59:12 +0800
Message-ID: <20230815085912.701356-3-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230815085912.701356-1-liaoyu15@huawei.com>
References: <20230815085912.701356-1-liaoyu15@huawei.com>
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

This is the riscv variant of commit 9855c4626c67 ("selftests/ftrace:
Add ppc support for kprobe args tests").

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 3 +++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 3 +++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc      | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index 3047fa96a7b7..3462c06d29b0 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
@@ -31,6 +31,9 @@ mips*)
 loongarch*)
   ARG1=%r4
 ;;
+riscv*)
+  ARG1=%a0
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
index a4f8e7c53c1f..9bfd2e488cea 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
@@ -31,6 +31,9 @@ mips*)
 loongarch*)
   ARG1=%r4
 ;;
+riscv*)
+  ARG1=%a0
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
index 1df61e13a812..8f1292ad80ff 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc
@@ -44,6 +44,10 @@ loongarch*)
   GOODREG=%r4
   BADREG=%r12
 ;;
+riscv*)
+  GOODREG=%a0
+  BADREG=%a8
+;;
 *)
   echo "Please implement other architecture here"
   exit_untested
-- 
2.25.1

