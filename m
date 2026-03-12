Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAEC31B823
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773315357; cv=none; b=jew/8gXNC7p2R7rLjJpTMShMhPOJRQcMWNxw0SkqzQ98SH0mIcv1oV0RhbEfChJ/9etX2gV49zcWO3Wb7lFyT85bAphWFXr+ezurz2qK79FbRVlWVEacDo/ZCoTaJSfg7XXkbX2fJ6NF4Ir3g0KZM8IshAhMAt7ymyO9l+r+4kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773315357; c=relaxed/simple;
	bh=luIBTGBBRJ67RNao0BWmDsf9r0yENl8hSkn4XXKgohc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IIUfJFGYDgd0g+gRCLdRLrcIfBd6KGDuUCptY3Br6/eCvL4lXDRZ7CD3WmLRhpcGXqnqdKyWwdyJc9sc46IVTkVFkubCrkLgABo+2I9xLuovvASadiCfiS52l/Ct6LD/TzyoqiZdr5muIx4okO8RuieDawU5qsPAOyeXGf45hfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8pCqNt7; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8pCqNt7"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-439bab2d095so554453f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 04:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773315355; x=1773920155; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MQysXvwEtyjr/4QwzwV58b1FSM2E3DJvALB+KxzJwQ4=;
        b=r8pCqNt7L3HtJvR28nx/Ksf6sDchwLMc8D68uIHDGsg/TMH4/j8QqkClCypHbmGQSg
         JXsk1wiPARIq8CmAhzkbIbj/kfivXJvslZRUj76IgSeRKLfwxL/i8ga6/FZxiqKlQc1V
         J+LyIEfgV907KYaeLxf2iRU7e2TOj8yj7HcF3GSgDtr5ePSv0X6Iy+AXrc/XGygk4CVs
         E9Xd1BvkmTVatLEx3s2VV202EheNZiM4LjmD4xyp5mb2L/6gziQD86dn22SyjzrNsb/z
         0IwphpaG+vxdD/Y7rmjfktqI5ZqkTPoKNJ6S+27NpPNdon63gnEvXfDLYDegYSx9ZiHY
         8Qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773315355; x=1773920155;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MQysXvwEtyjr/4QwzwV58b1FSM2E3DJvALB+KxzJwQ4=;
        b=vsWx350C2yw/4TU1H+1gHsNQt4bgiS1HWGYghP5250dlRUpBGcgxVhnkO+inlNZmaf
         UnvfEDGgrQpxTVy1sNuepDw1U++ajgchGMuOQrThq4FXlStb3ctQi2Zl7Z/DawDbLYDH
         1Suehxf/W3bqoFO+PsRUP55zIBFEFi3jrdG8MjZ2WDsmdhxPXY3af2kyTguYmMDC1DOr
         mGY7CAQ6c4KbjuNWWU0J+Hm5b8fnp8XSGelsSMJ4990IVL84Ifwoax1kFa14d3CU+KVb
         0aMC06bXP/elJoBCrTy2/lDP67eHCBtv2ElgCSo7HLMcM68HW/+jh27PxozwljG8xIfx
         laeg==
X-Forwarded-Encrypted: i=1; AJvYcCUo/gXKs/zfKjda36fzvA53zE+UfHzZYuBVOLkahbuM8+6+G2aqmsDCK3NseURGn7ZFGZpc/kIKxH92fuzGs8uehdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCzNcOJ/lpHtNljU6gsPXU+AqM67I5xJnR+GcY412ERqvBIzi
	0wEkG/u34wmkbeccIUM1rXGPPDFTcIVfiZDK91vaRvBQ2Z+cTID+BaCM69Xuk2CDo7dUR+l8E3w
	/fXgKyH1L8uTTx6r1IvGi2w==
X-Received: from wrbfr9.prod.google.com ([2002:a05:6000:2a89:b0:439:ddbd:5bdc])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:250e:b0:439:b629:42d7 with SMTP id ffacd0b85a97d-439f822bd11mr11329258f8f.46.1773315354685;
 Thu, 12 Mar 2026 04:35:54 -0700 (PDT)
Date: Thu, 12 Mar 2026 11:35:35 +0000
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.851.ga537e3e6e9-goog
Message-ID: <20260312113535.2213350-1-vdonnefort@google.com>
Subject: [PATCH] tracing: Update undefined symbols allow list for simple_ring_buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: maz@kernel.org
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	kvmarm@lists.linux.dev, kernel-team@android.com, 
	Vincent Donnefort <vdonnefort@google.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Undefined symbols are not allowed for simple_ring_buffer.c. But some
compiler emitted symbols are missing in the allowlist. Update it.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 3182e1bc1cf7..3cc490aadc99 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -137,7 +137,8 @@ obj-$(CONFIG_TRACE_REMOTE_TEST) += remote_test.o
 # to all kernel symbols. Fail the build if forbidden symbols are found.
 #
 UNDEFINED_ALLOWLIST := memset alt_cb_patch_nops __x86 __ubsan __asan __kasan __gcov __aeabi_unwind
-UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer
+UNDEFINED_ALLOWLIST += __stack_chk_fail stackleak_track_stack __ref_stack __sanitizer llvm_gcda llvm_gcov
+UNDEFINED_ALLOWLIST += .TOC\. __clear_pages_unrolled __memmove copy_page warn_slowpath_fmt
 UNDEFINED_ALLOWLIST := $(addprefix -e , $(UNDEFINED_ALLOWLIST))
 
 quiet_cmd_check_undefined = NM      $<

base-commit: 455baa581922086f1ad44c76d4a3b03c265ee950
-- 
2.53.0.851.ga537e3e6e9-goog

