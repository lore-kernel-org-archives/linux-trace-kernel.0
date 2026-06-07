Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855B02F8EAE
	for <linux-trace-kernel@vger.kernel.org>; Sun,  7 Jun 2026 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780848895; cv=none; b=UVER7hTU3VtjxqIjEcpxUQ3TINBDV2tmV+5uukm8co/zVKPotMtnW8Di4RsGtNA8ICh0Wx7nc8WFwI8sXa+i2Y3JaOypWOV/XsFVgsQVdsdK3zsah4yme5c9BSthjkLR3I6ZzDEyOvNr73t9CpnpmPzaGIOY//JKwczwLoUyiDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780848895; c=relaxed/simple;
	bh=JkxJo6dNe6jFYHOel75fG60DVrvAJzteUGhAf2csoy0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m65XqeYDIZwBSqqMmSkr4atPI6fmTqQaYh1LwkSscOPUAQPAOixoUpRb0PjJSgAuXd4AVM0K9biuknK96knWUoYxowys8p6P0pL9Q5//t86fEx8tTL92H/jUbSRREAHqZz3YzvhsndByiMOUqvUQXS2WMe+mMQqeCmdsxeV8fsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nJZ2ujjl; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nJZ2ujjl"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780848893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EoyB+sUa44vuBiahJB1fQ1ak8jLqjsVekOnEIwN9kqQ=;
	b=nJZ2ujjl0+vVzr1HFkpzS3h/QgtqTxoh9CdmH4/r+c0fr0p6sOI0zVhgonXMnk0GexeTsz
	9aboOPf3iWfWd11J1dUHIy0bBXypBMbLyy2dLsE939cDE9jVokgpiegiZW2O7ZZgAg7UoQ
	HOWrhcCKhmJ9qo4oZQnh1qYs3I/IYPg=
From: wen.yang@linux.dev
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wen Yang <wen.yang@linux.dev>
Subject: [PATCH v3 8/9] selftests/verification: fix verificationtest-ktap for out-of-tree execution
Date: Mon,  8 Jun 2026 00:13:56 +0800
Message-Id: <95e700c62601cf432842269d89a86a492d073f0e.1780847473.git.wen.yang@linux.dev>
In-Reply-To: <cover.1780847473.git.wen.yang@linux.dev>
References: <cover.1780847473.git.wen.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Wen Yang <wen.yang@linux.dev>

verificationtest-ktap used CWD-relative paths which broke when
invoked outside the verification directory (e.g. via vng).

Resolve paths via realpath "$(dirname "$0")" so the script works
from any working directory.  Accept an optional subdirectory argument
interpreted relative to the script's directory.

Suggested-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Wen Yang <wen.yang@linux.dev>
---
 tools/testing/selftests/verification/verificationtest-ktap | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/verification/verificationtest-ktap b/tools/testing/selftests/verification/verificationtest-ktap
index 18f7fe324e2f..055747cef38a 100755
--- a/tools/testing/selftests/verification/verificationtest-ktap
+++ b/tools/testing/selftests/verification/verificationtest-ktap
@@ -5,4 +5,6 @@
 #
 # Copyright (C) Arm Ltd., 2023
 
-../ftrace/ftracetest -K -v --rv ../verification
+dir=$(realpath "$(dirname "$0")")
+testdir=$(cd "$dir" && realpath "${1:-.}")
+"$dir/../ftrace/ftracetest" -K -v --rv "$testdir"
-- 
2.43.0

