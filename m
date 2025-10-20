Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A029443;
	Mon, 20 Oct 2025 01:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760922042; cv=none; b=TV2Jkj1wiAltQ/VuKldoA6oRnZv6xQ2m6yhfv2EMwOdTh1zD+rVkppWxOhZHB33qmeeKY+0wVsQmaSspyavHfOTYFCz2poRjuzwc9B49DVH31/0t7TxSLwTKIHlY6Gnb1dm87Xf41tblS3Q9Ak83HJDfgWutqF1zRAKELXEOFlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760922042; c=relaxed/simple;
	bh=lIXhujf2LnoQiqD2pBSflelyn0Ixc4SaTHhJhUSDojE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jPSYXqJQirBnshiHgbPglR7nUgQEiGAfs3dBE4piAuU1ECh5mWFqyygJ7O9LyhYhBeniWMDkThNteEWaaevR3nbVmMwyDRe8Hc5PVR9RgBEuXXbIFJP0MrnYS1bL7q+ueCo3K+bPTJ1dBRgu1VIDdo2avhjYjy/ELenItGF/7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=w6pch+N/; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="w6pch+N/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=IHhlDbpDR/uarsdX4/s6LAyO9lfPS7eMYByG4wX7hD8=; b=w6pch+N/4FXIFhu0iKsY9R3eos
	G65tG4E2ESdxg3BX6aAjl75VWfloLHguObs6/feZbzJpQ+MpTXLnHVTLlURvJ3hQGZmRf4/fYr4GL
	hRDL7UcB0jILAOV5Hm5BUKqTJ/ZTLDoeJ8L41K7VZ2mO/Od65SiOFMogwdCnCI+SGquHSI0q7Yqs6
	4xmYqn55gABdO/Km8+GRecLrswTrw3DNScXCwJ+kYVxAsTAt+cjME/dnp+CRGf+oyyOQ/TErRWBGi
	KDADDr6p7OPjoYvv8jRwsABQTTauI8boYabNNd4yNuczvXaRIdjF7c8dDPR6AGnd5MAXarXUSqVf4
	NsLIHZvw==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAeGM-0000000Bbcb-336O;
	Mon, 20 Oct 2025 01:00:38 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ring-buffer: fix kernel-doc format to avoid a warning
Date: Sun, 19 Oct 2025 18:00:37 -0700
Message-ID: <20251020010037.2681824-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Format the kernel-doc for RINGBUF_TYPE_DATA_TYPE_LEN_MAX correctly
to prevent a kernel-doc warning:

Warning: include/linux/ring_buffer.h:61 Enum value
 'RINGBUF_TYPE_DATA_TYPE_LEN_MAX' not described in enum 'ring_buffer_type'

Fixes: 334d4169a659 ("ring_buffer: compressed event header")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: reformat based on comments from Steven;
    add more enum types to aid with comments;

Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org
---
 include/linux/ring_buffer.h |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

--- linux-next-20251016.orig/include/linux/ring_buffer.h
+++ linux-next-20251016/include/linux/ring_buffer.h
@@ -43,18 +43,23 @@ struct ring_buffer_event {
  *				 array[0] = top (28 .. 59) bits
  *				 size = 8 bytes
  *
- * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
- *				Data record
- *				 If type_len is zero:
+ * @RINGBUF_TYPE_DATA:		Data record
  *				  array[0] holds the actual length
  *				  array[1..(length+3)/4] holds data
  *				  size = 4 + length (bytes)
- *				 else
+ *
+ * @RINGBUF_TYPE_DATA_TYPE_LEN_MIN:
+ * 				Data record with length and data as below
+ * . . .
+ * @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
+ *				Data record
  *				  length = type_len << 2
  *				  array[0..(length+3)/4-1] holds data
  *				  size = 4 + length (bytes)
  */
 enum ring_buffer_type {
+	RINGBUF_TYPE_DATA = 0,
+	RINGBUF_TYPE_DATA_TYPE_LEN_MIN = 1,
 	RINGBUF_TYPE_DATA_TYPE_LEN_MAX = 28,
 	RINGBUF_TYPE_PADDING,
 	RINGBUF_TYPE_TIME_EXTEND,
