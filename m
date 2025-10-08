Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838C20E030
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Oct 2025 17:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759944332; cv=none; b=I/fNk777xJmjOTc4tlgyJIZpnrkBcg7DQm4t1fETBnC9Sd7Ws+T8R9SU/SRoCiEejxAtHeFm37YkJS0lOqiK2KK90Jb4T2sYvK69ik71yFs1bVkHxodPQQxFYDXU1seS9H9t5tSssfa+bzOP/SmVLHPcR7uRT3//0HKK5j0O00I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759944332; c=relaxed/simple;
	bh=OBWc87pQeSBPnNP9Y6+pBUc5uvdElUQm6oastV3iVD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e/ufQR1Od/bN2lS5HLYSfcM8NySC/lkQoeQiiJkROmd3Qkqo2pmH6lj7ZNpivJwJgei1pNM6IhG72BHYA2B+FCI4PzuACd8AjCZMSDBmUQ0IGOw9tGJtlZDk6v86YLouL7miq7SbfoaCGlHaDi/LcfXtbxdns6sLCZTvSkeXfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zh8LER0V; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zh8LER0V"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-27eec33b737so865775ad.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Oct 2025 10:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759944330; x=1760549130; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=41XZ0Nc+5i1FOapXe9kYQ/jcLvjFNXLmKvQlP4jYRDA=;
        b=Zh8LER0VL2pk8CLUHU2JW5CnoxitNYIcMW0HDv57m5JYMvQQTw8G5vyUTwUmjk3Uft
         eEZFz5rJ1fetqeBNG+WG5dreH10Kfl+KALeRjIicQsNF+nFanmcUSeMgjQEeBgqCMwhp
         3tG5fU6VZhaz6WovP3N355qDqv0BsElmJI363l1tXc2JYsBQARuxUOW7+kXBGezaj2NP
         hNfecoBeeINfSTzT8r4hhjAlx6QPaFhBOUhJ7GimwSdUa6yDCCD+PGpIzSup0nJ3wsnv
         oZ2aQEJZMEPMQExuPVaeIxmOPB5dSlmfEBMOV+AB7EQ4PCv3U3kNHJjXNbJY76ZD+4AV
         ZWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759944330; x=1760549130;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=41XZ0Nc+5i1FOapXe9kYQ/jcLvjFNXLmKvQlP4jYRDA=;
        b=CUpvXomW+2mquu34tD3gtdCkCVjsh5BX2l0dEJxOrddk1ryhaBOS4jhU0oU9eJ45+a
         2WxSzh08Nu7PaRZwrB93DqInUMmVNMB9N47OSrxjBPhU/L7XoC7OXuvtNowDtaQ0wFyQ
         Oy76+PN07tz/6Y4NGcwXQntH5GdNo0KCy7apq9XUg/+Qm3WKlm0AOMtExVBPTBjuPacr
         jZMYcsrH/+zJB760JbgjYfroX7zsV75+A/bd5fGuAJvZxCvh/38nJyHcc8UxhNX9A0vO
         EEjhPOPtIXZeIgZ75mEbYtKeUMkDZsDT0Cbfp77GNFisiL276OFD1HFcLKEfm7Xx0O56
         HaJw==
X-Forwarded-Encrypted: i=1; AJvYcCV3jOBbapues4FLPKf2fZp2bpsqFjvQgCFtgf04yS+EtHtjyTQ7xFvinn7vSFJ9n1Vbgogdd0guR1z5FL10ALDbFPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyQR6/OKiro5rrwqCn5bYZWi0BOEi+Ru9eFgbQUr2VF5gwRNAY
	cmM/JCOXRK+VS5bpvjmoEbUpO71yVW4kNsiq29FiI4IDUR48mYHeVhkU
X-Gm-Gg: ASbGncvZcIyWp+D9CNOP9/re8ud9z12/gLfcXksRbHcKL+mNxwWztNBLs/eEn47vs74
	Rs6asKRJfa53RxAQT6BLFzwSlpPlSm25jqONTejOQrCIUfv81xHiW3YQ5nHLZChkqt4xMj3dG0e
	LusRLVLu8khCRk1rK69IEFsKHq8U2hVtxN+vWKhcRD22kFf421C7bqTVaS/YbDVBiTuA+NXVd6F
	m5EHyhmgVYtW+UzLjp7Mb8CiGFZ38i/xtm7Ls/NTe8KG52wjVa7GJeSKF3sAeJClNNk8AcDAnv4
	itbBrOYnJ/rMOOrvdrE57xBFEyQoIj0HNNkzwR8E8P2OYjM6EphWt1R41KQG4o0n2WP5w74FqiI
	XSZvDnJ4nlCNGPUa7avPk/mlaXZu1QS6JSFk7XhxElHVU97CAXkAF+VFcmEc8nZUIuA==
X-Google-Smtp-Source: AGHT+IElTiSwjjSnRQ2YldSSmOA7Pun5HHGSGRiphAnOm/twua0zyVb25UTGjox4glkPR20eg3ChWw==
X-Received: by 2002:a17:903:3c30:b0:270:ea84:324a with SMTP id d9443c01a7336-290272c1898mr58357555ad.38.1759944330387;
        Wed, 08 Oct 2025 10:25:30 -0700 (PDT)
Received: from fedora ([103.120.31.122])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm3039115ad.48.2025.10.08.10.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 10:25:30 -0700 (PDT)
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
Subject: [PATCH v2] ring buffer: Propagate __rb_map_vma return value to caller
Date: Wed,  8 Oct 2025 22:55:16 +0530
Message-ID: <20251008172516.20697-1-ankitkhushwaha.linux@gmail.com>
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

Changes in v2:
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

