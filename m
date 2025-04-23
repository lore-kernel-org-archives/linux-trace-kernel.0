Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25FE223DFB;
	Wed, 23 Apr 2025 06:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391041; cv=none; b=Z7G6e/TKoPZUwAzZ/dvApnn9KlHQdAE8+GFDRcg26wzWJbb2dWR74bWcGi7T4S2aqZlAb3Aqu2l8NdwCgOV+qDE4pB1W380nB+VQQ01EYC6N8jyxLjgVQPjxpS5Vxnj6OFak5EdvgJhx9jbODWnhHbNAap9ccxExnBX0cA+FDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391041; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ai93VPH112QVSAZyCftNWMRZoyp1P1LLcxTklijpGhC5xF+Nm+/cn1KuarQAQIdNrKBfrhhc1s9p4as8yqC12R8/bKFYrEU0NcJUKGszxpiCs/QwFNULckHOU5+XnmRALK7qrkBM0Wo4YhmO4iPRkue1oArJ5NXM/G8nFST6wKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M+oK8mcC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tPgFZ0il; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M+oK8mcC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tPgFZ0il"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745391032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=M+oK8mcCxPmkSTRolSOmcElhvwHEgJHBtX5ImHx8qONeIGZo5k6VDGssftg/lz9lULkryL
	Ansv0nNhJMP58zrVa8Ts7gufHquTHsQ8zJhUvNUXWYqedk7j9zFGrydzlJCM5fwnNc5XDp
	RhfruS8gw9cgW+n6ydQGzo1GUiflI466uo8OMPAdHuZBXbCeggGHTj2N2PJ63oP3tFKp5T
	pcxtEwgJkia7yPhfubUMTc6fJL9EyxvbZBQKKikgFcHl0Z08SGC9FnEcLsrnMCVajhK606
	7OXxoM+vA8ixYf787bXHCLMUaraM9FFCZVZ7zuNaabGN0hQUwDw1hc+6oDUiSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745391032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=tPgFZ0ilaz4zAyLrHPnEztzAYkSkSwOcvwohA/VSWh8w6EljxOSvkSVcDevkGrwIYvJ+IK
	uZ+2jZ94fAJC51Cw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v4 01/22] rv: Add #undef TRACE_INCLUDE_FILE
Date: Wed, 23 Apr 2025 08:49:56 +0200
Message-Id: <22e7471794f399a61cafb695c0c388dea10a5976.1745390829.git.namcao@linutronix.de>
In-Reply-To: <cover.1745390829.git.namcao@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de>
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

