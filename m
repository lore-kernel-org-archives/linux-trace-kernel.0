Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793150406;
	b=41tCzxEWTVDV/5NoPNWkKMbEkxOM2pcuTj9rJtHWyjBx2E0d6q/P9Kk+hV002reFTzGa
	 1Bk71Qn0zjA4H16gWO/6Wuaia7dFBrXvP6dUElYvny7K7JKgo5cX7VeJyBv9M8+ZNOuWm
	 1ctaY3DwFF/Dg+c1D6+H0r2kcnsvmV1Ythsroo6c7yAgpj/p2lP/69QFN4eE1I+R/J4rC
	 8IoknAO0441NPGC1BJtS/H8ikt0FOXcI/hiKal8sG3k2blIZjLX0YdrpeLUztxC8Ytzak
	 IwbhGqP7lREd99gNmMaBGZ482T8sYDJhfp2qEumjLv2U+L4O7WJlMpZrAlB4uCni8yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793150406;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aLduANwv1S0zzwppHfmO8Zkbjseh7UvsZ5j1k5QDDg4=;
	b=FNtQLbAqgbsyC9sMIPqHEiFpg34lQ45tR4OHcQdKhlOFhVSvXkWrBRvQy5yNQJl5/SbZ
	 KzeQ4hraaLOv9+ZP9pkoEtOw4Cp1zGgBMQQkqE+2nmW/ZZK5GNf88kNiObXnai6eEUThY
	 vegwmeYftRAQRpGj+mbrVCoa73kE1MvveCLTCOuLECI7EdIynIt2YmiCRYmpyO0v40NH8
	 1oIXSoc20XOLBx9Z7masy0ZAhBrETongaeDsMVlv0kJTOVeQ8K9bmJcyWSVU6KJj92FoT
	 R9QXMj3+LcMj7FHRFXre4lrYsH8R5RIK10r0Bjpn3c8j9FBfyxZArO/U7pEBeUFTrtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cYuptatW;
	arc=none smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2DD606A31F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 01:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4B2DD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cYuptatW
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a07078200fso239922b3a.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 27 Oct 2026 18:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793150405; x=1793755205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aLduANwv1S0zzwppHfmO8Zkbjseh7UvsZ5j1k5QDDg4=;
        b=cYuptatWk3AIwuv9NVY3j83Ne4A61NfgI8j3FYTY6xXx/cFjxGfsLVtWCjrLpzKhWp
         25pnxHwRFPtQANPLPSGH6YnFdmPfUI1ByFIlZWoMnzHMztZ/lVvNe2lFch8ihM/BdsN6
         FNlOmF2TkRk+aBvX4uxxQfIaYJXgRnzmG2F5ajawitg5FWu9W7dR7yTKR7GC+WqhGEZT
         ETGOsO4n+ZVDpYbADgdtN5+dXKuTPl6KIeqfT6ijS9xdocn4JqhBpSZVnQixv+DE98XD
         ARMp0gSsgVtXbopws1pGy8qq5vbCPhsXYbXHbbAywwhPtySTAYQULmVzvZ3pHY3rdMA8
         oJ4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793150405; x=1793755205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aLduANwv1S0zzwppHfmO8Zkbjseh7UvsZ5j1k5QDDg4=;
        b=HIXL8c2j/6R+iwzLHc1ITt2FZdzXfBCQwMWmHRd05N6Qdf9ECzEFts0fwqDTj+QcRF
         D5vtEmf6+zzOt+ntcrmtmFfJcUPmE9jdTW7hJjkg5HnIR5/CNWivcOyqrbRgpEjjPbcZ
         ygXEcSXa2zFpGMBA1Yy6QDLp9/qToHJWCKOF37U3qtgJiwrzOp3k3pISIQTrrJJFmeG7
         7HQhzBC3FBYMqwHwPDVfaVqrkTlAEaJYuYNBgOtcguMKl5m+opxzjrFk7cxS5vyLKcZ0
         PQ+PyVVpfzsoOngkHE9+6zJ4Tn2VVLe4q3NBh1yUAqDUanGNJTmZoMV6D45lrbxZTnPX
         o0bg==
X-Forwarded-Encrypted: i=1; AKwUvBwzgGnLrvx7c50v4UGj81+0r6O1TdKQuBp5bpWt+BaVryiuXANYKVy8YZJekzjqEV8Boc7oienI+uNDFCkronbWlqw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLDaEE8CYRULA3U7o31wq1CSwtpitzdgWz/Gv2UD4UHxFfp7ZN9
	hiDL1+uFvmNhdxcgMRXphDG/rzE/G5BkmFcYi3qnxYwZ9iSmSHRy8Qrc
X-Gm-Gg: AYBFou20A7Zm1dULRb62DHU9QYZuaSUXg2bB+skNZBL3CGGIJmYjOqE+LtVg355ESGo
	ryrHZmDCm+iagzQ6B6jyRGS1EtMPj5OW1D08JLFcODp4mi0YImmMw0MP7Hu5hM6GnHl1y245fAQ
	38kdwY8xTkMJmBnvrBemTBUfrjavq1JL3qt1TdrZ8b8+F4BiYKnIAgniZhmpj3yygujf3LnyC/S
	mWje2ydJNZVy7Qn5iPzQEwMvN58rW/hWcNIdkzdthKhoWi+2iH4XsNwkg4ZCxKik5OEwFylDXzy
	bx+kC664QSrfHgW4qYmdQmHOn/ekqVLUPAkX4AROQuQQ5U7NHUA+e87ZzCYvGePYvuXKjZJg2Hk
	JGkguPr6RCKtIulySbWJTQ0BOolUbUcxsH6atcYmYb4NairPvmGQlJkYlhu5Sz4/OEbgn6LyElN
	MOEuzRpVGI2g8ouELL7DtbmnZBGB8UMO7a47s1pdRfCtk+aHyw9Nr98dOIJ38cJvc8K/Mnxk9dI
	fVI7MtFAECIAiAnLEaQmWmQ/EnozzXy+HknCP9sbJ45qpA9pSr7FC/VXwJN+FKQSCG+sPfV9m77
	07rC8bjYWYtN7B8QmQ41kV5wxPRh0g9Lnht0GAJ9DheHgLfONg==
X-Received: by 2002:a05:6300:49c:b0:3dd:a197:735a with SMTP id adf61e73a8af0-3e902392eddmr613544637.51.1793150405474;
        Tue, 27 Oct 2026 18:20:05 -0700 (PDT)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd8ccc8f97esm3272997a12.19.2026.10.27.18.20.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 18:20:04 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>
Cc: stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2] selftests/ftrace: Add missing spaces after ! in probe syntax tests
Date: Wed, 28 Oct 2026 10:18:49 +0900
Message-ID: <20261028011923.2050009-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261025075044.1750113-1-jaewon8868@gmail.com>
References: <20261025075044.1750113-1-jaewon8868@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the missing space between ! and grep. Otherwise, the shell tries
to run !grep and reports "!grep: not found". This always skips the
conditional checks without checking for kernel return probe argument
support.

Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
Cc: stable@vger.kernel.org
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v2:
- Add Fixes, Cc stable and Acked-by tags as suggested by Masami.

 .../selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc  | 4 ++--
 .../selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc    | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index 384209968325..70751573e8de 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -33,7 +33,7 @@ check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
 
 check_error 'f vfs_read ^$arg10000'	# BAD_ARG_NUM
 
-if !grep -q 'kernel return probes support:' README; then
+if ! grep -q 'kernel return probes support:' README; then
 check_error 'f vfs_read $retval ^$arg1' # BAD_VAR
 fi
 check_error 'f vfs_read ^$none_var'	# BAD_VAR
@@ -100,7 +100,7 @@ if grep -q "<argname>" README; then
 check_error 'f vfs_read args=^$arg*'		# BAD_VAR_ARGS
 check_error 'f vfs_read +0(^$arg*)'		# BAD_VAR_ARGS
 check_error 'f vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
-if !grep -q 'kernel return probes support:' README; then
+if ! grep -q 'kernel return probes support:' README; then
 check_error 'f vfs_read%return ^$arg*'		# NOFENTRY_ARGS
 fi
 check_error 'f vfs_read ^hoge'			# NO_BTFARG
diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
index b0e6b80ccb01..06efa67e01ff 100644
--- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_syntax_errors.tc
@@ -108,7 +108,7 @@ if grep -q "<argname>" README; then
 check_error 'p vfs_read args=^$arg*'		# BAD_VAR_ARGS
 check_error 'p vfs_read +0(^$arg*)'		# BAD_VAR_ARGS
 check_error 'p vfs_read $arg* ^$arg*'		# DOUBLE_ARGS
-if !grep -q 'kernel return probes support:' README; then
+if ! grep -q 'kernel return probes support:' README; then
 check_error 'r vfs_read ^$arg*'			# NOFENTRY_ARGS
 fi
 check_error 'p vfs_read+20 ^$arg*'		# NOFENTRY_ARGS
-- 
2.43.0

