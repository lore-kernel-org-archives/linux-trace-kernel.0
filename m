Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE7126F467;
	Wed, 23 Jul 2025 06:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753253079; cv=none; b=USBrP87WR83WgZP+GABXWRol7V7nSVfqqBwuslqgOIyqVUWVopkF24nrkCEpOkbGkERfE1tHWsZkkUC4LH0DSZOnR0NgF29SrpQjXyQwy0rqasgcdVkY9Y276AM+FCqpVMK2ym0A1mDKBj4VrqN4srF0QRiPD/YGOTZEHdsGlyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753253079; c=relaxed/simple;
	bh=I3/6S9Q4JL4ymfy4KfW14+bgzgWaBRaN8C64bbCJT6Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vx+s5bmmsMIArqBxzxD7FltFlaHZjDFnPFnLYb9El20WJ/6wCYZdkiy+c7SIyUXbyEFfaWsqhjpmY0uXSHK4WdgxDmSYdfWu+Ch9CavS25rwmee9xljQt1QIxUxb4J5fb7doO2dHKFVdrab54XeZfNvQsKHT1TQdcNdtPHc4GHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TNGswDTb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=THeSdlr5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TNGswDTb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="THeSdlr5"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753253069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pqwf5o73kCLdf5NSJ0f43js37vB+8seX7MGAGCT2bTA=;
	b=TNGswDTbOT0e8famNJaGvss2I73gXRHxqsg6LkRWVXeaRmty0tp9u/MbD/Wva74l9RUegN
	YS5DASkZJrpXN0N6Z6PtcApNNRwm5EGVUD0L0YN/+P8FN9hvbpzYUU3gxpssYZDlW7vdoo
	Voc4BpdG8scS5XW8m3q8uDOGPryoqzzHSL1TtzH0iV7ou2u/C8z8up1jctJ5OzaFv7/VTm
	WN16amcDsphaDErS+SPC8x2COISXr0pOEC95BkNSmiDIK5lbd6qaLMU+ZDFB7JZ9ZvOTXn
	+FF8QmiNmqhYX+kekh+0O1BqGIov7mXIy2X94cb+tpWlbhgfB7IlCYlIq2B3Og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753253069;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Pqwf5o73kCLdf5NSJ0f43js37vB+8seX7MGAGCT2bTA=;
	b=THeSdlr5o68MH5PG86wfUT+Ji+KLjXmCIBt0J5N1PWTo8ELa46jg762dH/VPW2pyPpE4JB
	KHu2TZ0kILh5PUDQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 1/5] rv: Remove unused field in struct rv_monitor_def
Date: Wed, 23 Jul 2025 08:44:19 +0200
Message-Id: <5926497bfb0b12a65f4cffae1d0a20ebf388a6c7.1753252872.git.namcao@linutronix.de>
In-Reply-To: <cover.1753252872.git.namcao@linutronix.de>
References: <cover.1753252872.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

rv_monitor_def::task_monitor is not used. Delete it.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
index 98fca0a1adbc..873364094402 100644
--- a/kernel/trace/rv/rv.h
+++ b/kernel/trace/rv/rv.h
@@ -41,7 +41,6 @@ struct rv_monitor_def {
 	struct rv_reactor_def	*rdef;
 	bool			reacting;
 #endif
-	bool			task_monitor;
 };
=20
 struct dentry *get_monitors_root(void);
--=20
2.39.5

