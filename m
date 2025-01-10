Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7AF207E1A;
	Fri, 10 Jan 2025 16:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736526396; cv=none; b=uFNZU+0hn9mkFihLrV4TYOFrqyMpLqYIVgCctp+3T9Cr7SIflxq15BAz4DGrFoqPb8PqC8adZwGzPA9UcR7732zk+4VmwhYUTaKtgzAYr8JYYu1eSic14Dg8DbhU4OllcXqPBpUouoG8t8d/R0hVBccG8qwLj5i21xVtAa+aQtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736526396; c=relaxed/simple;
	bh=XpBp2/0Iuvi7Z2yROnUeT1g5tqYkFkZ3byg5NjdS4DA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRssx1Ml6NX++dPH9JDdfq1HNRaMm0b3ZbEYhn3BU9pT4/FI49ZUN4dkkQXiTBZ1RjPwCk5HK4aOMQk5HzgbcavDnMZD+KIMHHX1Ivi3OXdWJZYZE71b7qB02Gls60sre0UuQbkP6sfNqDMOUWxlOuFk4jHikWGY/SL6z5DsmI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YECD3b5U; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YECD3b5U"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-21649a7bcdcso36965545ad.1;
        Fri, 10 Jan 2025 08:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736526395; x=1737131195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bZOf7ixy3JqjNxFEObWlD6WqsrmDvaYekiBQC1vlej8=;
        b=YECD3b5UAMOoK8nUVezqK/ySNBnJiJei54tdBF0uHkQB9yNkEHJXqKI5KAH2xj+txE
         Upr8iGlRWO7YFazD1J/1fqHdT9hR5r8NYqelfMTMyMkYvQFUYRRkHy0eGI1+zgJbIXJH
         L/MzUVEzjFbKc+3Fwjg67LtNZKxaAK17Eh7krP+ypfI5oAfd7EqWuK/PQ/Qh1FgzTrGb
         4P3PM1gdAiitMwm7kkWvMzzmm2PJTPnEsVtVD4r5ChvHRIcZxVlqf0ayS4cMeQcAJw+n
         cRzIqZnIovEsY442il8IPQlVzc8swE+UachiGLSM+mDRlTq1myr0JwVy6nGuDT1AJarD
         phOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736526395; x=1737131195;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bZOf7ixy3JqjNxFEObWlD6WqsrmDvaYekiBQC1vlej8=;
        b=Tf2kbzP2phh66Ypa1exfGqViZBgxPBn/TSGT0N+R4M2w/D5ZFDPKCKYOGB4R3/Q7gH
         sHpV7srwMx6xEPp+Sj+P0wAmaiGkmMz3csi/B/mopZlLjgPDk1Xe1R0dCxoooq/lJTR1
         /7ZK1zibXMjdmjtY4YdRnUx1B9bwADomXt2/wjjaLBPpjKA0z/xHROsIl6j7ge7T7rb0
         8Ib3V9n+wRs6su0BmL/vo55E4/yFS97uQAU8L2oFOxL1LbZwhXsuFvuVMwbo5yxYOUuh
         oPrx41FrfhASfHprARb48GtPFc4hGbA1V6Ac012feVgq/3XHkXpuCH5t6VvE5FbKlSLX
         ocjw==
X-Forwarded-Encrypted: i=1; AJvYcCWApCyvpwFCunIVxLbSzmKxkur56l5IJxXlkvVCIfQgduIFRaop15ZKFJaxyv8MYC9kYcgzXl7gDABL6Nbamrlpy6cY@vger.kernel.org, AJvYcCXRNkaLcDi6jy0L49vai3Y6b9vSMYZEnjKAnymxL6VRgD/tPEQTidJgz4cqri0qYBgYToKOc7G+4ggiP9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhI25hz+W8h8ntF0ooh30mNLZaaEboLz39a8T1i+U1ac7jzjSd
	uvk6InjpmS4krnJTKze0QMmBwLjV2WlXaMym8DsjZIC4wB8WF3ZG
X-Gm-Gg: ASbGnct2asaYDViJIsJbqwlCXRud+9ktPa5SUEzgHF7O5lNzOWxmpgquSYZ1XmBCUzw
	KHvcTZzlcigjv4dhGNOkuWHNyi1GN+ZmLl6fIPSpJQekf2viACKfkHkC15KS+YNQ+I6Hzb58nau
	jMppjgriLs2EmFpldIi3rVdRBLqhisXhfhmzG3RG373oDQi4GS2qM+1bV1cSKmjQOjWy9A04y3d
	i34SHfoVFt0FVCE1pepVdhVU488ttcfTTbahzyFU6f/owunG572np2KnmmAulvqjOYaxPdy7FuT
	HnC15A==
X-Google-Smtp-Source: AGHT+IECmPuuEtIyj7WdP4+P4kUDmWEHmExqcGiA8ON6BT/1JldtSRZwDII9vaFGWkItoYX8PXZyTg==
X-Received: by 2002:a05:6a00:2c8d:b0:72d:3c4d:c1ea with SMTP id d2e1a72fcca58-72d3c4dc254mr5381670b3a.7.1736526394728;
        Fri, 10 Jan 2025 08:26:34 -0800 (PST)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40681bd0sm1721558b3a.150.2025.01.10.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 08:26:34 -0800 (PST)
From: Jeongjun Park <aha310510@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: david@redhat.com,
	vdonnefort@google.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ring-buffer: fix incorrect boundary check order
Date: Sat, 11 Jan 2025 01:26:12 +0900
Message-ID: <20250110162612.13983-1-aha310510@gmail.com>
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

Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 kernel/trace/ring_buffer.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 60210fb5b211..6804ab126802 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7059,7 +7059,7 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
-		struct page *page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		struct page *page;
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs)) {
@@ -7067,6 +7067,8 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			goto out;
 		}
 
+		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
 				break;
--
