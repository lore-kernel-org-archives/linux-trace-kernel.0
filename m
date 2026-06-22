Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6C62BFC8F
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782153075; cv=none; b=DFTXPt9QJNRK/LoP+LBHEOar3GUUK3YQY/T5yus2N/5yv6p10GYpuwKFit1jT2l89xZ1cWDBnHLRHzyHp6ETe+HJvMDxAhXUSHIlOvxDDXlR/3qGD9yiLWDIFDtGRGoLNONSZ6bWBFZxjyFu63hgUa72ZlA719RUxrIt8fF3FFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782153075; c=relaxed/simple;
	bh=yYOBQfqZGUS81DZaGsL3fkrDbvFg8rIO/JeYs0kuk84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CMzIYpIkVX7JGrCaJXbY5fZ/S4zO2dtptWDhfF9qsmIKtyK1GvIm+/8dIQnm0+uSAQ8XD5gLB64T1TSGHB0kKroK7jPLIeGvjgFvbIbdcEvXjz4w3NsaotY53aBCTCwT4Mh4cBo2i0XUEWCPC9m0CuVJ0bDs6Fz/SByhF0rXyFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hb6lkeLr; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hb6lkeLr"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a0e4f0342aso1644691eaf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 11:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782153073; x=1782757873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ei36sWm57Ir7QjyeXrpVqWueXDaMy2v9wz+4cwELous=;
        b=Hb6lkeLrDcJZNwIqX8aA5ocqyHDbd+kSBlpaHooL2h2d+8fDKNGbZ0dJ8pcVoHmj13
         tTPrMzE9N7LXK6ti1GdwBnpaLkxLdWltZoh8Ug7LkVvRKIr6tq90A0FdE8711p7O8LKu
         wcUdFLXaxFGlmmYyKBLqkf+60nCyJNW0xOgpzQqKNE+S5J40WYDHH+8i2xdMAaWhKOPF
         xCJB1Qr4Nop1PMbA9EWTqwVJLE2tfsFkFTLaNFt4afSs1lmDhX8A0spmZRVvPAql7Tlv
         FpiRle1/Z+kYP3wmcpD4nYlOCSfwKo0xYEvPESLgIWBkLprS1E/0atWA6P+EZhjzH4m/
         s8Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782153073; x=1782757873;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ei36sWm57Ir7QjyeXrpVqWueXDaMy2v9wz+4cwELous=;
        b=k+VP0IpJcBbpFlX/Qi6e77VAOGBiJnDP25KDMH7WPnvy2uWTs7QgY1RmaNiX1fim56
         KKve9GJeoTm7ekfi7WnRPMX4KzAEJeOs+pbs+QTwWJu776qXYBB3gnh9SL/aXNwk8RTv
         q8SJW6XLxiN7RurT1LStA7pbNfhBqyfYNKM/AAI9u2IIy1BD40HBSjyAM9X/M4qqy1xC
         IpLYjswwJcrd7DudTt7xyx7pq9WCJJv18/IY/+LnkjD/Y6Ea0pVnii8mRjySXTZy1E8s
         98DbTONUWs5dNqKh0t2/xy3t8B99ZP5imufKSb+maxbMfZkpMu2Cee1N+dLm+YlBcMei
         d72w==
X-Forwarded-Encrypted: i=1; AFNElJ8ZMYNEAs3h/FQLdbCpaXXqrzxFIcm/cK2RbOBBSBQbk3VqPZR7iqiZkvXXZIUl05qeSGArEnuUdl1uPOcrzLRK8LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnF9V4KNzUgTD43vTVwATAIDDaRRFV3KNf5aWveccxcCNAGWJv
	Si7QByowVvnAFYXEBfjtnULIbQIEl+k4a8piZFl3JZrvfsroOCydetLt
X-Gm-Gg: AfdE7ckkgDYL2pM8cNv49FVuvGAJlloDiujOUv1CSTedFkIVs3jVW6IOOxxJzbRcZoK
	b84UyeFhsdup9ZglS9jTrIJ9RcbSVzXDAxFUwfZ3QAF7DRBap4N4PLHAWJuiZuozkR84ucFVdsE
	s+g5VO6Ll8DUZjcJQL8Jla43OdQ1G5tDw+kQSGOyvCw2LrsCvkqpL+iIL10+jGEVc442Yo+w0qw
	JS8wpbdQfInsL//0xJigtPrd7H4iItmbio92ilHgD9Ibv71K1ILIS3pAUsGGjD4sc+grWo7J8S3
	1g9wBV0bGj189FU1v0R3UdG0YZYRqm2ktOGl2lptrcFUProdGeT/7RHrN+deYZU4sbtiPYRh83S
	QGj33hkBefgG/nRUsMjlIY3gE4T9kOlT8mEXRo11X486Qle7nfTzJMVAY5vxg0bChEo8UWDq4+n
	tNz7VRGv+pOFaYlLQZWd0tg97GydKLkrYgUqRHgTNkm3x79uERzrNaCfNkY8RkL6utHYKzLJ5hG
	V2wTQHBVkgajrY=
X-Received: by 2002:a05:6820:160b:b0:69d:e344:206f with SMTP id 006d021491bc7-6a0d8cd3357mr12748406eaf.29.1782153072948;
        Mon, 22 Jun 2026 11:31:12 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8df81fcb4a4sm101855136d6.36.2026.06.22.11.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 11:31:12 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	shuah@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH 1/2] x86/uprobes: Keep shadow stack in sync for emulated CALLs
Date: Mon, 22 Jun 2026 14:31:08 -0400
Message-ID: <20260622183109.1137245-1-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Uprobe CALL emulation updates the normal user stack, but not the CET user
shadow stack. The subsequent RET then sees a stale shadow stack entry and
raises #CP.

Update the relative CALL emulation and XOL CALL fixup paths to keep the
shadow stack in sync.

Fixes: 488af8ea7131 ("x86/shstk: Wire in shadow stack interface")
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 arch/x86/kernel/uprobes.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index ebb1baf1eb1d..ae32013a7097 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1246,8 +1246,12 @@ static int default_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs
 		long correction = utask->vaddr - utask->xol_vaddr;
 		regs->ip += correction;
 	} else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
+		unsigned long retaddr = utask->vaddr + auprobe->defparam.ilen;
+
 		regs->sp += sizeof_long(regs); /* Pop incorrect return address */
-		if (emulate_push_stack(regs, utask->vaddr + auprobe->defparam.ilen))
+		if (emulate_push_stack(regs, retaddr))
+			return -ERESTART;
+		if (shstk_update_last_frame(retaddr))
 			return -ERESTART;
 	}
 	/* popf; tell the caller to not touch TF */
@@ -1338,6 +1342,10 @@ static bool branch_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
 		 */
 		if (emulate_push_stack(regs, new_ip))
 			return false;
+		if (shstk_push(new_ip) == -EFAULT) {
+			regs->sp += sizeof_long(regs);
+			return false;
+		}
 	} else if (!check_jmp_cond(auprobe, regs)) {
 		offs = 0;
 	}
-- 
2.43.0
