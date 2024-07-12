Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FA365C;
	Fri, 12 Jul 2024 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720743982; cv=none; b=ah7UJoXPnh7cg/c0FiU938c+1tjthyp8lpC0ksuSQTORKoqt+m6h4qZaN8g/GY2YGh/NC1VN4vcuKqGlKgML4/8POII+R3B/WCDdjrWPMPfSe14Ks47yi1kICfk1Op8qNdmR2DKAOS5SsJPS+2GbIjBnxIL5IxA0vpJL1/1D/oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720743982; c=relaxed/simple;
	bh=tcjaljc4aW6IIF4cwuOvuFpMZ2MFM5h6S1WD5xZ04/Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JDsAkoirClS5K6mwgu+SXSMdyjf8BHOLusTTYf9/B5zzjenoWb6/ktyAZ/W7h/u81zCUpKHGR4iHXRHdYHnqfVsU9GgpgoC3ScVt/xYpKWTi5KSq7L2LrNSgQoWBClyHJle2XzOajl0xfZadVgU2wG1n14X0i/NY8rXk6LtcoWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1XUhk/9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1XUhk/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67487C116B1;
	Fri, 12 Jul 2024 00:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720743981;
	bh=tcjaljc4aW6IIF4cwuOvuFpMZ2MFM5h6S1WD5xZ04/Q=;
	h=From:To:Cc:Subject:Date:From;
	b=N1XUhk/9gQ6JqglvEfvtwNFyKI09e3nUJqakN0mJjxILWel5y3RAPhxrSPjctEtmv
	 Cwcf3esxKSCBWkLPofj9mRuP8MxPD8K876TdonJdrJIy995aA3Gj977pg+ActmdKgD
	 v8EIbBOEUP5+CNH7zkXQe8fncABk3NR65SmnjjwLfjhpHJWHOoYqcTvXexZCMqYahB
	 LYSeotYbwxOljoX+5L0pZalX8r62a8u+USMYGSuhsAh4vftiHL+AGVPLuSBHJztWw/
	 ELTeB3i51/SRmxA8sVNJD7f6VJUhjjZoM63o+ydAS9DNQ+fZsVdIfTqhCNGtwAbLxH
	 9ysutF+QdZcnA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	mingo@kernel.org,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add uprobes entry
Date: Fri, 12 Jul 2024 09:26:17 +0900
Message-Id: <172074397710.247544.17045299807723238107.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
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

Add uprobes entry to MAINTAINERS to clarify the maintainers.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 MAINTAINERS |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index da5352dbd4f3..ae731fa2328c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23105,6 +23105,19 @@ F:	drivers/mtd/ubi/
 F:	include/linux/mtd/ubi.h
 F:	include/uapi/mtd/ubi-user.h
 
+UPROBES
+M:	Masami Hiramatsu <mhiramat@kernel.org>
+M:	Oleg Nesterov <oleg@redhat.com>
+M:	Peter Zijlstra <peterz@infradead.org>
+L:	linux-kernel@vger.kernel.org
+L:	linux-trace-kernel@vger.kernel.org
+S:	Maintained
+F:	arch/*/include/asm/uprobes.h
+F:	arch/*/kernel/probes/uprobes.c
+F:	arch/*/kernel/uprobes.c
+F:	include/linux/uprobes.h
+F:	kernel/events/uprobes.c
+
 USB "USBNET" DRIVER FRAMEWORK
 M:	Oliver Neukum <oneukum@suse.com>
 L:	netdev@vger.kernel.org

