Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B997D311964;
	Fri, 17 Oct 2025 07:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760684877; cv=none; b=JOhqBwJwAvLGrKXAVeJnh973wAkNC8UC3lm/5jagsX3HyCvq+7KNXXFRrcyzE7Z/938/U84TySLeD4F/iiA3mG2ErDDnb8u7cAXBzyWmguLzNsBNIQQvAwA7xizeWv+J5xNR8K0fgeLx/CjYq2TFTWK3KcQL2JNmyumCrop0bMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760684877; c=relaxed/simple;
	bh=1rQjANCw0GG/0GagKqVML6Dp0C5BnCQd2hliZ49kQ6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ikh2OkL7h3jMeknKi41xo5q2172hCkcmlLbEruc5gydPrPZptG5KpSC85jcBELNmIJMul+C8QbHWuKk08Fg2nWu4r40dartBSgT4ph5SbHKxBfWALns2qSXWRS+3szwmYB2VUZfkhaesWXR8Ya/VDkx4mJYInIVuicwillZ5o3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rgsYIWjC; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rgsYIWjC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=E9Mc7eaN8RwyhVS+MOtoHI5EJvtYvI3FnmigMRZw8tY=; b=rgsYIWjCpUUQMaztkjs1gRYNLp
	4ncuAsp4khyiRNERV52kElIhL3ZRNKwIVv/dsMZesZVSxZB5tXZLQiaf4TitXtQ2x8DIfvVOluAe3
	mOyqSiHv1GmP4fHAxeKlNr6bFFloPstFvt63eIq8lqUrXbxw/mBa93E8Vj7qJoHdaWNc1RA9iYoHi
	7B5v0amrfq8AwPUYqFAtxi154cuQLj/gJGS4ASIj+a4gs9ugVZnH4zxfpMitbHGkjza1FEYrIQzIZ
	aQ/VUl0LEuxI8lCvPNxq+aGrvA0wUaEl9Su75PjLOaMhN967ZtKmQyZbek+QEqjJccJSKprU8qWT4
	egRbL81A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9eZ8-00000006vs9-0ewi;
	Fri, 17 Oct 2025 07:07:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: fix kernel-doc format to avoid a warning
Date: Fri, 17 Oct 2025 00:07:53 -0700
Message-ID: <20251017070753.1638717-1-rdunlap@infradead.org>
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
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org
---
 include/linux/ring_buffer.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20251016.orig/include/linux/ring_buffer.h
+++ linux-next-20251016/include/linux/ring_buffer.h
@@ -43,7 +43,7 @@ struct ring_buffer_event {
  *				 array[0] = top (28 .. 59) bits
  *				 size = 8 bytes
  *
- * <= @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
+ * @RINGBUF_TYPE_DATA_TYPE_LEN_MAX:
  *				Data record
  *				 If type_len is zero:
  *				  array[0] holds the actual length
