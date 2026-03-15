Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384F6354ADF;
	Sun, 15 Mar 2026 12:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577237; cv=pass; b=j6kXmbzr1Ev5xSf3Ccnf9/p837091plwV9SkaBP194AOjG3/F319tdwDtvOFN3pVIZKvq5XDax3oaggYDtjNhjRZUF5HbHvp1Mxx7wEPAYjB66RSOlsJnQNlu1XtGdHchu8a6HX/xCuWrdwq/x0iK0Auefg7qfothQULBNBdbBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577237; c=relaxed/simple;
	bh=J0dWEtL7oD28UFrLKGwL9fzqAkzoGMhBDWffJqXgq8s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ADCguAcel6+Byzz29qCssVSyWjJj4GQsJH4rc2Z5G4vESP6chrq/oijPMS061cGDtrrVOdVwKTqu9mruBo4SEzyixwYTphh+u8xnn4ds7JYRgBxjQW1RkC8OzGJ37AAykoHj4CQAdMO8/K2qkNugIlXCK2kXIup7l/xFIMztlyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Uk7WQh4d; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Uk7WQh4d"
ARC-Seal: i=1; a=rsa-sha256; t=1773577228; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MGEc66PDLw+Gt3DO9nxX/Jix9oGN807AJ7FXnLfbl0idJUsRP0WsVbKkuVI9ebAspTaVQVNYrqfeibjlegAgW3cwry1P9shoEFxMiqSs7LhYLQi5AshWywaMuRU+R9dilOF7ANpxKls5+310QHHwhkMMfVrDFFTUwpdkubi54YU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577228; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=DAmDK/t7v3VayM2/oeJKOAUQv25rBNApZIKdk5FaALE=; 
	b=Tj+zWlieSxrFX31j7xtkR8aXxrN9jw1sn+htnx4jVEZfaDDDMP79kpaEk0LyIs/QTbDhE/Z9SwbsVd0by88QDVSysBcEcDBqK91siWxmyfiWTi49st25mnO/s/vjATYheheAqzc8P89qJDM+3b6ACSTLpUF4DlYjYs/YC4zu+rw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577228;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=DAmDK/t7v3VayM2/oeJKOAUQv25rBNApZIKdk5FaALE=;
	b=Uk7WQh4dKL0EvcvTJPQ3WoC+A3UsxOJtBqTNNjcPHz6Fk6b6r4RlWaNScotcCfDE
	tLC4cDvW96gu679esGACg0KgdClHSNNkTfDxOCNR/3fOdqs21f6DGCdL1GnSKModcfJ
	qiDLX/0XpgFa++1XXtKrVamkzUbcs83a8HMAOPlw=
Received: by mx.zoho.eu with SMTPS id 1773577225930577.223199494676;
	Sun, 15 Mar 2026 13:20:25 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 15/17] lib/bootconfig: use size_t for key length tracking in xbc_verify_tree()
Date: Sun, 15 Mar 2026 12:20:13 +0000
Message-Id: <20260315122015.55965-16-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315122015.55965-1-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

  lib/bootconfig.c:839:24: warning: conversion from 'size_t' to 'int'
  may change value [-Wconversion]
  lib/bootconfig.c:860:32: warning: conversion from 'size_t' to 'int'
  may change value [-Wconversion]
  lib/bootconfig.c:860:29: warning: conversion to 'size_t' from 'int'
  may change the sign of the result [-Wsign-conversion]

The key length variables len and wlen accumulate strlen() results but
were declared as int, causing truncation and sign-conversion warnings.
Change both to size_t to match the strlen() return type and avoid
mixed-sign arithmetic.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 7296df003459..e318b236e728 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -803,7 +803,8 @@ static int __init xbc_close_brace(char **k, char *n)
 
 static int __init xbc_verify_tree(void)
 {
-	int i, depth, len, wlen;
+	int i, depth;
+	size_t len, wlen;
 	struct xbc_node *n, *m;
 
 	/* Brace closing */
-- 
2.34.1

