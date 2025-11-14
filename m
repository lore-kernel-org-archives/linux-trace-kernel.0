Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0293090DD
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 09:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112331; cv=none; b=IhdoP3i8kO0b5c9lAl8EaoTN0EoNutEXOLGcs0x9Ey57rBtKMh/f6BKbGte7reACrwXhL9M8VJkKrdSsW4JP+WkBZtsohqAMGJwP/8qp4+JLSmkoPdzxN/BpafUoqH1/Lzfsr+qAwu8k8QG+TIGqDDPOF9C3eG2Vg7Dtwv/PGxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112331; c=relaxed/simple;
	bh=nSRVg1kRiVYCpNkt7AXhxAnMSyGK6wFljHMdK0qKX7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7QXIDPRGr6UhmmxBaXHqi952hNiP6eNuXrD2py0tKT+m/0OmEM/R3P/6IvleqCcIiJYzlY1ZHEtapT0jTyPbt4jtvpfqfR3tO7arL8XKLO76M7mUiiFJXZ6jHuotqJ6l0Bl2cJf7jeqc74S6wY6aSbIZnHCxmOU6ESMCCOGUvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EM8dzaOr; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EM8dzaOr"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-29586626fbeso18099785ad.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Nov 2025 01:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112329; x=1763717129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IngssO9K5rvAy09b3O/itHOX87BH55Ede2DbNxyMyq0=;
        b=EM8dzaOrE2KU4KVDZpSb72WcdCv/AxpKiBYWFzAxm6e1ZGMcnYG04z02lmPtKd92GH
         /DGsu2EOzanwdcEIHYRROlaWHdz/4og+LfcHGEJW35hxyoRm36wS2jGE4jCiUTdgCVs2
         VNafytOecBKpqdj1o/jEE3/qyXWcchSN00fc94hgnE8mUlymbqZWkuPPHwfCg1xeCX8M
         M4ocTxZPgU8FdSNUjKY6VmuohLKBHuPfRE51kS3HPpHCFH73Wyb/S6sSUjZjboWWkQAo
         pug/KGzgS2oh8cx7a/2WNjA7dGqxYVnjm4C8s+3iXJ0n+2SqLXNiDLGb+AFA5ccoZEC7
         9yrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112329; x=1763717129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IngssO9K5rvAy09b3O/itHOX87BH55Ede2DbNxyMyq0=;
        b=gMg+a/AFYHVylfw+oTGzYH7Rx2/nYaQq01FXKPz6WCIvvi0osCvCNcN0dvoqXcWea9
         LSqm/En+BixPD/b07dhhyJlPaYD4YtxmxElWR5lEh44WaFqt8wQBN8sJ16nciMO84ZdK
         Q0uArQQ+NC7vkk5fWrMOag3kL6RvZ++HLDch+xOIcJzMOo8r/17KNOhXsirqfzxXmJcs
         5y4xMWvdc6v4FegxtypVwbqG0t2eWtMIq8b4RSvQT7vFZGyGRrO4Wyc0QS8gfUwl1y5W
         JzHx93dq7RkfkNqGy2Tezq4vpkbvZnJv4y6fC4pqbGuR8uT5LqFrQ0msiLV9Lb+FuNY3
         xzig==
X-Forwarded-Encrypted: i=1; AJvYcCVFdb5R6iQfgkdd4cYJUf40dQ+209XA0CRHjCOp8sVTZi4bPV4W+nKwFmrg5UjFsoLxeNg8jYXArIiNZ0Xt3uuL0gI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEOP3XQll26/6KanjioMvURQMzSbtwVh+3ChQMKoe+Hs/eVd/I
	G7G4peVbVv/N3fXkABBevnc/onlLCE8k6XomqdBAUsUlraGx7dV/rseL
X-Gm-Gg: ASbGncuthPM7eQzQd0Xz8HBiPi4f6eMkLrMqvEnyX2uymVGDs0O3pjou/emESR3LBIt
	Ls4cjcYTsvHp4T1LqdV0qL/2VllK6Bitc0N1GAfbS6Z2Y0IL89/j+r/j3wJovav4lOMf/jU/RPF
	wNxsD6WtNNL0tn+ke5w6lL1N8jiI9avpuooT3GaU7rIbQsBtnV6+fq/HMkqC11+Mf/rfNNNDvg3
	U2DW7fm1FclSbjIZL3v0H/ngr++eMZS4GsCSXB2YzaJp9PX9HAmmySyiE679at3Lx+icSslk6BQ
	glyp5mg1UkGII4zEib68duF+tOIpRXJ/JnAJpUnVaLUz0L1Zrs5mTGNt6b7lh0voK45T/m8cQ5j
	N7Z7dVPS5p1m1QY19fxFYRH+W6mZwGYBCJom2dBh58Hzb64+k/w1HszHsMMnS04LluWoLgRKGQP
	KzqovWPmKhAKY=
X-Google-Smtp-Source: AGHT+IHlbzklfDa0d/deVykG+Yd1NG+0UeBxaD2Sb0CDDCd79clZdzvDiQVWnGMoXC2ne+kl8gS7QQ==
X-Received: by 2002:a17:902:f691:b0:295:6a9:cb62 with SMTP id d9443c01a7336-2986a73b4a7mr29073255ad.35.1763112329230;
        Fri, 14 Nov 2025 01:25:29 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:25:28 -0800 (PST)
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 6/7] bpf,x86: implement bpf_arch_text_poke_type for x86_64
Date: Fri, 14 Nov 2025 17:24:49 +0800
Message-ID: <20251114092450.172024-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114092450.172024-1-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement the bpf_arch_text_poke_type() for x86_64.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 arch/x86/net/bpf_jit_comp.c | 28 +++++++++++++++++++++-------
 1 file changed, 21 insertions(+), 7 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 21ce2b8457ec..c82bd282988f 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -597,8 +597,9 @@ static int emit_jump(u8 **pprog, void *func, void *ip)
 	return emit_patch(pprog, func, ip, 0xE9);
 }
 
-static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-				void *old_addr, void *new_addr)
+static int ___bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
+				 enum bpf_text_poke_type new_t,
+				 void *old_addr, void *new_addr)
 {
 	const u8 *nop_insn = x86_nops[5];
 	u8 old_insn[X86_PATCH_SIZE];
@@ -609,7 +610,7 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	memcpy(old_insn, nop_insn, X86_PATCH_SIZE);
 	if (old_addr) {
 		prog = old_insn;
-		ret = t == BPF_MOD_CALL ?
+		ret = old_t == BPF_MOD_CALL ?
 		      emit_call(&prog, old_addr, ip) :
 		      emit_jump(&prog, old_addr, ip);
 		if (ret)
@@ -619,7 +620,7 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	memcpy(new_insn, nop_insn, X86_PATCH_SIZE);
 	if (new_addr) {
 		prog = new_insn;
-		ret = t == BPF_MOD_CALL ?
+		ret = new_t == BPF_MOD_CALL ?
 		      emit_call(&prog, new_addr, ip) :
 		      emit_jump(&prog, new_addr, ip);
 		if (ret)
@@ -640,8 +641,15 @@ static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return ret;
 }
 
-int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
-		       void *old_addr, void *new_addr)
+static int __bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
+				 void *old_addr, void *new_addr)
+{
+	return ___bpf_arch_text_poke(ip, t, t, old_addr, new_addr);
+}
+
+int bpf_arch_text_poke_type(void *ip, enum bpf_text_poke_type old_t,
+			    enum bpf_text_poke_type new_t, void *old_addr,
+			    void *new_addr)
 {
 	if (!is_kernel_text((long)ip) &&
 	    !is_bpf_text_address((long)ip))
@@ -655,7 +663,13 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	if (is_endbr(ip))
 		ip += ENDBR_INSN_SIZE;
 
-	return __bpf_arch_text_poke(ip, t, old_addr, new_addr);
+	return ___bpf_arch_text_poke(ip, old_t, new_t, old_addr, new_addr);
+}
+
+int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
+		       void *old_addr, void *new_addr)
+{
+	return bpf_arch_text_poke_type(ip, t, t, old_addr, new_addr);
 }
 
 #define EMIT_LFENCE()	EMIT3(0x0F, 0xAE, 0xE8)
-- 
2.51.2

