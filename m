Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B3E30D41F
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782410530; cv=none; b=NkzNOnH3quhzp7ouuLOayTIlPCT9TsxOCFVK/utrf0kS942Z2/Gt46mzdZVIKrwXiJ1SNRhN0Np+/OnG9WVHS6FfSaDma7bJS4Xyskkvs3ClYoi1LX5XDtGzDgIeha2og0M9hZu5H698Xrrbhj45y5+XRF4t+My0xRXndTOlTaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782410530; c=relaxed/simple;
	bh=AwfADB71gtX5OxxtbKioKMZhZz+x2T/CDlQMHNmN75w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JUbFpVUc1Wpqd1RHntHPLuS3Zj6lExgG/0Uepg+M9wm0jOOafh4urw0NmNeFt3X75ZhgPBgun85QYjzHPEHe3a+zUHo7x1evkWhEVHQQVq0Dxs21/CYMZZuDl/T1GtWeB/mj7Lij8Aa7n7kzW7RUOz2iGMbNZdlFWh8NKN014M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UujjQC+d; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UujjQC+d"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-464192ab2e1so29967f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Jun 2026 11:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782410526; x=1783015326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iy1R4WQwhE6n66P48kYKV+Z4fPY/RPEMTv/PHWH3DUc=;
        b=UujjQC+dVVcLWdT6443TjHND8FA6tfKWMXtRpVakfUHjeIBzApSRAV5wNF0/ZbmJuR
         waQ62L7pF/NubVS3fX/0uNXHPgxorntkpsbgKNZCh+Vm2l08VDk5/TGPl8W6yC21BsvQ
         gS3e5RcBBSRKsegsUEdDeS3eDhlDENyoq2Aen5SP46HgI846u2oLSb+Zit1+her4VNbO
         VGqRY6fNRwrXopoVTMeKLA9BcIoomnqhfs0myqBMqv3XPxvBvZM2eG72sJyfV55cwrWw
         QYc8oR/sMFU9Lk4euzOXMivZYrrPEx1PxCSdjrstdRi9Lpax2uMmMXyNIDlP3siwCN6i
         hSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782410526; x=1783015326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iy1R4WQwhE6n66P48kYKV+Z4fPY/RPEMTv/PHWH3DUc=;
        b=R30Wd0g3Y4khwNGQVJgCI0lJXllNUYcEcDP6IKlZ9JDE3wDHUoHU4GOZZeh8ovGqV7
         WbixCgUVO1WEB0oHpQLfV1EO80t3TpnvzjwNaJQ5WRw1cwM1A/A8WQAgAkg2Um87wgoJ
         aW57XAbZdaN2O4dpyePeytWmIV/I8LQdSwYhgfYIstpqSBJT82zEDv4d8hPUk1GCwugU
         ebpwx5Wa1TYxYhPxbiKEZ3BVM0NlndL3DzztXtEeMTiK7mRgWRtUxrPE24/gSDAxeFDy
         Eqgn6Zi7k++s/ExVar7k39G5vp7cwzdAEFCC6qYzwdaHFtmP42yhDg8swGBtvwNDAwsR
         P1+g==
X-Forwarded-Encrypted: i=1; AHgh+RqdMEpDKhXtRZlGpq3OzIfZ144UC5ueuxCJxDsC7h5If1VXToQwJinDakkCKKTkIrsMmysj7LNZvQ2T9fkc9fpj5To=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4ZiXaGQPIZgo+2y8np1Xo4PCMMtdAy3JWEq7f7qhSZ/l5Rm6l
	0PXoCdaeVvYoE3Pms3HsDifOsYddNV/YyZK793k6vRBsdKYIAHgOH6k=
X-Gm-Gg: AfdE7cllwL1RnTczjBXQAdDs5xJ+hopfVySSGFLhkQAC+cNomkJruk5OmiAMr6QRGZJ
	y50PHr9njDtHk57d930+tH20ltNEiGgvoIAGPjfd5LBZcs0ffpqrNneAnhq/P8pbjteps24oEfO
	qo+NhdPH1otQ9Z4O7tMDgVjGNJPankCfSTO5Db+291eqDev5NGMMcNt9bb1UsxFd6Q1acEKqX0g
	CeucVqt0sU1PoBwLC9dOxI0dZWAIbCX9qRK3ty73hcxzvYRNp45R0luTvsD8KZHc04g+l9Wh/tc
	gxaneN3YeFIVHWCTH6GGnqOq6/N7m6A1ldVCH3IGRX42rOZ4cqHlgtLF2OigItWqoKqBZQAh2xA
	rW+lrWVyxdROkS2j3brHYoz7OYu4HjxyWF0vFa7otvvuuHFYPb9YpZDyGqddJhpkTHlB2
X-Received: by 2002:a05:6000:4b15:b0:461:e43d:7d98 with SMTP id ffacd0b85a97d-46dc1f7a1c5mr5570318f8f.43.1782410525621;
        Thu, 25 Jun 2026 11:02:05 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c2279b85csm16743544f8f.28.2026.06.25.11.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 11:02:04 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] tracing/user_events: Use kfree_rcu for enabler cleanup
Date: Thu, 25 Jun 2026 18:02:03 +0000
Message-ID: <20260625180203.3343545-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

user_event_enabler_destroy() removes the enabler from an RCU-protected
list via list_del_rcu() and then immediately frees it with kfree(). This
can result in a concurrent reader in user_event_enabler_dup() accessing
stale memory during fork, since the enabler list is traversed under
rcu_read_lock().

The ENABLE_VAL_FREEING_BIT check in user_event_enabler_dup() is not
sufficient to prevent this, as the enabler can be freed between the bit
test and the subsequent pointer dereference.

Use kfree_rcu() to defer the free until after all RCU read-side critical
sections complete.

Fixes: 7235759084a4 ("tracing/user_events: Use remote writes for event enablement")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 kernel/trace/trace_events_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index c4ba484f7b38b..72bcb429eb4f3 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -109,6 +109,7 @@ struct user_event_enabler {
 
 	/* Track enable bit, flags, etc. Aligned for bitops. */
 	unsigned long		values;
+	struct rcu_head		rcu;
 };
 
 /* Bits 0-5 are for the bit to update upon enable/disable (0-63 allowed) */
@@ -404,7 +405,7 @@ static void user_event_enabler_destroy(struct user_event_enabler *enabler,
 	/* No longer tracking the event via the enabler */
 	user_event_put(enabler->event, locked);
 
-	kfree(enabler);
+	kfree_rcu(enabler, rcu);
 }
 
 static int user_event_mm_fault_in(struct user_event_mm *mm, unsigned long uaddr,
-- 
2.47.3

