Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8290288C88;
	Tue, 15 Apr 2025 11:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744716507; cv=none; b=UADVPHBMJzm7rP0Mw/vFBP95oXrRyeXTXm7JcHCRRfXLCP0ogx4Ldo7Ozq3Cl9/y1yySNtW3OrW5+YgYyotMutNK0m27nhMhbCphnCV2AecQtHck3h5Edp2hPoIowD0fWhrO33qECuRu+wM8cyeGRyMMVL+rgr6VtHjQ4iknDB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744716507; c=relaxed/simple;
	bh=zjo+6QiCbQI7Wkdf1JLfiryh8Y4sey5HoOLlYs3E73w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AWPrQo89HgTpZGhTLEfH0pml91vQJFFjGpGx3mJtCDy84GdLfRRgNn+FnJqtUjl7Kuglk56H6Z/M+WcJbL1QiPhkrzoynjO9Q2Fyv1fQ/OVpYF9KBYmsFdczKlLu9mJiGsaY7S1KYLpiX5rLNha3Oa1wwjj4rUNj/04cnQYd1qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iCTEsJ8o; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iCTEsJ8o"
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2264aefc45dso79516315ad.0;
        Tue, 15 Apr 2025 04:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744716505; x=1745321305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DztHw6xaBRM0pi7U2Teie2x2Tea4xhzgq5VCzCNtwYg=;
        b=iCTEsJ8oOv/eKhsymlpSuqQUEfyLW35qZ8uyaSpJsBiAzKw4GtSoWxffe1cmgPP5+Q
         0wU8zoFbeepqujZXQf5V58rQMVlo2DgxO2AFcM7YLbSoQa09E//0YsSMIKeczzcuVO4S
         N5ljnGidehE55P3YOcXkUIVmvIdLWdsoma2QzGpFZBh3bUP0FqEKkiv2l8nJ9o6LOQ3q
         ZltFyyP/ckbLqUiDYuqZHLqtanMijvDLTJth+VXDJtgi+2WoX7zBWjMATjvp+uy3whUY
         e1SYx72nVI5IdgBPzgVnK9MMutqWxDzN+cMSgBJJolile9U2U4gy20Ocq2fx1CPaaOA9
         hhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744716505; x=1745321305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DztHw6xaBRM0pi7U2Teie2x2Tea4xhzgq5VCzCNtwYg=;
        b=eLq0Yep2V6aasW+doCbQ6PwGLz/a+Wzxr0+MeS2GRjNidjkuUXxL67lpu1eOT5Mkr+
         XefGz4sr81qLR9zCOSdwCDR9yq67MKmnHFssxDDeG3M3f6pJq2ARQpqMvGJ3KT+lLq33
         q9OHWhs57SSkQ3lr5FSYIm/v7hPUdiyxNhOizEDWsL0VNqMCohsJ1BEWBYk/vrTCqe0j
         IIMs9kEk0cEknuI0RQ8XQ9weleA8zUwN4Ubxft+DyIqoE14bURXAOoZsY3Ujmho9SmeX
         fjPIK1UHq322j5p3V2Vsf5Am4JNMgZ0zGPxm45/HUXVDEWK7wD+LaA8xyIB4LDWSfRcE
         hFRA==
X-Forwarded-Encrypted: i=1; AJvYcCVF2k3OPlIhXxE7GZggGBykl/MBPY1vmupb+gRIRASAvifQCQ2bw3uDOkbW9vFZYwkA8auH7+BE962RULWOK9ZBz9Bq@vger.kernel.org, AJvYcCVT0+Y2opYweYzHyDdvjNAUkInIXFmE9FJoZqPMuI4JD88gbDCUOvXy9YzMNby8xQKTKH3p6SIcnvwlF+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc+ucnMLEchY79ctHyy2wkxsDSGtHyR71pDim3BLtSpbf2nfHs
	Q4+YpAU8d8ToodIbpKgIBI2PNV8QjSFE0IBOW6ege1ouTofXFOu1
X-Gm-Gg: ASbGnctR07CaHmqVFs2zA6Od3H7INvoV0xQ+8rwMF49ZJoDRYHpEIlBk9QpdvHjSp/T
	8SrqOJUaSrbB1ezQXfSo/hBZDnA7cpXobdPwshecIoiDpzpISsMbbPDBqJG5oHOVLbPXCXjkZbC
	Qssndyg9sJ7ul3Wt9M62yXCxX0GqgX7lhUmuXXNumlmIXFhD6jflZHFkeIhPl9jqgpitzw+hiBd
	KPXNIsquQuvg6er4Z9bpGDfs+9flLrK7QYVapm3QUS7Xx0dwFGkxOFtlxd7iVt6K/dQ14JPy7UK
	jl1FvLf1azQjZulDoA6qUSQVydgL0/nTF+r0FoFwdSwUTcF6wT+MfIl/
X-Google-Smtp-Source: AGHT+IHY9Bs1VQ391f8Z/Js9FKuUCUYZYk8EDJjf4B4MK8pBuEjQk4Wn3P6pKuv58EC/ylCxOsXniw==
X-Received: by 2002:a17:903:1c7:b0:220:e5be:29c7 with SMTP id d9443c01a7336-22bea4f180fmr244295615ad.39.1744716504736;
        Tue, 15 Apr 2025 04:28:24 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd22f0fb7sm8444627b3a.109.2025.04.15.04.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 04:28:24 -0700 (PDT)
From: Jin Guo <menglong8.dong@gmail.com>
X-Google-Original-From: Jin Guo <guoj17@chinatelecom.cn>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jin Guo <guoj17@chinatelecom.cn>
Subject: [PATCH] ftrace: make ftrace_location() more accurate
Date: Tue, 15 Apr 2025 19:27:50 +0800
Message-Id: <20250415112750.1477339-1-guoj17@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function ftrace_location is used to lookup the ftrace location with an
ip. However, the result that it returns can be wrong in some case.

Let's image that we have the following kallsyms:

  ffffffff812c35f0 T sys_ni_syscall
  ffffffff812c38b0 W __pfx___x64_sys_io_pgetevents_time32
  ffffffff812c38c0 W __x64_sys_io_pgetevents_time32

And the symbol has corresponding ftrace location like this:

  ffffffff812c35f4 sys_ni_syscall
  ffffffff812c3624 __ftrace_invalid_address___52
  ffffffff812c3654 __ftrace_invalid_address___100
  ffffffff812c3684 __ftrace_invalid_address___148
  ffffffff812c36b4 __ftrace_invalid_address___196
  ffffffff812c36e4 __ftrace_invalid_address___244
  ffffffff812c3714 __ftrace_invalid_address___292
  ffffffff812c3744 __ftrace_invalid_address___340
  ffffffff812c3774 __ftrace_invalid_address___388
  ffffffff812c37a4 __ftrace_invalid_address___436
  ffffffff812c37d4 __ftrace_invalid_address___484
  ffffffff812c3804 __ftrace_invalid_address___532
  ffffffff812c3834 __ftrace_invalid_address___580
  ffffffff812c3864 __ftrace_invalid_address___628
  ffffffff812c3894 __ftrace_invalid_address___676
  ffffffff812c38c4 __x64_sys_io_pgetevents_time32
  ffffffff812c38f4 __ia32_sys_io_pgetevents_time32

When we want to lookup the ftrace location for sys_ni_syscall, the ftrace
location "ffffffff812c3894" can be returned, which is totally wrong.

The reason is that we get a wrong function size from
kallsyms_lookup_size_offset(), because of the existing of weak functions.
And when we lookup with ftrace_location_range(), it will return the first
matched location between 0xffffffff812c35f0 and ffffffff812c38c0, as it
searches by binary on a page.

When the macro "FTRACE_MCOUNT_MAX_OFFSET" exists, we can limit the lookup
size no more than FTRACE_MCOUNT_MAX_OFFSET to avoid such error.

The victim of this problem can be BPF_PROG_TYPE_TRACING. When we want to
hook the function sys_ni_syscall with BPF_FENTRY, it will attach
to __ftrace_invalid_address___676(0xffffffff812c3894) successfully
instead, and the user totally can't aware it, which is dangerous.

Signed-off-by: Jin Guo <guoj17@chinatelecom.cn>
---
 kernel/trace/ftrace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 1a48aedb5255..8c9a4009c997 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1658,8 +1658,13 @@ unsigned long ftrace_location(unsigned long ip)
 			return 0;
 
 		/* map sym+0 to __fentry__ */
-		if (!offset)
-			loc = ftrace_location_range(ip, ip + size - 1);
+		if (!offset) {
+			size -= 1;
+#ifdef FTRACE_MCOUNT_MAX_OFFSET
+			size = min(size, FTRACE_MCOUNT_MAX_OFFSET);
+#endif
+			loc = ftrace_location_range(ip, ip + size);
+		}
 	}
 	return loc;
 }
-- 
2.39.5

