Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99B5192D80;
	Mon, 30 Sep 2024 11:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695314; cv=none; b=WVlEK1IqH73nhnzjWFeSdH+LpVjuO5zLbDVNpJBSkHU44hU8e/HQFilgCJAp17SX3R+Fdip7N//DLQi9HQl2zbak1tBSDJtqrcQjoj38r6kqURCqQeHf77bqqePFEik/2iPyGIQ0Cdj+WCld2tN40iIZgCXGNNHtJbcXY9P48VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695314; c=relaxed/simple;
	bh=83HNK4KVNUUuhSfGoTmI1AUv8PG4HnNND1Dst5shPCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BqovI+hbajznwty2IV/mrJCdsZLtaq72fUKN3LnXCxORKqnBGQ4n2YsXUozVJhIwXpeE6dPA517/6lcN1vAvWkKEIWOFr1Xs8ZFhVTRkLYlPHfv8m//dy0re0YXpfrnD9pAZGvQ3oFpf536s8mbsLYITaoSzJhx6+SymQpaUQHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=fnBZG12h; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="fnBZG12h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=68qzKLe5KZ0iLQM25TnuewoJxx38p3Etr0kNtLD9iOk=;
  b=fnBZG12hg+18uEbez/bDDvlPdj6taMXXlQ6ABTGmidGrOH+e5t6qaF24
   uLSJODB4rEMShBgcVUGRofNQKoEa16xQy4cRtVWHNVNj4Pc88KYNf+X52
   ckkI3OAuTjXblElG42lXvpQ3FHpI8EndaiZTb7z8ySLq02puL4c7c5noN
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.11,165,1725314400"; 
   d="scan'208";a="185956893"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 13:21:27 +0200
From: Julia Lawall <Julia.Lawall@inria.fr>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: kernel-janitors@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 21/35] ring-buffer: Reorganize kerneldoc parameter names
Date: Mon, 30 Sep 2024 13:21:07 +0200
Message-Id: <20240930112121.95324-22-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240930112121.95324-1-Julia.Lawall@inria.fr>
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorganize kerneldoc parameter names to match the parameter
order in the function header.

Problems identified using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 kernel/trace/ring_buffer.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 77dc0b25140e..313dffbdeef1 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2384,9 +2384,9 @@ EXPORT_SYMBOL_GPL(__ring_buffer_alloc);
  * __ring_buffer_alloc_range - allocate a new ring_buffer from existing memory
  * @size: the size in bytes per cpu that is needed.
  * @flags: attributes to set for the ring buffer.
+ * @order: sub-buffer order
  * @start: start of allocated range
  * @range_size: size of allocated range
- * @order: sub-buffer order
  * @key: ring buffer reader_lock_key.
  *
  * Currently the only flag that is available is the RB_FL_OVERWRITE

