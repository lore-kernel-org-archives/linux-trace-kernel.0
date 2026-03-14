Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB0D3859DB;
	Sat, 14 Mar 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773525340; cv=pass; b=OarDn5I26yH2xc7S72IE0lSr09F3PpHWzPKLRnYgD4ewlqLak+7OkFHeA3J0QXnjOEC3hwq4Rt+IeL0jhNs4JKSQzA2RmpS42xnfnuHWSHVzxofbgQ5IOju29LRNVC3eBZe6CePglrIp2wlWzP51+stEXeAftxaLsmIviuIyMWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773525340; c=relaxed/simple;
	bh=UvLyNGwexYo2cn8ocKvKWmvyhLSh4vWkr9PLO2DssME=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kfqe6y14F20y/hEsXNGjySf9VNrQ68870s6Hqs9Euut3+eklZPODtvLaIZHMYWNd6WpbdNa2OHgjfuEIndk/vzE6UB04IzKug1fF20WhIsMTqgMgpQSjYZMa+VzGcCOItoGFgslXZo0aUkcF85THsTD4jnDs4iIzIMLpZwfPipc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=QHq2URUI; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="QHq2URUI"
ARC-Seal: i=1; a=rsa-sha256; t=1773525331; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=bltVm8fyTWtN97y0Aaay6LEYGlVIxmv1a6UEEpjmr/LltYviFz8t87ecywAAZLV9iLUglfWZZ7H0MdaWOwN/wxFeP/ok3rYpcOEXneRBRhIxK4iDnt2LCUZ9O0B8FW+2t459V7g3Sm/aa1REtjQ7c/bKUaF02UUAQzTz4tyTaiA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773525331; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=cBOmSVZK/tdF2G9FHoUjRcgfEXBwIZcdPH0TEKRTIUc=; 
	b=jh5uSn2WO0TiVyd9E5aNI6VMX4Cx1np7aevq8ZsIwyLdsM4at5qud+wrAXLt7rFz1Kfb4vY6lJ6hV71FoDTLAf+dX0J6XIlq4Gxiow7fGKixpibi/Xx1n6TFTJ38GDswzRZxUrSc7Gi3Ogy154sj820VoYEbKgj7nD6SWs26N5Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773525331;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=cBOmSVZK/tdF2G9FHoUjRcgfEXBwIZcdPH0TEKRTIUc=;
	b=QHq2URUIz0d+fRdvAFyZNgPB282L2XodyHSKaxMG3GbynAipHyvAUO6kP+xGDpNy
	m0BjI7clubF34TRDlGeJrCl+lKmVLuEkNShpqm3c/VuCSzPKmubf9ccMyTHZMQCC3lx
	//TrHQeZQMBAp7A19XaDUGWZeLI80BQZW+pL3Smg=
Received: by mx.zoho.eu with SMTPS id 1773525329191788.0995050991733;
	Sat, 14 Mar 2026 22:55:29 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 03/14] lib/bootconfig: fix typo "uder" in xbc_node_find_next_leaf()
Date: Sat, 14 Mar 2026 21:55:15 +0000
Message-Id: <20260314215526.108651-4-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314215526.108651-1-objecting@objecting.org>
References: <20260314215526.108651-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 53aedc042f6e..35091617bca5 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -364,7 +364,7 @@ struct xbc_node * __init xbc_node_find_next_leaf(struct xbc_node *root,
 			node = xbc_node_get_parent(node);
 			if (node == root)
 				return NULL;
-			/* User passed a node which is not uder parent */
+			/* User passed a node which is not under parent */
 			if (WARN_ON(!node))
 				return NULL;
 		}
-- 
2.34.1

