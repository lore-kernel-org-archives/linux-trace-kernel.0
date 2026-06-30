Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0313CCA6B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Jun 2026 00:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782778419; cv=none; b=Q1sxp6h0mmQRwC/dYwMr4GOADcxPpWN9Pazg101dqHp6qteDnLy5f63wfEO+dWI4FLl//kwoauZIS+kAJYlxkUdefSFYJxkSsKrgyFXxNnCyV/Ku5CyRUL6PTnDPoiwNqB1/yuooE1m9C1zHHrJkX/lBdnIyFsvhKTFRX9AstSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782778419; c=relaxed/simple;
	bh=xA/Vs9V7SjmvMjzEG3jYo4JXm0pLhylCX8gmEuckYbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jXBH4crHxllVLok32GLFV0oK013V4mwlqzZHIYdR4Idd36/WGVZQG1+5XBobJ22IV0m/BeLlr3JlJiBHQXrfXDXG+B2WgH3KfsAf0h/vM2FCo7DnRTqTvevvBhjyHphru8la6RO96GtDq7Cu/mdTVQJ00x/OKx1qXk9q0vJ3y/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExUoY7ee; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExUoY7ee"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-51c08df8513so7865841cf.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 29 Jun 2026 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782778417; x=1783383217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jIkraZxinUJrwI8LhBH8/tkcf/KJe4Ahg7TpFa29WD4=;
        b=ExUoY7eeULcP47M1bs6z/Galpsx9KC2Lj0Zn1QteJiSOmVaLNrAm6GBr3n7XGJZWdh
         ZiSCJVsEq3hXviQ1iYv7ABy17INGs6u7Ocs9J6bEimYyiypdE25MNxzLEs7U0kxFXyow
         lj/ev5mE1fBg+xlb5NnImOS+o797Uk5anjw5DQiTKXjZeIyy8TuKwjXrseZuIMrqiogQ
         u0C0T9NsINX8TCBDiqgHw9vzDhNNu2C2Bcd5NPw4fvaVIJxG/lvdr/AFAYNxsOmUXBRi
         pCpRUq+7XAUkrvm4s3LZFO14AxfPDh4dyq7XIA8kSIUhDq7isdEmzEtR7+jF1XLTPScE
         28aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782778417; x=1783383217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jIkraZxinUJrwI8LhBH8/tkcf/KJe4Ahg7TpFa29WD4=;
        b=fDAUf0xMRvH7RERjFmZJV1z1pwyWb4MO2g2cqXkd1zYvbG1gShqhwEGhS3NBuZ3/2n
         07Dwn/7d/hzjMysbkeDxwdvMqY5MhLnrkHsduCS0Rt/x8+zQ+YHrYh2JKpxbgtgGj6O4
         CqboL4Z3K19eD0J5LxroyIu4uDCzN+qgYdVrUf5Kusm6azmLZZHkOPfMK/mmF8U1N7dP
         r+WaMPKscABjpY2sOP/g7Py39a88XU309nnt4Kt1pPurARHN5Ya4aZB6mKlLnj5JIZtr
         FjCVD7wNWcfM8oLs/JGAQ9STv2R+VJuwAtdM1DBeecgNp/BW7diV00rn741KaFLYFEVP
         Lt7g==
X-Forwarded-Encrypted: i=1; AFNElJ9cToOqLbHVwP4oAEY3iq3McjmYCzSa0O9nNSsX7hFAvNkYsA0NbBZZzFWVdNwAsWOLEx7kvSk8q94l5+8wO7biSIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+MuJeFQw7w767cbQChO0Tgx8E4SKLQIqOybXDnYSMDFKq+lg
	t6p+gf39GuQh3gjeJqA49EK0XDj0WJGlDxJk4wsN6PY9hW5U4VdNQkCp
X-Gm-Gg: AfdE7cljfLmPXAfr+52dM9sU/y8PN8TxblKHYAChDxteRjAXn7jzfDdlAoG4Uyz3lsU
	Sz6NeEAG1oGECbs/08g+wGH/ii4RUbWpiG4wwBtu6mR5enWFBaJEo/3MvmUnUCau9mBbwLTRF+z
	kVx66FEGz67fkbOKMxMQJly1kRntGnBaxBZgAtBkiqCSjNAt3TzyFzvbbMluXgB8ImsDoQA98jd
	qAUdrmEp12eJVtS61kBQVYZ/A3IVDNdVtdRH17UgBT32dd0VM5OluQyrieNiqMBnxDZPLRLLBXR
	DGn/Y+AS3f2Qxyjh/xv8cRIv3TUXr2GbPm06EMBUVUy9rz80oLncJS6JiYQWyBncm8t2Fsr4oYl
	Y1brWbMWnbNxR4CpDfFwlrJn3REc4R8Z0uXZ66DsqUSvuL4347zhV6ojMCyasSIsK5J0knPWdo9
	Mi5GINMJi/32YksySOUkpD++0g9syjvuSEAvGX4qDG1V2QMzP0rSNF+95T5BqXFbXJXoVAiIEGm
	WBW/hjbLk/IYtVyIAzXctpkOw==
X-Received: by 2002:a05:620a:461e:b0:92b:67e6:8acb with SMTP id af79cd13be357-92e627f80cdmr276859485a.69.1782778416870;
        Mon, 29 Jun 2026 17:13:36 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e6219cb9asm101975185a.21.2026.06.29.17.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 17:13:36 -0700 (PDT)
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
	rick.p.edgecombe@intel.com,
	jolsa@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v2 1/2] x86/uprobes: Keep shadow stack in sync for emulated CALLs
Date: Mon, 29 Jun 2026 20:13:33 -0400
Message-ID: <8b5b1c7407b98f31664ad7b6a6faf20d2d4a6cad.1782777969.git.dwindsor@gmail.com>
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

v2:
 - propagate error from shshk_update_last_frame() rather than returning
   -ERESTART in default_post_xol_op(). (Oleg)

v1: https://lore.kernel.org/all/20260622183109.1137245-1-dwindsor@gmail.com/

 arch/x86/kernel/uprobes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index ebb1baf1eb1d..d74bb54543b6 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1246,9 +1246,15 @@ static int default_post_xol_op(struct arch_uprobe *auprobe, struct pt_regs *regs
 		long correction = utask->vaddr - utask->xol_vaddr;
 		regs->ip += correction;
 	} else if (auprobe->defparam.fixups & UPROBE_FIX_CALL) {
+		unsigned long retaddr = utask->vaddr + auprobe->defparam.ilen;
+		int err;
+
 		regs->sp += sizeof_long(regs); /* Pop incorrect return address */
-		if (emulate_push_stack(regs, utask->vaddr + auprobe->defparam.ilen))
+		if (emulate_push_stack(regs, retaddr))
 			return -ERESTART;
+		err = shstk_update_last_frame(retaddr);
+		if (err)
+			return err;
 	}
 	/* popf; tell the caller to not touch TF */
 	if (auprobe->defparam.fixups & UPROBE_FIX_SETF)
@@ -1338,6 +1344,10 @@ static bool branch_emulate_op(struct arch_uprobe *auprobe, struct pt_regs *regs)
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
2.53.0

