Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049677;
	b=0/XRdN7MtU1Ms6wjcpPCGUsj6ZALE2ieznKFXU3sYQZ5yfkAF02/kGOjzuqP9hHziOBY
	 CBK4f4Hayaab09P7fstjeqZ9hQYfw6oWUyDUF8CalCKCH7lO9sp+uX00VoBLNUgpBXRd7
	 Q3ytSTUjaBWf2Vcs1v/dczEECB/fe2SVvvfW9doj/fETRM0iWo7vhNnJjzxtPU5qlfL1s
	 sCLkwqpMxzD51ZB+MPvSgOQ4ZfDPYsRdzLjH3C2o3g1a6fCgMz0BTCk83JiiGQDcGi5+v
	 tNmOGgi5wpkmzJZHtzLkcc2onzZ1m9rsc7I8OIzL5H0cBtTrV3hmwqKTqNxIH5V/aOg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049677;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=iazXt1ue45sdT0Gt6vlrMv52pc1Nk4AJvSoapTr3fo8=;
	b=cTKwqAF+XdqxVkGlqTqDFiO3r32fvftrAHYxLPRuw8wFy2KVjXBBzcqLD1prAMUHV1a7
	 Yov2eecxWzGzh336PsjSQ/aFFGqTUJ9B8kHMFze4jiI0NaK2O0+e+4rNYpeMpgbmnBB6A
	 b/w7hvK9m1VL3G5vcyt3tYmQVmspUOPeuSXAn+TdOYgLJLRNn6YabHfC6qbatmwqXiRiq
	 ZMi2+K1Ab0TvRw3V31AN/pHDCfWhVAB3G9CLXlY7pmgbmVmR4nficSDy8amH3k4EKwPLq
	 8tezaApq5DHr3nd++XAVok/D8/LGLaPTQ+ZeazOIYjArpjng7BMNXrE/XcF6zFuzf9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qEZl/bdc";
	arc=none smtp.remote-ip=209.85.216.43
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE86D606A32C
	for <linux-trace-kernel@vger.kernel.org>; Sat,  7 Nov 2026 11:07:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE86D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qEZl/bdc
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so821108a91.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 07 Nov 2026 03:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794049676; x=1794654476; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iazXt1ue45sdT0Gt6vlrMv52pc1Nk4AJvSoapTr3fo8=;
        b=qEZl/bdcxE8GCw8c7ClrZpmQhVEMFSEfQSIy6aqxy4a16P21FtQRRFalHK4OVhH7Nd
         zDFw99hGs3FIMKOHqMK2vYwdX1Nn+sZN9eOAki5cprOkzfHXy/Smnwuigh6dXnMX+bAV
         mv7OAQFjr4yd1PypfnitcKpAx3YiUAcxeSBFG+EKjtfhE8JPIdL4B4NMm/8iaxa4L6C7
         cm3/F3krW/Cxh7KJorkV7jUDeYM1c6oF7ESs1QDrehyQKemwMi2b8mI6YmESxqhGv8bd
         4MpYlpZv0jIQbOcp0VdfHgodPQDdQ0m58kKD+C5KvyhL/+0rvlLmjJ/zUGCd3Fn9jLGm
         fiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794049676; x=1794654476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iazXt1ue45sdT0Gt6vlrMv52pc1Nk4AJvSoapTr3fo8=;
        b=nrESqPt3EMp81PyQeA8FhebLbeXoTShf09Sk+hqd41kkRNhoaNvg8/Iomx/sikrH88
         eowKVpvQVGQgDAI6dIJAQzXSlU88u3VBoYwECu/BUMIt+HGSnBnUC00GVMt6a8ZymZsG
         /4GZmx2Iha8ZGVqLB5edDWofL8bxZ0EUBBMBNWocn2E7D3abved/Q67Ak/eDvq228VKB
         dtpIsTKimGhtKTVvgojC8565COCw81kvRBv9/HyJYHLKn72maNsMKtsaIuMRBSdEuygG
         52+NFS1kz2QWP8CyKqUZOs7S7j12OMMuwAP7OxKH654Xk+cq7oZkHSzCUz4ADvw5Kl91
         aXug==
X-Forwarded-Encrypted: i=1; AL+hErHMy0amRM9y3xiLZzxWd6Y30OYSK+7SFdT9apJW6WrqdgOh7WQrGXMef7V9DVMb+Yhf9xjmxqKTRgyP+5yS9pAiTd8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GWAy4aW7jlCb6duwPu9YEfT8qhalg1WV89Klhicy8Qlf4RL0K
	8zbKdsZJcNUwi57g0QV/b+MG4NNQdlsgHfTTfaQ6dYXlZ3DPVAZrjYG8fpIv7A==
X-Gm-Gg: AYBFou3ud5wEHu6ybu53PHylFlVxsYcKsBumevTewBf0aAIFA4r77Er12QDJpUfstgS
	2FEchOwzUF6RCWFKzi9knAe/hSG6Ae/pKIKLBZjHKG8vox/6HEGnEUAirBKHFWuXZ6AajDGz2rH
	gJnGtoGM6q8LYIsla9uT6W6jyfBzkvp5M9yrV+RomqCiA4T0KsiQJe2zSqq5MY3wsa5Bryc70mV
	7BFRG/bL1AyAKYV9h72LfZHdD7/hUikxb3BLwLQ3UdyHTX5wkPtREP4ImwKH46Sb+7wu8f/EaJ0
	tCt/fjyiStQuRyi/w9KZHYp9FWF09AzyGwq7Rr5RlxtyZY50PH7Gu47Q9L0UEJXHNI2mUlxLUAI
	qghqheO5LylknzFd7zbXgCdeKVMYtTQ5xTQxRBHxIZC/Aa+aftt/I7HXlmIzwi5e5v7NhRGFIWq
	I5pENYbvLhnVaSQ4bQub6vyh7nhUkg626uyR+oN6Jm+XftyWmCF/9iUTu4wAaUb1EZJju+98hWO
	6UeT3jWuJNDr6+lBwzfD/m9e073YMoHLu9HkoSPsT3Jna0mZ9V2hwGRxGE/S1hNCc5ImPKWeqUb
	ux/uxAvr+stOT457Yr8f2XyNb70Ipqg8WVx2Rs1UWO/CV4fIyr8HthllmliZ4cAiPzc9DnE=
X-Received: by 2002:a17:90b:2f4c:b0:3ab:2d17:51c5 with SMTP id 98e67ed59e1d1-3b0db5f176bmr5265142a91.6.1794049676200;
        Sat, 07 Nov 2026 03:07:56 -0800 (PST)
Received: from lipengfei28-ThinkStation-P368.mioffice.cn ([2408:8607:1b00:8:6fb0:6db0:221b:f543])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1057ef145sm2997336a91.6.2026.11.07.03.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 03:07:54 -0800 (PST)
From: Pengfei Li <ljdlns1987@gmail.com>
X-Google-Original-From: Pengfei Li <lipengfei28@xiaomi.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangbo56@xiaomi.com
Subject: [PATCH] tracing: Wait for marker writers when copy_trace_marker is cleared
Date: Sat,  7 Nov 2026 19:07:22 +0800
Message-Id: <20261107110722.1241413-1-lipengfei28@xiaomi.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clearing copy_trace_marker removes the instance from marker_copies
without waiting for trace_marker writers still walking the list. If the
option is set again right away, a writer on that entry can revisit
instances and write the same marker twice.

Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
Assisted-by: LLM
Signed-off-by: Pengfei Li <lipengfei28@xiaomi.com>
---
 kernel/trace/trace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 18710c190c92..b0357f1b5a69 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4016,7 +4016,9 @@ int set_tracer_flag(struct trace_array *tr, u64 mask, int enabled)
 		break;
 
 	case TRACE_ITER(COPY_MARKER):
-		update_marker_trace(tr, enabled);
+		/* Writers of the top level trace_marker may still be on this instance */
+		if (update_marker_trace(tr, enabled) && !enabled)
+			synchronize_rcu();
 		/* update_marker_trace updates the tr->trace_flags */
 		return 0;
 	}

base-commit: 4539944e515183668109bdf4d0c3d7d228383d88
-- 
2.34.1

