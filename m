Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC79B388E5C;
	Sat, 14 Mar 2026 23:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529333; cv=pass; b=AnKPsCAwFMLUPsn+F5gqSgKzTthRBHF2ertokPMDeRQbQ0j3W17lHG3/2yFQUDaOvx1uqLi8x3wLC1OZ8PAWkTUPSBLLBJgXXqKfXq0IrFBOFLyJeVx0izjMVCGEKZ0vOcK+oYIBmx9wtDaQkvjxJYrloCZ+kXilydV5m7/97rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529333; c=relaxed/simple;
	bh=FXNMbqg55SqbPOuJegAqlqm+AJvfK6co4zCLBLrw5Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BlGsPY3CE7Ea3EjOaDyoY1QKFKfoFb4bJGHpttI1c5K/PkiGV2immYRjYeuxrbf4zX5rO0XUm7BGNcEwyHjaLntGpLzOwQ6IG2tsxk6ADZr+qJmzaRLEbaJj3sGa3/G5OhwgFu3cdvDJwp+ljcJjlOETOlvLPHXZedINleU9sFA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=nrKMmyAp; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="nrKMmyAp"
ARC-Seal: i=1; a=rsa-sha256; t=1773529325; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Zz96mI/uAzrxojsyzp7yKUDxntkdvifcztTS0f4d2uVEHj2GAOQLL3e7vHtiFnm/aAicIS0gbnQtsC7FgTgrFC/Jbe+AUJ7/48RXmttW7wHDKLIqGNLdmt1/VQnud7KSBYf6Nj6Ip6YuzHkceO8izXDV0/qZaMRfHblZSqx2+ME=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529325; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=; 
	b=jgPfJ+/pVqF5uatVbrjs8zOroawcBHT4mdZ1tiCicrstYCCcuHepiU0aL898fI1uvWO8QgRTsQFd0JwpGF6db7SXsZP1YYqPUCdqOOdJ8XH2sG/oZtagEOvLVChScqP1UyZXvwv+ulQXz6Up2sMes0/7lPl8FJzL+AJW+32FbAU=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529325;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=;
	b=nrKMmyAp3UGibYz0q2UCVdOWoxNKVs0Eo7AQpA0TSUZjN3ovLN6QHtwVJhCvJseV
	Syy1ukjqlVprZG8b+dQUnyUeKNP9ba8oZHVmu81mEGuH0N/ZFmFOUmUR7EpE4hR4yTQ
	mNkYb6GmNEgDqV4moUxT2jO5P2JilCEj+Yyfq/4s=
Received: by mx.zoho.eu with SMTPS id 1773529323455990.8955846772761;
	Sun, 15 Mar 2026 00:02:03 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 11/17] bootconfig: use __packed macro for struct xbc_node
Date: Sat, 14 Mar 2026 23:01:49 +0000
Message-Id: <20260314230155.155777-12-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314230155.155777-1-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
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

