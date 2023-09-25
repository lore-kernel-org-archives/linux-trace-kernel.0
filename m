Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08126288
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:08:36 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3540310C;
	Mon, 25 Sep 2023 16:08:35 -0700 (PDT)
Received: from localhost.localdomain (unknown [4.155.48.113])
	by linux.microsoft.com (Postfix) with ESMTPSA id B48EB212C81F;
	Mon, 25 Sep 2023 16:08:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B48EB212C81F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695683314;
	bh=wB3d//EX+ogKijIJTe8Ceqkr+8ED/kywJ6SuAQTP9vQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CTAqxWFOfb0l8YHKBUEnkG96vNvFe+P+AuTU/Gonj3EuD+sQ9o7eqYJFi4We9eF6h
	 aOJu/i67vBNz/2POtoAv1vcLmjmNqanoQoXo/zg7/+u3iRnZzf6fwrJOrri69aC/pl
	 fut1vMf8O2ylt/hgtdkHTbVhC1Itpj6Guc7CRboM=
From: Beau Belgrave <beaub@linux.microsoft.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	cleger@rivosinc.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Date: Mon, 25 Sep 2023 23:08:29 +0000
Message-Id: <20230925230829.341-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925230829.341-1-beaub@linux.microsoft.com>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The abi_test currently uses a long sized test value for enablement
checks. On LE this works fine, however, on BE this results in inaccurate
assert checks due to a bit being used and assuming it's value is the
same on both LE and BE.

Use int type for 32-bit values and long type for 64-bit values to ensure
appropriate behavior on both LE and BE.

Fixes: 60b1af8de8c1 ("tracing/user_events: Add ABI self-test")
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 tools/testing/selftests/user_events/abi_test.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/user_events/abi_test.c b/tools/testing/selftests/user_events/abi_test.c
index 5125c42efe65..67af4c491c0c 100644
--- a/tools/testing/selftests/user_events/abi_test.c
+++ b/tools/testing/selftests/user_events/abi_test.c
@@ -46,7 +46,7 @@ static int change_event(bool enable)
 	return ret;
 }
 
-static int reg_enable(long *enable, int size, int bit)
+static int reg_enable(void *enable, int size, int bit)
 {
 	struct user_reg reg = {0};
 	int fd = open(data_file, O_RDWR);
@@ -68,7 +68,7 @@ static int reg_enable(long *enable, int size, int bit)
 	return ret;
 }
 
-static int reg_disable(long *enable, int bit)
+static int reg_disable(void *enable, int bit)
 {
 	struct user_unreg reg = {0};
 	int fd = open(data_file, O_RDWR);
@@ -89,12 +89,14 @@ static int reg_disable(long *enable, int bit)
 }
 
 FIXTURE(user) {
-	long check;
+	int check;
+	long check_long;
 };
 
 FIXTURE_SETUP(user) {
 	change_event(false);
 	self->check = 0;
+	self->check_long = 0;
 }
 
 FIXTURE_TEARDOWN(user) {
@@ -131,9 +133,9 @@ TEST_F(user, bit_sizes) {
 
 #if BITS_PER_LONG == 8
 	/* Allow 0-64 bits for 64-bit */
-	ASSERT_EQ(0, reg_enable(&self->check, sizeof(long), 63));
-	ASSERT_NE(0, reg_enable(&self->check, sizeof(long), 64));
-	ASSERT_EQ(0, reg_disable(&self->check, 63));
+	ASSERT_EQ(0, reg_enable(&self->check_long, sizeof(long), 63));
+	ASSERT_NE(0, reg_enable(&self->check_long, sizeof(long), 64));
+	ASSERT_EQ(0, reg_disable(&self->check_long, 63));
 #endif
 
 	/* Disallowed sizes (everything beside 4 and 8) */
@@ -195,7 +197,7 @@ static int clone_check(void *check)
 	for (i = 0; i < 10; ++i) {
 		usleep(100000);
 
-		if (*(long *)check)
+		if (*(int *)check)
 			return 0;
 	}
 
-- 
2.34.1

