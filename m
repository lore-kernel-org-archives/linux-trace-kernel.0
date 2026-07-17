Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D502E1F0E;
	Fri, 17 Jul 2026 02:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256723; cv=none; b=jSx8Bprdk1U43BQ/lxNTqm0i7Me9F1007EhtXdw//eTMUkiuAz52tYTaFFf5BUEu8dzoPdcZu3pNh7OUzwP/ZKof1lMgW3U/G8Duph4r2bG63bUQTBMANzHmvY6bysrFiX9Nrvp6AeXIoN5AzT4NEErqK9rx49Ra5rsZlLI2xGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256723; c=relaxed/simple;
	bh=YO5PRynN+n2gXmSUbrQBjzg51iau9e13HreIUwsu9sA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbSWcccBudhNgaKiKlVAQQUbRJKz0DzpM+HqjNCn4rKz5xCs71ybgBHt/eqOvoNunSvT+lRi85tkEQjnfnwniANV96kK4uSIzqw60QOL7emXOL+9mMNv9hTORr6MGqFNfiTPtZ6nP+mJ1UxtkvNuTSN9rkUY5rYf7DkbAbBZuTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzzFqyJY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzzFqyJY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA2031F00A3A;
	Fri, 17 Jul 2026 02:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784256722;
	bh=ntXphgozdJeqFblQjefKL19i8eFFCrjgVXvVUBFdhaA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mzzFqyJYn9GiTsveD+SMs/8EVUeR0yihIIwDHocnQkDrFD6/WaZnxIlGqTokKh8IL
	 iy6wtY7NM0JtjvXh2pT/wNIOHjO0W+fEjAx6K3fnoUZhCXd0SbdAOnrSbzHgL3j4ZW
	 Imb0l8Z7mbL0NTVxIYdBD3y70q9Ztkpn/MdPKWePtLn5zQRNCJetysERjNOUkt0IXb
	 IC+bp32bOS4MKEXgUGSAL6cpXN0HJPRIYc8WjZgDqg1iXG7uUzLuAxKZrqrhTTVAh+
	 1UHs5zKY2SET9P+6wPb7GFDAkEVkVB2/7gWWzWVENQnzriiNxR0+cX+V5AuCbMeZPt
	 GUD144QrFpQjw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/ftrace: Reset triggers at top level before instance loop
Date: Fri, 17 Jul 2026 11:51:59 +0900
Message-ID: <178425671889.84440.9477850701738666404.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178425669965.84440.3214667180548169854.stgit@devnote2>
References: <178425669965.84440.3214667180548169854.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

When running instance tests, 'ftracetest' creates a new ftrace instance
and runs the tests inside it. Before starting each test, it executes
'initialize_system()' to reset the ftrace state to initial-state.

However, since 'initialize_system()' is executed in the context of the
instance directory, it only cleans up triggers and filters of that
instance.
Any triggers or dynamic events left behind in the top-level instance by
previous failed top-level tests, are left completely untouched. These
top-level leftovers can cause subsequent instance-based tests to fail
or even crash the kernel.

Fix this by executing 'initialize_system()' in the top-level tracing
directory once before entering the instance loop.

Fixes: b5b77be812de ("selftests: ftrace: Allow some tests to be run in a tracing instance")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 tools/testing/selftests/ftrace/ftracetest |    1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 0a56bf209f6c..8ad2c385407e 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -503,6 +503,7 @@ for t in $TEST_CASES; do
 done
 
 # Test on instance loop
+(cd $TRACING_DIR; initialize_system)
 INSTANCE=" (instance) "
 for t in $TEST_CASES; do
   test_on_instance $t || continue

