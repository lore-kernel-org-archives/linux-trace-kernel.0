Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60034412
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Oct 2023 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DBDFA;
	Tue, 17 Oct 2023 19:05:28 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S9DdG4fWszrTWX;
	Wed, 18 Oct 2023 10:02:42 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 18 Oct
 2023 10:05:20 +0800
From: Yu Liao <liaoyu15@huawei.com>
To: <skhan@linuxfoundation.org>
CC: <liaoyu15@huawei.com>, <liwei391@huawei.com>, <rostedt@goodmis.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <shuah@kernel.org>, <mhiramat@kernel.org>
Subject: [RESEND PATCH 2/2] selftests/ftrace: Add riscv support for kprobe arg tests
Date: Wed, 18 Oct 2023 10:08:58 +0800
Message-ID: <20231018020858.1304218-3-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018020858.1304218-1-liaoyu15@huawei.com>
References: <20231018020858.1304218-1-liaoyu15@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This is the riscv variant of commit 9855c4626c67 ("selftests/ftrace:
Add ppc support for kprobe args tests").

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 3 +++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 3 +++
 .../selftests/ftrace/test.d/kprobe/kprobe_args_syntax.tc      | 4 ++++
 3 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
index 2b04603a3b40..21db6b720754 100644
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
index a202b2ea4baf..4e086f871cee 100644
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

