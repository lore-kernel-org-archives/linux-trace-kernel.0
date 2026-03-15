Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B66338595;
	Sun, 15 Mar 2026 12:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577230; cv=pass; b=GPcYIeyf38PmD2ihofCPnZutOTsWa/iW2rafbKB5dKLm56hBrx5Teukzs+iB4WwAi9phVuBg65ik3vTLIhKZxL1BHR+ZNX2nUNQf/uTM1w+E2kVUFmG05fLrEj2RWRvUSlJjDnlnFXlh3oT6GQ5HPulD9vlmnk1mU/NtP/jJEbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577230; c=relaxed/simple;
	bh=a+WFwpw+I4XZGC5elagyWWAPMbI+AfKvHrTYWpm5LbU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fTvhKSOBq19xu18R+SYBDyvHK/LOPMWozhkkiJyZj9uBRkauEAPNqROEH4xNznFy8P2I7sSnv8xfm6dcjT3hwnO9Ey4oJj62jurKnrOFArIFAX5ZIQjl9Kakff/5ZctRXnv7SAqCTU80O9HyWt0f1LaU/oIvvuaIfxGVvr3pGSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=gnLe6KhF; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="gnLe6KhF"
ARC-Seal: i=1; a=rsa-sha256; t=1773577220; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=IFlXUlf/YPSKxb9abgX56nimkIGsLa8QVB2pOnKQKfZaAVkLnnyzHpfuyvLc5L+aRSk6josZnz2AEWEZwAmtUhvUYeb6QJuDs7EK067pSbScHsT61QXV0i7LOVCIPdYQqt3ojiOsqZVjtWBe7GQTVAyA56xuP7mjxp01zoN4w5s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577220; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Ml1F7UA76fJe9dugLYEUHOcRjtxkVNciYSA20s/4dA8=; 
	b=Ps+ukiZfL9h41WjjUicgeirCGaYWQcyJLboKAHqVG9hv0lt+M4R3rT4iKE3hpCFm1R5XhyzXRDPzrmwOBlYONc4+6Ez8ABffJ4cl3fGGvinonDyV7aq6oJL6h1r0DcnwfDmEjrVVbCeGJ0LeWGtSnGrDaWrDXS6N30Ymgcj8mfU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577220;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Ml1F7UA76fJe9dugLYEUHOcRjtxkVNciYSA20s/4dA8=;
	b=gnLe6KhFrDpBKrpFyrKhJS7nroFLLMe4YJQIhbOE7hEmvn24M85CRLUAmqZWnEuA
	hTNDIyuwkbhEzCd9JTqUjCx4NGD17m6HaQZuCycc1F44UESaqu4KB9gFX+9Mvisia60
	bfdy5f5WT97+44jV7v/w3wepvpKfyR8Mke8rJq8w=
Received: by mx.zoho.eu with SMTPS id 1773577218485880.9295205333123;
	Sun, 15 Mar 2026 13:20:18 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 03/17] lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
Date: Sun, 15 Mar 2026 12:20:01 +0000
Message-Id: <20260315122015.55965-4-objecting@objecting.org>
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

The flag parameter in the node creation helpers only ever carries
XBC_KEY (0) or XBC_VALUE (0x8000), both of which fit in uint16_t.
Using uint16_t matches the width of xbc_node.data where the flag is
ultimately stored.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 80de9540245d..58d6ae297280 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -408,7 +408,7 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 /* XBC parse and tree build */
 
-static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag)
+static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
 {
 	unsigned long offset = data - xbc_data;
 
@@ -422,7 +422,7 @@ static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag
 	return 0;
 }
 
-static struct xbc_node * __init xbc_add_node(char *data, uint32_t flag)
+static struct xbc_node * __init xbc_add_node(char *data, uint16_t flag)
 {
 	struct xbc_node *node;
 
@@ -452,7 +452,7 @@ static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
 	return node;
 }
 
-static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, bool head)
+static struct xbc_node * __init __xbc_add_sibling(char *data, uint16_t flag, bool head)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
 
@@ -480,17 +480,17 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, boo
 	return node;
 }
 
-static inline struct xbc_node * __init xbc_add_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, false);
 }
 
-static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, true);
 }
 
-static inline __init struct xbc_node *xbc_add_child(char *data, uint32_t flag)
+static inline __init struct xbc_node *xbc_add_child(char *data, uint16_t flag)
 {
 	struct xbc_node *node = xbc_add_sibling(data, flag);
 
-- 
2.34.1

