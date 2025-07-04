Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93951FC3;
	Fri,  4 Jul 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751635233; cv=none; b=EkfUoKbB/xpoY27qZgXVS1o+tzc5masHnrBCGFbwX3f+LWUbExr4XkUOhiINbceFBgZI8bui7FgCmyMjnZP7XiYn7PPwLqSjiZchMppQvJ/fjxmXyDhSkTeYuHTwoZ1JkTbavQFMzNo04E+B3t9cspx4TNXf+bl3x6xFEXatY4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751635233; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sAO93MicFvNusEgktQ91FWekdzzvS0VYE1RjqngK4wOeJsLdYxssl7la0FPK6XsKRCSo8h0ynUAUi5PGzT14bhpMsgdi5jaXrpW0/yDATu5xdzNvVoRlRmJo6MjdGaCU5qb0IqV6xJ/JkuSr9kID9yIzHsMu4Dxw1lvrwiKWHJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o71t87yN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/xtVsI6x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o71t87yN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/xtVsI6x"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751635230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=o71t87yN4pUXKTRJVq52dE+wQJSMLrSGiHo8JF8xqKOHTKnIQ7r83os7xAdF+WUXyAUWhq
	GeLLRNltLivSDdoVkbqVXsgFJiW+UW1mCykhPYcEom+kqxqO4ST0rk4hJ3Zn7OtupHO3ss
	BEN3MqRi73RHyN8GWx/ThdJqxJdkUPXRD1fMdXUERl0TOF7r2Td+rG/M+WR4laBHlujGf0
	CYtlzRYnhmvNMoAHcOR4nqA71J4zt6WeCDU8pITF/BOjVZYlbw6q+oEIxnYVelNzYuevNk
	i1lTOagS/5DvtKhSiDCeJKEboYDisH0wG5OrLmeYD8KcupBJeF8L+/j6nmUZEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751635230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=/xtVsI6x0OrnCSmxhpCNj4mhbrg49Bnl1hTfCklZkZ5QslphSJ3gkv49IaKFjvau8JvLQT
	60chLHn4eQ7T6YCQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v11 01/21] rv: Add #undef TRACE_INCLUDE_FILE
Date: Fri,  4 Jul 2025 15:19:53 +0200
Message-Id: <9c8e7fce68d4b30568ffaf9e8cc02ae311600997.1751634289.git.namcao@linutronix.de>
In-Reply-To: <cover.1751634289.git.namcao@linutronix.de>
References: <cover.1751634289.git.namcao@linutronix.de>
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

