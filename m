Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3DA39FF8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="kXyZKvl0"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35D619E;
	Wed, 15 Nov 2023 07:49:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1700063394;
	bh=h8BeeUtryFB1IFOqZ1UsvXGcEOQuYKR5x0QNoI3HzV4=;
	h=From:To:Cc:Subject:Date:From;
	b=kXyZKvl03+gDeKUqdSSKeziCsZXarIM/oeb49dEkBTgRQB5eMYpSZ3STaUVqhFFb8
	 +9FBDZoBK6fea9UnN7vp9RpaRmFzRHaVfiaqN0LWupVauhLpao0/Sac4vj2cP9ye4E
	 eH4npy5YpuD31XAUD1d1nuhnVhk3EXjQ29l4JvRomuOyrUw7eo3zQsopcrgknVu4pj
	 84Akuu6Fa9CcfRMw0BU8CNHoJBCWm5Fh2YImWSUQWpgz8eaqc+2seK7Cf77EBcu3/d
	 SdU7QWHhI5IK/eFpSCMn2XAg/xHGJYJhqF1Ng1IVJ6ooxh2khhs09tBbKTdGdv3yQA
	 qJWXpapjhKnPQ==
Received: from thinkos.internal.efficios.com (unknown [12.186.190.1])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4SVnfn5vqHz1cYv;
	Wed, 15 Nov 2023 10:49:53 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: TRACING: Add Mathieu Desnoyers as Reviewer
Date: Wed, 15 Nov 2023 10:50:18 -0500
Message-Id: <20231115155018.8236-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to make sure I get CC'd on tracing changes for which my input
would be relevant, add my name as reviewer of the TRACING subsystem.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cc6bf79fdd8..a7c2092d0063 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21622,6 +21622,7 @@ F:	drivers/hwmon/pmbus/tps546d24.c
 TRACING
 M:	Steven Rostedt <rostedt@goodmis.org>
 M:	Masami Hiramatsu <mhiramat@kernel.org>
+R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-trace-kernel@vger.kernel.org
 S:	Maintained
-- 
2.39.2

