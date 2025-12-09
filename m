Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3A29463;
	Tue,  9 Dec 2025 00:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765239959; cv=none; b=OIdE9rWfDt5oU5aSChJsPEiCAwl/cfLFeO401cyXxM1oxo+t6BFvzGfpfmzTPGr0kokjaq3tUGR6nZdnzSMmwJ2bFEoA2rRQM1EMIFFDiAOZF+N9Z7RGF0TUp2dTily62GHFQeHc7ItuMZ2StF0OfAr9GH5VjiQ4sbbHDNL7IfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765239959; c=relaxed/simple;
	bh=MvKp8HUxnSz5iPfsCyKJ+NxK08+amtyqTbwY+vm2KAE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Xik+UCJCVWWGPEdya/9WATTEABhL2nj1fckFdXQX/sCUIDIMSm7mmd5LVAUJvgrxTRYSa5EzM9PWNSctiRuzO1y4G8bbzY5EM6pvzasUH8cPePjwddH4SPEJG1s8tpVb1gXx90ZEh5t7G+6aEqKJ2830nc0CdYZKpPMoicdBG1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 435E9C0391;
	Tue,  9 Dec 2025 00:25:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 86AF520016;
	Tue,  9 Dec 2025 00:25:48 +0000 (UTC)
Date: Mon, 8 Dec 2025 19:25:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH] MAINTAINERS: Add tracepoint-update.c to TRACING section
Message-ID: <20251208192544.5f2392a7@debian>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 86AF520016
X-Stat-Signature: 1etj6xgna8ydcfjxdx148aohgtttghwd
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18xS1ghVuZaj61V/HQ22mnKPT9N9ebbIkQ=
X-HE-Tag: 1765239948-317671
X-HE-Meta: U2FsdGVkX184nmm2qi67HOqWloidykM+yUEQ9/H9dQVSYdPHsN4DmciNUPIEoFK/1v8GIXQ6kqmAoTxSAwMYCF+Cza/B7t8Bh8ObMlibsxoFEKgiEe+Tm3aRBfpwmYPTbyCXrOaFklAL3hn9do3B+RIYAwymgUow3QbdTkS2N2Yond38967Q6gsYzdwyEuhdEebeb2mBLSHbGhc/51P0NWbwjQdgWHFvgIpo7dhKKYFdKCRtRKNLLas9d4Aj9JMFsYJVtMDqlWDSHBBBAhusF2e/Ta6j8YGLPRfx4h61oZEvr+qxsmztzDUyIR0cPFpeKo8v07wgs7+1pPW7bCHm7VKHAc/avEg0PILQPOlDpjJIxQE3/gyUaWeQToQbpAoy

From: Steven Rostedt <rostedt@goodmis.org>

Place the file scripts/tracepoint-update.c in the TRACING section.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a15891e21ff9..a6932a5bb91b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26440,6 +26440,7 @@ F:	include/trace/
 F:	kernel/trace/
 F:	kernel/tracepoint.c
 F:	scripts/tracing/
+F:	scripts/tracepoint-update.c
 F:	tools/testing/selftests/ftrace/
 
 TRACING MMIO ACCESSES (MMIOTRACE)
-- 
2.51.0

