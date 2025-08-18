Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6953203B2;
	Mon, 18 Aug 2025 12:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755520075; cv=none; b=AMYcrQCPItSkIXLebI5YiCqdULQOVnZM/JgUYv6WEUUvx1nN9xAtJl8MGKm6TiyhRpeTvoAem5VzIimLKjzGxHJNgJhRBESyb+ueqOvWh0nsrkU4ucJlxwwvcpIV6qp7ijOZK+NlY8ss3SQx11ybYWUTsTkkm6X2fBWjsOCZhVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755520075; c=relaxed/simple;
	bh=xRnuQR5nmKX86oqKG4RVX0dFhvbSEmxNcFqn88jRw9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hV30HLxe1s12k7wznyZZmPLdKQf1zGOGBOeUNQbTqr/6jhE2ApKikhHBCXBP6140yLGG59xfz3uNYv4EThBlyiWkZKN/RBMeqHToAHsYW4fIt7vWciMVX6bgcxirDRy8UQ2kG3R18uL0bn8UqCRQvHFAffnfTQhLEEfYGxNPKFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QYYq1Jj6; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QYYq1Jj6"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24458263458so31220675ad.3;
        Mon, 18 Aug 2025 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755520073; x=1756124873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7+skqhizRw6+30lEgRR8mTRkTR/5hsa5rsGuByfmTmA=;
        b=QYYq1Jj6hCuSNlHtaBMtK8XFG1iRbD7k3e1/z2G7oqhT0RGA/BY69zm3JWY3kKHbN5
         PeEXpDBAqZC3xDe4QeqaG2vlYIz/QANvQ1D7vHNywHQS+Mu2nGyuB6unE+NPtpaZUuyx
         y6x7KVwY8jovOS6XzGAU9gW1Uj1hkq61Jd8arSXaygB9odYNRAEyET1KqxQ12k0HDHpx
         wayf2C6eaFkKWx4RKRr5FkqANZ1QTMKemfOT3AGmioWQnznObBCMxMLrOWA0fmgzi3uv
         0ACpw4q/nujIk17rxJXboUw6k6z8elMxq9VqsKh8+v62jNUopfSt/q/9eprgAzKD1Lb/
         QOlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755520073; x=1756124873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+skqhizRw6+30lEgRR8mTRkTR/5hsa5rsGuByfmTmA=;
        b=AymxFcUPTuQhjwnKsyhN1maLcDkP/9bP01gQg0mPNAGzR5yymE/zbM1Cz911oqcSu5
         Tdgr2/d97d89J30qGYgluABNzcAjkXj/XtKaXuXlTEbVRnQwp7kYxoAp+e6EsBuTeiwI
         nxs82gx3PsmWR7VHUp0vgboqLrAavj5wjxIdqTKm3sRGCbrkrM5/dZEe4517zdMHfiLx
         Hel97VNJb5dPzS7acEZWqFZuOdc5AlsOMub9Y7Z0LioHwexfVz4qRNdFKYIc6QZcVNFO
         JX3/bOxZPHWKQtG2//14wWyLq1fpz6sEKjsqGpejSN2oI4cu6irkShebgZKi9I6zCRGn
         z4AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUa971fD7qwK8P066bhuTqNZH/z0qa+rSJdQg4WwDL2KmWzY6e/mxVclO4MTQgmZIbYAoTHPjICUBAXS5NhrjI7E0cZ@vger.kernel.org, AJvYcCV3UPyGs+i8lVnOxLH6J9+eXl80YxJh6MS6k18R4kPCMIdnTWTXOlD57Rxe6zc16h2vZKPpZAOsRByNj5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLANZp795M6abIdcShW6xwzHHavbKg2uRHMSqRYiWZDp6/IzGL
	jIuIHwDZVi9rHwOVfKjnAjDFiqUnwNjWPJDqky6gs8EafwzLQs9R83z3VC8pEeH3IVU2zA==
X-Gm-Gg: ASbGncv4nAXhS2LdMhD56d3NcdZCLuv1XytaWPBdhCp8FItHnGgB3t+MSd5XJCiuNYA
	AUEdvpuB7GAzCC4IYR8hW3ALNbjXgJyJwSm4DfyN+Q8KnOY6q5iTQNZXJAN++Vs5ZYdC0FQ2OTk
	gUnR+Dyw2Ot0ylSku2BwOtt2ReOwPZ+5laF5b9bKAy5wGLdWs1NckzjjY+hPtlifUbOQ9kk2SX0
	3qnfGHwe21PuHSXwud4aCw7yd40uGNMIl+Cnod/ZjSkZL0HJjtbCXpUYD4rpfgCaYpdqF3eaHfW
	kEy5UUlPFJgl8eCG6jQWsBsIGw/iNF+hZ2vOv42pZ9M/fmSdQKwMwQlDA5sUc6Dog8TPG+pOIBc
	k0dEFuIMucKcvnO2atTEq2c2pbZUJf+COodor1UNibcwe
X-Google-Smtp-Source: AGHT+IHJgfLfFK4K0WfBuoLmxYaamKTTf8SH/w3sao6ewMfrYn3NMsyzytLmcdtif1DDDCDs+rERsw==
X-Received: by 2002:a17:902:cccb:b0:243:80d:c513 with SMTP id d9443c01a7336-2446d6e444dmr167144865ad.4.1755520073253;
        Mon, 18 Aug 2025 05:27:53 -0700 (PDT)
Received: from localhost.localdomain ([2604:a840:3::3008])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d57f12esm79236705ad.157.2025.08.18.05.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:27:52 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: akpm@linux-foundation.org
Cc: mhiramat@kernel.org,
	naveen@kernel.org,
	davem@davemloft.net,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 02/13] x86/HWBP: Add arch_reinstall_hw_breakpoint() for atomic updates
Date: Mon, 18 Aug 2025 20:26:07 +0800
Message-ID: <20250818122720.434981-3-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818122720.434981-2-wangjinchao600@gmail.com>
References: <20250818122720.434981-1-wangjinchao600@gmail.com>
 <20250818122720.434981-2-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add arch_reinstall_hw_breakpoint() to enable atomic context modification
of hardware breakpoint parameters without deallocating and reallocating
the breakpoint slot.

The existing arch_install_hw_breakpoint() allocates a new debug register
slot, while arch_uninstall_hw_breakpoint() deallocates it. However, some
use cases require modifying breakpoint parameters (address, length, type)
atomically without losing the allocated slot, particularly when operating
in atomic contexts where allocation might fail or be unavailable.

This is particularly useful for debugging tools like kstackwatch that
need to dynamically update breakpoint targets in atomic contexts while
maintaining consistent hardware state.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/include/asm/hw_breakpoint.h |  1 +
 arch/x86/kernel/hw_breakpoint.c      | 50 ++++++++++++++++++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index 0bc931cd0698..bb7c70ad22fe 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -59,6 +59,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index b01644c949b2..89135229ed21 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -132,6 +132,56 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return 0;
 }
 
+/*
+ * Reinstall a hardware breakpoint on the current CPU.
+ *
+ * This function is used to re-establish a perf counter hardware breakpoint.
+ * It finds the debug address register slot previously allocated for the
+ * breakpoint and re-enables it by writing the address to the debug register
+ * and setting the corresponding bits in the debug control register (DR7).
+ *
+ * It is expected that the breakpoint's event context lock is already held
+ * and interrupts are disabled, ensuring atomicity and safety from other
+ * event handlers.
+ */
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	struct arch_hw_breakpoint *info = counter_arch_bp(bp);
+	unsigned long *dr7;
+	int i;
+
+	lockdep_assert_irqs_disabled();
+
+	for (i = 0; i < HBP_NUM; i++) {
+		struct perf_event **slot = this_cpu_ptr(&bp_per_reg[i]);
+
+		if (*slot == bp)
+			break;
+	}
+
+	if (WARN_ONCE(i == HBP_NUM, "Can't find a matching breakpoint slot"))
+		return -EINVAL;
+
+	set_debugreg(info->address, i);
+	__this_cpu_write(cpu_debugreg[i], info->address);
+
+	dr7 = this_cpu_ptr(&cpu_dr7);
+	*dr7 |= encode_dr7(i, info->len, info->type);
+
+	/*
+	 * Ensure we first write cpu_dr7 before we set the DR7 register.
+	 * This ensures an NMI never see cpu_dr7 0 when DR7 is not.
+	 */
+	barrier();
+
+	set_debugreg(*dr7, 7);
+	if (info->mask)
+		amd_set_dr_addr_mask(info->mask, i);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(arch_reinstall_hw_breakpoint);
+
 /*
  * Uninstall the breakpoint contained in the given counter.
  *
-- 
2.43.0

