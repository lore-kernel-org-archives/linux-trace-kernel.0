Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4245521D59B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  2 Dec 2025 14:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764685209; cv=none; b=lR8UCigQJfr9gLqwUrx8LexVTSgcReqLFfej4V93rs+VV6SL+sToRJH3dIiANkmHDpJhldiZVdjzxG57xC0mFX9B6it5PWzJrcH3bTRkadigeedgaRqs57IcQt+nlMY9aFrjvTRevp/npM86jtaSxSKu8tD2lY9xTaLwXWgJtGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764685209; c=relaxed/simple;
	bh=S+igu4aju7EwXWFRbjCCQgO7Bx4KXZSG7GeZGRqJ1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwF2iR7VR9V9BHO69cNxfXAbogq7RCqB1DG5FPA/4yUOGhGsP83V1q0MK72WC7N4JuVH7HifPTWPbGvh5UbAT5JFfRrfZVP9xs/d1woPgu+ynbNikV4VjZ24buAxarbJzkJSQM5PIPE4yLQy/sTpgYMn1vFrLRD4OD40djowbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iWJGiUt1; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iWJGiUt1"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6420dc2e5feso4351578d50.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Dec 2025 06:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764685205; x=1765290005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=iWJGiUt10jZa2RDY1pcrGAQvjNpGXz5+epqdPY0SngFhOQiS6APy+XIF+hP8JwU/OF
         9guqfNVstXTMJulyPoamVpkTvRIMrYSG6iDRt5X5YY0/h0Hq3ln4jeVgLz+By9LzvD4f
         q9bjPhLVCtWekxB03k4HgC0NPso/G/xq5j4lVK+q7LiEZb+YQN2HwY24Gg9wR82r4IFE
         mgZOwsxvYOtGvOX0pKQCSRqPQG1CctPPH7vEplgffWNxhOAcBIoSkwqv1kJ4DtcGEdVM
         cnPGM8+RK8dD4So+D6bTxc2gHRilJslikhbpK8IBW9XO7/0ZFGN2cFAdxrP7eiv7grrv
         sfPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764685205; x=1765290005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=DAL71Wl4VeDFLUA5iZ30z65tLwqa25su0meuwVy2xwQuBNL1VOM0E5whKdFbyfjQOI
         X4YnNnv3ip7LQWbBluxmwi9Rp6Nb78FXpq94TiMnKyY+h+V1efXEpiz6gp7PeZn2AkL5
         XcTUw7h/JRqwHPDGS922jxU3736zk08IMjJH8sasd5vh4dyyVdgpEX0etjCgWCE+2zsv
         R3CX0NmdpWX6v+tChRJksARNl3XkyBh6FlqrlGJxQDVKOPwLTVcOaDEJ0CrtTiuFDrQJ
         aB924NxCEXoEhuNCj3P3zuTUmjxRXpr+4tTxWQWTxOrmnyXVwWYrAxh8FGH2h0GSJYSq
         /qyA==
X-Forwarded-Encrypted: i=1; AJvYcCX2c32XXJerBeOpNNmnywnyEbygiqa7UmnlgUKHRMd6Di9Ulwo32ergx5REj/r4r4CSSxNu/HERfqcZ69Bms1a4+Fs=@vger.kernel.org
X-Gm-Message-State: AOJu0YztSevAKjgrG6Cx/m3rUdrQ6wZrNxLYQDWoAqaz6+KOzZgjPtdG
	KJtGy9ANbeA63IUyAmKRmO2hDvNw/8LH22tNpPmmOt78hahmnPXRqs8H
X-Gm-Gg: ASbGnctkyQq2rhPowT9YXvtYnffmadxis/jitiilF7P/HfP9yX8iWvS1ZzLXGV2akPn
	/u29Qije7lhNCULlgSL/sSMCGuY4CQhGLO7ZJlBcDM0XMgGvRqQwT9Mehx6bUqRfbTjje5waGw/
	U3DK6TeOK5Zn2FOix2PQ+iMRcX9sd7ZUppxIzxPU/ahm8g+nnM9DcrUZ4wdNxgv3FThX7KC00Tj
	VmZqvy/808+q7i/QjQK7TAyLtQiFn2Y8l6e5eCTxmJfYtOzJYQap6kSD4zsrlr6PMHGVG/1KF3h
	1MvtAvHa8waN0ZP7I8HzFPqr/dyPz0Qa94m4XRSZg2VaMs7EYscWZCBVNqRnWXay4RYF5G9XRsX
	kYQiUoYba2APyaqfNJwwKf9oZLsmTr33C70aVYXRloOm7bGWEW/fXs5f1IRy/hfVluu5CVBhVjL
	9NA9rj0EnCsERxqEoMOE4ypzYNxjNmqg3z3qVWXb/ZyeRF9fBkYnA=
X-Google-Smtp-Source: AGHT+IHnEicOTQPX6opDgFi2vp+1s1HztND01uccNXaYM349XugzEkvCl/XXLQPgtSoOfH7kYyl0Dw==
X-Received: by 2002:a05:690e:12c8:b0:643:1ef1:9613 with SMTP id 956f58d0204a3-6431ef199abmr25478296d50.15.1764685204701;
        Tue, 02 Dec 2025 06:20:04 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c497768sm6257715d50.25.2025.12.02.06.19.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 02 Dec 2025 06:20:04 -0800 (PST)
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
Subject: [PATCH bpf v3 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Tue,  2 Dec 2025 22:19:43 +0800
Message-ID: <20251202141944.2209-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251202141944.2209-1-electronlsr@gmail.com>
References: <20251202141944.2209-1-electronlsr@gmail.com>
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

