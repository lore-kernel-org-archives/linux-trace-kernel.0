Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F54E385510;
	Sat, 14 Mar 2026 21:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524781; cv=pass; b=PCBp33o6kIxpFOjdCNwYyxDIvoW3bVP/T0jv99W9jXfwostmfMtjiF4q3oj8f5qv4NTRAeEGaO/drcDG0UihcPipxcgc1rLekd7qu+CgvA+n+EI7tV4GzlKtbwxSmTtR40Nn31v6PHBD4dFEVOSmzHsreQxBoQi9BdhSGYwsZLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524781; c=relaxed/simple;
	bh=kDcgT5gXzTP1fqOGMdxALgedri0gVcD3is/FfzavjKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IkpwgWWWvCayCstf+PvpmoyjfuO0cNh3BTAra+XsXyWha6yyvELt0Y4ZhkbKrb5ZLw7U6aP71Z/mTyMPH7xkfXy/KjJr6PuEqBYr9sk20iXFKKqWdj1qeOi4sb9YpypPdez4a/vlv4MWDLqHfjkeGEFtPHdLFf/2RxB3VMY0gK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=n+6fTkPC; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="n+6fTkPC"
ARC-Seal: i=1; a=rsa-sha256; t=1773524765; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=VgLMMtChlqeo/lEN1F+BcB9+2Oe8HyYRKPXaqRczrTlLQpWC4Ar0cxgzUbKl87rIJlfaBNc7Ds86v5XtWfy0sEpnMGUjDfrN499GJT+i7CIZcfUpR7uvMGWOG2LqMKbAlzeBJx8iXnmzuatDRA+1u6O5kT4K54Bi6CefuXgv/gc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524765; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7bmeZKaQTYKiPdWWEUmU4EJNbpBFQlYVqCIGyMl5PZg=; 
	b=AkZtZfYwXNT78AaLfZLdgmnQs5+RsCrcwgvoZ2VDExYxY6l/6z6YLhRgW1lTWotvkaSsjyER16bkOThBeb1q5hlcIw/v1qAAOq7vlnj9M7LF3MAXA3Co1ZWVYzPbYr84bBQj/I1MOVhst29am+07ViK07V70AWpnzalwpfP2+dY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524765;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=7bmeZKaQTYKiPdWWEUmU4EJNbpBFQlYVqCIGyMl5PZg=;
	b=n+6fTkPCW8ZVFlUmXcpAZh8bT7jF4xKnRrDdApZuMoz5OlKfSb10pOi5llI9FaXn
	75sarm2/Em79ETpTUFm7dsCd4NHXm0QCWs7MjxacR60RmSdscZKLG8jihKtw1tJjRhT
	2PZZvO4nR+Eau3EM0qP7uXihcgJ+FvueUNxyhBvU=
Received: by mx.zoho.eu with SMTPS id 1773524762982831.3987582938475;
	Sat, 14 Mar 2026 22:46:02 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 08/15] lib/bootconfig: fix off-by-one in xbc_verify_tree() next node check
Date: Sat, 14 Mar 2026 21:45:48 +0000
Message-Id: <20260314214555.96217-9-objecting@objecting.org>
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

Valid node indices are 0 to xbc_node_num-1, so a next value equal to
xbc_node_num is out of bounds. Use >= instead of > to catch this.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 58d6ae297280..56fbedc9e725 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -816,7 +816,7 @@ static int __init xbc_verify_tree(void)
 	}
 
 	for (i = 0; i < xbc_node_num; i++) {
-		if (xbc_nodes[i].next > xbc_node_num) {
+		if (xbc_nodes[i].next >= xbc_node_num) {
 			return xbc_parse_error("No closing brace",
 				xbc_node_get_data(xbc_nodes + i));
 		}
-- 
2.34.1

