Received: from sender-of-o58.zoho.eu (sender-of-o58.zoho.eu [136.143.169.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0C138F641;
	Sat, 14 Mar 2026 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527685; cv=pass; b=qZTqatSKWjbWcQ8+5sGhSPjGKy/zdDikpytjbyt/omi/Msocn1HqMLHstekHiofoZBDoR4Y9CP5bhLrejVII4tTiRajF37HGsLfyJdjn+mO3/nXo6zA4cz4VxjiEkB6S45rvS81OVTo4Vsbr+OCYDou96XkjE/T0F+BA1xyvDUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527685; c=relaxed/simple;
	bh=6I0hpTbxvzM0MrqqhLwejv2QuzQNDU3b1q7ISIjV9Vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aLkPmON/Voo4P+lJo2jC+qgN9tHOskicfYXv7tWUOWZ9A/XKv5EefrUyMKS6FY458ZgGuBib15GWAitUrApz5iXB+6P5Wmdngf9a+mgmTyo81QsgoymgTmOLmx2SlHz16S3saKVIlzyWcyWwoKTao0w+EZRtHZXmhnTPnbQRaio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=S+6Xx2gg; arc=pass smtp.client-ip=136.143.169.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="S+6Xx2gg"
ARC-Seal: i=1; a=rsa-sha256; t=1773527676; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Q9cxx5Z1q1JrI8Lne992emwju4tuyoACr8J+vaVkn2pquowaong6NfwDMMu07vfq1v0KbjUNqBBKoZObXMIG2q8bqxJGSscQcL2MSG5CP8BK3WMFMhAI3/JVrMu8WKHph2/eHEMfLfxIrMzWU33JTLkW5OfY+8Jv4xpaqjGF+aY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527676; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=; 
	b=kbAbIe8q+oL5vQnIyc8BCaJGtVKgOTG8UmFAkStl+iBE7dMerHWE5VIsKgbqQJqsiOw6tKPNUwvbh2eV+BoMNbcVVRwaq5SNU5egJWlMbZilI4vFA4Uut5bbNBS5UHnPX+WVs0kdteOA8fFKhkDDCvWM2m5wIP9izs9nYTqDLWs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527676;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=1AD6D9MidV6Fkfxyg/iT9A9sDWNhqE7cnbV+HIFl0WI=;
	b=S+6Xx2ggomHXMMHgZcGBGddkod8q4kv6RYLBB5+DJTLn8zPLjW0TxGmqFNTtzoBv
	0Knn99PJRzXTS4jpX9uuylO8NNQlMdXt7TBMu7gLdTTxyFgrPOWuJ1snvE1OJMpqtdJ
	MAoDGxJGNLoYE8torqfnFzA80wkp/ioJVetJZdBA=
Received: by mx.zoho.eu with SMTPS id 1773527673949838.9845325686828;
	Sat, 14 Mar 2026 23:34:33 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 14/17] bootconfig: add __packed definition to tools/bootconfig shim header
Date: Sat, 14 Mar 2026 22:34:22 +0000
Message-Id: <20260314223425.142966-15-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314223425.142966-1-objecting@objecting.org>
References: <20260314223425.142966-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The tools/bootconfig userspace build includes the main bootconfig.h
via a shim header that defines kernel macros for userspace. Add the
__packed macro so the struct xbc_node declaration works after the
conversion from open-coded __attribute__((__packed__)).

Signed-off-by: Josh Law <objecting@objecting.org>
---
 tools/bootconfig/include/linux/bootconfig.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
index 6784296a0692..41c50ab95ba5 100644
--- a/tools/bootconfig/include/linux/bootconfig.h
+++ b/tools/bootconfig/include/linux/bootconfig.h
@@ -48,6 +48,7 @@ static inline char *strim(char *s)
 
 #define __init
 #define __initdata
+#define __packed	__attribute__((__packed__))
 
 #include "../../../../include/linux/bootconfig.h"
 
-- 
2.34.1

