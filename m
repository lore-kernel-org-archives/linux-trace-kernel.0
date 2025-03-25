Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D225EF9B;
	Tue, 25 Mar 2025 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742921533; cv=none; b=kRsQz5HBuT5ilKAMSNbx/jVC50sQnCcaaZhCwLpPd9HJWaSkihlTAYX6n/wx5viRJupLNhBr4yiOW2D6cBtv87humtNlxM7aE72PZVdSfOmHrikzmCYIoIdzdKOTeqOuUSyKpXImLspO5R8NSFjFag0AnkJKsDOzGQkTA+i2Woo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742921533; c=relaxed/simple;
	bh=Y39VWxHkrAC8RkPlmkSzEZs6r44C0TGrIxEsOUrSBlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oO904RNYsC01D64SiM0mGrBTH+ulTsCp65So9QsJ0IjXroz4jfySe34IcHzk4eYbCbtgLSqPZKDsXLz193TJd5lLDDjLWdc5yjgO2/o3hP9jmkMsyW69+GM1kd3pTaDlGZn+7SA79n0f9VzJJs030jE9mEZx4WH3e+YcdSY8ezE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CE1811756;
	Tue, 25 Mar 2025 09:52:15 -0700 (PDT)
Received: from e132430.arm.com (unknown [10.57.85.102])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9BFCE3F58B;
	Tue, 25 Mar 2025 09:52:08 -0700 (PDT)
From: Douglas RAILLARD <douglas.raillard@arm.com>
To: rostedt@goodmis.org
Cc: douglas.raillard@arm.com,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: Fix synth event printk format for str fields
Date: Tue, 25 Mar 2025 16:52:02 +0000
Message-ID: <20250325165202.541088-1-douglas.raillard@arm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Douglas Raillard <douglas.raillard@arm.com>

The printk format for synth event uses "%.*s" to print string fields,
but then only passes the pointer part as var arg.

Replace %.*s with %s as the C string is guaranteed to be null-terminated.

Signed-off-by: Douglas Raillard <douglas.raillard@arm.com>
---
 kernel/trace/trace_events_synth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
index e3f7d09e5512..f71e49cd35b0 100644
--- a/kernel/trace/trace_events_synth.c
+++ b/kernel/trace/trace_events_synth.c
@@ -305,7 +305,7 @@ static const char *synth_field_fmt(char *type)
 	else if (strcmp(type, "gfp_t") == 0)
 		fmt = "%x";
 	else if (synth_field_is_string(type))
-		fmt = "%.*s";
+		fmt = "%s";
 	else if (synth_field_is_stack(type))
 		fmt = "%s";
 
-- 
2.43.0

