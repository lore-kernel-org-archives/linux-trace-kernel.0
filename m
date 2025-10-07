Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E72E8B63
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759857221; cv=none; b=ViznrZh3h/HDSxrXc8+zWsenSFpeHHxZ8k1Ujuc6LK56l7wYUDAZvdTt0CxFYc0A7xkHRDhyEmM7+FAWFF6VUgVtc/rjrYkNrdZ6KpO/oJojSDu4suCNDYmvfSV5l+p7ITgIIAeryXWs6vglmz1vf6UL/o90b1Vin54QvAnc6iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759857221; c=relaxed/simple;
	bh=6hkEXSoPQClBN9P+2M59L/xoo11QDhuwy3o/ItrIwug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ys8qeMzFxmeoth8y1R2DbQT0SenitgXmNygbXWPmbn50M8kVyyrrfYVlPyqivx4fIL1ffcQbv+1SINo/HoLlFyGr25LyWCHEE8XYYCM58aLqzDMQlkcQb/AI03Jt0Cg2BrRQgEAP6+b7hviOcS6Y3huLdvGmaDdhZojhTW1PU/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZx9VgAg; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZx9VgAg"
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-330b4739538so6612897a91.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759857219; x=1760462019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ndiW8EiHjsJuqlvrDnKSTbKhst7QkkL0u0UDEfXrL54=;
        b=BZx9VgAg4A2J/75tOqLJHhPNOJVQzQwaPA0t/+lD9GMt+4M+lBGisQpB+KWMsvYNpj
         FK4WmeaPtjlowQeMmCPDgo/F44H0Kt1UtF0BK/6fw+TpXr6GC4EIxd6gBU0U9liFxQjN
         kNoBl562iK46eU8ZD27cS7bF4alhQogjMs1GG7Jl8fz3chSdL4nGeobUmnQkM3IU1KEa
         nKC1PyQeeTa58mmnt/7VZzQcnynIqQyCPLRxu9jqhilYVl8xtHwA+C/1314vufhzW7l8
         ZVO05lvTt5bZeJvi4bv/gD5BvSWMBnD/dT6ZM+u027Y+71sBkOHuv6xv4hev0CIANcUf
         C2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759857219; x=1760462019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ndiW8EiHjsJuqlvrDnKSTbKhst7QkkL0u0UDEfXrL54=;
        b=ZgLQ6VzYniSgmuykwNoTbDXZYeXh9rSYB2CHlGEautHLqrhL398YztbkqfQISysXQZ
         SvxF4UIKF9hC01CQO/Cg8ruvOR1wB2hsdyAHXqAj9L40R/ji+tDz4N2MOzK2ogg+nz+Y
         3DIysaNE1j/xZxVid5Qjam+GlxOyt7GnZCb2RGLMXQWV/uc4D7/lP35Jt6CAMdjjAkw7
         3Z0TXGHQ2zErUXKUYkgm1VHiPZ2fbMPEEpbCPUFHSgODo653xO4FZ3/mfP6GolbUOYTT
         img2OepwhYiS2Ft6vzas4ZmtAebGAO05F7yD2hkF4GLzf8Mqntcmc9/WB+OsbFHbT4r+
         uwbQ==
X-Forwarded-Encrypted: i=1; AJvYcCW97Fo2gGRVctQ5/Vy1mcKWVlzDNl2mjDcKKaEhNVzMJCHK6eIySEomq2eh3lohD76yHw0nAGsqypFEStiwx0ozKPs=@vger.kernel.org
X-Gm-Message-State: AOJu0YydO0C2A1I8glnTasOgocBE+cgcqMBlMH9VaOn80uf8suaMDC6n
	AWVE/wvTtCYSbcG4Tp00ajbdQZXJyfA0GIesD9q4+w6f9NgS7g+koQxY
X-Gm-Gg: ASbGncsucachqPoDmp2NzKHEwBXX4W1NeJCxzGemG7OAfR+ZRB7JZPQBv3JN2F3Lot4
	v9K02nGqBHHXgRPFe/VH2zEHdJGnIPUcOm3bRtta/Wp5XWAxz7v3ZgkAK9qjyz9BjVt+ZOJo70h
	oN1F9KIooNBPCCnDh/+PTWvyk3rnt2EgFM4dXOUDUGxNxmeBgfr0FSrkT68RJ9IHd43klTSxLb0
	ghjRRBm0XL5EagYQ8/oHQd2BR6TgJl0V6mV64g855KsBa7fKORTvVWv2r1JZWbTkSH0BMwfPJsC
	8azHy1SGKihLwXOQovEeRj2rVrNY2lF4sTC692nq1Pq3zzB6O+AWt4BtsagMgpXqDkIjkJfxIkR
	cbO9zzLBeX+Zd+jcEFggqWfVJRDo3tgRRtxNgzBgrPTJjOGpc725xKJ968fhvofPjeQ==
X-Google-Smtp-Source: AGHT+IEw8/ovBuazt3eXRnTgiJXDDXOaNSZGFtByXDec22X8YVk7CtYfnAhylw3oRk25QxNUr2BtOw==
X-Received: by 2002:a17:90b:1d09:b0:32e:a59f:b25d with SMTP id 98e67ed59e1d1-33b513cfadbmr293892a91.30.1759857219077;
        Tue, 07 Oct 2025 10:13:39 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339edf4992dsm1906075a91.0.2025.10.07.10.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 10:13:38 -0700 (PDT)
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
Subject: [PATCH] ring buffer: propagate __rb_map_vma return value to caller
Date: Tue,  7 Oct 2025 22:42:56 +0530
Message-ID: <20251007171256.20884-1-ankitkhushwaha.linux@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The return value from `__rb_map_vma()`, which rejects writable or
executable mappings (VM_WRITE, VM_EXEC, or !VM_MAYSHARE), was being
ignored. As a result the caller of `__rb_map_vma` always returned 0 
even when the mapping had actually failed, allowing it to proceed
with an invalid VMA.

Reported-by: syzbot+ddc001b92c083dbf2b97@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?id=194151be8eaebd826005329b2e123aecae714bdb
Signed-off-by: Ankit Khushwaha <ankitkhushwaha.linux@gmail.com>
---

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 4ff71af020ae

---
 kernel/trace/ring_buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 43460949ad3f..4efb90364f48 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7271,6 +7271,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		cpu_buffer->subbuf_ids = NULL;
 		rb_free_meta_page(cpu_buffer);
 		atomic_dec(&cpu_buffer->resize_disabled);
+		/* VM failed to be mapped */
+		return err;
 	}
 
 	return 0;
-- 
2.51.0

