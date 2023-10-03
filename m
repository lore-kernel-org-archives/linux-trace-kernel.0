Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33425102
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Oct 2023 18:24:14 +0000 (UTC)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C88595
	for <linux-trace-kernel@vger.kernel.org>; Tue,  3 Oct 2023 11:24:11 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40537481094so11975975e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 03 Oct 2023 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696357450; x=1696962250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9fq2RfR39uaAULbR2hK0DPNGxa1+1fryXBa+jVce0es=;
        b=nEzdDOpoqBI+wQtVlCWJW8amnF8ZXPhPovZR+h40G2m8tHkKCExGUYemCvKZqTtYKL
         npqglkZ835xAqhI8HHNAwhJeo/uH+r7FKOzG2e70C6lLfpCvn9ztd9EsfoZxmnIm+wGE
         vV4ALlFYs+3yvbEp6eXRSj8jefM8m/u26a4FBUtk/ifqwbzW2RKZVfO7d0OgJznRf9gI
         6XfpO0oBDr9Sr2F9o80cf4b7AJZcJPY+TqVqBF4k5qP/i4aWsG+Cvk4QNax6q3rKO7Bp
         PUCm37oW547HK7qno/OaTw+JOJl4AO8TiLLGZBYuCWFUTcsTKjwg5UVZTkYNJlKW0skB
         FZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696357450; x=1696962250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9fq2RfR39uaAULbR2hK0DPNGxa1+1fryXBa+jVce0es=;
        b=t7gzmWqFxXkP835ZJN32bWqxP/aXPm3uTUEVHitJ7EVlbIENT9iILg4zR416DZFEma
         EwY9EeNiVoJaoEy5hg4nIJhhrQDmwOxLzFY2M8v8NKBuZDXT+Oh8vNjHWoBG7iR/IvU8
         PCYJJsWae5VEn6FzgO0vRKSJbWt5EU/FfX4VJL3FlJMAOr5XsGKOHaIo24zzWXC+3CbD
         oMGyVGirv0QQW6DxWaddc09ZYglZK8rJJu8lQTJVE+QwaNbyWuVLdRBEUfB5anTet8yt
         uQCUcrJFNiAKNcCU2LzkHJ5cyfhy+PiT/SaoXogepEyppgydLAUlubsHDmFfvqoOMXS8
         9ngw==
X-Gm-Message-State: AOJu0YxeKAgDFH9iE74As8GicHYBUniED+G/mOnKDnD8DoRd6jb0QOz/
	XPqTQ25s8lJG9GLxiGRo5OpTjQ==
X-Google-Smtp-Source: AGHT+IFST40dAkMljajKV3st91h8lo8KqjiqMch0O4WAUPvcsQAwJnwqFiLD2Dq6fOcnD3TpdoY4xQ==
X-Received: by 2002:a05:600c:22cf:b0:401:4542:5edd with SMTP id 15-20020a05600c22cf00b0040145425eddmr187257wmg.34.1696357449779;
        Tue, 03 Oct 2023 11:24:09 -0700 (PDT)
Received: from alex-rivos.ba.rivosinc.com (amontpellier-656-1-456-62.w92-145.abo.wanadoo.fr. [92.145.124.62])
        by smtp.gmail.com with ESMTPSA id m24-20020a7bca58000000b004063977eccesm10001349wml.42.2023.10.03.11.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 11:24:09 -0700 (PDT)
From: Alexandre Ghiti <alexghiti@rivosinc.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Sami Tolvanen <samitolvanen@google.com>,
	Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: [PATCH -fixes] riscv: Fix ftrace syscall handling which are now prefixed with __riscv_
Date: Tue,  3 Oct 2023 20:24:07 +0200
Message-Id: <20231003182407.32198-1-alexghiti@rivosinc.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

ftrace creates entries for each syscall in the tracefs but has failed
since commit 08d0ce30e0e4 ("riscv: Implement syscall wrappers") which
prefixes all riscv syscalls with __riscv_.

So fix this by implementing arch_syscall_match_sym_name() which allows us
to ignore this prefix.

And also ignore compat syscalls like x86/arm64 by implementing
arch_trace_is_compat_syscall().

Fixes: 08d0ce30e0e4 ("riscv: Implement syscall wrappers")
Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
---
 arch/riscv/include/asm/ftrace.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 740a979171e5..2b2f5df7ef2c 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -31,6 +31,27 @@ static inline unsigned long ftrace_call_adjust(unsigned long addr)
 	return addr;
 }
 
+/*
+ * Let's do like x86/arm64 and ignore the compat syscalls.
+ */
+#define ARCH_TRACE_IGNORE_COMPAT_SYSCALLS
+static inline bool arch_trace_is_compat_syscall(struct pt_regs *regs)
+{
+	return is_compat_task();
+}
+
+#define ARCH_HAS_SYSCALL_MATCH_SYM_NAME
+static inline bool arch_syscall_match_sym_name(const char *sym,
+					       const char *name)
+{
+	/*
+	 * Since all syscall functions have __riscv_ prefix, we must skip it.
+	 * However, as we described above, we decided to ignore compat
+	 * syscalls, so we don't care about __riscv_compat_ prefix here.
+	 */
+	return !strcmp(sym + 8, name);
+}
+
 struct dyn_arch_ftrace {
 };
 #endif
-- 
2.39.2

