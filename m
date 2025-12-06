Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476131F30A9
	for <linux-trace-kernel@vger.kernel.org>; Sat,  6 Dec 2025 14:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765030360; cv=none; b=maDfYHFTEeXEPK8KmATbVjoG580idTvHH3IxKLwvpm5u/Gs490gpV4BuJwWa2UkzKWkEybzo8Ct/2fWKZPlL2RK52J4Jz2gq0kqxDzY8smelES816TdKgbvBZsU9gl+Eo9uKNbvofFWNJvGokscLC5FM9Lfc9zEirXbtbCD8K5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765030360; c=relaxed/simple;
	bh=S+igu4aju7EwXWFRbjCCQgO7Bx4KXZSG7GeZGRqJ1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9uJzSd+fUfFvH7jT/0l/Qs8xtsM5SCa7qKrPalGdTpddSjpxtDaEpEjgT8N2mn2uOoJeedKgobUNRjqyFuHrZAtDyWp/VtcTU+3+C5RY5IXJs+HVsk+qRt6SBDI0ZNmCwpUs/SJJHUxw9jkDHewusN7DTQEmUB1gG3p0uqglIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmHhnHMJ; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmHhnHMJ"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-641e9422473so2598780d50.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 06 Dec 2025 06:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765030357; x=1765635157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=GmHhnHMJtWXo5n9JfVX7awchSCfxN0g9ni8gmCegbPDs/e53eS0IOAmVGEuZot+rSa
         JV2GtmuVczlxmjS8CQCGvkN0JjMqGlIpo0RNGgQXztIsMZYYCkRFcqJDlnWSmfl5URtc
         zloliAFuImbfZqC2o07VWMhrYcucQrnnQ8+Tdoe0Ng7KkNrxEai8pByu5PLmaJr1vkTl
         v96uNKBpGlt7n7yflVkrYvwdHn6ruQMDVDjoM1wqwFb71AR9JA4LgljVUePly0p8x5vd
         0kfBxp0ivJijzhOwD7GqNSrQpf9h9qlnapG0OLtpWe4NAde6qhE15/z0NR0jHeA9+E+b
         6xbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765030357; x=1765635157;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=jfEY3YqYPeh+U0P4i72dO2L2kws7jDnLDLsc+iPHOhCmkbfptT55t+IKuTRb+fawZZ
         EoTnkg3zH2HVSYjqaQqahztiLzLZi/vQcq5J3GcsYTr9FIb9n/6UYjCjmNg8G0NUiUav
         HdqyOz3KSlijGAQMbb4FN6ztuJXkDE3mbSm1R4Rsu9e4ZJhuTqToYsAWCDRkUzfpTTwZ
         Jy30N9UUfX7Lpfn5K0lNcObu1YAJ69hbzhFclLMHAZEVLitf0Jo62dZey6jsqznYmCVc
         0VrqnTytZCACokTkRSHT0/PkeLd8gQAHxH0E/h9XPonc5pMSeBMF86+mOequ+2NX2Tap
         oNmg==
X-Forwarded-Encrypted: i=1; AJvYcCVoNuqB/4/ivnPpOehskOFnhvde+bZxkcPNsom0spVQqBy3bswGtgCc3sTARMFEAhyiUAW+/PWLxrLLwkpIKhHK8zA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhnh+y5g5Vnx74B06XmzaDqip87OwVw0YBaLe8VddVT6Vx/oza
	AoauqY5v0cneDgKiCdqsgMT1/EkGumEzzYOxqc1KzGBQ3NsdGPtxbsFU
X-Gm-Gg: ASbGncsYc83WCfy3mGyimsq5mRM9DyDKF/+MROOvOqj+8mB29hX3zrmO1pRoCLa5ZKc
	7NlR0XawP3qNPp8XiCCeVmyLSBcFNVe+4iPk3VTkK8ERyHVWUrCULfi4wgISyg5l7CuU5eOOslh
	WaevmB/vHgsJ7y4JOoLrWSTtroU4CdBBqYaMR6BvIxexx6pGMAKRHHXi1Z3kmI5vZVp1nVfpFqy
	OZtXBEb3/Kg8Ea4UiZ5yknSuOefHa2jjpbLMY1XSyO1QrX6vKLPFhAYcX6q4iYCIpgllt/HOpeV
	ue1c1HQImOWbdyOAIy1lZUJitmJGQYdVWv7XCXVHEhJeDdtXSUrJSQQDbjSDlBQg+0OItyKDF2c
	LZsfTMUseOJgHPk8PHaq1Pu7eISfM8XAsIkFbA6HOteIf/0AY/xZhHynJxr+MlgtBjkpSLTuKq9
	Ddw8pFFOZtmuiZwdvXcCSl9KXHDrUeckOCvk/+fFyfZixeLoQn4EUZmvX7GOv3bg==
X-Google-Smtp-Source: AGHT+IHuF83mFXlkaMu6oHm6oMBi8mfMFdfNONlXiyds7RYNVDtirN1s6Te2e+85GpStdEubYV2j5g==
X-Received: by 2002:a05:690c:64c2:b0:788:181b:869e with SMTP id 00721157ae682-78c33c171bemr42202787b3.40.1765030357161;
        Sat, 06 Dec 2025 06:12:37 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae534sm28038027b3.3.2025.12.06.06.12.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 06 Dec 2025 06:12:36 -0800 (PST)
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
	dxu@dxuuu.xyz,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	electronlsr@gmail.com,
	Zesen Liu <ftyg@live.com>,
	Peili Gao <gplhust955@gmail.com>,
	Haoran Ni <haoran.ni.cs@gmail.com>
Subject: [PATCH bpf v5 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Sat,  6 Dec 2025 22:12:09 +0800
Message-ID: <20251206141210.3148-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251206141210.3148-1-electronlsr@gmail.com>
References: <20251206141210.3148-1-electronlsr@gmail.com>
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
Reviewed-by: Matt Bobrowski <mattbobrowski@google.com>
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

