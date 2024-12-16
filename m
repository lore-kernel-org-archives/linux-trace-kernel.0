Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9722D1531C2;
	Mon, 16 Dec 2024 16:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367791; cv=none; b=COhoCjlu76Mfi1VjGBND9Ki/q5TUSme1tMyga+Dvs2gCFqC0eQaT7lsocOkK8C4KANbu9flzY0nht7SN+XOg6Gqw8Nk2j7uXN/z6JgxVLZq+KxtyQZA/xwwit3x+XuS2Z2B3uQXaYx2OCNLfXauyTyYT0fsqTOJuPufEAcl0cbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367791; c=relaxed/simple;
	bh=3EPYcFsfLjypf54Xvbd0t0zqln5DOiBJBTi6HRnxTNk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EO8Zoip5Zv7Qrs8UHyfkPjq/F2WSUUMIsSvFQ7RE6qro2KeK6XtChkJC5+WxRu7TdFxvIUJox9lOfUUe1yC0KwaCB8J2O9sXdNwyuW2DaknWRlDQIMch9MzIsqGEHnFCs6q4oKyYw26tt2+8vH4DbjZmOkbf6dTmhttgxu84Gns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uqt289GV; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uqt289GV"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-725ea1e19f0so3712061b3a.3;
        Mon, 16 Dec 2024 08:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734367789; x=1734972589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KMvV1LohsSgXUatvr/vuzMYqHRcvk6vycMGJ16mmjkw=;
        b=Uqt289GVy3mwMRx2R9Huo5LfSTo3Gyhr4Z7hDYGbGTQpXVmSM+33SX5QTIaQMTLvr/
         dxjSncHXvCZB65veKdgrtrOCzyQJ8iIs7BrRYPWtOZdHsLAzMFhWR7EQWMzxVz9NstgQ
         eUE7V+t5TNAJKTWciW9zsQlY9MEErtTgT67e3vK+1/lA/4a8PVkW3F9U59C5P7ccAc7s
         1AlCPhBAk9drIXkExUvoP3WVgdSdSC2EM6CvXeopZf95m6d/ryoA0Ej7cZscqwneFe7j
         VeA1PGPDjorxQgIeYUL2Eqh1AX7qb/qf/Plu3hnQz73VGcfmz/OSOsr8uAZDgQYJ5tps
         tx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367789; x=1734972589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KMvV1LohsSgXUatvr/vuzMYqHRcvk6vycMGJ16mmjkw=;
        b=VI2ln40Y39JjqEn3ltianjqA4GFD6efIY3BHGTgS/VPCaVHd90xQZrxPr0yB5a1Oxt
         iwRgVf7nP4V/IljVM1D5uCAChDY0y0xYd6QoQSWSGPFjjXXARSbFA4/Ab94oGlrRztMA
         00UI9ACBwoUhv1ZjIuhhUNd2F5yi0uevVV91OQ7jxZ1czwmRUMMBZEc8pWGonEpa81Lt
         BEtO6eORsSriF+KmhJYa9Icj22ZR9+tycocJrN5W1Hycyz9bmIyU7tvsYB2CGsdmqluL
         yzeK8Ta5hHa+kpEFD2/AOXvL0V4nhTtdT0SmyB5raIxhNIAnE7YVHR/tCUXyLRAM16ZI
         B3/g==
X-Forwarded-Encrypted: i=1; AJvYcCUWmof+/1VHt6VAl4bcn1BtmS3/uk1S790qGo62YT2A2Wn0lJ57HlTIEUl7CGUoSywsEv/t3SNCMjh8uXA=@vger.kernel.org, AJvYcCVtY9YQ2quymUypJVmzqfDmBgI4Y/M7+PJkyCAyFb073AZbp1f8DC2VJKxaWfynBailwBMl3eXeAJgm33yjTmjnjUzD@vger.kernel.org
X-Gm-Message-State: AOJu0YzsWAlsg8n8puCUn189qI2103rQ12kMc7D4ZRykoD3x5/oCXa7C
	uO8EJh8/2/Y2FnQxjw4LhtuJQH12thC3/BuHPkfqUL4Yk79Gi0XW
X-Gm-Gg: ASbGncvwiHo6tlHJypwmQNItYhazs3mbyiTgY59RutmRqK0AVmu8GFxSAprTA/hYqUZ
	G/noFiq1hDsD4pute0dfi6gRmKq3yzTZkbyaOs+WWmFPS0tVKc1tm53MxWbKTyWC4eddAuKMOcV
	1YNnZwscjOGKUeO1eEcU2tIffEr04CywLGS1LWSYs2ajRwPmk7EtK2eP67cJlPMKZa/DFCbN+ls
	Y8wsbG77LEA8IofekmJHJntQsV4dqMMFZlmoMzWfN2Q4mHTgf9VcqwXHBQt7eNqnnY7LJJizhnw
	/3mqaQ==
X-Google-Smtp-Source: AGHT+IHaSM3rrhM+cbB2ssRdx09a7c6hAAhrZSPqdxV9LbkXPwo8q4r3hiWpyxifCLtms29QOfHMiw==
X-Received: by 2002:a05:6a20:1593:b0:1e1:cba5:8e1b with SMTP id adf61e73a8af0-1e1dfd4c419mr20497028637.18.1734367788652;
        Mon, 16 Dec 2024 08:49:48 -0800 (PST)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-801d5aaf5f7sm4304658a12.24.2024.12.16.08.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 08:49:48 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: david@redhat.com,
	vdonnefort@google.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ring-buffer: fix array bounds checking
Date: Tue, 17 Dec 2024 01:49:30 +0900
Message-ID: <20241216164931.57323-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If there is a case where the variable s is greater than or equal to nr_subbufs
before entering the loop, oob read or use-after-free will occur. This problem
occurs because the variable s is used as an index to dereference the
struct page before the variable value range check. This logic prevents the
wrong address value from being copied to the pages array through the subsequent
range check, but oob read still occurs, so the code needs to be modified.

Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/trace/ring_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 7e257e855dd1..83da74bf7bd6 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6994,9 +6994,9 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
 	unsigned int subbuf_pages, subbuf_order;
-	struct page **pages;
+	struct page **pages, *page;
 	int p = 0, s = 0;
-	int err;
+	int err, off;
 
 	/* Refuse MP_PRIVATE or writable mappings */
 	if (vma->vm_flags & VM_WRITE || vma->vm_flags & VM_EXEC ||
@@ -7055,14 +7055,14 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
-		struct page *page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
-		int off = 0;
-
 		if (WARN_ON_ONCE(s >= nr_subbufs)) {
 			err = -EINVAL;
 			goto out;
 		}
 
+		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		off = 0;
+
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
 				break;
--
