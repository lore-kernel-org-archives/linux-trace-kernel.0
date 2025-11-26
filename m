Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF611096F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764196300; cv=none; b=VmbaCKn5MGdNuYWVAX6lBc46doZAlrTjmtFfuZaf5Bby5OBjIhR3VxCR15iQ0XeZWlsiyk3GAvbkOyBKpqfbG6pNWoPsT6o6KTIHY5EAxx53063v2HIPPknWomudNiPWcMtOjd1vSBiAIj/uoyKWw+ywMdXn+z0v+aL1yDG1eBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764196300; c=relaxed/simple;
	bh=27DtBrdVTbGuUr0pGz70YrWAN67qc7AHA2zgTWzyRWc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K5am5Iw1zGkeOTJTn/lmbkeITvrQ2JMO7FNry4XYQwmXu60RCozonDpjbvNVnGBWL/xjI+YR4SvBaV2CJz6VIcvWorz0azChm9w/llwVRXjor3KRCzt/IqbdqWuthNZxn/I+/Igr6DJM3xHvl2+snekbBKiQ+8+zVDDQ9HBDj44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMYUWV/I; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMYUWV/I"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c7869704so256620f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 14:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764196297; x=1764801097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=06gB16fa6KS/zoSWFVr7c45ocEVqzhsuohxeJKfmG+g=;
        b=mMYUWV/IGzHmrwDrpQqfRJxZYuVlh/cKEhNW2hrxJNrgPkEH1oFIr1y1GMNUJzCVGD
         vshGR7ZMyZTyHcK5WQOEIhTLjsYEV6F3a+3atZlIKwMRpFXkWIHs8rrEU8id0CXC1R61
         v5dxFYfA0hNFqFDE7YO7sAfcf1WgxMLpOss4LcpCN/ClzyOraxmmmyaDwEx7I79B3l8K
         937mMbnpicjxtfuUsZ2K0MS9CQAcBhIIlJPvCTjrxvkDOazPPiBKN0zVY9KTU41/89dr
         SCM9CVUHPh4BHQKT9ifXIbvFjia5eabS7XKomcJHEyk85BkPvwNzOWm3tTTKK1uNocwG
         BGuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764196297; x=1764801097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06gB16fa6KS/zoSWFVr7c45ocEVqzhsuohxeJKfmG+g=;
        b=a2EYjYDx0GDaotBWoC19ULR4ca7+noKZFG1L0KLNOt+aX3S0tCNwfexAc+pGyRTWFw
         CyLb223aQ4mJsYdi/B9mrNrQu/lLzp456I6EBYyeLjZxzTECAjByY8+2nfG6qG41JPZS
         d+9sRhjlff3hGaXS4iC16NHq/DXCVawjC6fjmfzgYv6Rl4MUhLme3Ka2vFNbbM1C1ser
         DkLf3d3q4U47j1ogyvr4o8FbCmEJ+97Cz5JKd5BeFMHvmN6UZOP+xqo1KVg3BdVFOH8A
         ou43C9nzHC8a1TmgS0ll/XWSinzEliQd4BLUWoKq9dL8MqVHOgZcd6Elw/a4zHWqqBXm
         tM6w==
X-Forwarded-Encrypted: i=1; AJvYcCUemtX8CAv99cl0kIexO/ho15q+y+zJHmlgsmOfrRQeilG9EsnuNRhAEiLzpwP4O8D5iLcIFJZc+oUvJa+6X6XLGm0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdSG+j4zjqQaEI5mihZ3bSXrkXbceetj5ydaxwZhkKFbaxyupE
	CUlhGSX+L/mYXKsX5iLi33RTi3a1codXrIDTT6rVuPfx0K3DpOAZEu26
X-Gm-Gg: ASbGnctMeYyKlB3UHM1OrIh0WIE8br7pGiLCAV8rP5GPAnLVcsQ4Xdv8Em3bzHFHPPa
	pc5S17Lo8UBfEm0KQVWplL7Hj9cglc9MGSkBDEWnxL/HWxO+2ALdI1EDEvE9cAdAoUfsypiWrHC
	vVEywbbRru8TQGNm5NBZrcZQmaaXp0MAI1MMJ6ylHWy9BPt8SQPZmx6kQWt+OvMKhDuVSqIGVWQ
	0F+VsC/TICwY/2Z5A7i2r/CTx7ENNK2mk5b4MQMQ75Db/I6HTSkNbKMhTDtwzaMPxdunT7m7fmg
	Y4m3WJvBiLW364Mh9XQvdcVB2hs7sdpREVgJAJ03CLC6WQbRDTyq9mwRgZBrk733NUFEA9EI4ga
	8gv0B7/eVW7njIVzcErwhxo3mHtMemOLU7CzJlc8PyJtdg7kBdplShuYWsEeiZCWmZN/mmhm6dN
	L0JN4kZ1rVESBagI0=
X-Google-Smtp-Source: AGHT+IFTq8xGRpCwoprbCeF3K9a3D/FqGda4o3Yl7FBKNxyW3D3EyyqfUlnqh/otuuy2/Zh5V/gmtg==
X-Received: by 2002:a5d:5d08:0:b0:42b:41d3:daf9 with SMTP id ffacd0b85a97d-42e0f1d5993mr9362364f8f.2.1764196296510;
        Wed, 26 Nov 2025 14:31:36 -0800 (PST)
Received: from osama.. ([2c0f:fc89:129:990a:83a3:6137:cef9:6de9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fa3592sm41705453f8f.21.2025.11.26.14.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 14:31:36 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	catalin.marinas@arm.com,
	will@kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] arm64: simplify arch_uprobe_xol_was_trapped return
Date: Thu, 27 Nov 2025 00:31:30 +0200
Message-ID: <20251126223130.216302-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

convert arch_uprobe_xol_was_trapped() from explicit if/return true
return false pattern to direct boolean expression return in
arch/arm64/kernel/probes/uprobes.c

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 arch/arm64/kernel/probes/uprobes.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index 2799bdb2fb82..b38c1dab7eb4 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -103,10 +103,7 @@ bool arch_uprobe_xol_was_trapped(struct task_struct *t)
 	 * insn itself is trapped, then detect the case with the help of
 	 * invalid fault code which is being set in arch_uprobe_pre_xol
 	 */
-	if (t->thread.fault_code != UPROBE_INV_FAULT_CODE)
-		return true;
-
-	return false;
+	return t->thread.fault_code != UPROBE_INV_FAULT_CODE;
 }
 
 bool arch_uprobe_skip_sstep(struct arch_uprobe *auprobe, struct pt_regs *regs)
-- 
2.43.0

