Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF4620C463;
	Tue, 10 Feb 2026 09:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770717265; cv=none; b=fk7NuHNXjZU+DxWM6rGgNiVEffXtCtM+cB91js4ndE/g5AJiFsH6eQnoeZXMxIZfU7oEB4VRjrY9uQWXRWqa750zrcuASAIdXroHNAAwpyDKy8Ls4h88Tq8Pl1i/lAafJfndu6wjkRPgfGaTcFfuDMbA8axim8Hr1XKbZWgsnpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770717265; c=relaxed/simple;
	bh=H5OQ2Gpu86hVunVJINYHrefqniEWtsXdV3w6gqszbc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+VpSpmSfevS3bziA54fnubQvL2UY2Bz/qTQvFKndr7e9cmP0GiyHE5g6fZP4woUXjuYRt8mVw0FXQwnIqld0h3BOcnikx3j+zEc4itPnff4A33Yp+kfubJCDRQ6utryWlR/vUxb/kXtzVsXgZz2wlXYeQntlPqyvegfbzvCbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZ7bPtZ2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZ7bPtZ2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B21C19423;
	Tue, 10 Feb 2026 09:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770717265;
	bh=H5OQ2Gpu86hVunVJINYHrefqniEWtsXdV3w6gqszbc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lZ7bPtZ2bL6zPSIJsr9aCDm4mcqcZ2A9wRmSJgZ6Qb23Ru5DtFxLFGFA2XJwZktSf
	 p6+KLbMy7VF/fT8ZmLDKiBHNW0GN0bCpMx9ALzZq/t6U76E0NobcRtmSrgPZR/EmSM
	 gXvdaC9IQ0iCeKGJcTaKFgFOiNAVQ3NjV7BOcPnbnOHS4By4aF/IKGU1DJGKjv/q4u
	 Tyff9AtUCheI0SOww/dSuwD8GulKBPVe2+kpJFGOIex3CVFFDI6cV1BEGTYq5UZFHH
	 IM8PPo0qCTjn2bXK9XKg+D7U9pApCCW9unhTsHPEkxUfmHiTQvqDOrGDeAbShE0kQX
	 WQ4/IBDqHcjRw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 2/2] selftests/tracing: Fix to check awk supports non POSIX strtonum()
Date: Tue, 10 Feb 2026 18:54:22 +0900
Message-ID:  <177071726229.2369897.11506524546451139051.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
In-Reply-To:  <177071725191.2369897.14781037901532893911.stgit@mhiramat.tok.corp.google.com>
References:  <177071725191.2369897.14781037901532893911.stgit@mhiramat.tok.corp.google.com>
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

Check the awk command supports non POSIX strtonum() function in
the trace_marker_raw test case.

Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 .../ftrace/test.d/00basic/trace_marker_raw.tc      |    2 ++
 tools/testing/selftests/ftrace/test.d/functions    |    4 ++++
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index a2c42e13f614..8e905d4fe6dd 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -4,6 +4,8 @@
 # requires: trace_marker_raw
 # flags: instance
 
+check_awk_strtonum || exit_unresolved
+
 is_little_endian() {
 	if lscpu | grep -q 'Little Endian'; then
 		echo 1;
diff --git a/tools/testing/selftests/ftrace/test.d/functions b/tools/testing/selftests/ftrace/test.d/functions
index e8e718139294..41325f387ee7 100644
--- a/tools/testing/selftests/ftrace/test.d/functions
+++ b/tools/testing/selftests/ftrace/test.d/functions
@@ -173,6 +173,10 @@ check_requires() { # Check required files and tracers
     done
 }
 
+check_awk_strtonum() { # strtonum is GNU awk extension
+    awk 'BEGIN{strtonum("0x1")}'
+}
+
 LOCALHOST=127.0.0.1
 
 yield() {

