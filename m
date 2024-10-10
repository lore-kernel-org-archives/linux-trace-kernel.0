Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC482F50;
	Thu, 10 Oct 2024 13:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728565387; cv=none; b=jPoAtE04nblUeuaI0FnyUl8ibMjNZwfgRkcdr29yqaZaH0kx3sWL2ND60V9DfIdYw25cryV3wddz++FQ40LCOL+ppuAIYuHw7/7NstKR6oDS7HT9NftzcDldkVbR9xL7fGB8TaeSEZikyFhdzZlE/MMZvex6ItQ3/AYn1eCicdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728565387; c=relaxed/simple;
	bh=yTF/DCuCTwmkV94QbseV4Sgwp3cd6Lf/APwwEEVxCw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V3I6MbidcilA6q/zFqAtbiNBVfdzknCDZOjSi7QdqMK3PuuzKUVFxA6LrA8HsvajcrPrWU9dD+4fRAy8ZV5no/qh25QU1MitykK4rwb00RDaJWDLjhASraEn+X5ICCCgHZZrifJIt2rb1dJoj+W12U8XY1IP5/1fT4wR9VSTyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iUn9VoMk; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iUn9VoMk"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71def715ebdso628718b3a.2;
        Thu, 10 Oct 2024 06:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728565385; x=1729170185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umckKx76OGnIFeZNOroF8SdnQCtCx5ALiZk+2dsYAZk=;
        b=iUn9VoMkIyu/pi/Usq8xYzGM9+0rPyjHXXtKPnAEIellHNcSBsco3oaYRJv7vHPo+z
         vSkssgQYcXAsasuRymZtCMBN1haAjLjDfEU3ez6UGOWkruGgcXJXFhUNqdTBr0GJLI9d
         nbyPSXxSW9MUqq4fi+zfyZn+/sw0j4NofLmmLX22IA4+SEmcQvI/b2N2vjkLKLNWXqcY
         QBTZ2a55xSgmyo3LxnTc6aBx9iZ7H5rg8UUDEmYRuUj4sgHm5v3EdsZSsHnvJuAjmups
         MWDTv27iNFsEnDjG29sLZZ5nyw16E04avkbH74pme3WdTXur3qTEbgiGJ6pI+RtUEaPu
         77fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728565385; x=1729170185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umckKx76OGnIFeZNOroF8SdnQCtCx5ALiZk+2dsYAZk=;
        b=HBeMSgdT9stws1T+d9nTufGaMM9FNiXAmUKY5zdUoL0plbPDcOhnxCo9ZeYfZWmw1d
         pcJCE40IjWxlXPasgX9zWvuUaROTmatFNvOpZKZh1pK3QzHzh2gi+6puwBai0q+rWebH
         q/n7iluZTN90jEz+SaJnh82+9kgpbHCBvWFp4Z1ZAOAO4m/rKJDEp7WEle+kBnM5HUv4
         svIwV2AelYabxN1qhkr909mvFqkyoA8A4XtOJ434vHZNqnJ0hVo6byq2hIRuyzQ5Izhj
         cS0m2x0DD9/CbEAltbGf/5/1u6zLKKQuKP3NDbFTqUfCIAZ2lW1uXW6B6ZniZEhKxE3s
         YM+w==
X-Forwarded-Encrypted: i=1; AJvYcCUDvjKW5WyAhU9MzoeXMhzoIVDMEkJz+Es5+lJ0llPJy/XGeDipwc22HiPnqNFOaKMCn2sDl/dhaB0fvc4=@vger.kernel.org, AJvYcCWyO6Kj2bLUCly4oIFG4FqarpRreOjf71JYa1O2rRHxrSpkVLZizx3OjVN/tCb5wenyiDpzUqrSzx7Q0xK3K5qoOs6g@vger.kernel.org
X-Gm-Message-State: AOJu0YzZQP06wPVhUmZJnHUl1eJs4JWpj6af5dlrVyR1tq2VFV3NmeJL
	EAVsDuUFLpf3e/+hUwQNq7PoD6Yp+ngXRjsoBxlpcu99V4g8Cj0U
X-Google-Smtp-Source: AGHT+IHOw5mZSXZV6orhSQFurdsUrV171mtqDrmQE4NJWnDDKYrehbw6xLVLrUSxQZZkF47741FYNg==
X-Received: by 2002:a05:6a00:3e12:b0:71e:cc7:c511 with SMTP id d2e1a72fcca58-71e1dbc7610mr10383972b3a.23.1728565384604;
        Thu, 10 Oct 2024 06:03:04 -0700 (PDT)
Received: from localhost.localdomain ([240d:1a:13a:f00:4b94:68e0:2d8b:3983])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9f53e0sm980693b3a.68.2024.10.10.06.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 06:03:03 -0700 (PDT)
From: Tatsuya S <tatsuya.s2862@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Tatsuya S <tatsuya.s2862@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: Fix function name for trampoline
Date: Thu, 10 Oct 2024 22:02:59 +0900
Message-ID: <20241010130300.2083-1-tatsuya.s2862@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The issue that unrelated function name is shown on stack trace like
following even though it should be trampoline code address is caused by
the creation of trampoline code in the area where .init.text section
of module was freed after module is loaded.

bash-1344    [002] .....    43.644608: <stack trace>
  => (MODULE INIT FUNCTION)
  => vfs_write
  => ksys_write
  => do_syscall_64
  => entry_SYSCALL_64_after_hwframe

To resolve this, when function address of stack trace entry is in
trampoline, output without looking up symbol name.

Signed-off-by: Tatsuya S <tatsuya.s2862@gmail.com>
---
 kernel/trace/trace_output.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 868f2f912f28..32a0858373e2 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1246,6 +1246,11 @@ static enum print_line_t trace_stack_print(struct trace_iterator *iter,
 			break;
 
 		trace_seq_puts(s, " => ");
+		if (is_ftrace_trampoline((*p) + delta)) {
+			trace_seq_printf(s, "0x%08lx", (*p) + delta);
+			trace_seq_putc(s, '\n');
+			continue;
+		}
 		seq_print_ip_sym(s, (*p) + delta, flags);
 		trace_seq_putc(s, '\n');
 	}
-- 
2.46.2

