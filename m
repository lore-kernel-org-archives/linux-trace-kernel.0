Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C64195;
	Tue, 31 Dec 2024 11:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735645371; cv=none; b=XjRc6iZr5toGCiJXVuNihm+yBmU7hJgAQR5jnOH3lK9oWPWU6UH4kQKr35FmQJ0WR+qTLoeL6o87eD9kT9l/fk+K18c0rWUv0ZriP/xcd2gTF2YTRuZK4rtRgqEDsvBCEIUe6V7HLg0/UsVN2VPEty4gg+JynQwwj1PpUA1odVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735645371; c=relaxed/simple;
	bh=QNAsIH9AftPR2ALNeY0MPiMVOLsvYgKLZG/mCKYz9ok=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f1aGI2LQc4LLCQ0RGsw9i+QbXQiLRGOYvWlqLTouSUhgcSbFJTRaPmaCg0EhQoxdp9mW6zlOGMDd0dNAYB5pBjYyHZ2ttbtr7DW89K9B4zM70bk7hdstyxI13ZI/LzBqEN+Nv5qeEMWtmSdlTLXtGWnEIOUYWAj2L726YjMhkpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=YMZtc2pm; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="YMZtc2pm"
Received: from localhost.localdomain (unknown [202.119.23.198])
	by smtp.qiye.163.com (Hmail) with ESMTP id 754d3d8f;
	Tue, 31 Dec 2024 19:37:34 +0800 (GMT+08:00)
From: Zilin Guan <zilin@seu.edu.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	Zilin Guan <zilin@seu.edu.cn>
Subject: [PATCH] kernel/trace: Add READ_ONCE() when accessing fgraph_array[]
Date: Tue, 31 Dec 2024 11:37:31 +0000
Message-Id: <20241231113731.277668-1-zilin@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCGU5CVkxPGEpMHk5IQx0YSFYeHw5VEwETFhoSFy
	QUDg9ZV1kYEgtZQVlJS0lVSkpCVUlIVUpCQ1lXWRYaDxIVHRRZQVlPS0hVSktISk9ITFVKS0tVSk
	JLS1kG
X-HM-Tid: 0a941c81c5d403a1kunm754d3d8f
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PBg6Gio6GDIRKTUwCTcIEgEB
	AhwKCiJVSlVKTEhOTU9OS05OSEJCVTMWGhIXVQESFxIVOwgeDlUeHw5VGBVFWVdZEgtZQVlJS0lV
	SkpCVUlIVUpCQ1lXWQgBWUFKSE9MNwY+
DKIM-Signature:a=rsa-sha256;
	b=YMZtc2pmb6r6SkrOndQ+lqcJt0Wa7Jo0slu0lFgVqBINCgqUEn0NWLx+WaEIIhOWOUeBAIJFeYuXdH5xhQHSX73L77qzsNeCipowF61XObavke9RYlaeCZ8xZW48u5ZOvc19jhhrlSLXyItdeZzlMEkwCYm7XC0OdEYZvYtubzA=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=yqC6Ryy5mRt2AOFqgXZi0SSFvpHkE+C08AlwMiIhc94=;
	h=date:mime-version:subject:message-id:from;

In __ftrace_return_to_handler(), a loop iterates over the fgraph_array[]
elements, which are fgraph_ops. The loop checks if an element is a
fgraph_stub to prevent using a fgraph_stub afterward.

However, if the compiler reloads fgraph_array[] after this check, it might
race with an update to fgraph_array[] that introduces a fgraph_stub. This
could result in the stub being processed, but the stub contains a null
"func_hash" field, leading to a NULL pointer dereference.

To ensure that the gops compared against the fgraph_stub matches the gops
processed later, add a READ_ONCE(). A similar patch appears in commit
63a8dfb ("function_graph: Add READ_ONCE() when accessing fgraph_array[]").

Signed-off-by: Zilin Guan <zilin@seu.edu.cn>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index ddedcb509..30e3ddc8a 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -833,7 +833,7 @@ static unsigned long __ftrace_return_to_handler(struct fgraph_ret_regs *ret_regs
 #endif
 	{
 		for_each_set_bit(i, &bitmap, sizeof(bitmap) * BITS_PER_BYTE) {
-			struct fgraph_ops *gops = fgraph_array[i];
+			struct fgraph_ops *gops = READ_ONCE(fgraph_array[i]);
 
 			if (gops == &fgraph_stub)
 				continue;
-- 
2.34.1

