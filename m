Received: from serv15.avernis.de (serv15.avernis.de [176.9.89.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B6F30BB91;
	Wed, 24 Jun 2026 03:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.89.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782272431; cv=none; b=i9Z5NaiUC48zMH15Hoq1x/pjo0JL8tkn4zcCKGwbua3QMLOiIZtPPkjE7J7xxZtOoJXmSUsEF9tmFls46jwZmmiA03qT23ptD5S4K1MXvwQ9I3rz+QaTmGZHwUj1SYyCSkUQdNX7PQg3EQu1QbkV90FKO8n+WGCVj2PrivKQytI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782272431; c=relaxed/simple;
	bh=u1hdxE0kDEXJ4eRWqv4JDM7ApFqbXvmMnIcLeT46bSo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S75gk2s/55oKqrI4j2S0FS0lXuCCWMQwdxLWi2DPpW3NssRw95Jyq4akkwfJsdmXTIbOWrI4vE8SJMRKK2YIj8HkmYxZ51twaai17sO7rr+EpnaTbIHdaszHsmSk0L0C/0DqVxcQ1y57LI8x7EZYu4qu6lM8S/QaQpEzfIDWcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umbiko.net; spf=none smtp.mailfrom=umbiko.net; dkim=pass (1024-bit key) header.d=umbiko.net header.i=@umbiko.net header.b=zupYTnB7; arc=none smtp.client-ip=176.9.89.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=umbiko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=umbiko.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=umbiko.net header.i=@umbiko.net header.b="zupYTnB7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=umbiko.net; s=mail;
	t=1782272067; bh=u1hdxE0kDEXJ4eRWqv4JDM7ApFqbXvmMnIcLeT46bSo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=zupYTnB7GfM+obHCsR+irxXcIQcVNVYsic+4fbPxPdBHnlzLCe+7DaVmVua02RGYl
	 npCpjPZq9jOmT+Uhg9ujcPsRNUlWnN6ze9sa+3R0RskScm9m+MllMj95V5mSo7BIEp
	 7EexSkYAk9poALM9VRKcsOBtWxmDox6K3nXDzs8Q=
Received: by serv15.avernis.de (Postfix) with ESMTPSA id C0DDABDE0E98;
	Wed, 24 Jun 2026 05:34:26 +0200 (CEST)
From: Andreas Ziegler <br025@umbiko.net>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andreas Ziegler <br025@umbiko.net>
Subject: [PATCH v2 1/1] rtla: fix missing unistd include
Date: Wed, 24 Jun 2026 05:33:41 +0200
Message-ID: <20260624033342.129970-1-br025@umbiko.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAP4=nvRozLS73PooixqWUhDh19eG6oPLTCSV8HvjhibsTLswtw@mail.gmail.com>
References: <CAP4=nvRozLS73PooixqWUhDh19eG6oPLTCSV8HvjhibsTLswtw@mail.gmail.com>
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

Compiling RTLA 7.1.x with GCC 16 and uClibc as standard library fails
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

Fixes: 115b06a00875 ("tools/rtla: Consolidate nr_cpus usage across all tools")

Signed-off-by: Andreas Ziegler <br025@umbiko.net>
---
Changes v1 -> v2:
  adapt commit message
  correct fixes: formatting
  rebase on current master (502d801f0ab0)

 tools/tracing/rtla/src/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index d0a8a6edbf0c..8c7f5e75b2ec 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -5,6 +5,7 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <string.h>
+#include <unistd.h>
 #include <sys/sysinfo.h>
 
 #include "common.h"
-- 
2.53.0

