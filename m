Received: from serv15.avernis.de (serv15.avernis.de [176.9.89.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CEE1474CC;
	Sun, 14 Jun 2026 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.89.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781429715; cv=none; b=rP5EKrKxWDYJDl0exSUDu6eN0MhCw/o3rtKsQbrrYRi1Ym6zYJpRjYU6AXN7oBl/t9LsfqteJidlCllxKWSIr7DbVIgYC1uU1xKkBgb0luBNgHmgvHGhtQ2TUIUDyUExKmJAnsB9j9ycyctx+972Sy/qw66HF2ScnhU8ee7xI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781429715; c=relaxed/simple;
	bh=kvlhBayuM0LFrweShy60Gb6P+63GddwWc/14Y184eeM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tv+9prV2CbmkVlebEOnkkyCJLXfjhu6bYoBWTPjsBRXZaaD7O9JFakFMy8Qo89kU2WgPwyzYdHSqVPju/JTuuE6YcBGsVVXRhvCGHS/i+oms6EkgTilHxkOKBe2oztBxKu9zWrJV5WzsOigAZMYj7T+b9c2Iq+O9Zo49JyyjlRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umbiko.net; spf=none smtp.mailfrom=umbiko.net; dkim=pass (1024-bit key) header.d=umbiko.net header.i=@umbiko.net header.b=mdnE/Osd; arc=none smtp.client-ip=176.9.89.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umbiko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=umbiko.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=umbiko.net header.i=@umbiko.net header.b="mdnE/Osd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umbiko.net; s=mail;
	t=1781429359; bh=kvlhBayuM0LFrweShy60Gb6P+63GddwWc/14Y184eeM=;
	h=From:To:Cc:Subject:Date;
	b=mdnE/Osd0yHBP/LuVgfSUmDhRm1JP7JRoxuLaHvfFP5DG1WsjESd6j+pQ4QVF8oKP
	 NNicLrNBdFkRLMBLe1biJp14Ou6mUgGPKo/Zi4YVjIrU+KdUXqirrtgyql5pNWOUVN
	 foTImutWoq4lbpOUpuEntSh35ceLtptV7VEdp7zI=
Received: by serv15.avernis.de (Postfix) with ESMTPSA id 40A5BBDE1080;
	Sun, 14 Jun 2026 11:29:17 +0200 (CEST)
From: Andreas Ziegler <br025@umbiko.net>
To: Steven Rostedt <rostedt@goodmis.org>,
	Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Ziegler <br025@umbiko.net>
Subject: [PATCH 1/1] tools/tracing/rtla: fix missing unistd include
Date: Sun, 14 Jun 2026 11:28:51 +0200
Message-ID: <20260614092855.129278-1-br025@umbiko.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 1.4.3 at serv15.avernis.de
X-Virus-Status: Clean

Compiling RTLA 7.1-rc6 with GCC 16 and uClibc as standard library fails
with these errors:

src/common.c: In function ‘set_signals’:
src/common.c:40:17: error: implicit declaration of function ‘alarm’ [-Wimplicit-function-declaration]
   40 |                 alarm(params->duration);
      |                 ^~~~~
src/common.c: In function ‘common_apply_config’:
src/common.c:187:44: error: implicit declaration of function ‘getpid’; did you mean ‘getpt’? [-Wimplicit-function-declaration]
  187 |                 retval = sched_setaffinity(getpid(), sizeof(params->hk_cpu_set),
      |                                            ^~~~~~
      |                                            getpt
In file included from src/common.c:9:
src/common.c: In function ‘run_tool’:
src/common.c:262:19: error: implicit declaration of function ‘sysconf’; did you mean ‘sscanf’? [-Wimplicit-function-declaration]
  262 |         nr_cpus = get_nprocs_conf();
      |                   ^~~~~~~~~~~~~~~
src/common.c:262:19: error: ‘_SC_NPROCESSORS_CONF’ undeclared (first use in this function)
  262 |         nr_cpus = get_nprocs_conf();
      |                   ^~~~~~~~~~~~~~~
src/common.c:262:19: note: each undeclared identifier is reported only once for each function it appears in
src/common.c:370:17: error: implicit declaration of function ‘sleep’ [-Wimplicit-function-declaration]
  370 |                 sleep(1);
      |                 ^~~~~

Restore the missing unistd.h include.

Fixes: <115b06a00875> (tools/rtla: Consolidate nr_cpus usage across all tools)

Signed-off-by: Andreas Ziegler <br025@umbiko.net>
---
 tools/tracing/rtla/src/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 35e3d3aa922e..5c5398d20f40 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -5,6 +5,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 #include <getopt.h>
 #include <sys/sysinfo.h>
 
-- 
2.53.0

