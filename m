Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9707C1D6DB6;
	Tue,  7 Oct 2025 01:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759798997; cv=none; b=tOcdiB95D4j0Alzh4phtuzsrdTUqS/krT5B7PBd0MkbRIFHqrDxOqNN8KPd5ZUwtj8A0vxKuWz03HGEZSqH3oKfhMXpLXIFAmMsGvnYFb8hKxoEF9eP5uxRarBM7sGch9GRiii1DlkOZVQLoUqTc/nFRZn0kaYtryeNrRcBmKZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759798997; c=relaxed/simple;
	bh=BRa8Gd95H9mmoLwKVmQDKTdSeZYDimkdScuRqx87pyE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WoauRjhAThP/ydW7X0yHu0S3lUkfz1L7iWsmiP/qQuw7sfgaIZfBW3Yk8crl+8uS7xDK86SRBYrDhOUMQTKvJGOSFje/Cg85gQu+rS1nVWduk53aNv4zDgkHK5sTqdjFiay05sBlSuJd9sojH8nKKJVg0uEvEmyP9r1oBRCp1eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=owAb/ciU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="owAb/ciU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B37C4CEF5;
	Tue,  7 Oct 2025 01:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759798997;
	bh=BRa8Gd95H9mmoLwKVmQDKTdSeZYDimkdScuRqx87pyE=;
	h=From:To:Cc:Subject:Date:From;
	b=owAb/ciUBa3R95r4jes4yCDNVQKVXdP88dYjr9EIa2obNJ64BE8ty5doMMFxtD96r
	 XS0eOyQhfAtZi8tutZhxaoFJYT7wMBTvQhuxLFOtcl8OVyEsjUxnxekZyOxbdWeGHD
	 QAYM4jxj7slL4Gpr6gCt0BBr2sqjqkvi+J3Leq8hr8GSIRNhGmOYjagzt0soYeKa2m
	 /f8X6txzMAuW8YQ5Sma7DIhEFHPhYoj0/9wpvoOcabGPI0HHaQzlBVYQpLbFWc9EPD
	 /qh2GnqoEiIa7EfmfBG2z9B78Ug360q4OCnA7ICY/5YyIlLXyafEdO5Sw7D6IGd+Of
	 oTdH40lRtA96A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Brown <broonie@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Menglong Dong <menglong8.dong@gmail.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [for-next PATCH v2] tracing: wprobe: Fix to use IS_ERR_PCPU() for per-cpu pointer
Date: Tue,  7 Oct 2025 10:03:12 +0900
Message-ID: <175979899246.1800846.1725245135731182727.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
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

Since wprobe uses IS_ERR() for per-cpu pointer, it failed to build.

/tmp/next/build/kernel/trace/trace_wprobe.c: In function '__register_trace_wprobe':
/tmp/next/build/kernel/trace/trace_wprobe.c:176:20: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
  176 |         if (IS_ERR((void * __force)tw->bp_event)) {
      |                    ^
/tmp/next/build/kernel/trace/trace_wprobe.c:177:35: error: cast to generic address space pointer from disjoint '__seg_gs' address space pointer [-Werror]
  177 |                 int ret = PTR_ERR((void * __force)tw->bp_event);
      |                                   ^

Use IS_ERR_PCPU() instead.

Reported-by: Mark Brown <broonie@kernel.org>
Closes: https://lore.kernel.org/all/aN6fTmAjD7-SJsw2@sirena.org.uk/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 - Confirmed that `make allmodconfig && make` passed on x86_64 and arm64.
 Changes in v2:
 - Remove unneeded casting.
 - Use PTR_ERR_PCPU() too.
---
 kernel/trace/trace_wprobe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
index 4b00a8e917c1..98605b207f43 100644
--- a/kernel/trace/trace_wprobe.c
+++ b/kernel/trace/trace_wprobe.c
@@ -173,8 +173,8 @@ static int __register_trace_wprobe(struct trace_wprobe *tw)
 	attr.bp_type = tw->type;
 
 	tw->bp_event = register_wide_hw_breakpoint(&attr, wprobe_perf_handler, tw);
-	if (IS_ERR((void * __force)tw->bp_event)) {
-		int ret = PTR_ERR((void * __force)tw->bp_event);
+	if (IS_ERR_PCPU(tw->bp_event)) {
+		int ret = PTR_ERR_PCPU(tw->bp_event);
 
 		tw->bp_event = NULL;
 		return ret;

