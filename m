Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A042E190462
	for <linux-trace-kernel@vger.kernel.org>; Fri, 16 Oct 2026 03:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792121230; cv=none; b=TPUEdgBLxtSU0MDYpntDh9ExL/7TAJHkeb5bPaMuWn7RtblYdwRn9LTWiPODSw2tCu+wlzAVmBcHlLpS7aywSmyT66aGKN3QM1muWZnm9k7of43FfawDKdudlkvQ12nugsa5yk8lHyk8AW8A3ujQrZca5/lhWfskzZv1P4BBv2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792121230; c=relaxed/simple;
	bh=/VlbzGT1I3JhT4kb0vmmrNMzk6JfXiX50KYaXup3DEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=svo5/pncW36DXRAGwiCLzza0sTpOvd0+CDbxU2EMW5U/DJN2MOO4EbZOVLkp95j3U6dKC40GAORf6QipueqR2Rf43p49P0cKZT6V7oHd6+IBRY+4vP/RwChStDqiC4UlGxrd7prCuJPyjfoysoS8A86CV3YGDQ6ebwXVKuQcS4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aOEZI/6u; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aOEZI/6u"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cd5cd8d89a7so2394089a12.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 20:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792121228; x=1792726028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y837x6zsLDY7Lr6OWbl3JVY9ardcrHQBqEd20U8eVmY=;
        b=aOEZI/6uYuEBzCmL/qo3vZLbAd2DvnZRQ6K1uPz77J4R6gxeHkqNC45Z2nhAamMAul
         CTKwc0IdckT4floa+zCesYjin2tKEFeiQZIIkyMuRGCCY/pZQYfhMyUxKBGRU2jal3/K
         A1V1S6NjwHP/kfkADahCdnzCYdnQHyB39frqhbLeE7j0exzONjoy/wiyiA+jf1Y8fJvo
         0f4eSbEttlV3wzTjYNrfhZTM58nzFmFIm9Q5KIHpxyTtKn8uQkCh7VBuaZ3jeIreTGWI
         rNc9T8IpOZAX8Uj84qRr0TEuDmEdY8dqAuhOPsFOkHNAZZYOFFL5BaiH2mV4JLqBh+Up
         mXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792121228; x=1792726028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y837x6zsLDY7Lr6OWbl3JVY9ardcrHQBqEd20U8eVmY=;
        b=YoA0Y6aP7qE06e34j0sRWVgKYKgOkb2V4OAI/4a2TJlAgk/RTDDflIBlkKj2U5ozmI
         Q8KA9WvvrEXKqOtR7bAonIn6jZ3wGngG05JGRR/RDTt2mA6zRyq2Ns1xG+fibeDozJv3
         yaztVL5/0hmZT5fiv6Iyh4fiBgQ/cs5mmqpXKtUOp0o8x99gmidXfFDKPQo9LVRcQ0AH
         qPbsx/3VCpShnJsbODiC+zfqmGM1bqUME+oA0CgGtpP9YDSv3S/KWyisbq/ESp6jEydk
         s1h6S+5qrShBwBqWwB/J2lflD500VNuRjm3u4xCMclAJ7qJ+vaI53B4+sdgpmmOCIc97
         K4RQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYdNjz6kCVFIYhRvoqnYsprfKMoixx2E0dPJs3x4ZQX04ubvkuJVXs2CRv6cS8yhK7kvK6MUDtLd/71stl2TXiO34=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6yC+QCqmU7fkqGNOOt1nE+yfDeY1YEu93EnX7FR3ESi+SHAFY
	7n1CguCqNzwnBMM287Qj8tK7XjpeY1Gy/aLO1ni2kl12RkOLJdHP/TB+
X-Gm-Gg: AYBFou1wGkjJdg9a/ucLEyprORxQIOCeIJH4De6Lxw00cPS1Xz2YO2hvxY7QXk9GHaC
	5zc2M4Hj89ir4GcCZp5a2RbQ8l+Q500lijPJBeLeUbnzV6jcGmV99a0ySihTe8ZEYAju63+/H0Q
	i1JFcXwZqQjRBlkNrtRqx9HfYmk3aEmhIQgtyS6phYnXXA1xwMPTqjdUT//AwpJKSVhCVZrgkHe
	TZEnzg5tammXSlsH7ZQ2gk2jNerf0BL7gdUAOrVhvIxZ15oJc6eIpvPoKJsv9hRyLBoijcutU7K
	VbYiTageSiPrKtsgJwFCbd93B4G7HsMdk3Z/XlC/x0WXl7DHUE23mFcdrDAbhv2QMwkFd+SjI9A
	H5xYUWRG14/c7wQVCMFdaWZ8+JzhUbtM8O+MTbrbSPwazhbuKSJF1zLpZrEQE9x6A7LfjuwQPC+
	W9eyPR9X/o9jSHC6Y4koS0DpbTh6ZSmMOVOL/Cjf1I1wJozPUo31hq7CM5J36srOP6gIXQX8/No
	MwDiCWJ
X-Received: by 2002:a17:90a:d2ce:b0:3ac:9925:72ae with SMTP id 98e67ed59e1d1-3ac99259edbmr4024010a91.31.1792121227907;
        Thu, 15 Oct 2026 20:27:07 -0700 (PDT)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acd3f3ce5asm305110a91.3.2026.10.15.20.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:27:07 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Check for dynamic_events before clearing
Date: Fri, 16 Oct 2026 12:26:32 +0900
Message-ID: <20261016032655.82009-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Trace instances do not have a dynamic_events file, but
clear_dynamic_events() is called during initialization. Check for the
file to avoid a "No such file or directory" error.

Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
 tools/testing/selftests/ftrace/test.d/functions | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index 826141e299e5..4f2abb05e365 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -84,6 +84,8 @@ clear_synthetic_events() { # reset all current synthetic events
 }
 
 clear_dynamic_events() { # reset all current dynamic events
+    [ -f dynamic_events ] || return 0
+
     again=1
     stop=1
     # loop mulitple times as some events require other to be removed first
-- 
2.43.0

