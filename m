Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCC23E8324;
	Tue,  2 Jun 2026 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780412977; cv=none; b=gruiJ16NoPp+0u412Uo7O/dQGm+JHyivhprJtMbelZ2KfMInepn3dJ8lYJCJOj/1wxmQWJVIjnjqn/HdA7C4X9dEZIa93qw93i2Apn4IvZCmR/DYZ5mSpaBtnWFMBP8K+nqRBTt38p5UdaW6Tuc353JZogjBWpBHev+PBlS4qFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780412977; c=relaxed/simple;
	bh=ioOPceM7UKjOwl2Pt8ZqxLBsrY8AJhg/6I6pX/zRfaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qkvyFvjylCSLYmT6e2ayOHnkwneJ/5sDZs/7Luh29ug63wI1I2otxgo0z/Peepxk72cioiGM8qNhM/fIv56wVafo4JHt2PyEpJ6c4wNDK9KqBjsBHSZX4XsL+wXD6RFW4PsBTY2RPGB2wpd3Gg/UUNs5R3hHmLzU6cp5+Z2nn+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fz44U0rD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fz44U0rD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748F51F00898;
	Tue,  2 Jun 2026 15:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780412976;
	bh=wxC5GQazXkSfb4E/OyxULD1lrIQbuxRHv/6QFM17duk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Fz44U0rDiRqSgWPZbreC2SbhJMeyXA3A/CK0XpbHhwbaslwwcktqSapEdrkr8N0rY
	 6ouDC223bJ+DJPbOSvz0FrWcfFdq+uNIITZYox8cpT/smrU7Z/pNUhUndTquMiu7Z4
	 Py9s14z/y5BXQcBBuR71IqI2tP6rr+ZNWD7RukzYXTXP5cfc0Jd7Qh6SdTsQDQ/CBb
	 x8ExnSsCggYoCp9ALSgHL2wp2BBLNIyji/izPOKBr0psUGrIsEDXPBnLk+grCg5WCK
	 GC25ZcNE5xRfwoFTU67+MYiI698wHs+ppwu+AhZZxyQstWoYYhw9m0xxiPYNkgc39U
	 oj3J4vNuhWfaw==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Crystal Wood <crwood@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Wang Liang <wangliang74@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/2] tracing/osnoise: add printf attribute to osnoise_print
Date: Tue,  2 Jun 2026 17:07:06 +0200
Message-Id: <20260602150904.2258624-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260602150904.2258624-1-arnd@kernel.org>
References: <20260602150904.2258624-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc points out that tne newly added function uses printf style arguments
and should get an attribute to allow verifying the format strings for
its callers:

kernel/trace/trace_osnoise.c: In function 'osnoise_print':
kernel/trace/trace_osnoise.c:96:17: error: function 'osnoise_print' might be a candidate for 'gnu_printf' format attribute [-Werror=suggest-attribute=format]
   96 |                 trace_array_vprintk(tr, _RET_IP_, fmt, ap);
      |                 ^~~~~~~~~~~~~~~~~~~

Add the attribute as suggested

Fixes: 9cb99c598643 ("tracing/osnoise: Array printk init and cleanup")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/trace/trace_osnoise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 1fbd8525ab54..6fa015e57899 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -83,7 +83,7 @@ struct osnoise_instance {
 
 static struct list_head osnoise_instances;
 
-static void osnoise_print(const char *fmt, ...)
+static __printf(1, 2) void osnoise_print(const char *fmt, ...)
 {
 	struct osnoise_instance *inst;
 	struct trace_array *tr;
-- 
2.39.5

