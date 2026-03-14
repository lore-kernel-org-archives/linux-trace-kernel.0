Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D92238F641
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531134; cv=pass; b=opHkwaKPh8cQ4omS1rBegI6mfAIYRsYvBbXGGQVQaXWbhg1ou4WWgPirkLn4uCrFeHFvluAXwv3xsGv3urRxy/RYmirz0bdUxCQv3q0KP3munTXqVq6LMtfOsSP9LI8/oJCt1xJYxGgPp/CNUWxdMfjd3yWSt9puHbtdl6ZzuyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531134; c=relaxed/simple;
	bh=ZuUlVeCERGWi0kiPXUflzzixT8Dr5l8GMnBPX34kkGY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hEbTOZEgR7qNMP3bu7nu4FaZ4BsAkue9hOlYyzQCsPn9PbndGBq2m1HVUMS6+L3Pa3HWOQ9My0/Cdbht+1frUgYnOvFEFhPF8R0qFfQfgHNhvzMO2rdwUwxWTCXpS28LHUWUyCviBxPVgRQvE2S6JRuehrddKLos0E7XJofiYH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=OHnt1awj; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="OHnt1awj"
ARC-Seal: i=1; a=rsa-sha256; t=1773531115; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=dVO00tCoJAM3avhXg7BxxTc/S+bTBh5/4HCYKCRq/aT4w7adROVYfW3zKvGGQj4SoxxQTTy1Q9wrKG3HvoCz6/M0Yvkl+0qnKC/ZK6olxsaO5w305CZlLQdZYpYU2M2Li7hJrFLumEPLDe1Tkil3CcrveMHGAAmGM7mK28Lc/sE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531115; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=jQa+d6xwRxy5WvG4jIfj7hMRpG3HkL2h6UH+aTlgbd4=; 
	b=kc8ww+IqsF3P9cccIBIHmdXcMkCS4WyX80SFKCC9OlNiKxG0Hm3GJgnR53ZjbdQMAa+R9ke5Ic5Nf0snkD42SQRtH+Lpg5i9QBMti0Bzqhhjm5qyedxCVrEMS+RhjfH9k3rN2BjOoKLDQjjG86EyQ6KwZnuQHN2rB56PaKrJ5Hg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531115;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=jQa+d6xwRxy5WvG4jIfj7hMRpG3HkL2h6UH+aTlgbd4=;
	b=OHnt1awjlSeilp0O50LYket7NYn2tatyPOfCvPvooJyR2ZRAJBgflESNscoKrSVS
	VAiZSS22BULDRWehu3qu8o4M4qEZgQ54MH4aJnD1t4+mwcTQLPnISPXaRRj6C4zB9z9
	ITpZ1sMpUoUs0LG91dUELTbIenaR+tSyx46FGgCk=
Received: by mx.zoho.eu with SMTPS id 1773531113256141.62583018923783;
	Sun, 15 Mar 2026 00:31:53 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 15/23] lib/bootconfig: validate child node index in xbc_verify_tree()
Date: Sat, 14 Mar 2026 23:31:36 +0000
Message-Id: <20260314233144.187273-16-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314233144.187273-1-objecting@objecting.org>
References: <20260314233144.187273-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

xbc_verify_tree() validates that each node's next index is within
bounds, but does not check the child index.  Add the same bounds
check for the child field.

Without this check, a corrupt bootconfig that passes next-index
validation could still trigger an out-of-bounds memory access via an
invalid child index when xbc_node_get_child() is called during tree
traversal at boot time.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 0823491221f4..038f56689a48 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -823,6 +823,10 @@ static int __init xbc_verify_tree(void)
 			return xbc_parse_error("No closing brace",
 				xbc_node_get_data(xbc_nodes + i));
 		}
+		if (xbc_nodes[i].child >= xbc_node_num) {
+			return xbc_parse_error("Broken child node",
+				xbc_node_get_data(xbc_nodes + i));
+		}
 	}
 
 	/* Key tree limitation check */
-- 
2.34.1

