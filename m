Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1DD3563F6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 12:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763469449; cv=none; b=YpIk9o+tbbWc5td9PpGM4ESc6bxBsLWJKLu6U7T+VSYloy49iA1fXEcIRgQD6ApypvRLDovXX4O0/tuBXsAEWS2k/Tw45J4DH8YOueavI3UY+CxX/4JUw5YvR6kxbe4G1+20B91vgXhXW/3yGVTon/tt8MjpD+8nFLDBbcsocJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763469449; c=relaxed/simple;
	bh=+LW1LDwlw5aMWSZC+RME7xkgV6VVEeYQmuAgzKDmvtU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejuNUxBuUoPIlg4muexzgtgg1/JAozGPQvhL/mG5D1kJSiGT5AKbMQXAKpLj2nCEW8I9LfNOzJeFqmeuVLdj05O9o08i4auvSxUpfibR+Zwx52aKcNFHPhRDDduUYzS7y2/ga2wMvpyLwPA0hYPh6XNqwzL5kVJd7z+ilNrPEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdobFG89; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdobFG89"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-343806688c5so5796776a91.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Nov 2025 04:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763469446; x=1764074246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GSVMHccR7qFQowMQrwveg0nRJjHYor4cBFPpOOVsWCI=;
        b=ZdobFG89XihdwouF7VTmof8NXxPPpnWRSF90gOqUX6zhmDlGfmbHn2i/29Wxo1sU2g
         ccGhFTB42xzYqgyitVQF/talHTSAEkDnbtmLPfu0tz+Dt5jOhujSUUT6j21NutwqBOmM
         96+jO+OOtuMRVbqKtzc1Dofeiny0hjYohyA1lPERR0yBqmgDhr80rFn9sKlpjNJLVU6G
         LZufg3zl7ltmHNaAmVW5az43B5u/IYQ9IQx96g7lFtdKhtuqeKE3UtPUPeg4Y/8K/sO/
         q5BWawOIq5k8Y7FeklGiIP0NsbL3NAuY3sxRkaUUoitmCJW/v4+1SaBwg4mAc2npL4yC
         4zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763469446; x=1764074246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GSVMHccR7qFQowMQrwveg0nRJjHYor4cBFPpOOVsWCI=;
        b=O/MH4b7ShCxTtIjWp35maVy/LcHqiMnurl89fiZoD+GVUEANQr6pD/1R7Zo4W8LFq9
         ck/YYaD31527m0KfdmDSlLoOrtc3QLgYLJR/Qc0GC+G7/5c4WOYD8/rZGrEdaIk2K5T0
         M88wuWHdtnZ+WoyUE0e5Gh3a4muBW/Eqw51Jfz3AWpmqhLwR42Hav7RohP2+NQoKOob6
         S79eF2Z5o9Ur38TT+s4igDJ4HhWdDG/3FXmhJVrfvi/ilf+KeLbvzNxJA33nOSQS9B23
         +l8vcwvTBMVnN3nkipItiq0Vwo19yH+5OR2/ftuj1lyFEJQJvqjnoSenrdIq+Frn+Hzg
         wdyA==
X-Forwarded-Encrypted: i=1; AJvYcCX6MFyRUaU5LkPA2QjW3MUorPirPJ01um+1uLHd2TlZp0m/Lrxdm647Sfxtd6962tem2oBRalrqLaG2n/h3SOGfPz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/oOQu5ZxubsEr0KHoHB7SI5r/pDR3MRXY+2HG4eM6UoCLfuMQ
	1j+meKPDvYHdRTYL4AS44VRGtlD7kMUf7bgb5D46O8vIJxbfPc/IOHsf
X-Gm-Gg: ASbGncsr4BASXVju/986rzTvUon7FGv2kIH2S68DkaC0N0q28zL7N8pURaNeffk8kob
	+m8crGNuzgxnPp8oQK2LrNND7mQykJGZP75iq5ZmhkrkLSW7J1Fbj3YvFXEB0bis8gi5Nn9uW1C
	j8nI5dDCRQt5QgGKWNj38Z3Nni4E0UsRVfPzx8jkkz2/qy98yiR2HpP3j+PoHgkWyC8XZcw4MsE
	FNoIsgFRHjAar5lQvTWepPHNUKgelMHjbVbcWOCVQAf4PUNAOk8WeBfyhIR8g8HAiH59hbGkEFH
	duoC4w+do5SlnMHImvQok0+uGXtwj9d74ukLUG88bLv1WNaVbh4t75zEXYjxias/MbRfF2RF3jH
	x0MjCHOzfWjBzHZi2wOXGWnfI8hGyIBVbl+vhe+iuKgs12fDFdflfmK1MZ/cHLiGsKeT5m0+R6d
	tzU7q4FASe3NQpwh/3VM2nSQ==
X-Google-Smtp-Source: AGHT+IHlB7JZdM0iuSFbQkeMsYxejQo0JNDWZPI7r1VSRlyryqeoQgKWNGwlsPQuVu65rP/M3ItuMw==
X-Received: by 2002:a17:90b:58cc:b0:343:684c:f8ad with SMTP id 98e67ed59e1d1-343f9e92249mr18880629a91.4.1763469446351;
        Tue, 18 Nov 2025 04:37:26 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b92772e7f2sm16331496b3a.57.2025.11.18.04.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 04:37:26 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 6/6] bpf: implement "jmp" mode for trampoline
Date: Tue, 18 Nov 2025 20:36:34 +0800
Message-ID: <20251118123639.688444-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251118123639.688444-1-dongml2@chinatelecom.cn>
References: <20251118123639.688444-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the "jmp" mode for the bpf trampoline. For the ftrace_managed
case, we need only to set the FTRACE_OPS_FL_JMP on the tr->fops if "jmp"
is needed.

For the bpf poke case, we will check the origin poke type with the
"origin_flags", and current poke type with "tr->flags". The function
bpf_trampoline_update_fentry() is introduced to do the job.

The "jmp" mode will only be enabled with CONFIG_DYNAMIC_FTRACE_WITH_JMP
enabled and BPF_TRAMP_F_SHARE_IPMODIFY is not set. With
BPF_TRAMP_F_SHARE_IPMODIFY, we need to get the origin call ip from the
stack, so we can't use the "jmp" mode.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- wrap the write to tr->fops->flags with CONFIG_DYNAMIC_FTRACE_WITH_JMP
- reset BPF_TRAMP_F_SKIP_FRAME when the second try of modify_fentry in
  bpf_trampoline_update()

v2:
- rename bpf_text_poke to bpf_trampoline_update_fentry
- remove the BPF_TRAMP_F_JMPED and check the current mode with the origin
  flags instead.
---
 kernel/bpf/trampoline.c | 75 +++++++++++++++++++++++++++++++----------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 0230ad19533e..976d89011b15 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -175,24 +175,42 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 	return tr;
 }
 
-static int unregister_fentry(struct bpf_trampoline *tr, void *old_addr)
+static int bpf_trampoline_update_fentry(struct bpf_trampoline *tr, u32 orig_flags,
+					void *old_addr, void *new_addr)
 {
+	enum bpf_text_poke_type new_t = BPF_MOD_CALL, old_t = BPF_MOD_CALL;
 	void *ip = tr->func.addr;
+
+	if (!new_addr)
+		new_t = BPF_MOD_NOP;
+	else if (bpf_trampoline_use_jmp(tr->flags))
+		new_t = BPF_MOD_JUMP;
+
+	if (!old_addr)
+		old_t = BPF_MOD_NOP;
+	else if (bpf_trampoline_use_jmp(orig_flags))
+		old_t = BPF_MOD_JUMP;
+
+	return bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
+}
+
+static int unregister_fentry(struct bpf_trampoline *tr, u32 orig_flags,
+			     void *old_addr)
+{
 	int ret;
 
 	if (tr->func.ftrace_managed)
 		ret = unregister_ftrace_direct(tr->fops, (long)old_addr, false);
 	else
-		ret = bpf_arch_text_poke(ip, BPF_MOD_CALL, BPF_MOD_NOP,
-					 old_addr, NULL);
+		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr, NULL);
 
 	return ret;
 }
 
-static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_addr,
+static int modify_fentry(struct bpf_trampoline *tr, u32 orig_flags,
+			 void *old_addr, void *new_addr,
 			 bool lock_direct_mutex)
 {
-	void *ip = tr->func.addr;
 	int ret;
 
 	if (tr->func.ftrace_managed) {
@@ -201,10 +219,8 @@ static int modify_fentry(struct bpf_trampoline *tr, void *old_addr, void *new_ad
 		else
 			ret = modify_ftrace_direct_nolock(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip,
-					 old_addr ? BPF_MOD_CALL : BPF_MOD_NOP,
-					 new_addr ? BPF_MOD_CALL : BPF_MOD_NOP,
-					 old_addr, new_addr);
+		ret = bpf_trampoline_update_fentry(tr, orig_flags, old_addr,
+						   new_addr);
 	}
 	return ret;
 }
@@ -229,8 +245,7 @@ static int register_fentry(struct bpf_trampoline *tr, void *new_addr)
 			return ret;
 		ret = register_ftrace_direct(tr->fops, (long)new_addr);
 	} else {
-		ret = bpf_arch_text_poke(ip, BPF_MOD_NOP, BPF_MOD_CALL,
-					 NULL, new_addr);
+		ret = bpf_trampoline_update_fentry(tr, 0, NULL, new_addr);
 	}
 
 	return ret;
@@ -416,7 +431,7 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 		return PTR_ERR(tlinks);
 
 	if (total == 0) {
-		err = unregister_fentry(tr, tr->cur_image->image);
+		err = unregister_fentry(tr, orig_flags, tr->cur_image->image);
 		bpf_tramp_image_put(tr->cur_image);
 		tr->cur_image = NULL;
 		goto out;
@@ -440,9 +455,20 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 again:
-	if ((tr->flags & BPF_TRAMP_F_SHARE_IPMODIFY) &&
-	    (tr->flags & BPF_TRAMP_F_CALL_ORIG))
-		tr->flags |= BPF_TRAMP_F_ORIG_STACK;
+	if (tr->flags & BPF_TRAMP_F_CALL_ORIG) {
+		if (tr->flags & BPF_TRAMP_F_SHARE_IPMODIFY) {
+			/* The BPF_TRAMP_F_SKIP_FRAME can be cleared in the
+			 * first try, reset it in the second try.
+			 */
+			tr->flags |= BPF_TRAMP_F_ORIG_STACK | BPF_TRAMP_F_SKIP_FRAME;
+		} else if (IS_ENABLED(CONFIG_DYNAMIC_FTRACE_WITH_JMP)) {
+			/* Use "jmp" instead of "call" for the trampoline
+			 * in the origin call case, and we don't need to
+			 * skip the frame.
+			 */
+			tr->flags &= ~BPF_TRAMP_F_SKIP_FRAME;
+		}
+	}
 #endif
 
 	size = arch_bpf_trampoline_size(&tr->func.model, tr->flags,
@@ -473,10 +499,18 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	if (err)
 		goto out_free;
 
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
+	if (bpf_trampoline_use_jmp(tr->flags))
+		tr->fops->flags |= FTRACE_OPS_FL_JMP;
+	else
+		tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
+#endif
+
 	WARN_ON(tr->cur_image && total == 0);
 	if (tr->cur_image)
 		/* progs already running at this address */
-		err = modify_fentry(tr, tr->cur_image->image, im->image, lock_direct_mutex);
+		err = modify_fentry(tr, orig_flags, tr->cur_image->image,
+				    im->image, lock_direct_mutex);
 	else
 		/* first time registering */
 		err = register_fentry(tr, im->image);
@@ -499,8 +533,15 @@ static int bpf_trampoline_update(struct bpf_trampoline *tr, bool lock_direct_mut
 	tr->cur_image = im;
 out:
 	/* If any error happens, restore previous flags */
-	if (err)
+	if (err) {
 		tr->flags = orig_flags;
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_JMP
+		if (bpf_trampoline_use_jmp(tr->flags))
+			tr->fops->flags |= FTRACE_OPS_FL_JMP;
+		else
+			tr->fops->flags &= ~FTRACE_OPS_FL_JMP;
+#endif
+	}
 	kfree(tlinks);
 	return err;
 
-- 
2.51.2

