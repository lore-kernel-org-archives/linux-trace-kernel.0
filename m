Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF77407106;
	Wed, 18 Mar 2026 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849583; cv=pass; b=jTblWM+BE5qtlxhT+tK69saRUuxH3FqmkGGIcc4kd6JWuObyVW/j2VvxXklMNPfz4CVXM5sjUp98aFd6IyoIdjEPwHM2dZRoh72IDWUrjQFO3Fw1NflxNdFVpHFodVF/hQ0VC3CRAwIuRbq2YsUMoKmBEG7Y/IO82M2O3+utnds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849583; c=relaxed/simple;
	bh=5DrGSXMEeIUOEdbJ9WiMaf2PnGRbNPGketohz92imfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F8BRXI/0fbEXsgJtci2yXyqGBHEmS5ZKboFC171wj/RHTNXX35wX31o56Lvxt6e3eFlqSQOlxuLvomtBhmTNVyQ/Xuo2TUbqMVmlov+42AtfQIyRHYxOAlf+kaJJcx6HIwNqh4GQYbsoVXXAmMNcets+PImrZPGVEVgoaAyCWR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=azdOizLL; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="azdOizLL"
ARC-Seal: i=1; a=rsa-sha256; t=1773849567; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Dg87BOQdzK+a9VeCxhMrQ9OaHifXUkWWF8H4saB3gGViZg45LbFgidRQ9ysV8ZFrIjJa1jEFfkSBXPa9/t4xRp0EsjKIH9TDETEfxMuH2LlqESRw8SEq3a6ni8w/W9j9D0hEtQz/un1N6AcUJ5wml/TXrwdgLMFxDS741FB4p2I=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849567; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=3izM0F1cOHEJuEmqlhbjziddkmwLfk1V+4E7AazdxMQ=; 
	b=gl6Q9bw557RzJWZvtHw/LVpU6Amkuyg2/amFZGqdnsxFzZp9ji+T7WVEPeR2pmF1NzG29Bd9s7n0WX0/DggMVlNF44adYXYFLjssNTVjYbO8zZ1i2hINDQfpnAjsR4RzTQk+ljqTU4ofdtbcoI4P0Mo1Kc4qe5RrOYeOdoRZOGQ=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849567;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=3izM0F1cOHEJuEmqlhbjziddkmwLfk1V+4E7AazdxMQ=;
	b=azdOizLLNN6CsV8Y54PbWCp1oBx0xRJeFYuB7sMZYXdMrXT9Ca4of4jiXrhPioBm
	v/K3Ivw80ln9iEXQDDxemj4lU9fE4b7vIz0YV4hf44HOuxEybIzAbB4x6q4J0FdfN46
	hXUvOz0XkOvQGkk/MOxpvZRKVFffmWrCDdZ5y9jE=
Received: by mx.zoho.eu with SMTPS id 1773849565242328.5993341348583;
	Wed, 18 Mar 2026 16:59:25 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 10/13] lib/bootconfig: use size_t for strlen result in xbc_node_match_prefix()
Date: Wed, 18 Mar 2026 15:59:16 +0000
Message-Id: <20260318155919.78168-11-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318155919.78168-1-objecting@objecting.org>
References: <20260318155919.78168-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

  lib/bootconfig.c:198:19: warning: conversion from 'size_t' to 'int'
  may change value [-Wconversion]
  lib/bootconfig.c:200:33: warning: conversion to '__kernel_size_t'
  from 'int' may change the sign of the result [-Wsign-conversion]

strlen() returns size_t but the result was stored in an int.  The value
is then passed back to strncmp() which expects size_t, causing a second
sign-conversion warning on the round-trip.  Use size_t throughout to
match the API types.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index dd639046912c..3c5b6ad32a54 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -195,7 +195,7 @@ static bool __init
 xbc_node_match_prefix(struct xbc_node *node, const char **prefix)
 {
 	const char *p = xbc_node_get_data(node);
-	int len = strlen(p);
+	size_t len = strlen(p);
 
 	if (strncmp(*prefix, p, len))
 		return false;
-- 
2.34.1

