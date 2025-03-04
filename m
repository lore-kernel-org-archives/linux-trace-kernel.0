Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF8A29DB7D
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Mar 2025 15:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741103346; cv=none; b=kQxgcfYLyY0rAUwid+VugHARYCoDZxzDWKj0jVS4HANXelb/qcuLvXmd+FATfgvWmlOKtpZTPtStP0HwA4SM0yGJoC/mhbUKnGOPMHg6OYjvyPrMtg9RzaI89XwH7jGc/49rrUTZjMWNJRBQ9OPRwKpoueFtaLryaW1JyIftkTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741103346; c=relaxed/simple;
	bh=uyHJhziojFGk/tam8soDl9qH4ruNaNMd8RrIguscx8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=fPwI9gX4+VFqyLI8l0gy5bGSWX8UMT3Fy6HTmI1NZeyZmkrPy+YmI6F18CgC5UPJ9BFCeHczUIykindhUDw9vxlL2DDSLAD4ZPZmngDqo2Xc/lSH9LrzA72gsCXXalbnsHKB17mSKXuZU1Sn+MRo75wSrwN4hmSQfn1JrrR4ZGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NoKYOUHY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NoKYOUHY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741103342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RHlzy1ROEWhQbxxG4Yv+rRoMty5ce9tc18f8MaHZsU=;
	b=NoKYOUHYLvFcLni16hzXllPXEEC4M9cpWMoE3Kc5vZ3ky8z9Q4C84VBTeEu2Tko3d4Y0Mz
	vIxXpS3wsO4eSL2SsUn34Xx63r788uP9cKFvwOVPjqHquPQgn767qj+3dozh8bbVWWuE+v
	GCKU4MHtZPaUxNc2P2/0eN+7AD/jFUY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-CWxLlz1HNYKp8aAIE_Es9Q-1; Tue, 04 Mar 2025 10:48:53 -0500
X-MC-Unique: CWxLlz1HNYKp8aAIE_Es9Q-1
X-Mimecast-MFC-AGG-ID: CWxLlz1HNYKp8aAIE_Es9Q_1741103331
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43941ad86d4so26883605e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Mar 2025 07:48:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741103331; x=1741708131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RHlzy1ROEWhQbxxG4Yv+rRoMty5ce9tc18f8MaHZsU=;
        b=PWL9IGo1MmnpYjkmMnu1AsdyeI7sJUq8mdr96V8R/QJesMQC+qS+B2FIyCDmXJyhu/
         js+x+m+NE95cfOCSoLNdi1889w70ER3mDLT6dG1bZmn3R+S1F3K28cxWumQUyWGEykjK
         xFzVnIgG4We3lmNBmi/2rEaQ1RKACN4nTYuaH183kjcKtAM1N/3lxMiBeowdNvklfTA6
         9eqkBpn5oyq+go6kUjCxnT4dtqgY5f9CyAr3XigVJoA+1BUqupVPajZ9ultcH3bZNR0J
         kLfUncon2IXTLNNFa3An9rygqU456HWAoab0ZMmB/N4xfZthoGbG5UwgJUFm5LkzpyN2
         0pqg==
X-Forwarded-Encrypted: i=1; AJvYcCXc1LmOtD51oIcLCoTlY5UwrSmn99VR1YzB98X7/qtoM1q2H8lyPR90ZO0MFWd2FaS86t8I04GmT/IwRYSWJPBkb7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxF5y952G7IlgAFq92z9ysjpSua3c1MYZXrF0CzCuomianko2M
	ZggX1GuKV4M08CeACbV1jrWliAfEtdb02BmTP4rlh+akHbRNJIi+Fwp2jPUXk5E08WTj+OTMhf5
	INR3Gta/mfdOSTzWCfPyqfUCo6nSJrOJ53P+bbyVaT98MDJp9LXS/ClisE0ERfqT66GxAuqkqf6
	/hA+xu
X-Gm-Gg: ASbGnctapGnY8uV67hUJf8AtbcTfHLdn/BZCYKY4C3JNEbz5wxVavozTsoQ+VABHO0Z
	ocuw5cqFIIuObaCtqkDQGggD/lH4TjF6xGYaI/AU459s+dMgu9rvQyCVNvhxWoeK5H+/+tqPKOi
	6/d5tB7ZFpFxaK56KsQSNmT+7BnNGqMC7WS+DDlHLFxHXTvu4xz3aNbhz8S6u6krymxRnBGVBhy
	wGgdFp5wfhTsd/trdyUegrx7lCQbHbtTpSak5TYhBpwgsq49e3xAkaBKHH7gBpjVgcU0pZMGA6N
	cATUJvPh8oOeoFwVsVzRMC9hnUp5gvuzrDwm3aiNa5hOS9KY4Q8xHYFdZGHCs2Q9QaMI1vD1Vh/
	Q
X-Received: by 2002:a5d:5847:0:b0:390:e94c:453e with SMTP id ffacd0b85a97d-390eca070b2mr17839153f8f.39.1741103331033;
        Tue, 04 Mar 2025 07:48:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFS2yQ2nIm92Fqm8oP87QtIsIbeZe5pQ0O0ho/Z0iCYCjljpWAZZP5v8ry/LGiAu8oiIQK1RQ==
X-Received: by 2002:a5d:5847:0:b0:390:e94c:453e with SMTP id ffacd0b85a97d-390eca070b2mr17839137f8f.39.1741103330643;
        Tue, 04 Mar 2025 07:48:50 -0800 (PST)
Received: from localhost (p200300cbc73610009e302a8acd3d419c.dip0.t-ipconnect.de. [2003:cb:c736:1000:9e30:2a8a:cd3d:419c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-390e485d906sm18206420f8f.90.2025.03.04.07.48.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Mar 2025 07:48:50 -0800 (PST)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"Liang, Kan" <kan.liang@linux.intel.com>,
	Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v1 1/3] kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
Date: Tue,  4 Mar 2025 16:48:44 +0100
Message-ID: <20250304154846.1937958-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250304154846.1937958-1-david@redhat.com>
References: <20250304154846.1937958-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DwaxY3QuBUWMr76Fx2vrg54pO7ZaxAjvojDMfkmPcoc_1741103331
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

... and remove the "MM" argument from install_breakpoint(), because it
can easily be derived from the VMA.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 8fc53813779a4..991aacc80d0e0 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1134,10 +1134,10 @@ static bool filter_chain(struct uprobe *uprobe, struct mm_struct *mm)
 	return ret;
 }
 
-static int
-install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
-			struct vm_area_struct *vma, unsigned long vaddr)
+static int install_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
+		unsigned long vaddr)
 {
+	struct mm_struct *mm = vma->vm_mm;
 	bool first_uprobe;
 	int ret;
 
@@ -1162,9 +1162,11 @@ install_breakpoint(struct uprobe *uprobe, struct mm_struct *mm,
 	return ret;
 }
 
-static int
-remove_breakpoint(struct uprobe *uprobe, struct mm_struct *mm, unsigned long vaddr)
+static int remove_breakpoint(struct uprobe *uprobe, struct vm_area_struct *vma,
+		unsigned long vaddr)
 {
+	struct mm_struct *mm = vma->vm_mm;
+
 	set_bit(MMF_RECALC_UPROBES, &mm->flags);
 	return set_orig_insn(&uprobe->arch, mm, vaddr);
 }
@@ -1296,10 +1298,10 @@ register_for_each_vma(struct uprobe *uprobe, struct uprobe_consumer *new)
 		if (is_register) {
 			/* consult only the "caller", new consumer. */
 			if (consumer_filter(new, mm))
-				err = install_breakpoint(uprobe, mm, vma, info->vaddr);
+				err = install_breakpoint(uprobe, vma, info->vaddr);
 		} else if (test_bit(MMF_HAS_UPROBES, &mm->flags)) {
 			if (!filter_chain(uprobe, mm))
-				err |= remove_breakpoint(uprobe, mm, info->vaddr);
+				err |= remove_breakpoint(uprobe, vma, info->vaddr);
 		}
 
  unlock:
@@ -1472,7 +1474,7 @@ static int unapply_uprobe(struct uprobe *uprobe, struct mm_struct *mm)
 			continue;
 
 		vaddr = offset_to_vaddr(vma, uprobe->offset);
-		err |= remove_breakpoint(uprobe, mm, vaddr);
+		err |= remove_breakpoint(uprobe, vma, vaddr);
 	}
 	mmap_read_unlock(mm);
 
@@ -1610,7 +1612,7 @@ int uprobe_mmap(struct vm_area_struct *vma)
 		if (!fatal_signal_pending(current) &&
 		    filter_chain(uprobe, vma->vm_mm)) {
 			unsigned long vaddr = offset_to_vaddr(vma, uprobe->offset);
-			install_breakpoint(uprobe, vma->vm_mm, vma, vaddr);
+			install_breakpoint(uprobe, vma, vaddr);
 		}
 		put_uprobe(uprobe);
 	}
-- 
2.48.1

