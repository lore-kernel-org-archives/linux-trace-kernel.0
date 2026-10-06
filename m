Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 054E23BFAE0
	for <linux-trace-kernel@vger.kernel.org>; Tue,  6 Oct 2026 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791327147; cv=none; b=LZr4h8X26nb86WAWraihSFn8drdXUKqFcQN/3IPGL+pMOXbEuyyr2INT1dbpRCYvmi1nsZDemlGkEfLUu6M7uI6R9vwQigRrDteo2VT9FOe9ie/VhI9oqlEUwWihRVO9dBQUwQgaPgpdWybJStaLDZMt7XfwhFOMp8pnMl8d+rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791327147; c=relaxed/simple;
	bh=pFTkUMk/rZ+bcDA0dNreWXqO/ymmW56hA2wPC8A0SUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PF9mKqeDn3f/iop9xPCagdw2uZmeESRd6wgSo/5xE8NfriuP34W/Qvmtt26tr+dVeSdYnVlNut61Eo1HX0HNzi2LC5ahsInTQGnp1prgA1643lpWXYzO/mQE657x5xB8IUUpDRdnaEIO9sGGmZdg701GBCP59av1AXf7y7HNRsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=YL6mqHpm; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="YL6mqHpm"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4b1ba286f6bso777536b6e.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 06 Oct 2026 15:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1791327146; x=1791931946; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VPdIVaXesRNcKlAXCOjj3AwAY0KkqhBFBWxij3ZELec=;
        b=YL6mqHpmX4aG5+DNtHousP20Pjlc6wbtx1gI7gJPTK86sQP2MU9IYWvbR5TzILUcxR
         xstCH/8TKMLQJooOYRMaUIvvZ+VFkEajsIBlguMw6lDRfzezQaWz4D8sDtOG/idVu9bk
         JpbK09nO9q7NL27sKorCCbdphnvARRa5dcJoQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791327146; x=1791931946;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VPdIVaXesRNcKlAXCOjj3AwAY0KkqhBFBWxij3ZELec=;
        b=FeEWgL8o8VDSBnLG1aGMOiua60enBSS1zcLn4tuW/4Pz7b/ve6bLiWmuqOBpe+lyBO
         VIgmpSFnUTSRosUhIX4011x9ZOMWguotkWwOYpPJnV9/4SBDh7gRopKmCPa060K5rv+z
         sWB/faujKMbGzMx9xQIU5TZzSRDwNC1iECyepGCCspjE9s1CXYxKzUVQmBm3wS868m0J
         InnKI2glfblrqOKRpDwdXPfa5+EtM3p0gsLAQIqeOCvSaugA7aKBekIrM5qQHuZ0wkjM
         fm46YbYGB24i/DV6hrtRy7wvb2G4duH5BavSDdEjUsxTh+UPN4fayfJRMmXMfOq6BOx7
         M2Ng==
X-Gm-Message-State: AFuF++lo8M4wfQIoPboeAqNHmRZHusdi6c8VP5aRCSf/IS3O1HJF9jBw
	qtlOj6eMwsl/N4FJQkA19MRXyPgtQMj0Gpg8nkFnOAWH4iTkJQ7Pp4YLoH00aVksMobvqK8L7do
	GSzKKoqA=
X-Gm-Gg: AYBFou2eaxbJkiz4y0X+OXKXM9zsl7RA9336v5Xna4MW+HE6kslhJdUofwyU/rGjWTf
	keNbd7cwdtj1vWY2lHPvG6QmmKzmNIP0MEAGfEDAOo7NQPR7pl4DbiuDMlfL/FvuX0ZMpMbOC8t
	w/2IRfBIcYQ2dE1NCJSjOc3+gYqhySM3W+X6vw0t7qB2RGBeEQDSr3jRyhaPxzNStb/r21HuRPO
	hpB4OblUSVADTzofzqGzP9lZy7Dy8QR5bkxOz25tCf89OEdIRYIoTIfE8Qiqap3aJ9ZAzHrZlQ7
	psIihO28CgtGL0okz681UlTIVZtAOAHA3CEDHE8Kre/Q8dr7XyHuRJ7H3J3HGJ37MOUILEBiUHR
	Qt1Kg51LlvwdZZb+UGZtoaNZMBeDa+uLyyU8/KLPtVe634oI3e0sVCkgOOPDE8fHJKqk0WIZcYT
	yO4YJokZT/KXVXBErzIiB1WO/3q9SSrUO94eKehll+KfXgGSCrJT9EcAbI5kFrWk4fV8LuBTppZ
	rFxsTAjf73ddXYC6oP2uDSzcuUu7sQuOPVQf22BRO9IHr1zMdxCusdHpoU7qLdwmckfy/LpYks=
X-Received: by 2002:a05:6808:3c47:b0:495:ce6d:7d48 with SMTP id 5614622812f47-4fc44b3f7cbmr587506b6e.9.1791327145807;
        Tue, 06 Oct 2026 15:52:25 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc49a71636sm583940b6e.16.2026.10.06.15.52.24
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 15:52:25 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	outbounddisclosures@openai.com,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Validate user addresses in faultable buffer copies
Date: Tue,  6 Oct 2026 15:52:21 -0700
Message-ID: <20261006225221.54513-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syscall entry tracing runs before the syscall implementation validates
its arguments. For a size-bearing user argument,
syscall_copy_user_array() passes the register-supplied pointer directly
to __copy_from_user(), which assumes the user address has already been
checked. On x86-64 this can copy mapped kernel memory into the raw event.
An unprivileged task can open a task-bound sys_enter_write perf event at
perf_event_paranoid=2 and disclose that memory with a write() that even
fails with EBADF.

Use copy_from_user() for each actual array pointer. Use it in the default
trace_user_fault_read() path as well: the original syscall-array tracing
implementation used that path, and the helper is documented to use
copy_from_user(). Keep the existing length limits and per-argument fault
handling, so valid user data is recorded as before and failed copies do
not contribute bytes to the event.

Fixes: b4f7624cfc94 ("tracing: Have system call events record user array data")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 kernel/trace/trace.c          | 2 +-
 kernel/trace/trace_syscalls.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index e4a490d3d08c..07acbc44d99c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6263,7 +6263,7 @@ char *trace_user_fault_read(struct trace_user_buf_info *tinfo,
 		if (copy_func) {
 			ret = copy_func(buffer, ptr, size, data);
 		} else {
-			ret = __copy_from_user(buffer, ptr, size);
+			ret = copy_from_user(buffer, ptr, size);
 		}
 
 		preempt_disable_notrace();
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index e35744049e3f..d9190fdc030d 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -683,7 +683,7 @@ static int syscall_copy_user_array(char *buf, const char __user *ptr,
 
 	for (int i = 0; i < args->uargs; i++, buf += SYSCALL_FAULT_ARG_SZ) {
 		ptr = (char __user *)args->ptr_array[i];
-		ret = __copy_from_user(buf, ptr, size);
+		ret = copy_from_user(buf, ptr, size);
 		args->read[i] = ret ? -1 : size;
 	}
 	return 0;
-- 
2.53.0

