Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4092F658E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758713910; cv=none; b=E4fbLAEHF062NgONlqcM2dWBncMT/Y8Figo+DUrI334Ls4Z0Pdq69FjMNhkWJjcN2Tf/RHKwblVcCJxjJgEkBzjww84VzfxAEm/jFaPrLdKwwAMXAm3EdjzeP33cgp8NYOTG/LejSgZiRLpzLO5EOSQX3RbJXYESMJzfGhILZYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758713910; c=relaxed/simple;
	bh=lJ+QK63UKKDRlNr2QKgzcHWo08FmbTRWgsBmzrgBVrM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Dl6rcGireX4ARCO1IutIQ1R0J+LukNqXLs4xgWaWxgPQEE0zxxemfjkxtx3022FQnyoDzaXCugOhJHBCg4oZ/t8rW/VO0ikoPw0GskML9F+NU/Ft7sNwDPWaFo3m6Ze+Sk36NTVVVgcwYhBLPBc2PFj2y46NB+q272f2heekwAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=b9qqR5hD; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="b9qqR5hD"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-468973c184bso29422525e9.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 24 Sep 2025 04:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758713902; x=1759318702; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCA5QwajlQ59UvvMinwj9VwflaDYvT24c/5GSvnh2pc=;
        b=b9qqR5hDXlkjib3ezccQvRYgrPeorjZn1+QJNLujdcQ9ggO8RGC0L9mqyhd/aqN4ju
         3+vGyc1N/WJvX9Qt93XBQxqs6keq09JG7GQqeLJQXbttMBEdBMfnL7/rqdCzU0637Q0a
         U+x/FYPJnVTusdT/t9fF37XAV41VFPUEzsno910fyzQz4ecqzjXNwMWPH+eoIoNodwSS
         TTSRCDcDLNxTtpf0lID2pdmGp/w1rWrRddU/Cuq2+4N8O32Ic4U8pnmDanK8HxXeqWw9
         zkW1j3aK+WOL612CG+2J6s48+Po+0qlSjHGufGKJ4SNskP0aFPOGvdtfH481LmEADATK
         Mu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758713902; x=1759318702;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCA5QwajlQ59UvvMinwj9VwflaDYvT24c/5GSvnh2pc=;
        b=NpLf1keMsQcATe8qnGe1ky4gWJA3xPnrSkVZp6DXpxYi0sScnhvuq9345pyRwvIfl4
         MjSPKaLfdT6mWN5DYgufO0FKUC03Y8VTxfKVBkhoZWZeYl8FKDlQxTY2DasdG3oDMVxy
         dL4kCSpf7U0XJnRGz/hJ1L5eyCRkq+bYVN1DGfz7/KTGYiLFDxn1YKxxPZRmFI2sj+MB
         Sz60eMCk2HbcSOoJW1qeIIQ+BHAwEuHjP7TMeUu660yXToaGE2WCTr5hOimxR/JeL/bI
         KJH05VuIVt75VStyQRj+/HpFtuEvvJccaAyOd5nIe/IpwhCuofHp9bkZ6+9ZSB8UQ0OD
         Z2jg==
X-Forwarded-Encrypted: i=1; AJvYcCU19AynghAxkyjcOL3UFWQEiIevKDRjcSzPBIznFL5yiDSRDH1yOoCEJoEAqhzLPYYZiHx4982XQzr8K3g5rjbAd0o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/DBoZ9V23K/U9i5DVtsJbvU+0z5gT3w+XiSbwJDbfGNX3K6XM
	qMVA8KsDlKS7a96AIO8Pz9KrVoO4iXb2WJxa1LpF1R3MFDX4j1x2fQkOeWAiLDeldJGZ1WCyL2D
	B3I8U
X-Gm-Gg: ASbGnctxgFRRGFTIXiLKQOoZ4SzcCTnaPCkIUYUp3GjdMN1pyGiSlHG2oN8R147WBZ1
	kClcAfu0DMkY9eTdEvjsUnAaoHfA0b8Z2izXW6wXEBMzlkgDkkfqLVKnyIY5eJ+CE6E2ZlUVJ/C
	iN9TLXbj2ntIZ9h+ENnFW7RQI0fSylU/1a1KOzX6jjT0msq0mJ9XcqQQnG3f3MA0htqP06bgLzh
	GfLlS0OmZDU7UEcDAWqHQSsYlhxjG8BEoGf4kNz5JIhSP+dCz20FT3TVDBjc0F7FzCgveAcVsg+
	EDJ4dMn9Ixuhg1ig9uJM8pLawzjTrAB5f2iVpGhvest+cnS1WHtuW8iDXDZ0CIrAyZ6hhYpzzz4
	uCiVfF8ak4DQfAo04C/cCLg3jU8Hm9qODViv1/IwOCfA=
X-Google-Smtp-Source: AGHT+IFf83Wibzw2MAhJv1PA22Vi+FCDsaK4BLLL7JmG2DYF16kFe+b/FtEEihOebIFxrR58Qf6U+A==
X-Received: by 2002:a05:600c:3ba0:b0:45d:d50d:c0db with SMTP id 5b1f17b1804b1-46e1d988f88mr69789865e9.15.1758713902430;
        Wed, 24 Sep 2025 04:38:22 -0700 (PDT)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e2ab48570sm27592755e9.16.2025.09.24.04.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 04:38:22 -0700 (PDT)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Ensure optimized hashing works
Date: Wed, 24 Sep 2025 13:38:09 +0200
Message-ID: <20250924113810.2433478-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If ever PID_MAX_DEFAULT changes, it must be compatible with tracing
hashmaps assumptions.

Link: https://lore.kernel.org/r/20240409110126.651e94cb@gandalf.local.home/
Signed-off-by: Michal Koutný <mkoutny@suse.com>
---
 kernel/trace/trace_sched_switch.c | 2 ++
 1 file changed, 2 insertions(+)

v1 in https://lore.kernel.org/r/20250923165908.2399256-1-mkoutny@suse.com/
- cohere with code (Steven)

diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
index cb49f7279dc80..9ee62364d98d2 100644
--- a/kernel/trace/trace_sched_switch.c
+++ b/kernel/trace/trace_sched_switch.c
@@ -248,6 +248,8 @@ int trace_save_cmdline(struct task_struct *tsk)
 	if (!tsk->pid)
 		return 1;
 
+	BUILD_BUG_ON(!is_power_of_2(PID_MAX_DEFAULT));
+
 	tpid = tsk->pid & (PID_MAX_DEFAULT - 1);
 
 	/*
-- 
2.51.0

