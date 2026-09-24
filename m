Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2CB42047A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 08:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790239804; cv=none; b=qObbKwddsxyG7c+8hoSAQE5kX2/byNJ+OZnGlshH4GamEgaCI47bs7rfMW1bdrz3UMUTUh/EJsoFpBnfJQFAvRjMzlVX933trx9gxoVNwhzb1GswMe2UkUsUgdxePub/yFoq6GWhRVRqsHgt4Fclf/FbY+GvYzVJ4Tlj1vDDIpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790239804; c=relaxed/simple;
	bh=RTolrfWc72Cy+7e76YB0IcJJ7ooAp/AC6TNHC4OWuek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9Ahav3AgZrzyUlsxcRthYwIHI0pF1jYnatc6qqknGZuMBXrpRtyAzznC+8bne2357JEV9FtJiRtlkOb+Pj18qWb4QZGdWIlfkG2VI3F7Gf4Nq9WqdA0ntDWw4JN84GJrYN7pk0aDLNevTbYiyw8BUGNvgBMwjEXDF3UMGpQOGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jafwul+S; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jafwul+S"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254fa650c8so302742666b.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 24 Sep 2026 01:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790239793; x=1790844593; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1b80XxLjp7p9yNMOdcMsvgCe3vPig69itQP5JgqdKTA=;
        b=Jafwul+SrWbPqylyk3BSzRFTLwdO1lJQ9x8haOGRLwml/+NWYex0mAOMwqoXSMkJ6w
         K33SlGpNzvke3QpP3WRd0873Q8tlas8vy2ASdDxNWM+t2AtfDQqk9o47Rmx5jrAjXfrM
         fS8K92sqDOToh+LJ7Ri2A1OLvwlLfrtMJjROFA9YvJ1T1VZnE/oIGC34ORU9FE2pMRG2
         B9agHW/BWMzjPCDgLka8uH70wepXsxpyLNpaRdUl1omVKU8V4W79yx6iA4gF5G9MkUBi
         2s8C53+sSTfJGLVh2v/GKKfnjx98LH6fnh5kRzQiAnTqoEHGmgbmoKSKAZ3D7do0I9ie
         JVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790239793; x=1790844593;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1b80XxLjp7p9yNMOdcMsvgCe3vPig69itQP5JgqdKTA=;
        b=rEfWwPOKdIFFcrTN197lApHRH+8cAMXmqH0aTMJT05fO3jTMQjpENBl4JOkDCoNA7b
         7ngJ536YSLY2omjUtVBJ7hyQY3GSb7O+/Nc21cleMCYJmblYp0QKRDSO8B8LQ0hcN7G2
         ItaYnBbEajF4Yd3EAerLiE+noTf8USQN2Q1KoJqz1zk8VuCs9ujeRA3dYQ1Vz+iaO/qx
         BDzWXKJuMEDiQdLH8LLhOklhFXL9hCcFMbbWZSkbHJe/wHwADDhBjOlWcdqk538T+NKV
         /aGSZzSggDJACW/4sf8LjfBHhjx4I1JzV8SrCcTwyeoJIXKvnkAnfoOFkR9m/rdQPAO+
         foyQ==
X-Forwarded-Encrypted: i=1; AKwUvBzsrSfgFt2bICUtU2ZC32DWTfALF25YFIT+sEfHP64UsHX50yBDF/ctqBDdG08rp2gcvO9f3L0KBbQVkR3TcnAjA0c=@vger.kernel.org
X-Gm-Message-State: AFuF++n/gq/2plfaxkqZMrTRRMdRm4LNRC3nURxkRaxiuS5/nJsXaQZH
	WuhyDUjQqB+1HXVY/8aJT7INOZ1wXn/7ZniLU3Fb9XMuImZTHUw5g0UZ
X-Gm-Gg: AYBFou3aLCDIVpQPIIAhu/+mEkbF/I/aQSOSi12/BX8mqFxikFXwNdwXtL7jCmN/gLx
	XYFX+HdMavcQSR7Nt92ykgDBTHUWwWIiNnwTMLroQF9B5i43sGMQLktpZzX8UicxBE9TlKsQRnZ
	c50GcvPA1KZQoPwhK05qr6A74TXoh03Nk0FCPf0l/t0IF/JyeslG5sbSOYGwQ/VW4nAvG3YY/QG
	gj3Q/vT3H+kuJtGDxrCv3yL1gapWGLUVH/w3bAnsmpjLA2uwoNMBhjxsW4ddhGIKXLWjj684j2v
	PcTWKj9tU1la7Yw6PwrPUEzMFFy0dRuiPeeyb0fOUMCMSz4AZ40EbdrI/RF35GV/R6077ftmvMv
	ZR8khmAyFhscfuu7e7lJIZapDl8WRfZzBfjedZoZntBkt7o5ALTzaRuX8T/pSfQBZU6KRHQs1M4
	V2NvgUSxYtn62PXE8oUHGVkM7s3419Pjd25FFRhkcl2bdsJbEDWvH+bOS7/K3+Tr/5vkmB+PYFg
	t29NnrJSvvpID4GImOF+dl4U+lf4nda4ElWct6B8NlMtYZZKHOs5lbhM5U/LH6aAyJo3tuF3DKT
	rXnhaV4t+bIQywDO8l0NAOQx2z/WHM9pG7o8eCXgiqhQ7qNkM6NC/u9Us5hpsLE9nHT+3n9uQMo
	68MKEUtFaMnzeSq/qzB0gqX6sGIxNJL0ieZamZB/ddg8ouvcnzYg=
X-Received: by 2002:a17:907:7214:b0:c25:c54d:d1a2 with SMTP id a640c23a62f3a-c2ac23c0f05mr127635366b.18.1790239792459;
        Thu, 24 Sep 2026 01:49:52 -0700 (PDT)
Received: from Ubuntu.ts.net (87-205-15-91.static.ip.netia.com.pl. [87.205.15.91])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae687318sm266221466b.44.2026.09.24.01.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 01:49:52 -0700 (PDT)
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	syzbot@lists.linux.dev,
	syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com
Subject: [PATCH v2] ring-buffer: Fix false warning in ring_buffer_map_get_reader()
Date: Thu, 24 Sep 2026 10:49:42 +0200
Message-ID: <20260924084946.20104-1-krystianmkaniewski@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <15bc282f-669e-4a94-911d-bb435513461f@mail.kernel.org>
References: <15bc282f-669e-4a94-911d-bb435513461f@mail.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The mmap reader can warn when it catches up with a writer that is still
committing events. rb_get_reader_page() returns NULL in this case, but
ring_buffer_map_get_reader() treats that result as an error.

The initial rb_per_cpu_empty() check filters out an empty buffer, but it
does not guarantee that the next reader page has committed data. Writers
do not take reader_lock and can advance commit_page before publishing the
committed length on the new page. rb_get_reader_page() can swap to that
page, catch up with the writer and return NULL.

Handle NULL through the existing no-data exit without warning. Remove the
caller's reader_page == commit_page check as well, since the reader-page
helper already handles that case. The existing metadata update and return
path remain in place.

Fixes: 117c39200d9d ("ring-buffer: Introducing ring-buffer mapping functions")
Assisted-by: Gemini:gemini-3.8-flash syzbot
Reported-by: syzbot+de3d7f9bcc9212f3fae1@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=de3d7f9bcc9212f3fae1
Link: https://syzkaller.appspot.com/ai_job?id=488adc18-a10e-42d2-a205-25327c38837f
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
---
Changes since v1:
- Rewrite the commit message to explain the race more concisely.
- Clarify why the earlier empty-buffer check does not exclude this case.
- Remove the redundant reader_page == commit_page check, as discussed
  with Vincent. Let rb_get_reader_page() handle the caught-up reader.

v1: https://lore.kernel.org/all/15bc282f-669e-4a94-911d-bb435513461f@mail.kernel.org/

 kernel/trace/ring_buffer.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 9c03a555a6ba..9222fc881bc2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -7990,12 +7990,8 @@ consume:
 		goto out;
 	}
 
-	/* Did the reader catch up with the writer? */
-	if (cpu_buffer->reader_page == cpu_buffer->commit_page)
-		goto out;
-
 	reader = rb_get_reader_page(cpu_buffer);
-	if (WARN_ON(!reader))
+	if (!reader)
 		goto out;
 
 	/* Check if any events were dropped */

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.53.0
