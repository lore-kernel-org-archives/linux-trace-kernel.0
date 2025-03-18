Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF2620CCFF;
	Tue, 18 Mar 2025 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742305156; cv=none; b=jdidCbnBOdhkoeyjXWJ2KrOihdAk6uvJ7/KBbJtbyvjNWeL6GHseqDCwVPPdFvhScI8kARBAf4UahW6prHbtIWqyofvu8QPmCj4sY+n7qi2uT/X+cLCDG9KCGFavYPrAlK9iUlgIzrAFEKOd4YClPwMENBpCKjJVaR3hMBRJ6Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742305156; c=relaxed/simple;
	bh=zapNBJCCUw5qTJ19EUx95jqFWdpFucl2eNrjim6tNn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O9ZiKgemZWU1W309OcUGigkhi854uVOsDtb8yAdmTkiUZU8IYVnvQJegyZYA+T7EDMEQSuUzse5tvwh/o9qjGGq266ElLKyBoGgNQoZWAqjHpGaHuFNFkrhW83e2D6A9pAaiJ5GoIQBkp2108TGn9M9e+x8Cgux2/EUG66Lg36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ljmx2OeO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ljmx2OeO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7488AC4CEDD;
	Tue, 18 Mar 2025 13:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742305156;
	bh=zapNBJCCUw5qTJ19EUx95jqFWdpFucl2eNrjim6tNn8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ljmx2OeOwv3ua7/U5SL9CjAhrc4Q/q9gZRk4xZkC2emDtlO8Jf5YM5IyZd8uP1BBd
	 +WyC5p3JgZ7z6iLdcimfq15wMxHrgKPYanKYIhdhlz8YGwCzuAvQBbF1hKjcVNabKT
	 jOr8kICV2baW1ENiSzLBezfUu7jw6Tz8N3u/F636wQVrZX6StMbgHw93Cg/A1Feret
	 xs5ZimpHEVFmc2P6haeAelAzkuJPuZ8HnzAsqNCAA/IlKIcCtdF6zCErhyul8yo2Kn
	 T5reZ2zoTgI74YpMJhH1iboXquTRx1C8bB7btGSJteAsAB/ZyGAZF/6qsbWfF2/Nt8
	 2QTXPIhItkVxQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 1/2] tracing: Fix a compilation error without CONFIG_MODULES
Date: Tue, 18 Mar 2025 22:39:13 +0900
Message-ID:  <174230515367.2909896.8132122175220657625.stgit@mhiramat.tok.corp.google.com>
X-Mailer: git-send-email 2.49.0.rc1.451.g8f38331e32-goog
In-Reply-To:  <174230514441.2909896.16487286892751735867.stgit@mhiramat.tok.corp.google.com>
References:  <174230514441.2909896.16487286892751735867.stgit@mhiramat.tok.corp.google.com>
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

There are some code which depends on CONFIG_MODULES. #ifdef
to enclose it.

Fixes: dca91c1c5468 ("tracing: Have persistent trace instances save module addresses")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 Changes in v5:
   - Make a nop save_mod() if CONFIG_MODULES=n instead of
     adding #ifdefs around module_for_each_mod().
---
 kernel/trace/trace.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c3c79908766e..68abea81e51a 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6001,6 +6001,7 @@ struct trace_scratch {
 
 static DEFINE_MUTEX(scratch_mutex);
 
+#ifdef CONFIG_MODULES
 static int save_mod(struct module *mod, void *data)
 {
 	struct trace_array *tr = data;
@@ -6025,6 +6026,12 @@ static int save_mod(struct module *mod, void *data)
 
 	return 0;
 }
+#else
+static int save_mod(struct module *mod, void *data)
+{
+	return 0;
+}
+#endif
 
 static void update_last_data(struct trace_array *tr)
 {

