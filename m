Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E49B2686A5;
	Mon, 12 May 2025 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747047081; cv=none; b=Ns/A7w6l5tGiYiVKOVoTrnvm8wMuyBiA0BaW3J+DOVTFA2b8IYaZCqSjXCIVNle4lOrmeu7xqXjUBOXDuDcgHNyk7Jn4MhnE2WZdulErv9r/wpo/Tg1Ju/poy2edPbkU1bdDtWCwNpJJSN9r1fVG0AzgM0ptN67VNsIY5TXPmVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747047081; c=relaxed/simple;
	bh=MRg+w2iH0HGF5UyuFu3lFXx9krIj2AUo3GAFy7nbrK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pt3ubXcVve0td8Qfg9tI8+RnVUw6A0dkzjwIDabzMP2Lah8LYNmLyKgQwVhyBLEZMbOSfIkegyL+sjuA66bkLyFJQXpZJRfeeeA89O6OMoHNIIqKXXJLnXcCS5CJwU3fm3sA4+r2IgApWvrcVFubeWrcRMtIr6eQ021vWDL46y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SfW10wNy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNw1jZiL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SfW10wNy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNw1jZiL"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747047076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=SfW10wNyvJro8y136y3V2swh0EFLOI7Aw+3dwcNmq4a50qNSSIVcUXgBFAzyeSZb9okmpw
	fAbWiIxXOsZ6fKQBrYyNGhwplvtSRFtNB9w7BCQ1R5rCKChf49D4GdWfyGCWdfhLs8ksE5
	sIoAsBg1n8akk3Qs0pbn0+kh7ZK7ANV3iLc4EQet2DdgG45nnIk05DnTpWHnMPCITjs1g+
	61/eHk7hwBCCmX9cZ1EdFeqwha1o1sl8sVi59uRcRjxXTOF9sX7azTlyWgZAWsiT4WGVcZ
	bcUb1bqgDnwkqADOubyt6D3RQtEGPn4VBmNjnSalkw03XLbxY3QtlGgo7KWP7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747047076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=aNw1jZiL3wtwzmCFGBcefhE6AI2AurwTLJgI8HJ0GRHosh4nGTJ4eyh+zcY7yU09UqOMsO
	TU7SgegbF4nKh+Ag==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v8 08/22] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Mon, 12 May 2025 12:50:51 +0200
Message-Id: <aae71829c22715c13beedc7e93cb49378c524f33.1747046848.git.namcao@linutronix.de>
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>
References: <cover.1747046848.git.namcao@linutronix.de>
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

