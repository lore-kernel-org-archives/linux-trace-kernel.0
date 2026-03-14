Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4E6391E5C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531137; cv=pass; b=cd1yraqSvLB6ENLdrt2XXsJoZq92DOZhZVFeB9L4T0zaVJ1c7zi5Ib6Hi7WqtEsWDIZ6HR52Bo81neiJt0Go7U/yBO6aXi7MYj7vBH4s1SR/9qN9ngV6FmDP1p/ttxgvRzrfp2xip2ExBlwU78LupXPWmXE3Kbg/3mhqT5ocR1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531137; c=relaxed/simple;
	bh=FXNMbqg55SqbPOuJegAqlqm+AJvfK6co4zCLBLrw5Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pgfXVvQ0N5LA1hGPmpBfYOExWWpWcjK5W3dU74e8gwelwHOLcH71dRzTQc6Dhf7yJEWhXBwGz/dW1NtZvtX7ZW0bqFuB+Re+T2s0y0I3CXGq9vbF6UUUppHbjp9ZXCayjRiFPXK9/Mom456OYgJPIkIAkkowh/b4IdV5xqdTEjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=W2tSOsyv; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="W2tSOsyv"
ARC-Seal: i=1; a=rsa-sha256; t=1773531113; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=HJx+/wAjF1FwjSlTRxQU72L9P9H52zWX91FfVqdmGWFypV2C8L69zAVcUsStFZWpRUCYXlYjjvXnltzTtRGKhdcOjymCOphiPuqqBkKzBY71zMMSSR/riQAHgj1Idw+N413/HoQvJKZ18yfZkYBBjXQ8Lpj/Y3Z4qlJSKPt5YlI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531113; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=; 
	b=fo1uVUM1eEKl/bNm+AcW2ukLxt2I1WSw6xwwY3q2XJt52rrQ/D1GP8S4Ci/VAEggW/b+fiuvT6lwlTWxQbXhfaSwkDeIaS7mqFOhiUVwQLkqLRC0EKy/iqbMOr9eyQ6PY7KBy1qJYE7iHktRllO7EBWz9huEQns7IqjXTjcte7M=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531113;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=;
	b=W2tSOsyvt99z88vEL5G/UbQJop/rScxUQWH9nxhZ5sMMQ1wjQks2H5dwLRVH1wK9
	0eQdUq4nim3UZFd8yk93xlwy1fMLcXKmUhl88F4wQvP1/Ye9GM3ScXpLynKY6uO9JKR
	HVjllUM71zj5ajBVWFttc80motl7AimkK+4sjp9c=
Received: by mx.zoho.eu with SMTPS id 1773531111299626.1583483874036;
	Sun, 15 Mar 2026 00:31:51 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 11/23] bootconfig: use __packed macro for struct xbc_node
Date: Sat, 14 Mar 2026 23:31:32 +0000
Message-Id: <20260314233144.187273-12-objecting@objecting.org>
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

Replace the open-coded __attribute__((__packed__)) with the kernel
__packed macro for consistency with the rest of the kernel.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/bootconfig.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 25df9260d206..c37e0096c4f1 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -53,7 +53,7 @@ struct xbc_node {
 	uint16_t child;
 	uint16_t parent;
 	uint16_t data;
-} __attribute__ ((__packed__));
+} __packed;
 
 #define XBC_KEY		0
 #define XBC_VALUE	(1 << 15)
-- 
2.34.1

