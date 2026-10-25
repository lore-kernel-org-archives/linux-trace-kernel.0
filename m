Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792914649;
	b=fUs34YILmbBkA5XRm7NHVTYpRKthtl6Jf5BXp2aASl0TMDGk+U4QdxQa3LdpAGGuKEKV
	 FQqUU5U7eK5mA7zXEFCccmD3m1DVWomzeWmwhyGJluwL4aAB/KEpcTXjsqriuA1Oe3pGD
	 tIVeiitkYUkHPOu9gIrBgSyw+JiyDmEO/9QUvxU1cRFhClomrYC5PTTpx3ltsyr03I+mx
	 UelSMLv3nraRUJ2dR5ky7s+rVv+u20WJtHanDrVYdHhXG0QEIx+z/MNjBnIKFpmPaiejD
	 RWnDP+hwQcjktTSVXxEOQJ/GXJDuP/82+3CaeUsyXxN1Q5dpXZZSDvJt1Ws8hNQ+NWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792914649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qw8iT3vjQ6v6/N4nQ3kAFOKgih6vtaYdBPaT8XNpq84=;
	b=oYXogaemL8raTZGpTA3XmflL8RhUiVo2M7pQxlkPXK/BrYqhUZU1YqwmAQg0+gSJT8w0
	 7DoxFWQRhEDDbsZXcJ6rKFc++yVxs7SpzaONNH7+Id57Vb8QWHHxY5LPEgJ+uX1yTzCQG
	 09Mza/FOdB+72C2ijAJ8g7tE4rRNkPYgsJpKlemBH9zKfvpqc7p8QZSsHQRa+u1FNM60T
	 KJvEJ4f8bFX8ng+6iMcEhySQ6/0zpu9ZdnRJXXoenTb38z7+HwGkjVlCQGzCQ/1opryER
	 DWGe4NZjrq0AFAwhBZjBy4gf0Lbmrg3vGjqSwS7YPv4ehWWxIPzjtDWCbtmSNjbAn+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZU9D4xZQ;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E11D606A31B
	for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 07:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E11D606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZU9D4xZQ
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35c76e9614aso3365191eec.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 25 Oct 2026 00:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792914648; x=1793519448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qw8iT3vjQ6v6/N4nQ3kAFOKgih6vtaYdBPaT8XNpq84=;
        b=ZU9D4xZQT9lRNzJIr0ql9vXLWN16FNvjZngwe3GrKVd/CkwklZ252VjyPTMyxakg9o
         iacgLUa6eSniXyNb41gMlUTdOtXLYcpdyEMYWEi9nrr0oOzXXSPaeJWbgAcwGXJCcjkM
         Vt+d0vAVPMVhR4/Ywl+vs22ZZbKY2KRzAcdbzVkv5iltNWMglPoPuxxZuTZ3dTclNuXK
         s0yQlT/qzXD3IyFmDukHYBfDX9Id3/D0dWEU8dA5tFBcgE0a7aWc5+a8e4wTLA4mJwIr
         nFXzrg/C5StE0K24XJoBbv40rP3Zvu71CA/gm4JFmbjQqRSKf9QcgOizACAZkxUZhO6/
         SQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792914648; x=1793519448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qw8iT3vjQ6v6/N4nQ3kAFOKgih6vtaYdBPaT8XNpq84=;
        b=Hj8MNYnwkbMQlmGzcFQbVW/hKv1IIq3XleCRv9bRBeNx0HxNNUvlSmwuevKwA6XPcu
         VVIsu8ZBzUM4KyyrBxIhATZVtVTdCz8Lc6S5PPYoszGiwaqgjDI4ecGE4AmF0OdIhXzN
         9/YSzXBwP/aJF27tvljCqjQ4xt0EQoeNYpR2ydHZapTQBCp2N7MZKc7JyQlT0A+ju2v7
         ryK5DCXNuGVMkDkKn1/Uqe6c2zyMI7a+Zk61VI7b9seON4VoIpEsQgUNtCBuFRVGuEHJ
         rgmV8dw2SuA5XrcEtiA1bITZ1nNaEEnvqWEPo4wCU1mgyTjNHg39nFaIvjWwMFKyoy8i
         c98w==
X-Forwarded-Encrypted: i=1; AKwUvBw+65tDjIkMTb6LNBJvvwmVlCB46JPipc5+tBe5egeoGrcpE+LXGNga1cIwGO22gVYOyv6vb7iLu5Xg8DzTGN3dfOc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZ6UTgjavhph/TigxvloN3rTazpwT0kEUOHnzojTTpq4Ifetb4
	3nSF0loNIzr/YuHysEpV+ePrmBB6mX8hbNjlsfK0dSlh/rIflnGJhUNW
X-Gm-Gg: AYBFou3xhOkzlE12gz8x/5Un5hQH6zDe+3t9dZdNEDcvKncjT9SNT1/x/9AwiB6MuXv
	BC1wLXhtomAttHQgTRLuJiMDE8hKSoBW/QWKx2slynm5X68blmcJFe7TIg9iRimJ4xxStA1Auji
	QAcU9e2STxE+bgqm2rWHN0FcvRyiIpKcyJYb9THor+Gm0b2zIYVJyu6dChUEQ1gkybmEHgPeZCa
	gPE6UdNa0YQIrR/yi+C82zjdKME8YHvpD5xS4Uf7Fs0OD0EPu8nq9Uj7zyd2cH5HEbfoHyestjb
	1S9ghCSv4xNRkBgidu8cxCtlf8YXtra0f2tpMKTlnfg8ll7klYqUgeAsG1YqG5NWj1B3nz/jq+P
	/wr8Fr8FYfKUM71TpB2SF/h99tkCT7oUyLr7N59wKdnQoKkgT/fF2k/38fz+ceUrsVOVtRBEt8S
	eeDvHdDLZSfazRQgvuCIHp63FN7oG/eAvrQyziFeGGIvGUKIRH+GSsrG6Mlns9SdaHX3S2cukUG
	7R5TLOPgviQhZW/pyptN8tlDd9KDklXmn5w+mh5NuIkc03ajGKkhv4=
X-Received: by 2002:a05:693c:880d:10b0:35c:ceb0:8bf8 with SMTP id 5a478bee46e88-369e849280dmr5082964eec.9.1792914647783;
        Sun, 25 Oct 2026 00:50:47 -0700 (PDT)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8c572bbsm14791299eec.2.2026.10.25.00.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 00:50:47 -0700 (PDT)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Add missing spaces after ! in probe syntax tests
Date: Sun, 25 Oct 2026 16:50:42 +0900
Message-ID: <20261025075044.1750113-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
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

