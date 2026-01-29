Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67C323E356;
	Thu, 29 Jan 2026 01:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769649137; cv=none; b=r7oy6JW9v0ALY/tpZ6tc9Flnjh2Dn5iHjUMYm2b8oGycg/Ufk/6TZs0FWL4C1yA0qYfagNfFTW4OZJTVU9zqmN9c9+WeHb5ZhT7eXfWrbbwihv/2bkU15oXderau8/qREJU8bKE/ec53KkrnSisrBuK9st9Y0KmnVDCF5qwapzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769649137; c=relaxed/simple;
	bh=0v3PR7rb0+eEOgBRoxlGoVj3VwtxmYZaaaJ1KHtQC9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KtHS30BFGtvgpRgO95DcmPbzkKBgtAB2V6wLVyB23m2pxBRbusnCbPb+Dh86yZoNkzmpM2eEhTTIVx7SkaTcpoz4GqbaTBZsQCT3IyZIYdqIo3MnsPApyE0zzV+soIqLyUI3GlgGHbOjWxQrxtsHm7bburNtkNRCA9c2NRa6IIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hiR7xDsq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hiR7xDsq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=PjevQMszua+7INec/b9PESykoQNyHqA/RallFFGPqJM=; b=hiR7xDsq++XxRCnbfdX+j/zA0a
	PDC42acUCBuX94+1d8CQbP877uYhCBvNf9VXuHEmS0yBCQdmP+hJT9G5ZRFZDi4qrIpCWNxPKbQyx
	W/3H5xj+9fRkwEvZLqKD+fLDGvWsexoXoOZgZ2YYJ14XbP0SIzKrKuL4mtFb6NMg+VmbVylLri3K3
	YNKiE5k1UJG3mkdt1V7S4ouN/gv5E9ckvJuzhL7f19CjHtCDCVvu/Y81HcwMA/0PRuMRXGJ4SdZVk
	vSpBRspteR9bwdscVmTzWMjhnWH7IrbRHJmNSrX8WEl5Me+DyvyKkCjTOztv3aWpWGUI5EeWDY0FE
	MwIo8c6A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlGZx-0000000H21T-16VU;
	Thu, 29 Jan 2026 01:12:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing: trace_mmap.h: fix a kernel-doc warning
Date: Wed, 28 Jan 2026 17:12:12 -0800
Message-ID: <20260129011212.616311-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a description of struct reader to resolve a kernel-doc warning:

Warning: include/uapi/linux/trace_mmap.h:43 struct member 'reader' not described in 'trace_buffer_meta'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
v2: move @reader ahead of its struct members (Steven)

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org

 include/uapi/linux/trace_mmap.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20260128.orig/include/uapi/linux/trace_mmap.h
+++ linux-next-20260128/include/uapi/linux/trace_mmap.h
@@ -10,6 +10,7 @@
  * @meta_struct_len:	Size of this structure.
  * @subbuf_size:	Size of each sub-buffer.
  * @nr_subbufs:		Number of subbfs in the ring-buffer, including the reader.
+ * @reader:		The reader composite info structure
  * @reader.lost_events:	Number of events lost at the time of the reader swap.
  * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
  * @reader.read:	Number of bytes read on the reader subbuf.
