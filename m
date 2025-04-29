Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9273D2C108B;
	Tue, 29 Apr 2025 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745928095; cv=none; b=LjildMm/yFtCsSKJE99SSUAx6RCpA63UcmL4VUo2CjWaloQjWZ0M95p/ob2L/ocd90OaojRW6grjySkEnMPc7qKf9mjjuakVQQOZuHjYJ3o/Y4Bo2dN8jcVcoXG39/O27sTiSfVJGTYsEj/3pzgi+hVCcn0aizPfAD5tviqOAgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745928095; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NUkDekYj6958i/MAnDgsPc37VCQbpKFXMEZUPt/JIBpUbuMYoxicYyx+4BZYvuXZduSCBZPxFa4QVBCZYMB6tgChyb6XZOMNxST5R9RKare6bdeookTx1YABY7OYTM3XSUeweVKgi+0fOzyq5tnnbG+jowgJ5ZeH3LVaFWEHKgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4suG1uQq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YIpjOg93; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4suG1uQq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YIpjOg93"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745928085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=4suG1uQqMc4Bv9xNq1cVIr2kmhy03eBEjaKCC/2W4oKElAJsns4DYpIhsFjtaHrdMtzjc8
	c8A5lMm0aDBqO9ulGMZP57aSA6qhyQQOPwiRuWjSErmVfmU/CG53dcOqOvPSNhZTyy8cSP
	4Vgp71qVJ6DtXwKp3fbgC87FsqI+OgM6wdew9wJvRwZZmlwVr6NSUIyJU0Da5w+E0AolzH
	Asvb6UutOG04nAyDwMfQ1miaRci2BEE1dL29JCpY+yDAw63bKLt5R4R7N8WkTw9lrT0lpP
	gIf6Ohi0s8fBS+LKG1WAzrSpeBYIup2gKW127NksDLzEqkx17Ej2qIJtz6KEjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745928085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=YIpjOg938ZzicBUFMOb5QJlcvEJ9XUfVnrYj38dVvOd/kkagWhzV8svj2+F2DbFWSTaceH
	bKiJQ6rRWCMzEoDQ==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v5 01/23] rv: Add #undef TRACE_INCLUDE_FILE
Date: Tue, 29 Apr 2025 14:00:46 +0200
Message-Id: <a1884da3393d1739d45e29b7cd4f3ac7bf2b8d37.1745926331.git.namcao@linutronix.de>
In-Reply-To: <cover.1745926331.git.namcao@linutronix.de>
References: <cover.1745926331.git.namcao@linutronix.de>
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

