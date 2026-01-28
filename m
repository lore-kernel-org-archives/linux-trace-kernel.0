Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89639330329;
	Wed, 28 Jan 2026 06:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769581526; cv=none; b=mnGL2YMQ59stbcX2TBxnqSyTZGholRkTkXDvHWPqdld4j9IV74RuL8okXlKrpsWiO3JRbZhpdd0aynFB7kw2kz3gj8EbbgUUrarDeGoPDayMYgxJ/+WUWESBw28olEhazX2sPK1lEXBiPlCoHikBJXn34ISfKP6oQlrmg06GUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769581526; c=relaxed/simple;
	bh=nXdSwy9AGwJMyOtc/GKNk4T/xBWKTNua99/y0kXdMHs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uwy0kPDLU9veUdj2OiHrb99c+LnGOD/Z6vHkOZ+my9UkaO7+/OQaB+wHyVdeDplwfVnPXlqVMux8AxR0misZy1MxB2DejdznVmSu+qHfeCHB2/By5x97LfJTRVvLE/E3mDhs63xAm+MALsq6dVBVCMwb/n1OvCDQ+qgCH2vUIc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Kyt7smC6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Kyt7smC6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lfzAOZ3CzzI72wMDP00Lg6x9DZ2Xj9Ui/7qIFZATc5A=; b=Kyt7smC6gJgfk/yR8ONNfj9X97
	+QfP9w+EW/imXXiRPGORzQx5vj9qE9KW6h4NNmFFGOgeo+h6Mz0W/VSRdA/IAmh9uW/L1+fO9Ywd7
	SSLthIjpQPo9LTpG0t5aEgQmt8vq1yXy58ej4T1PErKCgMeq3y70YSRYbFnb7wil8ctHfF7BqrkmM
	oKkgZQKLcgBCmTT4oFxZdzYLyolgCddDa7pvF3sRURtSZ/JO7yLzOsUC2tu6d6lYbX8VBXxQ2C/FA
	3qnNVmHO2ecRXFPxzUvt2A1NUHVswkYSsyzcf6iaLmh0maSLHsRfKhY2tFj6DsSFh0D0X09Y4P1Ek
	BYFsKL/g==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vkyzS-0000000FXMd-2WiK;
	Wed, 28 Jan 2026 06:25:22 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: trace_mmap.h: fix a kernel-doc warning
Date: Tue, 27 Jan 2026 22:25:22 -0800
Message-ID: <20260128062522.403456-1-rdunlap@infradead.org>
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
---
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org

 include/uapi/linux/trace_mmap.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20260126.orig/include/uapi/linux/trace_mmap.h
+++ linux-next-20260126/include/uapi/linux/trace_mmap.h
@@ -13,6 +13,7 @@
  * @reader.lost_events:	Number of events lost at the time of the reader swap.
  * @reader.id:		subbuf ID of the current reader. ID range [0 : @nr_subbufs - 1]
  * @reader.read:	Number of bytes read on the reader subbuf.
+ * @reader:		The reader composite info structure
  * @flags:		Placeholder for now, 0 until new features are supported.
  * @entries:		Number of entries in the ring-buffer.
  * @overrun:		Number of entries lost in the ring-buffer.
