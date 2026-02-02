Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09502F3C22;
	Mon,  2 Feb 2026 09:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770026321; cv=none; b=PGNuJcDP7Z/80OpNtdgGkx/a4QONv+VSBpNNmXqTN/eNhd2TcfBT0OlJh9UzGl8xJd5Sm9Kq6qNDgrYdtNQv0uiF3dhpKr/WCwoMJdKLK687nfZS3qsJrmfXFXRFi7gJTTX10CVZLf5ePKNEkAIp0UTd5Ti71uo1fwIIbj9//ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770026321; c=relaxed/simple;
	bh=cB2rHCtYV6qOIxySUHUz6iQyAuMyZGTOXKzz4CskM+8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rqlMMs7yeJfC2VWIxfMVOlkqZck0XmUCj1kKkHqN3JlYmEKhNqN6C/M1gz3sXC/mRaTCzWA/E13TMMJfrsoDH9u91f7R90p4L4kzkXqcEsOdV4IZMHIwz6LVpb9UI8vDeZbO3oq0lX6CTbZYkUxf7LnVNo3WTm2MeezsBHNlSDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+N7U+sT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+N7U+sT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B48CC116D0;
	Mon,  2 Feb 2026 09:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770026321;
	bh=cB2rHCtYV6qOIxySUHUz6iQyAuMyZGTOXKzz4CskM+8=;
	h=From:To:Cc:Subject:Date:From;
	b=n+N7U+sTgI284joRfla+kJxkaEjJ0meCYFkpqrGrCeQJOmpVKgKjjTzeypppEgWl+
	 QLqp2r2MtfWzsTxsaNuhK4UUkpVvqXR9r2GD1cAgis3DqsTtorFMI0ORMrTTkJFFA+
	 4fVmbqYvR8ck3yF1RTeiCa3S3nByL4UzmFVvlDbas1MeBUU+p+MQ5uknk0vSqho4to
	 G6zPQVcvhc9DghT5wSKoS+oVqQ2LcdE6jsom7uB8qkV3GATkOJtqqnp1zmdP4etppo
	 zZSSnMWQg8eaIIsx1cED9kmWEbjH0zjdqEOGOxelgdXmxaBRfXT98AkdTxNwdkMxUI
	 xu2fAlMlirnbA==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Anna Schumaker <anna.schumaker@oracle.com>,
	Chuck Lever <chuck.lever@oracle.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <ynorov@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: remove __printf() attribute on __ftrace_vbprintk()
Date: Mon,  2 Feb 2026 10:58:27 +0100
Message-Id: <20260202095834.1328352-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The sunrpc change to use trace_printk() for debugging caused
a new warning for every instance of dprintk() in some configurations,
when -Wformat-security is enabled:

fs/nfs/getroot.c: In function 'nfs_get_root':
fs/nfs/getroot.c:90:17: error: format not a string literal and no format arguments [-Werror=format-security]
   90 |                 nfs_errorf(fc, "NFS: Couldn't getattr on root");

I've been slowly chipping away at those warnings over time with the
intention of enabling them by default in the future. While I could not
figure out why this only happens for this one instance, I see that the
__trace_bprintk() function is always called with a local variable as
the format string, rather than a literal.

Remove the __printf(2,3) annotation on this function, as this is can
only be validated for literals. The format strings still get checked
because the underlying literal keeps getting passed into __trace_printk()
in the "else" branch, which is not taken but still evaluated for
compile-time warnings.

Fixes: ec7d8e68ef0e ("sunrpc: add a Kconfig option to redirect dfprintk() output to trace buffer")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/trace_printk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/trace_printk.h b/include/linux/trace_printk.h
index bb5874097f24..2670ec7f4262 100644
--- a/include/linux/trace_printk.h
+++ b/include/linux/trace_printk.h
@@ -107,7 +107,6 @@ do {									\
 		__trace_printk(_THIS_IP_, fmt, ##args);			\
 } while (0)
 
-extern __printf(2, 3)
 int __trace_bprintk(unsigned long ip, const char *fmt, ...);
 
 extern __printf(2, 3)
-- 
2.39.5

