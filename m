Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDDD3A382E;
	Wed, 18 Mar 2026 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773849546; cv=pass; b=ucR06okDMkRwUxflLlSn5RC55U411hePaq1qK75VsAoCih6TSddUruIgvl+hfw1MeBdoBEqSWbA+3E/dj7IGOl8yrKJNp9xT1q3VGKcaQ+VlW/e8AZMio3cTsVoZo98Ww3mIiC5ZowRFRv2Gtv+VP19M1GitfYzSO7WGABNsPjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773849546; c=relaxed/simple;
	bh=UCGF2iqPoFrqZNf487e+VjLxRdr/pZrbHmHEvFZFg8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UdKRCrc8AEhZc+Sc2i1gtQFwMMmVc/YFWsAsDL8nlKuezPThGZtRmDyVLO2s0pjp6/G+GmjBoQwVF68ixe9VYPDuwj9qfim+5bPvX6IKw+Kl2YduslwMf2ClS8mSq/Vgm23nnQ1E8USj3/Hvrx5/iUKomerq/GM5c9suC6raVLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=FDCzrksV; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="FDCzrksV"
ARC-Seal: i=1; a=rsa-sha256; t=1773849531; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ABYeiJNHeZK/EJ9G0/Yajr5VgZTM7IuE4Y/7Iyzw6BsdcoZZizOZI9H1PHx7MH1QUre8VcJFUSbnKR3iTPmA0bMWrHKTCqkEq7cvVbH9OL/p/2TOZ/Bl2fD8ztsmgdf4KjNNrM/npjDYu5CsZKwffr4+dWyafvg0mEn7E4yHMuk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773849531; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wQFyRPqlyhXtP7Cik8jB5wy9RJRVH73G8I3fT158msE=; 
	b=dByjiowwNvOE7rzd1urxlNCUsOYfo7pmkO+TIYJOKca78Sx4BLMl2nsrrDavPJd1MPFP+Kr5HIx6LdZup5yVhFKM5hYydaNzAO+HpVieuramsv3eW2d7krg1Tlk+8jmAwcOl8uu4eOxsji9rANcxBxYbxmpmZLRobur79LQqOgc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773849531;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=wQFyRPqlyhXtP7Cik8jB5wy9RJRVH73G8I3fT158msE=;
	b=FDCzrksVuamUHPZTwDilItJ+8lcqSbk3Ou7MnAWyo5xViGrQn6KmyZM6UvULECOs
	oS3ukS4eyQ2mdZRFc44u7bW7BrTFBx8gvF8KkYszkHJ1c2fcjjunQKrWuGHvH1Yr/GJ
	B1oX8/EeOX5jLV63++26YeoV2hgzcmzYDgbK+HBQ=
Received: by mx.zoho.eu with SMTPS id 1773849529411359.27485192489564;
	Wed, 18 Mar 2026 16:58:49 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v8 1/2] lib/bootconfig: check xbc_init_node() return in override path
Date: Wed, 18 Mar 2026 15:58:46 +0000
Message-Id: <20260318155847.78065-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260318155847.78065-1-objecting@objecting.org>
References: <20260318155847.78065-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The ':=' override path in xbc_parse_kv() calls xbc_init_node() to
re-initialize an existing value node but does not check the return
value. If xbc_init_node() fails (data offset out of range), parsing
silently continues with stale node data.

Add the missing error check to match the xbc_add_node() call path
which already checks for failure.

In practice, a bootconfig using ':=' to override a value near the
32KB data limit could silently retain the old value, meaning a
security-relevant boot parameter override (e.g., a trace filter or
debug setting) would not take effect as intended.

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 1adf592cc038..ecc4e8d93547 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -728,7 +728,8 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 		if (op == ':') {
 			unsigned short nidx = child->next;

-			xbc_init_node(child, v, XBC_VALUE);
+			if (xbc_init_node(child, v, XBC_VALUE) < 0)
+				return xbc_parse_error("Failed to override value", v);
 			child->next = nidx;	/* keep subkeys */
 			goto array;
 		}
--
2.34.1

