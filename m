Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D0A154B1
	for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Feb 2024 23:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707692999; cv=none; b=q+IF9VsjoQzt6+bCR5y0TGD7rYX4GyPrzSvoyxTam7naBEJ4Ah8U/suaBSBVAebvHQ5guYzMmuu1Rklzm0knvbG/y5M51puY5ZfduCScK2fGuJQkqUn/onrtr4FKQN0gBRLpYFJKoVS+y03WTkV9i9O3+3gE+z8QXnAzeKXwA9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707692999; c=relaxed/simple;
	bh=0UHBFd8KsfNzuUb6VByQxElPhKzrj40UEzATEtX2vCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bI62IKtuzk3nN/9LQxaEQjmvHSji5uNIzHEPzLHO3YTgoQ9MkY1EKGLbAUxWrjx3I0SUH9Slkvf3zJB6Je2oK9kJgDY4Bgr5BlmfxR/4nghslXXu6izbTirOeVu98Z3ApufjhFOnlpTvhcmf6M0v2by9uophLqeeuVjcvk6+BqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=M5JSqYeC; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="M5JSqYeC"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-561587ce966so2991347a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:09:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1707692994; x=1708297794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XH/aCjJt/DiB7MsEbqzKT+olkUUu+T5Xb1GlIEopZ2s=;
        b=M5JSqYeCSp8QZJ0B2mc5PfXQd8UPl+0ebY+0u3Y8K2A0g/yx5mmKb5TiyY96kReG60
         rdBafxGQe9jaEMLth/9RIT43xfVjJ3VUAfpxec6sEX7XaN+r+HJv/hodKAmEScigPQmb
         b5HIFSqr9NsYSACyYYq0ZPq3/sDHQSxyW87siIYAIv65M3EnrxP0zVbjtRhiJUmlISWK
         PW9LIMxa4nyxbONBqWD9F6jSJ/spDArZ7X3oJ9txipFILbKmt6sS3dQ7HaZvv6aVRU1J
         N/M4IlywRgLrZEMoxTgcxCNQDardrOj//vbYNC7Qv1EYRsu5dnB+UA1191K5D/ZvI4lL
         zL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707692994; x=1708297794;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XH/aCjJt/DiB7MsEbqzKT+olkUUu+T5Xb1GlIEopZ2s=;
        b=NR9/EzqFU2qq8wTCZ4btyn2y858gTZkNEQwK0heYYxCVndmRRL2rCw5OjwO9D6DGr8
         RmlRX/H9BAl/DsWogrdILf/26ln/tj0P9K91EF/6wLL3nBNWKScwgzCOlhUIns+hU2Nc
         59w/ilckEz4AZI1GGw8LUXhz3JuoXM3kTsvl7Y4vxLSNhJVNYj20ArWfmg+PaSLC0uMC
         5E5S+CMtxEW3R9y54RGj3lwKSdVSmowMXWc7DZxS1PcZ2ya1t4Td4wr9cwzPCeBFE/dh
         IoCNLlp3Hhkwrveu15Egbwb9vAvvbmsl54qpA6kPZJVQCtXpPiYS7SukY5LIZNDQ6lN0
         Vz1Q==
X-Gm-Message-State: AOJu0YxcWC17CoFWVNrUY4TrpSDr0HsmIq+ey8F56D9auDkLX97C4C2O
	AgoSg4+dxZAqeTK1wLZqwTrz+hq6UOb3/xMhYEXSqVp9oz5QnEdJlKmazE7xJVE=
X-Google-Smtp-Source: AGHT+IE/NlI/6DThlF/g6NgjuI7e0164D2rPvpOssgTLNrvG5ONjv7e8Jh03RQj+ex2PdOM1dF87kQ==
X-Received: by 2002:a05:6402:35d2:b0:561:841f:ed03 with SMTP id z18-20020a05640235d200b00561841fed03mr4116845edc.14.1707692993755;
        Sun, 11 Feb 2024 15:09:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU8klcKZ40EjoIvJcSdkTkkctgF4aLklrTh0LA3GCGFlxsHvhu2iaJDoXh8SbFR2ykdO1OHYPmnwHRIRne8/iFWv3Xnx0P+iJDrLWI3UsTxy6mYBkjPS80zr+xF81W5Ft2FoFZePwaIKyF9/s3hpXjyma4TfGT/DY7z4np6u7S1JBY+bE4BqXDohnuaPizfwn/i7uNKjGn/8uPde2l6nDNATh26taFPA6bdDegmDFNeIFxVY2t1k16RyJRZ69GTdUGujLgEM1HxzKEx2YkKBGRrta4cmsvtaw==
Received: from raven.blarg.de (p200300dc6f267100023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f26:7100:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id e8-20020a056402148800b0055ff9299f71sm2183566edv.46.2024.02.11.15.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 15:09:53 -0800 (PST)
From: Max Kellermann <max.kellermann@ionos.com>
To: svens@stackframe.org,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	mcgrof@kernel.org,
	linux-parisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] parisc/kprobes: always include asm-generic/kprobes.h
Date: Mon, 12 Feb 2024 00:09:45 +0100
Message-Id: <20240211230945.297104-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NOKPROBE_SYMBOL macro (and others) were moved to
asm-generic/kprobes.h in 2017 by commit 7d134b2ce639 ("kprobes: move
kprobe declarations to asm-generic/kprobes.h"), and this new header
was included by asm/kprobes.h unconditionally on all architectures.

When kprobe support was added to parisc in 2017 by commit
8858ac8e9e9b1 ("parisc: Implement kprobes"), that header was only
included when CONFIG_KPROBES was enabled.

This can lead to build failures when NOKPROBE_SYMBOL is used, but
CONFIG_KPROBES is disabled.  This mistake however was never actually
noticed because linux/kprobes.h also includes asm-generic/kprobes.h
(though I do not understand why that is, because it also includes
asm/kprobes.h).

To prevent eventual build failures, I suggest to always include
asm-generic/kprobes.h on parisc, just like all the other architectures
do.  This way, including asm/kprobes.h suffices, and nobody (outside
of arch/) ever needs to explicitly include asm-generic/kprobes.h.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 arch/parisc/include/asm/kprobes.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/parisc/include/asm/kprobes.h b/arch/parisc/include/asm/kprobes.h
index 0a175ac87698..0f42f5c8e3b6 100644
--- a/arch/parisc/include/asm/kprobes.h
+++ b/arch/parisc/include/asm/kprobes.h
@@ -10,9 +10,10 @@
 #ifndef _PARISC_KPROBES_H
 #define _PARISC_KPROBES_H
 
+#include <asm-generic/kprobes.h>
+
 #ifdef CONFIG_KPROBES
 
-#include <asm-generic/kprobes.h>
 #include <linux/types.h>
 #include <linux/ptrace.h>
 #include <linux/notifier.h>
-- 
2.39.2

