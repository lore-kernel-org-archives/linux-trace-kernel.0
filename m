Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9688E1FF1D5
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118533; cv=none; b=jSXq7kfndlhLA9tlW2UzHZHgBXHkrl3y3XjT6ZhxeqoDOU4gxVP+O7I/epnBpkh8rczBJ4gvT2w9o30lScQhQwPicVYOcDC70RhlnX4ErXw0qhkwhhs2BkHP0kC1abPzEJCKbjlrsJTj6AOD9zzjAJuV7/7aeDrI9jGv+U/MhTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118533; c=relaxed/simple;
	bh=X8anZV27FZCgXW3F5EqnL5fY9LwcbNE90sBSOU25nzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=Amgy5kR49pDWrgj5uWRAMG4eK5YBX/wS9TMV7TgdD4CATa80eO8+iE6GnPi6uqWHLbyiz5JrErh7N5yuLiyUnmfAwcVDAm3KYAEddrPaVgmZ0XwzBF9nM+PgXsWcV70ejUtb7IObRCtXOyezOCQIpygGCsLugvxZaf5jebwQK40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HzcHXJ7i; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HzcHXJ7i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737118530;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=i/Ub09OUl9RsJ71owNWlOANuCEZ1Ov31/V75zShlIM0=;
	b=HzcHXJ7ia2pFLLIZjRNnanIFkL4dplrrWj7ILU8l7PxDOlAVPF29hBaPVDt6HpjYPzfAbH
	p/z9YJNjqhC/IXxY6CJgiaTTE4FOgASNI2nx7UbfE0c4c6wwqQjlvKb6hML2m/HGO7jzCv
	womxmmmkUS/2SKJwbSxD4BLmJ3/+Qc4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-QCyKolcVM7iABIUWUzO5Cw-1; Fri, 17 Jan 2025 07:55:29 -0500
X-MC-Unique: QCyKolcVM7iABIUWUzO5Cw-1
X-Mimecast-MFC-AGG-ID: QCyKolcVM7iABIUWUzO5Cw
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4678b42cbfeso39471301cf.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 04:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737118529; x=1737723329;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i/Ub09OUl9RsJ71owNWlOANuCEZ1Ov31/V75zShlIM0=;
        b=CouMUQ0fk6UxrlMj5bSQxZBt7JkpxoZLurAt1eeH1zQ2c4GRN2obsxPCMORohR6PKF
         qWgvBLmZDqgydMZonnBfFXPlLQG0pAHx1rCTkaLTFWmqpLWpPe5V9bymM+TUXU48gVjN
         7PUqLHiK5uTvtCegiqXReUhqFlj9afCZHyxz3fa9gyDZKOKMQvtwnV78NnhcaVHAFvJf
         4Vte8qkl9beXmcLM51NyhpAARis53xvVTycYguU9vSRvmvQYUFV04mTFJVQUMtume/R8
         8FPipSfbWwLr4WAMv+IEyvQyGl4tF9wib7m4R2w3Yif/u0WPysSGHnaRRaEEg7Xpgv2q
         PCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsD6ey7GiwF/Rfr4s0DIpg1PrWMzE4ZQpqZA8nPS+92Uf5lHWzvNlki4Xs25/1WCv2dKj1BeyvyK/cM6aZ5ej9mBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzegDkUgu77XuyyJm/oXUoKn1/3wKxnkxVKTx8kqFI2jgzthlR+
	KBtXu7zfCKJmKr/yPWzwPs6VcCmPF1Kw9zVtWaZhGcT2TYTBlBti0Kt5A2hHntsdy9gkBgWh0h1
	TcIfpx5YcVb2oni/o9r82q9eA3fwF/+Qw9tAQJk7gFc70fhe+5lAZFKgLnKr2HGulotGw2w==
X-Gm-Gg: ASbGnct53vUA2OoWEHFsidJY4IgfH9CKNwngQSt0qqa1hyN/PnpduMgug7gQiYBWqu6
	C/4GDi6xJfRZwa4tmKlFrcnFCtB+ojDSoNFmTbs+x/Vr5LM+Y0AuO03WQ1ZCZZ1LtYiDw2xbDcH
	E7tiaiyM0xwpZ0cp37Ra8+UcH9oOj2Uhg2lGzV/eE0s+2/ObAvQME+JbPOHRA4bQRZCrfPO+UFM
	9kcERomhuObJysAwAedH7uvnHuQCmFWJyDCDl40ILgKo8jKutpLfyI91dfETWrseBNq6YWn1EIa
	tzJBNT9SVYa3bXxvJAF58dk=
X-Received: by 2002:a05:6214:3197:b0:6d8:8a01:64e2 with SMTP id 6a1803df08f44-6e1b21e2e0emr39493916d6.43.1737118528988;
        Fri, 17 Jan 2025 04:55:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx3VOtr4krB36MByyqD5emK2TbJbOECiK3nFAsHVkyKtYlRN7uMRhrwZIBRHacmF4EwSlKuw==
X-Received: by 2002:a05:6214:3197:b0:6d8:8a01:64e2 with SMTP id 6a1803df08f44-6e1b21e2e0emr39493606d6.43.1737118528701;
        Fri, 17 Jan 2025 04:55:28 -0800 (PST)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([66.187.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e1afc22d3bsm11032406d6.55.2025.01.17.04.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 04:55:28 -0800 (PST)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL
Date: Fri, 17 Jan 2025 07:55:22 -0500
Message-ID: <20250117125522.99071-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xLwV7jHTXMB8-uGNkgbdsmYl3oT4Q_Wb5Hb_WmhbQ7U_1737118529
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
replaces the config HAVE_FUNCTION_GRAPH_RETVAL with the config
HAVE_FUNCTION_GRAPH_FREGS, and it replaces all the select commands in the
various architecture Kconfig files. In the arm64 architecture, the commit
adds the 'select HAVE_FUNCTION_GRAPH_FREGS', but misses to remove the
'select HAVE_FUNCTION_GRAPH_RETVAL', i.e., the select on the replaced
config.

Remove selecting the replaced config. No functional change, just cleanup.

Fixes: a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed3eca8..940343beb3d4 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -225,7 +225,6 @@ config ARM64
 	select HAVE_FUNCTION_ERROR_INJECTION
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_GRAPH_TRACER
-	select HAVE_FUNCTION_GRAPH_RETVAL
 	select HAVE_GCC_PLUGINS
 	select HAVE_HARDLOCKUP_DETECTOR_PERF if PERF_EVENTS && \
 		HW_PERF_EVENTS && HAVE_PERF_EVENTS_NMI
-- 
2.47.1

