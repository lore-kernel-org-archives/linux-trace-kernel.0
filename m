Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88997483;
	Tue, 20 Aug 2024 00:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724115403; cv=none; b=cEQZkGKUTJkj/Z3gpiM5fF57csCdl7WW3wz1mqTc9fs659L4UZ4rbn3+vE+K3ZN24YpDSpq5kXmg1m9oKzwAh1WiNBaPDg4ozQbJfuQ98oFJe4jpp4XJbDkTaFPoWh2vqkI6uuZKrjXF8lmRffM6h3wx5BXIjw8kwiQjtBaZRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724115403; c=relaxed/simple;
	bh=F+7+0r9dfywiWlAXd8gckAT02cgsXlbdVrQ/xNdaQOo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=B1maYBcj0UL6Exs4SZLMFdT2ZOlezq1UxKj+v38lIn5OY/5sxIpYWFmYnb48B1t3UXh9hcjsT/karLKY7DFfzqXGVIc27lqfCu36/NS9LOZ/v8ojqBO5Ut9Y0uWRq31mgfXNFnBdFyDYc8l8KMaKpW3BYVs3hDUAcB5R9CIDhaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIMAEpoQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIMAEpoQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37756C32782;
	Tue, 20 Aug 2024 00:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724115402;
	bh=F+7+0r9dfywiWlAXd8gckAT02cgsXlbdVrQ/xNdaQOo=;
	h=From:To:Cc:Subject:Date:From;
	b=aIMAEpoQOaLMmIqF27scOAkZqlsy2vFxnDJXV5DGWSu1eBnIVzyr5jx7JeaVal7Mb
	 bNLARS2SYH045QhkVgVcHT5L5BT89T917KzL51WRR5Co0Bfgce8qH5clLftA/gtu6n
	 R0+GqV3dPAX41wldHudD4QrXN5XSSbJEyH+Shw9AW8f5/YiMxX0J6KpzdlhdDp61P3
	 3paQYI/vR3D4YiX9XHdgWhQWs92jvXbaJrcL+opF4wLSsVQsP7F/h6kxVQDhc1EX+L
	 E5gLVabDcyWC2uKGSG97aAeulmD1B4cvKKiD/SdVi/s8vVffbe93l/uXxmUBhDo5NH
	 d7B11S5qkJgiA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhiramat@kernel.org
Subject: [PATCH] tracing: Fix memory leak in fgraph storage selftest
Date: Tue, 20 Aug 2024 09:56:38 +0900
Message-Id: <172411539857.28895.13119957560263401102.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

With ftrace boot-time selftest, kmemleak reported some memory leaks in
the new test case for function graph storage for multiple tracers.

unreferenced object 0xffff888005060080 (size 32):
  comm "swapper/0", pid 1, jiffies 4294676440
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 10 06 05 80 88 ff ff  ........ .......
    54 0c 1e 81 ff ff ff ff 00 00 00 00 00 00 00 00  T...............
  backtrace (crc 7c93416c):
    [<000000000238ee6f>] __kmalloc_cache_noprof+0x11f/0x2a0
    [<0000000033d2b6c5>] enter_record+0xe8/0x150
    [<0000000054c38424>] match_records+0x1cd/0x230
    [<00000000c775b63d>] ftrace_set_hash+0xff/0x380
    [<000000007bf7208c>] ftrace_set_filter+0x70/0x90
    [<00000000a5c08dda>] test_graph_storage_multi+0x2e/0xf0
    [<000000006ba028ca>] trace_selftest_startup_function_graph+0x1e8/0x260
    [<00000000a715d3eb>] run_tracer_selftest+0x111/0x190
    [<00000000395cbf90>] register_tracer+0xdf/0x1f0
    [<0000000093e67f7b>] do_one_initcall+0x141/0x3b0
    [<00000000c591b682>] do_initcall_level+0x82/0xa0
    [<000000004e4c6600>] do_initcalls+0x43/0x70
    [<0000000034f3c4e4>] kernel_init_freeable+0x170/0x1f0
    [<00000000c7a5dab2>] kernel_init+0x1a/0x1a0
    [<00000000ea105947>] ret_from_fork+0x3a/0x50
    [<00000000a1932e84>] ret_from_fork_asm+0x1a/0x30
...

This means filter hash allocated for the fixtures are not correctly
released after the test.

Free those hash lists after tests are done and split the loop for
initialize fixture and register fixture for rollback.

Fixes: dd120af2d5f8 ("ftrace: Add multiple fgraph storage selftest")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_selftest.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index 97f1e4bc47dc..c4ad7cd7e778 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -942,7 +942,7 @@ static __init int test_graph_storage_multi(void)
 {
 	struct fgraph_fixture *fixture;
 	bool printed = false;
-	int i, ret;
+	int i, j, ret;
 
 	pr_cont("PASSED\n");
 	pr_info("Testing multiple fgraph storage on a function: ");
@@ -953,22 +953,35 @@ static __init int test_graph_storage_multi(void)
 		if (ret && ret != -ENODEV) {
 			pr_cont("*Could not set filter* ");
 			printed = true;
-			goto out;
+			goto out2;
 		}
+	}
 
+	for (j = 0; j < ARRAY_SIZE(store_bytes); j++) {
+		fixture = &store_bytes[j];
 		ret = register_ftrace_graph(&fixture->gops);
 		if (ret) {
 			pr_warn("Failed to init store_bytes fgraph tracing\n");
 			printed = true;
-			goto out;
+			goto out1;
 		}
 	}
 
 	DYN_FTRACE_TEST_NAME();
-out:
+out1:
+	while (--j >= 0) {
+		fixture = &store_bytes[j];
+		unregister_ftrace_graph(&fixture->gops);
+
+		if (fixture->error_str && !printed) {
+			pr_cont("*** %s ***", fixture->error_str);
+			printed = true;
+		}
+	}
+out2:
 	while (--i >= 0) {
 		fixture = &store_bytes[i];
-		unregister_ftrace_graph(&fixture->gops);
+		ftrace_free_filter(&fixture->gops.ops);
 
 		if (fixture->error_str && !printed) {
 			pr_cont("*** %s ***", fixture->error_str);

