Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A472DECA1;
	Thu, 28 Aug 2025 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366502; cv=none; b=ttx1+ICrAjCfY1JZ4WsuFVetfXkLHO7muiNu5MLO58OR+C2NGur4nL6FmlN9jQS+J5/T3QYxK+HFwHuv7f8uKv/XHGuL9wjFa9ri0/yIQ4uBheZa/0ZgEJt/JAjEAH11cLNn5yPSrjxCCuxFG2mbS1uIF4Bg+VTy5kBvP/mkcak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366502; c=relaxed/simple;
	bh=ivSu/IMaZGfW21FS3ZEvzo2NiJNn9PUIMXyecx0W7Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8BNSAZm16uhgTmisYzx2adXjdoSocnEBlOZiylXxmwn4dLsruz+ImW8p1FBZFuth3GTL45edbYGwF+13Mx+vEuObNgA21yZC38TYpKW+KIwHMLJOrsjT2ILuoyua2ZuuSL09mI2OAsexYJHJupAKqN6idT8HnbFBSBl1a6gg04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SC7kjKQp; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SC7kjKQp"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso632475b3a.1;
        Thu, 28 Aug 2025 00:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366501; x=1756971301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KOiu/GBUWD+aWp2OIEycImwBUVzT2dU285cFy6GfNhs=;
        b=SC7kjKQpI6Tc+KOWaooHsnrKpEUHsjOaFLlC6AOMlNwg1ANXmC67tVktmXdz90SDsQ
         8ySftmNZ406m4RLJfHN62LeAxGlDiaFovan5D3v2AN0J4KPA1pzfGKuBVFSlEJs84sI0
         LNjhrit3oNoMrm4cBZUBvyw+yb1f/KRFwGf9kl4UgOJlXXvvKvLr+V4/zVv3wr5oH/pE
         9SDMA2ObmztgpdElkr6XCx+jd7gWFkP1rdOHr8wZUxmOvMskzD74/KNuJ7tHofh72RjR
         ikaEEne8PtGA26jquAEgRK/yxet/XdHpmxkWWTLkQn3i0j5CYAdHVGsvUGjzUdV+rEHX
         4XPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366501; x=1756971301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOiu/GBUWD+aWp2OIEycImwBUVzT2dU285cFy6GfNhs=;
        b=r71I3SfHkPgVE2/mPC8Y5yKF0t6NUNst6ixs2BzdJtt5o8qGWt0HGh9HbjuSy5/1OG
         /f4aTlXTrsNHHFyL1bdg9jaO5MKoXcQR5kWgMzVpXJftXsfavvofFKmGVIUfzZCqnH+t
         kezgW9AGsCLI5kpE5q/TaVRmeyjJA6JFvAIsEk6ygNgs6PrjZjUBwQjkhzgxUBM9HPR4
         koadFlMflA3vqShBuvRX0iMe/BL+Wig5eYWeDcBSej7y2JEkcaWn+joqGzdRGVA3tYgf
         ugk2/6PHdVz5YtW95d/xEl8+ofzj50H5SDn+pFN9OldFs113m5ExhODQQV/tIdYGeW0x
         kIeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXawYh601CpWbSvt7qhV3RPJYAfvFZpeNAE1Z2Okt2J5Pn0AaKHZyTwUlxBs8EfF3VdoBTfXymEjlwm04+cwLeSGac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBRY5tOxX5wBUVSiI++OOvIqKZb380N0TJsbEgWQgQVn1RJRA
	pNn+xnr/yERAIFhgKiifZaRLm00phfB9bLEjoOqDho830qmYRYyRVYIh
X-Gm-Gg: ASbGncv1LzmO/BHeCR0ivABxVzPI433xOSIzIuOybMdgyZ2l9WfuwrBwwSjdHSIUlrP
	NnnEJ6sS2sfZjQTaQY4KIhTAlX4+Y97y0o7lT4Tq8oFwW1rA8CGMLFI3UQvRtUl9NHHHV2iDKmn
	JE1qVit1HTosoyvsieMFjG5KYZs/6EazhIzvNYS7Vj7ojE+tNPBMzGCoxGqCc6zaDzG0prx4atV
	O71MTIsOhzIcafcqALlu1t+iKDTwJ4mzk4uxda7RJRcj3j8/Hl85lDOTSHA0xQaOaxqlq/T8UAm
	jjMII17+LrHmyD5lPGhXw0j/4qvWIy7B6mYP5dZBBXrTQ/8e1YJ1rLVma1BxrO+EzcK04RkfHuq
	FR3BpRWNftk9LlCESU3JbtBh2QIp/ZccoT+82CMWbzvv7iPTph6W/68GkWXZK
X-Google-Smtp-Source: AGHT+IFY7Sr3NFmqU4r7l704msEMWDuzdTM26kIlnGaBdOScCFq81peAWPHhGn4VtotCUhBmhFVWWA==
X-Received: by 2002:a05:6a20:2585:b0:240:ed9:dd0a with SMTP id adf61e73a8af0-24340d11bf2mr32380410637.35.1756366500817;
        Thu, 28 Aug 2025 00:35:00 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:35:00 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 15/17] mm/ksw: add recursive corruption test
Date: Thu, 28 Aug 2025 15:32:48 +0800
Message-ID: <20250828073311.1116593-16-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828073311.1116593-1-wangjinchao600@gmail.com>
References: <20250828073311.1116593-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a test case simulating stack corruption across recursive calls.
This scenario writes to a local buffer at every recursion depth up to a
configured maximum, allowing validation that KStackWatch can detect
corruption in nested stack frames.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch_test.c | 32 ++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/mm/kstackwatch/kstackwatch_test.c b/mm/kstackwatch/kstackwatch_test.c
index 1f0d616db7c5..cb216b6ee5d7 100644
--- a/mm/kstackwatch/kstackwatch_test.c
+++ b/mm/kstackwatch/kstackwatch_test.c
@@ -146,6 +146,30 @@ static void silent_corruption_test(void)
 		silent_corruption_hapless(i);
 }
 
+/*
+ * Test Case 3: Recursive Call Corruption
+ * Check whether KStackWatch can handle corruption in a recursive call
+ * Write the local variable at every depth
+ * Configure /proc/kstackwatch to specify the corruption depth
+ * Verify that the watch is triggered
+ */
+static void recursive_corruption_test(int depth)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("KSW: test: recursive call at depth %d\n", depth);
+	pr_info("KSW: test: buffer 0x%px\n", buffer);
+	if (depth <= MAX_DEPTH)
+		recursive_corruption_test(depth + 1);
+
+	buffer[0] = depth;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("KSW: test: returning from depth %d\n", depth);
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -177,6 +201,11 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("KSW: test: triggering silent corruption test\n");
 			silent_corruption_test();
 			break;
+		case 3:
+			pr_info("KSW: test: triggering recursive corruption test\n");
+			/* depth start with 0 */
+			recursive_corruption_test(0);
+			break;
 		default:
 			pr_err("KSW: test: Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -198,7 +227,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"Usage:\n"
 		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
 		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n"
-		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n";
+		"  echo 'test2' > /proc/kstackwatch_test  - Silent corruption test\n"
+		"  echo 'test3' > /proc/kstackwatch_test  - Recursive corruption test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

