Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8085B67D;
	Fri, 22 Mar 2024 06:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090736; cv=none; b=Ql7AhIND5pmLGd4US6U3ysbm32bydJu95AOvWC5czw6Cgmvu+rN+7RH6FiQGsQo6CljgfSRLb8RkM8MbqN57Q041V+1lTRQ6P7lC/jBrlryZzbpMGA4VMkMK0dwqdebBcNj7YvPs5EGNCu5CctrTPFgCCpy6OjtCaz7WB1DeG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090736; c=relaxed/simple;
	bh=mm/LKOibx69xdWi9kZO3FwKzMXoZWR3O/2RiRcPvCZk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qbpb5Zc2MGqmgmhFYvEPBze1jO50XrWFq6SHxAdAQPdBTeAkNKM+AwT5hsbcqoWxjcMYIgZDaszTI/CEagcNxLyh0qU3b6oSTO9T9ACIp9fk45xOGGh/gsc6Qioz1VJLmyOUYGnzG9+qw6ZRzDS9vXjmFQ++k/uQuoUYqehw/Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V1CPH5w44zNmJx;
	Fri, 22 Mar 2024 14:40:03 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id 1E5C018007A;
	Fri, 22 Mar 2024 14:41:59 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 22 Mar
 2024 14:41:58 +0800
From: Ye Bin <yebin10@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <yebin10@huawei.com>
Subject: [PATCH v8 5/5] selftests/ftrace: add fprobe test cases for VFS type "%pd" and "%pD"
Date: Fri, 22 Mar 2024 14:43:08 +0800
Message-ID: <20240322064308.284457-6-yebin10@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240322064308.284457-1-yebin10@huawei.com>
References: <20240322064308.284457-1-yebin10@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500010.china.huawei.com (7.192.105.118)

This patch adds fprobe test cases for new print format type "%pd/%pD".The
test cases test the following items:
1. Test "%pd" type for dput();
2. Test "%pD" type for vfs_read();

This test case require enable CONFIG_HAVE_FUNCTION_ARG_ACCESS_API configuration.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 .../ftrace/test.d/dynevent/fprobe_args_vfs.tc | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
new file mode 100644
index 000000000000..49a833bf334c
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_args_vfs.tc
@@ -0,0 +1,40 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: Fprobe event VFS type argument
+# requires: kprobe_events "%pd/%pD":README
+
+: "Test argument %pd with name for fprobe"
+echo 'f:testprobe dput name=$arg1:%pd' > dynamic_events
+echo 1 > events/fprobes/testprobe/enable
+grep -q "1" events/fprobes/testprobe/enable
+echo 0 > events/fprobes/testprobe/enable
+grep "dput" trace | grep -q "enable"
+echo "" > dynamic_events
+echo "" > trace
+
+: "Test argument %pd without name for fprobe"
+echo 'f:testprobe dput $arg1:%pd' > dynamic_events
+echo 1 > events/fprobes/testprobe/enable
+grep -q "1" events/fprobes/testprobe/enable
+echo 0 > events/fprobes/testprobe/enable
+grep "dput" trace | grep -q "enable"
+echo "" > dynamic_events
+echo "" > trace
+
+: "Test argument %pD with name for fprobe"
+echo 'f:testprobe vfs_read name=$arg1:%pD' > dynamic_events
+echo 1 > events/fprobes/testprobe/enable
+grep -q "1" events/fprobes/testprobe/enable
+echo 0 > events/fprobes/testprobe/enable
+grep "vfs_read" trace | grep -q "enable"
+echo "" > dynamic_events
+echo "" > trace
+
+: "Test argument %pD without name for fprobe"
+echo 'f:testprobe vfs_read $arg1:%pD' > dynamic_events
+echo 1 > events/fprobes/testprobe/enable
+grep -q "1"  events/fprobes/testprobe/enable
+echo 0 > events/fprobes/testprobe/enable
+grep "vfs_read" trace | grep -q "enable"
+echo "" > dynamic_events
+echo "" > trace
-- 
2.31.1

