Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D893C416A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787406850; cv=none; b=Mn3VGJlClQAtbZGpsXt4jsyOsZV02jwdiNeLLaDhVXWXOWglumHVxOGxeZE2Bj7CpFwFTwEUgLO6hfjsJuqaLeTWgL7NSmXFqaAHTEqeTJ1U5/1s2QbkuhdOc6OxMV0b+3qCjWDMSflYv7s3Wd/J7nrFuYraZxfBpZDIeitfQPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787406850; c=relaxed/simple;
	bh=AinIhOYRxdY9RQ11Fott/8QSuWqVe/WuXNQsPZeV7zM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TJz3mCfXjrNfYb3lZQXru2x1cPx9OPF7ynYnUP93N9z3E/k3UfHxOhrkO+VB1MOubqDRm4+mjlmr9IHY6XNGAC3V7YQwLU1CUODtg7i4vnZTQDzqlV30w49H0eXIug5+sLUbkxW7ku0x8PblstJ9hrVBrFeyS0uD2qHURFJ/ZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Q+F6MFYP; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Q+F6MFYP"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4954dcd6131so17149535e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 22 Aug 2026 06:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787406847; x=1788011647; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ei9aAhCyyRq9nczFsrb/oQ6US+9hvk5Rs5Wuqs8mBgQ=;
        b=Q+F6MFYPnjjZXTQBjiiGUuu8ifKu+d2kjpTf8wEmN9T/27lQ3bX+8jFbm/lSV26u/8
         Y7rLXnkEqXCKBOYXRtXhWbaBYqN9kB1kTDgS27DvF0KMlCq5LZqFt3NK41HTgdAEuZmB
         hD/zt3G4STNdV23XqM+GJ+VyL+ku3fai32Cxft1XBdWtgL9O5jqtzFKBSVCdTpAMXEYr
         93lVOgx0QwUXbZSutMimuDsVPNzwAa0i+whuL9+RsTIsNUNn4ElIMjzxz9T2Msid+zGn
         3CSb5ym2iWljxZE6uFz/DGKJu1xa6uJUheAsiBWej9qgi/FRRj7ZSSUrac8a7AMUxbv5
         zXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787406847; x=1788011647;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ei9aAhCyyRq9nczFsrb/oQ6US+9hvk5Rs5Wuqs8mBgQ=;
        b=YJG0fRTDB8/GGyPT6kuUd7lyAQqiIottWdt0Bb+up0/lhBY+r/j9D+l17Gvqt/X1Cg
         MbV2UgRRH+3Mzs0iRumxYTRYoSGhWHO3yf5jPc+PEzBiaea2pJARyH3VKRJOCIJuHBni
         RwTaJPJ1BEvZJx8RR4BovJDCXEo1qehCOyUnkNxEloVrl82kv+FJ96ChhgXC0Vu/ESZi
         WtoKP+N4U/4Vnt9qyA+jqlSKycYb9f4mkg59imUtLVfveaXgwFctKGcUHu25Uco6RHhe
         kp2rSyYgI6SW2exyQb1gyadr9X2ZtiaLQ5BI6UO1aHb8f0YLutLzvcZi3FM25JL1+UNk
         ZTfw==
X-Forwarded-Encrypted: i=1; AHgh+RoSynLIz/9Hov5OhO+wnTNNX27WBqDuGSngA6S1surcQRm48Q0qiNgK291qWcZu7AYp+NMdhRAN5pBkUyHBFHYR6rE=@vger.kernel.org
X-Gm-Message-State: AFuF++mjwZcjGAhxYyyGlCmvTYBeleFQS1cVIh673xUjzKPx+zpsuGBR
	EP4q+HjydbGCko7f76IW/Iu2ZAWl6jbiB0aLxggo5RbBWrrgN+HXhxhTqY5sJtF98z40v4ho4Q=
	=
X-Received: from wmcu3.prod.google.com ([2002:a7b:c043:0:b0:499:8f0d:36d6])
 (user=ardb job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:8b77:b0:499:48bb:417e
 with SMTP id 5b1f17b1804b1-499b82f4163mr187118595e9.2.1787406846628; Sat, 22
 Aug 2026 06:54:06 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:53:25 +0200
In-Reply-To: <20260822135323.795946-11-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260822135323.795946-11-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=ardb@kernel.org;
 h=from:subject; bh=LLSSaN9rhZ2F3aT4P4AsB5UNc3JBgAb9PUajizskM3Y=;
 b=owGbwMvMwCVmkMcZplerG8N4Wi2JIatz5Y0AZ4svS9ISbTaf6Vvbffb640AuEdFH514lyFxeu
 vB339++jlIWBjEuBlkxRRaB2X/f7Tw9UarWeZYszBxWJpAhDFycAjCREiuG3+xHy5/ozft6vo39
 a++HnWc27J26lnlODVv1x/cTz/MfferGyHBrod6fpd6OR87MNvD91aMtcLL+0Su90/UXLE4ohsc 1yXMBAA==
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260822135323.795946-14-ardb+git@google.com>
Subject: [RFC PATCH 3/9] module: Place MOD_TEXT before MOD_INIT_TEXT in enumeration
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, "=?UTF-8?q?Adrian=20Barna=C5=9B?=" <abarnas@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	linux-arm-kernel@lists.infradead.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-modules@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Reorder enum mod_mem_type so that MOD_TEXT appears right before
MOD_INIT_TEXT. This will result in MOD_INIT_TEXT being allocated right
after MOD_TEXT when the allocation logic iterates over the memory types
in enum declaration order.

In a subsequent patch, this will be taken advantage of, by allocating
.text and .init.text together, and freeing .init.text by truncating the
allocation. Doing so without this reordering would likely result in more
fragmentation, as the truncated .text allocation would be followed by
.rodata and .data/.bss of the same module.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 include/linux/module.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index 7566815fabbe..0336a46733dd 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -316,10 +316,10 @@ struct mod_tree_node {
 };
 
 enum mod_mem_type {
-	MOD_TEXT = 0,
-	MOD_DATA,
+	MOD_DATA = 0,
 	MOD_RODATA,
 	MOD_RO_AFTER_INIT,
+	MOD_TEXT,
 	MOD_INIT_TEXT,
 	MOD_INIT_DATA,
 	MOD_INIT_RODATA,
-- 
2.55.0.860.g4b6b3295ed-goog

