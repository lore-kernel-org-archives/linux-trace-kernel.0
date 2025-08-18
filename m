Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8B43203B2;
	Mon, 18 Aug 2025 12:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520069; cv=none; b=NiWscz7Yg/PJC5S8Tl3bE7xC/3Qjm5rWs3lxnlGKkg0baaOd5H2Lm/jpl9IDa1/7BZtpZCJJO064dWkX+56rl2D9OWhUdXlu5/bZC9WqlFOi4Pi5D7abqmWMm3NECD4GrzMd5+t8xbsKA1Rf914SQ5XljckaOxEBhm32z2rN2rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520069; c=relaxed/simple;
	bh=JBGYrGMGQb9ZBZC3MFgEIN+nizWSRG4X3GbMSkLOOu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W8oNLu7lCa9aFElggDv8/1ufG6vHa21juS0m5bwKczJ93xoXy2KVY1hcp8NUweZyveswGaHRKGgKEAkEO0WuOTaBVRYHuZPd2YoVq7lBGi+ZlBQLXU0RElmz2ri2Z0/C3hF3wJUGpWi4h+VSwuLLToJc5tqvaiwyUBHYZvttK28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GED38bxB; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GED38bxB"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b47173749dbso2709932a12.1;
        Mon, 18 Aug 2025 05:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520067; x=1756124867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cwneGKQ4sfoe7BKC8gdXxzrgKAJX+5iJGTZjGrJF3aY=;
        b=GED38bxBxNQ+xx3fVz0PutHRu+tw/5cf0XrIzjE7TRFLJirE+zCYr3TZj93aDXnD5r
         3ga+r941dTDA/oXr2eMqUEX3cgL3oxGYBva6sQ8+OGWH8kw66doKQrJ2QbTk6sH+UFJ6
         Bs7z4fA7otvq+ZqyIVVqJzvJ4/pEE5xeb8tRP7UVbkjXT73OQ5aP48RUs7+6gZ2mtJT3
         ePGGU4NJp+49EA7rBdlT/zyQ9+ioCaL9jhmX3KLUaRf/aQtllqO4Q7DuZAhIC751hL+g
         x/yHdVgXvst+y41j8PGV7GqDwmFt85bx/RnszZQnmBc5blJdLn43tF3lyRyJYJgmVi+8
         6vuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520067; x=1756124867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cwneGKQ4sfoe7BKC8gdXxzrgKAJX+5iJGTZjGrJF3aY=;
        b=ZaXlH64vzhPjLuNPSWwe8Oh7pHRi0Yl1ljSdDMrezAcCS4+PhBgujxfGTR4U30D3hN
         d9MC5L8R36FHjxii2dEDWMWZhbZcyztrDWgKcFjvu4dtc8lO5H807r6rQkLhBD1SONbT
         D9D0fmr9dRmHyaEkPfU4N8I/Bq9a+mt3W+ykrnLdD9TyXYFROmH18dbhy/bPOYVCtWH8
         AK2bNuDck9oXtzGPGvHoxq1wTfwkXMzL2yKcbjmAQ7R4jwCKMBWzuEAjrYeZTBUXp2Eg
         Ykq9kl9LqehZ4TwtUyFpzRfuzJyK/3fPfL1XjJs4kthUqoiR6SBVqldNEaiYlqwWuz7Q
         ML2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpXvJFI40HmXP6mNmSvm3Z1IHkgQs3icNBx1yA/3TjUU6vkEYFWfq4nLDpnpz7IsPAg+7OCfogq096wr4N/DN6VIVe@vger.kernel.org, AJvYcCWH/5EvJtHJj9l8M5MKNlb29UE0nG1LPBEGgWlzpsGru6MJN9LCbJIl0q8DY6iMgu/CXyob5cuM+doB+2g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUuadUfJrEADbB8abzP/9ea+d3VsnZnMfF6DapErcrbsrmdCYH
	Kjm+LyRWwRGtGxokJ5JF/cUE8kpGBCiZ2RxmwgwnvX5Gwi3RLYA/AEUgkDgg38Q1Kixu8g==
X-Gm-Gg: ASbGnct8Kq+XikncMMbsh0vcqmIO9Q51OX8KPSOGp8v6P6SOJ/bG3qY4MJDtYSxJaZQ
	lWewqyZHaE5nMTG2E92R47l7PUIRXdiQ7BJ3vGOz1Meb+IpQeMFqGF1b4B2f6lW5g7yt7p0+RfM
	TUvikJpvBESxjP0+Ati/VtTResRADmNQMnwN9nTF9FBadzNeCUHUO5pb0a5uJFdrZINflr3B2ku
	yeIiaGt01p0MZmNnZlVPmja65lKEVCBsBemUd62qOh/CyZn6IagTyPnAwtqXa04By27S/nLIbGX
	F5psz1M8dAUw905Q1VnYhmIxGtn4ZF6Tnq0EjdJupLzsAOdcX7i8pGmKxr9OA2HYOMJ863ofVSF
	q9k8/AFf1ZYg6MX9tIXxwE3MydJFAiYpkfPsok8e9MTpe
X-Google-Smtp-Source: AGHT+IGTAUGEwOZ5QaDSUG+R4n2NIvHL+mwgpzRGpuDYJ00xK6zUpiTVfF5BJr74uTjMSx7tqRF/ug==
X-Received: by 2002:a17:903:2f82:b0:244:6c39:3383 with SMTP id d9443c01a7336-2446d709449mr143591315ad.21.1755520066653;
        Mon, 18 Aug 2025 05:27:46 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:27:46 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 01/13] mm: Add kstackwatch build infrastructure
Date: Mon, 18 Aug 2025 20:26:06 +0800
Message-ID: <20250818122720.434981-2-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-1-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the build system for kstackwatch, a new kernel stack
corruption debugging tool. This patch adds the necessary Kconfig
and Makefile infrastructure to support the kstackwatch subsystem.

kstackwatch uses hardware write breakpoints to detect stack
corruption in real-time, providing precise identification of
the instruction that overwrites stack canaries or local variables.
This is a significant improvement over traditional stack protection
mechanisms that only detect corruption at function exit.

The implementation is placed in mm/kstackwatch/ alongside other
memory debugging tools like KASAN, KFENCE, and KMSAN. The tool
requires STACKPROTECTOR, hardware breakpoint support, and kprobes
functionality to operate.

The modular design splits functionality across:
- kernel.c: Main logic and module lifecycle
- stack.c: Stack canary detection and probing
- watch.c: Hardware breakpoint management

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 mm/Kconfig.debug             | 12 ++++++++++++
 mm/Makefile                  |  1 +
 mm/kstackwatch/Makefile      |  3 +++
 mm/kstackwatch/kernel.c      |  0
 mm/kstackwatch/kstackwatch.h |  0
 mm/kstackwatch/stack.c       |  0
 mm/kstackwatch/watch.c       |  0
 7 files changed, 16 insertions(+)
 create mode 100644 mm/kstackwatch/Makefile
 create mode 100644 mm/kstackwatch/kernel.c
 create mode 100644 mm/kstackwatch/kstackwatch.h
 create mode 100644 mm/kstackwatch/stack.c
 create mode 100644 mm/kstackwatch/watch.c

diff --git a/mm/Kconfig.debug b/mm/Kconfig.debug
index 32b65073d0cc..dd9c1bb7f549 100644
--- a/mm/Kconfig.debug
+++ b/mm/Kconfig.debug
@@ -309,3 +309,15 @@ config PER_VMA_LOCK_STATS
 	  overhead in the page fault path.
 
 	  If in doubt, say N.
+
+
+config KSTACK_WATCH
+	tristate "Kernel Stack Watch"
+	depends on STACKPROTECTOR && HAVE_HW_BREAKPOINT && KPROBES && HAVE_KRETPROBES
+	help
+	  This debugging tool monitors kernel stack usage. When enabled,
+	  it can detect potential stack corruption by watching the remaining
+	  stack space. This provides real-time warnings before a crash occurs,
+	  which is useful for debugging stability issues.
+
+	  If unsure, say N.
diff --git a/mm/Makefile b/mm/Makefile
index ef54aa615d9d..665c9f2bf987 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_PAGE_POISONING) += page_poison.o
 obj-$(CONFIG_KASAN)	+= kasan/
 obj-$(CONFIG_KFENCE) += kfence/
 obj-$(CONFIG_KMSAN)	+= kmsan/
+obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch/
 obj-$(CONFIG_FAILSLAB) += failslab.o
 obj-$(CONFIG_FAIL_PAGE_ALLOC) += fail_page_alloc.o
 obj-$(CONFIG_MEMTEST)		+= memtest.o
diff --git a/mm/kstackwatch/Makefile b/mm/kstackwatch/Makefile
new file mode 100644
index 000000000000..076822eb7661
--- /dev/null
+++ b/mm/kstackwatch/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_KSTACK_WATCH)	+= kstackwatch.o
+
+kstackwatch-y := kernel.o stack.o watch.o
diff --git a/mm/kstackwatch/kernel.c b/mm/kstackwatch/kernel.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/mm/kstackwatch/kstackwatch.h b/mm/kstackwatch/kstackwatch.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/mm/kstackwatch/stack.c b/mm/kstackwatch/stack.c
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/mm/kstackwatch/watch.c b/mm/kstackwatch/watch.c
new file mode 100644
index 000000000000..e69de29bb2d1
-- 
2.43.0

