Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A77221572;
	Wed, 16 Apr 2025 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744786318; cv=none; b=FDpZy2dx5jVP1ecBlb7st52snzKZHN00iDYm9uZA975W/HQghdl9JSso7Z0I4vBWF7xzelMRnzTwbH+bjU/ah4P5E6nVnqnJsP4/xKJlk1vZqRk05UiJOfECQvcje6+DaAyI1R7ARupNctpX26MtjpRXkqYuG2chPRLy/cvpRBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744786318; c=relaxed/simple;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SW/qHaWuD2GERmMgVMbFdSpNc/xTvUQ03YRM8Vwm7Fqsyg0cwc9Siqkhoj6jHQKTHzDWY3ivh6o/oYiqTrnteU/Dttr10eikYOP7pweK+ZflXyKrbDRuYSySbmwPlPv2MLcYnmiwcFDw96FYgR5yA2LdOyh1EDUEOiHWTHC+Ch0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dojs6mFo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zwToH/EQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dojs6mFo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zwToH/EQ"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744786315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=Dojs6mFo4Mzf4JUfi5u3DVgoAdF72WD4+ZS8pehKh3pTtj3lF4X3KSRnLPY0Uh1UpBxJz8
	RE0IQiisGDaJUhHvh7JyWi26bvz4T/HpEsRKkCk6wduWwSsEoPUAvPNrgBTA2+MfO0SuoO
	o/zhA+4agt15j7l9cVV0xLaUiFYuLphL+t4Jvj6x4MLOxNe942c3ij5PFTLgDZ05K47Cq0
	SZ8YgPZ2qevf3WlBo6l6kd8X/pcZ9K69pjHaJHn4vW2W9mcwFi9Lv97kWilQ8QRgFfRYsM
	mrR/Tjy2I4ignUWS7VTCF8LWPJm9L70ajtLaTdyCaUiCd6umb1z7uGCtCo4Daw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744786315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9REGFnfyFOEyIjAE1cjJKsPFnrPKw4O7e9wg4waN3vU=;
	b=zwToH/EQNVW6TbBnvlq3sYXoZ7BDjyd66fiDrwauZsKzPa6cIssmu68lwUkE6f06HveQL+
	rgfgUkXpgQyS1fAw==
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: john.ogness@linutronix.de,
	Nam Cao <namcao@linutronix.de>
Subject: [PATCH v3 01/22] rv: Add #undef TRACE_INCLUDE_FILE
Date: Wed, 16 Apr 2025 08:51:07 +0200
Message-Id: <206700fffd52b4565228f4c6185bb56269e63618.1744785335.git.namcao@linutronix.de>
In-Reply-To: <cover.1744785335.git.namcao@linutronix.de>
References: <cover.1744785335.git.namcao@linutronix.de>
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

