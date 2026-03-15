Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7947354ADF;
	Sun, 15 Mar 2026 12:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577254; cv=pass; b=CotB1cS7PyJ5HyJDWwiP5Ldg0DSnBjMm/TfWA4z9UT92LiUL3yyp4l3SGOqJA1JnbeBusYOCdg/iWzEmxoOSfOpdtW45eTBgwKwtqaEUcMhCp4UDRonnQ3yj1olTZR0X/fgoo+fv7/dFR9P7xLiAbLy14dLLN6dhEu6CnMqWzAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577254; c=relaxed/simple;
	bh=NJb0PfVx2IEUEXdGwnAshKOKOsoCjiLfgSxsXZPvw2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cNHB41fCch9QbPl4turwgOJA9oDZ+PHOGO4QXjYch6OnOIUga+Dra5xuPvnmdLogOe+prRsyAAR7DaYy4G8xhXyLbnZJ1DD4oxRdif05J3RJNnFzBtvEEZmKe/tTztnMmpolXfpyl+tgzwMGEgRpEABl84INQ5murk1SexCLvLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fovjcEc7; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fovjcEc7"
ARC-Seal: i=1; a=rsa-sha256; t=1773577230; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=BGaPNOJeM1xZUXgPCGhV86EYJC7S0T2xebCgdxbkBjwm8u1zgVExmdpO5RR8w/3gexRCLGGotjOl0guXV+kVaMneCusH6wgmdIpXXP+NCyJseYIuwyEA2i1gfi2LakcTre2jJXD4JHAWW2HI4HryXJalIMCZyWKh3jRSxgtNZl8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577230; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=eg017Ee8s6ss2maCA0kRT3aMT33sR6JqGAzxxAeSigc=; 
	b=Ud+Px96tXeYltAnu1rCi/GOAXR/TlEdT5U/liyzp2x59D+bZrKbyT2ltPYGCgLvGutAoTZmKPZi1rhKJqh2Pq0HNzMpwpAZlx2wHlgYq4kXmiElDA3ptnfQmhzKpyxE6FKHlJtzPuU9vcT7IUQnspRBaoqLGuhmaXdM5Mq02+nw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577230;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=eg017Ee8s6ss2maCA0kRT3aMT33sR6JqGAzxxAeSigc=;
	b=fovjcEc7NpiJAC56kFNK4uMUb1FTnNImKM4YgdSTudxoAVtqA4HgWstsPNCp1qka
	Uhcy/rTus2i0yADitrT2HMUIjgBcMBapfLCg5ycM9SXCgdNJAxEFtUWBL2bBiKzx+yn
	P+8Ju2MH5tyYNqhVry7BycWXZ93LRbUjTaPz7LvI=
Received: by mx.zoho.eu with SMTPS id 1773577227076927.1548014143685;
	Sun, 15 Mar 2026 13:20:27 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 17/17] lib/bootconfig: change xbc_node_index() return type to uint16_t
Date: Sun, 15 Mar 2026 12:20:15 +0000
Message-Id: <20260315122015.55965-18-objecting@objecting.org>
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

  lib/bootconfig.c:136:21: warning: conversion from 'long int' to
  'int' may change value [-Wconversion]
  lib/bootconfig.c:308:33: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]
  lib/bootconfig.c:467:37: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]
  lib/bootconfig.c:469:40: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]
  lib/bootconfig.c:472:54: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]
  lib/bootconfig.c:476:45: warning: conversion from 'int' to 'uint16_t'
  may change value [-Wconversion]

xbc_node_index() returns the position of a node in the xbc_nodes array,
which has at most XBC_NODE_MAX (8192) entries, well within uint16_t
range.  Every caller stores the result in a uint16_t field (node->parent,
node->child, node->next, or the keys[] array in compose_key_after), so
the int return type causes narrowing warnings at all six call sites.

Change the return type to uint16_t and add an explicit cast on the
pointer subtraction to match the storage width and eliminate the
warnings.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/bootconfig.h | 2 +-
 lib/bootconfig.c           | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 23a96c5edcf3..692a5acc2ffc 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -66,7 +66,7 @@ struct xbc_node {
 
 /* Node tree access raw APIs */
 struct xbc_node * __init xbc_root_node(void);
-int __init xbc_node_index(struct xbc_node *node);
+uint16_t __init xbc_node_index(struct xbc_node *node);
 struct xbc_node * __init xbc_node_get_parent(struct xbc_node *node);
 struct xbc_node * __init xbc_node_get_child(struct xbc_node *node);
 struct xbc_node * __init xbc_node_get_next(struct xbc_node *node);
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 68a72dbc38fa..148084abae12 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -131,9 +131,9 @@ struct xbc_node * __init xbc_root_node(void)
  *
  * Return the index number of @node in XBC node list.
  */
-int __init xbc_node_index(struct xbc_node *node)
+uint16_t __init xbc_node_index(struct xbc_node *node)
 {
-	return node - &xbc_nodes[0];
+	return (uint16_t)(node - &xbc_nodes[0]);
 }
 
 /**
-- 
2.34.1

