Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2588B155757;
	Wed, 10 Dec 2025 01:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765331256; cv=none; b=eoKL6jLdSf/h9r81/hUg5JLLVQxqgMWfg+xwtk/IzButoRpNQvdv2lNF0XKSEBqtsgTUt+t1Qa3nbqEQm6Sbdx89QBKvzn0+q+dJgY8TZl7Mh5VslA+JWrdac34EvSZfvad2QR9AE8CH5CMTUNQnH2YAy4/qrb1t30lm8I6M9zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765331256; c=relaxed/simple;
	bh=9VSo+M1Wv2/l7UlB3HX+jwwxn5jZBgxe9ULB2+q9iDw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=IKRRj2Ha+A2JyT6O2hl03GouJfgcvMMdUyQ487dxAxu6qPFemMeMvQHIUbNrnbcJAygGNoyzGqEK0wOF7fftOMyI/JJciCb+UeSABLv85nBvEZStZLySIltZqaWG37ehEC9Qub8jwwBYyU8VNWVGHHKHOiW7Wofvbo+EUg6LcgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 6BEE9C038A;
	Wed, 10 Dec 2025 01:40:31 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id BA3E820024;
	Wed, 10 Dec 2025 01:40:28 +0000 (UTC)
Date: Tue, 9 Dec 2025 20:40:23 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2] tracing: Fix unused tracepoints when module uses only
 exported ones
Message-ID: <20251209204023.76941824@fedora>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: BA3E820024
X-Stat-Signature: 3cqatinwmbk1z5qzow3ohrkpyw8qh3sg
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18ADvmPIdavuv7q6zc9ROOKZZj9zbYL2yU=
X-HE-Tag: 1765330828-821864
X-HE-Meta: U2FsdGVkX19jHATaCrata43/RTHIVar5jB6xi8j1yG5q590RfKXGVUsTy7bv5RIEXM8jtIcPeSeQOOvSemy2whGMyb0/IWHwQ3SRciLb7aV4jEgaYTBrJ6PIlYTCLYFEUKPJ9LahuEDnOPJoY1a3drFvMSEt7b2LOjzlrvg7bcsQGjCWW5/UWxxH5Krl+IHMmObAXJ8A23hr5e2k3aRCe0pUX9HItYMWud+VdskHWtEq9w2Z7vw5bGc3BGttGhmcXztKRW/Z4Ic6fKMshuxiEmBNbNJP8x3uUSnI6wJY6XY1bkuIifO8Nvw0VnQ9EjUEPEqG3Q8qEYlA9c1WDuxtKht2wLV6E9llddphDbeLBvFdx7XrWVsHxo1XF0sfCyDSmp5Ps82ukUW7zfVpiTxi9DMcFBtFXaYvOrBb/2lyvZ1E8yW+ohJxoWnPQ9j2WTqgvpLNAO8J01QmSwLvnlr0BQ==

From: Steven Rostedt <rostedt@goodmis.org>

Building the KVM intel module failed to build with UT=1:

no __tracepoint_strings in file: arch/x86/kvm/kvm-intel.o
make[3]: *** [/work/git/test-linux.git/scripts/Makefile.modfinal:62: arch/x86/kvm/kvm-intel.ko] Error 1

The reason is that the module only uses the tracepoints defined and
exported by the main kvm module. The tracepoint-update.c code fails the
build if a tracepoint is used, but there's no tracepoints defined. But
this is acceptable in modules if the tracepoints are defined in the vmlinux
proper or another module and exported.

Do not fail to build if a tracepoint is used but no tracepoints are
defined if the code is a module. This should still never happen for the
vmlinux itself.

Fixes: e30f8e61e2518 ("tracing: Add a tracepoint verification check at build time")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://patch.msgid.link/20251208085336.6658743c@debian

- Just fixed the change log for grammar and spelling erros (Mathieu Desnoyers)

 scripts/tracepoint-update.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/scripts/tracepoint-update.c b/scripts/tracepoint-update.c
index 7f7d90df14ce..90046aedc97b 100644
--- a/scripts/tracepoint-update.c
+++ b/scripts/tracepoint-update.c
@@ -210,6 +210,9 @@ static int process_tracepoints(bool mod, void *addr, const char *fname)
 	}
 
 	if (!tracepoint_data_sec) {
+		/* A module may reference only exported tracepoints */
+		if (mod)
+			return 0;
 		fprintf(stderr,	"no __tracepoint_strings in file: %s\n", fname);
 		return -1;
 	}
-- 
2.51.0

