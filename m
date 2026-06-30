Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233741FC8
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 00:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778420; cv=none; b=DF0qwyeR8e3CgpgpP95opdBVeaaKwvDekDZnSWA4GZ0V3EZF+uoODT8jsMDX3gOPwKxKHAEzUsLJ9k4LnydUVEQCUF433bGuKw9cL93xSApUlpYFJ3C+4ci8X6l4/o0zENeqjtRXSQqqELP3xPx7yJdDALY9y9WoHQMDIZOwycE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778420; c=relaxed/simple;
	bh=LpefGqISpCECkK9K+7Wu7IMXsR7Ciya9KmDiHH/yoto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sII3nv8SHZIxhHRLmiLsabJtqu/4osQKzXf9gYaiYCiAD9A7uyYDOoPnG48omBYlF5WZ7u4q2RU89W3etFP8e0RYKslpyzDbyv5Dw3iT/Gf24XDX/1TWbirutn/8xLfqDBzs71FmmtPLJVGkuLwrc+DVB2zDxUEchn57BjpAIAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FCNhcUQp; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FCNhcUQp"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-92e5d6f35c1so113775985a.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 17:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782778418; x=1783383218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gBVGMUDoW3cJlDl1HiRQBX/yXVW3BQpzxrX3ECvYbGU=;
        b=FCNhcUQpau95vnDXBW84aIEXsUGFt4JmStl/v70HkGj8qKNp/gBQq31PygwofVQZmr
         SioF62rIZvG6GOxZrXkTSi4BEm+bi8NLZ00b3aEHThsiJlds73UyI3R/qfosdKZpRvPq
         whPwOLQZtkJgILVpvMVs7xT6ZVYYYam1QMj/sAg6dkZI5DXcqQwiRMCLaXgsFDsUcaLP
         FZxRZTPDgnJgbKyuhx5eKNzrO83m83JdEOgg31T0+p/NIkPajyz+g6xHqvMozxJ8xfnz
         +WiBZiCy902JBJvwalH2wPVTmoICSI3gM+LjHqk27ltbl/PWP6qDM87b8reYNLqkd0UR
         cKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782778418; x=1783383218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gBVGMUDoW3cJlDl1HiRQBX/yXVW3BQpzxrX3ECvYbGU=;
        b=JaCSSjtr+L5tjz/fEm6MzGiNnnfK6E/9O+UommgdpOf577cdWJ5Cdeg1bclqbujQ0g
         uh62lOpASHRBeyWFYjBCwaKUJ+Z87o9fI3hExdEf74hI9J5enrCBNnXkwEmwuhBnDycm
         uWwLeYYMB4Lr4zrB18VG5IhLxuqJJASQar9j0wdKN3Kwnj2LR2n6N5UCDfGfI7jiqXec
         sn/YEY++ngNYaxKU3DO3iDn9g369vCWlmNyobwvNKtbikkQCTt7N+mZlc6x8XI01Gqrh
         +vsEv8QQQII+DGxAzaf8ajAd9bFtlsz7dQw1KOwC6r4jdTJOzkJxVbtc9yFMUe8O09Y7
         20Iw==
X-Forwarded-Encrypted: i=1; AFNElJ940RsCFQw46zNLx0IB9g5Q5pGdSWb9Ab12sOUDQYbQ11wT5bGnM4Mjv4z204kao+CQO5bzUXl8hrIeLaU4+PaSrd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdftUPQFpJRN21auG2RHKlacLr/3kT3UzQxFr2W//l4jXWnrDk
	TOFoqEp8Dk5qCVzE0vXrzGCvnsIKicnUmZWt1de0GU5xsC0TK7qgqJ+h
X-Gm-Gg: AfdE7cmx2JJkzNXg8WJLpjragw9Kh1HQAY/2OKSyQrXjaYjccVAN75cOp0/GWRjAtww
	Ui84xseu/mIxtVPTPU0LdEJnU1LiIbQgxRfPBGcckFUjxfJtywHARaGz9hz08+hqs7Vb83TIkQ+
	b1iOTyEBvxMsURUhVu0v+kKQhu+nXKA8h9nI4Sv0KtnzYudYqm8G0ftu+0YS0C22TrxAQxczkOp
	udHXuFQaXGcLaqk8jBeF89NZaFqj/tJ+ef7ZdlcsSjukn4JUnxY8rT0CYZd0TnCjhzVPwjFWqG7
	I5PIcShZqq39uRP3silCGe6mXhHItwqbcSAa2rUQFdStUDyFWLp3cdIsUYbwHsN2dohTiu3dYiS
	Gqpv9Tv0hb6kMQ0rdaxHl1ML+e7bNOF5OeOCTXVKe5gFcVyRjmhIc6qz7RDPhCaAx4d4C+lA/Pg
	dASwZk2d0qzjAavMAtqOy32N9zI9Toe2iWZRemUAGVRDAlgaoogwzLMO5GCthBQEQHd9FfdP2g7
	0nHPXTOJSJv3nA=
X-Received: by 2002:a05:620a:701b:b0:915:8502:f7fc with SMTP id af79cd13be357-92e624ad068mr278904385a.16.1782778418038;
        Mon, 29 Jun 2026 17:13:38 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6219cb9asm101975185a.21.2026.06.29.17.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 17:13:37 -0700 (PDT)
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
	rick.p.edgecombe@intel.com,
	jolsa@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v2 2/2] selftests/x86: Add shadow stack uprobe CALL test
Date: Mon, 29 Jun 2026 20:13:34 -0400
Message-ID: <b957039191118c5eba97d01d80c494b859f115a6.1782777969.git.dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <8b5b1c7407b98f31664ad7b6a6faf20d2d4a6cad.1782777969.git.dwindsor@gmail.com>
References: <8b5b1c7407b98f31664ad7b6a6faf20d2d4a6cad.1782777969.git.dwindsor@gmail.com>
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

Notes:
    v2:
      - New patch. Adds a uprobe-on-CALL subtest to test_shadow_stack_64 to
        cover the fix in 1/2. Verifies that an emulated CALL through a
        uprobe leaves the shadow stack consistent with the user stack
        (no #CP on the matching RET).

 .../testing/selftests/x86/test_shadow_stack.c | 86 +++++++++++++++++++
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
2.53.0

