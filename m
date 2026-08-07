Received: from va-1-113.ptr.blmpb.com (va-1-113.ptr.blmpb.com [209.127.230.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2090274B5F
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Aug 2026 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.230.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786090557; cv=none; b=XtrYvnZbwzgSMdCtStDOusX+CFhT6wCXeyN/R2vnpLZyhmnYF4zRtKdyi7t4zrGpl5Nk3aL3qQFxg8QdXKNlmVqhl/x2DQJbjcItYdL1nKEdTHvzuPkKu3EnhudXEA3aPLBGuMgWBjLaY2/k0g70n8yLTaeKWsLwl20kg+/qW1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786090557; c=relaxed/simple;
	bh=A3hxkj0mnENhQepTkY8vMZbzVGgYvfElGjjdeNE53CU=;
	h=To:From:Mime-Version:Cc:Subject:Date:References:Content-Type:
	 Message-Id:In-Reply-To; b=oXO6+O+deYXMcd5+VZu2LuXDv5sCElULW2uAEn7VGrB3E4bJWC+wYUAqHehOzbOd8Y8SmTAkWwZg0ygTftU5k4XjccknyAocwH2kSgXDyiHc15g3IK7SquWba/z4sTDv88OqER+SZ1TllJL21v1WofcTOcO+C5kCmYXR+MXM/Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=XZHKugL7; arc=none smtp.client-ip=209.127.230.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="XZHKugL7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1786090549; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=+XWYCvGW0LNdiKWYNV9u+HmtX/DOjOYu6CEy4SzeiMU=;
 b=XZHKugL7d+aapQKm2ydxhlv0rw1SqK2HmKv7aA4f8ULmntckHfDgTwHtGjnjqbTZ6W2O/o
 o40qF140HbkDElNqRBwRMr85irRYdANKSuH0/pwAnyCdeocdoJPwi94by6Sh9/ZioPnkqR
 j6tdIoyQZ1R5cAU9HyHDryFD4/h6rJO9H9fSZeKqmhBhYQQZi8iTJWu9a2S7jRfLWla8CJ
 TH8OtrtSCvy+yh/bm3U6Qk07zX/s5qR0WWeozhsvh6axbb2miE5/vCRg00z4FbD7l8yDh6
 Gitndm5l14xTa+50G3lb0F4xBgTOWLtHd4RWcj1XINt1wn2GK00I9ATHeytrUQ==
To: "Steven Rostedt" <rostedt@goodmis.org>, 
	"Masami Hiramatsu" <mhiramat@kernel.org>
X-Lms-Return-Path: <lba+26a75942f+300c30+vger.kernel.org+qirui.001@bytedance.com>
X-Mailer: git-send-email 2.20.1
From: "Rui Qi" <qirui.001@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: "Mathieu Desnoyers" <mathieu.desnoyers@efficios.com>, 
	"Shuah Khan" <shuah@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, 
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>, 
	<linux-kselftest@vger.kernel.org>, "Rui Qi" <qirui.001@bytedance.com>
Subject: [PATCH v2 1/2] selftests/ftrace: Force C locale in ftracetest
Date: Fri,  7 Aug 2026 16:15:11 +0800
References: <20260806083101.2651025-1-qirui.001@bytedance.com> <20260807081512.2974757-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Message-Id: <20260807081512.2974757-2-qirui.001@bytedance.com>
In-Reply-To: <20260807081512.2974757-1-qirui.001@bytedance.com>
X-Original-From: Rui Qi <qirui.001@bytedance.com>

Some ftracetest test cases parse command output by matching English
field names. Tools such as readelf may localize their output via
gettext, while ftracetest currently inherits the user locale from
the environment.

If a translated field name is printed, parsing can fail even though
the tested kernel behavior is unchanged. For example, add_remove_uprobe
can fail to find the ELF entry point and then write a uprobe event with
a missing offset.

Export LC_ALL=C in the top-level ftracetest runner so every test case
gets stable command output by default.

Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
 tools/testing/selftests/ftrace/ftracetest | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/ftrace/ftracetest b/tools/testing/selftests/ftrace/ftracetest
index 8ad2c385407e..246d7e1d015c 100755
--- a/tools/testing/selftests/ftrace/ftracetest
+++ b/tools/testing/selftests/ftrace/ftracetest
@@ -7,6 +7,9 @@
 #  Written by Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>
 #
 
+# Keep command output parsing stable regardless of the user's locale.
+export LC_ALL=C
+
 usage() { # errno [message]
 [ ! -z "$2" ] && echo $2
 echo "Usage: ftracetest [options] [testcase(s)] [testcase-directory(s)]"
-- 
2.20.1
