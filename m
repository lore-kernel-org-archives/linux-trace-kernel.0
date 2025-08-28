Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410072F39A3;
	Thu, 28 Aug 2025 07:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366499; cv=none; b=h9QDPqmjpGp7r6PiDPCuOLKWr4siGc7p6bOZYKY7y4wVGfEmcLLkSHBUPedm/CWB6oPGRsXUzK2jhmPeHglcxwZ+6bZKGcEWUR3L4EvmeyiPEBO0O7jZJhB8+UkOR8ac6InNee8qIu9R8epGBJuyx5zizbifo3VnnUYqcVq9Irg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366499; c=relaxed/simple;
	bh=LZfImMzMcwQbupG4M6+Sd95ddnMNs/MgYxCY/DAN4QM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UJ73jBy6uiIeV7AMvoqzxt5AATDUGbq0Xf2LmPjlhgQGNsyHF01s7Gt4aSzSaxyxjzaNA0ADZSJluU33RdeGp+UcQEO14Yz7SvQE4V3vNMqqtpdKLNa+b8Hxv5AudFLxqZZbEt4M85GoykLnHj7FYcQwx+4H8TCU3NTCBoiDomM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GJ7SUa40; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GJ7SUa40"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7704f3c46ceso563776b3a.2;
        Thu, 28 Aug 2025 00:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366497; x=1756971297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MrzeI3EYnXpSYBJKftFAUOvxevvy4jLNuncba+XGBDk=;
        b=GJ7SUa40KafgGjuf1ElpkcXGYWS/31QvxRdywg5ZfBRB6PjzRME/I7kPqJ42PLbG7a
         m4us4nTVeA/6I8nhrOoSEPD24qVXyOGV7PH6AwHBYZWgYu2yyYufjl4nY3SDpgFns3w5
         4JmpZUZXxv99Hx4iym/txk2wEx4lgv79OdQNyYekWZ3VEbjDGYSWdUsSzoNdqEUY3YyO
         e3mMdk/Upi6dnu0HMn6ZomPFlUrBEKHCgH9SHw6WRAUhjs38HJpVZnJ0m442k0nvM7ND
         Eg8sC5JLje331TBD7xOCOMG/ez9YMGbT1Ug17WMD8E5lYMy8f+9qOME29R8FfVcBc0R0
         N8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366497; x=1756971297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MrzeI3EYnXpSYBJKftFAUOvxevvy4jLNuncba+XGBDk=;
        b=SGbVhyz0wMpDBtbgHie+5lIEiJlKi4k/I90V3EwTkEeFf9NadKVok7xSP0DvWaRExm
         A++y1FrHCgfvHqkDRQa7RLlSYLEqY+bj3YdLK311BXx7cnNwAl1AAVv1oazld1px9sWx
         LGg+Wdbtpnolm9QZiIlOt7PC5HuY6scOfwxlxBSvVHpjfx/4dL/SgjnmD2QVyBmDtFYc
         A+9cO7GwtZZtcMS0SUpGewsqmvj5UY2/KSELMKZPPra+KbYBw9gnikCv6XVphltnTkuo
         3lVz1cGisIk3tbGIZ6cdsNibeDhdPoJnpdAne9KLeOepK2rV8mRk8ofepllzRYAIjQtz
         1U1A==
X-Forwarded-Encrypted: i=1; AJvYcCVotZ3n3tn+Z7AyH7QcNcIX6RdUElvSf70b0fJLGYYo+j93mh6GUlFKwtO3+hX7VHK1qtvOn2nT1YthbyLgryBzRpQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu2sVxsPu19cBACQ5TByG/kZ61ZnDFrZSCIF15snNa4FdamgQE
	qyX5kyrkZDRfgM7QvgYstvS1EZN5SR9Y0GU3/AlGHVYPbYHFEjGV/+HM21QmL8TwTXs=
X-Gm-Gg: ASbGncvGzRPvzaTQjtQUtCBXdVYmyuJ+oReYB+XZPJk9K0fnSaV4qA7j52cuYXSe8rs
	y62TjAvVlIbnfMX/7QJV/nk/BeQGByiqb/OFAVU1XHUs6sdRLB3npJkeC8Hf1XEbh2DXl074dW5
	cFaG48kH3/cfQsGkwg++f+aLbgTFxc96FaFOl5a4M4KOulUNw7cp/B6OxwG9VAk9xxSiOt6qe6+
	bKujx6pmn6fgcLa9X+nUAvg/wtoWXYZdhXxxBZVxC6AA5bsGGZdC4A8KUGeydWS4QGNF/d1uZ4g
	YPTlaRqAuhizfOf/xkPeDCoeM8w2mC3rWx+yDiiB4+uUz7VsbBx7ohl1P1rMrwu8jOWhzBzZk6k
	sdJdpe5dYO8D0q7uR+nmWxlVXcB28NQgTsamuHfy6YfdpkQnfxw==
X-Google-Smtp-Source: AGHT+IHD57dw5PWoE8qv8A9jbGNzXzct5VOkOCkS7MNXKbnk/+b/dQdygfPv1AzYB+6KyyshnI7WQg==
X-Received: by 2002:a05:6a21:6d84:b0:243:971d:cd84 with SMTP id adf61e73a8af0-243971dd02bmr9544389637.22.1756366497452;
        Thu, 28 Aug 2025 00:34:57 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:57 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 14/17] mm/ksw: add simplified silent corruption test
Date: Thu, 28 Aug 2025 15:32:47 +0800
Message-ID: <20250828073311.1116593-15-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduce a lightweight test case simulating “silent” stack corruption
where hapless() is unaware its local variable may have been modified.
This test is much simpler than real production scenarios but demonstrates
the core logic.

Test logic:
- buggy(): exposes a local variable via a global pointer without resetting
  it, creating a dangling reference.
- unwitting(): a background kernel thread accesses the global pointer and
  modifies the pointed memory.
- hapless(): operates on its local variable, unaware it may be modified.

This controlled, minimal scenario provides a simple way to validate
KStackWatch’s detection of unintended stack modifications or silient
corruption.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch_test.c | 90 ++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kstackwatch_test.c b/mm/kstackwatch/kstackwatch_test.c
index 138163472b03..1f0d616db7c5 100644
--- a/mm/kstackwatch/kstackwatch_test.c
+++ b/mm/kstackwatch/kstackwatch_test.c
@@ -22,6 +22,9 @@ static struct proc_dir_entry *test_proc;
 #define BUFFER_SIZE 4
 #define MAX_DEPTH 4
 
+/* global variables for silient corruption test */
+static u64 *g_corrupt_ptr;
+
 /*
  * Test Case 0: Write to the canary position directly (Canary Test)
  * use a u64 buffer array to ensure the canary will be placed
@@ -63,6 +66,86 @@ static void canary_test_overflow(void)
 	pr_info("KSW: test: canary overflow test completed\n");
 }
 
+static void do_something(int min_ms, int max_ms)
+{
+	u32 rand;
+
+	get_random_bytes(&rand, sizeof(rand));
+	rand = min_ms + rand % (max_ms - min_ms + 1);
+	msleep(rand);
+}
+
+static void silent_corruption_buggy(int i)
+{
+	u64 local_var;
+
+	pr_info("KSW: test: starting %s\n", __func__);
+
+	pr_info("KSW: test: %s %d local_var addr: 0x%px\n", __func__, i,
+		&local_var);
+	WRITE_ONCE(g_corrupt_ptr, &local_var);
+
+	//buggy: return without reset g_corrupt_ptr
+}
+
+static int silent_corruption_unwitting(void *data)
+{
+	pr_debug("KSW: test: starting %s\n", __func__);
+	u64 *local_ptr;
+
+	do {
+		local_ptr = READ_ONCE(g_corrupt_ptr);
+		do_something(0, 300);
+	} while (!local_ptr);
+
+	local_ptr[0] = 0;
+
+	return 0;
+}
+
+static void silent_corruption_hapless(int i)
+{
+	u64 local_var;
+
+	pr_debug("KSW: test: starting %s %d\n", __func__, i);
+	get_random_bytes(&local_var, sizeof(local_var));
+	local_var = 0xff0000 + local_var % 0xffff;
+	pr_debug("KSW: test: %s local_var addr: 0x%px\n", __func__, &local_var);
+
+	do_something(50, 150);
+	if (local_var >= 0xff0000)
+		pr_info("KSW: test: %s %d happy with 0x%llx", __func__, i,
+			local_var);
+	else
+		pr_info("KSW: test: %s %d unhappy with 0x%llx", __func__, i,
+			local_var);
+}
+
+/*
+ * Test Case 2: Silient Corruption
+ * buggy() does not protect its local var correctly
+ * unwitting() simply does its intended work
+ * hapless() is unaware know what happened
+ */
+static void silent_corruption_test(void)
+{
+	struct task_struct *unwitting;
+
+	pr_info("KSW: test: starting %s\n", __func__);
+	WRITE_ONCE(g_corrupt_ptr, NULL);
+
+	unwitting = kthread_run(silent_corruption_unwitting, NULL,
+				"unwitting");
+	if (IS_ERR(unwitting)) {
+		pr_err("KSW: test: failed to create thread2\n");
+		return;
+	}
+
+	silent_corruption_buggy(0);
+	for (int i = 0; i < 10; i++)
+		silent_corruption_hapless(i);
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -90,6 +173,10 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("KSW: test: triggering canary overflow test\n");
 			canary_test_overflow();
 			break;
+		case 2:
+			pr_info("KSW: test: triggering silent corruption test\n");
+			silent_corruption_test();
+			break;
 		default:
 			pr_err("KSW: test: Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -110,7 +197,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"==================================\n"
 		"Usage:\n"
 		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
-		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n";
+		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n"
+		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

