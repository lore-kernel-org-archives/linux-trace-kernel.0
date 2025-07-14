Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E812E371E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 14 Jul 2025 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752479754; cv=none; b=BvHj/2jML6vTW/vMpuCSu2+sIDBZjFDEyirkVD+OYKLg3PrjrAGPCuULmw6QU37J0NpqqOzhrxHCXCISlNJhQlojFkOCuzzBGKnQ6iy8J2PIUxQK+9mniP71P4f5kE7U7Ybx9lbba3F5TesMJtzqF8MAvQwB6xQFjHtXEgARbkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752479754; c=relaxed/simple;
	bh=B9h3hRprYcgNci58s5419jngt37Jl+qroxT5D0K6igw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OtK54KVdvUApu1G5di+Krzw0AmadyZMMdSHLnScSQt2rUe4/rHqK+2499rimcviOjq/X37q9lNcuata4BWAvfB5h6rxa44+Kp0hGcOSXaco43P4c0DOtFfMfgefciOZYOgqY54OErQSfrVCsuLcO+HQ/+djZgHVNwphpVbFZBfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=frUvedzU; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="frUvedzU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752479740;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vPxMdQC2ns7gLLrlIIRncvrzyqThLyDSkJC6jrXOdSg=;
	b=frUvedzU1obDUzjEFU8sjsjN1f9OWS11jTPC/KrOtlg/xagLHMHyI0zOQNup5GG1uuIe/W
	FHK0i9sBgNmhYofDP/I0MvsdIRDS5+mfzL7qB5TGYcmb0Txk3QMaA5o7wuWG7jNi8NbYyt
	xvAN244WjrQK0TySQQjDBnyn5ebpMOk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Guillaume Nault <gnault@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next] tracing: ipv6: Replace deprecated strcpy() with strscpy()
Date: Mon, 14 Jul 2025 09:54:33 +0200
Message-ID: <20250714075436.226197-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use strscpy() instead.

Since the destination buffer has a fixed length, strscpy() automatically
determines its size using sizeof() when the size argument is omitted.
This makes the explicit size argument unnecessary - remove it.

Now, combine both if-else branches using strscpy() and the same buffer
into a single statement to simplify the code.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 include/trace/events/fib6.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/fib6.h b/include/trace/events/fib6.h
index 8d22b2e98d48..903a18836bc6 100644
--- a/include/trace/events/fib6.h
+++ b/include/trace/events/fib6.h
@@ -64,11 +64,9 @@ TRACE_EVENT(fib6_table_lookup,
 			__entry->dport = 0;
 		}
 
-		if (res->nh && res->nh->fib_nh_dev) {
-			strscpy(__entry->name, res->nh->fib_nh_dev->name, IFNAMSIZ);
-		} else {
-			strcpy(__entry->name, "-");
-		}
+		strscpy(__entry->name, res->nh && res->nh->fib_nh_dev ?
+				       res->nh->fib_nh_dev->name : "-");
+
 		if (res->f6i == net->ipv6.fib6_null_entry) {
 			in6 = (struct in6_addr *)__entry->gw;
 			*in6 = in6addr_any;
-- 
2.50.0

