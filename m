Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BA5336EC0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784053921; cv=none; b=rTpAj0FEFdbih6zc7DNphWqDo10PNQTKchf6v2yTApQhciIwKcc83O4/Ablo78zVFXyTmiENfHTY3tx7DBEDXwgFFHouGVUTT/bclQcn1vwW0kOzhFPToqfAfO8mwoRgymCAWxSr2AflCW69f9npeVyMMU+l6a9XrWPOgoWbS7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784053921; c=relaxed/simple;
	bh=VjO/40vwtlEqoqa0MWjtEwISafs1DuSDXBphWFAVeM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXVlZaU8kzrEz7BcxNYuFbE3CcQ5CaToBLnAMr36+70GENqQ021cTXxx4fW79mLw5akcyvxdV1F1pvMZamg8hu1+hBiXiG1F3BSdFS6Zh33D8Ru2Ra5gsPHpH6WR65AEbbhr4FAayEE9Ralbsrw4bUoa+OCwNcmW1ES2takd5u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MU2gdJms; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MU2gdJms"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efef6533aaso13628306d6.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 14 Jul 2026 11:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784053919; x=1784658719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KwQ36ycy2027O2OnXTT+jaKQ0lX0IY/IjFba+f+HbbQ=;
        b=MU2gdJmsxzKlkum3NlI0Bt6u3MFh3Ge5SRJ6lQACJSbB9X94H807fYOy5FY9pHzcLk
         FAPshpyZbymGqiTrfInEYL+xJM6h/oaOOpjzr1etSvudNc5wz42NKh2EA02P52g8NJ/X
         Vz8ujfqLmPfBh3LaLE/6h9bj/JEwNDdrLPpoFVuoZiGB2o/izJeNX70lG6X6gJsBGKQG
         oO+O2JmhN7hUbkx/eE6O3VuTqbwhj0OotnbPsIYddQnQu7cNIj+14bmB7zPHDYpY569J
         aaDJHcM0taT1bB8QAmbad63CSfgofVa6PXb0YdjckVRWTbaSsv/euNsp6FtUFy6fywaj
         dD+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784053919; x=1784658719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KwQ36ycy2027O2OnXTT+jaKQ0lX0IY/IjFba+f+HbbQ=;
        b=jq0e3/+as0ACYxFqsxOUKmfbnfuMo0bo7Nm+Kj4UExAm3Ybe7YWIijQFeOt131dmwX
         yDqhahu2erTLw76ZqRLwKAPta8e3SvrnjumQZBzwLqyQolKIYJf9MZplhV4oYTqelx58
         zu6CXwn5yHAdr4wP3RKVU9Lm/gdxpZtZMhgUcPwfWgnybUXMlVddgRID6Kcxij24j7/K
         TDOkIfUcJL7haiSj6F8rdOdn3bUaCIhbmcH4DwYaF1kq1yL8vjFb8n+jAElh0Ltktcil
         GZhwtzvEaD8a31d1xdjPeJiMRYb9qyUI+4xnZGuEceAvAJBWg7hIxAdnz2ztboukCn/0
         w3Gw==
X-Forwarded-Encrypted: i=1; AHgh+RprNsZPtyJ3Tu/Q9D2G0A29pWUb8bCMyxtBA3t5nNK1gFYdnUHaIQK7QSdF73TE8qNeBXq1AopkitwDCn7BlPPrvyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcmBaH8YQANLjntlUKpnb3yJzD1zrisPoF9PP5yXmOqpHtcenL
	6MQft1IzbDKgV2UyqGZlfrLx80E7QkH6D18oKZwyegTLiDxVKhX1lQC0
X-Gm-Gg: AfdE7ckltwKznuQlmfD4x5TJ5oH7WuCMA1U6vUWUA0WeyH1i3nSGzuQzjYCc8iiKGzR
	hrNETktxc44NNjtlhgepVboBFTWx1qkG3EDkoYJV3YmELXzZbKOZQWzMR+53SpKKtss1ZLv4Cck
	Nn+wXbmblOLPg3Eu/PIA9VkXGTacCXxHn1U9WPFcoqi8bxDuQZViO1STiHuNGAWbAwiqR4+P9DU
	IIA9bBrpoY9pMsktCl4vdQQGmiCkVDs5H39BNi6XODTSGd0j8yxui03yT0cktYBj8pKjuJvhzbf
	6i8Pt/yonPDL+SPa2zttx9ORgQyvvhwcAVCYWI2Uph79440YX1KxfUIkfGOk5ddevBLBruExlYp
	ScjuZb+3nLW+a10J84LpK7J7G7nR+P1swh8m0+GRCzyhIX79w8+iD42s/y637dCy33ZpRflyL2V
	HwwTuSbL/gHQ/VF36u6dezD33Exlxihwi6RiuY7Qsamp5i2WE4K/taGGAvQ/HkLA==
X-Received: by 2002:a05:6214:3d0f:b0:8cc:ea7f:d3c8 with SMTP id 6a1803df08f44-90401578bbbmr161798496d6.30.1784053918640;
        Tue, 14 Jul 2026 11:31:58 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd87cacb8sm178386286d6.49.2026.07.14.11.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 11:31:58 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Matthew Wilcox <willy@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Jinchao Wang <wangjinchao600@gmail.com>
Subject: [RFC PATCH 07/13] stacktrace: export stack_trace_save_regs()
Date: Wed, 15 Jul 2026 02:31:46 +0800
Message-ID: <20260714183146.12598-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260714182243.10687-1-wangjinchao600@gmail.com>
References: <20260714182243.10687-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The other stack_trace_save_*() flavours are exported, but the regs
variant is not, so no module can capture a stack trace for a given
pt_regs. KWatch, which may be built as a module, uses it to record
who wrote to a watched address from the hardware breakpoint handler.
Export it like its siblings.

Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 kernel/stacktrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/stacktrace.c b/kernel/stacktrace.c
index afb3c116da91..d853c40f916b 100644
--- a/kernel/stacktrace.c
+++ b/kernel/stacktrace.c
@@ -175,6 +175,7 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 	arch_stack_walk(consume_entry, &c, current, regs);
 	return c.len;
 }
+EXPORT_SYMBOL_GPL(stack_trace_save_regs);
 
 #ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
 /**
@@ -325,6 +326,7 @@ unsigned int stack_trace_save_regs(struct pt_regs *regs, unsigned long *store,
 	save_stack_trace_regs(regs, &trace);
 	return trace.nr_entries;
 }
+EXPORT_SYMBOL_GPL(stack_trace_save_regs);
 
 #ifdef CONFIG_HAVE_RELIABLE_STACKTRACE
 /**
-- 
2.53.0

