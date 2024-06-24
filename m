Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B205C613
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Jun 2024 08:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719217309; cv=none; b=FCYiMEiXBaTnjkWvVbx76Sjd0zEZKWmzxxS/a+wfN8Hsfc8EMoy0cz0KxhPW0FHLfG9Za12SFkU4wH2sn8IAmkwmuxn1vFJB278Eda3ZZIwlg3cALjpG0F8DCS0xMlYPx8nQldk0dwKSSlkwUyDmDYGn3+78G/KOmXrBm55dfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719217309; c=relaxed/simple;
	bh=Q8+lA3g3VpMDpv4RGNngoyb1uea582m7nevs6ZhhA+k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dqeZluzD1VL6v3K3HnQ94BcIpksQTB8Oo8k9BVq9Hg7qshOGc9mDUkYBoAdGIgjjhtXOrjpKzrK7hQNMpkJ+msFx83hi84wLcMlxPWqeLDtlF1l392wiK+L8ARg0Mjh7C/vxkgnCxXYD45q9SNw/VtHw7HX8CXcjHsQj3iz/l2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=jy20IWaa; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="jy20IWaa"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a72517e6225so89793166b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Jun 2024 01:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719217305; x=1719822105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zZ1i8mi9BqNSECU2gQQmd4hyYzq+GyjZ8nLWHvP5TDw=;
        b=jy20IWaaRcWo9WyHfcChvBwlUhDWl8RI2w7mBXaAJpDKQpXB1UtsSQPBHnChJ5Lamu
         /QioMSHX6yDu3ThkINiqpJQhOujFrUqNos+L/XODrEorpyfDni2YmuJX2wGn6i5JjfXe
         LARkIp7OpRrgIpCdqdHv/Tcyx6ens751p5LFcAiaDF/2GSw7vJuUMq++JsTo1kCNbhxR
         c5pZOwTgh2XzjISNRI7wgMKaY42uwkhrayHjDmNOkHwBIOIb9/lFL7UB2Ig97B37Y2yb
         bV/sPm5LXwi2AWam9a/JtRiT3AUTs3BGWAadEG14eza6q6I/7L/oOxk7mh/qeTWo0N2J
         vfMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719217305; x=1719822105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZ1i8mi9BqNSECU2gQQmd4hyYzq+GyjZ8nLWHvP5TDw=;
        b=bdemCn1WQggTJsjC9MvD8p7ihAvOnVt0aSUEWt90MEBSxIc2uUvfWc0Mu75oPeqrIz
         PN0HPXGDHoCX9t+Mr5hhrPPUtBj0PsFE/E0uyig8bfAgn+YfbYwgerzy+kASoh0r+lQf
         joRPRSCnPrjyJFgKkDEXrg01wY4CSGBSMatdiGUsBWNATytYac7dpz7Hlw3TeY0xUEOB
         6nelQOVZO1qHhZ5WSvaLFLqGt0Mssz/biLtgdP+U8IrGpK7D6d12d7CHsFoUtkZts85c
         zXKXkjwivUfUc/Fl2SR2KQLjbI9OL7peYeSZ6KgKNppgPRf+3IhxClJswy0LKKwX7Ze0
         k8ow==
X-Forwarded-Encrypted: i=1; AJvYcCUcG7KwuX1J8VkBh+mTCPZEgKQCr/rKZUZwmpHaLzNT8xu9Xgh9tw436ckXyHHCWtaRZ2XYP7+tUf5IF9soQcB+N7Su66GFZ1ntRkKWHUYkLPiD
X-Gm-Message-State: AOJu0Yx1ygHxu9Xrxf6jxP+HLSLH2n8QOM6cM4ab/+j4rq++I2QTexqi
	vY1aKINVLkssJOTURyoGERSXM+cqA6j0JNyV3za11VNXUxPyDd2EhaVz0SCIe2M=
X-Google-Smtp-Source: AGHT+IGBH8KsRxnkr+7B5tqjabfbteV9WIQqVq8let6lqDrgcfIE+H/7OcoN0EbyyGuJFz1zez80FQ==
X-Received: by 2002:a17:907:c281:b0:a72:5e67:19dd with SMTP id a640c23a62f3a-a725e671ad7mr48004166b.6.1719217305317;
        Mon, 24 Jun 2024 01:21:45 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com ([89.207.171.145])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fcf428c18sm385774466b.24.2024.06.24.01.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jun 2024 01:21:44 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andy Chiu <andy.chiu@sifive.com>,
	Puranjay Mohan <puranjay12@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH -fixes] riscv: patch: Flush the icache right after patching to avoid illegal insns
Date: Mon, 24 Jun 2024 10:21:41 +0200
Message-Id: <20240624082141.153871-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We cannot delay the icache flush after patching some functions as we may
have patched a function that will get called before the icache flush.

The only way to completely avoid such scenario is by flushing the icache
as soon as we patch a function. This will probably be costly as we don't
batch the icache maintenance anymore.

Fixes: 6ca445d8af0e ("riscv: Fix early ftrace nop patching")
Reported-by: Conor Dooley <conor.dooley@microchip.com>
Closes: https://lore.kernel.org/linux-riscv/20240613-lubricant-breath-061192a9489a@wendy/
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/kernel/ftrace.c |  7 ++-----
 arch/riscv/kernel/patch.c  | 26 ++++++++++++++++++--------
 2 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index 87cbd86576b2..4b95c574fd04 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -120,9 +120,6 @@ int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
 	out = ftrace_make_nop(mod, rec, MCOUNT_ADDR);
 	mutex_unlock(&text_mutex);
 
-	if (!mod)
-		local_flush_icache_range(rec->ip, rec->ip + MCOUNT_INSN_SIZE);
-
 	return out;
 }
 
@@ -156,9 +153,9 @@ static int __ftrace_modify_code(void *data)
 	} else {
 		while (atomic_read(&param->cpu_count) <= num_online_cpus())
 			cpu_relax();
-	}
 
-	local_flush_icache_all();
+		local_flush_icache_all();
+	}
 
 	return 0;
 }
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 4007563fb607..ab03732d06c4 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -89,6 +89,14 @@ static int __patch_insn_set(void *addr, u8 c, size_t len)
 
 	memset(waddr, c, len);
 
+	/*
+	 * We could have just patched a function that is about to be
+	 * called so make sure we don't execute partially patched
+	 * instructions by flushing the icache as soon as possible.
+	 */
+	local_flush_icache_range((unsigned long)waddr,
+				 (unsigned long)waddr + len);
+
 	patch_unmap(FIX_TEXT_POKE0);
 
 	if (across_pages)
@@ -135,6 +143,14 @@ static int __patch_insn_write(void *addr, const void *insn, size_t len)
 
 	ret = copy_to_kernel_nofault(waddr, insn, len);
 
+	/*
+	 * We could have just patched a function that is about to be
+	 * called so make sure we don't execute partially patched
+	 * instructions by flushing the icache as soon as possible.
+	 */
+	local_flush_icache_range((unsigned long)waddr,
+				 (unsigned long)waddr + len);
+
 	patch_unmap(FIX_TEXT_POKE0);
 
 	if (across_pages)
@@ -189,9 +205,6 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
 
 	ret = patch_insn_set(tp, c, len);
 
-	if (!ret)
-		flush_icache_range((uintptr_t)tp, (uintptr_t)tp + len);
-
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_text_set_nosync);
@@ -224,9 +237,6 @@ int patch_text_nosync(void *addr, const void *insns, size_t len)
 
 	ret = patch_insn_write(tp, insns, len);
 
-	if (!ret)
-		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
-
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_text_nosync);
@@ -253,9 +263,9 @@ static int patch_text_cb(void *data)
 	} else {
 		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
 			cpu_relax();
-	}
 
-	local_flush_icache_all();
+		local_flush_icache_all();
+	}
 
 	return ret;
 }
-- 
2.39.2

