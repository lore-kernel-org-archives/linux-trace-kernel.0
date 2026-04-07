Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6803A75BE;
	Tue,  7 Apr 2026 12:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775563960; cv=none; b=YvcY/jLVjsIcaGXTP1PK/CUuhDinIYmnGM9TR5KiFfCKxEhGSZxaTLQeaMdme61fy+Vu5TBIk+clq1QEmezFkFWgIyl173Pkw7ke5znE+ev/jBUrA1RbgTou3QDUOMIRa/flgp0AcbQf2XRey7wq4hSRhyGLwV2w8zJBWHKG/ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775563960; c=relaxed/simple;
	bh=oHaYJKEeJ6tC87yIRVb418Uer3snAQOL/vVIqdTaZrE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kLIVwlu0XfTxx5JaMoZ4Y1iFiVkSb3w9zkv7lt6U2F/ubl5Y19mUIb3hsdGcGANjasX2P52hPOp4EIHul1yNbEwnBsqTiuiLmUdA7hM8XzDOdQ0czflBJhudm4zZEOPHkpC/HwpPOlHP+vWTIVSrTxRjkyC9B070QmoTyoA90rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=WNjZbheR; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="WNjZbheR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Wf
	Z1YPNApqOpiOodsxcYvd7rQOq083lk2BF9//v+j94=; b=WNjZbheRFPDfZN8XpM
	MZERxdLe4jni11d9Dk9qv8d/87LqEXXh7VLxDqV0ttvWcZattFIIj4Pum1LpO9ck
	Kf5lKhDtSZ3yHW6THMwGFUdTvMa/u5C2tOmvh8+cPurxCnOG0uE5x2b+WRenDKx0
	JyQh8a3O0G+gFSESKn41Fabpg=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBXKR+F9NRponppDw--.13830S2;
	Tue, 07 Apr 2026 20:11:51 +0800 (CST)
From: Cao Ruichuang <create0818@163.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/ftrace: Fix BAD_TP_NAME marker in fprobe_syntax_errors
Date: Tue,  7 Apr 2026 20:11:44 +0800
Message-Id: <20260407121144.98992-1-create0818@163.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBXKR+F9NRponppDw--.13830S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1fWw4fKF48Jry5tFyxKrg_yoW8GrWDpF
	yxC3ZYy3Z5JFyxKry8JFZ8X3W0yrWkArW8Cr15XanxWw15JF1DXF9xGrW2gr429rWkt343
	uayS9ryxGFWUWrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UG4EiUUUUU=
X-CM-SenderInfo: pfuht3jhqyimi6rwjhhfrp/xtbCwAjuKGnU9IhTjwAA3T

The BAD_TP_NAME check currently expects the error marker for
`t kmem/kfree` to point at the slash. Current kernels report
this parse error at the start of the invalid tracepoint name,
so the selftest fails even though the input is still rejected.

Move the caret to match the reported error position.

Signed-off-by: Cao Ruichuang <create0818@163.com>
---
 .../selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
index fee479295..e51f642c3 100644
--- a/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
+++ b/tools/testing/selftests/ftrace/test.d/dynevent/fprobe_syntax_errors.tc
@@ -27,7 +27,7 @@ check_error 'f:^foo.1/bar vfs_read'	# BAD_GROUP_NAME
 check_error 'f:^ vfs_read'		# NO_EVENT_NAME
 check_error 'f:foo/^12345678901234567890123456789012345678901234567890123456789012345 vfs_read'	# EVENT_TOO_LONG
 check_error 'f:foo/^bar.1 vfs_read'	# BAD_EVENT_NAME
-check_error 't kmem^/kfree'       # BAD_TP_NAME
+check_error 't ^kmem/kfree'       # BAD_TP_NAME
 
 check_error 'f vfs_read ^$stack10000'	# BAD_STACK_NUM
 
-- 
2.39.5 (Apple Git-154)

