Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ED247CC82
	for <linux-trace-kernel@vger.kernel.org>; Mon, 11 May 2026 18:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523926; cv=none; b=R1P4j17TffWHZwh6dG0VYoshoYfbebSslPVKMNmWrTEcIxRXVlFxw638Vfgf+04j27muIAZxtBuReXv9uXUXHf+YPSjZL+vi+EtXlFUAJx7v+7bMyU3EcjUhnnsxY+w+8wtmBBDl7Un6hmYLPtKapvWXBCl661j5f+jc3eoEHBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523926; c=relaxed/simple;
	bh=x0N3Y2QenibRrFuO3zhAz0CXTVqKQaqnYOVYAIRkZ5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cL3TQf+bnI6zPm+L2lx86tqlCaDWYEc8yEhj1J3uYe2mDZoZWyj2iPs5pIH6ngG/uVQ+oHmGo3DApTfXpngC5jUIMOB6FHP7VIgY+YLFrn5C1/Kovt25M6vUU++Bh8vLxmOfCfA9ji3QxYPEPaPkgR699YLaPnjLgcJAU8dWfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a90M5aGG; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a90M5aGG"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778523923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X15e0nlHXpxQx401W4O6S+WSF172wMdASqEezgkf+IU=;
	b=a90M5aGGZF8zuIg8yOmnsadCo9ca3ya/GpYjw38DbjyYjcAcFYWTmaPa0TC2bcMpJrbuhm
	Jl3SyK6A+0c8lr6Qkj4pu/OCKz7Xo/W+n5gxlAtlpFycj3qBnqSe5P1h2csNxXnHUakLT+
	G/Ea4nB55raT6WCSZUAzjJvQ6u7hRGU=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [RFC PATCH v2 03/10] selftests/verification: fix verificationtest-ktap for out-of-tree execution
Date: Tue, 12 May 2026 02:24:49 +0800
Message-Id: <7368ee25b1b45c92beb14c05be366b71da585ca4.1778522945.git.wen.yang@linux.dev>
In-Reply-To: <cover.1778522945.git.wen.yang@linux.dev>
References: <cover.1778522945.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

verificationtest-ktap used a CWD-relative path (../ftrace/ftracetest)
and a relative argument (../verification) for --rv.  This works when
the shell changes into the verification directory first, but breaks
when the script is invoked directly - e.g. by the kselftest runner or
vng - because the working directory is the kernel source root, not the
script's own directory.

Fix this by computing the script's directory from $0 with cd/dirname/pwd
and using absolute paths for both the ftracetest invocation and the --rv
argument.  Also export the directory to PATH so that check_requires in
the ftracetest framework can locate helper binaries.

Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/testing/selftests/verification/verificationtest-ktap | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/verification/verificationtest-ktap b/tools/testing/selftests/verification/verificationtest-ktap
index 18f7fe324e2f..456b8578a307 100755
--- a/tools/testing/selftests/verification/verificationtest-ktap
+++ b/tools/testing/selftests/verification/verificationtest-ktap
@@ -5,4 +5,6 @@
 #
 # Copyright (C) Arm Ltd., 2023
 
-../ftrace/ftracetest -K -v --rv ../verification
+dir=$(cd "$(dirname "$0")" && pwd)
+export PATH="$dir:$PATH"
+"$dir/../ftrace/ftracetest" -K -v --rv "$dir"
-- 
2.25.1

