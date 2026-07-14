Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DEE412C0A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 18:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053417; cv=none; b=LO+TOApx8DoTc7uc4mdEHa6DdJ0wlLm17uejbuuSFQmFLMh8bFPMYGZiyig1ShY7guxgGlmz1+uWxR+tsa8WzdkNusA9nKG6v3JR6NhZX9QCt2vJ6k2Nx0nIDjw9jAhTII3gnVhaigWGgx9/3c56Si1rg82xSsX2MAhaYRont+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053417; c=relaxed/simple;
	bh=4jktZnR0Pc2J7o9JFOWqLz2AFfowdAE5d7umNHBmtls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIBY22eGMGYVgL+RPzy+ciAq+7212s1aG9HPmLh+Po+aT2zvuh07XuuchJc82Ryu96HoEwmLunOh5pOGZB59mBXLnz1f6B4XU0b5yft9MXxhcculKxn9Ix25qtGRgmK1QQS8s9EzCNyaoSrs59Tly2ok2mo0jH2KorsDgihDBAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/uYmZ8g; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/uYmZ8g"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-8fcc43c48f7so41931536d6.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 11:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053413; x=1784658213; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dlvBm4NItea/+plJuhWRRJi1bfhjVkmixX1HjLGBPlA=;
        b=W/uYmZ8gEQNcJJpfYjNkCOkHIRSulmC9MgO0+6GH5Zlz1ob9T27rWwkjFtwDYGT32V
         T3sl0sF0ziCMO02IF+45IUl6Z4XE6Fer5piqLvLFaSGjKOKoSchXa6uCx1XyknDeVKM7
         5Xvz9XyZavQGDN18vGn8XDUW5ABO6s3cIk/ibFGDnBFUoDXIOOuaJT5JNZvsSMnc1uGN
         ct2JiGDWuP5HVlU6kUFBRRC2WElQb2DfEEWBcT6mjpbkzxxQ6Dm77+S8JtiQurrlLjtN
         Z7jqPeyRd3NvonDHfCNtkocjzC0zSUbWc4/ONJxIKKrX1bZNB8DrlIcGzpx/xZAV2iP5
         ijkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053413; x=1784658213;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dlvBm4NItea/+plJuhWRRJi1bfhjVkmixX1HjLGBPlA=;
        b=h4LmSX2ASpK7+rluBNBbj8+0nFmCImN7nKT84oIRht9ITJcQlQw5yOcjZgLP88Nswz
         4FjaTrgkjoDuU0JSzfsVuQSjkygLtO4uoCwPfiLdMVOWsx57UXThPkbqB/d1tBn0HorA
         rB/ZolgiZCzXhGcWCvBXF7WaZrJWMnoi0J7TAxXT8Csjw5LYNz200IrnM+lXxdv6DZKj
         V9sCPbeTbJkLu++eEGY/55iKQ12/HS6ALRoGMDG1hHpOJDOVPFsxoN9tZydy9J6FzkoA
         KOSixkcHgIKcAKcuMzYUobqLSMHixIeEevyd8xQ75c8A0h8PlAM1AsbcfU5D+37VS1qY
         +9tA==
X-Forwarded-Encrypted: i=1; AHgh+RqVWwohclv4keXvYwlkhhpogjQu+MQKbXNow/AABE4s0lDbOFFUMmFzyChFkQGR18Yo9Mr1UdKaVhSU/YM/0KU9yz0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXs4qLbINAFKKIu1EdbFpyYoDu4lATRLG5Uy225KTDf9QezpRX
	n9OGPsbdjadSW2eYJ4g0irTlI+SqWiQQTqtPBLSOAIqjTKnR/r3uwdR1
X-Gm-Gg: AfdE7cmu1CbPv03d8SOJHHUpHl5S4nD3D4lg0G0yajO893AmKaJKFthwGg2QJHO71lc
	jtW7NLz5/Ou0Segr10torULLLkcdhPoMO5/KHwViN9JdmbhzPihgtso58rC1/oSSRiiPmfSstm2
	EIv0oKuuT8GL6YkfJxOXdTr9vWzFbuk/3k1L7CIS3I2rHcuCLuToaHv3V11WlNb5kw2fZYlK2il
	Aq4l5kEzwF0ESlK0XHNumsff3/QRJi9bQKX7pJXuWgRRkM7tIKvHHKGHP5N24aWgunT9hr4NPxo
	28dNn5cNR1ec0jsf9SSiDCeMKEUtk9A15X6HxtAkpR6SvEOoMjKufOXBQBbJ2oH7Ph9N5yQcnDr
	DT3zfemEUyHZYg4eEY7Jr1cawiR6W5kDBsX1lUBw+UuXdlPGUKKXAlGqT+vqr2K+33Pz78FDQmc
	Pby/nBewp/NnV6FUtpdKZLvOSNDTbI+WhfOlUHCY0Xdnr6Fm+oyqw=
X-Received: by 2002:a05:6214:5913:b0:8f2:2e4e:f5f with SMTP id 6a1803df08f44-90401b75879mr187179916d6.45.1784053413454;
        Tue, 14 Jul 2026 11:23:33 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd248e666sm173753776d6.0.2026.07.14.11.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:23:32 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 03/13] x86/hw_breakpoint: Add arch_reinstall_hw_breakpoint
Date: Wed, 15 Jul 2026 02:22:33 +0800
Message-ID: <20260714182243.10687-4-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new arch_reinstall_hw_breakpoint() function can be used in an
atomic context, unlike the more expensive free and re-allocation path.
This allows callers to efficiently re-establish an existing breakpoint,
and x86 advertises the capability via HAVE_REINSTALL_HW_BREAKPOINT.

Since a REINSTALL may change bp_len, setup_hwbp() must clear the
slot's stale len/type and enable bits in DR7 before re-encoding:
OR-merging the new encoding over the old one would keep the CPU
watching with the stale width (verified in QEMU by reading DR7 after
re-arming watch_len=1 over a len8 breakpoint: 0x999906aa merged
without the clearing, 0x199906aa with it).

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 arch/x86/Kconfig                     |  1 +
 arch/x86/include/asm/hw_breakpoint.h |  2 ++
 arch/x86/kernel/hw_breakpoint.c      | 16 ++++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index bdad90f210e4..5be698db0241 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -246,6 +246,7 @@ config X86
 	select HAVE_FUNCTION_TRACER
 	select HAVE_GCC_PLUGINS
 	select HAVE_HW_BREAKPOINT
+	select HAVE_REINSTALL_HW_BREAKPOINT
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK	if X86_64
 	select HAVE_IRQ_TIME_ACCOUNTING
diff --git a/arch/x86/include/asm/hw_breakpoint.h b/arch/x86/include/asm/hw_breakpoint.h
index aa6adac6c3a2..c22cc4e87fc5 100644
--- a/arch/x86/include/asm/hw_breakpoint.h
+++ b/arch/x86/include/asm/hw_breakpoint.h
@@ -21,6 +21,7 @@ struct arch_hw_breakpoint {
 
 enum bp_slot_action {
 	BP_SLOT_ACTION_INSTALL,
+	BP_SLOT_ACTION_REINSTALL,
 	BP_SLOT_ACTION_UNINSTALL,
 };
 
@@ -65,6 +66,7 @@ extern int hw_breakpoint_exceptions_notify(struct notifier_block *unused,
 
 
 int arch_install_hw_breakpoint(struct perf_event *bp);
+int arch_reinstall_hw_breakpoint(struct perf_event *bp);
 void arch_uninstall_hw_breakpoint(struct perf_event *bp);
 void hw_breakpoint_pmu_read(struct perf_event *bp);
 void hw_breakpoint_pmu_unthrottle(struct perf_event *bp);
diff --git a/arch/x86/kernel/hw_breakpoint.c b/arch/x86/kernel/hw_breakpoint.c
index 877509539300..4221dbb899f9 100644
--- a/arch/x86/kernel/hw_breakpoint.c
+++ b/arch/x86/kernel/hw_breakpoint.c
@@ -100,6 +100,10 @@ static int manage_bp_slot(struct perf_event *bp, enum bp_slot_action action)
 		old_bp = NULL;
 		new_bp = bp;
 		break;
+	case BP_SLOT_ACTION_REINSTALL:
+		old_bp = bp;
+		new_bp = bp;
+		break;
 	case BP_SLOT_ACTION_UNINSTALL:
 		old_bp = bp;
 		new_bp = NULL;
@@ -134,10 +138,13 @@ static void setup_hwbp(struct arch_hw_breakpoint *info, int slot, bool enable)
 	__this_cpu_write(cpu_debugreg[slot], info->address);
 
 	dr7 = this_cpu_read(cpu_dr7);
+	/*
+	 * Clear the slot's stale len/type and enable bits first: a REINSTALL
+	 * with a different bp_len would otherwise OR-merge both encodings.
+	 */
+	dr7 &= ~__encode_dr7(slot, 0xf, 0);
 	if (enable)
 		dr7 |= encode_dr7(slot, info->len, info->type);
-	else
-		dr7 &= ~__encode_dr7(slot, info->len, info->type);
 
 	/*
 	 * Enabling:
@@ -188,6 +195,11 @@ int arch_install_hw_breakpoint(struct perf_event *bp)
 	return arch_manage_bp(bp, BP_SLOT_ACTION_INSTALL);
 }
 
+int arch_reinstall_hw_breakpoint(struct perf_event *bp)
+{
+	return arch_manage_bp(bp, BP_SLOT_ACTION_REINSTALL);
+}
+
 void arch_uninstall_hw_breakpoint(struct perf_event *bp)
 {
 	arch_manage_bp(bp, BP_SLOT_ACTION_UNINSTALL);
-- 
2.53.0

