Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BC430C619
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 05:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787377602; cv=none; b=RrzV+tycNWaJOyXaCOxY9sz+UMYbzxqekBoGZ4Cftnyk8mb7gjWLfh+mMCQa8Q3CzlvWRxUJlzLPymTir/wAM5tGmFLA/n63mdTgYsVBPoo1HVNYPDLCveHpiX1zx7aeJInyziMfIx7UEDF5qS5NhLGbRjYiWcvxZVVSVq4zmUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787377602; c=relaxed/simple;
	bh=rsxYMIIl9lejcQNSt8h8g+hgwmROpp3hO3YGy6eR2+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pLdmzr260tu2lebDautodb4367mfrjJr/6vFnYQ9PK/nyRUKgqIqBs30JkY56QJdPWYjBDnayr5LHC177hPJLL8dRfAqc7nRQR44NfPcEgfOLXYXlOeo3fZjlFL9h/FVPOL8kUwbO/pvX35Ey+khBBjZZdI1TZqVzCavXCUiNZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdFWYa/R; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdFWYa/R"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cbedf318752so1374459a12.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Aug 2026 22:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787377600; x=1787982400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VwddFd+9ThQQoTgktfYP5DV/IA+A8c1RRw87x6cYdlE=;
        b=AdFWYa/RY3QUUQTgG7Z+DAklc9Wtv++4qwWWyjOr5JqgYJJedJ9/FqOIOBFaiOUsM4
         W3awfsah9b3iB4UZlj4LvURRi90JGOcwPXb1m8MGcKEb5xuM9G/0IVwwP+dlAbJhfHh4
         2Ns/X1ASsQk75k4TjCkQbJNKsZDJA0O30YhLioBpQZwC165XtZs4IYIzBRyDWIL6qJ+V
         LgykSgPHrHO1xFma2z37yisZXvLdN/GSZmcSQVpxDNq8YBT8IER7vqd2oZL0GG0pSMIm
         /1R+xloq3VvIqHc1C5uoh6OOVpdHTyYNRR3bLTIBMvcJUlpqKw6O8z+UtxK5NgQwCf/u
         rpww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787377600; x=1787982400;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VwddFd+9ThQQoTgktfYP5DV/IA+A8c1RRw87x6cYdlE=;
        b=lQIGJf3zTtz3DbVgMXvf8xYzbuYXSZ+NFAedVD25uki5iv0Bx437IBGOVnGpOmzFjj
         lKBCpezNhBbNyvLFbq9b72EEnxWleUP1P389U0KxeAFLDIDLkXcZ5DbY+PAvQHudEnxe
         kDbiT8XPaoJFecZEjRYmVbxYELjp3Bt9uCFAMtyVHaIfl/B7tpQAyH1+4SJH/7vM/dZ1
         UmPyTUI6QKMPJE01eOcePUO1z8BbuE2qxexScJVnAi5NgFqRXG0AnQ7TbveTSZvCKx5q
         HhcR7oXwFIbK1eEXd5I8NN6virspYZH4uI6vKZsmTZVRhCSeQ8PiwcZC5I0ffE+NfKYp
         PBFA==
X-Forwarded-Encrypted: i=1; AHgh+RpFGU6vHADfGfoqKh8vHW4mhVUgAXPb3ZQeqO/JXTu5HSz/h/M02gxehVShroMNYangV3Dp6cYxo0bV+aZio1RCD/0=@vger.kernel.org
X-Gm-Message-State: AFuF++lB53/s+6JTsxpehiEvv9i8A5OeQPHtucRSfrpnDme7ozd5G6fs
	aH4N4yE1MVZWOKFAYj0N7UJ3ncqGxwhf6SEFPr/HG54dQ0OGkDiS/KWi
X-Gm-Gg: AR+sD10ce5fGlDVY1MXx8knJOGK50RSI5n+q9ZH1s7FnercAI/CU6tKUhE0PNf7+GQz
	p4qBHbIsv00SZHiIhUn27iZ6p3ryIj+sXTcgshhNrsP8ii+O4ECJzzSZwPI+LqEq2U3slXE5dQV
	4286/m9HhyhGN/S2Sx63zpbczMaQlDEUzJTN5YszMgtUUBmSJYupnZweDZVhUC/0GnDkqnipdU3
	L3GcJ6pTi1HKCGnuQEqMTW6Ka16N7t0BHDGvsWiADnOpWAfrx8KsfQbftn6UMi8SFpQnvBHYDMa
	FKFe98UGKJkUlPQf0iJz3oZE+icG0LqNTfdEV/MWWCvL7kqdWGatxC+mHam4pHUX+N6AwIFyEQ+
	5BzTpacLXSFKLZ1n2wREPveDyJXn4mbJ6uPrT8Ol60Hp0+4ERhE5A/OJQo+XF82yaQXXfeZwfre
	nQtOhLrkpr70FGUhrr8g36tEBkXPM4TSVTm0Li1L8RKqWh/sCGLwoXpJvwHeCOiuYsFNalFZrev
	m3kayg5V9sIAcM=
X-Received: by 2002:a17:90b:2c87:b0:392:7f74:58c9 with SMTP id 98e67ed59e1d1-395c3a43766mr23532416a91.15.1787377600292;
        Fri, 21 Aug 2026 22:46:40 -0700 (PDT)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([117.172.231.249])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183f31sm3444592c88.13.2026.08.21.22.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 22:46:39 -0700 (PDT)
From: Keke Ming <ming.jvle@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Keke Ming <ming.jvle@gmail.com>
Subject: [PATCH] uprobes: Free utask on dup_return_instance() failure
Date: Sat, 22 Aug 2026 13:46:20 +0800
Message-ID: <20260822054620.452262-1-ming.jvle@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dup_utask() installs the new uprobe_task in t->utask before copying
return_instances. If dup_return_instance() fails, the partially copied
utask is left attached to the child task.

Free the partially copied utask before returning -ENOMEM.

Signed-off-by: Keke Ming <ming.jvle@gmail.com>
---
 kernel/events/uprobes.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index b25531331902..0c8a664a0fe5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -2140,8 +2140,10 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
 	p = &n_utask->return_instances;
 	for (o = o_utask->return_instances; o; o = o->next) {
 		n = dup_return_instance(o);
-		if (!n)
+		if (!n) {
+			uprobe_free_utask(t);
 			return -ENOMEM;
+		}
 
 		/* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
 		uprobe = hprobe_expire(&o->hprobe, true);
-- 
2.43.0

