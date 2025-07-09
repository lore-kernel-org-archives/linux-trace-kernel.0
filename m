Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09A123FC52;
	Wed,  9 Jul 2025 19:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752088906; cv=none; b=Zqu7lMOmxO2+xjI5STOBWCCyLRuNJO9GqH7+KUqPcGeTaJ00ifaHRk7tcWbwuFh37aLfCWwpboPjsK7SGFHk+ah8Du6PbYr3zlgZ+3A/mTLe4IKVpHstf+Ut1mbADc7AK+Rgjl31IXf0j+IGoKBCuGwpeSgXsoPIPNV+2oCDL0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752088906; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jIpZfubw726fzwaEDQ6jByatfHUvfaKgz8xprgOqv4V71DTGOsq91h1XQfzffJHhJ+CCiw3/UkH9DxSe7LImqHksh5dTjRv2LQ4uurJm3ManAOmXUvQKfGjm19ind4KPw9qDc1HYLhp7EMKYH/WL0+j+c1jAyGK4achVx/B1xG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I+/yQgGg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tHOrg51K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I+/yQgGg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tHOrg51K"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752088902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=I+/yQgGg1309dec53ELluYJGR5+YoopHs8xy0tOk1zG0IlqoQKw8GZ5nCOm1FEqYAItv+A
	pWJeCNrxLG/ptFIywqJan0Ux7EFl23v37w8QQEc7PIa8p5O0mRJnG9GADchH9tJ1rUQcm6
	wiJvWqHhMf/tGLzfAUfFRO9gOffPXig/QqtkmQe24XeNfbdYPGRXAvGCoCUzovJF4tAcSl
	loS5DM2creW//2pasbwQG1C2rvNaO6BsHay3Fk01w7K8maf9ecnkgOHZwu1ep+v98V2n1m
	Xpujz1L2lz/PMa9QqeQAGzaKEnoe1CmabRqVeag6mIE+A9OQojvqtZaoUAXbDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752088902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=tHOrg51KJSU1Nq/NXlHoWyPwoHpEGRk3fRHYoGcCBeYmivIVJasWx8PtAk/J14yV2rAnlv
	QwFuIbYNOU+raMBw==
To: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Nam Cao <namcao@linutronix.de>
Subject: [PATCH v13 01/12] rv: Add #undef TRACE_INCLUDE_FILE
Date: Wed,  9 Jul 2025 21:21:12 +0200
Message-Id: <f805e074581e927bb176c742c981fa7675b6ebe5.1752088709.git.namcao@linutronix.de>
In-Reply-To: <cover.1752088709.git.namcao@linutronix.de>
References: <cover.1752088709.git.namcao@linutronix.de>
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

