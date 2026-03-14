Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B0D34F49F;
	Sat, 14 Mar 2026 22:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527917; cv=pass; b=CHuS6Xf/uPqWNsLJD1Rly4fkkaez5gto2QvAjpCoQuXw9rBf2M9qP6kZ4xso9lAxmKf/KhFocIW3QUNT7d5AxPOmcIDoB4RLEL3HTi75oX0zMr6pSNoXp2cKLw8rSiBLwF1+twsc6xFTYkgQqO884PE8cirgkY9LFkEEmPJmr30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527917; c=relaxed/simple;
	bh=Y9mfWQWziz20z1wZlyGCqiydfBbJQNFNO/oywEYrkow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K20WGT4CjH5ADlaKGcbaOsjSrE3++p7Idbmiwa7pTTt20GAKTnt7ZKfomUHOxKb3E2qH+GP/Wz8Aje9CzZmMLBE8NUcLcOc6S4uxSJrCblYRdpXe0sRVjZgeXTbRSStea6BxnP66gF1rL0tt432zpI1mu0dW5f7GBdI3zFZC3d4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=KIjmCrdQ; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="KIjmCrdQ"
ARC-Seal: i=1; a=rsa-sha256; t=1773527668; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MNxfhLBcytHZsNecvP/CV7NVS8kJnsh/1pck7jX+2RWTnp9HE9tVBWWUay+Gw+DdqAbzvW15uOf6usDxLJIiSdhAWPu2TU1xJ8UlKUT0+rK9672WdBYFzuRMLyHcDstzO77oDfw9Weconx/UUWQE5+owf2FS97xQdhJhRls2iLA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527668; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=; 
	b=XjDOX/jyljwoKEmPBECnk4WmDXgFGgSNV43aIZUCkEwDRGhry07xjQ9wruJumjk+K9dE7CdI5xLfRcfdk9hlnW5SM972P/l9ZR9RZp7UOW0efYUms3pWFDkt7z20Vg3vULklrraYGKnLQrsheRUTDSTn4uwX/E8lgZVg54qGD5Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527668;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=;
	b=KIjmCrdQLMZs9vVfO1kYvvEAMFhVhlk6Cd/ozmDn5M3TI/Vl+wbpwkqWzJJBQTe3
	aWF8qXB98OQkePcCUsle7LW/NfTBf2aO3cZGtUqvrLKmG1zb5Ig2+CNExDNEUBsIzRV
	3B9ergk3VOjka4XSyax6N2zv8j/JKvZsqO0AnF5I=
Received: by mx.zoho.eu with SMTPS id 1773527666944922.5579149566756;
	Sat, 14 Mar 2026 23:34:26 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 01/17] lib/bootconfig: add missing __init annotations to static helpers
Date: Sat, 14 Mar 2026 22:34:09 +0000
Message-Id: <20260314223425.142966-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314223425.142966-1-objecting@objecting.org>
References: <20260314223425.142966-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

skip_comment() and skip_spaces_until_newline() are static functions
called exclusively from __init code paths but lack the __init
annotation themselves. Add it so their memory can be reclaimed after
init.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index b0ef1e74e98a..51fd2299ec0f 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -509,7 +509,7 @@ static inline __init bool xbc_valid_keyword(char *key)
 	return *key == '\0';
 }
 
-static char *skip_comment(char *p)
+static char __init *skip_comment(char *p)
 {
 	char *ret;
 
@@ -522,7 +522,7 @@ static char *skip_comment(char *p)
 	return ret;
 }
 
-static char *skip_spaces_until_newline(char *p)
+static char __init *skip_spaces_until_newline(char *p)
 {
 	while (isspace(*p) && *p != '\n')
 		p++;
-- 
2.34.1

