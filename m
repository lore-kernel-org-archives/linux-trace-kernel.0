Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9E02D7D59;
	Thu, 28 Aug 2025 07:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756366496; cv=none; b=RhT3CYUQU7hTTqdmmFEv6riN8kYaCovCFRIC17ptBy0Mz0wwCbI4255QSlI4wUpIgVKA3bjAemVwyY/s/k/cf2wRYkVJ9vNP9G4ceM0bILafaqyAbSkciGgC3lBJljUPSNRFvWUrXvAnhdzdoIDFBBoxo39ncYvCXtQ+7bBRiG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756366496; c=relaxed/simple;
	bh=6rw+m4VKvEY+PNH3LtpXPUlmxSfDZ834B7ADRGFPwkE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhmJ01NW1GWG9HNMf0W3E8JW3+6y3tRka6ytWPPQQFrxHamujwr3zbqkzvZ8XEUrYCqzn4H6nvcMSxzieehZyvbgrwT8Kn98OycK4z8LNSW9aZH654LMbG7IdIO+qZ31/pgGtWRjtQM+HPjvOzLiNTzwNZcyYw6nc6nuLfHOUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M8OOP7e3; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M8OOP7e3"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32753ef4e33so524786a91.0;
        Thu, 28 Aug 2025 00:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756366494; x=1756971294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Or2e3wHrlUvOPFgjfY3GC0NcILvcAZ+AmyV41U5R5a8=;
        b=M8OOP7e3CaYEnkS8hKzzOszRiqHHYpcvFIJUs7RcQw518QRzBLpE+FYk3o5LEP2wxR
         dCf/h98IEQNavFaKuLmjQV8CwX8ckJu40WCi4M2dyBc5jDA434TTimtml7Po4NGKgAVf
         S1/R7q15T8fumOQ/gTXgHkXVmHkFDY01nISxjOa61fZG0zgWVRO8JIaGFFrT29VprVLb
         AsoPoX95wxkXb0XcgzHOeoSxwIHaQCW0WOrWNnyM9G5EIuXc1021e7+bYVkiXZBxAdYc
         tKiQj6TtiSIzqaZTjHbt8vt1eq7dZ9VGHllvqUzla87/Z7ek4Wt/mT6Q/1z/O8RY+cgK
         gOrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756366494; x=1756971294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Or2e3wHrlUvOPFgjfY3GC0NcILvcAZ+AmyV41U5R5a8=;
        b=hAJua/XkRTkeSVnZk13jVD9CpkQNOGUnb15BcrhehdV0u+echpd2HTUFXYMYAJFQt2
         D/QMbFzHQPyxOEkBcSXjXfFBcgOeluMI8Fj7TP/BGNyVD03FLldmc/vlSYejEdHxvwr2
         wGXzh5WRXsga2uchZ46+rHJdWV1Or3oUXW70KQ6PUXup9Fn50j80wc6cJje9y3aihmvV
         JzPpSzMpllD+G8Oi10ZwBSjkQsiaTPBrStuXxY5zL5DfoJ7tN5O1RkiXWY+4/PE/fze2
         /8Fn0OYqCDEtGOE13ZPpASuqsAQehshGo3OsUGaX9MfsLrRsY7joq+Q/C014z1WdB4mX
         DwoA==
X-Forwarded-Encrypted: i=1; AJvYcCV1APDv3pKPU4j4zHw/I/uLgMVBwVycGdVSZP9BDHaaWqwcOh1b8plJSp974Pk1qmmD4hIqfOeMZvZGbwYyFm3aEPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mZBOpTGBXSuVNxygZ9552LKGWZNtLOgmM0tihg2yy2X0pBXC
	hUXU9TexDAcLCsnEFPUJRdZ4Q2MjySbWoRcvtmpP1R509m7dJqoLErVA
X-Gm-Gg: ASbGncu5CtCKJY0/bbyTouDPjOrdovtaSORe0waqF2yNBJJ6tiRkTYVnlEQFPX6Ef1A
	k6/UXyn3Bi7L2UrNsaKbt9iky8S1Cnop6rVCPlqVngwpxjhTWvCRrogVsS7MmKBf6GggcBJuUgL
	7orJcE6GW3236zq/+7qQUdxRHb/zot0KW+cj8iZFl6o+gizaNNvfJpJyYc03+0OEHk9HxiT/ltU
	riBLuZ+lmwzw1Xs5XI9HX9VTqAvtIM8D8uF7T+ACG46E8DT1j6MDqIu66Pc130OfAXaA6NHzkAc
	PKy0zPrHQ9jcZd1dETGfi7ZWod3OoI4DNGoakO3jETpiAtnelZm3PwrOFJEoz+v2FZnUx7MUnFY
	NF6LlfRRdEijYjnB9vbt4ObhXLtDcw0X/Vu56lpsN3uJU1BPm41nbieUaZbxGA2fubllD7T4=
X-Google-Smtp-Source: AGHT+IHB1bGrZQkRWWOeTcaD9yBKG+Jt7AaKjMTGJ6v8jmWN0++u4eqV5qBUc+XfK8W7V9oke139Hg==
X-Received: by 2002:a17:90a:fc46:b0:327:5461:51ce with SMTP id 98e67ed59e1d1-32754615342mr10004212a91.35.1756366494136;
        Thu, 28 Aug 2025 00:34:54 -0700 (PDT)
Received: from localhost.localdomain ([103.88.46.62])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b49cb8afb7bsm13182613a12.16.2025.08.28.00.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 00:34:53 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"Naveen N . Rao" <naveen@kernel.org>,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [PATCH 13/17] mm/ksw: add stack overflow test
Date: Thu, 28 Aug 2025 15:32:46 +0800
Message-ID: <20250828073311.1116593-14-wangjinchao600@gmail.com>
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

Extend the test module with a new test case (test1) that intentionally
overflows a local u64 buffer to corrupt the stack canary.  This helps
validate KStackWatch's detection of stack corruption under overflow
conditions.

The proc interface is updated to document the new test:

 - test1: stack canary overflow test

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/kstackwatch/kstackwatch_test.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/mm/kstackwatch/kstackwatch_test.c b/mm/kstackwatch/kstackwatch_test.c
index bba2ab8530ed..138163472b03 100644
--- a/mm/kstackwatch/kstackwatch_test.c
+++ b/mm/kstackwatch/kstackwatch_test.c
@@ -42,6 +42,27 @@ static void canary_test_write(void)
 	pr_info("KSW: test: canary write test completed\n");
 }
 
+/*
+ * Test Case 1: Stack Overflow (Canary Test)
+ * This function uses a u64 buffer 64-bit write
+ * to corrupt the stack canary with a single operation
+ */
+static void canary_test_overflow(void)
+{
+	u64 buffer[BUFFER_SIZE];
+
+	pr_info("KSW: test: starting %s with u64 write\n", __func__);
+	pr_info("KSW: test: buffer 0x%px\n", buffer);
+
+	/* intentionally overflow the u64 buffer. */
+	buffer[BUFFER_SIZE] = 0xdeadbeefdeadbeef;
+
+	/* make sure the compiler do not drop assign action */
+	barrier_data(buffer);
+
+	pr_info("KSW: test: canary overflow test completed\n");
+}
+
 static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			       size_t count, loff_t *pos)
 {
@@ -65,7 +86,10 @@ static ssize_t test_proc_write(struct file *file, const char __user *buffer,
 			pr_info("KSW: test: triggering canary write test\n");
 			canary_test_write();
 			break;
-
+		case 1:
+			pr_info("KSW: test: triggering canary overflow test\n");
+			canary_test_overflow();
+			break;
 		default:
 			pr_err("KSW: test: Unknown test number %d\n", test_num);
 			return -EINVAL;
@@ -85,7 +109,8 @@ static ssize_t test_proc_read(struct file *file, char __user *buffer,
 		"KStackWatch Simplified Test Module\n"
 		"==================================\n"
 		"Usage:\n"
-		"  echo 'test0' > /proc/kstackwatch_test  - canary write test\n";
+		"  echo 'test0' > /proc/kstackwatch_test  - Canary write test\n"
+		"  echo 'test1' > /proc/kstackwatch_test  - Canary overflow test\n";
 
 	return simple_read_from_buffer(buffer, count, pos, usage,
 				       strlen(usage));
-- 
2.43.0

