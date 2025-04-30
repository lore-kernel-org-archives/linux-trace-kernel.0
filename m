Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D9221ADA9;
	Wed, 30 Apr 2025 11:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746010967; cv=none; b=XAjThduFngL2Rp7MRrdKOW9sKL4UToJ0pIta5hWIpnDPZUOfTxAdnfvRrXhe6kHbscqcaOqFlRV64Ne6dvIsJot8K+8ZGH7LZFHqMzSBlWdBtelivG2B9HI2bLegG2WsQjU8Mg5S5OIq7SbKiEl4URm4rV14WH9AoD+TnqmDjeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746010967; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jm8L4pJNB/05GWHhRxUJDjMTC4SSl9HyHP/+c8X9y8YgE/JCKRUaa/iANWlU2p/l0M4TxtL6TmotNpCNKf1ZPYnCtC9VAo/XXMze2HJWC3oiLzcbPbG9WzfB42fIjI2sbiE2ShU7AzitH3T2zaGjU4hJgxMdu3vx138FHV/B4aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v29CP3VA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oR9Xyp7C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v29CP3VA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oR9Xyp7C"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746010963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=v29CP3VA5Cwq0NqpCPjPnm9y0jEJWHkVNrA/5bK4VJCOX+7njm3DJDlM50oR4m/wJ1sKCo
	6Cips1CiUC7UnkJKVuE3zkKaWQVqDkP5wspIkNTvg/MVhVBCvE+XEvUx6ywIgi5q6z7rYd
	Uub7NawNczSKZC6N8ZcRPdk98EDmJjmnf/kCMQgWurv9ar2KWIreN0pimOUIp2So4Qx2ao
	Bqr08VR5ET5n98gbKCE+DMIahu5hPr9Dp1O8xDrd60GasVWCMkd4yA4UyXp8rmSK8dMsj7
	VMVAq/H7v63Se0kX53N2VOcbL86JcVuNgasVx6umqWUecihXx6FEILI3SNRfQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746010963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=oR9Xyp7CktHqagkFoNgSYf4D6FZaxEX7v9rz6bQ1HuI8ZIjiqS3zGnNQlYwSlrSs/A4OpI
	7t+vItAcuz//wgBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v6 01/22] rv: Add #undef TRACE_INCLUDE_FILE
Date: Wed, 30 Apr 2025 13:02:16 +0200
Message-Id: <a1884da3393d1739d45e29b7cd4f3ac7bf2b8d37.1745999587.git.namcao@linutronix.de>
In-Reply-To: <cover.1745999587.git.namcao@linutronix.de>
References: <cover.1745999587.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Without "#undef TRACE_INCLUDE_FILE", there could be a build error due to
TRACE_INCLUDE_FILE being redefined. Therefore add it.

Also fix a typo while at it.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
---
 kernel/trace/rv/rv_trace.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
index 422b75f58891..99c3801616d4 100644
--- a/kernel/trace/rv/rv_trace.h
+++ b/kernel/trace/rv/rv_trace.h
@@ -129,8 +129,9 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 #endif /* CONFIG_DA_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
=20
-/* This part ust be outside protection */
+/* This part must be outside protection */
 #undef TRACE_INCLUDE_PATH
 #define TRACE_INCLUDE_PATH .
+#undef TRACE_INCLUDE_FILE
 #define TRACE_INCLUDE_FILE rv_trace
 #include <trace/define_trace.h>
--=20
2.39.5

