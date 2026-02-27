Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEB33A9E7
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Feb 2026 03:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772164434; cv=none; b=jx5t2sKuLzO+ggKyZIqVfwP7AisKXFJ5GqhzcJ8IMICyuIKU0OkY8roSTOf+Iz5YhWxE21wAbiOLLg+c4aPq6/0GTN5xSOVhR1ycZ7Jl5L85fAbeD3U9Gecc83phOqO3oDj2Nzvsd9drZBt32N0o7xScBzOnUS86l3VGuqQ8hXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772164434; c=relaxed/simple;
	bh=zTuuLUaWX2nnbSpNamvQH8sri2HhCf5G7tUFH903TXA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5Q1EjGGa8BvBHXwwtxuLvbgwZSG8nrNwF0au2Vw9a8/FRD8G8maPuDrLPHY+clBC+eS6DF6fiKwTWbqEExTrqltCcyaPtqA/7e/H9o97MFOH6MJgwaSym+WATkkWDz39E7pzttjvUYhTp2U2ZC7DwjUJ8FHBKB+MmJGYZPvQPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b79cBtnh; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b79cBtnh"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ab46931cf1so19450725ad.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Feb 2026 19:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772164433; x=1772769233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwdSgM1NQbWP7Rhe378wlcNmZqA7RqveMVNj2ZfOXJQ=;
        b=b79cBtnhX5DYVf7TRGR0jTubka9G1aJBvGFK86o0gRpavdkPf5JrbuQGcogKxjU3Wg
         SwePW7ajFrxDrHH05sEsgAICPtydywgxz3ZUJIUAQo78nJhh32C+6CVrPQxxDRa+TKwd
         so52/1n3KqT6eg7X0roR+mAO0qAOors3jN4nvnpoEcfiHQe7PjyTANqlkgzMey4g21Qa
         hK3RSkGtExzUA9TdLCKrwpvKQLnhP0to/BU2ELQfE3RocbqkzG19qJOh7+BWao8Gj1Yr
         3W1BUJXgviT21caFHpehh17NraI+7WgJqnDJ0ew3AohTGRjbHCgEaQ8cZpoubcIa9ZLy
         zvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772164433; x=1772769233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pwdSgM1NQbWP7Rhe378wlcNmZqA7RqveMVNj2ZfOXJQ=;
        b=pIstXdRKj3vFJLFEEvM/iBGv6VI/AKgSwE/tE1rF8M+IhoRn7qtRuAXedRiPGQQp8A
         YV1YbbOd/6FH9KY2IEjUlInfnqVkPa8L+ItTwezwdRO2+LU3wSw/pWAmulTws9cIWjCR
         eMvIlvfY1hM3zJkBbuqVliR10+ypkFhK2/J1URbkbYkZyZHNe0X/cOYoPM8p7QteD56M
         9Nv3UZNSBj2UgJHGYc6DfhP8nM3AKhJ4AImMKAx2BnFYN19D6isp9esomEHTp67556Y0
         ShDQJpYlSW6DMY5836E0XsIFTo0hgWB7C9vTAhjaJN3GMkpCL99gyfAwBpuPF8tg+W3V
         7bEw==
X-Forwarded-Encrypted: i=1; AJvYcCU7TGGnJjFQy1N/pgvBAlFkLd61fL3yOjh4eYpnjsUYo+E+kL5XC5bd4FqiYSQqAZ09xF6ny4fxg/CSNWjNIKa3Id0=@vger.kernel.org
X-Gm-Message-State: AOJu0YygH9WLV17eREOIHMk8bUwjCL3ANxXAKEtBiJJ8QioAFE9599s6
	R+PiJdVwvYX8x5ruY4eXrnV+wCLKPoNB49iF2cQEJPoRtJCNHPO7nY3c
X-Gm-Gg: ATEYQzzRDUc7vkKKqkTpZky5Uw3GIMRkvSCG6BsLRccsy+XIOc9n0rMdf/4Lqs9UNND
	lhWcJ9ZviyW7NxW3TpFkWvgNrybLnwP3RmB0K0r1rbtEL8yNP+oSQjY9MNupv12GxOrWuBJfJFr
	ckRcHTl9bU4Jmo53ApMJdaOINpXaxXKlzB8YfSmL8VaYdflUuZKNjfgjufrsNvtVufuPDgfvfLn
	JrYUp63oSq1hAVBAVi2tcTHs6tfRfgoZ5NoD5bzRxQ1wpFljKGLHYmbfKOT5urxl0AeDdgxLJce
	qbJ/UqFZKDmpIjwsSIDIrED+d54+4y82q2ndNPZuxFcoLZvDTpDNNxAzGuIhrXAp5hrA9Pc09pP
	uVYbG9G3GOOC4JlrLPlDydwFdSoJHZDMcMcz9g6PP4pIi77TFs6Fu4g0Ch8c3hDJMbVTz+NA7Ms
	eG9bdWahCcRyhByeOBbo5iT6g7l52R8agttHTfYcngbIUmx/dP/w==
X-Received: by 2002:a17:902:ea08:b0:2aa:e9f0:146c with SMTP id d9443c01a7336-2adf79cd7d5mr56815645ad.29.1772164432629;
        Thu, 26 Feb 2026 19:53:52 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.215])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5c3b01sm41487125ad.31.2026.02.26.19.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 19:53:52 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+9ea7c90be2b24e189592@syzkaller.appspotmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	mathieu.desnoyers@efficios.com,
	mattbobrowski@google.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org,
	sdf@fomichev.me,
	song@kernel.org,
	syzkaller-bugs@googlegroups.com,
	yonghong.song@linux.dev
Subject: Re: [syzbot] [bpf?] [trace?] KASAN: slab-use-after-free Read in bpf_trace_run3 (2)
Date: Fri, 27 Feb 2026 11:53:41 +0800
Message-Id: <20260227035341.1108372-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <69a0544c.050a0220.3a55be.0004.GAE@google.com>
References: <69a0544c.050a0220.3a55be.0004.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 2d14fb6d0ed0..038bf4436959 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3783,6 +3783,8 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
 
 	bpf_probe_unregister(raw_tp->btp, raw_tp);
 	bpf_put_raw_tracepoint(raw_tp->btp);
+
+	synchronize_rcu();
 }
 
 static void bpf_raw_tp_link_dealloc(struct bpf_link *link)
