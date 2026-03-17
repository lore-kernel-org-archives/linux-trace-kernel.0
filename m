Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789722F9D83;
	Tue, 17 Mar 2026 16:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763784; cv=pass; b=ZTziYvYFmqaronSzMPSGxUYMWBG2pkk4MdfMUw/Mt9pEJ47j7E9URvMDgC2sAmKVtM75WGH/gT170j4Vy2CaQqMH3us25DDQA+Hskstoan5Lad2hW9bw4nHH3Pwy5plXL6fafRrYPq6ZlT3of3iuaOfsgYRQCSjHFNWSrqYeSj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763784; c=relaxed/simple;
	bh=vGHAAnRSmfkKeoZIkPxL389Ha8SG4InW5EOp9WN4bv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lhtwBL9K5XDbfNqMvLwZNF+PawUM/81U/zHd799wrdkfLPZjGuGMHRk/HXegH1STfCQWpg/VDy1Uld5vLm5qr/C7cXdUeXLM2BAs+ZnJcOVToFJP/tW/YIgAjhUXoc7HsBM54zRtYz88qOrQ2+yVUr2ZS7cAGet2TtJITIDCBWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=MC3wxsKy; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="MC3wxsKy"
ARC-Seal: i=1; a=rsa-sha256; t=1773763764; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=TRK5y9wTTPbfip3sSlEe56nqZtt32xY5IclbRqjqyOQ6Rt3WobnsVExtnClq+JJi08+5xGD9TIXco8c5ZC/+y2uObHmmjUenYIR4VUgUnB7fT++HLbV25Qh7f99TzR74cJRY60EHftROusrEeoXDY+EhgB8BUZJ1QytvVce4RiA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763764; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=45wJib0hzF/G0lzrOyItS1blgCsEV6Gatl0MqE00PSc=; 
	b=MMf2I/DScn+bCxCqJdwMCl2V50HcMI6V2kz2n4SK3RLjn+v0bdlAIAmeqDDPSP8nIrZxf5t6OLqwrqG/gwqjjIM6cEMjuHMdwZWovUImbo1reLd8fv2br4fS/b+of3I1nO4nrIcDQcakXVqJhqSYQTt7zwabH+TE7UduUYaSlF8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763764;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=45wJib0hzF/G0lzrOyItS1blgCsEV6Gatl0MqE00PSc=;
	b=MC3wxsKy+h1C+uoo4zVYqS2I78guhgtySvhgo0wKh8oz4HgHAvrQKFAmrxjb8N/5
	CZj9CfWQ9tCae6aUZzmQHbpXnQu834/7rs3X7hLb9lpjC96wte6k5VNy0cxU8v7IeYM
	P6ZoqkK4bD+0yg0aA0eGkTGg6wBWW99uqeqBN0Yg=
Received: by mx.zoho.eu with SMTPS id 1773763761395468.1932241623323;
	Tue, 17 Mar 2026 17:09:21 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 07/15] lib/bootconfig: replace linux/kernel.h with specific includes
Date: Tue, 17 Mar 2026 16:09:08 +0000
Message-Id: <20260317160916.33576-8-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

linux/kernel.h is a legacy catch-all header. Replace it with the
specific headers actually needed: linux/cache.h for SMP_CACHE_BYTES,
linux/compiler.h for unlikely(), and linux/sprintf.h for snprintf().

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 69486bd56fea..d7e2395b7e83 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -17,7 +17,9 @@
 #include <linux/bug.h>
 #include <linux/ctype.h>
 #include <linux/errno.h>
-#include <linux/kernel.h>
+#include <linux/cache.h>
+#include <linux/compiler.h>
+#include <linux/sprintf.h>
 #include <linux/memblock.h>
 #include <linux/string.h>
 
-- 
2.34.1

