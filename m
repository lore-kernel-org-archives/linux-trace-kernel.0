Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFB2367A0
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 08:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745569059; cv=none; b=NTM794vgPZDNeUtlDVxOs8grX6bB2nd2bV1NWAQKANSo1HAXLOtRqQAQ6ebPDSpf6hd8qypIBdf/1rewX84urWUK7PASeSPXJJdfqyB2Aku5mIBD5WyUn6v3KR1guE/nF14NXDhVxLW8+b6eD1RUs97Ykf/95TOI+pbeTJdITH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745569059; c=relaxed/simple;
	bh=zb1DGhQBoGmzpTwSqI1Egmp9Z8u5JW6+w6xVrEIvOU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=JJs1oWYDC5P55SIx6oCg0HW3/550M7PDTAwTYPRhfJ355FUS4Y3cc+9+VAvaeny4R4Wsabqsorp72Ox63wZfoKL2SHUi916v8S9ZJZfUo88hD4KiVUK9xB86Urdcxa28zy9SQYxnPwDGJxKqGptVjKSHUttDJQhuBShOKR5wjdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eorKbbyJ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eorKbbyJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745569056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7xNohxILTOPqd/8P2+09zos3Ls7ebzSxsppSFkARpPU=;
	b=eorKbbyJvVDwzOjDaamMLyP92weVkUhJU2DrpyUHPq7a1VTK81/gJUsWHhanVPefdBXlHU
	KkSE1feeLfC1Qu/FdSed372XarvbeONh99d4ySwzYeQ6oOvkcNwbIArsLQuIaGuw1DgsEZ
	mTll03b+GKrMTHmkZ6sXCfIjFgH55Vk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-635-FBDoltcmPdG2FDUeh7_LXA-1; Fri, 25 Apr 2025 04:17:35 -0400
X-MC-Unique: FBDoltcmPdG2FDUeh7_LXA-1
X-Mimecast-MFC-AGG-ID: FBDoltcmPdG2FDUeh7_LXA_1745569054
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ea256f039so14339155e9.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 01:17:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745569054; x=1746173854;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7xNohxILTOPqd/8P2+09zos3Ls7ebzSxsppSFkARpPU=;
        b=EWsu8j5TBDTSMeywfK0aBHHWmZqHZlcZCy55X9Ll/HiJ8P2Rrtgfi2WKBemfbxBJCi
         n1Ojv1UDuIZreEMHra+EAwaHAAY48xZxjD4fqazkSLccHr8+2Nk7Qf7cT7KwHpD5F4oX
         j78lYfOOYFy48UcpIeoRorhWVFLD50rhxlxSMEZxYk+mk67kPW9NYxJupOl+n/sJqh47
         0G5+AcjNw9ewwH7RrraXpQk76HWhAir68aQpsEvfsHUYcEQ9QmyUaB7KeWVnfu8ApLXo
         x4lb1+jJb2EEpeIpTz7miLSVz1Fad5ea45Uk8nNPTZUHYLIb3cwep0NZ+UZdXgFvLl3b
         PxRQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4sNfnD5ouPLUB5/5T68ptZqY5i1KQIIlxqb2AHm3EAVrlnv4esYZd/2eI5ojEQy9isV3HWpy+0K4xS9LN66O+AyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmXnCSWNgWVVAq/S0wcucbjXozWmRLIv8FPmdFVOrafHqlK2ey
	SXePNZE5B9BB2CH1S9HQBDfg2xypufaPC7qKGO3l4yc/7lgNt7w7atSIPn8glIkpbgAw6MxS3Lc
	8RYtt/Gf12c8sgO6oS9FMp8dQQUKczy0p4zULvp0DITfd0jgfNoOIGdoe0p7r9mzA5Yw1JA==
X-Gm-Gg: ASbGncvmNqTrkRGbgpEAptSaerWHpCm54EyXvh9uP+hpI7xZFXLF2EeSInmvd52Upgh
	PuCcgPnlMD04KyE+2vYGMZdhtScs+wAL8rxWIJ/JKlm7f5Mv2oCQYS6J0L42RlvOuFkwFW0kdjq
	bPbqOiX3roGIluwMSxDjLfS7/CmtafJLwYFAxEHF1Oagcxj4HMaQA4epozU/QuBnuttyBhzqW2v
	TnoZ/Y0ZuFvLsbzewQ0QYTe00Cix9EGdyRmpYcCfrGBYWqhx0qe2hFjzRA6X7s6Rd374x74nrw5
	VWlCvYnvseCqo+VFLGCK8mVq9zkxBS6RPO/DS9K8k67A/eV9DsAUc8vIhD3zJPYQru4VJ6M=
X-Received: by 2002:a05:6000:430d:b0:399:7f43:b3a4 with SMTP id ffacd0b85a97d-3a074e2f3b3mr903680f8f.24.1745569054455;
        Fri, 25 Apr 2025 01:17:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFENsE4+5Cu5ObTVfglloYLU5xkxFPfypsGCDuMGrHDVRAMikMZaqFHaFNkwSVPa60/smc7Mg==
X-Received: by 2002:a05:6000:430d:b0:399:7f43:b3a4 with SMTP id ffacd0b85a97d-3a074e2f3b3mr903634f8f.24.1745569054012;
        Fri, 25 Apr 2025 01:17:34 -0700 (PDT)
Received: from localhost (p200300cbc70f69006c5680f80c146d2a.dip0.t-ipconnect.de. [2003:cb:c70f:6900:6c56:80f8:c14:6d2a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073c8cab5sm1648138f8f.10.2025.04.25.01.17.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 01:17:33 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	x86@kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-trace-kernel@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Andrew Morton <akpm@linux-foundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 07/11] mm: remove VM_PAT
Date: Fri, 25 Apr 2025 10:17:11 +0200
Message-ID: <20250425081715.1341199-8-david@redhat.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250425081715.1341199-1-david@redhat.com>
References: <20250425081715.1341199-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Be51o9r5GabYhUjpRK_S-ipp33m8grE6MnBQD9ev4dM_1745569054
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

It's unused, so let's remove it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h             | 4 +---
 include/trace/events/mmflags.h | 4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9b701cfbef223..a205020e2a58b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -357,9 +357,7 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_SHADOW_STACK	VM_NONE
 #endif
 
-#if defined(CONFIG_X86)
-# define VM_PAT		VM_ARCH_1	/* PAT reserves whole VMA at once (x86) */
-#elif defined(CONFIG_PPC64)
+#if defined(CONFIG_PPC64)
 # define VM_SAO		VM_ARCH_1	/* Strong Access Ordering (powerpc) */
 #elif defined(CONFIG_PARISC)
 # define VM_GROWSUP	VM_ARCH_1
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 15aae955a10bf..aa441f593e9a6 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -172,9 +172,7 @@ IF_HAVE_PG_ARCH_3(arch_3)
 	__def_pageflag_names						\
 	) : "none"
 
-#if defined(CONFIG_X86)
-#define __VM_ARCH_SPECIFIC_1 {VM_PAT,     "pat"           }
-#elif defined(CONFIG_PPC64)
+#if defined(CONFIG_PPC64)
 #define __VM_ARCH_SPECIFIC_1 {VM_SAO,     "sao"           }
 #elif defined(CONFIG_PARISC)
 #define __VM_ARCH_SPECIFIC_1 {VM_GROWSUP,	"growsup"	}
-- 
2.49.0

