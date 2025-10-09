Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0927E25B311
	for <linux-trace-kernel@vger.kernel.org>; Thu,  9 Oct 2025 04:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759985675; cv=none; b=SAXt6JHHOMjB/uOQEqXJPRBcnfUn/lfrVgxKIEB5YT/bBGBkoNLRdDqH3UUlcdct9NNmN+sfgtOPgQjA5Vsv0CyTXwAUcxWgmW3nmoSUUFqyCF//Alf18TEWn+hmw+tTQTnA+NFihr4+JooQWVBM0UUO1WahpB4wpgGKHSA+KKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759985675; c=relaxed/simple;
	bh=w+Kuafgc44tEvaLcNgVbY1Detnyn1TP+rsKy11PWdGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JvkE5UzUfI7Rx8VaIJ2Zx8Q5rHrSJmeYygFwkxmmbgqmvNxqDl7GIfsCRuouSi8hV3z+jLueNFqPvyWRMa9GAMl2yKZHLCqVK7lDz8U5ZF6e54JbszFClgR4Caib1vhHjY33gs6ivLPQGk62q1fu7Eunoevz0sp3pxaeOujoELI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BobXPTxC; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BobXPTxC"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b4ee87cc81eso436041a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 21:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759985673; x=1760590473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0Tfw9ZfkVYbFeFtQQO2RdnGi20hC7pdXgzL0TwKkXK4=;
        b=BobXPTxCYgu9Jp78A4hBylz1ia+ra6VKxVHTQXFYbNZnjwC4uSmqo62zsvGKb60+JY
         dqEiGJNjndK7okyynbvnKYg2sVTQ8i4BGikV4ttrayFCDy34fEAKKKFHx1WAXWdj4pQu
         RC/2N2GTGiovJvM6s47/5oPn3LYkM4S2Lw2RF+O+zWuxix5n1ZlJjZeCJCUbSAJn8JC1
         SafpedmoKncblsu7uVI3TIPPfeolaF5ALVu4ZKB6g1AvhZZAAhp0/NqcJpZ0ECHUNVpC
         EmKXX5dnjK+GN1S92DGUVau4G7QGMrX24Je+wVX06jJxnHzMRDRSymF0sD3ZEwUNj3kx
         gV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759985673; x=1760590473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0Tfw9ZfkVYbFeFtQQO2RdnGi20hC7pdXgzL0TwKkXK4=;
        b=l47cPCxFRZ6yCzGAPGB27fm+MugzgdmzdrX2OS2BDq19lJ7aeHneLh4a4fjLMHwi9R
         Yl4vA1O/LAjoIqJzfyyOZz8FmgB17l+krPiqeKcgHgMAq00unuiYPydSufiu4DJiuwCr
         wbQMnOPezQl6ploEQHXjLnMCHsqSDYmF1o+aiNFYxpNOkP05lH4rL9PXCRtevuDtA8be
         l71TqPBa78Uqe8C+PcJHI7nU6dEr+0iziTwuu7nIr4iajFCfe48XhZ5dm/VfjdGy0QuR
         pIzpju8ca9ZRtQRDzjmITT6igJy2uuZ9+7wfolQ7aPSGhj9ptZUbFkmjlQAeZdDv+fXC
         SK1A==
X-Forwarded-Encrypted: i=1; AJvYcCWcQDhkracHPjZJnn5h1AdH6j5VXY4GZq6/ojuo8PnySoz2vNsQFofh80VWrubl4elHn4BIFIblR47rh0NIAkOIbu8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytMvOh8QPbiEcsOgVXjk19PVf5WrsWB2FoJLgir5ll0ZLdDCV6
	gvBE44FWUNGJo/D9tenmKNSjpeXeh93O3C9OH7A1Jo5ZnuUtRHyxz53jFYlBXtXLCJ4=
X-Gm-Gg: ASbGncsYhgYNlkmRk4d5fAO9lAnMv2Wr4HZKi/L/syQHXG79fNKfOse+cFEXZICdYDI
	pYymoQ6uvmvPb8y5T1SKva+8ZlQAziEGnNr9E/yCrhkCPjZQfBN+KOEDqjsNJcbX4qLTLQHdrrR
	Kep3KZn6YysPfXd0VvzMswE52Sbko/BWw8Zcm2TYfdUJZ3l1WCgEm1WDNjjLpFEd4GWxmfavUxL
	BW94Y7NLLsNyWOdwxWbhOSvkAErHLnLMhDUXaAFndbO/+dQutQ4RrPOqLwpOsQ1FkN9+SZO0i2c
	+YLxVAF5IWjMSlA7cEvyomDd53bAWy/XbXzxK6v5v+tY22DQC8Gu/2tFRhOPvWCBt5iuAYviNvq
	TpQeUOcybdcsGbEraAUH7hXq89FTAsnfD1VnODc202t30WNn2sRPJ6BnA31PWKI1icg==
X-Google-Smtp-Source: AGHT+IHs5oQxzgPYgvjhGgUXIMHAfemFYJF0eBPmSz+QPLzUbxC4cmQvyXqohxlvHOS0JXDY4GoQVg==
X-Received: by 2002:a17:903:2d0:b0:265:604c:17e7 with SMTP id d9443c01a7336-2902741f0b1mr68383795ad.60.1759985673202;
        Wed, 08 Oct 2025 21:54:33 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f36cb1sm14161475ad.100.2025.10.08.21.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 21:54:32 -0700 (PDT)
From: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>,
	syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Subject: [PATCH v3] ring buffer: Propagate __rb_map_vma return value to caller
Date: Thu,  9 Oct 2025 10:23:45 +0530
Message-ID: <20251009045345.8954-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from __rb_map_vma(), which rejects writable or
executable mappings (VM_WRITE, VM_EXEC, or !VM_MAYSHARE), was being
ignored.  As a result the caller of `__rb_map_vma` always returned 0 even when the
mapping had actually failed, allowing it to proceed with an invalid VMA.

Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=194151be8eaebd826005329b2e123aecae714bdb
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---

Changes in v3: https://lore.kernel.org/linux-trace-kernel/20251008172516.20697-1-ankitkhushwaha.linux@gmail.com/
* Same as v2:)

Changes in v2: https://lore.kernel.org/linux-trace-kernel/20251007171256.20884-1-ankitkhushwaha.linux@gmail.com/
* applied minor cleanup suggested by Steve in v1

---
 kernel/trace/ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43460949ad3f..1244d2c5c384 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7273,7 +7273,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		atomic_dec(&cpu_buffer->resize_disabled);
 	}
 
-	return 0;
+	return err;
 }
 
 int ring_buffer_unmap(struct trace_buffer *buffer, int cpu)
-- 
2.51.0

