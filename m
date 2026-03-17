Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED7E2F2619;
	Tue, 17 Mar 2026 16:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763782; cv=pass; b=pLhtL4PPBkbo1jE3jKIF3p4vtYGXbaEjvBfl9Xvwiv14m5eySMqu7H1koLcV4P54inT+sz62Em1d7LeZjUiLzBjXpm8z4KHOXMS/MbKpOpQts7sszr28CBqmsTc1GztEuvSX8olxwm6SKBabfx/jXD9JLu9FwJWLeRLfbgjl+7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763782; c=relaxed/simple;
	bh=k1J7BK/fpcNNRsuYpLDEr6NUfHMMBv470GcUJe6c/Bk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNVHcQ1rBCMslBbGl7pj/iMNjZ9IBRjH79dfHybFziWn5jeoVYW3RUV2j7fkQ3+49OocvqTFJiLe0WgcFoQBEbQuuGna7Ub6rjgK6PdlKsgdU9xHoYxeUzlXemunl6Qo+xREtSva5/ukf5niCaO3Feff0MJZh/6kBatrhbVyWU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=LqTH1jyT; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="LqTH1jyT"
ARC-Seal: i=1; a=rsa-sha256; t=1773763766; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=OtWJCTHrN1V7VY4785ZA7jriMHvlIS1KEOl0AHuiqu5X/goGIZUnfN08J17HxIQUoTBizdpbOb6MKVaGzXW31J96zCgjZnKP4h4hBiF+axyotHyDcubCwJ/oAzy4hcoY3XtyFJn89jF3zVxYISzPpGjkex7gh4gq8XmD/Q0KDJU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763766; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=EX/3umGvgoplaVSbNUVqsuFtykwhUNbV9tqaQFKaobM=; 
	b=amUZvv2twEXIuRrEzs0jfKc1d0SfGmZxa+J79QgsUgvz1yJGDDjoBpIfQ7NabxV64WZirQtBjo8l4xjK64Jm8WbcRMgbIOe9oe/tNF53EisPKDLZFyd9wjVPjg4DjDDI0nracuscYbB7b2A9B7LHwvPu7WIVO4qKmNWc7xrt8Cc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763766;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=EX/3umGvgoplaVSbNUVqsuFtykwhUNbV9tqaQFKaobM=;
	b=LqTH1jyTOPcVBy6fa7V2BGufAo/YTmdhZAh4wyTtU2KmgAd8Wx/SjaM1gUJDK4h+
	NJHzomtnDW9HVU5HdjhPsd4j+KxEi3XWM8nKKOKbXiPo26KWwuI3wQ/HrhJb94i+DUm
	ITEdnb5Z/UkKbbZ/ylUzQ9m6A0SqxAwHMXnKLK3I=
Received: by mx.zoho.eu with SMTPS id 1773763763492148.96351708589395;
	Tue, 17 Mar 2026 17:09:23 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 11/15] lib/bootconfig: fix signed comparison in xbc_node_get_data()
Date: Tue, 17 Mar 2026 16:09:12 +0000
Message-Id: <20260317160916.33576-12-objecting@objecting.org>
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

  lib/bootconfig.c:188:28: warning: comparison of integer expressions
  of different signedness: 'int' and 'size_t' [-Wsign-compare]

The local variable 'offset' is declared as int, but xbc_data_size is
size_t.  Change the type to size_t to match and eliminate the warning.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index ecc4e8d93547..dd639046912c 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -183,7 +183,7 @@ struct xbc_node * __init xbc_node_get_next(struct xbc_node *node)
  */
 const char * __init xbc_node_get_data(struct xbc_node *node)
 {
-	int offset = node->data & ~XBC_VALUE;
+	size_t offset = node->data & ~XBC_VALUE;
 
 	if (WARN_ON(offset >= xbc_data_size))
 		return NULL;
-- 
2.34.1

