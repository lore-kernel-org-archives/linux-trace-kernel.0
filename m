Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7E21146B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Mar 2025 22:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742336106; cv=none; b=VZkX4GX1xJbi3/KCOmHQB/TXIuGkQPBYL98wTrLxQns8E/oK1YnBSCT6FRat456CB+4PGfTG7ll8Kma/arWUzDy54j3gUoTMo5JHhTj6e9XutvW/65+dAC/Zx/dNGRZM5pTN6MzfwuelFEHjvCQdu3Rw+RwWtvOjPm0iwLyQG4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742336106; c=relaxed/simple;
	bh=dmIEFpP5Vzp4R9JKUVjUJzGbQUrzscJCuLnCPzsk7xQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=gKwyebh1ZqoEzgNxLTeLmBnd9+aQc2SjCdhOnm44ay2zm3TbLr3QIBXK3Yn4IIjl1hbiCY95Y1JfgcGi5qBDPLn4BOpm584f3zQFGe7+acW5q0jMBI/G1yJtFQxMG5YqV/fcG02h2OL3GUriXdo7fVJD8R+pfSGAjYcHquv8548=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HZb8S0xF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HZb8S0xF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742336104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rus6kw9XsBL2c9jHGjOEjWiY0U6NqB+KHNJXO9LzuQY=;
	b=HZb8S0xFrLEAjsfe8oezHXKdyrdCy9dYddjEnMDPGE6HKYYhtUJ0PrAtk4WLMdUZsoU32g
	nNzQWv+ki5evKxXgNUU/2A+GNqx2UoZJEHiiJ8Ej/X+UcaCu4d4qLeKHOdmFysGHMGVHF/
	FI9gnlhHWPLYeRPTPKThznrapkXzLiI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-B5zaEGUMML6tbjEV3CDJ9g-1; Tue, 18 Mar 2025 18:15:03 -0400
X-MC-Unique: B5zaEGUMML6tbjEV3CDJ9g-1
X-Mimecast-MFC-AGG-ID: B5zaEGUMML6tbjEV3CDJ9g_1742336102
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-391345e3aa3so3650447f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 18 Mar 2025 15:15:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742336102; x=1742940902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rus6kw9XsBL2c9jHGjOEjWiY0U6NqB+KHNJXO9LzuQY=;
        b=EF6YH/TWCyLuo6vAxaB6KtN6x5YIP9govXvRyUF8t3E5HLs7j3xoezN6TOusbjTQS+
         svdaSbRhVe4k9zv5nS4nv0Sav+CsFJ3SQX9uFydmUv8A3aEbRkWDGw+KkDLNfhDYIsR4
         q5cvBAm5TjVik+xJNXtFhNrl6IiVOuWq4mz7h1xow9Sgmd13GEdzI0hoFGxsVXKq9ZVb
         0utuRi8fF8l2owEy/m7AZVwELTr/XygdyyMPv+mNDagk07PPfvJMt2xqYJ7fmBSiFhxp
         4BgFLgy/OhzPsWU0wGQJGcMHR8K7uN6IKWjT/IfeeUmpqUkm7SHj7mlSS6iM0dgjFa8z
         UiNA==
X-Forwarded-Encrypted: i=1; AJvYcCWLOt+q7cagVM90VOuMcpjBxb84CUthgIRrY+EAKBW04nztkNs/2Ihm9E0r0r2WwLyxl3XjUCYze7GYIRSJknjEpaM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzuia2mNEl1sr5zaWlMuqqHSykFMiWc1C/uFPLjbZpFJXakx8Jd
	QyaUYc2yhKGqcpTvsKskpQYxtsFbmzCkmB9D015bXzrvQll3Yk3e6oVYc28b6Tk1rdq7FsT34R8
	J3tF9vE+5l4S4j7vExq2Iml+nAOmz6T+GjL4G7UxG/IVWA3HuuZP/Sli/hhyhIgcHp3OYcg==
X-Gm-Gg: ASbGncufiXpJXMuQ3YBeOBnnmcQ7PdNddpuwcL8S1n7JPS/ObQ5gSlzuml8ZIHQtnLk
	VMbrVlXZdjL7Ssk/tasSIgao0PYnHoMw5gqliHaiCmEjPOvKcito+wB2ICYl96R4dFyj+H4SPjK
	F/FSOfECQululoN2FDR1JLFWDVOPrcWSObXK4Dc+gf/Wr66Bmvw7ortVlPp0DXoZvfucYLUOKIp
	RNcSfWKdjMPJgP0rnQ2LkrCDYUTGKXt+oTt6j0NA0/YHKBFXvbs/IuGqM6aL7MG32IYNNhb8QTa
	ms92iG5g64XNoelLiAAdpHL21+mUU74Mc0yt0f5EOU1+xzec+VyRP+EBDxfImHITke0fIHobV5B
	E
X-Received: by 2002:a05:6000:2a6:b0:390:e8e4:7e3e with SMTP id ffacd0b85a97d-399739b484emr390658f8f.6.1742336101722;
        Tue, 18 Mar 2025 15:15:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHEntLQOUh/Nv/fGa/REaqlKcGpxmQ8E/qfsoQdKPfCKbsE1Lco5OztnXYuajlRpXhgshxCpw==
X-Received: by 2002:a05:6000:2a6:b0:390:e8e4:7e3e with SMTP id ffacd0b85a97d-399739b484emr390645f8f.6.1742336101239;
        Tue, 18 Mar 2025 15:15:01 -0700 (PDT)
Received: from localhost (p200300cbc72d250094b54b7dad4afd0b.dip0.t-ipconnect.de. [2003:cb:c72d:2500:94b5:4b7d:ad4a:fd0b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-395cb318a8bsm19682001f8f.66.2025.03.18.15.15.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Mar 2025 15:15:00 -0700 (PDT)
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
Subject: [PATCH v2 1/3] kernel/events/uprobes: pass VMA instead of MM to remove_breakpoint()
Date: Tue, 18 Mar 2025 23:14:55 +0100
Message-ID: <20250318221457.3055598-2-david@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250318221457.3055598-1-david@redhat.com>
References: <20250318221457.3055598-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mI0hkE-zxwpG-JjReKRr2ObUwOhxTVOKAgW8HIlyX0s_1742336102
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

