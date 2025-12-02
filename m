Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEAC303CB2
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 07:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764662116; cv=none; b=q+kXaCgDCeI7jXy/ZgIdVMK8lwd+Me3U5S5W0ffSWBVEcjbXnSoHZttlCE0q4VNzFbTB+4fx1nWNENoThEZ1+WZOUuCnJAH9YlJU3t1Bie1yutR+A6p8cTpDGYdQsKxRThNvZo/cEcD+m5TmxPJJm6ZVZwt+2jVVG3tQhB4gZEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764662116; c=relaxed/simple;
	bh=HDJieKVU1OPAPmWICR7jITnRxxHe+vYqQPrTd5IfbEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qU3oVtsrUKytkQgRzIL12fZZoecWKSu4IwcTzDYVkBqBpIQfJ/8iHrtOC6o+lneShhWh3C5TPFiNIENQ+t0bqp1Om2TMk5PipK1q1YquC67yS0GU0lnL9pS1htX6NbUOcvkwFQm0btwvhmv5NivMdET6Wdhsn8vOHhPIxAM3k3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jy8Ps9oN; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jy8Ps9oN"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-641e942242cso4650224d50.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 01 Dec 2025 23:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764662114; x=1765266914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhV+wF32u4YWe4M1PbEZf3RsFPpmY7QIKhhlfIeHA4U=;
        b=Jy8Ps9oNB3ab2K2ycUuXqN0BU7zovA5qMOWdMPG+3EBjsixSFYzmiDSP+ARnJvCN4z
         GEOjWMcltGsp9x7DSZhM5BZ3RrQlCttgxwt2nl7TJX3QYXMbPsC1acPKMdmopTkssmCM
         YsL8uFGsVDDXKNz87drTtLsozNGTH802ekoqHADWAPAMBjsuGNBPDmhEUpjjWNtl0xyG
         W5dJemmAFon/n8Bwydo0UU7NwGrf1ngtAbpy4PQADn+eNYkoR0cPxF6CojFC4LrklR+r
         NOo1zq7x7fFuwVi1P0uMjizbZNbGeYeJL3u96joi6lfH8bZ9+Pw+1WIHz+hY4n5UOzN+
         a0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764662114; x=1765266914;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nhV+wF32u4YWe4M1PbEZf3RsFPpmY7QIKhhlfIeHA4U=;
        b=eB3zxuyC+tDgNFNqjsdtq7v0hNt/WoAyYa0R1PELNdHYqdYSvHVT4J5lY7gi/qPPrn
         Q2R9YLpfJY1N1siXVOuslncU03pZh0RcWyjLokr9ahjPoCutSfKbuqaWtL4Cm7B4i7zD
         CjRry0sy6T8+AOFGIWONhFGVRI5MsUR1yAMQ7LvyPKBfMXR6iw4ALFTAFmv1zXl+dLYY
         AdrxtF2Zp+j1evzogw5QNoo2wXYt/zqeUr/27ENFziXy5hiBfOwkLbpgInRm6FfhFjPr
         5vKV4MNiUe8QISy8YEqaruAWjZ83ME4BwCtY7gI4sAjI/GsTEHnTLUdQ7RWXlCiu0rJx
         smaA==
X-Forwarded-Encrypted: i=1; AJvYcCU+Ad7JhpP61CwyA6USUahvUT3jrP9U2KAEaZ/jKV6dY62NYu6AOeNxTbF1xoBu9E0tX+xHIkcmavuB2h3JRM8Zi9k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRSTEUW37xzZDpN7idgpdL6NOiVhHnRNTk08xydVjkEyoh1BcG
	IecFrb0te8aZgKMzlSB5jbdqOKtCbS55UgPI3CrkQChtyw3V6LWYkf6g
X-Gm-Gg: ASbGncv7cl9jj3eRF/1/hUQQ5Nu7VsnpUmzBWr5oRynULS3hsqC0A+AxxPBSl8WNdy1
	1R3B0ndHakCC3Ti+ylKysZVzdmOtjPebeweDz8xV3ENLt2k+HED3Gt4PXH+Rlzk3abWL0ThSzEM
	WmOqnPylP5SpQcS5irPWMO+P2bDmeDMq7511CNCwBEBN6u6Vb2ECMCg+VGHHUzyaVgJYyZlHGLm
	/mtNwhCp7ZI7xURpzXcgZrc7Bs71Zc/8El6CQsVCqyvR7p3KlnJZWiiGsgi1B+d9PtoZFerqJy8
	vVBEmZ/xjzZHJAlXBBI/jziqdOOmgvj/2qrTG8ZdDxoNA/rbqNdfBwJj2HPAyWwSnwJGcxtFtVk
	6buNqe8K+ktHAy+MeshBNCu4tt/NMobSI5GqWdjhUaEdTKBTPpcr20iKE8J2K6HyIzOkXvSHuK4
	be8yKk7BHa2AEylK3PhVVX9BMYRFF6OO/jTiUPOJf7k2ZY2Lerpjc=
X-Google-Smtp-Source: AGHT+IFBZzlyhlJjdYgFkuL2hoZT20pUWcYFhY1fRPsK8reHDBcNcbu7yudp/HsStn2A2L+CGjg/Og==
X-Received: by 2002:a05:690e:134b:b0:63f:7da8:6b8f with SMTP id 956f58d0204a3-64302af092emr29674313d50.54.1764662113717;
        Mon, 01 Dec 2025 23:55:13 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c050d98sm6008225d50.2.2025.12.01.23.55.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 01 Dec 2025 23:55:13 -0800 (PST)
From: Shuran Liu <electronlsr@gmail.com>
To: song@kernel.org,
	mattbobrowski@google.com,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v2 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Tue,  2 Dec 2025 15:54:40 +0800
Message-ID: <20251202075441.1409-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251202075441.1409-1-electronlsr@gmail.com>
References: <20251202075441.1409-1-electronlsr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 37cce22dbd51 ("bpf: verifier: Refactor helper access type
tracking") started distinguishing read vs write accesses performed by
helpers.

The second argument of bpf_d_path() is a pointer to a buffer that the
helper fills with the resulting path. However, its prototype currently
uses ARG_PTR_TO_MEM without MEM_WRITE.

Before 37cce22dbd51, helper accesses were conservatively treated as
potential writes, so this mismatch did not cause issues. Since that
commit, the verifier may incorrectly assume that the buffer contents
are unchanged across the helper call and base its optimizations on this
wrong assumption. This can lead to misbehaviour in BPF programs that
read back the buffer, such as prefix comparisons on the returned path.

Fix this by marking the second argument of bpf_d_path() as
ARG_PTR_TO_MEM | MEM_WRITE so that the verifier correctly models the
write to the caller-provided buffer.

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Co-developed-by: Zesen Liu <ftyg@live.com>
Signed-off-by: Zesen Liu <ftyg@live.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
---
 kernel/trace/bpf_trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 4f87c16d915a..49e0bdaa7a1b 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -965,7 +965,7 @@ static const struct bpf_func_proto bpf_d_path_proto = {
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_PTR_TO_BTF_ID,
 	.arg1_btf_id	= &bpf_d_path_btf_ids[0],
-	.arg2_type	= ARG_PTR_TO_MEM,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_CONST_SIZE_OR_ZERO,
 	.allowed	= bpf_d_path_allowed,
 };
-- 
2.52.0

