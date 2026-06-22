Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B1F33A9D1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 18:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153076; cv=none; b=XZ30oMkvc5Jz1FS9Y8xRnLp5EGSE/+VLEDKJ6e5mdieIWbMNTJyQ+K4XnAU0F5sLWrjpKOvTU2BS6blAklMKUs+QwhnR7F7/FqB0II7WDAApAcdDERzuji8uZ37SnYaTCW3X8qvok3lyCAnpSGDL5Gq0hv/xJ05fTE2smGPLYgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153076; c=relaxed/simple;
	bh=QIYEraF/j8k02VvAVfR9lZtuZN9nqciszILyb4fLqMM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q02/LmH6j0kkjykfoBPq4QEihm2qJdCsa7DLNdCmBemZG1lfKuaT43hBw8TMI/zWZb1Qymldzj5Z7flg8wf3gi36oD6slofx+YdveQQ0ZqGGst/716JkhNl8NLeRsyIE/MSt0gT3dG2KU1N2KTcwrehqMNKbubszbslvNMMybmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L/neiS/m; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/neiS/m"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7fdeab38240so42174487b3.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 11:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782153074; x=1782757874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NeK5tgUe20vmCAZ/D9O4itxg6FXOxTZ9G+a/3t1IL1I=;
        b=L/neiS/mkAhH7E6rkZwJ0l+j/I64WLX0mhZTbUcyZLy3jLPrkB2F28x7KaRfa9T2VS
         wv9FbKLvywNmrOep9oQ0Zc6nRRwKa7YpiUuX/zDduC3lBw3qrtIrbf9jMjqDh7wrfsj3
         1/inbhASbNG6o+NHx4856Jt30HVA2FhXy3JPw4napnrYhxCdElnvUUflBZtX20Isr1Ty
         tA6iF6NPbmbiIQ4r3Qi/P9LhZT8+OTIoBkJDCTFU6TqjYy2n7+cabUIMTZQTUmzeX72a
         /D8XU1d7fCDMfUywG0ED8/VATHJIVtyW8BVqBhvp0FA4/EXBk+bQREx6H1yFusFZRAgK
         rxxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782153074; x=1782757874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NeK5tgUe20vmCAZ/D9O4itxg6FXOxTZ9G+a/3t1IL1I=;
        b=VDX9SJEJz6OPMg7h8+lR7r06ilDj97y7gAKu9PcqdzmkHXK8G9EYBtd+2Vexy+JeoO
         ZmlzOpbBxJbzS8kUWAnqWLhTwAdYfgV9bH3HF6D+K7GZx+MEmT7QXuRTLwHYZrs0im7m
         TY7MPZWGBkgzjDBjLwPkJ8hxwzerWpm7P11m/gffp2rAbbvotLU/Ht7RrPnsJ1DHXuI0
         CGWritw3zRXEj+EieEWnil2PbXdyhZPJ3xZT6YqEv+DeiQrTcEoKRoX3agNYNYV6Mg6U
         9gtZ2P3rtnZ8cOpkV4Dl6TRHmz87/5/+RuDbRy6Nl5y9j542tZdfB7KRasYrXt82Z9Wv
         /Ntg==
X-Forwarded-Encrypted: i=1; AHgh+RpD375vn5Tvx0uOTSiZpkibG7sDFObPH81LOVgbgGMiCAgARXQ3fKuAk9Jz102ZkoYmgpd8Rn6SAlrd9ATESOEobN4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsDiC6C0/z1u2MsHgWKByESD0vFiWRePY80KAueUASEeTLeaXN
	XGyCiRPGM4t5doHZwCrnHHHgpVsl1L3vcRsxO5LNiYqn16UA98HZnd7R
X-Gm-Gg: AfdE7cmMjhGSOyOjoe89EHunCbaACaeGFyrJ2L/0hrRSOmceqw514waSHZ/Tzq+b1zY
	xzycrbvsiLPD4xJH4pMNOea5IdhAJnJPCKy0VEQZpIi+9q98OXDeHe9f9zqGixVT2h97FVqlmDE
	iy4Yk7gTE4t1X+jUHsf0OPWGAJbBUmJqAGXGxYuzKvE8JYL8UdVkJa3F31or7CLuEsWOtIVSrGH
	eJouXi4R3zmSoPf2jwSF9eJiQaX8uAjxcpXEze4R79U27i9ZftYw+i6R9IGmCbAPTOYRAD8u0MU
	md1o4x3LNrB1iOi/t4T7EK8mIHu+rdslSxpA3vGF+xwaPsMplri3BpBASUp/+o1dRm8oxrg5ujr
	4Xazg1yH/mfTHrtFfjTm7Z8ckTKaGDwu2AClX3w0XOBy1LonHPcYnWMZPdeVcuxXs5wXNjS23JS
	TTnybdOxLJGSVA56CWhS5Hbb1MWVb3+mEvrg+FETvfidja2IDN0RGqhi8Sj4dGnxEIqxtBLL3iA
	rN0PFfCNUnpAIg=
X-Received: by 2002:a05:690c:c24c:b0:806:71b2:8f4f with SMTP id 00721157ae682-80671b29ee6mr10031217b3.20.1782153074082;
        Mon, 22 Jun 2026 11:31:14 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81fcb4a4sm101855136d6.36.2026.06.22.11.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 11:31:13 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	shuah@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH 2/2] selftests/x86: Add shadow stack uprobe CALL test
Date: Mon, 22 Jun 2026 14:31:09 -0400
Message-ID: <20260622183109.1137245-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260622183109.1137245-1-dwindsor@gmail.com>
References: <20260622183109.1137245-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add coverage for entry uprobes installed on CALL instructions while user
shadow stack is enabled. The test puts an entry uprobe on a helper whose
first instruction is a relative CALL, then verifies that the call/return
sequence completes without SIGSEGV.

This catches regressions where x86 uprobe CALL emulation updates the
regular user stack but leaves the CET shadow stack stale.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 tools/testing/selftests/x86/test_shadow_stack.c | 86 +++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
index 21af54d5f4ea..3d6ca33edba4 100644
--- a/tools/testing/selftests/x86/test_shadow_stack.c
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -873,6 +873,86 @@ static int test_uretprobe(void)
 	return err;
 }
 
+/* Keep the CALL first so the function address is exactly the probed CALL. */
+extern void uprobe_call_trigger(void);
+asm (".pushsection .text\n"
+	".global uprobe_call_target\n"
+	".type uprobe_call_target, @function\n"
+	"uprobe_call_target:\n"
+	"	ret\n"
+	".size uprobe_call_target, .-uprobe_call_target\n"
+
+	".global uprobe_call_trigger\n"
+	".type uprobe_call_trigger, @function\n"
+	"uprobe_call_trigger:\n"
+	"	call uprobe_call_target\n"
+	"	ret\n"
+	".size uprobe_call_trigger, .-uprobe_call_trigger\n"
+	".popsection\n"
+);
+
+/* If CALL emulation misses the shadow stack update, this exits via SIGSEGV. */
+static int test_uprobe_call(void)
+{
+	const size_t attr_sz = sizeof(struct perf_event_attr);
+	const char *file = "/proc/self/exe";
+	int fd = -1, type, err = 1;
+	struct perf_event_attr attr;
+	struct sigaction sa = {};
+	ssize_t offset;
+
+	type = determine_uprobe_perf_type();
+	if (type < 0) {
+		if (type == -ENOENT)
+			printf("[SKIP]\tUprobe on CALL test, uprobes are not available\n");
+		return 0;
+	}
+
+	offset = get_uprobe_offset(uprobe_call_trigger);
+	if (offset < 0)
+		return 1;
+
+	sa.sa_sigaction = segv_gp_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+
+	/* Setup entry uprobe through perf event interface. */
+	memset(&attr, 0, attr_sz);
+	attr.size = attr_sz;
+	attr.type = type;
+	attr.config = 0;
+	attr.config1 = (__u64)(unsigned long)file;
+	attr.config2 = offset;
+
+	fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */, -1 /* cpu */,
+		     -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
+	if (fd < 0)
+		goto out;
+
+	if (sigsetjmp(jmp_buffer, 1))
+		goto out;
+
+	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK))
+		goto out;
+
+	/*
+	 * This either segfaults and goes through sigsetjmp above
+	 * or succeeds and we're good.
+	 */
+	uprobe_call_trigger();
+
+	printf("[OK]\tUprobe on CALL test\n");
+	err = 0;
+
+out:
+	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+	signal(SIGSEGV, SIG_DFL);
+	if (fd >= 0)
+		close(fd);
+	return err;
+}
+
 void segv_handler_ptrace(int signum, siginfo_t *si, void *uc)
 {
 	/* The SSP adjustment caused a segfault. */
@@ -1071,6 +1151,12 @@ int main(int argc, char *argv[])
 		goto out;
 	}
 
+	if (test_uprobe_call()) {
+		ret = 1;
+		printf("[FAIL]\tuprobe on CALL test\n");
+		goto out;
+	}
+
 	return ret;
 
 out:
-- 
2.43.0
