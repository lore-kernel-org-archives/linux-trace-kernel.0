Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB76385510;
	Sat, 14 Mar 2026 21:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524776; cv=pass; b=jBT2nU2XGNds6cjm+2SoFXhc4wN7n99ZKaL1NbM5+eXJ+cCzEaZ0xz6pYHrDHELgUe2YCk1YfPmc7HDrtEKaynHciXLZL3rqoz4JJa/K5CJPEO5QtXiR71OZPEOTqdRPA7l5eqnCYMoHWILIgfAMVZ+86+Lh9ygZoPOREU4tsV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524776; c=relaxed/simple;
	bh=Y9mfWQWziz20z1wZlyGCqiydfBbJQNFNO/oywEYrkow=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VdCFpiYL5NK420ERJe0sdCYheS9+H93hbgM7dr5BMbdJVeB0jnls9pjVGf74Bo/dPNTnP3YscC5pYAC3Jk7HYdeFVQ/P2PoJJk3DcgpViRJx6J4fhUbIwcn8Xbm/sM6y00/hcME/owbzbkpDtnBjosfz11DmVQPX/FFdhN2TBN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=oVdRCtwu; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="oVdRCtwu"
ARC-Seal: i=1; a=rsa-sha256; t=1773524760; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=OoxLI6lgDK7CjgSOOvQPrVgvwEXqANKxHo8vlBzGjaG4ks1au+5Pa33Ucjyg3F63aQlRuYQgJSfI4JekreywrL5AfcMWCEUiEONLvvMSzCeyh5PVaolkUH16V3yde2K3vqbVThMpEhsMR87OhfQ2UuMiVRdkUFlqUo3GqiD2v9s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524760; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=; 
	b=E1Nxsd/Kkk0ZcPG2m9VaBhfEuLyGFVr6LM5dDT7XVzaNmBflvAJUNUDkDfoROkHuEZ2Gn2qessalZU2b8T1uKOd4IFiWTbRB0sfQH1Q0AldyVJsBLsj4dVqXgYK4jzWS+SHQAnPt28DoX8lmAPxg59z643n2aIWdfevW7GFR248=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524760;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=hXgtMivk2FUkBDZ0ELim05yAd6enb/8iaNS3/idzO40=;
	b=oVdRCtwurLZWXjz+LuWGP+AVYri8XmSwvJGqSqlNHLmaxfP1da3ZI7SP75YAck+S
	ztKZns/AklsyihRrGW/wBFrdvlhLVzlNh8S/Kd54iLpzKXrT0jr6Yc3ZmPHKL5ZPuE2
	Hu2GruhiA/LaHaQNM1fktEh8rb9vkeU6a8fV7n10=
Received: by mx.zoho.eu with SMTPS id 1773524758047454.75902255180154;
	Sat, 14 Mar 2026 22:45:58 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 01/15] lib/bootconfig: add missing __init annotations to static helpers
Date: Sat, 14 Mar 2026 21:45:41 +0000
Message-Id: <20260314214555.96217-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314214555.96217-1-objecting@objecting.org>
References: <20260314214555.96217-1-objecting@objecting.org>
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

