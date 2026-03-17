Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43FF2FE579;
	Tue, 17 Mar 2026 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763894; cv=pass; b=u5Qw0iResfc8FX5Oq74VlOP3X4LUxFpblAuXl3Zv4ZQLImlEBbwsJGm8LKyutRDRMZGJVELy4MmZsWU4D8iyXZi9Q65uf9yhYXWnyQthhzoAI35PLFyZLoM/ApPrEyCpK+PIWViKyDhf6FjNZKQ14akcZnXaFFWCYl0tOkyFB8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763894; c=relaxed/simple;
	bh=z4qpI5K5VuCGCL+LIB0Pg02CYIyxZaHnByIH+LUn4eI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSncwuf+Ri8uRroEQSshtRkBOY5TAmIq2WxqpMC25ruUHunOxeUJV4sA9BPlB/OZUMWG2aQesuXpNGiYdQsXP0mhrtaj2ciWW9/fRvvPhpdPBO3wvHvKhwB+iTwbMF8W/sMeicfkEPgWEYHm+EEw2Tc1ZfocBpL3zrg+yMXuvz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=VAl36DAp; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="VAl36DAp"
ARC-Seal: i=1; a=rsa-sha256; t=1773763764; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=d1xn7w0qJ0HpQyXTBZ9JwhOil3vVLpqqbFh9i3zc6qFUedRMbRmtEAyx93VTUYD/STIhfOszYvJpFf8A/dopUyRobulRVwyYI3PCfQz4W4CjVINGq+adbt1wlWXm4Me+N5uWtfAX8jYskTLFL/GosnuBcP5OHFtYsB/vl4IockY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763764; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=stHVeUHtUkhvr3p0PGGWk2OqvHsyK4X6A5Msa7FZmRI=; 
	b=BFoPljCnB/stVXM/SDZkx168aEv6cpugZGkvbeiYvViY17FnJJyJAH0yEAzkPGTYB2qh6IyC7ytTXpmkIYASgvRMJNlhGyEiZDi15XIgobr9ZMXj9ugzSn6Tw+RiG9b0L7JCFVIpi7jo3GiJAGavTfooPHc1XT/BPfIupKfrhfg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763764;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=stHVeUHtUkhvr3p0PGGWk2OqvHsyK4X6A5Msa7FZmRI=;
	b=VAl36DApJa9Ka7FhMUqsOfJ8mhl1uZwUGyrpB8Y4rchcH464w7KnmlBYlE+G0jfp
	lA7DeQ1pVVaRFK5IjYBsRN6daY2HV9YhPbiYCXwdrwcTo8s+P67bRFw5P7jH8zUTGiM
	OLmsZfL2hQfTTBEsRSzFR+GLwSjDnndMZMBJ1beA=
Received: by mx.zoho.eu with SMTPS id 1773763760862485.8642777649935;
	Tue, 17 Mar 2026 17:09:20 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 06/15] bootconfig: constify xbc_calc_checksum() data parameter
Date: Tue, 17 Mar 2026 16:09:07 +0000
Message-Id: <20260317160916.33576-7-objecting@objecting.org>
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

xbc_calc_checksum() only reads the data buffer, so mark the parameter
as const void * and the internal pointer as const unsigned char *.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 include/linux/bootconfig.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/bootconfig.h b/include/linux/bootconfig.h
index 25df9260d206..23a96c5edcf3 100644
--- a/include/linux/bootconfig.h
+++ b/include/linux/bootconfig.h
@@ -36,9 +36,9 @@ bool __init cmdline_has_extra_options(void);
  * The checksum will be used with the BOOTCONFIG_MAGIC and the size for
  * embedding the bootconfig in the initrd image.
  */
-static inline __init uint32_t xbc_calc_checksum(void *data, uint32_t size)
+static inline __init uint32_t xbc_calc_checksum(const void *data, uint32_t size)
 {
-	unsigned char *p = data;
+	const unsigned char *p = data;
 	uint32_t ret = 0;
 
 	while (size--)
-- 
2.34.1

