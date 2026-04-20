Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7543EF640;
	Mon, 20 Apr 2026 13:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691526; cv=none; b=Ixoai9B5VGz/a526ftCbjBp+XpiuWbmqk5ZbNZVJq+0kvWOgS7/rFvOrRo80vLxExBt7SmL3fWZuRdVGQLZCV/a2sUUfstY6+M4PdtuuqTglShleobeK094jNcCPsM459PmZaoS3ImHTO1QeoQMhLwr1gQywW9p5kXaTqBuGYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691526; c=relaxed/simple;
	bh=qXxhdKsXxMXJ4EjeMKgqXX+TvRwoTN/Q3SI9QWRzlzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uJ9lX/yW1Ok1iqS+9WzcFszauzdbEpw/GeAYDbMLaCZCmIAwRHcjKfpxi6nhXcbbSRQq+VepKzohv8UcLo5gppj+57t/hZdIO6Xo/RLnnNIoDNBXVMX0quLy+QSiUuqiQ4yc/tEgyWi/+f7a2E8osAqSgYmong2kCla5EsgEjfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=C23sENpL; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="C23sENpL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=15k9GvoAVEL7uVhs/OZFiqpWrC/ZIh+/rXUrJtSay84=; b=C23sENpL+Dk59vWs+OXj1H4fkJ
	JjJgKC2+wAuIuCBlVfObTAHyOdlmNkpNWm8l/lBcUPZyfDaOB5exTROSKNe6tqwXk3yel0Mq1AXPZ
	EhvjtYGAsr7EUKCKM/MGmvVWr5Cu5rvbYr4aWds3W+yHU1GKbo5L6B84v2yyBgWu2uswHpWxvjYDo
	Os+A0sViv/ZqLg/bDwUdBTwddq/lAimM9mBQHQt5oS18k20gU0y+EF+H9a4+y5sqYz1cmuyJCZvn/
	nfs6eRo5mCG80W9ChHHuNsOv/PuWIrKHFHXG8/URRVzTDFMfMA5ubNY2mAUsJVkXz5Gwm1AVVBO+G
	/Yr1VJQw==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wEocl-0006y0-0o;
	Mon, 20 Apr 2026 13:25:15 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Apr 2026 06:25:09 -0700
Subject: [PATCH] tracing: branch: Fix inverted check on stat tracer
 registration
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-tracing-v1-1-d8f4cd0d6af1@debian.org>
X-B4-Tracking: v=1; b=H4sIADUp5mkC/yXMQQqDMBBG4asM/9pATCTFXEVcaBztuIiS2FKQ3
 L2oy7f43onMSTjD04nEX8myRXiqK0J4D3FhJRM8wWjjdGO0OtIQJC7KzrV1L+ZmbC0qwp54lt9
 96vqn82dcORwXRyl/1RE0cWsAAAA=
X-Change-ID: 20260420-tracing-3f1367ee4b93
To: Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Ingo Molnar <mingo@elte.hu>, Frederic Weisbecker <fweisbec@gmail.com>
Cc: Steven Rostedt <srostedt@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, paulmck@kernel.org, 
 kernel-team@meta.com, Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=1822; i=leitao@debian.org;
 h=from:subject:message-id; bh=qXxhdKsXxMXJ4EjeMKgqXX+TvRwoTN/Q3SI9QWRzlzY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBp5ik3dTrxHYOVPCo2KQEDYxxFri8NmR+AJ0Qyc
 sLOpQqAyzKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaeYpNwAKCRA1o5Of/Hh3
 bYTYEAClQpXLhLsSDngG2Imx9M5YsV7gTXcYn5zOrI2mrmuDwqIn8x+zp9zbYTLTEQ5AztmRNzk
 VlwNUdH8D4iXzwaQiblmMuHkfuHa3Z0LOdiPYXwK4lr4VDalbOTPAOgsoHDAl7HYP+GNnCZkdMq
 AyT+BSZwGGW9DgPwNU0xlesdez7DIFKvUaElQJUR1cxmSuTg3Ur8wRBB9dQBO4n52DTnqXUxvDd
 vWj30qe2masr3UNZO0a5GUhzokb1EQdlJfiZyEEDfVGQyiSb93ppw20LJciJxkpFsbhE733n9+l
 +u4DfgjDIY8j0FuZ3U7FiQkZNsz0dcnh/jJQN8sKgzxuDNZWhZFy1NxBRi56AxLUe/syUccTFJL
 OLwTUBQfey5+LtzxQbmw1+X2f/KDEEiZ1YO+ssW6M8Vll7Qb8A2VTI5NqYMcDYKqpLHXM0ClQDE
 qW90xKeJlfzxhVtG7gjNv7TVH2GKzuduvUjIqh8jTmYIMn2nZxF0OuazWI4Tm5Ss2ifxp+fEaIy
 xHoZzjHmDqC5LL2cfCtt9Wr5E6FZ4eHC4ljutfBZ5WE9ek/O9r4XnVYhDo62n/iLFcKpaGiK0HJ
 lJNPKHz6mJUYnpWHo6JMjb7LactKeOjD50SrU87Su13tvpg7uv77j26Ku0hbEnIF/rmbZZ2WOPB
 KQJNu7msVshAsXQ==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

init_annotated_branch_stats() and all_annotated_branch_stats() check the
return value of register_stat_tracer() with "if (!ret)", but
register_stat_tracer() returns 0 on success and a negative errno on
failure. The inverted check causes the warning to be printed on every
successful registration, e.g.:

  Warning: could not register annotated branches stats

while leaving real failures silent. The initcall also returned a
hard-coded 1 instead of the actual error.

Invert the check and propagate ret so that the warning fires on real
errors and the initcall reports the correct status.

Fixes: 002bb86d8d42 ("tracing/ftrace: separate events tracing and stats tracing engine")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/trace/trace_branch.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_branch.c b/kernel/trace/trace_branch.c
index 6809b370e991d..d1564db95a8f5 100644
--- a/kernel/trace/trace_branch.c
+++ b/kernel/trace/trace_branch.c
@@ -373,10 +373,10 @@ __init static int init_annotated_branch_stats(void)
 	int ret;
 
 	ret = register_stat_tracer(&annotated_branch_stats);
-	if (!ret) {
+	if (ret) {
 		printk(KERN_WARNING "Warning: could not register "
 				    "annotated branches stats\n");
-		return 1;
+		return ret;
 	}
 	return 0;
 }
@@ -438,10 +438,10 @@ __init static int all_annotated_branch_stats(void)
 	int ret;
 
 	ret = register_stat_tracer(&all_branch_stats);
-	if (!ret) {
+	if (ret) {
 		printk(KERN_WARNING "Warning: could not register "
 				    "all branches stats\n");
-		return 1;
+		return ret;
 	}
 	return 0;
 }

---
base-commit: c7275b05bc428c7373d97aa2da02d3a7fa6b9f66
change-id: 20260420-tracing-3f1367ee4b93

Best regards,
--  
Breno Leitao <leitao@debian.org>

