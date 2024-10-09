Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9001D07A3
	for <linux-trace-kernel@vger.kernel.org>; Wed,  9 Oct 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488360; cv=none; b=SLsYK7F2PRpZQiOwRgYlwglnY+HFbu+QbaRbWm0U2YklBQB+sSSsMNWbAzTHtviHHmeXQofEqovXDr+a7L0chfSQCBRUXcO6OJ8I1aLceKZGoo0+/xRW5t39SKfruYuvwdjK6snKKdH/i0tQs51neetUGOFsuPKJD501Q1z2EOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488360; c=relaxed/simple;
	bh=mTVGohqQhQ+rnWnxvs61IpD872h66PAzmV4rz1Tfg7A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Uft5pjlefuakuwNY7UnUBMRjqVFS89BDXLScbNtqiiFtMmdgKihANiKSpQPE9G2slMFPPzwC+j3bZ99OhrZdijIjEUVEZKnZMJbG+CUCeGk3sbAFXUPwZLe3Hgnv7Jd+qDFn2VkdbZ3sO3cgNdFiX91KA8TBef6NCLvMYa5P7UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dpoR6tHQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dpoR6tHQ"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e290222fde4so933014276.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 09 Oct 2024 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728488358; x=1729093158; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QYyiAS0INs/NWkNBJl2g+1VUV2QV3THsM68JPcVS+YY=;
        b=dpoR6tHQq+IEIvZxyc5QTw87rdbOuncMsD4H8Vb997X78V1z6t6KHDvV6m7+/mWU/U
         J1qrmbWfgOCVBilmSQNgjMd7gHTwjVYiAvUW3xaYaYMeF4RDMIBHTOfGn0OPXJVJrONF
         tB6YD3eiVtsSiWvqU0x9vaMiJ5cP8HSlwZqOnegOJE8sFbJUrgFF7qoxtij4ntqgryvm
         5b4BDUAamCOhWsKyE7y+fjov0/37yIdam6Ebegzlzn2+hFUjodLvsQku74OWgMN5pm93
         t3ArWTCva8r7krNsU+UF8tIG3fa0AeC1o10XCYfcothTCFRT/gO6najR1LJ2K6UmxWHv
         5mYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728488358; x=1729093158;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYyiAS0INs/NWkNBJl2g+1VUV2QV3THsM68JPcVS+YY=;
        b=mnjAw/X2DrU6hF2fjEDLTr75JXZMZFDPz/MzZwlNS7/s2tSJG7lkk6Dko+OS9NU9np
         d5Ervfvc4ql9bbA1JS9/kdKr+xq4BCK7oUnxXHK3gvNJBRj49ATChbv/H14iU7QbwVYi
         6fYWGCk8YWdzVECJ0hnPKOx5r0wlVNNOzv56n4VXJWva8b9S5/ShsCurgLe76cvty7Cg
         24MM8KYmPpZlxagBMm5q5z4D0U0LPtBx3VLivHF6S1gvhL817V8dteICEMwtQ21HUHwn
         4o3uEWKufQ9nP1AoRqDY45VMqd/dywVOESTVmQPvWyxVYVjMS/A02pDu1ScOd30/vPHm
         JpTQ==
X-Gm-Message-State: AOJu0YzMMc90wKcyg2zh70mufwC5ulI6AF7X94H3DXNrSXoQZtJGhMcp
	pFfjiREZfttLYX3kvl0ixgBDhJ+VxmyfU0Qg1/nERW770HIbRAyDskCRezUg6SsENBEvNU1PTRg
	30cgaq6UC9SdWNKuPod69TyWTPmkk/BgB+l4ZEA+lMIaiLhb4SwjyE36ToH87NI+7rkNuCteER/
	1IpbmF9ZBEOh8lbdthpRJ2r62AYoZjlvL7A0vEVQ==
X-Google-Smtp-Source: AGHT+IHIoVogYPJY9awQcFf2XNy4JBbgtfmZhjVVXbqFXh4Tsc5ifrpwAQ3N32DMwXvcP1Og5ZfpFKGu
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:7b:198d:ac11:8138])
 (user=ardb job=sendgmr) by 2002:a25:a484:0:b0:e20:210d:4e4e with SMTP id
 3f1490d57ef6-e28fe3fbac7mr30646276.7.1728488357426; Wed, 09 Oct 2024 08:39:17
 -0700 (PDT)
Date: Wed,  9 Oct 2024 17:39:01 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475; i=ardb@kernel.org;
 h=from:subject; bh=w98mnX5+KZJQ9aIhR0ntKseGofoDBus8uh8cyGitUc8=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIZ1t8dSDjw2sF9auaWgwFd7B6yQ14+H0TUqbzq2wXOchX
 TpJgbO6o5SFQYyDQVZMkUVg9t93O09PlKp1niULM4eVCWQIAxenAEwkKovhN8vZwqMJXz/vDtbJ
 yYpf/5/97Vl28aYAJ/Vf5lmi/kf3KTMybNVzqH/S3dgrLNdbs5lB+dlS60+b1U5zfCh8IFRzpTe CAwA=
X-Mailer: git-send-email 2.47.0.rc0.187.ge670bccf7e-goog
Message-ID: <20241009153901.3878233-2-ardb+git@google.com>
Subject: [PATCH] x86/ftrace: Don't bother preserving/restoring R10/R11
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

The x86_64 calling convention specifies that R10 and R11 are
caller-save, and are not used to pass function arguments. Given that any
compiler optimizations that may deviate from this rule (e.g., -fipa-ra)
are disabled when profiling is enabled, R10 and R11 are dead when the
ftrace hook is called, and so there is no point in preserving and
restoring them.

Case in point: the code inadvertently never restored R11 to begin with
(added via [0] in 2012)

[0] 08f6fba50311 ("ftrace/x86: Add separate function to save regs")

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/ftrace_64.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 214f30e9f0c0..9e13f9b203d1 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -216,8 +216,6 @@ SYM_INNER_LABEL(ftrace_regs_caller_op_ptr, SYM_L_GLOBAL)
 	movq %r14, R14(%rsp)
 	movq %r13, R13(%rsp)
 	movq %r12, R12(%rsp)
-	movq %r11, R11(%rsp)
-	movq %r10, R10(%rsp)
 	movq %rbx, RBX(%rsp)
 	/* Copy saved flags */
 	movq MCOUNT_REG_SIZE(%rsp), %rcx
@@ -256,7 +254,6 @@ SYM_INNER_LABEL(ftrace_regs_call, SYM_L_GLOBAL)
 	movq R14(%rsp), %r14
 	movq R13(%rsp), %r13
 	movq R12(%rsp), %r12
-	movq R10(%rsp), %r10
 	movq RBX(%rsp), %rbx
 
 	movq ORIG_RAX(%rsp), %rax
-- 
2.47.0.rc0.187.ge670bccf7e-goog

