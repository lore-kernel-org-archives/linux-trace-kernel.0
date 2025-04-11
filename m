Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D45283684;
	Fri, 11 Apr 2025 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744357089; cv=none; b=T7u3O3KgknkMVSfid/LXliVritIjGq//tSLAwYh63rUt0/P0jHR75ixSapzfcCTR/oQhQmNMlAb0pBe2kDVLv6AvqivbbKdZoFo4oh46ceLItGj90Es3xyntbBBb7GbBzuThXlOiYnmgCclGuWNwbznB0DFKGDu9Rjyrt6f7kLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744357089; c=relaxed/simple;
	bh=Jw17k9WQkRnMqTlghMlT0Z6/jWk3P0nzWEXmGhIlmvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psWs6jfCHt9Wz/E0g+E+SWR329LxRZNmCkwmg/JnLqcwqv1Ov9TRorIrawkZ4vNgIccc+rs51zof9W2LMeJo5D8RhjyOIJDT09/a8N1eqHFFEGl8m0ZpNEcDxYwSeL6zGzm789OU2frtba77bwmCUts76AbdwQgu9Dx0X3Zd82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AAAdAqzF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vhGyF2uY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AAAdAqzF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vhGyF2uY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744357086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jw17k9WQkRnMqTlghMlT0Z6/jWk3P0nzWEXmGhIlmvo=;
	b=AAAdAqzF9ENxCJ6OCWUARlxBfUFeBgwzewu0TuG/pqbteg+YEnxIZzTTibEMEStceoiQBM
	LhAgs+PD2pCxcYoyOUz2RlvNwnMJXDis1UvbutHPIajyreSBf0ce1H9bMfSXkMPECoIwNH
	fWUa1HGH+ZMsoX4j/MdaQqXFU5x0IQPJdJ262plmb6n1jvsOPhO1/3hTnjTkZMTQFtw1CI
	2BPsT2ujoTVN+0geh/CXlmb5oWI1aZaSoaZUwfSe8F29FDxklFE/SNuAWBk5x6OEcrXBlH
	nMaQXFKgcx1CiMh+Kb2vKOpITmMsXtfV/1/vzJ0Gv3l5WbBOL7P/SY+2S5mkdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744357086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jw17k9WQkRnMqTlghMlT0Z6/jWk3P0nzWEXmGhIlmvo=;
	b=vhGyF2uYgiC8Ee+/HfZ0xx/9+y3o1RwFhhIPUBjZzCTdZ2H3InET3nsShCmklzlO6NSo3R
	19zbz9G2AFkg+QDA==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v2 02/22] rv: Add #undef TRACE_INCLUDE_FILE
Date: Fri, 11 Apr 2025 09:37:18 +0200
Message-Id: <04f4544015495d957db0b633bdce746a5710c192.1744355018.git.namcao@linutronix.de>
In-Reply-To: <cover.1744355018.git.namcao@linutronix.de>
References: <cover.1744355018.git.namcao@linutronix.de>
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

