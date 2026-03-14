Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70078386C17;
	Sat, 14 Mar 2026 21:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524787; cv=pass; b=r7fvWPqfZ1GSuEBSQerM9dTi8o1oQ9NOJrTValREdNeCeqZDesxUZ2Pbw6SPZSBZlgfXMpTPZupdJN7I0+O1GYqiBQCwbng/qWPa7PWzuuKA/eTEJI07Hm6Ykci44oRASUAfy0Vm/elNZrMmZ1DQbNS2ptRbZNxSkpXvwMx3QxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524787; c=relaxed/simple;
	bh=FXNMbqg55SqbPOuJegAqlqm+AJvfK6co4zCLBLrw5Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vAvID5jeiblM9zFuwQ0yS9WiEFj8O4KHw8cD8kB/5CYVxyybSWG17fbE5xL0udmoN3brFAK0LsApalyllfZwd13b5CgNGbAwtMrLkNqa4mXfdbuW52RI4PAGFV37f8Q0Vun9AK01xJ0UWiUI9P0bkpSfAOglOfhdfx/qUnORelY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Ef8j29gw; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Ef8j29gw"
ARC-Seal: i=1; a=rsa-sha256; t=1773524766; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CJdjcv719rmq8DykinWv63Q8zh91huAMJQe5xkJvu0iDKsvgsQzs72m1ilhrSEBbbwXKkukiYNRjy+c1wvKtI0RTWEcohKOEmD5XWA8KHz4I5odykcRlR8RThTTRrW54xSk0WalKA25tngWa4rUHrtElkEWuTc1oQq2I/ERhV6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524766; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=; 
	b=isLOBtwU1JaZm10hNVvBY8j8mUTn36gk2nep0HzQP2KlMpdSCOA/0wdukLKCscsltkZoVSBFf1I0YvR9luJbiRriuR5KISQy7eheomb2quzFkJCu6MWinomeUe4B5Tpt23SkNZ3WPe2kM2shIBltgR3XWcfkigodNn9JYLyMQAA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524766;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=;
	b=Ef8j29gwtjQaiaiysTX5P7pu3J/JHgXGAaMNVrG4xJtnHv6/++Qy6W9wKDC9Hz6g
	e2rvt4+xNwsQheqywObUscOVOWiAoD+8AyGhQNl08hpfRPOqbEpzkKyc6o6ky3jHD1F
	AQ1EnVi79UK8yjWUA1vW5NgRMVxKQKm7YZlvqIe8=
Received: by mx.zoho.eu with SMTPS id 1773524764667721.0396314285333;
	Sat, 14 Mar 2026 22:46:04 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 11/15] bootconfig: use __packed macro for struct xbc_node
Date: Sat, 14 Mar 2026 21:45:51 +0000
Message-Id: <20260314214555.96217-12-objecting@objecting.org>
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

