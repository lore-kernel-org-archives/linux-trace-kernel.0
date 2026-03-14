Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B038CFE6;
	Sat, 14 Mar 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527683; cv=pass; b=GDRDoa9AlJlf6OQqzeRiaRLis8Ecjk7a+lZfY0wCRQz3DA7SUsvFHncehRsRXJPVx1TieFa4hfkEDCuW6kLEqrb2uWfGodtpeYSFu7BsHz0Oz4314kUYwTB2Q+zmVHT0t899RDQ4OjCqc43Kak82ZUdQXHTw2l0V6nTYO+RjfWk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527683; c=relaxed/simple;
	bh=FXNMbqg55SqbPOuJegAqlqm+AJvfK6co4zCLBLrw5Q0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXIs1G2CEwUAktFdjclrT2VNzXLJ94ptlcqQrppYYTEXoSRan81X2BUQ7mnnCgdJLi4tD0hzpiwvN6uBNMSuOzDUZsNp1kVIq+PUi4XIpbR69VcfCx/dGMf4ns+IxD91pwscfvVwhe2lMSPFcmq8GJz3X+b6sSrVPcvILcUgQzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=U1+gEK5Z; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="U1+gEK5Z"
ARC-Seal: i=1; a=rsa-sha256; t=1773527674; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=GUcPE8gG07jxUGUxxPZq1G/GsNA1BOOBJkUj9TqEYK57KJsj/Cyrc5hYiUbnStdEMI7kurHDx/YaFDaDqKOA9YExtfDvjqfFnKlJo69pcA1ZF0yGBQt+zNcBU9pieqs79L5mMj3slAnSkaPgzJWbaLoUUaxZqOuvA9HIhzpEEXk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527674; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=; 
	b=QUaX1c2cMccCGziPpYwvSM3jrkj8JdJmbOAdBlnKrnd7H/KplR9ByQJQzi42JwHic+8FV7v8HMq14V48T/c9TJC2exwMdxssGf0/FiO5eEC8ATMUsWQ8CDAqCW2qFRZhnuGrad4I5AKE0yKvWLEsQi4QJnreiqTGYDRY/iCJumM=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527674;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=WR9vliQJfdjZlPD0h9WaXzdDRa+2M90wAFjtK+1BE/I=;
	b=U1+gEK5ZmaCr7wZi5Br9NRyDmAxN23f6HUTJ1Jw7seUUHR+4HXjWVC7R5729GgEt
	Rx2h0VeyxDUAN6rpC7BHES7HEJKEzShdG6LR0uxNcYEAon0tJPLDbJMknjcMMgJq8c1
	l0PzM0MNgZ+WdafHtWNwbyfMyYLnGk7qDD3hUKpY=
Received: by mx.zoho.eu with SMTPS id 1773527672398159.3961345633245;
	Sat, 14 Mar 2026 23:34:32 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 11/17] bootconfig: use __packed macro for struct xbc_node
Date: Sat, 14 Mar 2026 22:34:19 +0000
Message-Id: <20260314223425.142966-12-objecting@objecting.org>
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

