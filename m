Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE0C316919
	for <linux-trace-kernel@vger.kernel.org>; Wed,  7 Jan 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767788558; cv=none; b=TWrIpRax3f8YeNwUUQSq+KD1BsC+PFkC4uoSjtmX180ghcIGlIO0YbhkyC/0aw2I2N/8Mzsv580II/Sr1uUEzwmX8HtfGmbL11B+Or2gREO4VSx0yrfp4nSaBM+mPzHnkS3lvC4Ycm1iQBm0TQnZykZ/ypRa4SoH/4F7kzFpHQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767788558; c=relaxed/simple;
	bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOp7dRIxumfbLxl7X+lNUr6je9BV+xNvYK7DmrV2LMPYIlUlaSBFb7u5JVF6RMzzQt5u4MVuYjT2wNdiycEZdkQMXhFJxjw4C48H15/exewcf5zG0LdwVCLXyPxgeSu3EOk8ANYvssLjLDh9H8Ld8xGT3NnCLzm0MDWXmcwGkyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IPE49rnj; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPE49rnj"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c05d66dbab2so1396904a12.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 04:22:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767788556; x=1768393356; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=IPE49rnjTjtHNOBtLnU3aEWDBjoZx5aoL7s059ET3UMOTiQ/nA6pVAcCTiwASBZDZz
         dEPHicB+5eMr95lUShJLydiEOVzS/Pq0ts2IIL8m+lUMVjD0mJj1/JksKgGPqUj38+3Q
         tlbPNWe6NBaxjmO7u4RWTO1+5oo4esLYzm8dMi4RrlApnNkpdXQwNt1dLyYvSKCybrTQ
         sOaJTBT9RzwMbK1EuwKvmHMHkZxFF/QnLpIr/oaxJLVtQ6G2Y5fzKOjK4YAckBZyMn2m
         98RJck2QDqsS1P1iaBBZ8j4enbxg0mUqyZDomxUbMb9/7+VQypljfgi4w07DMF3+Rmh4
         E/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767788556; x=1768393356;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=htJmJ2nOl5HS2d4lrmu4G6awIswx3aqJ66sxEqxOU2k=;
        b=XexWlOgw5pFtt9mdbnMc99y1uVDjya2am/rv3fwz2uwrDDP0n/Y1m8q/sZfVRG9/l7
         XBMvQ68e2IWeNHFw1oQ3Vkwt+22jgZkV+bX0BZwlNwF99KaBlZSCBrtsjHKOQcU9oiub
         jDq4ixRq4eCHxISmLyJPaJiFEDaTbbhasqr8E8SvqxSJKsUSrNz0KIekZz9Q6BAUprv2
         GLOo/cf+KfSSgqQY1NSlhpVhsZ2BdKpvLpszteBdqX1ZqNuDqQIi/TjSmSCkXtTW/T1d
         kAXCERppSzoWziis3VnvcBosfc6zz7G7hUW8cp9vh4kqSF6ZmsYpZfsK8/jd0/gewpIf
         +fzg==
X-Forwarded-Encrypted: i=1; AJvYcCXyAjezA9Div7oPc9E3vU0mTN8octTmo+H1AtPfBAmRfyvCwCI3MKUV6nbvEJnwy1k60JBq4+Ltoie2D4FHxxgB4uw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2VuEctL56WcZH6n8gQEV4SamJpF0fpqAyG9v6khunpUkH+iJq
	rZzZbg9yL1gigRv8plWyeFsPWGzL7x/Kxb4uQUdxg1MLMn4Fey9B0xeo
X-Gm-Gg: AY/fxX4gJpKM/PkshRC5yL6ATLSDMrp7tG0BLcPUtZ3pZh5+ZMG7Czmvmhr3fhtnTET
	kQEz8URvSKz77AOmoy3dXve8GjbeQYsf7kNP1ANX2hE5D1ubVl0559Zmin1qOjt3Kg1AvayZSjx
	TmiZQJIBzjA6kDEg2/+58ILSEg/qW61wSdoYb0tCxiLhdP5q6ywfy868+Z8w5VO++H1vmu8l/MY
	WZmkSAHsB4jZi8sMONqV3YfT1Sib0642NdToLUzc0E72fIiDRS5XDBrJodddImh+M8tn64h4rhb
	l07BVO7BRDhQ5AnNCWler+m/YXKgtD4rw21XXj1tiXo5T+wrozVVl/MBsXQw+S4Ufn7uAW9tVe0
	8ecSqDh1oFHvMWyaPHlL5vlUg1idzIpHj2V+jikYtsyCFgYhUu9Yx/Dbz/8vEmt1mAj7tugI5oW
	5zsCrF79AbCZc=
X-Google-Smtp-Source: AGHT+IF4vumQ3UxDP/AczQhAuKSLCFCXdWDt3+3Ac3DseSrY7lK07U9RAIhVR1+386lDOWSI3dLtWg==
X-Received: by 2002:a17:90b:540e:b0:343:5f43:933e with SMTP id 98e67ed59e1d1-34f68cbe0b5mr2124192a91.19.1767788555990;
        Wed, 07 Jan 2026 04:22:35 -0800 (PST)
Received: from [127.0.0.1] ([188.253.121.153])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f5f8b1526sm5025946a91.14.2026.01.07.04.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 04:22:35 -0800 (PST)
From: Zesen Liu <ftyghome@gmail.com>
Date: Wed, 07 Jan 2026 20:21:39 +0800
Subject: [PATCH bpf 2/2] bpf: Require ARG_PTR_TO_MEM with memory flag
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-helper_proto-v1-2-e387e08271cc@gmail.com>
References: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
In-Reply-To: <20260107-helper_proto-v1-0-e387e08271cc@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 Shuran Liu <electronlsr@gmail.com>, Peili Gao <gplhust955@gmail.com>, 
 Haoran Ni <haoran.ni.cs@gmail.com>, Zesen Liu <ftyghome@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1786; i=ftyghome@gmail.com;
 h=from:subject:message-id; bh=unytFKZ8LCGZbWiIqqle1BjuJ9OKga7Krn0YjNtEcU4=;
 b=owGbwMvMwCXWI1/u+8bXqJ3xtFoSQ2ac/xdV2YfeZ4wuCJmHK+jVqLv8r746++XhqI33HeIWb
 12tuTauo5SFQYyLQVZMkaX3h+HdlZnmxttsFhyEmcPKBDKEgYtTACYSPZ3hn9Xf5xONrlr+X8xp
 w3u4MqBS/ZX9+cne2x/Yf3gYWmhZ9YLhf4YZZ/bqW6kPMp8LaE/j6LdmUPfcu6VwpXSdpc3x3sx
 nvAA=
X-Developer-Key: i=ftyghome@gmail.com; a=openpgp;
 fpr=8DF831DDA9693733B63CA0C18C1F774DEC4D3287

Add check to ensure that ARG_PTR_TO_MEM is used with either MEM_WRITE or
MEM_RDONLY.

Using ARG_PTR_TO_MEM alone without tags does not make sense because:

- If the helper does not change the argument, missing MEM_RDONLY causes the
verifier to incorrectly reject a read-only buffer.
- If the helper does change the argument, missing MEM_WRITE causes the
verifier to incorrectly assume the memory is unchanged, leading to errors
in code optimization.

Co-developed-by: Shuran Liu <electronlsr@gmail.com>
Signed-off-by: Shuran Liu <electronlsr@gmail.com>
Co-developed-by: Peili Gao <gplhust955@gmail.com>
Signed-off-by: Peili Gao <gplhust955@gmail.com>
Co-developed-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Haoran Ni <haoran.ni.cs@gmail.com>
Signed-off-by: Zesen Liu <ftyghome@gmail.com>
---
 kernel/bpf/verifier.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index f0ca69f888fa..c7ebddb66385 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10349,10 +10349,27 @@ static bool check_btf_id_ok(const struct bpf_func_proto *fn)
 	return true;
 }
 
+static bool check_mem_arg_rw_flag_ok(const struct bpf_func_proto *fn)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(fn->arg_type); i++) {
+		enum bpf_arg_type arg_type = fn->arg_type[i];
+
+		if (base_type(arg_type) != ARG_PTR_TO_MEM)
+			continue;
+		if (!(arg_type & (MEM_WRITE | MEM_RDONLY)))
+			return false;
+	}
+
+	return true;
+}
+
 static int check_func_proto(const struct bpf_func_proto *fn, int func_id)
 {
 	return check_raw_mode_ok(fn) &&
 	       check_arg_pair_ok(fn) &&
+		   check_mem_arg_rw_flag_ok(fn) &&
 	       check_btf_id_ok(fn) ? 0 : -EINVAL;
 }
 

-- 
2.43.0

