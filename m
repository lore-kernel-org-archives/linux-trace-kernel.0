Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC953A8755
	for <linux-trace-kernel@vger.kernel.org>; Mon,  7 Sep 2026 06:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788762375; cv=none; b=QvA3Q5rxj/h9cp80KlE1h9Oz+QQxzpMqgu9kB4FfSk2sH1StXBK2QEyN56pcdYIHs2S4agqtKAGhVhjCVnQJXFMF6pzW5mCsEgHy1kQ1lDvAhwIRWTGsRIoqfRjJCGEKRU+j7v5AqE48cYo1WSt6iAjdwedoEYOsMxxHoijkf3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788762375; c=relaxed/simple;
	bh=ytaOgPiD27NmO0p/hdzmEK5TXPSV7EgzssfUs4MDXBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GNL1vZPtgBLpZCB7aR61LMLhSQrLZT7NuNtzHLKKpGfmuVxMlDZiiurE+x3fsmPYh7+Mg+HDCPRxjqv7zwMN7otBxLWSBCwhAu48UVfvwBhIbHeSJfzcAPAugbNp0cSZHDYB9NojLU/gwXAr5DfJyiRJJxNV89NX5WB71VFqqKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLFXwa+T; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLFXwa+T"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso3064861a12.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 06 Sep 2026 23:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788762373; x=1789367173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=02lq+eXcDw6s0xPfNQzAdvi3Q6KYZBjnBNOuKbpzIQE=;
        b=oLFXwa+TCQ8s0ApW4KClE/BUvwo8Cjtw2++6wskABH4IheceP0S4ng1JtO3FT6KM5m
         1UhMFbcjne7meBTil+g/BJY2ec+ehhYpBntp9WqtBN1C1ndPj3mQsA2+FVPwyiYjuanh
         70zKS16qD9puTEYcPtNqzeqi1AgWPaMyTp3JSG+buuPUs8OxOSFTe9KwbIr1h8vk8jNS
         XgwNfGbTzQqwB58CqDkzI2Wbd6Tot9Zi3+lJIgYxsVi/CfxHzQ8ngnU8WdC/l5kmwvQL
         e8FfdnHG7FtPzTBGie2mJ3wBUtUvrRugyabd1Q5xx1i3119t9u+CW2BKofY97mZuBrn1
         rJ+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788762373; x=1789367173;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=02lq+eXcDw6s0xPfNQzAdvi3Q6KYZBjnBNOuKbpzIQE=;
        b=ScPkMxKij+oDKC4Ed8dyIljT1PruxVRcY2YVy53pvCokJ9ZEgeEQAe9RXS6gRz+i7P
         T4ohy78o+r+xEkabmbtiq+RVHvWoapnkS1g0Nod3jk0FRt8tOjymbW5VrXMevCbPZW7J
         4r+1G9TKpAMTePKl0I3hPKLy7BiGdUc61Fj/JmbOOxjap7RAKRaFUVP+0zR/BKc/gSI8
         K18VnubjrrIM9SbQUSv4n0O+zvrF8Xv8MOcJBsrbvfp0r7RyudlYhFbhkitujeu7/haq
         F532r1fRYGpNfF2GVldfUCgMM2EAAPb3TgN7/enwPV725XsUwU9EyRomq3qxoTKt2l8L
         62Sw==
X-Forwarded-Encrypted: i=1; AKwUvByjcrE0FuGGxPIodDWSeZTPH3ljU+0Vz3BaVYAGTLgsTvkEUJPwcfZ1VTKnZfnP835zVWcG56Ap0g1q9OLW9eux0as=@vger.kernel.org
X-Gm-Message-State: AFuF++n1//y+5oll+CeW3E+iqGLyLYZZd68JzekQB55wUEru49zu5e+h
	+cC1YErmgwyc9R06gQRNO9wwYwHUmsR4E4Qr8BetTQzRnI/XPfcx1FUm
X-Gm-Gg: AYBFou3J2HiBxfCKIDqHxve1yDnpedn8Y6I6+BtR5nAhKDlq/lQbJlx/sqRkdVpAfUD
	VdPtVXj/uLzd4Q4v2BXglqJj/A/I1owMCnmoMskf3YT6PxlysxL9TrLnCNBjI0zCJMkQ6VqbXFP
	flEfF7lQyL96vdY1ng3WUjgl/USobtOhvTzV7jUpZA3sqdkgVzc4nvN0jQTh/YYL5NPK8mMqhIW
	u1jecQBAMn33xD+JqKXg8Pw20MydVnWKM8mUdh5dchb/RUMT5tTddgW6fptzs9I7MCeEYOpCxTX
	OBQyRerOFoeJyutFXoZSTo77oZYZ7iH/nsRxZqpN7aXjwCBc3ediHUEEx1STGrbUZ3wK2uYrjl8
	x7qYamAIrefksZpD5oQ/IwOQkR7yjaaXitKWw6jIE4Idrh3srJOHoFDQ6SQepWUeCqF53RkVeFN
	Y7+ClZzNRgzmPNEhLCxQr2FohqRmaOhhmmkJabxgB3z2A6kvkbctLSUILagwAHs6XYdGTzelFBR
	6++bLc5FrGH+RAjpfk+NuCH
X-Received: by 2002:a05:6a21:9103:b0:3d3:ae40:51e6 with SMTP id adf61e73a8af0-3da3a104fefmr31944175637.26.1788762373444;
        Sun, 06 Sep 2026 23:26:13 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b8f44d7sm24354228eec.22.2026.09.06.23.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:26:13 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: fix typo "availabe" in comment
Date: Mon,  7 Sep 2026 11:56:08 +0530
Message-ID: <20260907062608.13924-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct "availabe" to "available", reported by scripts/checkpatch.pl using
the misspelling list in scripts/spelling.txt.  Only touches comments, no
code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 kernel/trace/rethook.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 5a8bdf88999a..87a27f3aa4a6 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -171,7 +171,7 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
 	 * This expects the caller will set up a rethook on a function entry.
 	 * When the function returns, the rethook will eventually be reclaimed
 	 * or released in the rethook_recycle() with call_rcu().
-	 * This means the caller must be run in the RCU-availabe context.
+	 * This means the caller must be run in the RCU-available context.
 	 */
 	if (unlikely(!rcu_is_watching()))
 		return NULL;
-- 
2.48.1

