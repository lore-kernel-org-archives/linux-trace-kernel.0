Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAC6221277;
	Mon,  1 Jun 2026 02:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780281185; cv=none; b=X2kWzKCjj++3VO7GpcmnhiYsKw0T1oEAPF06y7uv8sbQJAg5exAznc19mzJunistzeTRBygclul5TKJL4oqP4rPfRtpLmsSUQmJ/bDcgHvxD0TOd7ZSWxyMW5EPUTGOISsdHOKTk0e1owxR20W3kCOEoyQghvQI5KgMIzbiRNTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780281185; c=relaxed/simple;
	bh=9ChulMQ4HtwDaNNSM6XekXLk7VY4BhagcCO1SkNrBkI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iTbHutJmG+Ulo/HMzvO/vqugPnOZ9FfUteQUmYY/nq63a7FRUiu/VBpF3QIb6RhNZfAcxUY14uU2MhlTkOw67XVy6tXP21msrWj0H/Y5Mu4kk8w0spoPEd7s4gJgYzgzLjxVNSQ7kyqcAUykjMkF/LRvFDdBYK//Cr/4UiCFFx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qXxiuJeb; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qXxiuJeb"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780281179; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nzR0aLCA9B2xvAkabMir/P0TKLQ1O0jOUYJXMmo9WcQ=;
	b=qXxiuJebWbP96FMXs1UsluMRU5pzNWU0/GT/em9eZjroRCCijuU7VSAz5kVRMO/jXf9mdVIHaGcO5z6mhlwh2TBw6ypOmekOEdAEODDYlHtJRqPQ1RgVZpiDH3Gk97qM8oD+QcPg6ecdL/xZ/xO0KuSaKqGZTSLpZxKAsx+/RuM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R461e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X3vJxdj_1780281171;
Received: from localhost.localdomain(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0X3vJxdj_1780281171 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 01 Jun 2026 10:32:59 +0800
From: Tianchen Ding <dtcccc@linux.alibaba.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3] selftests/ftrace: Fix trace_marker_raw test on 64K page kernels
Date: Mon,  1 Jun 2026 10:32:51 +0800
Message-Id: <20260601023251.1916483-1-dtcccc@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
References: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On ARM64 kernels with 64K pages, the trace_marker_raw test fails because
bash's printf builtin uses stdio buffering which splits output into
multiple small write() calls to the tracefs file. Since each individual
write is within TRACE_MARKER_MAX_SIZE (4096), they all succeed, causing
the "too big" write test to incorrectly pass.

Fix by writing through dd with iflag=fullblock to guarantee a single
atomic write() syscall to trace_marker_raw.

Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
---
v3:
Measure the binary length via wc -c instead of hard-coding "size + 4".

v2:
Update comment about 64K pages.
---
 .../ftrace/test.d/00basic/trace_marker_raw.tc      | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
index 8e905d4fe6dd..f985ff391463 100644
--- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
+++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
@@ -36,15 +36,23 @@ make_str() {
 
 	data=`printf -- 'X%.0s' $(seq $cnt)`
 
-	printf "${val}${data}"
+	# Return escape-sequence text (e.g. "\003\000..."); the caller
+	# converts to binary. Shell command substitution strips NUL bytes,
+	# so the binary form cannot survive being captured into a variable.
+	printf '%s' "${val}${data}"
 }
 
 write_buffer() {
 	id=$1
 	size=$2
 
-	# write the string into the raw marker
-	make_str $id $size > trace_marker_raw
+	str=`make_str $id $size`
+	len=`printf "$str" | wc -c`
+	# Pipe through dd to ensure a single atomic write() syscall
+	# on architectures with 64K pages, where shell's printf builtin
+	# uses stdio buffering which may split the output into multiple
+	# writes.
+	printf "$str" | dd of=trace_marker_raw bs=$len iflag=fullblock
 }
 
 
-- 
2.39.3

