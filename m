Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150BA433D1
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Feb 2025 02:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740451358; cv=none; b=Y3LKw3uyth0L6/ARK0AK2niKSsXvQfW71e6nrULyeW4w27yjYwmBjPcOdJM30giQA3sF3upAcK7wA56msTmcvkLxreGg2tejppAXhvYlRxqijrmkGgPkbN8L4ehtfmIlMDgQPl7eu+JSD/XrTAJaka2S5EzzBnYgPN4WEDZm5M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740451358; c=relaxed/simple;
	bh=W8bVT3KdKXtHJWTSCayGdVWSdCOptjFaSdECSOxAXbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=glltRPxha1KuUapgs7+nZ0fAMith478Xg5gVIGbN6CzkC2+JP3e78/8oFUEoBk+psymvYTPugmrx3nzrSp98xQDzq6Ra4mdzgaEER2M7daDmN++YdP1P0ihypzkY1383ma7DeD/fRmkXhRwsM5OI9jy/TCMYPGYwVZqzH5OnCR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nBZjsb2p; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nBZjsb2p"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f42992f608so7960435a91.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Feb 2025 18:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1740451355; x=1741056155; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aZanNtGerLw/d8sQjxfza/brPslbbPWAc0F+e/+SVZc=;
        b=nBZjsb2p64lSHV3UQfHh8/HkbMUTV3vN+/Y/kzx1VGutq9pBRMQpRddKp+x+GeyIf+
         kcnVYe1yCGIiaE0aYLwrPZuG/VjJHp3U4wKXCjdudwRZO4fXlnRNy0iaySpnXFh7F+FR
         4sdWM5mJY8JBfVb5/MNAGaamtHocF8VXhVPViJH+nc36Y/w/E83/5FgNp9lukIPTLpa1
         IsUxIEwbScXz6s98iGm+OaE3iIMW5xKhwovUpRmlFGf17qS7wypvTefZA/RdmTRUou+7
         SpUTL3+ZInn8AofNYDrjgayDaGbMZU7ovlgD8u8JeuDYRW/OqHgEf/OjMZ8wUcQMc2k4
         D6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740451355; x=1741056155;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aZanNtGerLw/d8sQjxfza/brPslbbPWAc0F+e/+SVZc=;
        b=iZw4iE9q7lF25wcjH5tWNIj6/Jg/g6RAKahEdD5grSjNIa2MCS4r6loxpwOwVj4lJ4
         xp31ILgWFI4wkFBlv24Z4wQKfF3ITa7MsPfsDjd8///wtYFU7juYbQ9NnEdf8hkP34uU
         K1BZDWu2tz/feVqQne4jSjG6GxFF+kMSl3yXxbnZGE2jJYCDk74Vi2AfN5MUS69sqSWv
         qZZi1iAlRsL8QjjuMKd7vY9uHRhTzjDp9ByfEQOWG+bTJz5X098Djhx1CjAuYbe8Apy2
         Vf3IKIj2g8hbdAY9nT9JBZgH+1zJZeHgan+ofZmlErFmMXjDkkFiGQu96ZWIEkHtW8wr
         FZNQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrW9FkLDa5AasARhxqU9O1qX3j74mM3cTF0ZG/I1PLICnnRgSMFWpp5RYD7YNU7VEMVigqCSzNj7DMGKzpaeyayNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAC9TWvfPU5Q303+7l/s0hKXz7WDUV1A43xKsIIR2wP/hF5VkG
	HsKzE+uZbMVsG55BQquCX6+SDoddOxpZ47IJYSdM6fImY5sW1i4mRh2G9xc0qMo=
X-Gm-Gg: ASbGncvwOZbQYuy1xNOkTlfBU21JxkZ3spB99RwqkeXUHgYaOZKOWaT7uEQHCkk0x65
	awgj07G4RiPYZ1eB++Cflr/E//V3ZeotuUhoUw7HgBLXmy1P0hXEK3anCkhl3hhdMVaQHpy156T
	2RrH+2iEX2eYwz+VHuMO2l5xZ4SwXxxNaoj8EQtxWpjX9u7s9D5cjnbBp4xPx98lY9VXe5adBel
	tLwTO0/zJIcGw+jGfWWls+h66nThZeGQ+h+972lnE6iabbWdg48MlYXw2oyJ1ka1ruL0alH+ncV
	OFCxUC/pXNn3Tqj/d08I5Tp6E8EQcyP549XkvPE0Wg==
X-Google-Smtp-Source: AGHT+IH9Mpxjv6YP2dwaBxfmSmdJtkTNXmqQrMZT7HWbkyf1jCK+dNT3UgG+ZQDzaPqR9bpDWYMqpQ==
X-Received: by 2002:a17:90b:56ce:b0:2eb:140d:f6df with SMTP id 98e67ed59e1d1-2fe68ac9543mr2456297a91.1.1740451355356;
        Mon, 24 Feb 2025 18:42:35 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a09d819sm3163885ad.163.2025.02.24.18.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 18:42:34 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 24 Feb 2025 18:42:21 -0800
Subject: [PATCH] riscv: tracing: Fix __write_overflow_field in
 ftrace_partial_regs()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250224-fix_ftrace_partial_regs-v1-1-54b906417e86@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAAwuvWcC/x2MUQqAIBAFrxL7nWBSBF0lQpZ81kJUrBFBePekz
 4GZeSlBBYmG6iXFLUmOvUBTVzSvvC8wEgqTs66zzrUmyuPjpTzDn6yX8OYVSzIIgWPLPToEKvW
 pKOp/HqecP9rKXD9pAAAA
X-Change-ID: 20250224-fix_ftrace_partial_regs-eddaf4a7e5ed
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Oleg Nesterov <oleg@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2184; i=charlie@rivosinc.com;
 h=from:subject:message-id; bh=W8bVT3KdKXtHJWTSCayGdVWSdCOptjFaSdECSOxAXbo=;
 b=owGbwMvMwCXWx5hUnlvL8Y3xtFoSQ/pePaFXX7s2bp3zKU+I8VTyye6Hcs5ZQW55OV0N6vaia
 hpWz592lLIwiHExyIopsvBca2BuvaNfdlS0bALMHFYmkCEMXJwCMBFnD0aGFYa+ihbXIxac9TD4
 9vNykqqDfbtqVTSP5KIzEwJEHk4QZ/hnnpNy6V9D9YeoQjaz4m0ray4lp765IDFlloPj0tglt+y
 5AQ==
X-Developer-Key: i=charlie@rivosinc.com; a=openpgp;
 fpr=7D834FF11B1D8387E61C776FFB10D1F27D6B1354

The size of &regs->a0 is unknown, causing the error:

../include/linux/fortify-string.h:571:25: warning: call to
'__write_overflow_field' declared with attribute warning: detected write
beyond size of field (1st parameter); maybe use struct_group()?
[-Wattribute-warning]

Fix this by wrapping the required registers in pt_regs with
struct_group() and reference the group when doing the offending
memcpy().

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/include/asm/ftrace.h |  2 +-
 arch/riscv/include/asm/ptrace.h | 18 ++++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index c4721ce44ca474654b37b3d51bc0a63d46bc1eff..ec6db1162021fbf4fa48fc87e7984266040aa7d9 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -207,7 +207,7 @@ ftrace_partial_regs(const struct ftrace_regs *fregs, struct pt_regs *regs)
 {
 	struct __arch_ftrace_regs *afregs = arch_ftrace_regs(fregs);
 
-	memcpy(&regs->a0, afregs->args, sizeof(afregs->args));
+	memcpy(&regs->a_regs, afregs->args, sizeof(afregs->args));
 	regs->epc = afregs->epc;
 	regs->ra = afregs->ra;
 	regs->sp = afregs->sp;
diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptrace.h
index b5b0adcc85c18e15c156de11172a5d7f03ada037..2910231977cb71dac3cc42f2dc32590284204057 100644
--- a/arch/riscv/include/asm/ptrace.h
+++ b/arch/riscv/include/asm/ptrace.h
@@ -23,14 +23,16 @@ struct pt_regs {
 	unsigned long t2;
 	unsigned long s0;
 	unsigned long s1;
-	unsigned long a0;
-	unsigned long a1;
-	unsigned long a2;
-	unsigned long a3;
-	unsigned long a4;
-	unsigned long a5;
-	unsigned long a6;
-	unsigned long a7;
+	struct_group(a_regs,
+		unsigned long a0;
+		unsigned long a1;
+		unsigned long a2;
+		unsigned long a3;
+		unsigned long a4;
+		unsigned long a5;
+		unsigned long a6;
+		unsigned long a7;
+	);
 	unsigned long s2;
 	unsigned long s3;
 	unsigned long s4;

---
base-commit: d082ecbc71e9e0bf49883ee4afd435a77a5101b6
change-id: 20250224-fix_ftrace_partial_regs-eddaf4a7e5ed
-- 
- Charlie

