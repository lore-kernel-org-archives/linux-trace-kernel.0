Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECC72A1BB;
	Fri,  2 Jan 2026 19:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767382299; cv=none; b=TAebMlTqxOgUuAkWXAtWYebMaOnJ5tJuvzDO3xz8wuR8obh/L1kaurEw2RFCABz479mXsNwflbH6ZKIngUCdT8Nri9FnpHtLstRAGtM3UGG/cvnnPu+2rgvD+rCPhNHURI7Ecapz6itGH6zIdUCwzixQH7BWSPPx36Iwgn32950=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767382299; c=relaxed/simple;
	bh=EfN5hdup5v/WVV0Va70goiCNOxcElw6t5jwjSNIX9lI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=riWtOIkp5Fw5VQO6o1un4h3dyDnAc2GQFLIq8Q1nZqdvyoo00sOGwE/gJHUxk3bk9pYW2zvvBeDSi+sIEJeouC0wBHoQ6lY6Kxv3oVlfsUz8uiqpMwhQshMOpkEEVy0BmdOSElCt7YTus/3mXS8/SmMdiLyMznYL02Yy5E7WxpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 47531140353;
	Fri,  2 Jan 2026 19:31:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 7311260010;
	Fri,  2 Jan 2026 19:31:33 +0000 (UTC)
Date: Fri, 2 Jan 2026 14:31:48 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH] ftrace: Make ftrace_graph_ent depth field signed
Message-ID: <20260102143148.251c2e16@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 7311260010
X-Stat-Signature: o4ega1747nb493ahgkp571bsjd16xmps
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19g3WGXFwqX5v2huaMvYmb6+pekEiowmRU=
X-HE-Tag: 1767382293-424486
X-HE-Meta: U2FsdGVkX1/68ZtCOWMcMTAeT8WhJW5/JZSTD9D1dARRC9MwFVIxamO3MLISPbTwGdZYGTNUQOOBlyFlCed4NfsZmLmI1Qbucl+zZsmcMXjL9cUqr7dsyZ1Jqwudn6hs+lxNh0HqLNXiJACnZmHsE7trNRInHiVex4YzGQCkiKW2uvsmxfszSZ8uCtEFlpszr5ZyZRhAjPs0uXOXZLV/fX/NCm+Ja2OwgRQpM1Hxpj5BisE7q6putVUHr0KNTI2as37nAOE3vxTwU+6SuwKrq6JbU333Jl5J4ZaxfK3WQyYipOpw/MpNIU3PX6B0lHMK8ToelvWktjwhUkODTImC3SIukCIzalnPO19vek3fDIyFkhyStxYOv1fhz696yKbbjcL4/DI13CN+EyBjFSexnyL4t0sRbEjpPdyEYgvFRdTQ0qcno0S3jCoCLy//Qu7IX+XvEPwAyeq/58eqmqKDcg==

From: Steven Rostedt <rostedt@goodmis.org>

The code has integrity checks to make sure that depth never goes below
zero. But the depth field has recently been converted to unsigned long
from "int" (for alignment reasons). As unsigned long can never be less
than zero, the integrity checks no longer work.

Convert depth to long from unsigned long to allow the integrity checks to
work again.

Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/all/aS6kGi0maWBl-MjZ@stanley.mountain/
Fixes: f83ac7544fbf7 ("function_graph: Enable funcgraph-args and funcgraph-retaddr to work simultaneously")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 770f0dc993cc..a3a8989e3268 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1167,7 +1167,7 @@ static inline void ftrace_init(void) { }
  */
 struct ftrace_graph_ent {
 	unsigned long func; /* Current function */
-	unsigned long depth;
+	long depth; /* signed to check for less than zero */
 } __packed;
 
 /*
-- 
2.51.0

