Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6490B3074A4
	for <linux-trace-kernel@vger.kernel.org>; Thu,  4 Dec 2025 07:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834428; cv=none; b=qbBlddZTNhn1eI1rb35ce88+ktXPRgZeFehto97+/RFKyuBdHa81mWYAVoQeVZ65i9pqKyztJpDEdz86miBtcDrv+fH3kgQytRBHU4/qA28IKU2l4mfKCjvLUqkwpBw8bmcTvr8ca8rhRr0PzP3bNhfuYi+1NoNtORzNsNI/HJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834428; c=relaxed/simple;
	bh=S+igu4aju7EwXWFRbjCCQgO7Bx4KXZSG7GeZGRqJ1fM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9hCxlVUG1pG3v0O65eMIDmYcgygu2pZM0QR5gMe+EVDLimRiWpFQyY2yG3ScnLY7EoFT+Z4/VaBMr8QqcNgFsF3QJLgC2a9Sd2/zSHDOLS9OulSfhocBj4dg1q1nCooqTAbmEqATpYIgBqOdEt4jwWl2JnO4esviafFoDmGvc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T709czta; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T709czta"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-640d0895d7cso1013973d50.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 23:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764834425; x=1765439225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=T709cztaehuPRi/41Hlij4yPBK6fd5hun8C2R3vIhqNee3CfJYkSQDqJ/myUIKs9lM
         7X1GtK2Mwy/neATrH8vIWAp+dvBQpRU14Et0JUWEOY4n9F0XYBdj8l0bWxGMeDeIqVef
         GV5NTOn1QEUKv3T/Lpmk0jDKTHUoY7hU0AwAEi0forF+GgN4yetgMqRLsrYfI6zGmRKL
         NEYkSxyE86M3POKl9NlZHXb+PGZ9TTqjmmyeoXaqQgbvR1zYnRh0rx89rGzFFnNyruDt
         PL50tCxLx2g93qmi1bPKeKfLMEgTTqQYGpvp6fDs1XJUnRCt2H2ynVEOweidZB1O2C5r
         dh5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764834425; x=1765439225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fX6x8dKVuvuScvQG43b+CJnQqhUVfctvBR8HYubZTkk=;
        b=h35/BhC9KPjYjKOetrGXU8+ZnzDgXgzlkFRYz3JziMAPZKKS1iLghVSdax3zxrPAsL
         eoTgxILJplGxY77NyMsUpQAVQXRxRwBfmxx5uujHlAlxmbVbknT1aT8jCkzAYdsJg/Sg
         NWwWEevFoHo9AU82F9JDsI6k1qgMPhkTVwggpEApMsFsh0l56sRjk+Kq6D+nJZ4zwoBq
         c8WDlZpoKBXiIyQ1Ydb0n+xa4+ON9YRCXISalG2khYKbAJ/OCTjLqwFdqGG6pOPZHuda
         hZ4u01KmlatjFQPsI3BXGdqbtGjhkbMW0BoQGvaIrvZ4JLSBT+Y+YAyrcerP8yJw/h76
         TM0g==
X-Forwarded-Encrypted: i=1; AJvYcCXoLK+BZXeU1ozdrAaZyIHS65D7hILGII9s2tB4h95nkxdlyPkDZ+pdUenJg5SOte/cPGsRw3AIwrzB0L/PxBIb4Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCMbFpmfdTWBbJj5FtBCzmNpBmRfjumMSSGBEeh8bdT9UbK9De
	cQMIsetVjsgNP20vd75VT4BLcM/3dRb8PeisZz65mnNCGgYb5SvKbbwN
X-Gm-Gg: ASbGncuTi62LTPFQbYopygPI32WpH57nYhxfh5kpEG/Jgj9J7Gk5Z68ns3dbhjTq234
	avhusyx9juHj4nm0lX3jqEyU7Z8ZhUt2BqBRjtiTViGq5ZlyOeUvtPvpUKasZqgcW+ZhIyNKWAN
	uT/2IG3C+IggDYfUE7f6BEoJAIdrMR12jrbpU7tl34/SjhLFAtgXD7c4JW7j0WG9JDd4eM1f+aF
	21nwLCX8m/pCUO1vuWEx6KvC69ynopZ2huMR1GXzqa/ONwaVOVjlVgms/ecNOxQ67OuTbzPMlsE
	+EAPqhlEw1KFUWEZYar0R/cUVsATfm1lf3ejl6RoQjD2QAvVGpQzPHDr+WngTIFSszbBRn8YqzU
	anM+1swwMc1K0Y+79PvXD3GPafeqn+8QIl9P2s472kZpx2lz4fGTDOANsgUFgIaY+1zRGS1Y2tF
	ps952zpZ80P548Jm0GGfCpVZ+y3Kf2Z/31/1OGMxAuFtnWl2eLWhGzsKshIis1PA==
X-Google-Smtp-Source: AGHT+IHAWdGveni9JgLF4NjXVCpK9JAnHMY2t30oQX6L7RsPJUxpwwCxNvBkYXUImMErt52ZB44Cuw==
X-Received: by 2002:a05:690e:1301:b0:63f:af0f:aaf with SMTP id 956f58d0204a3-6443d6e9d62mr1667544d50.1.1764834425343;
        Wed, 03 Dec 2025 23:47:05 -0800 (PST)
Received: from localhost.localdomain (45.62.117.175.16clouds.com. [45.62.117.175])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6443f5bcbbesm364495d50.23.2025.12.03.23.46.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 03 Dec 2025 23:47:05 -0800 (PST)
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
Subject: [PATCH bpf v4 1/2] bpf: mark bpf_d_path() buffer as writeable
Date: Thu,  4 Dec 2025 15:46:31 +0800
Message-ID: <20251204074632.8562-2-electronlsr@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251204074632.8562-1-electronlsr@gmail.com>
References: <20251204074632.8562-1-electronlsr@gmail.com>
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

