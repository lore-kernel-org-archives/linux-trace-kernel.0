Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE99161B71
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142840; cv=none; b=rg5ZTCPgySPtpvXKAkIy+Gekd7Tbohly3rCa4W02WpWX08ccHDiH4WYGYguHirS+nmjMK+jJmaNWyi2MxO7Wg0eGbFC2yXep9XMu238bFPaUAzXe649zLFcQMubNu6BzWMNlk5vRRUiAA2VR1vmYJjaOdZI7x1cxhuNneQJbQ+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142840; c=relaxed/simple;
	bh=1Bd28xktdVPNsM8n0LsBzvjun5YufbV6tfnuehsJA7U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNhBBpCJpcnL2OzLeugHJ7//Sho0XoOzSaageLmgkBA+bwan6eGTk5jYuGUjjQRRSTnQXvuHFW7UhofBP1ezxUD6GHZmTRR7DWEudbWYXe6Ofz6olC/QDzjm0F54/6J8CFvQ9DDQdWaO7ei9IObGTBCIBSNWbKasp8p4sfJHK14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=D2IrTjkj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="D2IrTjkj"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412a3371133so76115e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Feb 2024 09:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709142836; x=1709747636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y2KLsPuh1XpNjZ2CAToQLQwQXyB2VEROM3hvTLFmqyk=;
        b=D2IrTjkjDsw+RKk6jHaPEfsFKyrJOMcpjZfnctDFKLMJHzu/vzHLgb6BAX+Y9piSA+
         vg2xGX/EnGpKh7FWvkTbCz4IL1Y1znrUR+u0372XlXpKYczQslLlEYhJ1qEbgZF2lGxp
         85zMkCYpoIFsPiunabG4TkWEpw4wKBlTfuJ0mH08iioPGUulUWcfBv+ghqnSpbtl2Ze6
         U+fGIpIsnA9hlVHiLXNTVd7L4ihI399UhRIn7JsZ6ILHztxWQ64HveUAadAGrEVD9RNC
         25pXfKiuFpCdqq3el5BnwIO7LFrCugy0zB69AL07Ir2aGGrKvNthocvfQGFlIFxxTwht
         qi9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709142836; x=1709747636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y2KLsPuh1XpNjZ2CAToQLQwQXyB2VEROM3hvTLFmqyk=;
        b=TBWrzJnfS7LziI2muPNmY37AgLP2JCBLgs74zV2+TqndqRxCjiEOI+6rJi5UK4Dm2q
         gt44fkTplCP9Wi2CMQmRCFqOEz7FNYqiFz2eexIiiDNJvMtH5VDm6YH7owQE+Kf7eqp1
         Hcixx27fuiEvCUg/D7HsXQnU3nZhoySqVPGneuSy6Y2wLVoFd9uMbKv7VKMVg3RzKhUe
         33ILDS1RSdCWMip1vKkvsg7p+l8TroMXZI4pGkaOHP6qtcSpL7yOhzvK16oNNPiQaeQk
         YeQgg3UObghp0QolmEOVT0AamMdZ8k3Qiiu8UohdFaM7RtYYn0110cFOp9m81fbrZxKS
         k5MA==
X-Forwarded-Encrypted: i=1; AJvYcCXCYZmXGxxN+G6/Ml6yJ2eVGdY86tWl+iuRNqIcSAkH5MTSq/KaqR2lde24cJ03O0GJSTkm4xFexaPL0jVVe2jJc0mjXe83TjOy9RV3K/TtMQ5y
X-Gm-Message-State: AOJu0YwJYkiVfrU5Y1K0XpzHs+CRl5p/gdBdQzmB8powbF3frr3pDryG
	23DPhSoPHTqXnMqEmW+0By6yzz0GCQ0sdQZT5oquVBt8EnyOZCu9fqRjJyrzNV4=
X-Google-Smtp-Source: AGHT+IFzsKFwkm6/PUuNhQXzmzQ00xQ91ajZbuZqPe2v3cVZIJEAYjZNYyL+734jbdq5mZCUaY5k7A==
X-Received: by 2002:a05:600c:190a:b0:412:b15c:9769 with SMTP id j10-20020a05600c190a00b00412b15c9769mr174697wmq.25.1709142836667;
        Wed, 28 Feb 2024 09:53:56 -0800 (PST)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id n12-20020a05600c500c00b00412abfb0ed0sm2880142wmr.0.2024.02.28.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:53:56 -0800 (PST)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Andrea Parri <andrea@rivosinc.com>,
	Anup Patel <anup@brainfault.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@rivosinc.com>
Subject: [PATCH 2/2] riscv: Fix text patching when IPI are used
Date: Wed, 28 Feb 2024 18:51:49 +0100
Message-Id: <20240228175149.162646-3-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228175149.162646-1-alexghiti@rivosinc.com>
References: <20240228175149.162646-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

For now, we use stop_machine() to patch the text and when we use IPIs for
remote icache flushes (which is emitted in patch_text_nosync()), the system
hangs.

So instead, make sure every cpu executes the stop_machine() patching
function and emit a local icache flush there.

Co-developed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/patch.h |  1 +
 arch/riscv/kernel/ftrace.c     | 42 ++++++++++++++++++++++++++++++----
 arch/riscv/kernel/patch.c      | 18 +++++++++------
 3 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/include/asm/patch.h b/arch/riscv/include/asm/patch.h
index e88b52d39eac..9f5d6e14c405 100644
--- a/arch/riscv/include/asm/patch.h
+++ b/arch/riscv/include/asm/patch.h
@@ -6,6 +6,7 @@
 #ifndef _ASM_RISCV_PATCH_H
 #define _ASM_RISCV_PATCH_H
 
+int patch_insn_write(void *addr, const void *insn, size_t len);
 int patch_text_nosync(void *addr, const void *insns, size_t len);
 int patch_text_set_nosync(void *addr, u8 c, size_t len);
 int patch_text(void *addr, u32 *insns, int ninsns);
diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
index f5aa24d9e1c1..5654966c4e7d 100644
--- a/arch/riscv/kernel/ftrace.c
+++ b/arch/riscv/kernel/ftrace.c
@@ -8,6 +8,7 @@
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
 #include <linux/memory.h>
+#include <linux/stop_machine.h>
 #include <asm/cacheflush.h>
 #include <asm/patch.h>
 
@@ -75,8 +76,7 @@ static int __ftrace_modify_call(unsigned long hook_pos, unsigned long target,
 		make_call_t0(hook_pos, target, call);
 
 	/* Replace the auipc-jalr pair at once. Return -EPERM on write error. */
-	if (patch_text_nosync
-	    ((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)hook_pos, enable ? call : nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -88,7 +88,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 
 	make_call_t0(rec->ip, addr, call);
 
-	if (patch_text_nosync((void *)rec->ip, call, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)rec->ip, call, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -99,7 +99,7 @@ int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
 {
 	unsigned int nops[2] = {NOP4, NOP4};
 
-	if (patch_text_nosync((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
+	if (patch_insn_write((void *)rec->ip, nops, MCOUNT_INSN_SIZE))
 		return -EPERM;
 
 	return 0;
@@ -134,6 +134,40 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 
 	return ret;
 }
+
+struct ftrace_modify_param {
+	int command;
+	atomic_t cpu_count;
+};
+
+static int __ftrace_modify_code(void *data)
+{
+	struct ftrace_modify_param *param = data;
+
+	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
+		ftrace_modify_all_code(param->command);
+		/*
+		 * Make sure the patching store is effective *before* we
+		 * increment the counter which releases all waiting cpus
+		 * by using the release version of atomic increment.
+		 */
+		atomic_inc_return_release(&param->cpu_count);
+	} else {
+		while (atomic_read(&param->cpu_count) <= num_online_cpus())
+			cpu_relax();
+	}
+
+	local_flush_icache_all();
+
+	return 0;
+}
+
+void arch_ftrace_update_code(int command)
+{
+	struct ftrace_modify_param param = { command, ATOMIC_INIT(0) };
+
+	stop_machine(__ftrace_modify_code, &param, cpu_online_mask);
+}
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
index 0b5c16dfe3f4..82d8508c765b 100644
--- a/arch/riscv/kernel/patch.c
+++ b/arch/riscv/kernel/patch.c
@@ -188,7 +188,7 @@ int patch_text_set_nosync(void *addr, u8 c, size_t len)
 }
 NOKPROBE_SYMBOL(patch_text_set_nosync);
 
-static int patch_insn_write(void *addr, const void *insn, size_t len)
+int patch_insn_write(void *addr, const void *insn, size_t len)
 {
 	size_t patched = 0;
 	size_t size;
@@ -211,11 +211,9 @@ NOKPROBE_SYMBOL(patch_insn_write);
 
 int patch_text_nosync(void *addr, const void *insns, size_t len)
 {
-	u32 *tp = addr;
 	int ret;
 
-	ret = patch_insn_write(tp, insns, len);
-
+	ret = patch_insn_write(addr, insns, len);
 	if (!ret)
 		flush_icache_range((uintptr_t) tp, (uintptr_t) tp + len);
 
@@ -232,15 +230,21 @@ static int patch_text_cb(void *data)
 	if (atomic_inc_return(&patch->cpu_count) == num_online_cpus()) {
 		for (i = 0; ret == 0 && i < patch->ninsns; i++) {
 			len = GET_INSN_LENGTH(patch->insns[i]);
-			ret = patch_text_nosync(patch->addr + i * len,
-						&patch->insns[i], len);
+			ret = patch_insn_write(patch->addr + i * len, &patch->insns[i], len);
 		}
-		atomic_inc(&patch->cpu_count);
+		/*
+		 * Make sure the patching store is effective *before* we
+		 * increment the counter which releases all waiting cpus
+		 * by using the release version of atomic increment.
+		 */
+		atomic_inc_return_release(&patch->cpu_count);
 	} else {
 		while (atomic_read(&patch->cpu_count) <= num_online_cpus())
 			cpu_relax();
 	}
 
+	local_flush_icache_all();
+
 	return ret;
 }
 NOKPROBE_SYMBOL(patch_text_cb);
-- 
2.39.2

