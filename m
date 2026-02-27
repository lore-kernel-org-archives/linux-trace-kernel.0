Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA34144CF51
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 19:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772221499; cv=none; b=iDXxeeNcp58uwsAJnKFaP/iijzW8/HYW/e6IjmDvKe0xmQbECtOGfGS9KddW7GuA1j0R/aIeLMwIYWRCSho/+3tnwuznZ4En+hAnssuV3PTuTuliH7rhhAbBRHtvOyFt58PcvC+S9v1GPuuqhJU6qucRremhWaP0fLvqk+bRm0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772221499; c=relaxed/simple;
	bh=sGukunZf/yiMmIshCxlQIMKg/jvcuH6/Gbp7DaGc8JE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n21PEG7sXtsPq9xdfghWfnMQSm0FJJ3TGVmEl257F6aN/OalKI23sApaXNHQHFdz/UNvMCBJYV0Aixy87FwnhVl7oDbhxWCTyd8oUbFmzoyndnACo7JBaR2mTIzEm9mcxAyh2Q1YqS3B9m3ygUGRzwCFfLU9Qv8/dVE71r3jjos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INvDwP7d; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INvDwP7d"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7986e0553b0so22993557b3.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 11:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772221497; x=1772826297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qfiXw09aKYFd8mOuaxrb+P18U9WKXR/TPhCnApMgZ/s=;
        b=INvDwP7dBVCk8AhZp/EVu8xwH4jKFR8oxHhhOF8M2cPfK2AwP7mwzIfPXEDWbQ2Fy2
         TNM/RU+OAa4XwgwQIxfVV76pe0VDCmnTdJgGJcZOYCdD+L4G4Cc5FpttmAD40sGW1PqL
         7puX6OtiLURYV1S5otWmgbLQHMC15k1Ly59LNYddsQ/vb2A+7OcTJZb93l4YQ92kauVM
         CF5V+VpH2kjS4Ieg10NT2xV0kQvwzC5ip8684T5dRlSf3WdKUzUomaqYvl2D0A+5oVM8
         klnNY1KBjnE92ciDQA5EjxCL3w9O/jNo3atJ+cE6foZaEVs9ya7ipb00SLSud1jAACfI
         JhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772221497; x=1772826297;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qfiXw09aKYFd8mOuaxrb+P18U9WKXR/TPhCnApMgZ/s=;
        b=fQtWkl0yj+2PjT5mzsbazI5rdsFXlQ9b/x9/mdJnVK+u/JIYU1oDcOkUHzeK9JwBhT
         U8Bd60xZIunwGO8kg9dejg2j17pmb1hVgoJAfnLOulRdy+eLj870MVfM+WWA3eqSp9+B
         e8mDwfCsJzKi2Gi0WjwW7TYqCDcfqohTd47bfPa+KMvvr8vLU+lGTgdW+syai9RioPnT
         F0MAwycVC65LPwKHuzCkawOYxZcn0r5f4fhv1QQfF4TU35vs3MGo/FlDILtf7VlO2cxa
         SUh/Gm8AbSQgyTVpdlm0Zg7pz3OJMxgqqJFcR9AlHDwhxG0O4Yq39OIGaFhMfbX+gPrb
         34mQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0cqTfuhUpubw93C8GeVzf3lQ7Ft+Wc6vD1sYAjHg/0vvBlTdxkVKrjSOKkMx7MkdKC5TpdRYdd3A6ROBfzrO6Spk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDeP6bxoCXmMb4GQGLSxG/Vv4NqazaJYJU/T92l9xvCwU3IzWA
	dBh/4Vaw1zIsjMKAEO+yTrhdbRyONu6FawNXMYuXpnJT8RYDz6o3S+sz
X-Gm-Gg: ATEYQzwjeDwRmfyuSHtAjrXvOZA78XBuvVcR9PxxmOaf3MCtcqHzgh1+4nyIZqGO3CO
	+5saBHE3GR556+IqSuSS3xEmF2Vm2myYQSOLT7jX3uTZC/MkU3bCKTtmB//hXvJWrxVmdEcC/Jl
	JMP7rFvXvVgRAJsvD6+tBqbHArS14P/G+t4CzGW+gUwU09Qb2WJGOdsRhVohe7/sx+O6ZOqh34+
	cZKX+qweMuz7Xj03V/GE2hwhaTWSqEHj4s7u6ymkHYdH96edJCd2xUO4hFINIAR8EhM/7DyCn/7
	+fw3yRmYYeTtJSt0Wvc0AjdjhhHGT9jkkNXuYxQTOLU/eI19uN7HbERx/k05a2TigV7FDZb040d
	3LvkjJihCfn8e6y0bINAncA4E3yqy19BRDqe2Es/mJZagIE6yyfCvLaPouCOvXDEUFJev5CbsW5
	SMQfNHEY3sPePBLeuDQ42gjG39
X-Received: by 2002:a05:690c:dc7:b0:796:6da9:bf97 with SMTP id 00721157ae682-798855bd4a2mr43885187b3.43.1772221496705;
        Fri, 27 Feb 2026 11:44:56 -0800 (PST)
Received: from ubuntu ([76.38.17.53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876bf9449sm24829997b3.28.2026.02.27.11.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:44:56 -0800 (PST)
From: AnishMulay <anishm7030@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AnishMulay <anishm7030@gmail.com>
Subject: [PATCH] tracefs: Simplify get_dname() with kmemdup_nul()
Date: Fri, 27 Feb 2026 14:44:53 -0500
Message-ID: <20260227194453.213095-1-anishm7030@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In fs/tracefs/inode.c, get_dname() allocates a buffer with kmalloc()
to hold a dentry name, followed by a memcpy() and manual
null-termination.

Replace this open-coded pattern with the standard kmemdup_nul() helper.
Additionally, remove the now single-use local variables `dname` and
`len`. This simplifies the function to a single line, reducing visual
clutter and making the memory-safety intent immediately obvious without
changing any functional behavior.

Testing:
Booted a custom kernel natively in virtme-ng (ARM64). Triggered tracefs
inode and dentry allocation by creating and removing a custom directory
under a temporary tracefs mount. Verified that the instance is created
successfully and that no memory errors or warnings are emitted in dmesg.

Signed-off-by: AnishMulay <anishm7030@gmail.com>
---
 fs/tracefs/inode.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index d9d8932a7b9c9..86ba8dc25aaef 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -96,17 +96,7 @@ static struct tracefs_dir_ops {
 
 static char *get_dname(struct dentry *dentry)
 {
-	const char *dname;
-	char *name;
-	int len = dentry->d_name.len;
-
-	dname = dentry->d_name.name;
-	name = kmalloc(len + 1, GFP_KERNEL);
-	if (!name)
-		return NULL;
-	memcpy(name, dname, len);
-	name[len] = 0;
-	return name;
+	return kmemdup_nul(dentry->d_name.name, dentry->d_name.len, GFP_KERNEL);
 }
 
 static struct dentry *tracefs_syscall_mkdir(struct mnt_idmap *idmap,
-- 
2.51.0

