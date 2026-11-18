Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961984;
	b=fLvNGc/pdicvMIBy0XWiCmCS53iob2AvMhaeSaa1TfmVRNSUHmPlPEjm4tvgoEs8ywCI
	 Uk6GGECF5pDVEqqsCiIs5KGcqIqx/wXfVFSbizKVF7HbAvDJR+Lq/Tn8oS60+9qP+HBt/
	 8bR8WagpAG7d1Ca2kgaUrDlspj0dEQ4WC1Gz5vEiuTkZ25UWxv+02MXg7HAHkU77u17Wr
	 PHSka6LPSKuNu7ivKIhe8IVhO3W5qlxxHmGJ+bwC9XUPoMS6GWLjinm2x8ie/DOCtwTyP
	 i9cCmKh53zJMuy8/uvxp8EdGki3a14FbEoGtTXjiDuPrjrYzZc76fFLIYitosb4nkNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961984;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=gjGQXw/70DbXqpjUFfZeDZh2w0sbpZHOaCdTp2IlGvk=;
	b=O38X01MKZhpWeSP7YIoUGeaikULtCzjazM+F159Eift2p2ES6JdYYjS19AJfaOVtCHL+
	 Ge8NDl87N3wEPpM1ReZI+JGnCbUIQzEHdYLLwdg+nDwhN2qNIe1ZryZ1xNStzBJpiE5yx
	 EO0DzNDwK6+73AUWce2l9t34BvhLoe5RzYkpnmVqGRP00lLaEJODqbT0wANUroCsZASGN
	 atJaYgQbIcMg0KPiJI3WraJJJmH3XS/5Cse4oYSP+Ey0ZRdWW/HCLymsz7ieuwS3ByCs4
	 7cwwbOXeXsFIlr0mUoVBMzlpAFZNz/A99XpGKFBuVZ7ZZh/i5qR0ii/htVV27fQezlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBYHROdA;
	arc=none smtp.remote-ip=209.85.161.44
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 090BC606A33B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 00:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 090BC606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yBYHROdA
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-70b875f6f13so375393eaf.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 16:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794961983; x=1795566783; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=gjGQXw/70DbXqpjUFfZeDZh2w0sbpZHOaCdTp2IlGvk=;
        b=yBYHROdA5yxM+zOO0I5PPRFs+Aa/f417+NndZoLS8vVqf9QiD9JYsEW96INWoEPPHM
         q3FXykjJiSrgC2Wbg3zqcCPN/2wBZ63EXOzPqdg9VxpXb0OrwFHTU4MW/veMVcIy7pPe
         3XxJ5YE3gtJn3hKpfc6c+Sjdp0no9Y0i+iND5TEJayZWLJOvn9gqe7BgVPOpN5IhWwYV
         vSX+iBwZjLA6G4aTjVdhXfdqfOkPrCr7fP9osC/xqVQhoPlXVIbGF5Jb2tlWsERnpeIl
         MO4Ghvt4ibd4jjUSKCRsJWNeMN0WrKdXvwgG96zoK8OxovB9izrc8LpAv1p3yj1oJFRg
         ew7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794961983; x=1795566783;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gjGQXw/70DbXqpjUFfZeDZh2w0sbpZHOaCdTp2IlGvk=;
        b=CEn+CGOCwxSwuOq+rktFJhEomSWtNIhxB+Hqez44o6lTpb/T+gqCEPJmBhuDhqEclJ
         Tc8eJWHY2q6eAx+F4z/3eQM1F59uDk3y2JBYPHs4uxg25mE7xzbZ/YIhC12h7UMOKaNE
         8b5C3np1I7/gmXP/Wwd7gGgnpnJ+D2audH23q0HjhL6yKJIOLe7GH0NzMBSDByVaIrvM
         bJeyHgEc45mxdhIVru2ns2jZeohPK0uh4DrojzxxVKU/fY8D+KEJ4uOzTzKvrXvJTXM5
         2nUaOcR9zp3bPJKhYAeGRdjiAivYYYPBnfrKX4IM2RcUnKMWLo3WAfMCMgyldXnyERm4
         OQ3A==
X-Forwarded-Encrypted: i=1; AL+hErHH0JGc4bi8F4DE2BD8jucsqOVy6gAl9rGpmbAGUe23Hkf045uviupsq7ZDs0o+18xDQ8GFiSnUFXX79Ljv/2qWQfg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Ry+h2ThYWGFUYEw789Gv0YYWjL0XFGJbNcAbO9BD+jhu9w4Pk
	7PGQdQKdX/Y7hGrcMi8VVy7NLz6tBmX9SsVo9UhABJh5LZO6IDdCYjos
X-Gm-Gg: AYBFou2h1zESHINdlnQen2pAJaPNzwRvGwUTy8BdmSvyIBKSjtjF8JX6XJQlC5UDjET
	+D//m0qRjdlPrtky54HtjEFzQ4JR0PFIn3HtleTxbHfgI2410THdxHNmsUP5w6s23trn8z/cHAW
	XoIkHNd1v3wVrSdeBB+MGiCbgtV/HaD5VhNnDNB+7izcS4U4esyvZuQyI4t5rJ6wJDm3PYenT3Y
	fDtRHy9wP7RzYcKkD0c4+r4exgp035w1jgljBRkPVPSFA/UC5NwU1D67YS8sSmtlmXDip9+fDOO
	7v3PXHibLuBbakpPIiENHGrBdcuhIo/qMedbaTtfR7QXesadO6g0KlvvArNxmvVaPLP5vgGy73U
	l2Vb4T9Zbgr3Pldz9TME5Se+V3xxuImxUiKMSfMEwzC23JFga2FfDh+0u7Q8T3KCqX3up/Eq3tu
	2CQvW0yUUObtEjgzBJgLh2sC8ftEAch8TulDILMRre8Mq8I0O/cmfz+cBlZy1lor86oEkuRA6K4
	asqZp3sqY1vlBD/+NjfC7DNHAreZZ7ZlrNOzs9h4y7lHaVxiuBlFxJ0xG8yiPFB2UMsADSs5R/q
	A01TyaW+52wkrgqKRHguJEnsfzQrpBWseJdTwKTj8AL2q7aA3b7BJKO23QGYxQNCvQFe9/yGhR2
	6Bbt6XlnoA+JGVtam///GZV83MGQL3JpUcozWdg==
X-Received: by 2002:a05:6820:178f:b0:6fd:4277:16e7 with SMTP id 006d021491bc7-71b18476f7emr825396eaf.23.1794961982890;
        Tue, 17 Nov 2026 16:33:02 -0800 (PST)
Received: from FKXX2DL94F.bytedance.net ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-71b19229f3csm736942eaf.1.2026.11.17.16.33.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 16:33:02 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>
Subject: [PATCH] tracing/fprobe: Do not let KASAN check the $stackN read
Date: Tue, 17 Nov 2026 16:32:05 -0800
Message-Id: <20261118003205.59804-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ftrace_regs_get_kernel_stack_nth() reads the Nth entry of the kernel
stack for the $stackN argument of fprobe and tracepoint probe events.
That entry can be in the redzone of another stack frame, so with
CONFIG_KASAN_STACK every hit of such an event is reported:

  # echo 'f:fp_read vfs_read $stack10' >> dynamic_events
  # echo 1 > events/fprobes/fp_read/enable
  BUG: KASAN: stack-out-of-bounds in process_fetch_insn+0xac9/0xcb0

Use READ_ONCE_NOCHECK(), as arm64 does in regs_get_kernel_stack_nth()
for kprobe events.

Fixes: 0566cefe73b9 ("tracing/fprobe: Enable fprobe events with CONFIG_DYNAMIC_FTRACE_WITH_ARGS")
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
Tested on v7.4-rc3 in QEMU with KASAN: 6 reports before, 0 after.
Found and written with the help of an AI coding assistant.

 include/linux/ftrace.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1c2056a1a68b..bdb6ee6bc3b9 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -270,7 +270,7 @@ ftrace_regs_get_kernel_stack_nth(struct ftrace_regs *fregs, unsigned int nth)
 	stackp = (unsigned long *)ftrace_regs_get_stack_pointer(fregs);
 	if (((unsigned long)(stackp + nth) & ~(THREAD_SIZE - 1)) ==
 	    ((unsigned long)stackp & ~(THREAD_SIZE - 1)))
-		return *(stackp + nth);
+		return READ_ONCE_NOCHECK(*(stackp + nth));
 
 	return 0;
 }

base-commit: 63fdb511c27afcebce797e3db580b3534ddfa639
-- 
2.39.3 (Apple Git-146)

