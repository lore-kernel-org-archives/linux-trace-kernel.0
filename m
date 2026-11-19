Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795106524;
	b=efDq0TDfKOAQVYQsRo6deWcJXvq+5S3PlcYj1j8spw4s5oz4oES0aQdrGft4Bs7fwGcq
	 oyR1y3wtO+M2LNY8lO2JPN1etYSHkIYUy8oBixxJKSXk14sHNDllrg4MEvhD5dkYC5T0B
	 xrsJX8UPBJKqKNkZgaw0emnrHSt2BFCDJuNcTPx/+FxpITyIoO09J5QbXvLegZGGebrdU
	 c87xoqx0zdwb6GD1MZHuJo/hd2/NiGDu0qxzca7lrLSZoH9Cg3Iddm7MRqv9kRSnmpsLI
	 ufm2G1uEK1oLBxSLHrNPbFSczkCWURjJ3k0JEp5mtGL+o57kYDVEC/t9dD/kpKa8/YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795106524;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HgDd5L0VIORH2VG2v5Fp/wWX0U3z/GJXEnBUz5v1RkU=;
	b=4l+4idhCXUBS330IWdXXdXbRgNMIH3st3j1QqogZCAO9185hRLDGnooq0wIlREB6j3sH
	 kJw9JWJlETzJQADDqiujxVKToJGXYH932pj8UzQby2FdceV/7o4qoFWuYD9wpZd3wWrYs
	 L3D1H5u/foOI/3SMRdkl5DXBdThkYXoTf4R49NLaWgHUuVpyLiIDf+rAGErtuWqwXPaVW
	 D6vMFJ/fdUiFNsGYsdYJIoD6U6qIqnYsYP0bULT63RoC8LnaAX5zxVx3HRwLNctd3+UxN
	 y5WF7YiQI4/q6KC1kOFcgY39VfX/b37oKN/Xr4nKAtsBL+WdJz5LqicQu7/qCxbtuAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTLbUhHH;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80856606A324
	for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 16:42:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80856606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZTLbUhHH
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1a3c08d6928so3380799c88.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 19 Nov 2026 08:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795106523; x=1795711323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HgDd5L0VIORH2VG2v5Fp/wWX0U3z/GJXEnBUz5v1RkU=;
        b=ZTLbUhHHtbEifkw55T/7SASi3uFaklxp2yFg3vzaGeTR8ge312YjkAunBIvmi4rQSO
         udI3e3qpMJBVO2EYnEHMvJaN+g2HjnJpcL6Lku4FYz3/GLmZx1LFkh8FDvLQrAb6olQ1
         GXbTxh82NeNBoLcMaCKyPHvfHxPC0yaCrtyHxfMWmgM+8CFXqV0CzAEgj0kYjSo5m5/M
         P3gX292QVX+GAP5nmc+W7CZP11Vm4nAelZC49qbxYqk3aT/DUDSVt9z3Bi8kMTxMuKNX
         nEWhaHYNkpvtGsHGYYaXjez5N5sAD8jj/w6877E5BOpcW3GbRm0xwC9eGRMmBdAE7Qw7
         iktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795106523; x=1795711323;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HgDd5L0VIORH2VG2v5Fp/wWX0U3z/GJXEnBUz5v1RkU=;
        b=fnLIkx0Lqlk6pYR3CUpvhT/UbQN8f52jQBZQ5ZGyfEouUugEWrdMu9ksyv8PA9wAHh
         dW28UBNnU+v3UrhimNViavWhJ+ip9wpkJO5I564JAV6JrFikmODdepGDhjvy6Jugo/7P
         0/XKOBa2MVdWMOJtOoI6z1+uH2TsAkml4PRwzDCCeosdetfMr/plyUCtnZmg1H7/NuIe
         60/Jw/Jx/QZxCS3TfISYvEFecAEcDNTn0nW7VtjAGag5EvzC0S7/I6mCXKuWq04KhRys
         Geq50ML/AUBvt1UqRruQ+rtDfzaOhv/ITTHYztbCbo6iDGl45eto4Z5vLDXQIbx2u2ih
         HrFw==
X-Forwarded-Encrypted: i=1; AL+hErHAUK9qk5opsEB2dtLzEd8pxOohvQEvVvlcO7xhKqXTDfZ4Fyjy1TQWK7sR0i0qeaFAshWygkOYbj92INIrThPY/FQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Utatn82ZwWEFaBMhUR3bceKzCmTZf8lNNyeWHkwdI5YDI+IPd
	oMC3BleJJP2vx3RL96N2nYBYnksrsZSB3HSUZcXGS/yiWGiddME7m2tv
X-Gm-Gg: AYBFou1QqbWN6x0tWhfBStN+sbH9MCG98a5qA5/oYaTKH2FxT3g6/slVHgUhwIVmKaf
	o1hLQkvK16Kh5WtjdiN5EwYfXVWgNhvJR+BLfUeaglWiSZkIs9uRGl67g9lYox7JyPGWRQgwQ3T
	Q8Ve2nKA0Yd5FJpQ25G2xoeL9b0tCj3pR+gAN3zyjQ4W7IJdZ7HA/BGOYRns3WvIXHvJsnoUTDw
	1dcANDX2BShjRSczV0sKnkC2yZzG9M6C5tGwi3vriXUDtBv02GpvHu2uUSlVxZwphIqkrN4D2Y9
	b/PIyiElNQSPUXB/9WcZWJ81EV1bAFqfBHfg6Ya2YXjcvJy1f97uAc+uXqK1Il0ZMJWjhC7C3DW
	8hiDo8pCwscBeV4DmucduNBkZt4pla85Q4pjQGuBsHdjar1A5ByBY9Rg0w+imCUtbXgXGKqzZms
	P64kw5TFV820lrgnMaaCuemo4/KcU17EpMF85J+W0jzqjnDvDh0Pl6N10brYcp5QGEUQ9lpC9B8
	IpzBctC2PeRPuF5IHb3W4qJ3+Kybn5kxvm08gu54YppWo2LLFLu+WQv4ErkqE69w5KgxqAkNd84
	ud5H09myyHjiGXf9N1lgLqsZNL9C3sjh6fUbV2BmSI2xMmuAG3byDJJqJnze4RFi5rcNSf3bJVu
	xNVzGdovakA==
X-Received: by 2002:a05:701b:2705:b0:1a0:f970:4f5d with SMTP id a92af1059eb24-1b55688b929mr201816c88.17.1795106522470;
        Thu, 19 Nov 2026 08:42:02 -0800 (PST)
Received: from cps-manycore-1 ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55682d301sm327441c88.10.2026.11.19.08.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 08:42:02 -0800 (PST)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	jolsa@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: reject override_return programs on uprobe_multi links
Date: Thu, 19 Nov 2026 16:41:40 +0000
Message-ID: <20261119164152.3678373-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_override_return() changes pt_regs->ip to the kernel's
just_return_func for kprobe error injection. Perf uprobes reject
programs using this helper, but uprobe_multi links accept them even
though their pt_regs belong to a user task. When the probe runs, the
task returns to user mode with a kernel address as its instruction
pointer, faults, and exposes that address in its signal frame.

Reject programs marked kprobe_override when creating an uprobe_multi
link. This covers both entry and return probes and matches the perf
uprobe restriction.

Fixes: 89ae89f53d20 ("bpf: Add multi uprobe link")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
 kernel/trace/bpf_trace.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index d22e78e7f28d..45ff81dbca96 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -3297,6 +3297,9 @@ int bpf_uprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_uprobe_multi(prog))
 		return -EINVAL;
 
+	if (prog->kprobe_override)
+		return -EINVAL;
+
 	flags = attr->link_create.uprobe_multi.flags;
 	if (flags & ~(BPF_F_UPROBE_MULTI_RETURN | BPF_F_UPROBE_MULTI_PATH_FD))
 		return -EINVAL;
-- 
2.56.1

