Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0592D471265;
	Tue, 21 Jul 2026 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664419; cv=none; b=prDyLWt5I/WvDzd5P4s0CFr+rOhx76V5eEQMwrhnC+qfrCOOTdYnfLID3i9NxJZSN/lUtWa+YAhTgON+VQ7qbAVGjUPG1E7rl3BJZZqU4uzv0qbN18fOow0q/hQ5qKCUnNf3GBRU0nruzbIDfFXZxgUmhR9jfH7wX1vuuPZMgFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664419; c=relaxed/simple;
	bh=4vtiVO6EBJ14VnSGK6Xjq0LKSP7NwzXM5F9gL2KrXL0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=p7bgTUOo4M1mkx16zE2WloDXRBTU1GmcLFdX6GABYkZy8j+iACOz1vSfrLe6zFwI3QGx1aF1WxWc/RSI63bIZK+yXjb3fuYuA0LWd5/NUz87rqwUAo1RGRh+b+qdYcYrYxTJhsH5ZNWlqcdEYaqva3JmyTlFF8qgeugr59c6+Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-209-184-216.092.209.pools.vodafone-ip.de ([92.209.184.216] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wmGjl-000000023vq-1qeh;
	Tue, 21 Jul 2026 22:06:45 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	oe-lkp@lists.linux.dev,
	lkp@intel.com,
	Martin Kaiser <martin@kaiser.cx>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH] selftests/ftrace: allow relative paths in eprobe test
Date: Tue, 21 Jul 2026 22:05:59 +0200
Message-ID: <20260721200612.1749777-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The add/remove eprobe test installs an eprobe for the openat syscall,
runs ls and checks the filenames that were opened.

Commit 206b25c09080 ("tracing: eprobe: read the complete FILTER_PTR_STRING
pointer") fixed access to some string fields in eprobes. This allows for
dereferencing more filenames. In some cases, the log now shows a file
with a relative path instead of "(fault)". A relative path makes the
test fail.

Relax the filename checks to fix the test. Allow shared libraries and
locale configs that use a relative path.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202607151010.b68428e1-lkp@intel.com
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 .../selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc      | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
index c300eb020262..baceeca7ccdf 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/add_remove_eprobe.tc
@@ -22,7 +22,8 @@ ls
 echo 0 > events/eprobes/$EPROBE/enable
 
 content=`grep '^ *ls-' trace | grep 'file='`
-nocontent=`grep '^ *ls-' trace | grep 'file=' | grep -v -e '"/' -e '"."' -e '(fault)' ` || true
+nocontent=`grep '^ *ls-' trace | grep 'file=' | \
+	   grep -v -e '"/' -e '.so' -e 'locale' -e '"."' -e '(fault)'` || true
 
 if [ -z "$content" ]; then
 	exit_fail
-- 
2.43.7

