Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE7B3C0622
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 16:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281703; cv=none; b=lRlsuFyTo4s/PUMc1ssRspXQ5QFZL22J+4Gn51MLChFhW49ZqpicrPXNJTFfJhVuqT+1ILC2QdEhADklwjeOHQXi6oJ6W9lOI5FnF9gI1KiJVjD/W0QGw0/Udpc1Q5OE/RDdLOn9JowI3ESQGyED7lrNE17vFrXKwznC0j0Wv2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281703; c=relaxed/simple;
	bh=csCOKU4ZGweoZ0qVuu0CPj5KbzdHlMu0Ye2PUQfjQHM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAZCvhqVeZnNg9Uy+ymxQ/mdBAE/PVi0l/W/9oh/s5pH3AiDLZgglOniY096yC5dd1fwpFEg0MMSlJmL2DwSdi8X5n+unVkLAvGG54lzmWtspCCkum6oS1ixM3c44Kr2H/Ui3/nl4o4xaTwNzU2iklt1j+l91F0LqEot6yQ6e1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=RjERMzQZ; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="RjERMzQZ"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cd77786e97so27734385a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Mar 2026 09:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281701; x=1774886501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDV783MNsejQMiPhyabnRoBjsJDu3rOHFXCd2/91B04=;
        b=RjERMzQZUxM59pVP+MAu45vvJEI/VSxmuYfcmKSXOxUz9P1AuXtf4ZSOsnrj+/b5cV
         aF8gFyy40YLWVMxWYyiBl33t85XYQ3tt6n9C08zG7DaAyZTOBz1LzSE4z+w5Pzv4cMh3
         XptZOBGhDXHAZ3pXFG7hOQTsrNFm6lo6CyPYNqrNk3zcK2xssE89job+6+hKROlQNEfa
         d16CtdtZSQvxT3PXKE6SW88GAWJLIcxl5yEnpFdfVHiKEq6aBsfpWjsZgH95BZRzzscA
         HETwr8zEpwp5YMEtL1QhEYmKs2zWXonyRh82/5cmMzlfc0F6cpQqDv/rWcpbcMRKH8VZ
         brUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281701; x=1774886501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MDV783MNsejQMiPhyabnRoBjsJDu3rOHFXCd2/91B04=;
        b=RQeK13su6CiZE7ZaIAjT6eTyf/ZYu9PMMovmAsv4G0Z1bm6ckZymQ5tcFhLCGWOvjt
         yVZrYPAsVRwGyGHVpqkLnNcjU8jLRenFi+/iWBmhou2mEXACZ0X7A05LsnJmM0c1oNaN
         UVHkpopwsgHA8QTfEEGmLYkdhN3QUYNTidFJ5awyaAd3Ddd/tyZ7GmtfebXNMORC0LI7
         57JJZDaQENWvszgOxz2u6Hx5MdXET9WN0J15CjDCNuTkijf0lGJX2auRURSNWTib7atF
         SfV4DoEQ4ZboFYB7ZKW7m4qFwo3Nqd5VkvbuihCOkQ+7z6NaErwHiBrbJcNiTa8isgjz
         aYug==
X-Forwarded-Encrypted: i=1; AJvYcCXKfnMBfsUnxnA1Iiykndwu5giccS9YafBJCxHVHZGNiAOp7wfFZZcQUJCJj4tcOk/AQ8/BMMxCTPb4GfYlIuYwzxE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbbaJeoTR/DsPAzD/1/rNEu7E+hvfZRqR3xSXzmVMPj9td7Ua/
	gLVgXC7+SwdiRN96Xd5m/y6IQDYvn8bp3Cvu7FgCLsV0KO8kFpFCk6Bv47LOsq/V3aY=
X-Gm-Gg: ATEYQzxTOGeTftxlMhZaDVrriEEgKOixoNVmeJscFzWgmhdBiZsIfA4w4sFrNLpdXc5
	eEiWKlhjseQmhKyNnip77EW51Qtj0v5sYF5QfYUYR+DxFEVRj7YZqVnNC+YeTNjk12AG405nevM
	3j1RMzo5vGSf/r7As7TsCCciWZaO2tqWBnz1J5GBkX9JAQkJb7hsmPe+nMvSFguukYflu9yy9+n
	Q0bY1BUfyvUq24Qfi++6eW4mwwWaEP6/Y6SIw1TXEi168b2TbYAKL25Y1kQU4o8eOBxi9A00NGi
	uq8IUx4a7lQIytWbx6KCr4a2hY1/XlKxg5ZpfW6WdBSFfYOFh1N2oxuJgWUDBT9bVhtqf/4HZZV
	gOAVkW5S7Rn+alrJUF3aL5fZl0Qk/pvipR/jbwfTISXndePuZHk+RXLMJ9DBTeB6mSkga0cop12
	x5n6bD/BczxyFDEv1L9OQVzl6ROaFUBmRkvx1TBMBADRJLIoWYF8cCmLurYr+uO23pOA==
X-Received: by 2002:a05:620a:199a:b0:8cf:d804:4569 with SMTP id af79cd13be357-8cfd80447bcmr1211283185a.23.1774281701098;
        Mon, 23 Mar 2026 09:01:41 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:40 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 19/19] x86: msr: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:38 -0400
Message-ID: <20260323160052.17528-20-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The do_trace_write_msr(), do_trace_read_msr(), and do_trace_rdpmc()
wrappers exist to break the header dependency from asm/msr.h which
cannot include trace headers directly. Their callers in asm/msr.h
already guard calls with tracepoint_enabled() checks, so the trace_foo()
calls inside these wrappers perform a redundant static_branch_unlikely()
re-evaluation.

Replace trace_write_msr(), trace_read_msr(), and trace_rdpmc() with
their trace_call__##name() variants to call the tracepoint callbacks
directly without the redundant static branch check.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 arch/x86/lib/msr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/lib/msr.c b/arch/x86/lib/msr.c
index dfdd1da89f366..14785fe5e07b5 100644
--- a/arch/x86/lib/msr.c
+++ b/arch/x86/lib/msr.c
@@ -125,21 +125,21 @@ EXPORT_SYMBOL_FOR_KVM(msr_clear_bit);
 #ifdef CONFIG_TRACEPOINTS
 void do_trace_write_msr(u32 msr, u64 val, int failed)
 {
-	trace_write_msr(msr, val, failed);
+	trace_call__write_msr(msr, val, failed);
 }
 EXPORT_SYMBOL(do_trace_write_msr);
 EXPORT_TRACEPOINT_SYMBOL(write_msr);
 
 void do_trace_read_msr(u32 msr, u64 val, int failed)
 {
-	trace_read_msr(msr, val, failed);
+	trace_call__read_msr(msr, val, failed);
 }
 EXPORT_SYMBOL(do_trace_read_msr);
 EXPORT_TRACEPOINT_SYMBOL(read_msr);
 
 void do_trace_rdpmc(u32 msr, u64 val, int failed)
 {
-	trace_rdpmc(msr, val, failed);
+	trace_call__rdpmc(msr, val, failed);
 }
 EXPORT_SYMBOL(do_trace_rdpmc);
 EXPORT_TRACEPOINT_SYMBOL(rdpmc);
-- 
2.53.0

