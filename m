Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE228BAB5;
	Tue, 10 Jun 2025 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548647; cv=none; b=nzhg9ZCgA1WhmlXxABkZZIOnQnQfzUy+Kmrhf2Awc2Yz8DczghdYGLa5UpX/NQm+hlFxL2deCE7aSEJvHak0h2xEOythQiC168C5kohQMameCDwKDAkPjdrhFVqFpKC087KHxOHJobVVE7Q+DDFQg2+QPgi3Y1nmdL/AUCp7pgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548647; c=relaxed/simple;
	bh=P5ASf0EaUGdYR16ZALPRODOKdfKYmQIDsIDjyhrkHho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mxepUKjPdkEBA1u8Sz19m8Pu6/VmeHw1HMPKOyRXsYh2sGPNTONBTyTrq5MiVT7wYvuPkS8s8IcFT/r9/vv+LAs8N/wo0W2NDc6wy1H9lk27HiMNCwHr4YoTo6/I9rkd/hV6+AErvfgb7cnzqp1kOgvDabffmZUxvxvKinc/yUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=npXeqWJO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/OLS3/5b; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="npXeqWJO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/OLS3/5b"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749548643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZTQIIl+DZdgGOeBRGyvT6/RVe3muYNTiUdYH5ke2K8=;
	b=npXeqWJO384pgOCDbx0mZrVDbd4FpqX+92vVPJ6L1ZV9dFKkbk5J0LweatZqNehjL79ofN
	G8gixAL282QaYxu5/kCqFYHfcZdT+iIHpY5bFu+41QWva3X3/MxNtNt/7g+sa/RSH1kxoo
	/RYF9LH26ltlhX/IKUf/KsCXW7gLN1E3VTc9e4zUR5zQeQj/YqqmJIdo+fsS/d3gQ47f2O
	mXu0fpLhZ6iM+g+d2te0G7PTKOvPmsOwnsCQyyhxHg7BO7DjqJ4glb+2LNfVlWWBKGFlkJ
	eqSxgQGWNlCK98bgHgtWf9SnNrcxBfvHg30Wa5dd42HodVhptFwQkA1y8yEGoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749548643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XZTQIIl+DZdgGOeBRGyvT6/RVe3muYNTiUdYH5ke2K8=;
	b=/OLS3/5b05ev69eezL9TWyQlZ+f778GpaZdsJOQ+s3tM2M38QzsHl65guSRPiGDR1ZXQLK
	iHSda8VFAmQ8ucAg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v10 08/19] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Tue, 10 Jun 2025 11:43:33 +0200
Message-Id: <1b547a3f9e3f6ecde043dfd754e76c8b58d50a30.1749547399.git.namcao@linutronix.de>
In-Reply-To: <cover.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
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
index b39f36013ef23..6cdffc04b73c2 100644
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
index e4077500a91db..e25d65fe432a6 100644
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

