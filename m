Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E8E288C2D
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Sep 2026 14:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788617808; cv=none; b=Qzqo0G6CgZciWplgKQVxXnuwqaelwWOUHOw9g/+/ET5+KPNS6FFnyl/TKIrBdJp7WOSkvJxePl1Le4ViojsF14Es/gPLqs7rGkEstfGfjlrmTOc64g0GeeBMhMuqe1J/Rk7o7GmKkoatiWayvsm0RqX9FU+hsjqVfK5O8TYjrYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788617808; c=relaxed/simple;
	bh=yCdC10nGItrzvxNEa4wF1imId166+qrRFvplJBgC844=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzs8YR9p4LCNXRdt68gNw5L5ry3LY5bhG0waF7dwzrAo4Zc2yQOwJyzZ0WgdLWbpt1qtYYb/Pcttgh8HQZkQEG7moEHC9/RSDFbp/J3/QsHKBNoXdYjtYe9+XjroGgwYAEZ0+Hzf2Cf2kCyxYqIAI+BNaZwJDuimAQjEkV8SN1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZV4OqED; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZV4OqED"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d715f4a587so28867315ad.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 05 Sep 2026 07:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788617807; x=1789222607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7l4+sGFhZsq3cAXpjxQ20/NKUqCCRHoSQb6ERGgOzFk=;
        b=bZV4OqEDuJJzyPQAXwRD8D9O94XeufWMvjC/vvGibIyt4RQerrV/N5IIWrN34H0Omk
         EmzuangEZjxhbSzGtnD7LZyzMXWe9lf3EjF+WvreTKv9+49UO4msc0hI61Za4OthUdAk
         cmH40tVbzheLExGcKlLjll7CaBtulKq0+DgexnL6qcP1wXuntZ+SNbH8i3RbGZimMr1Y
         YrQEZ4NsID6gCTb1j5J7HEIvX2PUWgCanFm0d7gjckejEPqdgVF4pmAMJxPN/biQ0mVo
         wnmvp6ZQO0A6/xLM1+IjYr2QytNFxcvaJooh8MihYlGquo0FXQ5EdHrrdufzceyO0ay0
         fxEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788617807; x=1789222607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7l4+sGFhZsq3cAXpjxQ20/NKUqCCRHoSQb6ERGgOzFk=;
        b=QeQOGbIpztw0gnkHWT7AwGym8EUMkao5zs42coF3FkmCPi2ofPaGO1ts9cuErfj+bJ
         rGdCul7wJGmEf/fRYwySFjjb8O8X/BgvfaNzeFA7vS8VB1+8pL+Cpc+a4Vt1QmT2tvAQ
         g3wuWn95fPYWDGNtF6/7jISW6SfObi9MY+zWGG+EuU4pCY6qN6YE38HAYfRDnKyXdpmX
         6pBLvcvc9HVWdVP1c0HglVtSuM+HvSov16XuWc1rj68N5Cs7kGp8U/H5VOFb309dsxIo
         kbArjR4HaA9qHY7TNZpjptvPbRJSAZHAR/MPv6Oymdo+aSoFyF4rYAKgoMvBkz2rK++c
         3iYQ==
X-Gm-Message-State: AFuF++nbET5MYXPOuAar0Ib5U575K69ElQhxyaji9M9ipRDnTId2dGip
	1JarFdBaw0jQFOw5IHifNbE+y2Gh8WXRovQVxlsmzxkk3Nd96d/kfJv/m4FtLg==
X-Gm-Gg: AYBFou3uDyu0pJbIquZhhuc2oMpdMRRvIKbHaoYcC6xz/Ib3m0X7JRlKerJWDkN3H3Q
	GoW3ji7MTIAi5X94GNq/RiU6iCT8T29OpgoppBwExXTzWHDa4/xArnYUE7Ag3QFdVV7u4O8R+tE
	xSiU2ZJZmSugwzOurfQA/6nF/+MAKoo2aM1i3TYIXBnx8vY6hjED0ce5K7nmBIT0h9O5Aamm+sB
	jfTyKmgxYQH3Oy+lnNtC+lWwtfjREgAl7ZPWatb3w8hKS3NzvXfmxIUPn1Ga7UnEHRrFxpyQ1lJ
	2bm9ZpG8eF9Upf26ETAjBhsYJEn+7AaKlKel+FFe0NGW3UJ82jfaOcWNbDGQdFf1PJwU0wyH4Ne
	d7w96UHWUgDpWZGHxjy+7jgB/A9TSyGnTW6MEtXltmyK4YmtrGgTHKqHY64RPcv/3phMVYKg2L+
	S4gqVlkN1/OyLwkYKqaFKFeukLupd/jwZJNSSBUvkTTWWwlo8xJIB8Nw==
X-Received: by 2002:a17:90b:3d48:b0:396:5f7f:52f5 with SMTP id 98e67ed59e1d1-39b260e13e0mr18916605a91.3.1788617806648;
        Sat, 05 Sep 2026 07:16:46 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c39227sm16732702a91.9.2026.09.05.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 07:16:46 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: [PATCH] bootconfig: remove unreachable index checks in xbc_verify_tree()
Date: Sat,  5 Sep 2026 23:16:36 +0900
Message-ID: <20260905141637.1547429-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xbc_verify_tree() checks that every node's next and child are below
xbc_node_num. Both fields store the index of an existing node, which
is below xbc_node_num.

So remove the checks.

No functional change.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 lib/bootconfig.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 89c88e359179..d383430637ee 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -1005,7 +1005,7 @@ static int __init xbc_close_brace(char **k, char *n)
 
 static int __init xbc_verify_tree(void)
 {
-	int i, depth;
+	int depth;
 	size_t len, wlen;
 	struct xbc_node *n, *m;
 
@@ -1022,17 +1022,6 @@ static int __init xbc_verify_tree(void)
 		return -ENOENT;
 	}
 
-	for (i = 0; i < xbc_node_num; i++) {
-		if (xbc_nodes[i].next >= xbc_node_num) {
-			return xbc_parse_error("No closing brace",
-				xbc_node_get_data(xbc_nodes + i));
-		}
-		if (xbc_nodes[i].child >= xbc_node_num) {
-			return xbc_parse_error("Broken child node",
-				xbc_node_get_data(xbc_nodes + i));
-		}
-	}
-
 	/* Key tree limitation check */
 	n = &xbc_nodes[0];
 	depth = 1;
-- 
2.43.0

