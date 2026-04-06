Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7742938B151;
	Mon,  6 Apr 2026 16:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775494451; cv=none; b=oxs018guI+ndieFUuJ7bEbCYICUmjYbvgkrlAugOl3aC0yUc5o6Z5BKUs7K1lXgfEISHX2F88H5JtG2iHmP7PPrc+VTLlCrmrS6RlMj85gbL4/UUqVcFkC1UHH6Vk8UHd8dSxKR4O6TmXjEdA08ciLq/CpNoN7aCv23mU/mjJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775494451; c=relaxed/simple;
	bh=VXV3g4Cku3HtfIu/eMC5bEVsDUc65ZTW4YmIezvUIKY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lTFUuDgw7l7bruO7aI3/EUSJ3lJFT/ImpDWquHSO2NmtQGcPj0T090IIINHuIzqoqEZWL6yatxG1DL/N+7tLoQnS22Dl5gwAIzPyHVny75bFMttu9LIWtNQndE8tEI3ok9gmWlcFqnsXS5N00n4Wj8aMavLL14cqgTuUbxxIW7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=JBU8/qc+; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="JBU8/qc+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=pr
	2MS4FI2GOrGg5Ix1007P7ftZWqM4souT4XTzB2Iik=; b=JBU8/qc+InYSzbU24R
	lAZggfd1cdh4Anuk1r1TC79xFg9MQC+LmDrfC+blD1FHqDp3YqGq5HgLuGKIpXOF
	FnMUpj44FDuRVxyBKqwVVusCrjmJ43PHiUn74Gb4/ZEnKHCmsvCaigAO13/GDEck
	PcU6rHexcr/dMnPnB9FlG2XNA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgCX_FcT5dNpElTMVQ--.562S2;
	Tue, 07 Apr 2026 00:53:42 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ring-buffer: report header_page overwrite as char
Date: Tue,  7 Apr 2026 00:53:33 +0800
Message-Id: <20260406165333.46052-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260406162843.41592-1-create0818@163.com>
References: <20260406162843.41592-1-create0818@163.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgCX_FcT5dNpElTMVQ--.562S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWruryxZF47urWrKFykKrg_yoW8Gw18pF
	y5Kw1DK3yDJr1jka4DuF15ZryrtFs8J34xWa9rG34ftF1DXF1DW34a9r9rGr48tFySqFZx
	try3ur95Kws7u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jn-B_UUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCwBbNB2nT5RbTiAAA3O

The header_page tracefs metadata currently reports overwrite as an
int field with size 1. That makes parsers warn about a type and
size mismatch even though the field is only used as a one-byte flag
within commit.

Keep the shared offset with commit as-is, but report overwrite as
char so the declared type matches the hardcoded size. The signedness
is already carried separately by the emitted signed field.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216999
Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 170170bd8..6811dfffa 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -627,11 +627,11 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 			 (unsigned int)sizeof(field.commit),
 			 (unsigned int)is_signed_type(long));
 
-	trace_seq_printf(s, "\tfield: int overwrite;\t"
+	trace_seq_printf(s, "\tfield: char overwrite;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), commit),
 			 1,
-			 (unsigned int)is_signed_type(long));
+			 (unsigned int)is_signed_type(char));
 
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-- 
2.39.5 (Apple Git-154)

