Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D177274642;
	Fri,  9 May 2025 08:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778367; cv=none; b=aOTWZ9IErzujaaIOH6AMV/q79DO7dviBhdxu9Qo/kQiraAyqinEhT8Vf0zJo89hKhuczIBhipQaPnTRSYGfYvLBEW74twMmBS1TakzbMJ67uXXeN0wkHwYqTPvnhqtgnHyhYf4qZFV9x5l8TsoZ1RzBWIne9CwBiQ9fAtp1Gqt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778367; c=relaxed/simple;
	bh=MRg+w2iH0HGF5UyuFu3lFXx9krIj2AUo3GAFy7nbrK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1Hhakj3YbNkRAJc799aWMAQ+JUEnwkWqgZj2juZysFKT+QvxiSZBfTLUNdba7K+BRDiK2paLLhkos8lnnThZbsnnZmsCH1WysRJW84n9DLr5tWccxHeG6VJ3Py+1WSTNXsUQ/dlpAH02pQUeh3qoVIpFrQQwtNnHjNMU6/22PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ubmGgcGV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z7maHhHt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ubmGgcGV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z7maHhHt"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746778362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=ubmGgcGVgXZNJXj0IQyYzqK8tLCQO0cz2r86gUIZHX7Uo0rI2OyTVdNYR6bQdof+GJsFeE
	tUc2JNf13Ifm5Le91xqzyi9RsE2nUFh23u5LSqI6FpQXDDqnXm0C9nt0vMKIQMcBifakbQ
	tKSw9VdZOkMCuWEMrPj3NMYI6xvAqLfhjxRQDMz8/6984sisWf3weWUFVeppDPIUVtCQFe
	+7CNARETfUuK0Xwe27irzfLdx2DyG6jVUNzUPKWzW8EHSr86iSU5G2U1rGKiGm0JRCiW1P
	iJOUIyS7vjq5s/G1YJbfb8h22ffmZDbrCLKPC3YwnW+NqiQUMEaD9pDTSUVHEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746778362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=z7maHhHtS/nXup78PJSAcbj4zLSbAA+dZkVtLbfI5BwW4ZVgHYnK9q2ENKGrSKCfooobhz
	gZU05X1DufTHY3CA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v7 08/22] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Fri,  9 May 2025 10:12:07 +0200
Message-Id: <aae71829c22715c13beedc7e93cb49378c524f33.1746776116.git.namcao@linutronix.de>
In-Reply-To: <cover.1746776116.git.namcao@linutronix.de>
References: <cover.1746776116.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

CONFIG_DA_MON_EVENTS is not specific to deterministic automaton. It could
be used for other monitor types. Therefore rename it to
CONFIG_RV_MON_EVENTS.

This prepares for the introduction of linear temporal logic monitor.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/Kconfig | 6 +++---
 kernel/trace/rv/rv.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index b39f36013ef2..6cdffc04b73c 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-config DA_MON_EVENTS
+config RV_MON_EVENTS
 	bool
=20
 config DA_MON_EVENTS_IMPLICIT
-	select DA_MON_EVENTS
+	select RV_MON_EVENTS
 	bool
=20
 config DA_MON_EVENTS_ID
-	select DA_MON_EVENTS
+	select RV_MON_EVENTS
 	bool
=20
 menuconfig RV
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index e4077500a91d..e25d65fe432a 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -143,7 +143,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
=20
-#ifdef CONFIG_DA_MON_EVENTS
+#ifdef CONFIG_RV_MON_EVENTS
 #define CREATE_TRACE_POINTS
 #include <rv_trace.h>
 #endif
--=20
2.39.5

