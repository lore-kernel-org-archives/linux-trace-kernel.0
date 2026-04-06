Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B072D0614;
	Mon,  6 Apr 2026 16:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492959; cv=none; b=m3RS6VpJ3wnObPF5w8W2n9Q987eDtSABPB0vMfCmsnatjbocvjclSDjtwPI/wMoLl46uyIuGlc/2FHcWA5FGDcC30kfn8XaQa9jBY7k9QcHSFxvy+H2SgHkqQjfuNGGom4wiG45kTRxEL1Nf0T2FEniVtE6oIZGzI0VRUZs1jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492959; c=relaxed/simple;
	bh=akWfkPK5a5tauwrqPwdUGwGFdvNN/7EvehPYO5oPJ1w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CqUkA+GNgg2Evvmh+j1gZFNiPF4+OTGo7nZBymv0AaXV6OLSB3KLArRDsqP2Dg5zlmhnFax97RGdrZ1a3DzsDXD8oq0wQBR33StGhYvelQJ73GiLvMJCuw5y2aaPDPGxBzpoLxS4nSiMYCvNe5GIq5BFFWt/OuEAZtVyR+IfEZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=qBCDfovZ; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="qBCDfovZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=nY
	usRIiaSUn58yirAVNO43HrJBfohZ6w8Ya8FbplEtY=; b=qBCDfovZgOsfYpO6So
	4JiX+o6BExBABO6Ckl7nC3LS67WJMhAl5A2n0hLlmjVNKceL1a/RW0e/GdeB1CnN
	3JKxcEDGOwCEBoCV1vEwzBRyHKQXN7Cd0GORnOJrr9N0336tI0fzFMa47YMiJgrh
	0ZZU+zjIyz4MlAA5mSbtkbpCg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wCnzKNA39NpEyNyDg--.57771S2;
	Tue, 07 Apr 2026 00:28:50 +0800 (CST)
From: CaoRuichuang <create0818@163.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: report header_page overwrite as signed char
Date: Tue,  7 Apr 2026 00:28:43 +0800
Message-Id: <20260406162843.41592-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnzKNA39NpEyNyDg--.57771S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CrWruryxZFyrCry3KrWxJFb_yoW8GF4kpF
	y5Kw1DK3yDtr1UKFyDWF15Zryrtan8X34xWFZrG34ftF1DXF1UX34a9r9rKr48tFySqa9x
	try3ur95Kws7u3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jnZ23UUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCwAJXkGnT30IlSQAA3O

The header_page tracefs metadata currently reports overwrite as an
int field with size 1. That makes parsers warn about a type and
size mismatch even though the field is only used as a one-byte flag
within commit.

Keep the shared offset with commit as-is, but report overwrite as
signed char so the declared type matches the hardcoded size and the
emitted signedness.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216999
Signed-off-by: CaoRuichuang <create0818@163.com>
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 170170bd8..c4c2361b0 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -627,11 +627,11 @@ int ring_buffer_print_page_header(struct trace_buffer *buffer, struct trace_seq
 			 (unsigned int)sizeof(field.commit),
 			 (unsigned int)is_signed_type(long));
 
-	trace_seq_printf(s, "\tfield: int overwrite;\t"
+	trace_seq_printf(s, "\tfield: signed char overwrite;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
 			 (unsigned int)offsetof(typeof(field), commit),
 			 1,
-			 (unsigned int)is_signed_type(long));
+			 (unsigned int)is_signed_type(signed char));
 
 	trace_seq_printf(s, "\tfield: char data;\t"
 			 "offset:%u;\tsize:%u;\tsigned:%u;\n",
-- 
2.39.5 (Apple Git-154)

