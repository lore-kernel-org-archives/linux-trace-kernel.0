Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5655274FE0;
	Mon, 19 May 2025 10:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747650481; cv=none; b=kF3lug8J7wqyqFTfatGLuO2QkRcGdrO4BggFnxn+HSM959KzWFH0DhytrFB/T4xNI5d9hVf6kpSw70nWdJZfguFF9k8Pc1XXSZwzPoenyTCIx7WTwWa9MEXfJB4rXEkCyvtBLMP44IvE5E8YwU7cd4+X1hsJ3mNGCbOo7Ph27Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747650481; c=relaxed/simple;
	bh=MRg+w2iH0HGF5UyuFu3lFXx9krIj2AUo3GAFy7nbrK8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MGyIYhDEWsF42C+x7RcdGRdmE/zJ1mkLpO+kfq+Y+2BNmdo+7x0qjuR/sIV8hojIaHvuvuW7W2D2+wbp/8KzQKeVfnJo5h5P/jkFQxCjzFAUSZY/ASq7uDecgjWh/UWoJM6ARMT0QGJpQ3dYRtqUIQQyPnUTNqbBdaGUONFI9Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYkEXF8z; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M7hRSDft; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYkEXF8z";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M7hRSDft"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747650477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=MYkEXF8zUUyFh+d7KZuJrdrBtmW3v5BimLUMGDNz0q8j3IFbcfRVwrPC2dspzTxogqZmOs
	rh/lzgrv4yutrTx/3icvsYN+IHJe7ZTAvtx7WaHfiaYyqtcw7Hg69+3KinzQbbInpJWaW+
	JtiIROE60FvMX0rsNc2VVefVswIuhxzMGMDkEBbHfdJHYbuVWcdueJHQIBbxBozWIycP5x
	nZcpcN8OeCIeTedK6qSIzk60040QBYrkfBLH1nPC4gy/J1qxD6WPUkBEU8tgJXzf3VZuEo
	DHQTtXHvOOcNLZAxcYF/200OtRsAdvbbdnZtwDfHkjRw2WYPq4kFVU9Ie8l9Cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747650477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wd36I9Oi5n/Lmp8CkDPUxkaX/ZJRiNSgqZM9aUNzkIY=;
	b=M7hRSDftHN0daHURzUCpmE4V4bBA+HauTfROnM8EQoPe4UgtlYAiik7OgLDy8fNCEHQsix
	UQZi8giWDiAgdhAg==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v9 08/22] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
Date: Mon, 19 May 2025 12:27:26 +0200
Message-Id: <52dcee4bd4c39389d98f65fc5abd78882feeb10c.1747649899.git.namcao@linutronix.de>
In-Reply-To: <cover.1747649899.git.namcao@linutronix.de>
References: <cover.1747649899.git.namcao@linutronix.de>
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

