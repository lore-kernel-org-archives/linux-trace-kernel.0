Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D219155753
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742557043; cv=none; b=eloejzDvA8phvnnZM5r2tzlf2IXrECai1JiicurQ23dDEApOueGu27pFq9CqUSnLTBr+yBftkOoM0WICNzOUskozmYvTZlI/4Ymg+GqvKHCxyvYj0AP010U8gQGwjnWVV8FRM5ZCD+Vk6Z/XPniS12RaGdonp1NW9uzGz0s6I4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742557043; c=relaxed/simple;
	bh=XqLEM356KJ4Nr3KBH7m+aoqP3r0tyveu5sLdaxismyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=H0ZERDdcNckoOSp1DMAT3nP5TdEc0k1zpTHkC3WWVuw451JeovvBQ//rHUvN8FVGKWvFtCmgmTSjkoqnXMN03E6+7RBQQ1CLx4IMN6TOk/+IeEKprW0p7CAEqGeKYZsK+c7axLHxF8dxDj7EacQ+7s/oGGMXOcbr1BY2pgRAAac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gKLjWuy6; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gKLjWuy6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742557040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/AdkIGrCnMsc+er9X66uqVETmxKiULUWSewMsh5Pldk=;
	b=gKLjWuy6vsqFIw8SagXDhwxg7bpi1WrqdfnuL0+BizoKkH0nnUrmenTmp9UQbItR1pXXHg
	KQSSFJRPglSmMwfqCfsFo7GE4Jj4kOh8ydC8AntM7rhMaHTraIdLmSbgBMzBHnQkmQ72yd
	dK6vNb9jjap0YGZ4ERCLEGSexcr+4xI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-VeFhnz5JPX-OSM8qUjLHJQ-1; Fri, 21 Mar 2025 07:37:18 -0400
X-MC-Unique: VeFhnz5JPX-OSM8qUjLHJQ-1
X-Mimecast-MFC-AGG-ID: VeFhnz5JPX-OSM8qUjLHJQ_1742557038
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3912fe32a30so754998f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742557037; x=1743161837;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/AdkIGrCnMsc+er9X66uqVETmxKiULUWSewMsh5Pldk=;
        b=GibfOQVePu4jwfo+bDHKKRnKKPvtM65IZceLQ51oKlR9TLHB/PF1BzoPXH6zVN/noc
         cDLiFwiEoKgFZ1oaZMbfhWe05Ir9qcYwgcW5VCVUQU5pHRbs+862igyD3CGZyQwSIpf9
         1DfJgsoRh01XREXfllb4F0+tcaTuOO1pFqCo2+VaCXW+hbLuK/oSz0JTvF8bepHfIWVd
         n4c8hIDcAlSMeRyd3q0GoW/Foyt2Hz3Xit9jr+mj88fZfTOoNUxg/ltdwlKXUX+pknbd
         /+Z2n8MtK1wAxGv0jaZ29FQ5c0l4oIyfc5u0CnmBg/jcdBj/mtgvePu2qjO0YI9Kp1jS
         ZeGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsLNh7jpPx3eTfRt6TYl+mDNQRKXAy/TOJfY7wYk5T68tLlbOklHR0qmab99jcHE6QwYP0pyPVn6TOKHEea2IQelc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUFJUa/MpHlg31k5T5yaZaGv0rQc+ZIGXGBny4RLOAWL/oFpEN
	SOBoSzDb83PFRxSvaecA52PZZlWr6XZQkwZ+YdPmied+CpDUfvlmgp1RVJwICa4NZFxb2ohevD0
	ndUuEPP+m4YTIRVX1bCylzYroHgNcXHmnfC1oLsmC2chV7LztTVvS8NZd1ivQVvhWBoMY5w==
X-Gm-Gg: ASbGncvLX6HrTj1+BWfDZLbxXdPmKiRuyL9r5TUREQEBtuysMgs9jG+mMSQ4Y6enWgE
	ngFI6+fOq3/3nCCYunpOd+1QzEC/UxsnRilWl+TW6nJFzkkKklTFxLvAubQYpa8x5jqeMNwkehR
	UjzhE9PuvKbywaxuLOf+gTCPnrC2cxrwr0qmhyAp3oeAqzbK+Jcevpm2UxbQskTtO5pc+Ts+WV/
	4cK1X+vDb6sgch539liZegBNJ6pWtZ1JFmWFMyQa5/XB7dCYIdsOue713RhSRxNQNuYlinUacti
	VWm5V9HlOt0AWW1dO/+hLau4okUOO1OtnDfnHHdchOsMPZpklnRosKCFoCJldbEPMmSeWY0IxqO
	s
X-Received: by 2002:a05:6000:144c:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-3997f90e7c2mr2841352f8f.31.1742557037619;
        Fri, 21 Mar 2025 04:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG49ODTrypvf9tYQ5TgQ34vttK3IHB4Rj01M+eydlpDxfAmjxfWJ7Zgo7XydYKuCca6cGe7VQ==
X-Received: by 2002:a05:6000:144c:b0:390:ea34:7d83 with SMTP id ffacd0b85a97d-3997f90e7c2mr2841314f8f.31.1742557037213;
        Fri, 21 Mar 2025 04:37:17 -0700 (PDT)
Received: from localhost (p200300cbc72a910023d23800cdcc90f0.dip0.t-ipconnect.de. [2003:cb:c72a:9100:23d2:3800:cdcc:90f0])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3997f9a3f36sm2189825f8f.32.2025.03.21.04.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:37:16 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii.nakryiko@gmail.com>,
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
Subject: [PATCH v3 1/3] kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
Date: Fri, 21 Mar 2025 12:37:11 +0100
Message-ID: <20250321113713.204682-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250321113713.204682-1-david@redhat.com>
References: <20250321113713.204682-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6Z5gGLRjVzVOHwXOm3qnQq6Puq9gv_BP5v-r6M2KM6c_1742557038
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

... and remove the "MM" argument from install_breakpoint(), because it
can easily be derived from the VMA.

Acked-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/events/uprobes.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 5d6f3d9d29f44..259038d099819 100644
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

